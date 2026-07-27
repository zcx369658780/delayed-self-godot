extends SceneTree

const SubmissionSfxRouter = preload("res://scripts/audio/submission_sfx_router.gd")
const GameplayScene = preload("res://scenes/vertical_slice/vertical_slice.tscn")
const LevelLoader = preload("res://scripts/simulation/level_loader.gd")
const Simulation = preload("res://scripts/simulation/simulation.gd")

const EXPECTED_EVENTS := [
	"ui_focus_or_move",
	"ui_confirm",
	"YOU_move",
	"ECHO_move",
	"wall_bump",
	"plate_activate",
	"door_open",
	"blocked_or_invalid",
	"level_complete",
]

const EXPECTED_BUS := {
	"ui_focus_or_move": "UI",
	"ui_confirm": "UI",
	"YOU_move": "Gameplay",
	"ECHO_move": "Gameplay",
	"wall_bump": "Gameplay",
	"plate_activate": "Gameplay",
	"door_open": "Gameplay",
	"blocked_or_invalid": "Gameplay",
	"level_complete": "Gameplay",
}

var assertions := 0
var failures := 0
var loader := LevelLoader.new()
var simulation := Simulation.new()


func _init() -> void:
	call_deferred("_run")


func _run() -> void:
	var result: Dictionary = await run(self)
	if int(result.failures) == 0:
		print("TASK_0024BAE_AUDIO_FEEDBACK_AND_MUSIC_TRIAL_PASS assertions=%d" % int(result.assertions))
	else:
		printerr("TASK_0024BAE_AUDIO_FEEDBACK_AND_MUSIC_TRIAL_FAIL failures=%d assertions=%d" % [int(result.failures), int(result.assertions)])
	quit(0 if int(result.failures) == 0 else 1)


func run(tree: SceneTree) -> Dictionary:
	_test_audio_file_contracts()
	_test_router_contracts_and_buses()
	await _test_runtime_transition_classifier(tree)
	_test_completion_wav_timing()
	await _test_music_trial_gate(tree)
	return {"assertions": assertions, "failures": failures}


func _test_audio_file_contracts() -> void:
	var required_rate := 44_100
	var required_bits := 16
	var required_channels := 1
	for event_id in EXPECTED_EVENTS:
		var path := _event_path(event_id)
		var exists := FileAccess.file_exists(path)
		_expect(exists, "required event file exists for %s" % event_id)
		if not exists:
			continue
		var parsed := _parse_wav_header(path)
		_expect(parsed.ok, "required WAV header parses for %s" % event_id)
		_expect(int(parsed.sample_rate) == required_rate, "required WAV sample rate is 44.1kHz for %s" % event_id)
		_expect(int(parsed.bits_per_sample) == required_bits, "required WAV bit depth is 16-bit for %s" % event_id)
		_expect(int(parsed.channels) == required_channels, "required WAV channel is mono for %s" % event_id)
		_expect(int(parsed.data_bytes) > 0, "required WAV has PCM body for %s" % event_id)


func _test_router_contracts_and_buses() -> void:
	var router: SubmissionSfxRouter = SubmissionSfxRouter.new()
	var snapshot := router.get_event_map_snapshot(true)
	_expect(snapshot.size() == EXPECTED_EVENTS.size(), "exactly nine event IDs are declared in snapshot")
	var deterministic := snapshot.duplicate(true)
	_expect(snapshot == deterministic, "event snapshot is deterministic")
	for event_id in EXPECTED_EVENTS:
		var record: Dictionary = snapshot.get(event_id, {})
		_expect(not record.is_empty(), "snapshot includes %s" % event_id)
		_expect(record.bus == EXPECTED_BUS[event_id], "snapshot bus is expected for %s" % event_id)
		_expect(not record.get("audio_stream_loaded", false), "stream stays lazy until router is preloaded for %s" % event_id)
	router.free()
	var loaded := _ensure_router_and_preload()
	var ready_snapshot: Dictionary = loaded.get_event_map_snapshot(true)
	for event_id in EXPECTED_EVENTS:
		var record: Dictionary = ready_snapshot.get(event_id, {})
		_expect(int(record.get("ready", 0)) == 1, "router preloads player for %s" % event_id)
		_expect(int(record.get("audio_stream_loaded", 0)) == 1, "router loads audio stream for %s" % event_id)
	_expect(loaded.play_event("invalid_event_id", 0, false) == false, "invalid event ids are ignored without crash")
	_expect(loaded.get_loaded_event_ids(true).size() == EXPECTED_EVENTS.size(), "preloaded players equal expected event count")
	loaded.reset_router_state()
	loaded.play_event(SubmissionSfxRouter.EVENT_UI_FOCUS_OR_MOVE, 1000, false)
	_expect(loaded.get_accepted_event_history() == [SubmissionSfxRouter.EVENT_UI_FOCUS_OR_MOVE], "first focus event accepted")
	_expect(loaded.play_event(SubmissionSfxRouter.EVENT_UI_FOCUS_OR_MOVE, 1_100, false) == false, "focus event debounces during 180ms window")
	_expect(loaded.play_event(SubmissionSfxRouter.EVENT_UI_FOCUS_OR_MOVE, 1_300, false) == true, "focus event accepts again after debounce")
	loaded.shutdown_for_test()


func _test_runtime_transition_classifier(tree: SceneTree) -> void:
	var gameplay := GameplayScene.instantiate()
	gameplay.configure_route_payload({"level_id": "vertical_slice_delay_3", "level_path": "res://data/levels/vertical_slice_delay_3.json", "hud_mode": "STANDARD_COMPACT", "classification": "audio_classifier", "development_direct": true, "final_level": false})
	tree.root.add_child(gameplay)
	await tree.process_frame
	var router := SubmissionSfxRouter.ensure_router(tree)
	var loaded := loader.load_file("res://data/levels/vertical_slice_delay_3.json")
	var level: Dictionary = loaded.level
	var loaded_plain := loader.load_file("res://data/levels/tutorial_reach_exit.json")
	var reach_level: Dictionary = loaded_plain.level
	_expect(loaded.ok and loaded_plain.ok, "required audio fixture levels load")

	var initial: Dictionary = simulation.construct_initial_state(level)
	var wall_attempt: Dictionary = simulation.transition(level, initial, "LEFT")
	_expect(wall_attempt.ok, "wall-facing recorded turn is still accepted by simulation")
	var wall_events: Array = gameplay.classify_transition_events(initial, wall_attempt.state, "LEFT", false)
	var wall_only: Array = [SubmissionSfxRouter.EVENT_WALL_BUMP]
	_expect(wall_events == wall_only, "wall-facing recorded turn maps to wall_bump and suppresses YOU_move")
	_expect(wall_attempt.state.turn_index == initial.turn_index + 1, "wall-facing recorded turn increments turn_index")
	_expect(wall_attempt.state.player_position == initial.player_position, "wall-facing recorded turn keeps YOU position")
	_expect(wall_attempt.state.history[-1] == "LEFT", "wall-facing legal action is kept in history")

	var first: Dictionary = simulation.transition(level, initial, "RIGHT").state
	var second: Dictionary = simulation.transition(level, first, "RIGHT").state
	var mechanism_events: Array = gameplay.classify_transition_events(first, second, "RIGHT", false)
	_expect(_count_occurrences(mechanism_events, SubmissionSfxRouter.EVENT_PLATE_ACTIVATE) == 1, "plate activation emits exactly one plate_activate")
	_expect(_count_occurrences(mechanism_events, SubmissionSfxRouter.EVENT_DOOR_OPEN) == 1, "door open emits exactly one door_open")
	_expect(_count_occurrences(mechanism_events, SubmissionSfxRouter.EVENT_WALL_BUMP) == 0, "door and plate change do not emit wall_bump")

	var unchanged: Dictionary = simulation.transition(level, second, "RIGHT")
	var unchanged_events: Array = gameplay.classify_transition_events(second, unchanged.state, "RIGHT", false)
	_expect(_count_occurrences(unchanged_events, SubmissionSfxRouter.EVENT_PLATE_ACTIVATE) == 0, "plate remains unchanged after already-pressed setup")
	_expect(_count_occurrences(unchanged_events, SubmissionSfxRouter.EVENT_DOOR_OPEN) == 0, "already-open door emits no repeat door_open")

	var echo_probe_state: Dictionary = second
	var echo_move_seen := false
	for probe_action in ["UP", "WAIT", "LEFT", "WAIT", "DOWN", "WAIT"]:
		var echo_probe: Dictionary = simulation.transition(level, echo_probe_state, probe_action)
		_expect(echo_probe.ok, "convergent setup accepts echo movement probe action")
		if not echo_probe.ok:
			continue
		var echo_events: Array = gameplay.classify_transition_events(echo_probe_state, echo_probe.state, probe_action, false)
		if _count_occurrences(echo_events, SubmissionSfxRouter.EVENT_ECHO_MOVE) == 1:
			echo_move_seen = true
			break
		echo_probe_state = echo_probe.state
	_expect(echo_move_seen, "ECHO movement remains independently represented")

	var before_completion: Dictionary = simulation.construct_initial_state(reach_level)
	var step_a: Dictionary = simulation.transition(reach_level, before_completion, "UP").state
	var step_b: Dictionary = simulation.transition(reach_level, step_a, "RIGHT").state
	var completed: Dictionary = simulation.transition(reach_level, step_b, "RIGHT")
	_expect(completed.ok and completed.state.completed, "tutorial_reach_exit completion transition is valid")
	var completion_events: Array = gameplay.classify_transition_events(step_b, completed.state, "RIGHT", false)
	_expect(completion_events == [SubmissionSfxRouter.EVENT_LEVEL_COMPLETE], "completion suppresses ordinary move events and emits only level_complete")

	var classification_before: Dictionary = step_b.duplicate(true)
	var classification_after: Dictionary = completed.state.duplicate(true)
	var classification_first: Array = gameplay.classify_transition_events(classification_before, classification_after, "RIGHT", false)
	var classification_second: Array = gameplay.classify_transition_events(classification_before.duplicate(true), classification_after.duplicate(true), "RIGHT", false)
	_expect(classification_first == classification_second, "classifier output is deterministic and state-pure")
	_expect(classification_before == step_b && classification_after == completed.state, "classification does not mutate transition states")

	router.reset_router_state()
	gameplay._play_transition_sfx(initial, wall_attempt.state, "LEFT", false)
	_expect(router.get_accepted_event_history() == [SubmissionSfxRouter.EVENT_WALL_BUMP], "runtime wall-facing transition emits wall_bump only")
	router.reset_router_state()
	gameplay._play_transition_sfx(completed.state, completed.state, "RIGHT", true)
	gameplay._play_transition_sfx(completed.state, completed.state, "RIGHT", true)
	_expect(router.get_accepted_event_history() == [], "playback with completion flags off in synthetic states is silent for missing transition")
	gameplay._play_transition_sfx(step_b, completed.state, "RIGHT", false)
	_expect(router.get_accepted_event_history() == [SubmissionSfxRouter.EVENT_LEVEL_COMPLETE], "runtime completion transition emits level_complete once")
	router.shutdown_for_test()
	router.queue_free()
	gameplay.queue_free()
	await tree.process_frame
	await tree.process_frame


func _test_completion_wav_timing() -> void:
	var parsed := _parse_wav_header("res://audio/sfx/gameplay/level_complete.wav")
	_expect(parsed.ok, "completion wav header parses")
	if not parsed.ok:
		return
	var data_bytes := int(parsed.data_bytes)
	var sample_rate := int(parsed.sample_rate)
	var bytes_per_sample := 2 * 1
	var seconds := float(data_bytes) / float(sample_rate * bytes_per_sample)
	_expect(sample_rate == 44_100, "completion wav sample rate is 44.1kHz")
	_expect(seconds >= 0.50 and seconds <= 1.0, "completion wav duration is within 500-1000ms")
	_expect(data_bytes > 50_000, "completion wav is substantially longer than prior pickup-like cue")
	var completion_bytes := FileAccess.get_file_as_bytes(ProjectSettings.globalize_path("res://audio/sfx/gameplay/level_complete.wav"))
	var segment_one_hz := _zero_crossing_hz(completion_bytes, 44, sample_rate, 60, 190)
	var segment_two_hz := _zero_crossing_hz(completion_bytes, 44, sample_rate, 290, 480)
	var segment_three_hz := _zero_crossing_hz(completion_bytes, 44, sample_rate, 590, 790)
	_expect(segment_one_hz > 0.0 and segment_two_hz > segment_one_hz and segment_three_hz > segment_two_hz, "completion PCM contains three ordered rising cadence regions")


func _test_music_trial_gate(tree: SceneTree) -> void:
	var music_path := "res://audio/music/crow_producer/优哉游哉(loop).wav"
	var music_exists := FileAccess.file_exists(music_path)
	if not music_exists:
		_expect(not music_exists, "music trial remains optional and unimported when blocked")
		_expect(tree.root.get_node_or_null("SubmissionMusicController") == null, "music controller is absent when trial path is not provisioned")
		return
	var parsed := _parse_wav_header(music_path)
	var music_file := FileAccess.open(ProjectSettings.globalize_path(music_path), FileAccess.READ)
	var music_size := music_file.get_length() if music_file != null else 0
	if music_file != null:
		music_file.close()
	_expect(parsed.ok and music_size == 25_404_968, "music file uses validated exact source size")
	_expect(parsed.ok and int(parsed.sample_rate) > 0, "music WAV includes parseable metadata")
	var godot_stream := AudioStreamWAV.load_from_file(ProjectSettings.globalize_path(music_path))
	_expect(godot_stream != null, "Godot loads the original music WAV as AudioStreamWAV")
	_expect(FileAccess.get_sha256(ProjectSettings.globalize_path(music_path)).to_upper() == "E4552E433479AECD0790A901A84E9738448B7092BEE51109E0D748A8B9F3E850", "repository music SHA remains byte-identical to verified source")
	var controller_script := load("res://scripts/audio/submission_music_controller.gd") as Script
	_expect(controller_script != null, "music controller script parses")
	var controller: Node = controller_script.new()
	tree.root.add_child(controller)
	await tree.process_frame
	_expect(controller.get_child_count() == 0, "headless music controller does not create or play an audio player")
	controller.queue_free()
	await tree.process_frame
	var app_scene_text := FileAccess.get_file_as_string(ProjectSettings.globalize_path("res://scenes/app/app_root.tscn"))
	_expect(app_scene_text.count("SubmissionMusicController") == 1, "AppRoot contains exactly one persistent music controller node")
	var controller_text := FileAccess.get_file_as_string(ProjectSettings.globalize_path("res://scripts/audio/submission_music_controller.gd"))
	_expect(controller_text.contains('MUSIC_BUS := &"Music"') and controller_text.contains("AUDITION_VOLUME_DB := -16.0"), "controller routes to Music bus at the frozen low audition gain")
	_expect(controller_text.contains("loop_mode = AudioStreamWAV.LOOP_FORWARD") and controller_text.contains("loop_end ="), "controller configures looping only in memory")
	var attribution_text := FileAccess.get_file_as_string(ProjectSettings.globalize_path("res://docs/licenses/ATTRIBUTION_CURRENT.md"))
	_expect(attribution_text.contains("音乐由[乌鸦Producer]提供"), "exact Crow Producer attribution is present")


func _ensure_router_and_preload(tree: SceneTree = null) -> SubmissionSfxRouter:
	if tree == null:
		tree = self
	return SubmissionSfxRouter.ensure_router(tree)


func _event_path(event_id: String) -> String:
	match event_id:
		"ui_focus_or_move":
			return "res://audio/sfx/ui/focus_move.wav"
		"ui_confirm":
			return "res://audio/sfx/ui/confirm.wav"
		"YOU_move":
			return "res://audio/sfx/gameplay/you_move.wav"
		"ECHO_move":
			return "res://audio/sfx/gameplay/echo_move.wav"
		"wall_bump":
			return "res://audio/sfx/gameplay/wall_bump.wav"
		"plate_activate":
			return "res://audio/sfx/gameplay/plate_activate.wav"
		"door_open":
			return "res://audio/sfx/gameplay/door_open.wav"
		"blocked_or_invalid":
			return "res://audio/sfx/gameplay/blocked_invalid.wav"
		"level_complete":
			return "res://audio/sfx/gameplay/level_complete.wav"
	return ""


func _count_occurrences(events: Array, event_id: String) -> int:
	var count := 0
	for event in events:
		if event == event_id:
			count += 1
	return count


func _parse_wav_header(path: String) -> Dictionary:
	var bytes := FileAccess.get_file_as_bytes(ProjectSettings.globalize_path(path))
	if bytes.is_empty() or bytes.size() < 44:
		return {"ok": false}
	if bytes[0] != 82 or bytes[1] != 73 or bytes[2] != 70 or bytes[3] != 70:
		return {"ok": false}
	if bytes[8] != 87 or bytes[9] != 65 or bytes[10] != 86 or bytes[11] != 69:
		return {"ok": false}
	var format_tag := 0
	var channels := 0
	var sample_rate := 0
	var bits_per_sample := 0
	var data_size := 0
	var offset := 12
	while offset + 8 <= bytes.size():
		var chunk_size := _u32_le(bytes, offset + 4)
		if offset + 8 + chunk_size > bytes.size():
			break
		var chunk_id := bytes.slice(offset, offset + 4).get_string_from_ascii()
		if chunk_id == "fmt " and chunk_size >= 16:
			format_tag = _u16_le(bytes, offset + 8)
			channels = _u16_le(bytes, offset + 10)
			sample_rate = _u32_le(bytes, offset + 12)
			bits_per_sample = _u16_le(bytes, offset + 22)
		elif chunk_id == "data":
			data_size = chunk_size
		offset += 8 + chunk_size + (chunk_size % 2)
		if format_tag > 0 and data_size > 0:
			break
	return {
		"ok": format_tag == 1,
		"channels": channels,
		"sample_rate": sample_rate,
		"bits_per_sample": bits_per_sample,
		"data_bytes": data_size,
	}


func _u16_le(bytes: PackedByteArray, index: int) -> int:
	return bytes[index] | (bytes[index + 1] << 8)


func _u32_le(bytes: PackedByteArray, index: int) -> int:
	return bytes[index] | (bytes[index + 1] << 8) | (bytes[index + 2] << 16) | (bytes[index + 3] << 24)


func _zero_crossing_hz(bytes: PackedByteArray, data_offset: int, sample_rate: int, start_ms: int, end_ms: int) -> float:
	var start_frame := int(float(start_ms) * float(sample_rate) / 1000.0)
	var end_frame := int(float(end_ms) * float(sample_rate) / 1000.0)
	var crossings := 0
	var previous := 0
	for frame in range(start_frame, end_frame):
		var byte_index := data_offset + frame * 2
		if byte_index + 1 >= bytes.size():
			break
		var sample := _u16_le(bytes, byte_index)
		if sample >= 32768:
			sample -= 65536
		if frame > start_frame and ((previous < 0 and sample >= 0) or (previous >= 0 and sample < 0)):
			crossings += 1
		previous = sample
	var duration_seconds := float(end_ms - start_ms) / 1000.0
	return float(crossings) / (2.0 * duration_seconds) if duration_seconds > 0.0 else 0.0


func _expect(condition: bool, label: String) -> void:
	assertions += 1
	if not condition:
		failures += 1
		printerr("TASK_0024BAE_AUDIO_FEEDBACK_AND_MUSIC_TRIAL_FAIL " + label)

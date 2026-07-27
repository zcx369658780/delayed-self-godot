extends SceneTree

const SubmissionSfxRouter = preload("res://scripts/audio/submission_sfx_router.gd")
const GameplayScene = preload("res://scenes/vertical_slice/vertical_slice.tscn")
const MainMenuScene = preload("res://scenes/ui/main_menu.tscn")
const LevelSelectScene = preload("res://scenes/ui/level_select.tscn")

const EXPECTED_EVENTS := [
	"ui_focus_or_move",
	"ui_confirm",
	"YOU_move",
	"ECHO_move",
	"blocked_or_invalid",
	"level_complete",
]

const EXPECTED_BUS := {
	"ui_focus_or_move": "UI",
	"ui_confirm": "UI",
	"YOU_move": "Gameplay",
	"ECHO_move": "Gameplay",
	"blocked_or_invalid": "Gameplay",
	"level_complete": "Gameplay",
}

var assertions := 0
var failures := 0


func _init() -> void:
	call_deferred("_run")


func _run() -> void:
	var result: Dictionary = await run(self)
	if int(result.failures) == 0:
		print("TASK_0024BAD_SFX_CONTRACT_PASS assertions=%d" % int(result.assertions))
	else:
		printerr("TASK_0024BAD_SFX_CONTRACT_FAIL failures=%d assertions=%d" % [int(result.failures), int(result.assertions)])
	quit(0 if int(result.failures) == 0 else 1)


func run(tree: SceneTree) -> Dictionary:
	_test_file_contracts()
	_test_runtime_buses()
	_test_router_snapshot_and_loading()
	await _test_router_runtime_semantics(tree)
	await _test_integrated_event_seams(tree)
	var persistent_router := tree.root.get_node_or_null("SubmissionSfxRouter")
	if persistent_router != null:
		persistent_router.shutdown_for_test()
		persistent_router.free()
	await tree.process_frame
	return {"assertions": assertions, "failures": failures}


func _test_runtime_buses() -> void:
	for bus_name in ["Master", "UI", "Gameplay", "Music"]:
		_expect(AudioServer.get_bus_index(bus_name) >= 0, "runtime AudioServer contains %s bus" % bus_name)


func _test_file_contracts() -> void:
	var required_rate := 44_100
	var required_bits := 16
	var required_channels := 1
	for event_id in EXPECTED_EVENTS:
		var path := _event_path(event_id)
		var exists: bool = FileAccess.file_exists(path)
		_expect(exists, "sfx file exists for %s" % event_id)
		if not exists:
			continue
		var parsed := _parse_wav_header(path)
		_expect(parsed.ok, "sfx header parses for %s" % event_id)
		_expect(int(parsed.sample_rate) == required_rate, "sfx sample rate is 44.1kHz for %s" % event_id)
		_expect(int(parsed.bits_per_sample) == required_bits, "sfx bit depth is 16-bit for %s" % event_id)
		_expect(int(parsed.channels) == required_channels, "sfx is mono for %s" % event_id)
		_expect(int(parsed.data_bytes) > 0, "sfx has non-empty body for %s" % event_id)


func _test_router_snapshot_and_loading() -> void:
	var router: SubmissionSfxRouter = SubmissionSfxRouter.new()
	var snapshot := router.get_event_map_snapshot()
	_expect(snapshot.size() == EXPECTED_EVENTS.size(), "exactly six event IDs declared in snapshot")
	var deterministic := snapshot.duplicate(true)
	snapshot = router.get_event_map_snapshot()
	_expect(snapshot == deterministic, "event map snapshot is deterministic")
	for event_id in EXPECTED_EVENTS:
		var record: Dictionary = snapshot.get(event_id, {})
		_expect(not record.is_empty(), "snapshot includes %s" % event_id)
		_expect(String(record.get("label", "")) != "", "snapshot records label for %s" % event_id)
		_expect(String(record.get("path", "")).ends_with(".wav"), "snapshot path is wav for %s" % event_id)
		_expect(int(record.get("audio_stream_loaded", 0)) == 0, "stream intentionally lazy when router is not in tree for %s" % event_id)
		_expect(String(record.get("bus", "")) == EXPECTED_BUS[event_id], "snapshot bus is expected for %s" % event_id)
		_expect(not _expected_musics(router, event_id), "no event maps to Music bus")
	var loaded := _ensure_router_and_preload()
	var ready_snapshot: Dictionary = loaded.get_event_map_snapshot()
	for event_id in EXPECTED_EVENTS:
		var record: Dictionary = ready_snapshot.get(event_id, {})
		_expect(int(record.get("ready", 0)) == 1, "router has player node for %s" % event_id)
		_expect(int(record.get("audio_stream_loaded", 0)) == 1, "router preloads %s stream" % event_id)
	router.shutdown_for_test()
	router.free()


func _test_router_runtime_semantics(tree: SceneTree) -> void:
	var router := _ensure_router_and_preload(tree)
	router.reset_router_state()
	_expect(router.play_event("invalid_event_id", 0, false) == false, "unknown event does not play")
	_expect(router.get_loaded_event_ids().size() == EXPECTED_EVENTS.size(), "loaded players cover six required events")
	_expect(router.play_event(SubmissionSfxRouter.EVENT_UI_FOCUS_OR_MOVE, 1000, false) == true, "first focus event allowed")
	_expect(router.play_event(SubmissionSfxRouter.EVENT_UI_FOCUS_OR_MOVE, 1_100, false) == false, "focus event debounced within threshold")
	_expect(router.play_event(SubmissionSfxRouter.EVENT_UI_FOCUS_OR_MOVE, 1_300, false) == true, "focus event replays after debounce window")
	_expect(router.play_event(SubmissionSfxRouter.EVENT_YOU_MOVE, -1, false) == true, "YOU movement maps to YOU_move")
	_expect(router.play_event(SubmissionSfxRouter.EVENT_ECHO_MOVE, -1, false) == true, "ECHO movement maps to ECHO_move")
	_expect(router.play_event(SubmissionSfxRouter.EVENT_BLOCKED_OR_INVALID, -1, false) == true, "blocked cue plays")
	_expect(router.play_event(SubmissionSfxRouter.EVENT_LEVEL_COMPLETE, 0, false) == true, "first level_complete cue plays")
	_expect(router.play_event(SubmissionSfxRouter.EVENT_LEVEL_COMPLETE, 0, false) == false, "level_complete one-shot stays false after first")
	_expect(router.movement_event_for_outcome("YOU", true, false, false) == SubmissionSfxRouter.EVENT_YOU_MOVE, "you move outcome maps to YOU_move")
	_expect(router.movement_event_for_outcome("YOU", false, false, false) == "", "you no-move produces empty event")
	_expect(router.movement_event_for_outcome("YOU", true, true, false) == SubmissionSfxRouter.EVENT_BLOCKED_OR_INVALID, "you blocked move maps to blocked")
	_expect(router.movement_event_for_outcome("ECHO", true, false, false) == SubmissionSfxRouter.EVENT_ECHO_MOVE, "echo move outcome maps to ECHO_move")
	_expect(router.movement_event_for_outcome("ECHO", false, false, false) == "", "echo no-move produces empty event")
	_expect(router.movement_event_for_outcome("ECHO", false, true, false) == "", "echo blocked no-move produces empty event")
	_expect(router.movement_event_for_outcome("YOU", true, false, true) == SubmissionSfxRouter.EVENT_LEVEL_COMPLETE, "completion outcome takes precedence")


func _test_integrated_event_seams(tree: SceneTree) -> void:
	var router := SubmissionSfxRouter.ensure_router(tree)
	router.reset_router_state()
	var gameplay := GameplayScene.instantiate()
	tree.root.add_child(gameplay)
	await tree.process_frame
	router.reset_router_state()
	var blocked_before := {
		"player_position": Vector2i(1, 1),
		"echo_positions": [{"id": "echo", "position": Vector2i(2, 2)}],
		"completed": false,
	}
	var blocked_after := {
		"player_position": Vector2i(1, 1),
		"echo_positions": [{"id": "echo", "position": Vector2i(3, 2)}],
		"completed": false,
	}
	gameplay._play_transition_sfx(blocked_before, blocked_after, "RIGHT", false)
	_expect(router.get_accepted_event_history() == [SubmissionSfxRouter.EVENT_BLOCKED_OR_INVALID, SubmissionSfxRouter.EVENT_ECHO_MOVE], "blocked YOU with moving ECHO emits blocked plus ECHO, never YOU_move")
	router.reset_router_state()
	gameplay._play_transition_sfx(blocked_before, blocked_after.merged({"completed": true}, true), "WAIT", false)
	gameplay._play_transition_sfx(blocked_before, blocked_after.merged({"completed": true}, true), "WAIT", false)
	_expect(router.get_accepted_event_history() == [SubmissionSfxRouter.EVENT_LEVEL_COMPLETE], "integrated completion edge is one-shot")
	gameplay.queue_free()
	await tree.process_frame
	_expect(tree.root.get_node_or_null("SubmissionSfxRouter") == router, "root router survives gameplay scene replacement")

	var menu := MainMenuScene.instantiate()
	tree.root.add_child(menu)
	await tree.process_frame
	router.reset_router_state()
	var play: Button = menu.get_node("MenuActions/Play")
	play.emit_signal("focus_entered")
	play.emit_signal("pressed")
	_expect(router.get_accepted_event_history() == [SubmissionSfxRouter.EVENT_UI_FOCUS_OR_MOVE, SubmissionSfxRouter.EVENT_UI_CONFIRM], "main menu focus and confirm callbacks reach router")
	menu.queue_free()
	await tree.process_frame

	var level_select := LevelSelectScene.instantiate()
	level_select.configure([], null)
	tree.root.add_child(level_select)
	await tree.process_frame
	router.reset_router_state()
	var back: Button = level_select.get_node("OuterPanel/Back")
	back.emit_signal("focus_entered")
	back.emit_signal("pressed")
	_expect(router.get_accepted_event_history() == [SubmissionSfxRouter.EVENT_UI_FOCUS_OR_MOVE, SubmissionSfxRouter.EVENT_UI_CONFIRM], "level select focus and confirm callbacks reach router")
	level_select.queue_free()
	await tree.process_frame


func _ensure_router_and_preload(tree: SceneTree = null) -> SubmissionSfxRouter:
	if tree == null:
		tree = self
	var router := SubmissionSfxRouter.ensure_router(tree)
	return router


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
		"blocked_or_invalid":
			return "res://audio/sfx/gameplay/blocked_invalid.wav"
		"level_complete":
			return "res://audio/sfx/gameplay/level_complete.wav"
	return ""


func _expected_musics(router: SubmissionSfxRouter, event_id: String) -> bool:
	var record: Dictionary = router.get_event_map_snapshot().get(event_id, {})
	return String(record.get("bus", "")) == "Music"


func _parse_wav_header(path: String) -> Dictionary:
	var bytes := FileAccess.get_file_as_bytes(path)
	if bytes.is_empty() or bytes.size() < 44:
		return {"ok": false}
	if bytes[0] != 82 or bytes[1] != 73 or bytes[2] != 70 or bytes[3] != 70:
		return {"ok": false}
	if bytes[8] != 87 or bytes[9] != 65 or bytes[10] != 86 or bytes[11] != 69:
		return {"ok": false}
	var format_tag := _u16_le(bytes, 20)
	var channels := _u16_le(bytes, 22)
	var sample_rate := _u32_le(bytes, 24)
	var bits_per_sample := _u16_le(bytes, 34)
	var data_size := _u32_le(bytes, 40)
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


func _expect(condition: bool, label: String) -> void:
	assertions += 1
	if not condition:
		failures += 1
		printerr("TASK_0024BAD_SFX_CONTRACT_FAIL " + label)

extends SceneTree

const AppRootScene = preload("res://scenes/app/app_root.tscn")
const GameplayScene = preload("res://scenes/vertical_slice/vertical_slice.tscn")

const WITNESS := ["RIGHT", "RIGHT", "RIGHT", "UP", "UP", "UP", "LEFT", "RIGHT", "DOWN", "DOWN", "UP", "LEFT", "RIGHT", "UP", "UP", "UP"]
const PREFIX_LEVELS := [
	["tutorial_reach_exit", ["UP", "RIGHT", "RIGHT"]],
	["tutorial_echo_bridge", ["RIGHT", "RIGHT", "UP", "DOWN", "LEFT", "DOWN", "DOWN", "RIGHT", "RIGHT"]],
	["vertical_slice_delay_3", ["RIGHT", "RIGHT", "UP", "UP", "UP", "RIGHT", "RIGHT", "RIGHT", "RIGHT"]],
	["door_one_turn_late", ["RIGHT", "RIGHT", "UP", "UP", "RIGHT", "RIGHT", "RIGHT", "UP", "UP"]],
	["two_keys_one_door", ["RIGHT", "RIGHT", "RIGHT", "RIGHT", "UP", "UP", "RIGHT", "RIGHT", "UP", "UP", "LEFT", "LEFT"]],
]
const LEVEL_6 := ["UP", "RIGHT", "RIGHT", "DOWN", "UP", "RIGHT", "RIGHT", "RIGHT", "RIGHT", "UP", "UP", "UP", "LEFT", "LEFT", "LEFT"]

var output_directory := ""
var records: Array = []


func _init() -> void:
	var arguments: Array = OS.get_cmdline_user_args()
	arguments.append_array(OS.get_cmdline_args())
	for argument in arguments:
		if argument.begins_with("--evidence-dir="):
			output_directory = argument.trim_prefix("--evidence-dir=")
	call_deferred("_capture")


func _capture() -> void:
	if output_directory.is_empty() or not DirAccess.dir_exists_absolute(output_directory):
		printerr("TASK_0017_CAPTURE_INVALID_EVIDENCE_DIRECTORY")
		quit(1)
		return
	root.size = Vector2i(960, 540)
	var app = await _new_app()
	for spec in PREFIX_LEVELS:
		await _complete(app, spec[0], spec[1])
	var locked_scroll: ScrollContainer = app.get_active_screen().get_node("OuterPanel/EntryScroll")
	locked_scroll.scroll_vertical = int(app.get_active_screen().get_screen_snapshot().scroll.maximum)
	await _frames()
	if not await _save_app("01_bridge_locked_before_level_6.png", app):
		return
	await _complete(app, "staggered_doors", LEVEL_6)
	if not await _save_app("02_level_6_completion_reveals_bridge.png", app):
		return
	app.queue_free()
	await _frames()

	var gameplay = await _new_bridge()
	if not await _save_gameplay("03_bridge_initial_cues.png", gameplay):
		return
	for index in 5:
		_send_action(gameplay, WITNESS[index])
	if gameplay.get_presentation_snapshot().echo_divergence.visible:
		_abort("stable-spacing state falsely cues")
		return
	if not await _save_gameplay("04_stable_spacing_no_false_cue.png", gameplay):
		return
	for index in range(5, 9):
		_send_action(gameplay, WITNESS[index])
	var divergence: Dictionary = gameplay.get_presentation_snapshot().echo_divergence
	if not divergence.visible or divergence.detail != "E2 BLOCKED · E4 MOVED":
		_abort("required BLOCKED/MOVED cue missing")
		return
	if not await _save_gameplay("05_required_blocked_moved_divergence.png", gameplay):
		return
	for index in range(9, 12):
		_send_action(gameplay, WITNESS[index])
	if not await _save_gameplay("06_recovery_phase.png", gameplay):
		return
	for index in range(12, 14):
		_send_action(gameplay, WITNESS[index])
	if not gameplay.state.door_states[0].open:
		_abort("A+B committed result did not open Door")
		return
	if not await _save_gameplay("07_e2_a_e4_b_result.png", gameplay):
		return
	_send_action(gameplay, WITNESS[14])
	if gameplay.state.player_position != [6, 2]:
		_abort("open-snapshot crossing did not enter Door")
		return
	if not await _save_gameplay("08_open_snapshot_crossing.png", gameplay):
		return
	gameplay.queue_free()
	await _frames()

	app = await _new_app()
	for spec in PREFIX_LEVELS:
		await _complete(app, spec[0], spec[1])
	await _complete(app, "staggered_doors", LEVEL_6)
	await _complete(app, "echo_spacing_bridge", WITNESS)
	if not await _save_app("09_bridge_completion_reveals_shifted_level_7.png", app):
		return
	var level_select = app.get_active_screen()
	var final_button: Button = level_select.get_node("OuterPanel/EntryScroll/LevelEntries/Level_two_echo_convergence")
	final_button.grab_focus()
	await _frames()
	if not await _save_app("10_sequence_8_tail_focus.png", app):
		return
	app.queue_free()
	await _frames()

	var reduced = await _new_bridge()
	for index in 9:
		_send_action(reduced, WITNESS[index])
	reduced.set_reduced_motion_for_test(true)
	await _frames()
	if not await _save_gameplay("11_reduced_motion_decision.png", reduced):
		return
	if not await _save_grayscale("12_grayscale_decision.png", reduced):
		return
	reduced.queue_free()
	await _frames()

	var snapshot_file := FileAccess.open(output_directory.path_join("presentation_snapshots.txt"), FileAccess.WRITE)
	if snapshot_file == null:
		_abort("snapshot ledger could not be written")
		return
	snapshot_file.store_string(var_to_str(records))
	snapshot_file.close()
	print("TASK_0017_VIEWPORT_CAPTURES_PASS captures=12")
	quit(0)


func _new_app():
	var app = AppRootScene.instantiate()
	root.add_child(app)
	await _frames()
	app.navigate("LEVEL_SELECT")
	await _frames()
	return app


func _new_bridge():
	var gameplay = GameplayScene.instantiate()
	if not gameplay.configure_route_payload({"level_id": "echo_spacing_bridge", "level_path": "res://data/levels/echo_spacing_bridge.json", "hud_mode": "STANDARD_COMPACT", "classification": "standard", "development_direct": true, "final_level": false}):
		_abort("bridge route payload rejected")
		return null
	root.add_child(gameplay)
	await _frames()
	return gameplay


func _complete(app: Node, level_id: String, actions: Array) -> void:
	app.select_level(level_id)
	await _frames()
	for action in actions:
		_send_action(app.get_active_screen(), action)
	await _frames()


func _save_app(filename: String, app: Node) -> bool:
	var screen = app.get_active_screen()
	var snapshot: Dictionary = screen.get_screen_snapshot()
	records.append({"file": filename, "viewport": Vector2i(960, 540), "route": app.get_current_route(), "level_select": snapshot})
	return await _save(filename)


func _save_gameplay(filename: String, gameplay: Node) -> bool:
	records.append({"file": filename, "viewport": Vector2i(960, 540), "turn": gameplay.state.turn_index, "presentation": gameplay.get_presentation_snapshot()})
	return await _save(filename)


func _save_grayscale(filename: String, gameplay: Node) -> bool:
	records.append({"file": filename, "viewport": Vector2i(960, 540), "turn": gameplay.state.turn_index, "grayscale": true, "presentation": gameplay.get_presentation_snapshot()})
	var image := root.get_texture().get_image()
	image.convert(Image.FORMAT_L8)
	var path := output_directory.path_join(filename)
	var error := image.save_png(path)
	if error != OK:
		return _abort("grayscale save failed: " + path)
	print("CAPTURE_SAVED " + path)
	return true


func _save(filename: String) -> bool:
	await _frames()
	var path := output_directory.path_join(filename)
	var error := root.get_texture().get_image().save_png(path)
	if error != OK:
		return _abort("capture save failed: " + path)
	print("CAPTURE_SAVED " + path)
	return true


func _frames() -> void:
	await process_frame
	await process_frame


func _send_action(scene: Node, action: String) -> void:
	var event := InputEventAction.new()
	event.action = {"UP": "move_up", "RIGHT": "move_right", "DOWN": "move_down", "LEFT": "move_left", "WAIT": "wait_turn"}[action]
	event.pressed = true
	scene._unhandled_input(event)


func _abort(message: String) -> bool:
	printerr("TASK_0017_CAPTURE_FAIL " + message)
	quit(1)
	return false

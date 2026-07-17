extends SceneTree

const AppRootScene = preload("res://scenes/app/app_root.tscn")
const GameplayScene = preload("res://scenes/vertical_slice/vertical_slice.tscn")

const WITNESS := ["RIGHT", "RIGHT", "RIGHT", "RIGHT", "RIGHT", "RIGHT", "UP", "UP", "UP", "LEFT", "RIGHT", "DOWN", "DOWN", "UP", "DOWN", "UP", "UP", "UP", "UP"]

var output_directory := ""


func _init() -> void:
	var arguments: Array = OS.get_cmdline_user_args()
	arguments.append_array(OS.get_cmdline_args())
	for argument in arguments:
		if argument.begins_with("--evidence-dir="):
			output_directory = argument.trim_prefix("--evidence-dir=")
	call_deferred("_capture")


func _capture() -> void:
	if output_directory.is_empty() or not DirAccess.dir_exists_absolute(output_directory):
		printerr("TASK_0015_CAPTURE_INVALID_EVIDENCE_DIRECTORY")
		quit(1)
		return
	root.size = Vector2i(960, 540)
	var app = AppRootScene.instantiate()
	root.add_child(app)
	await _frames()
	app.navigate("LEVEL_SELECT")
	await _frames()
	await _complete(app, "tutorial_reach_exit", ["UP", "RIGHT", "RIGHT"])
	await _complete(app, "tutorial_echo_bridge", ["RIGHT", "RIGHT", "UP", "DOWN", "LEFT", "DOWN", "DOWN", "RIGHT", "RIGHT"])
	await _complete(app, "vertical_slice_delay_3", ["RIGHT", "RIGHT", "UP", "UP", "UP", "RIGHT", "RIGHT", "RIGHT", "RIGHT"])
	await _complete(app, "door_one_turn_late", ["RIGHT", "RIGHT", "UP", "UP", "RIGHT", "RIGHT", "RIGHT", "UP", "UP"])
	await _complete(app, "two_keys_one_door", ["RIGHT", "RIGHT", "RIGHT", "RIGHT", "UP", "UP", "RIGHT", "RIGHT", "UP", "UP", "LEFT", "LEFT"])
	if not await _save("01_level_7_locked.png"):
		return
	await _complete(app, "staggered_doors", ["UP", "RIGHT", "RIGHT", "DOWN", "UP", "RIGHT", "RIGHT", "RIGHT", "RIGHT", "UP", "UP", "UP", "LEFT", "LEFT", "LEFT"])
	if not await _save("02_level_7_unlocked.png"):
		return
	app.queue_free()
	await _frames()

	var gameplay = GameplayScene.instantiate()
	gameplay.configure_route_payload({"level_id": "two_echo_convergence", "level_path": "res://data/levels/two_echo_convergence.json", "hud_mode": "STANDARD_COMPACT", "classification": "standard", "development_direct": true, "final_level": true})
	root.add_child(gameplay)
	await _frames()
	if not await _save("03_level_7_initial_cues.png"):
		return
	_send_action(gameplay, WITNESS[0])
	await _frames()
	if not await _save("04_e2_e4_overlap.png"):
		return
	for action in WITNESS.slice(1, 17):
		_send_action(gameplay, action)
	await _frames()
	if not gameplay.state.door_states[0].open:
		printerr("TASK_0015_CAPTURE_CONVERGENCE_FAILED")
		quit(1)
		return
	if not await _save("05_two_echo_convergence_result.png"):
		return
	if not await _save_grayscale("08_grayscale_decision_frame.png"):
		return
	_send_action(gameplay, WITNESS[17])
	await _frames()
	if not await _save("06_open_snapshot_crossing.png"):
		return
	_send_action(gameplay, WITNESS[18])
	await _frames()
	if not gameplay.state.completed:
		printerr("TASK_0015_CAPTURE_COMPLETION_FAILED")
		quit(1)
		return
	if not await _save("07_level_7_completion.png"):
		return
	print("TASK_0015_VIEWPORT_CAPTURES_PASS")
	quit(0)


func _complete(app: Node, level_id: String, actions: Array) -> void:
	app.select_level(level_id)
	await _frames()
	for action in actions:
		_send_action(app.get_active_screen(), action)
	await _frames()


func _frames() -> void:
	await process_frame
	await process_frame


func _send_action(scene: Node, action: String) -> void:
	var input_actions := {"UP": "move_up", "RIGHT": "move_right", "DOWN": "move_down", "LEFT": "move_left", "WAIT": "wait_turn"}
	var event := InputEventAction.new()
	event.action = input_actions[action]
	event.pressed = true
	scene._unhandled_input(event)


func _save(filename: String) -> bool:
	var path := output_directory.path_join(filename)
	var error := root.get_texture().get_image().save_png(path)
	if error != OK:
		printerr("TASK_0015_CAPTURE_SAVE_FAILED path=%s error=%d" % [path, error])
		quit(1)
		return false
	print("CAPTURE_SAVED " + path)
	return true


func _save_grayscale(filename: String) -> bool:
	var image := root.get_texture().get_image()
	image.convert(Image.FORMAT_L8)
	var path := output_directory.path_join(filename)
	var error := image.save_png(path)
	if error != OK:
		printerr("TASK_0015_GRAYSCALE_SAVE_FAILED path=%s error=%d" % [path, error])
		quit(1)
		return false
	print("CAPTURE_SAVED " + path)
	return true

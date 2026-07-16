extends SceneTree

const AppRootScene = preload("res://scenes/app/app_root.tscn")
const GameplayScene = preload("res://scenes/vertical_slice/vertical_slice.tscn")

const WITNESS := ["UP", "RIGHT", "RIGHT", "DOWN", "UP", "RIGHT", "RIGHT", "RIGHT", "RIGHT", "UP", "UP", "UP", "LEFT", "LEFT", "LEFT"]

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
		printerr("TASK_0012_CAPTURE_INVALID_EVIDENCE_DIRECTORY")
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
	if not await _save("level_select_level_6_locked.png"):
		return
	await _complete(app, "two_keys_one_door", ["RIGHT", "RIGHT", "RIGHT", "RIGHT", "UP", "UP", "RIGHT", "RIGHT", "UP", "UP", "LEFT", "LEFT"])
	if not await _save("level_select_level_6_unlocked.png"):
		return
	app.select_level("staggered_doors")
	await _frames()
	if not await _save("staggered_doors_initial.png"):
		return
	for action in WITNESS.slice(0, 5):
		_send_action(app.get_active_screen(), action)
	await _frames()
	if not await _save("staggered_doors_first_window.png"):
		return
	for action in WITNESS.slice(5, 7):
		_send_action(app.get_active_screen(), action)
	await _frames()
	if not await _save("staggered_doors_second_window.png"):
		return
	root.remove_child(app)
	app.queue_free()
	await _frames()

	var completion = GameplayScene.instantiate()
	completion.configure_route_payload({
		"level_id": "staggered_doors",
		"level_path": "res://data/levels/staggered_doors.json",
		"hud_mode": "STANDARD_COMPACT",
		"classification": "standard",
		"development_direct": true,
		"final_level": true,
	})
	root.add_child(completion)
	await _frames()
	for action in WITNESS:
		_send_action(completion, action)
	await _frames()
	if not completion.state.completed:
		printerr("TASK_0012_CAPTURE_COMPLETION_FAILED")
		quit(1)
		return
	if not await _save("staggered_doors_completion.png"):
		return
	print("TASK_0012_VIEWPORT_CAPTURES_PASS")
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
		printerr("TASK_0012_CAPTURE_SAVE_FAILED path=%s error=%d" % [path, error])
		quit(1)
		return false
	print("CAPTURE_SAVED " + path)
	return true

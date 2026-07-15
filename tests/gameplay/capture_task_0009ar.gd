extends SceneTree

var output_directory := ""


func _init() -> void:
	for argument in OS.get_cmdline_user_args():
		if argument.begins_with("--evidence-dir="):
			output_directory = argument.trim_prefix("--evidence-dir=")
	call_deferred("_capture")


func _capture() -> void:
	if output_directory.is_empty() or not DirAccess.dir_exists_absolute(output_directory):
		printerr("CAPTURE_INVALID_EVIDENCE_DIRECTORY")
		quit(1)
		return
	root.size = Vector2i(960, 540)
	var packed = load("res://scenes/app/app_root.tscn")
	if not packed is PackedScene:
		printerr("CAPTURE_APP_SCENE_UNAVAILABLE")
		quit(1)
		return
	var app = packed.instantiate()
	root.add_child(app)
	await _frames()
	app.navigate("LEVEL_SELECT")
	await _frames()
	if not await _save("level_select_five_initial.png"):
		return
	await _complete(app, "tutorial_reach_exit", ["UP", "RIGHT", "RIGHT"])
	await _complete(app, "tutorial_echo_bridge", ["RIGHT", "RIGHT", "UP", "DOWN", "LEFT", "DOWN", "DOWN", "RIGHT", "RIGHT"])
	await _complete(app, "vertical_slice_delay_3", ["RIGHT", "RIGHT", "UP", "UP", "UP", "RIGHT", "RIGHT", "RIGHT", "RIGHT"])
	if not await _save("level_select_level_4_unlocked.png"):
		return
	app.select_level("door_one_turn_late")
	await _frames()
	if not await _save("door_one_turn_late_initial.png"):
		return
	for action in ["RIGHT", "RIGHT", "UP", "UP", "RIGHT"]:
		_send_action(app.get_active_screen(), action)
	await _frames()
	if not await _save("door_one_turn_late_open_result.png"):
		return
	for action in ["RIGHT", "RIGHT", "UP", "UP"]:
		_send_action(app.get_active_screen(), action)
	await _frames()
	if not await _save("level_select_level_5_unlocked.png"):
		return
	app.select_level("two_keys_one_door")
	await _frames()
	if not await _save("two_keys_one_door_initial.png"):
		return
	for action in ["RIGHT", "RIGHT", "RIGHT", "RIGHT", "UP", "UP", "RIGHT"]:
		_send_action(app.get_active_screen(), action)
	await _frames()
	if not await _save("two_keys_one_door_and_open.png"):
		return
	print("TASK_0009AR_VIEWPORT_CAPTURES_PASS")
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
		printerr("CAPTURE_SAVE_FAILED path=%s error=%d" % [path, error])
		quit(1)
		return false
	print("CAPTURE_SAVED " + path)
	return true

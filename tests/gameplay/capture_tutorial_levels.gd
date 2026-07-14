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
	if not await _save("level_select_initial.png"):
		return
	app.select_level("tutorial_reach_exit")
	await _frames()
	if not await _save("tutorial_reach_exit.png"):
		return
	for action in ["UP", "RIGHT", "RIGHT"]:
		_send_action(app.get_active_screen(), action)
	await _frames()
	if not await _save("level_select_after_tutorial_0.png"):
		return
	app.select_level("tutorial_echo_bridge")
	await _frames()
	if not await _save("tutorial_echo_bridge.png"):
		return
	for action in ["RIGHT", "RIGHT", "UP", "DOWN", "LEFT", "DOWN", "DOWN", "RIGHT", "RIGHT"]:
		_send_action(app.get_active_screen(), action)
	await _frames()
	if not await _save("level_select_after_tutorial_1.png"):
		return
	app.select_level("vertical_slice_delay_3")
	await _frames()
	if not await _save("vertical_slice_unchanged.png"):
		return
	print("TASK_0007_VIEWPORT_CAPTURES_PASS")
	quit(0)


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

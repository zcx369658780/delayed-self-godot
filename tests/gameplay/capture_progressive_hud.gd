extends SceneTree

const GameplayScene = preload("res://scenes/vertical_slice/vertical_slice.tscn")

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
	var intro = await _open("tutorial_reach_exit", "res://data/levels/tutorial_reach_exit.json", "INTRO_MINIMAL")
	if intro == null:
		return
	if not await _save("intro_minimal_initial.png"):
		return
	_send_action(intro, "UP")
	await _frames()
	if not await _save("intro_minimal_progressed.png"):
		return
	intro.toggle_help()
	await _frames()
	if not await _save("intro_minimal_help_expanded.png"):
		return
	intro.toggle_help()
	_send_action(intro, "RIGHT")
	_send_action(intro, "RIGHT")
	await _frames()
	if not await _save("intro_minimal_completed.png"):
		return
	await _close(intro)

	var guided = await _open("tutorial_echo_bridge", "res://data/levels/tutorial_echo_bridge.json", "GUIDED_ECHO")
	if guided == null:
		return
	if not await _save("guided_echo_initial.png"):
		return
	for action in ["RIGHT", "RIGHT", "UP"]:
		_send_action(guided, action)
	await _frames()
	if not await _save("guided_echo_before_first_replay.png"):
		return
	_send_action(guided, "DOWN")
	await _frames()
	if not await _save("guided_echo_after_first_replay.png"):
		return
	_send_action(guided, "LEFT")
	await _frames()
	if not await _save("guided_echo_on_plate.png"):
		return
	guided.toggle_help()
	await _frames()
	if not await _save("guided_echo_help_expanded.png"):
		return
	guided.toggle_help()
	for action in ["DOWN", "DOWN", "RIGHT", "RIGHT"]:
		_send_action(guided, action)
	await _frames()
	if not await _save("guided_echo_completed.png"):
		return
	await _close(guided)

	var standard = await _open("vertical_slice_delay_3", "res://data/levels/vertical_slice_delay_3.json", "STANDARD_COMPACT")
	if standard == null:
		return
	if not await _save("standard_compact_initial.png"):
		return
	_send_action(standard, "RIGHT")
	await _frames()
	if not await _save("standard_compact_progressed.png"):
		return
	standard.toggle_help()
	await _frames()
	if not await _save("standard_compact_help_expanded.png"):
		return
	print("TASK_0008_VIEWPORT_CAPTURES_PASS")
	quit(0)


func _open(level_id: String, level_path: String, hud_mode: String):
	var scene = GameplayScene.instantiate()
	var configured: bool = scene.configure_route_payload({
		"level_id": level_id,
		"level_path": level_path,
		"hud_mode": hud_mode,
		"classification": "tutorial" if level_id.begins_with("tutorial_") else "standard",
		"development_direct": true,
		"final_level": level_id == "vertical_slice_delay_3",
	})
	if not configured:
		printerr("CAPTURE_CONFIGURATION_FAILED " + level_id)
		quit(1)
		return null
	root.add_child(scene)
	await _frames()
	if not scene.is_runtime_ready():
		printerr("CAPTURE_RUNTIME_NOT_READY " + level_id)
		quit(1)
		return null
	return scene


func _close(scene: Node) -> void:
	root.remove_child(scene)
	scene.queue_free()
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

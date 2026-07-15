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
	var cases := [
		["tutorial_reach_exit", "res://data/levels/tutorial_reach_exit.json", "INTRO_MINIMAL"],
		["tutorial_echo_bridge", "res://data/levels/tutorial_echo_bridge.json", "GUIDED_ECHO"],
		["vertical_slice_delay_3", "res://data/levels/vertical_slice_delay_3.json", "STANDARD_COMPACT"],
		["door_one_turn_late", "res://data/levels/door_one_turn_late.json", "STANDARD_COMPACT"],
		["two_keys_one_door", "res://data/levels/two_keys_one_door.json", "STANDARD_COMPACT"],
	]
	for item in cases:
		var initial = await _open(item[0], item[1], item[2])
		if initial == null or not await _save("initial_%s.png" % item[0]):
			return
		await _close(initial)

	var guided = await _open("tutorial_echo_bridge", "res://data/levels/tutorial_echo_bridge.json", "GUIDED_ECHO")
	if guided == null:
		return
	if not await _save("timeline_guided_visible.png"):
		return
	guided.toggle_help()
	await _frames()
	if not await _save("help_guided_modal.png"):
		return
	await _close(guided)

	var standard = await _open("vertical_slice_delay_3", "res://data/levels/vertical_slice_delay_3.json", "STANDARD_COMPACT")
	if standard == null:
		return
	if not await _save("timeline_standard_hidden.png"):
		return
	standard.toggle_help()
	await _frames()
	if not await _save("help_standard_modal.png"):
		return
	await _close(standard)

	var timing = await _open("door_one_turn_late", "res://data/levels/door_one_turn_late.json", "STANDARD_COMPACT")
	if timing == null:
		return
	for action in ["RIGHT", "RIGHT", "UP", "UP"]:
		_send_action(timing, action)
	await _frames()
	if not await _save("level4_closed_critical_start.png"):
		return
	_send_action(timing, "UP")
	await _frames()
	if not await _save("level4_blocked_echo_plate_feedback.png"):
		return
	if not await _save("level4_open_next_input_badge.png"):
		return
	_send_action(timing, "RIGHT")
	await _frames()
	if not await _save("level4_next_input_closed_around_you.png"):
		return
	await _close(timing)

	var and_level = await _open("two_keys_one_door", "res://data/levels/two_keys_one_door.json", "STANDARD_COMPACT")
	if and_level == null:
		return
	for action in ["RIGHT", "RIGHT", "RIGHT", "RIGHT", "UP", "UP", "RIGHT"]:
		_send_action(and_level, action)
	await _frames()
	if not await _save("level5_two_plate_and_open.png"):
		return
	await _close(and_level)

	var reduced = await _open("door_one_turn_late", "res://data/levels/door_one_turn_late.json", "STANDARD_COMPACT")
	if reduced == null:
		return
	reduced.set_reduced_motion_for_test(true)
	for action in ["RIGHT", "RIGHT", "UP", "UP", "UP"]:
		_send_action(reduced, action)
	await _frames()
	if not await _save("level4_reduced_motion_static_feedback.png"):
		return
	await _close(reduced)

	if not _save_grayscale("level4_closed_critical_start.png", "grayscale_level4_closed.png"):
		return
	if not _save_grayscale("level4_open_next_input_badge.png", "grayscale_level4_open.png"):
		return
	print("TASK_0011_VIEWPORT_CAPTURES_PASS")
	quit(0)


func _open(level_id: String, level_path: String, hud_mode: String):
	var scene = GameplayScene.instantiate()
	if not scene.configure_route_payload({"level_id": level_id, "level_path": level_path, "hud_mode": hud_mode, "classification": "tutorial" if level_id.begins_with("tutorial_") else "standard", "development_direct": true, "final_level": level_id == "two_keys_one_door"}):
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


func _save_grayscale(source_name: String, target_name: String) -> bool:
	var image := Image.load_from_file(output_directory.path_join(source_name))
	if image.is_empty():
		printerr("GRAYSCALE_SOURCE_INVALID " + source_name)
		quit(1)
		return false
	image.convert(Image.FORMAT_L8)
	var path := output_directory.path_join(target_name)
	var error := image.save_png(path)
	if error != OK:
		printerr("GRAYSCALE_SAVE_FAILED path=%s error=%d" % [path, error])
		quit(1)
		return false
	print("GRAYSCALE_SAVED " + path)
	return true

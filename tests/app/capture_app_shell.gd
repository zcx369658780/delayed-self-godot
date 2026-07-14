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
	await process_frame
	await process_frame
	if not await _save("main_menu.png"):
		return
	app.navigate("LEVEL_SELECT")
	await process_frame
	await process_frame
	if not await _save("level_select.png"):
		return
	app.select_level("vertical_slice_delay_3")
	await process_frame
	await process_frame
	print("CAPTURE_LAYOUT logical_viewport=%s host_size=%s" % [root.size, app.get_node("RouteHost").size])
	if not await _save("gameplay_route.png"):
		return
	app.navigate("UNKNOWN_CAPTURE_ROUTE")
	await process_frame
	await process_frame
	if not await _save("safe_error.png"):
		return
	print("TASK_0006_VIEWPORT_CAPTURES_PASS")
	quit(0)


func _save(filename: String) -> bool:
	var image := root.get_texture().get_image()
	var path := output_directory.path_join(filename)
	var error := image.save_png(path)
	if error != OK:
		printerr("CAPTURE_SAVE_FAILED path=%s error=%d" % [path, error])
		quit(1)
		return false
	print("CAPTURE_SAVED " + path)
	return true

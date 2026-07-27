extends SceneTree

const MainMenuScene = preload("res://scenes/ui/main_menu.tscn")
const GameplayScene = preload("res://scenes/vertical_slice/vertical_slice.tscn")

var output_dir := "res://docs/reviews/evidence/0024BAD"


func _init() -> void:
	for argument in OS.get_cmdline_user_args():
		if argument.begins_with("--output-dir="):
			output_dir = argument.trim_prefix("--output-dir=")
	call_deferred("_run")


func _run() -> void:
	root.size = Vector2i(960, 540)
	var absolute_dir := ProjectSettings.globalize_path(output_dir)
	var error := DirAccess.make_dir_recursive_absolute(absolute_dir)
	if error != OK:
		printerr("TASK_0024BAD_CAPTURE_FAIL mkdir=%d" % error)
		quit(1)
		return
	if not await _capture_scene(MainMenuScene, "main_menu.png"):
		quit(1)
		return
	if not await _capture_scene(GameplayScene, "gameplay.png"):
		quit(1)
		return
	print("TASK_0024BAD_CAPTURE_PASS count=2 viewport=960x540")
	quit(0)


func _capture_scene(packed_scene: PackedScene, filename: String) -> bool:
	var node := packed_scene.instantiate()
	root.add_child(node)
	await process_frame
	await process_frame
	await process_frame
	var image := root.get_texture().get_image()
	var path := output_dir.path_join(filename)
	var error := image.save_png(path)
	node.queue_free()
	await process_frame
	if error != OK or image.get_width() != 960 or image.get_height() != 540:
		printerr("TASK_0024BAD_CAPTURE_FAIL file=%s error=%d size=%dx%d" % [
			filename,
			error,
			image.get_width(),
			image.get_height(),
		])
		return false
	return true

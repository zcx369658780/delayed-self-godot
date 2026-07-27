extends SceneTree

const GameplayScene = preload("res://scenes/vertical_slice/vertical_slice.tscn")
const LevelLoader = preload("res://scripts/simulation/level_loader.gd")
const Simulation = preload("res://scripts/simulation/simulation.gd")

const OUTPUT_DIR := "res://docs/reviews/evidence/0024BAE"

var loader := LevelLoader.new()
var simulation := Simulation.new()


func _init() -> void:
	call_deferred("_run")


func _run() -> void:
	root.size = Vector2i(960, 540)
	var error := DirAccess.make_dir_recursive_absolute(ProjectSettings.globalize_path(OUTPUT_DIR))
	if error != OK:
		printerr("TASK_0024BAE_CAPTURE_FAIL mkdir=%d" % error)
		quit(1)
		return
	if not await _capture_level(
		"res://data/levels/vertical_slice_delay_3.json",
		[],
		"01_closed_door_initial.png"
	):
		quit(1)
		return
	if not await _capture_level(
		"res://data/levels/vertical_slice_delay_3.json",
		["RIGHT", "RIGHT"],
		"02_plate_active_door_open.png"
	):
		quit(1)
		return
	if not await _capture_level(
		"res://data/levels/two_echo_convergence.json",
		["WAIT", "WAIT", "WAIT", "WAIT"],
		"03_two_echo_finale.png"
	):
		quit(1)
		return
	print("TASK_0024BAE_CAPTURE_PASS count=3 viewport=960x540")
	quit(0)


func _capture_level(path: String, actions: Array, filename: String) -> bool:
	var loaded: Dictionary = loader.load_file(path)
	if not loaded.ok:
		printerr("TASK_0024BAE_CAPTURE_FAIL load=%s" % path)
		return false
	var level: Dictionary = loaded.level
	var scene = GameplayScene.instantiate()
	scene.configure_route_payload({
		"level_id": level.get("level_id", path.get_file()),
		"level_path": path,
		"hud_mode": "STANDARD_COMPACT",
		"classification": "owner_capture",
		"development_direct": true,
		"final_level": false,
	})
	root.add_child(scene)
	await process_frame
	var capture_state: Dictionary = simulation.construct_initial_state(level)
	for action in actions:
		var transition: Dictionary = simulation.transition(level, capture_state, String(action))
		if not transition.ok:
			scene.queue_free()
			await process_frame
			printerr("TASK_0024BAE_CAPTURE_FAIL transition=%s level=%s" % [action, path])
			return false
		capture_state = transition.state
	scene.state = capture_state
	scene._update_hud()
	scene.queue_redraw()
	await process_frame
	await process_frame
	await process_frame
	var image := root.get_texture().get_image()
	var save_error := image.save_png(OUTPUT_DIR.path_join(filename))
	var valid := save_error == OK and image.get_width() == 960 and image.get_height() == 540
	scene.queue_free()
	await process_frame
	if not valid:
		printerr("TASK_0024BAE_CAPTURE_FAIL file=%s error=%d size=%dx%d" % [
			filename,
			save_error,
			image.get_width(),
			image.get_height(),
		])
	return valid

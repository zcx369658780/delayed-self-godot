extends SceneTree

const GameplayScene = preload("res://scenes/vertical_slice/vertical_slice.tscn")
const WITNESS := ["RIGHT", "RIGHT", "RIGHT", "RIGHT", "RIGHT", "RIGHT", "UP", "UP", "UP", "LEFT", "RIGHT", "DOWN", "DOWN", "UP", "DOWN", "UP", "UP", "UP", "UP"]

var output_directory := ""
var records: Array = []
var failures := 0


func _init() -> void:
	var arguments: Array = OS.get_cmdline_user_args()
	arguments.append_array(OS.get_cmdline_args())
	for argument in arguments:
		if argument.begins_with("--evidence-dir="):
			output_directory = argument.trim_prefix("--evidence-dir=")
	call_deferred("_capture")


func _capture() -> void:
	if output_directory.is_empty() or not DirAccess.dir_exists_absolute(output_directory):
		printerr("TASK_0015R_CAPTURE_INVALID_EVIDENCE_DIRECTORY")
		quit(1)
		return
	root.size = Vector2i(960, 540)
	var gameplay = GameplayScene.instantiate()
	gameplay.configure_route_payload({
		"level_id": "two_echo_convergence",
		"level_path": "res://data/levels/two_echo_convergence.json",
		"hud_mode": "STANDARD_COMPACT",
		"classification": "standard",
		"development_direct": true,
		"final_level": true,
	})
	root.add_child(gameplay)
	await _frames()
	if not await _record("01_no_cue_control.png", gameplay, false, false):
		return

	for action in WITNESS.slice(0, 5):
		_send_action(gameplay, action)
	await _frames()
	if not await _record("02_stable_two_cell_spacing.png", gameplay, false, false):
		return

	for action in WITNESS.slice(5, 9):
		_send_action(gameplay, action)
	await _frames()
	if not await _record("03_signed_vector_change.png", gameplay, true, false):
		return

	for action in WITNESS.slice(9, 14):
		_send_action(gameplay, action)
	await _frames()
	if not await _record("04_overlap_spacing_collapse.png", gameplay, true, false):
		return

	_send_action(gameplay, WITNESS[14])
	await _frames()
	if not await _record("05_e2_blocked_e4_moved.png", gameplay, true, false):
		return

	_send_action(gameplay, WITNESS[15])
	await _frames()
	if not await _record("06_subsequent_spacing_expansion.png", gameplay, true, false):
		return

	_send_action(gameplay, WITNESS[16])
	await _frames()
	if not await _record("07_a_plus_b_stable_convergence.png", gameplay, false, false):
		return

	_send_restart(gameplay)
	await _frames()
	if not await _record("08_restart_cleared.png", gameplay, false, false):
		return

	gameplay.set_reduced_motion_for_test(true)
	for action in WITNESS.slice(0, 15):
		_send_action(gameplay, action)
	await _frames()
	if not await _record("09_reduced_motion_blocked_moved.png", gameplay, true, false):
		return
	if not await _record("10_grayscale_decision_frame.png", gameplay, true, true):
		return

	var snapshot_file := FileAccess.open(output_directory.path_join("presentation_snapshots.txt"), FileAccess.WRITE)
	if snapshot_file == null:
		printerr("TASK_0015R_CAPTURE_SNAPSHOT_WRITE_FAILED")
		quit(1)
		return
	snapshot_file.store_string(var_to_str(records))
	snapshot_file.close()
	gameplay.queue_free()
	await _frames()
	if failures > 0:
		printerr("TASK_0015R_VIEWPORT_CAPTURES_FAIL failures=%d" % failures)
		quit(1)
		return
	print("TASK_0015R_VIEWPORT_CAPTURES_PASS snapshots=10")
	quit(0)


func _record(filename: String, gameplay: Node, expect_visible: bool, grayscale: bool) -> bool:
	var snapshot: Dictionary = gameplay.get_presentation_snapshot()
	var divergence: Dictionary = snapshot.echo_divergence
	_expect(divergence.visible == expect_visible, filename + " has expected divergence visibility")
	_expect(snapshot.viewport == Rect2(0, 0, 960, 540), filename + " keeps exact 960x540 logical viewport")
	if divergence.visible:
		_expect(not divergence.headline.is_empty() and not divergence.detail.is_empty(), filename + " retains static causal text")
		_expect(not divergence.badge_rect.intersects(snapshot.board_rect), filename + " badge stays outside the board")
		for surface_name in snapshot.surfaces:
			var surface: Dictionary = snapshot.surfaces[surface_name]
			if String(surface_name).begins_with("help_") and not snapshot.help_open:
				continue
			if surface.visible:
				_expect(not divergence.badge_rect.intersects(surface.rect), filename + " badge avoids visible " + surface_name)
	records.append({
		"file": filename,
		"turn_index": gameplay.state.turn_index,
		"completed": gameplay.state.completed,
		"reduced_motion": snapshot.reduced_motion,
		"echo_divergence": divergence,
		"echoes": snapshot.echoes,
		"plates": snapshot.plates,
		"doors": snapshot.doors,
		"surfaces": snapshot.surfaces,
	})
	var image := root.get_texture().get_image()
	if grayscale:
		image.convert(Image.FORMAT_L8)
	var path := output_directory.path_join(filename)
	var error := image.save_png(path)
	if error != OK:
		printerr("TASK_0015R_CAPTURE_SAVE_FAILED path=%s error=%d" % [path, error])
		quit(1)
		return false
	print("CAPTURE_SAVED " + path)
	if failures > 0:
		printerr("TASK_0015R_CAPTURE_AUDIT_ABORT failures=%d" % failures)
		quit(1)
		return false
	return failures == 0


func _expect(condition: bool, label: String) -> void:
	if not condition:
		failures += 1
		printerr("CAPTURE_AUDIT_FAIL: " + label)


func _frames() -> void:
	await process_frame
	await process_frame


func _send_action(scene: Node, action: String) -> void:
	var input_actions := {"UP": "move_up", "RIGHT": "move_right", "DOWN": "move_down", "LEFT": "move_left", "WAIT": "wait_turn"}
	var event := InputEventAction.new()
	event.action = input_actions[action]
	event.pressed = true
	scene._unhandled_input(event)


func _send_restart(scene: Node) -> void:
	var event := InputEventAction.new()
	event.action = "restart_level"
	event.pressed = true
	scene._unhandled_input(event)

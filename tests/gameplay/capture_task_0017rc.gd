extends SceneTree

const AppRootScene = preload("res://scenes/app/app_root.tscn")
const GameplayScene = preload("res://scenes/vertical_slice/vertical_slice.tscn")
const BRIDGE_WITNESS := ["RIGHT", "RIGHT", "RIGHT", "UP", "UP", "UP", "LEFT", "RIGHT", "DOWN", "DOWN", "UP", "LEFT", "RIGHT", "UP", "UP", "UP"]
const PREFIX_LEVELS := [
	["tutorial_reach_exit", ["UP", "RIGHT", "RIGHT"]],
	["tutorial_echo_bridge", ["RIGHT", "RIGHT", "UP", "DOWN", "LEFT", "DOWN", "DOWN", "RIGHT", "RIGHT"]],
	["vertical_slice_delay_3", ["RIGHT", "RIGHT", "UP", "UP", "UP", "RIGHT", "RIGHT", "RIGHT", "RIGHT"]],
	["door_one_turn_late", ["RIGHT", "RIGHT", "UP", "UP", "RIGHT", "RIGHT", "RIGHT", "UP", "UP"]],
	["two_keys_one_door", ["RIGHT", "RIGHT", "RIGHT", "RIGHT", "UP", "UP", "RIGHT", "RIGHT", "UP", "UP", "LEFT", "LEFT"]],
	["staggered_doors", ["UP", "RIGHT", "RIGHT", "DOWN", "UP", "RIGHT", "RIGHT", "RIGHT", "RIGHT", "UP", "UP", "UP", "LEFT", "LEFT", "LEFT"]],
	["echo_spacing_bridge", BRIDGE_WITNESS],
]

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
		return _abort("invalid evidence directory")
	root.size = Vector2i(960, 540)

	var bridge = await _spawn("echo_spacing_bridge", "res://data/levels/echo_spacing_bridge.json", "STANDARD_COMPACT", false)
	var bridge_before := _state_record(bridge)
	if not await _save_gameplay("01_bridge_help_closed.png", bridge, false, false):
		return
	bridge.toggle_help()
	if not _audit_help(bridge, true, true):
		return _abort("bridge open Help audit failed")
	var bridge_open := _state_record(bridge)
	_expect(bridge_open == bridge_before, "bridge Help open preserves operational state")
	if not await _save_gameplay("02_bridge_help_open.png", bridge, true, false):
		return
	var help_body: String = bridge.get_hud_snapshot().help_body
	var static_copy: String = help_body.substr(help_body.find("SPACING ·"))
	bridge.toggle_help()
	for action in BRIDGE_WITNESS.slice(0, 9):
		_send_action(bridge, action)
	var progressed_before := _state_record(bridge)
	_expect(bridge.get_presentation_snapshot().echo_divergence.detail == "E2 BLOCKED · E4 MOVED", "real spacing event is present before Help")
	bridge.toggle_help()
	var progressed_body: String = bridge.get_hud_snapshot().help_body
	var progressed_contextual: String = progressed_body.substr(progressed_body.find("SPACING ·"))
	_expect(progressed_contextual == static_copy and _state_record(bridge) == progressed_before, "Help remains static and state preserving after spacing event")
	if not await _save_gameplay("03_bridge_help_after_blocked_moved.png", bridge, true, false):
		return
	bridge.queue_free()
	await _frames()

	var convergence = await _spawn("two_echo_convergence", "res://data/levels/two_echo_convergence.json", "STANDARD_COMPACT", true)
	convergence.toggle_help()
	if not _audit_help(convergence, true, false):
		return _abort("two_echo_convergence Help audit failed")
	if not await _save_gameplay("04_convergence_help_without_bridge_section.png", convergence, true, false):
		return
	convergence.queue_free()
	await _frames()

	var zero = await _spawn("tutorial_reach_exit", "res://data/levels/tutorial_reach_exit.json", "INTRO_MINIMAL", false)
	zero.toggle_help()
	if not _audit_help(zero, true, false):
		return _abort("zero-ECHO Help audit failed")
	if not await _save_gameplay("05_zero_echo_help_control.png", zero, true, false):
		return
	zero.queue_free()
	await _frames()

	var single = await _spawn("tutorial_echo_bridge", "res://data/levels/tutorial_echo_bridge.json", "GUIDED_ECHO", false)
	single.toggle_help()
	if not _audit_help(single, true, false):
		return _abort("single-ECHO Help audit failed")
	if not await _save_gameplay("06_single_echo_help_control.png", single, true, false):
		return
	single.queue_free()
	await _frames()

	var grayscale = await _spawn("echo_spacing_bridge", "res://data/levels/echo_spacing_bridge.json", "STANDARD_COMPACT", false)
	grayscale.toggle_help()
	if not await _save_gameplay("07_grayscale_bridge_help.png", grayscale, true, true):
		return
	grayscale.queue_free()
	await _frames()

	var reduced = await _spawn("echo_spacing_bridge", "res://data/levels/echo_spacing_bridge.json", "STANDARD_COMPACT", false)
	for action in BRIDGE_WITNESS.slice(0, 9):
		_send_action(reduced, action)
	reduced.set_reduced_motion_for_test(true)
	reduced.toggle_help()
	if not await _save_gameplay("08_reduced_motion_bridge_help_decision.png", reduced, true, false):
		return
	reduced.queue_free()
	await _frames()

	var app = AppRootScene.instantiate()
	root.add_child(app)
	await _frames()
	app.navigate("LEVEL_SELECT")
	await _frames()
	for spec in PREFIX_LEVELS:
		app.select_level(spec[0])
		await _frames()
		for action in spec[1]:
			_send_action(app.get_active_screen(), action)
		await _frames()
	var level_select = app.get_active_screen()
	var final_button: Button = level_select.get_node("OuterPanel/EntryScroll/LevelEntries/Level_two_echo_convergence")
	final_button.grab_focus()
	await _frames()
	var select_snapshot: Dictionary = level_select.get_screen_snapshot()
	_expect(select_snapshot.entries.size() == 8 and select_snapshot.entries[7].level_id == "two_echo_convergence" and select_snapshot.entries[7].unlocked, "sequence 8 remains reachable at Level Select bottom")
	records.append({"file": "09_level_select_sequence_8_reachable.png", "level_select": select_snapshot})
	if not await _save("09_level_select_sequence_8_reachable.png", false):
		return
	app.queue_free()
	await _frames()

	var ledger := FileAccess.open(output_directory.path_join("presentation_snapshots.txt"), FileAccess.WRITE)
	if ledger == null:
		return _abort("snapshot ledger could not be written")
	ledger.store_string(var_to_str(records))
	ledger.close()
	if failures > 0:
		return _abort("capture audit failures=%d" % failures)
	print("TASK_0017RC_VIEWPORT_CAPTURES_PASS captures=9")
	quit(0)


func _audit_help(scene: Node, expect_open: bool, expect_contextual: bool) -> bool:
	var hud: Dictionary = scene.get_hud_snapshot()
	var presentation: Dictionary = scene.get_presentation_snapshot()
	var body: Label = scene.get_node("Hud/HelpCard/Body")
	_expect(hud.help_expanded == expect_open and presentation.help_open == expect_open, "Help open state is consistent")
	_expect(hud.help_body.contains("SPACING ·") == expect_contextual, "contextual section has expected applicability")
	_expect(presentation.viewport == Rect2(0, 0, 960, 540) and presentation.help_rect == Rect2(96, 54, 768, 432), "Help retains exact 960x540 modal geometry")
	_expect(
		body.get_theme_font_size("font_size") >= 16 and body.get_minimum_size().y <= body.size.y,
		"Help body remains readable without vertical overflow (minimum=%s available=%s)" % [body.get_minimum_size(), body.size]
	)
	return failures == 0


func _state_record(scene: Node) -> Dictionary:
	return {
		"turn_index": scene.state.turn_index,
		"canonical_key": scene.get_hud_snapshot().canonical_key,
		"player_position": scene.state.player_position.duplicate(),
		"echo_positions": scene.state.echo_positions.duplicate(true),
		"door_states": scene.state.door_states.duplicate(true),
		"history": scene.state.history.duplicate(),
		"completed": scene.state.completed,
		"disclosure": scene.get_hud_snapshot().disclosure.duplicate(true),
	}


func _spawn(level_id: String, level_path: String, hud_mode: String, final_level: bool):
	var scene = GameplayScene.instantiate()
	if not scene.configure_route_payload({
		"level_id": level_id,
		"level_path": level_path,
		"hud_mode": hud_mode,
		"classification": "tutorial" if hud_mode != "STANDARD_COMPACT" else "standard",
		"development_direct": true,
		"final_level": final_level,
	}):
		_abort("route payload rejected: " + level_id)
		return null
	root.add_child(scene)
	await _frames()
	return scene


func _save_gameplay(filename: String, scene: Node, help_open: bool, grayscale: bool) -> bool:
	var snapshot: Dictionary = scene.get_presentation_snapshot()
	_expect(snapshot.help_open == help_open, filename + " has expected Help state")
	records.append({
		"file": filename,
		"turn": scene.state.turn_index,
		"state": _state_record(scene),
		"presentation": snapshot,
		"help_body": scene.get_hud_snapshot().help_body,
		"grayscale": grayscale,
	})
	return await _save(filename, grayscale)


func _save(filename: String, grayscale: bool) -> bool:
	await _frames()
	var image := root.get_texture().get_image()
	if grayscale:
		image.convert(Image.FORMAT_L8)
	var path := output_directory.path_join(filename)
	var error := image.save_png(path)
	if error != OK:
		return _abort("capture save failed: " + path)
	print("CAPTURE_SAVED " + path)
	return failures == 0


func _frames() -> void:
	await process_frame
	await process_frame


func _send_action(scene: Node, action: String) -> void:
	var event := InputEventAction.new()
	event.action = {"UP": "move_up", "RIGHT": "move_right", "DOWN": "move_down", "LEFT": "move_left", "WAIT": "wait_turn"}[action]
	event.pressed = true
	scene._unhandled_input(event)


func _expect(condition: bool, label: String) -> void:
	if not condition:
		failures += 1
		printerr("CAPTURE_AUDIT_FAIL: " + label)


func _abort(message: String) -> bool:
	printerr("TASK_0017RC_CAPTURE_FAIL " + message)
	quit(1)
	return false

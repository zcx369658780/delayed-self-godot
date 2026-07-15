extends SceneTree

const GameplayScene = preload("res://scenes/vertical_slice/vertical_slice.tscn")

var failures := 0


func _init() -> void:
	call_deferred("_run")


func _run() -> void:
	await _test_board_geometry()
	await _test_contextual_timeline()
	await _test_all_formal_layouts()
	await _test_modal_help_blocks_gameplay()
	await _test_level_four_feedback_trace()
	await _test_level_five_dependency_and_rapid_input()
	await _test_reduced_motion_feedback()
	if failures > 0:
		printerr("TASK_0011_PRESENTATION_RECOVERY_FOCUSED_FAIL failures=%d" % failures)
		quit(1)
	else:
		print("TASK_0011_PRESENTATION_RECOVERY_FOCUSED_PASS")
		quit(0)


func _test_board_geometry() -> void:
	var scene = GameplayScene.instantiate()
	var configured: bool = scene.configure_route_payload({
		"level_id": "tutorial_reach_exit",
		"level_path": "res://data/levels/tutorial_reach_exit.json",
		"hud_mode": "INTRO_MINIMAL",
		"classification": "tutorial",
		"development_direct": true,
		"final_level": false,
	})
	_require(configured, "geometry tracer configures reusable Gameplay")
	root.add_child(scene)
	await process_frame
	_require(scene.has_method("get_presentation_snapshot"), "Gameplay exposes a public presentation snapshot")
	if scene.has_method("get_presentation_snapshot"):
		var snapshot: Dictionary = scene.get_presentation_snapshot()
		_require(snapshot.cell_pitch == 60, "presentation pitch is 60 px")
		_require(snapshot.board_zone == Rect2(24, 84, 540, 420), "accepted board zone is exact")
		_require(snapshot.board_rect.size == Vector2(300, 240), "Tutorial 0 uses its formal 5x4 board footprint")
		_require(snapshot.board_rect.position == Vector2(144, 174), "Tutorial 0 board is deterministically centered")
	scene.queue_free()
	await process_frame


func _test_contextual_timeline() -> void:
	var scene = GameplayScene.instantiate()
	_require(scene.has_method("timeline_visible_for"), "Gameplay exposes deterministic contextual Timeline visibility")
	if not scene.has_method("timeline_visible_for"):
		scene.free()
		return
	var base := {"echoes": [{"id": "echo_a", "delay": 3, "spawn": [1, 1]}]}
	_require(not scene.timeline_visible_for({"echoes": []}, "INTRO_MINIMAL", false), "Tutorial 0 never shows Timeline")
	_require(scene.timeline_visible_for(base, "GUIDED_ECHO", false), "guided Echo keeps Timeline visible while incomplete")
	_require(not scene.timeline_visible_for(base, "GUIDED_ECHO", true), "completed guided level hides Timeline")
	_require(not scene.timeline_visible_for(base, "STANDARD_COMPACT", false), "simple standard level hides Timeline")
	var multiple_echoes := {"echoes": [{"id": "echo_a", "delay": 3}, {"id": "echo_b", "delay": 3}]}
	var distinct_delays := {"echoes": [{"id": "echo_a", "delay": 2}, {"id": "echo_b", "delay": 3}]}
	var delay_four := {"echoes": [{"id": "echo_a", "delay": 4}]}
	_require(scene.timeline_visible_for(multiple_echoes, "STANDARD_COMPACT", false), "multiple Echoes trigger standard Timeline")
	_require(scene.timeline_visible_for(distinct_delays, "STANDARD_COMPACT", false), "distinct delays trigger standard Timeline")
	_require(scene.timeline_visible_for(delay_four, "STANDARD_COMPACT", false), "delay four triggers standard Timeline")
	scene.free()


func _test_all_formal_layouts() -> void:
	var cases := [
		["tutorial_reach_exit", "res://data/levels/tutorial_reach_exit.json", "INTRO_MINIMAL"],
		["tutorial_echo_bridge", "res://data/levels/tutorial_echo_bridge.json", "GUIDED_ECHO"],
		["vertical_slice_delay_3", "res://data/levels/vertical_slice_delay_3.json", "STANDARD_COMPACT"],
		["door_one_turn_late", "res://data/levels/door_one_turn_late.json", "STANDARD_COMPACT"],
		["two_keys_one_door", "res://data/levels/two_keys_one_door.json", "STANDARD_COMPACT"],
	]
	for item in cases:
		var scene = GameplayScene.instantiate()
		scene.configure_route_payload({"level_id": item[0], "level_path": item[1], "hud_mode": item[2], "classification": "tutorial" if item[0].begins_with("tutorial_") else "standard", "development_direct": true, "final_level": item[0] == "two_keys_one_door"})
		root.add_child(scene)
		await process_frame
		var snapshot: Dictionary = scene.get_presentation_snapshot()
		_require(snapshot.board_zone.encloses(snapshot.board_rect), "%s formal grid fits the accepted board zone" % item[0])
		if item[2] == "STANDARD_COMPACT":
			_require(not snapshot.timeline_visible and not snapshot.surfaces.timeline.visible, "%s simple standard Timeline is hidden" % item[0])
		for surface_name in ["status", "objective", "legend", "timeline", "controls"]:
			var surface: Dictionary = snapshot.surfaces[surface_name]
			_require(not surface.visible or not surface.rect.intersects(snapshot.board_rect), "%s %s does not overlap the board" % [item[0], surface_name])
		for surface_name in snapshot.surfaces:
			var rect: Rect2 = snapshot.surfaces[surface_name].rect
			_require(Rect2(0, 0, 960, 540).encloses(rect), "%s %s stays inside 960x540" % [item[0], surface_name])
		_require(snapshot.surfaces.legend.font_size >= 16 and snapshot.surfaces.timeline.font_size >= 16 and snapshot.surfaces.controls.font_size >= 16, "%s secondary text meets 16 px" % item[0])
		_require(snapshot.surfaces.objective.font_size >= 18 and snapshot.surfaces.help_body.font_size >= 18, "%s body text meets 18 px" % item[0])
		_require(snapshot.surfaces.status.font_size >= 22 and snapshot.surfaces.help_title.font_size >= 22, "%s important text meets 22 px" % item[0])
		scene.queue_free()
		await process_frame


func _test_modal_help_blocks_gameplay() -> void:
	var scene = GameplayScene.instantiate()
	scene.configure_route_payload({
		"level_id": "tutorial_echo_bridge",
		"level_path": "res://data/levels/tutorial_echo_bridge.json",
		"hud_mode": "GUIDED_ECHO",
		"classification": "tutorial",
		"development_direct": true,
		"final_level": false,
	})
	var back_requests := 0
	scene.request_back.connect(func(): back_requests += 1)
	root.add_child(scene)
	await process_frame
	_send_key(scene, KEY_H)
	var state_before: Dictionary = scene.state.duplicate(true)
	var key_before: String = scene.get_hud_snapshot().canonical_key
	_send_action(scene, "move_right")
	_require(scene.state == state_before, "open Help blocks movement")
	_send_action(scene, "wait_turn")
	_require(scene.state == state_before, "open Help blocks WAIT")
	_send_action(scene, "restart_level")
	_require(scene.state == state_before and scene.get_hud_snapshot().canonical_key == key_before, "open Help blocks restart and preserves canonical key")
	_send_action(scene, "ui_cancel")
	_require(not scene.get_hud_snapshot().help_expanded and back_requests == 0, "Esc closes Help before Back")
	_send_action(scene, "move_right")
	_require(scene.state.turn_index == state_before.turn_index + 1, "gameplay focus/input returns after Help closes")
	scene.queue_free()
	await process_frame


func _test_level_four_feedback_trace() -> void:
	var scene = GameplayScene.instantiate()
	scene.configure_route_payload({
		"level_id": "door_one_turn_late",
		"level_path": "res://data/levels/door_one_turn_late.json",
		"hud_mode": "STANDARD_COMPACT",
		"classification": "standard",
		"development_direct": true,
		"final_level": false,
	})
	root.add_child(scene)
	await process_frame
	for action in ["move_right", "move_right", "move_up", "move_up", "move_up"]:
		_send_action(scene, action)
	var snapshot: Dictionary = scene.get_presentation_snapshot()
	_require(snapshot.blocked_door.visible and snapshot.blocked_door.door_id == "door_timing", "Level 4 critical commit exposes blocked-Door stop feedback")
	_require(snapshot.echo_trails.size() == 1 and snapshot.echo_trails[0].echo_id == "echo_delay_2", "Level 4 critical commit exposes accepted ECHO replay trail")
	_require(snapshot.plates[0].visual_state == "FILLED_PRESSED", "Level 4 critical commit exposes pressed Plate")
	_require(snapshot.doors[0].visual_state == "HOLLOW_OPEN" and snapshot.doors[0].dependency_pips[0].active, "Level 4 critical commit exposes open Door and active dependency")
	_require(snapshot.teaching_badge.visible and snapshot.teaching_badge.text == "OPEN · NEXT INPUT" and snapshot.teaching_badge.duration_seconds == 1.25, "Level 4 first open commit exposes the bounded teaching badge")
	var turn_before: int = scene.state.turn_index
	_send_key(scene, KEY_H)
	_require(scene.get_presentation_snapshot().help_open and not scene.get_presentation_snapshot().teaching_badge.visible, "Help toggle clears the transient badge")
	_send_action(scene, "move_right")
	_require(scene.state.turn_index == turn_before, "Help remains modal during Level 4 teaching feedback")
	_send_key(scene, KEY_H)
	_send_action(scene, "move_right")
	var next_snapshot: Dictionary = scene.get_presentation_snapshot()
	_require(scene.state.turn_index == turn_before + 1 and scene.state.player_position == [4, 3], "next input uses the already-open logical Door snapshot exactly once")
	_require(not next_snapshot.teaching_badge.visible, "next gameplay input clears the teaching badge")
	scene.queue_free()
	await process_frame


func _test_level_five_dependency_and_rapid_input() -> void:
	var scene = GameplayScene.instantiate()
	scene.configure_route_payload({
		"level_id": "two_keys_one_door",
		"level_path": "res://data/levels/two_keys_one_door.json",
		"hud_mode": "STANDARD_COMPACT",
		"classification": "standard",
		"development_direct": true,
		"final_level": true,
	})
	root.add_child(scene)
	await process_frame
	for action in ["move_right", "move_right", "move_right", "move_right", "move_up", "move_up", "move_right"]:
		_send_action(scene, action)
	var snapshot: Dictionary = scene.get_presentation_snapshot()
	var pips: Array = snapshot.doors[0].dependency_pips
	_require(snapshot.doors[0].visual_state == "HOLLOW_OPEN", "Level 5 accepted AND state renders an open aperture")
	_require(pips.size() == 2 and pips[0].plate_id == "plate_echo" and pips[1].plate_id == "plate_you", "Level 5 dependency pips use stable Plate-ID order")
	_require(pips.all(func(pip: Dictionary): return pip.active), "Level 5 AND-open state fills both dependency pips")
	_send_action(scene, "restart_level")
	var rapid_actions := ["move_right", "move_right", "move_right", "move_right", "move_up", "move_up", "move_right", "move_right", "move_up", "move_up", "move_left", "move_left"]
	for action in rapid_actions:
		_send_action(scene, action)
	var expected: Dictionary = scene.simulation.replay(scene.level, ["RIGHT", "RIGHT", "RIGHT", "RIGHT", "UP", "UP", "RIGHT", "RIGHT", "UP", "UP", "LEFT", "LEFT"])
	_require(expected.ok and scene.state == expected.state and scene.state.completed, "Approach A rapid input preserves exact accepted action count order and result")
	scene.queue_free()
	await process_frame


func _test_reduced_motion_feedback() -> void:
	var scene = GameplayScene.instantiate()
	scene.configure_route_payload({
		"level_id": "door_one_turn_late",
		"level_path": "res://data/levels/door_one_turn_late.json",
		"hud_mode": "STANDARD_COMPACT",
		"classification": "standard",
		"development_direct": true,
		"final_level": false,
	})
	root.add_child(scene)
	await process_frame
	scene.set_reduced_motion_for_test(true)
	for action in ["move_right", "move_right", "move_up", "move_up", "move_up"]:
		_send_action(scene, action)
	var snapshot: Dictionary = scene.get_presentation_snapshot()
	_require(snapshot.reduced_motion and snapshot.echo_trails[0].visual_state == "STATIC_SEGMENTS", "reduced motion uses static ECHO replay segments")
	_require(snapshot.doors[0].visual_state == "HOLLOW_OPEN" and snapshot.teaching_badge.visible, "reduced motion preserves Door shape and teaching badge meaning")
	scene.queue_free()
	await process_frame


func _send_action(scene: Node, action: String) -> void:
	var event := InputEventAction.new()
	event.action = action
	event.pressed = true
	scene._unhandled_input(event)


func _send_key(scene: Node, keycode: Key) -> void:
	var event := InputEventKey.new()
	event.keycode = keycode
	event.pressed = true
	scene._unhandled_input(event)


func _require(condition: bool, label: String) -> void:
	if not condition:
		failures += 1
		printerr("TASK_0011_FAIL: " + label)

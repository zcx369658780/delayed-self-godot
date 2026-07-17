extends Node2D

signal gameplay_completed(level_id: String, turns: int)
signal request_back

const LevelLoader = preload("res://scripts/simulation/level_loader.gd")
const Simulation = preload("res://scripts/simulation/simulation.gd")
const TimelineModel = preload("res://scripts/gameplay/timeline_model.gd")
const LEVEL_PATH := "res://data/levels/vertical_slice_delay_3.json"
const HUD_MODES := ["INTRO_MINIMAL", "GUIDED_ECHO", "STANDARD_COMPACT"]
const CELL := 60.0
const CELL_GAP := 3.0
const BOARD_ZONE := Rect2(24, 84, 540, 420)
const RIGHT_RAIL := Rect2(600, 84, 336, 420)
const GOAL_STRIP := Rect2(24, 18, 912, 46)
const HELP_RECT := Rect2(96, 54, 768, 432)

var level: Dictionary = {}
var state: Dictionary = {}
var load_error := ""
var simulation := Simulation.new()
var timeline_model := TimelineModel.new()
var configured_level_id := "vertical_slice_delay_3"
var configured_level_path := LEVEL_PATH
var route_payload: Dictionary = {}
var hosted_by_app := false
var help_expanded := false
var reduced_motion := false
var teaching_badge_consumed := false
var visual_feedback := {
	"echo_trails": [],
	"blocked_door": {"visible": false},
	"teaching_badge": {"visible": false},
}
var disclosure := {
	"controls_collapsed": false,
	"legend_collapsed": false,
	"causality_collapsed": false,
	"objective_collapsed": false,
}

@onready var status_label: Label = $Hud/Status
@onready var objective_label: Label = $Hud/Objective
@onready var legend_label: Label = $Hud/Legend
@onready var timeline_label: Label = $Hud/Timeline
@onready var echo_next_label: Label = $Hud/EchoNext
@onready var history_label: Label = $Hud/History
@onready var completion_label: Label = $Hud/Completion
@onready var help_card: ColorRect = $Hud/HelpCard
@onready var help_title: Label = $Hud/HelpCard/Title
@onready var help_body: Label = $Hud/HelpCard/Body
@onready var feedback_timer: Timer = $FeedbackTimer


func _ready() -> void:
	feedback_timer.timeout.connect(_on_feedback_timeout)
	var loaded := LevelLoader.new().load_file(configured_level_path)
	if not loaded.ok:
		load_error = "INVALID_LEVEL: " + _codes(loaded.errors)
		printerr(load_error)
	elif loaded.level.level_id != configured_level_id:
		load_error = "LEVEL_ID_MISMATCH"
		printerr(load_error)
	else:
		level = loaded.level
		state = simulation.construct_initial_state(level)
	_update_hud()
	queue_redraw()


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		if help_expanded:
			help_expanded = false
			_clear_teaching_badge()
			_update_hud()
			queue_redraw()
			return
		if hosted_by_app:
			request_back.emit()
		else:
			get_tree().quit()
		return
	if _is_help_toggle(event) and load_error == "":
		help_expanded = not help_expanded
		_clear_teaching_badge()
		_update_hud()
		queue_redraw()
		return
	if load_error != "" or event.is_echo():
		return
	if help_expanded:
		return
	if event.is_action_pressed("restart_level"):
		state = simulation.construct_initial_state(level)
		_reset_visual_feedback()
		_update_hud()
		queue_redraw()
		return
	var action := ""
	if event.is_action_pressed("move_up"):
		action = "UP"
	elif event.is_action_pressed("move_right"):
		action = "RIGHT"
	elif event.is_action_pressed("move_down"):
		action = "DOWN"
	elif event.is_action_pressed("move_left"):
		action = "LEFT"
	elif event.is_action_pressed("wait_turn"):
		action = "WAIT"
	if action != "" and not state.completed:
		var before: Dictionary = state.duplicate(true)
		var was_completed: bool = state.completed
		var result := simulation.transition(level, state, action)
		if result.ok:
			state = result.state
			_update_visual_feedback(before, result, action)
			_update_disclosure(before, result)
			if not was_completed and state.completed and hosted_by_app:
				gameplay_completed.emit(configured_level_id, state.turn_index - 1)
		else:
			printerr(result.status)
		_update_hud()
		queue_redraw()


func is_runtime_ready() -> bool:
	return load_error == "" and not level.is_empty() and not state.is_empty() and status_label != null and objective_label != null and legend_label != null and timeline_label != null and echo_next_label != null and history_label != null and completion_label != null and help_card != null and help_body != null


func configure_route_payload(payload: Dictionary) -> bool:
	if is_inside_tree() or not payload.get("level_id") is String or not payload.get("level_path") is String or not payload.get("hud_mode") is String:
		return false
	if not payload.level_path.begins_with("res://data/levels/") or not payload.level_path.ends_with(".json") or not HUD_MODES.has(payload.hud_mode):
		return false
	configured_level_id = payload.level_id
	configured_level_path = payload.level_path
	route_payload = payload.duplicate(true)
	hosted_by_app = true
	return true


func get_route_payload() -> Dictionary:
	return route_payload.duplicate(true)


func get_hud_snapshot() -> Dictionary:
	return {
		"status": status_label.text,
		"objective": objective_label.text,
		"legend": legend_label.text,
		"timeline": timeline_label.text,
		"timeline_model": get_timeline_snapshot(),
		"echo_next": echo_next_label.text if echo_next_label.visible else "",
		"history": history_label.text,
		"completion": completion_label.text if completion_label.visible else "",
		"help_expanded": help_expanded,
		"disclosure": disclosure.duplicate(true),
		"turn_index": state.get("turn_index", 0),
		"canonical_key": simulation.canonical_key(state) if not state.is_empty() else "",
	}


func get_timeline_snapshot() -> Dictionary:
	return timeline_model.build(level, state, simulation) if not level.is_empty() and not state.is_empty() else {"visible": false, "max_delay": 0, "slots": [], "echo_pointers": []}


func get_presentation_snapshot() -> Dictionary:
	return {
		"viewport": Rect2(0, 0, 960, 540),
		"cell_pitch": CELL,
		"board_zone": BOARD_ZONE,
		"board_rect": _board_rect(),
		"right_rail": RIGHT_RAIL,
		"goal_strip": GOAL_STRIP,
		"help_rect": HELP_RECT,
		"timeline_visible": timeline_visible_for(level, _hud_mode(), state.get("completed", false)) if not level.is_empty() else false,
		"help_open": help_expanded,
		"reduced_motion": reduced_motion,
		"surfaces": _surface_snapshots(),
		"plates": _plate_snapshots(),
		"doors": _door_snapshots(),
		"echoes": _echo_snapshots(),
		"echo_trails": visual_feedback.echo_trails.duplicate(true),
		"blocked_door": visual_feedback.blocked_door.duplicate(true),
		"teaching_badge": visual_feedback.teaching_badge.duplicate(true),
	}


func set_reduced_motion_for_test(enabled: bool) -> void:
	reduced_motion = enabled
	queue_redraw()


func _surface_snapshots() -> Dictionary:
	return {
		"status": _control_snapshot(status_label),
		"objective": _control_snapshot(objective_label),
		"legend": _control_snapshot(legend_label),
		"timeline": _control_snapshot(timeline_label),
		"controls": _control_snapshot(history_label),
		"completion": _control_snapshot(completion_label),
		"help": _control_snapshot(help_card),
		"help_title": _control_snapshot(help_title),
		"help_body": _control_snapshot(help_body),
	}


func _control_snapshot(control: Control) -> Dictionary:
	return {
		"rect": control.get_global_rect(),
		"visible": control.visible,
		"font_size": control.get_theme_font_size("font_size") if control is Label else 0,
		"text": control.text if control is Label else "",
	}


func _plate_snapshots() -> Array:
	if level.is_empty() or state.is_empty():
		return []
	var pressed: Array = simulation.pressed_plate_ids(level, state)
	var snapshots: Array = []
	for plate in level.get("plates", []):
		var snapshot := {
			"id": plate.id,
			"position": plate.position.duplicate(),
			"center": _center(plate.position),
			"pressed": pressed.has(plate.id),
			"visual_state": "FILLED_PRESSED" if pressed.has(plate.id) else "HOLLOW_UNPRESSED",
		}
		if _uses_convergence_cues():
			snapshot.merge(_dependency_identity(plate.id))
		snapshots.append(snapshot)
	snapshots.sort_custom(func(a: Dictionary, b: Dictionary): return a.id < b.id)
	return snapshots


func _door_snapshots() -> Array:
	if level.is_empty() or state.is_empty():
		return []
	var pressed: Array = simulation.pressed_plate_ids(level, state)
	var snapshots: Array = []
	for door in level.get("doors", []):
		var dependency_ids: Array = door.all_plate_ids.duplicate()
		dependency_ids.sort()
		var pips: Array = []
		for plate_id in dependency_ids:
			var pip := {"plate_id": plate_id, "active": pressed.has(plate_id)}
			if _uses_convergence_cues():
				pip.merge(_dependency_identity(plate_id))
			pips.append(pip)
		var open := _door_open(door.id)
		var occupied_by := PackedStringArray()
		if state.player_position == door.position:
			occupied_by.append("YOU")
		for echo in state.echo_positions:
			if echo.position == door.position:
				occupied_by.append(echo.id)
		var snapshot := {
			"id": door.id,
			"position": door.position.duplicate(),
			"center": _center(door.position),
			"open": open,
			"visual_state": "HOLLOW_OPEN" if open else "BARS_CLOSED",
			"state_label": "OPEN" if open else "CLOSED",
			"dependency_pips": pips,
			"occupied_by": Array(occupied_by),
			"actor_identity_visible": true,
		}
		if _uses_convergence_cues():
			snapshot["dependency_expression"] = " + ".join(dependency_ids.map(func(plate_id): return _dependency_identity(plate_id).label))
		snapshots.append(snapshot)
	snapshots.sort_custom(func(a: Dictionary, b: Dictionary): return a.id < b.id)
	return snapshots


func _echo_snapshots() -> Array:
	if level.is_empty() or state.is_empty():
		return []
	var snapshots: Array = []
	for echo_state in state.echo_positions:
		var definition := _echo_definition_by_id(echo_state.id)
		var overlap_count: int = state.echo_positions.filter(func(other): return other.position == echo_state.position).size()
		snapshots.append({
			"id": echo_state.id,
			"position": echo_state.position.duplicate(),
			"center": _center(echo_state.position),
			"delay": int(definition.get("delay", 0)),
			"badge": "E%d" % int(definition.get("delay", 0)),
			"outline_style": "SOLID" if int(definition.get("delay", 0)) == 2 else "DOUBLE_DASHED",
			"overlap_count": overlap_count,
			"overlap_readable": overlap_count <= 1 or _uses_convergence_cues(),
		})
	return snapshots


func _uses_convergence_cues() -> bool:
	if level.get("echoes", []).size() < 2:
		return false
	return level.get("doors", []).any(func(door): return door.get("all_plate_ids", []).size() >= 2)


func _dependency_identity(plate_id: String) -> Dictionary:
	var ids: Array = level.get("plates", []).map(func(plate): return plate.id)
	ids.sort()
	var index := ids.find(plate_id)
	var labels := ["A", "B"]
	return {"label": labels[index] if index >= 0 and index < labels.size() else "?", "shape": "TRIANGLE" if index == 0 else "CIRCLE"}


func timeline_visible_for(level_facts: Dictionary, hud_mode: String, completed: bool) -> bool:
	if completed or hud_mode == "INTRO_MINIMAL":
		return false
	var echoes: Array = level_facts.get("echoes", [])
	if echoes.is_empty():
		return false
	if hud_mode == "GUIDED_ECHO":
		return true
	if hud_mode != "STANDARD_COMPACT":
		return false
	var delays := {}
	var max_delay := 0
	for echo in echoes:
		var delay := int(echo.get("delay", 0))
		delays[delay] = true
		max_delay = maxi(max_delay, delay)
	return echoes.size() > 1 or delays.size() > 1 or max_delay >= 4


func toggle_help() -> void:
	if load_error == "":
		help_expanded = not help_expanded
		_clear_teaching_badge()
		_update_hud()
		queue_redraw()


func _draw() -> void:
	draw_rect(Rect2(Vector2.ZERO, Vector2(960, 540)), Color("111827"))
	if load_error != "":
		return
	for y in level.terrain_rows.size():
		for x in level.terrain_rows[y].length():
			var rectangle := Rect2(_board_origin() + Vector2(x, y) * CELL, Vector2(CELL - CELL_GAP, CELL - CELL_GAP))
			draw_rect(rectangle, Color("263449") if level.terrain_rows[y][x] == "." else Color("0a0f1a"))
	var pressed_plate_ids: Array = simulation.pressed_plate_ids(level, state)
	for door in level.doors:
		var dependency_ids: Array = door.all_plate_ids.duplicate()
		dependency_ids.sort()
		for plate_id in dependency_ids:
			var plate := _plate_by_id(plate_id)
			if not plate.is_empty():
				var active: bool = pressed_plate_ids.has(plate_id)
				draw_dashed_line(_center(plate.position), _center(door.position), Color("fbbf24", 0.78) if active else Color("64748b", 0.46), 3.0 if active else 1.5, 8.0)
	for plate in level.plates:
		var active: bool = pressed_plate_ids.has(plate.id)
		var plate_center := _center(plate.position)
		if _uses_convergence_cues() and _dependency_identity(plate.id).shape == "TRIANGLE":
			_draw_triangle_token(plate_center, active)
		else:
			draw_circle(plate_center, 18, Color("3f3215"))
			if active:
				draw_circle(plate_center, 12, Color("fbbf24"))
				draw_arc(plate_center, 22, 0, TAU, 32, Color("fde68a"), 3)
			else:
				draw_circle(plate_center, 11, Color("111827"))
				draw_arc(plate_center, 15, 0, TAU, 32, Color("d6a928"), 3)
		if _uses_convergence_cues():
			draw_string(ThemeDB.fallback_font, plate_center + Vector2(-5, 5), _dependency_identity(plate.id).label, HORIZONTAL_ALIGNMENT_LEFT, -1, 14, Color("fff7d6"))
	for door in level.doors:
		var open: bool = _door_open(door.id)
		var door_center := _center(door.position)
		var rect := Rect2(door_center - Vector2(22, 25), Vector2(44, 50))
		if open:
			draw_line(rect.position, rect.position + Vector2(0, rect.size.y), Color("a7f3d0"), 4)
			draw_line(rect.end - Vector2(0, rect.size.y), rect.end, Color("a7f3d0"), 4)
			draw_line(rect.position, rect.position + Vector2(12, 0), Color("6ee7b7"), 3)
			draw_line(rect.end - Vector2(12, 0), rect.end, Color("6ee7b7"), 3)
		else:
			draw_rect(rect, Color("7f1d1d", 0.92))
			draw_rect(rect, Color("fecaca"), false, 3)
			for offset in [-12.0, 0.0, 12.0]:
				draw_line(door_center + Vector2(offset, -21), door_center + Vector2(offset, 21), Color("fee2e2"), 4)
		_draw_dependency_pips(door, door_center, pressed_plate_ids)
	_draw_echo_feedback()
	var exit_position: Vector2 = _center(level.exit.position)
	_draw_exit_base(exit_position)
	for echo in state.echo_positions:
		var echo_center := _center(echo.position)
		draw_circle(echo_center, 16, Color("a78bfa", 0.72))
		var definition := _echo_definition_by_id(echo.id)
		if _uses_convergence_cues() and int(definition.delay) == 4:
			_draw_dashed_arc(echo_center, 20, Color("ddd6fe"), 2)
			_draw_dashed_arc(echo_center, 24, Color("c4b5fd"), 2)
		else:
			draw_arc(echo_center, 20, 0, TAU, 24, Color("ddd6fe"), 2)
		if _uses_convergence_cues():
			var badge_offset := Vector2(5, -20) if int(definition.delay) == 4 else Vector2(-25, -20)
			draw_string(ThemeDB.fallback_font, echo_center + badge_offset, "E%d" % int(definition.delay), HORIZONTAL_ALIGNMENT_LEFT, -1, 13, Color("f5f3ff"))
		else:
			var echo_letter_center := echo_center + Vector2(10, -8) if echo.position == state.player_position else echo_center
			_draw_actor_letter(echo_letter_center, "E", Color("f5f3ff"))
	draw_circle(_center(state.player_position), 15, Color("f8fafc"))
	draw_circle(_center(state.player_position), 7, Color("22d3ee"))
	_draw_actor_letter(_center(state.player_position), "Y", Color("082f49"))
	_draw_exit_overlay(exit_position)
	_draw_blocked_door_feedback()
	_draw_teaching_badge()


func _draw_dependency_pips(door: Dictionary, door_center: Vector2, pressed: Array) -> void:
	var dependency_ids: Array = door.all_plate_ids.duplicate()
	dependency_ids.sort()
	var start_x := door_center.x - float(dependency_ids.size() - 1) * 8.0
	for index in dependency_ids.size():
		var center := Vector2(start_x + index * 16.0, door_center.y + 34)
		var identity := _dependency_identity(dependency_ids[index]) if _uses_convergence_cues() else {}
		if _uses_convergence_cues() and identity.shape == "TRIANGLE":
			_draw_triangle_pip(center, pressed.has(dependency_ids[index]))
		elif pressed.has(dependency_ids[index]):
			draw_circle(center, 6, Color("fbbf24"))
			draw_arc(center, 8, 0, TAU, 20, Color("fef3c7"), 2)
		else:
			draw_circle(center, 5, Color("111827"))
			draw_arc(center, 7, 0, TAU, 20, Color("fbbf24"), 2)
		if _uses_convergence_cues():
			draw_string(ThemeDB.fallback_font, center + Vector2(-4, 4), identity.label, HORIZONTAL_ALIGNMENT_LEFT, -1, 10, Color("fff7d6"))
	if _uses_convergence_cues():
		draw_string(ThemeDB.fallback_font, door_center + Vector2(27, 5), "A+B", HORIZONTAL_ALIGNMENT_LEFT, -1, 13, Color("fff7d6"))


func _draw_triangle_token(center: Vector2, active: bool) -> void:
	var points := PackedVector2Array([center + Vector2(0, -18), center + Vector2(18, 14), center + Vector2(-18, 14)])
	draw_colored_polygon(points, Color("fbbf24") if active else Color("111827"))
	draw_polyline(PackedVector2Array([points[0], points[1], points[2], points[0]]), Color("fde68a") if active else Color("d6a928"), 3)


func _draw_triangle_pip(center: Vector2, active: bool) -> void:
	var points := PackedVector2Array([center + Vector2(0, -7), center + Vector2(7, 6), center + Vector2(-7, 6)])
	draw_colored_polygon(points, Color("fbbf24") if active else Color("111827"))
	draw_polyline(PackedVector2Array([points[0], points[1], points[2], points[0]]), Color("fef3c7") if active else Color("fbbf24"), 2)


func _draw_dashed_arc(center: Vector2, radius: float, color: Color, width: float) -> void:
	for index in 12:
		var start := float(index) * TAU / 12.0
		draw_arc(center, radius, start, start + TAU / 24.0, 4, color, width)


func _draw_echo_feedback() -> void:
	for trail in visual_feedback.echo_trails:
		var from := _center(trail.from)
		var to := _center(trail.to)
		if reduced_motion:
			draw_line(from, to, Color("c4b5fd", 0.76), 2)
		else:
			draw_dashed_line(from, to, Color("c4b5fd", 0.82), 3, 7)
		draw_circle(to, 7, Color("7c3aed", 0.88))
		draw_string(ThemeDB.fallback_font, to + Vector2(-6, -22), "↻", HORIZONTAL_ALIGNMENT_CENTER, 14, 16, Color("ede9fe"))


func _draw_blocked_door_feedback() -> void:
	if not visual_feedback.blocked_door.get("visible", false):
		return
	var center := _center(visual_feedback.blocked_door.position)
	draw_line(center + Vector2(-11, -11), center + Vector2(11, 11), Color("fff7ed"), 5)
	draw_line(center + Vector2(-11, 11), center + Vector2(11, -11), Color("fff7ed"), 5)


func _draw_teaching_badge() -> void:
	if not visual_feedback.teaching_badge.get("visible", false):
		return
	var door := _door_by_id(visual_feedback.teaching_badge.door_id)
	if door.is_empty():
		return
	var center := _center(door.position)
	var badge := Rect2(center + Vector2(-100, -57), Vector2(200, 25))
	draw_rect(badge, Color("052e2b", 0.96))
	draw_rect(badge, Color("a7f3d0"), false, 2)
	draw_string(ThemeDB.fallback_font, badge.position + Vector2(8, 18), visual_feedback.teaching_badge.text, HORIZONTAL_ALIGNMENT_CENTER, 184, 16, Color("ecfdf5"))


func _draw_exit_base(center: Vector2) -> void:
	var diamond := PackedVector2Array([center + Vector2(0, -22), center + Vector2(22, 0), center + Vector2(0, 22), center + Vector2(-22, 0)])
	draw_colored_polygon(diamond, Color("2563eb", 0.22))
	for index in diamond.size():
		draw_line(diamond[index], diamond[(index + 1) % diamond.size()], Color("60a5fa"), 3)


func _draw_exit_overlay(center: Vector2) -> void:
	var outer := PackedVector2Array([center + Vector2(0, -27), center + Vector2(27, 0), center + Vector2(0, 27), center + Vector2(-27, 0)])
	for index in outer.size():
		draw_line(outer[index], outer[(index + 1) % outer.size()], Color("bfdbfe"), 3)
	draw_string(ThemeDB.fallback_font, center + Vector2(-23, -31), "EXIT", HORIZONTAL_ALIGNMENT_CENTER, 46, 14, Color("dbeafe"))


func _draw_actor_letter(center: Vector2, letter: String, color: Color) -> void:
	draw_string(ThemeDB.fallback_font, center + Vector2(-10, 6), letter, HORIZONTAL_ALIGNMENT_CENTER, 20, 15, color)


func _update_hud() -> void:
	if load_error != "":
		status_label.text = "Level load failed\n" + load_error
		objective_label.text = ""
		legend_label.text = ""
		timeline_label.text = ""
		echo_next_label.text = ""
		history_label.text = ""
		completion_label.visible = false
		help_card.visible = false
		return
	var hud_mode: String = route_payload.get("hud_mode", "STANDARD_COMPACT")
	match hud_mode:
		"INTRO_MINIMAL":
			_update_intro_hud()
		"GUIDED_ECHO":
			_update_guided_echo_hud()
		_:
			_update_standard_hud()
	completion_label.visible = state.completed
	completion_label.text = "COMPLETE\nYOU reached EXIT\nPress R to restart"
	_update_help_modal()


func _update_intro_hud() -> void:
	objective_label.text = "GOAL: Move YOU (white) onto EXIT."
	legend_label.text = "ENTITY KEY\nYOU — white / cyan core\nEXIT — blue diamond"
	timeline_label.visible = false
	timeline_label.text = ""
	echo_next_label.visible = false
	echo_next_label.text = ""
	status_label.text = "%s\n\nTurn: %d\n\n%s" % [level.title.to_upper(), state.turn_index, "COMPLETE — YOU reached EXIT\nPress R to restart" if state.completed else "Move YOU to EXIT."]
	if help_expanded:
		objective_label.text += "\nOnly YOU can complete the level."
		legend_label.text += "\n\nHELP\nMove with Arrows/WASD.\nR restarts without changing a turn."
	history_label.text = _controls_text(false, not disclosure.controls_collapsed or help_expanded)


func _update_guided_echo_hud() -> void:
	objective_label.text = "GOAL: ECHO holds PLATE; YOU crosses DOOR to EXIT."
	legend_label.text = _full_entity_key()
	var has_echo: bool = not level.echoes.is_empty() and not state.echo_positions.is_empty()
	var has_door: bool = not level.doors.is_empty() and not state.door_states.is_empty()
	echo_next_label.visible = false
	echo_next_label.text = ""
	var delay_text := "\nEcho delay: %d" % level.echoes[0].delay if has_echo else ""
	var door_text := "\nDoor: %s" % ("OPEN" if state.door_states[0].open else "CLOSED") if has_door else ""
	status_label.text = "%s\n\nTurn: %d%s%s%s" % [level.title.to_upper(), state.turn_index, delay_text, door_text, "\n\nCOMPLETE — YOU reached EXIT\nPress R to restart" if state.completed else ""]
	if disclosure.legend_collapsed and not help_expanded:
		legend_label.text = _compact_entity_key()
	if disclosure.causality_collapsed and not help_expanded:
		objective_label.text = "GOAL: ECHO holds PLATE; YOU reaches EXIT.  H: Help"
	var model := get_timeline_snapshot()
	timeline_label.visible = model.visible and timeline_visible_for(level, _hud_mode(), state.completed)
	timeline_label.text = timeline_model.expanded_text(model) if help_expanded else timeline_model.compact_text(model)
	history_label.text = _controls_text(true, not disclosure.controls_collapsed or help_expanded)


func _update_standard_hud() -> void:
	objective_label.text = "GOAL: Move YOU — not ECHO — onto EXIT."
	legend_label.text = _compact_entity_key()
	var has_echo: bool = not level.echoes.is_empty() and not state.echo_positions.is_empty()
	var has_door: bool = not level.doors.is_empty() and not state.door_states.is_empty()
	echo_next_label.visible = false
	echo_next_label.text = ""
	var delay_text := "\nEcho delay: %d" % level.echoes[0].delay if has_echo else ""
	var door_text := "\nDoor: %s" % ("OPEN" if state.door_states[0].open else "CLOSED") if has_door else ""
	status_label.text = "%s\n\nTurn: %d%s%s%s" % [level.title.to_upper(), state.turn_index, delay_text, door_text, "\n\nCOMPLETE — YOU reached EXIT\nPress R to restart" if state.completed else ""]
	if disclosure.objective_collapsed and not help_expanded:
		objective_label.text = "GOAL: YOU → EXIT.  H: Help"
	var model := get_timeline_snapshot()
	timeline_label.visible = model.visible and timeline_visible_for(level, _hud_mode(), state.completed)
	timeline_label.text = timeline_model.expanded_text(model) if help_expanded else timeline_model.compact_text(model)
	history_label.text = _controls_text(true, not disclosure.controls_collapsed or help_expanded)


func _update_help_modal() -> void:
	help_card.visible = help_expanded
	var normal_visible := not help_expanded
	status_label.visible = normal_visible
	objective_label.visible = normal_visible
	legend_label.visible = normal_visible
	history_label.visible = normal_visible
	completion_label.visible = normal_visible and state.completed
	if help_expanded:
		timeline_label.visible = false
		echo_next_label.visible = false
		var sections := PackedStringArray()
		sections.append("OBJECTIVE · " + _help_objective())
		sections.append("CONTROLS · " + _help_controls())
		sections.append("ENTITY KEY · Y YOU  •  E ECHO  •  ○/● PLATE  •  ||/□ DOOR  •  ◆ EXIT" if _hud_mode() != "INTRO_MINIMAL" else "ENTITY KEY · Y YOU  •  ◆ EXIT")
		if not level.get("doors", []).is_empty():
			sections.append("DOOR / PLATE · Filled pips = linked Plates. Bars = CLOSED. Hollow = OPEN.")
		var model := get_timeline_snapshot()
		if model.visible:
			sections.append(_help_timeline_text(model))
		help_body.text = "\n".join(sections)


func _help_objective() -> String:
	if _hud_mode() == "INTRO_MINIMAL":
		return "Move YOU onto EXIT. Only YOU completes."
	return "ECHO holds PLATE; move YOU through DOOR to EXIT. Only YOU completes."


func _help_controls() -> String:
	var destination := "Back" if hosted_by_app else "Quit"
	return "Arrows/WASD Move%s · R Restart · H Help · Esc %s" % [" · Space Wait" if _hud_mode() != "INTRO_MINIMAL" else "", destination]


func _help_timeline_text(model: Dictionary) -> String:
	var slot_parts := PackedStringArray()
	for slot in model.slots:
		slot_parts.append("[%d %s %s]" % [slot.slot_number, slot.glyph, slot.accessible_label])
	var pointer_parts := PackedStringArray()
	for pointer in model.echo_pointers:
		pointer_parts.append("E d%d → slot %d: %s %s" % [pointer.delay, pointer.slot_number, pointer.glyph, pointer.action])
	return "TIMELINE · oldest → newest\n%s\n%s\nPointers replay next; blocked actions stay recorded." % ["  ".join(slot_parts), "  |  ".join(pointer_parts)]


func _update_visual_feedback(before: Dictionary, result: Dictionary, action: String) -> void:
	_reset_visual_feedback()
	var after: Dictionary = result.state
	for index in result.actor_actions.echoes.size():
		var actor_action: Dictionary = result.actor_actions.echoes[index]
		var before_position: Array = before.echo_positions[index].position
		var after_position: Array = after.echo_positions[index].position
		if actor_action.action != "WAIT" and before_position != after_position:
			visual_feedback.echo_trails.append({
				"echo_id": actor_action.id,
				"action": actor_action.action,
				"from": before_position.duplicate(),
				"to": after_position.duplicate(),
				"visual_state": "STATIC_SEGMENTS" if reduced_motion else "SEGMENTED_REPLAY_TRAIL",
			})
	if ["UP", "RIGHT", "DOWN", "LEFT"].has(action) and before.player_position == after.player_position:
		var attempted: Array = [before.player_position[0] + int(_action_delta(action).x), before.player_position[1] + int(_action_delta(action).y)]
		for door in level.get("doors", []):
			if door.position == attempted and not _door_open_in_state(before, door.id):
				visual_feedback.blocked_door = {
					"visible": true,
					"door_id": door.id,
					"action": action,
					"position": attempted,
					"visual_state": "X_STOP_NOTCH",
				}
				break
	if configured_level_id == "door_one_turn_late" and ["UP", "RIGHT", "DOWN", "LEFT"].has(action) and before.player_position == after.player_position:
		for door in level.get("doors", []):
			if not _door_open_in_state(before, door.id) and _door_open_in_state(after, door.id):
				visual_feedback.blocked_door = {
					"visible": true,
					"door_id": door.id,
					"action": action,
					"position": door.position.duplicate(),
					"visual_state": "X_STOP_NOTCH",
					"critical_timing_boundary": true,
				}
				break
	if configured_level_id == "door_one_turn_late" and not teaching_badge_consumed and visual_feedback.blocked_door.visible and not visual_feedback.echo_trails.is_empty():
		var door_id: String = visual_feedback.blocked_door.door_id
		if not _door_open_in_state(before, door_id) and _door_open_in_state(after, door_id):
			teaching_badge_consumed = true
			visual_feedback.teaching_badge = {
				"visible": true,
				"door_id": door_id,
				"text": "OPEN · NEXT INPUT",
				"duration_seconds": 1.25,
			}
			feedback_timer.start()


func _reset_visual_feedback() -> void:
	visual_feedback = {
		"echo_trails": [],
		"blocked_door": {"visible": false},
		"teaching_badge": {"visible": false},
	}
	if feedback_timer != null:
		feedback_timer.stop()


func _clear_teaching_badge() -> void:
	visual_feedback.teaching_badge = {"visible": false}
	if feedback_timer != null:
		feedback_timer.stop()


func _on_feedback_timeout() -> void:
	_clear_teaching_badge()
	queue_redraw()


func _door_open_in_state(candidate_state: Dictionary, door_id: String) -> bool:
	for door_state in candidate_state.get("door_states", []):
		if door_state.id == door_id:
			return door_state.open
	return false


func _action_delta(action: String) -> Vector2i:
	match action:
		"UP":
			return Vector2i.UP
		"RIGHT":
			return Vector2i.RIGHT
		"DOWN":
			return Vector2i.DOWN
		"LEFT":
			return Vector2i.LEFT
	return Vector2i.ZERO


func _update_disclosure(before: Dictionary, result: Dictionary) -> void:
	disclosure.controls_collapsed = true
	if _hud_mode() == "STANDARD_COMPACT":
		disclosure.objective_collapsed = true
	for index in result.actor_actions.echoes.size():
		var echo_action: Dictionary = result.actor_actions.echoes[index]
		if echo_action.action != "WAIT" and before.echo_positions[index].position != result.state.echo_positions[index].position:
			disclosure.legend_collapsed = true
	var door_changed := false
	for index in result.state.door_states.size():
		if before.door_states[index].open != result.state.door_states[index].open:
			door_changed = true
	var echo_on_plate := false
	for echo in result.state.echo_positions:
		for plate in level.get("plates", []):
			echo_on_plate = echo_on_plate or echo.position == plate.position
	if door_changed and echo_on_plate:
		disclosure.causality_collapsed = true


func _hud_mode() -> String:
	return route_payload.get("hud_mode", "STANDARD_COMPACT")


func _full_entity_key() -> String:
	return "ENTITY KEY\nYOU — white / cyan core\nECHO — purple outline\nPLATE — amber pad\nDOOR — red closed / green open\nEXIT — blue diamond"


func _compact_entity_key() -> String:
	return "KEY\nY YOU  •  E ECHO\n● PLATE  ▮ DOOR  ◆ EXIT"


func _controls_text(include_wait: bool, expanded: bool) -> String:
	var destination := "Back" if hosted_by_app else "Quit"
	if expanded:
		return "Move: Arrows/WASD%s   Restart: R   Help: H   %s: Esc" % ["   Wait: Space" if include_wait else "", destination]
	return "H Help"


func _is_help_toggle(event: InputEvent) -> bool:
	return event is InputEventKey and event.pressed and not event.echo and (event.keycode == KEY_H or event.physical_keycode == KEY_H)


func _door_open(id: String) -> bool:
	for door in state.door_states:
		if door.id == id:
			return door.open
	return false


func _plate_by_id(id: String) -> Dictionary:
	for plate in level.get("plates", []):
		if plate.id == id:
			return plate
	return {}


func _echo_definition_by_id(id: String) -> Dictionary:
	for echo in level.get("echoes", []):
		if echo.id == id:
			return echo
	return {}


func _door_by_id(id: String) -> Dictionary:
	for door in level.get("doors", []):
		if door.id == id:
			return door
	return {}


func _center(position: Array) -> Vector2:
	return _board_origin() + Vector2(position[0], position[1]) * CELL + Vector2.ONE * (CELL - CELL_GAP) * 0.5


func _board_rect() -> Rect2:
	if level.is_empty() or level.get("terrain_rows", []).is_empty():
		return Rect2()
	var grid_size := Vector2(level.terrain_rows[0].length(), level.terrain_rows.size())
	var size := grid_size * CELL
	return Rect2(BOARD_ZONE.position + (BOARD_ZONE.size - size) * 0.5, size)


func _board_origin() -> Vector2:
	return _board_rect().position


func _codes(errors: Array) -> String:
	var codes: PackedStringArray = []
	for error in errors:
		codes.append(error.code)
	return ", ".join(codes)

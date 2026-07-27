extends Node2D

signal gameplay_completed(level_id: String, turns: int)
signal request_back

const LevelLoader = preload("res://scripts/simulation/level_loader.gd")
const Simulation = preload("res://scripts/simulation/simulation.gd")
const TimelineModel = preload("res://scripts/gameplay/timeline_model.gd")
const SchemaV2Presentation = preload("res://scripts/gameplay/schema_v2_presentation.gd")
const SubmissionVisualTheme = preload("res://scripts/presentation/submission_visual_theme.gd")
const SubmissionSfxRouter = preload("res://scripts/audio/submission_sfx_router.gd")
const LEVEL_PATH := "res://data/levels/vertical_slice_delay_3.json"
const HUD_MODES := ["INTRO_MINIMAL", "GUIDED_ECHO", "STANDARD_COMPACT"]
const CELL := 60.0
const CELL_GAP := 3.0
const BOARD_ZONE := Rect2(24, 84, 540, 420)
const RIGHT_RAIL := Rect2(600, 84, 336, 420)
const GOAL_STRIP := Rect2(24, 18, 912, 46)
const HELP_RECT := Rect2(96, 54, 768, 432)
const ECHO_DIVERGENCE_BADGE_RECT := Rect2(24, 66, 540, 18)
const COMPLETION_RECT := Rect2(84, 210, 480, 120)
const FINAL_ACKNOWLEDGEMENT_RECT := Rect2(84, 170, 480, 200)
const FINAL_ACKNOWLEDGEMENT_VISIBLE := "FINAL_ACKNOWLEDGEMENT_VISIBLE"
const FINAL_ACKNOWLEDGEMENT_COPY := "THE SIGNAL ARRIVED LATE.\nIT WAS HEARD.\n\nEnter / Space: Level Select\nR: Replay"
const CARDINAL_ACTIONS := ["UP", "RIGHT", "DOWN", "LEFT"]
const BRIDGE_CONTEXTUAL_HELP := "SPACING · Closed DOOR/wall BLOCKS one ECHO while another MOVES, changing spacing.\nEXPERIMENT · Compare MOVED/BLOCKED; try another route or loop.\nA+B · Two ECHOS hold separate Plates; YOU stays free to cross. Only YOU completes."

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
var acknowledgement_return_requested := false
var visual_feedback := {
	"echo_trails": [],
	"blocked_door": {"visible": false},
	"teaching_badge": {"visible": false},
	"echo_divergence": {
		"visible": false,
		"headline": "",
		"detail": "",
		"actors": [],
		"pair": {},
		"badge_rect": ECHO_DIVERGENCE_BADGE_RECT,
		"visual_state": "STATIC_OUTCOME_CUE",
	},
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
	SubmissionSfxRouter.ensure_router(get_tree()).reset_router_state()
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
	if is_final_acknowledgement_visible():
		if event.is_echo():
			return
		if event.is_action_pressed("restart_level"):
			_restart_level()
		elif event.is_action_pressed("ui_cancel") or event.is_action_pressed("ui_accept") or event.is_action_pressed("wait_turn"):
			_request_acknowledgement_return_once()
		return
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
		_restart_level()
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
			_play_transition_sfx(before, state, action, was_completed)
			_update_visual_feedback(before, result, action)
			_update_disclosure(before, result)
			if not was_completed and state.completed and hosted_by_app:
				help_expanded = false
				gameplay_completed.emit(configured_level_id, state.turn_index - 1)
		else:
			if CARDINAL_ACTIONS.has(action):
				SubmissionSfxRouter.ensure_router(get_tree()).play_event("blocked_or_invalid")
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


func is_final_acknowledgement_visible() -> bool:
	return hosted_by_app and bool(route_payload.get("final_level", false)) and bool(state.get("completed", false))


func get_final_acknowledgement_state() -> String:
	return FINAL_ACKNOWLEDGEMENT_VISIBLE if is_final_acknowledgement_visible() else ""


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
		"final_acknowledgement_state": get_final_acknowledgement_state(),
		"acknowledgement_return_requested": acknowledgement_return_requested,
		"help_expanded": help_expanded,
		"help_body": help_body.text if help_expanded else "",
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
		"you": _you_snapshot(),
		"surfaces": _surface_snapshots(),
		"terrain": {
			"wall_adjacency": _wall_adjacency_snapshot(),
			"floor_mark_count": _floor_mark_count(),
		},
		"plates": _plate_snapshots(),
		"doors": _door_snapshots(),
		"echoes": _echo_snapshots(),
		"exit": _exit_snapshot(),
		"echo_trails": visual_feedback.echo_trails.duplicate(true),
		"blocked_door": visual_feedback.blocked_door.duplicate(true),
		"teaching_badge": visual_feedback.teaching_badge.duplicate(true),
		"echo_divergence": visual_feedback.echo_divergence.duplicate(true),
	}


func get_schema_v2_presentation_snapshot() -> Array:
	if level.is_empty() or state.is_empty():
		return []
	return SchemaV2Presentation.build(level, state, _board_rect(), CELL, Rect2(0, 0, 960, 540)).duplicate(true)


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
		var plate_bounds := _cell_bounds(int(plate.position[0]), int(plate.position[1]))
		var snapshot := {
			"id": plate.id,
			"position": plate.position.duplicate(),
			"center": _center(plate.position),
			"bounds": {
				"x": plate_bounds.position.x,
				"y": plate_bounds.position.y,
				"width": plate_bounds.size.x,
				"height": plate_bounds.size.y,
			},
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


func bridge_contextual_help_applicable(level_facts: Dictionary) -> bool:
	var metadata = level_facts.get("metadata", {})
	if not metadata is Dictionary or not metadata.get("intended_mechanics", []) is Array or not metadata.intended_mechanics.has("echo_spacing_change"):
		return false
	var echoes = level_facts.get("echoes", [])
	var plates = level_facts.get("plates", [])
	var doors = level_facts.get("doors", [])
	if not echoes is Array or echoes.size() < 2 or not plates is Array or plates.size() != 2 or not doors is Array:
		return false
	var plate_ids: Array = plates.map(func(plate): return plate.get("id", "") if plate is Dictionary else "")
	if plate_ids.any(func(plate_id): return not plate_id is String or plate_id.is_empty()) or plate_ids[0] == plate_ids[1]:
		return false
	var first_position = plates[0].get("position") if plates[0] is Dictionary else null
	var second_position = plates[1].get("position") if plates[1] is Dictionary else null
	if first_position == second_position:
		return false
	return doors.any(func(door):
		if not door is Dictionary:
			return false
		var dependencies = door.get("all_plate_ids", [])
		return dependencies is Array and plate_ids.all(func(plate_id): return dependencies.has(plate_id))
	)


func toggle_help() -> void:
	if load_error == "":
		help_expanded = not help_expanded
		_clear_teaching_badge()
		_update_hud()
		queue_redraw()


func _restart_level() -> void:
	state = simulation.construct_initial_state(level)
	SubmissionSfxRouter.ensure_router(get_tree()).reset_router_state()
	acknowledgement_return_requested = false
	help_expanded = false
	_reset_visual_feedback()
	_update_hud()
	queue_redraw()


func _request_acknowledgement_return_once() -> void:
	if acknowledgement_return_requested:
		return
	acknowledgement_return_requested = true
	request_back.emit()


func _draw() -> void:
	draw_rect(Rect2(Vector2.ZERO, Vector2(960, 540)), SubmissionVisualTheme.color_for_token("paper_background"))
	if load_error != "":
		return
	for y in level.terrain_rows.size():
		for x in level.terrain_rows[y].length():
			var rectangle := Rect2(_board_origin() + Vector2(x, y) * CELL, Vector2(CELL - CELL_GAP, CELL - CELL_GAP))
			_draw_paper_cell(rectangle, level.terrain_rows[y][x] == ".", x, y)
	_draw_schema_v2_descriptors(false)
	var pressed_plate_ids: Array = simulation.pressed_plate_ids(level, state)
	for door in level.doors:
		var dependency_ids: Array = door.all_plate_ids.duplicate()
		dependency_ids.sort()
		for plate_id in dependency_ids:
			var plate := _plate_by_id(plate_id)
			if not plate.is_empty():
				var active: bool = pressed_plate_ids.has(plate_id)
				draw_dashed_line(_center(plate.position), _center(door.position), SubmissionVisualTheme.color_for_token("success_mark") if active else SubmissionVisualTheme.color_for_token("secondary_ink"), 3.0 if active else 1.5, 8.0)
	for plate in level.plates:
		var active: bool = pressed_plate_ids.has(plate.id)
		var plate_center := _center(plate.position)
		_draw_plate_token(plate_center, plate, active)
		if _uses_convergence_cues():
			draw_string(ThemeDB.fallback_font, plate_center + Vector2(-5, 5), _dependency_identity(plate.id).label, HORIZONTAL_ALIGNMENT_LEFT, -1, 14, Color("fff7d6"))
	for door in level.doors:
		var open: bool = _door_open(door.id)
		var door_center := _center(door.position)
		_draw_door_token(door_center, open)
		_draw_dependency_pips(door, door_center, pressed_plate_ids)
	_draw_echo_feedback()
	var exit_position: Vector2 = _center(level.exit.position)
	_draw_exit_base(exit_position)
	for echo in state.echo_positions:
		var echo_center := _center(echo.position)
		var definition := _echo_definition_by_id(echo.id)
		_draw_echo_token(echo_center, definition)
	var you_center := _center(state.player_position)
	_draw_you_token(you_center)
	_draw_schema_v2_descriptors(true)
	_draw_exit_overlay(exit_position)
	_draw_blocked_door_feedback()
	_draw_teaching_badge()


func _draw_paper_cell(rectangle: Rect2, floor_cell: bool, x: int = -1, y: int = -1) -> void:
	var paper: Color = SubmissionVisualTheme.color_for_token("paper_background")
	var ink: Color = SubmissionVisualTheme.color_for_token("secondary_ink")
	if floor_cell:
		_draw_floor_cell(rectangle, ink)
		if x >= 0 and y >= 0 and _draw_floor_mark_cell(x, y, rectangle):
			var mark_offset: Vector2 = Vector2(19, 19)
			draw_line(rectangle.position + mark_offset, rectangle.position + mark_offset + Vector2(8, 0), ink, 1.5)
	else:
		var mask: int = _wall_adjacency_mask(x, y)
		draw_rect(rectangle, ink.lightened(0.62), false, 1.2)
		draw_rect(rectangle, ink.darkened(0.35))
		_draw_wall_contour(rectangle, mask, ink)
		draw_wall_interior_detail(rectangle, x, y)


func _draw_floor_cell(rectangle: Rect2, ink: Color) -> void:
	var paper: Color = SubmissionVisualTheme.color_for_token("paper_background")
	draw_rect(rectangle, paper)
	draw_rect(rectangle, ink, false, 1.0)


func _draw_floor_mark_cell(x: int, y: int, rectangle: Rect2) -> bool:
	return (x + y) % 5 == 0


func _wall_adjacency_mask(x: int, y: int) -> int:
	if x < 0 or y < 0:
		return 0
	var mask: int = 0
	if not _is_wall_cell(Vector2i(x, y - 1)):
		mask |= 1
	if not _is_wall_cell(Vector2i(x + 1, y)):
		mask |= 2
	if not _is_wall_cell(Vector2i(x, y + 1)):
		mask |= 4
	if not _is_wall_cell(Vector2i(x - 1, y)):
		mask |= 8
	return mask


func _is_wall_cell(position: Vector2i) -> bool:
	if position.x < 0 or position.y < 0:
		return false
	if position.y >= level.terrain_rows.size():
		return false
	var row: String = level.terrain_rows[position.y]
	if position.x >= row.length():
		return false
	return row[position.x] != "."


func _draw_wall_contour(rectangle: Rect2, mask: int, ink: Color) -> void:
	var top: Vector2 = rectangle.position
	var bottom: Vector2 = rectangle.position + Vector2(rectangle.size.x, 0)
	var left: Vector2 = rectangle.position + Vector2(0, rectangle.size.y)
	var right: Vector2 = rectangle.position
	var outline: float = 2.2
	if mask & 1:
		draw_line(top, top + Vector2(rectangle.size.x, 0), ink, outline)
	if mask & 4:
		draw_line(Vector2(left.x, left.y), Vector2(left.x + rectangle.size.x, left.y), ink, outline)
	if mask & 8:
		draw_line(right, right + Vector2(0, rectangle.size.y), ink, outline)
	if mask & 2:
		var right_top := rectangle.position + Vector2(rectangle.size.x, 0)
		draw_line(right_top, right_top + Vector2(0, rectangle.size.y), ink, outline)


func draw_wall_interior_detail(rectangle: Rect2, x: int, y: int) -> void:
	var muted: Color = Color("0f172a", 0.48)
	var center: Vector2 = rectangle.position + rectangle.size * 0.5
	var size_a: float = 14.0
	var size_b: float = 10.0
	for index in 2:
		var start := center - Vector2(size_a - float(index * 4), 0)
		var end := center + Vector2(size_a - float(index * 4), 0)
		draw_line(start, end, muted, 1.0 if index == 0 else 0.9)
	if (x + y) % 3 == 1:
		draw_line(rectangle.position + Vector2(rectangle.size.x - 12, 10), rectangle.position + Vector2(rectangle.size.x - 6, rectangle.size.y - 10), muted, 1.1)
		draw_line(rectangle.position + Vector2(12, 10), rectangle.position + Vector2(6, rectangle.size.y - 10), muted, 1.1)


func classify_transition_events(before: Dictionary, after: Dictionary, action: String, was_completed: bool) -> Array[String]:
	return _classify_transition_events(before, after, action, was_completed)


func _play_transition_sfx(before: Dictionary, after: Dictionary, action: String, was_completed: bool) -> void:
	var router := SubmissionSfxRouter.ensure_router(get_tree())
	var events: Array = _classify_transition_events(before, after, action, was_completed)
	for event_id in events:
		router.play_event(event_id)


func _classify_transition_events(before: Dictionary, after: Dictionary, action: String, was_completed: bool) -> Array[String]:
	var events: Array[String] = []
	if was_completed:
		return events
	var completed: bool = bool(after.get("completed", false)) and not bool(was_completed)
	if completed:
		return [SubmissionSfxRouter.EVENT_LEVEL_COMPLETE]
	if not CARDINAL_ACTIONS.has(action) and action != "WAIT":
		return events
	var before_player: Variant = before.get("player_position", [])
	var after_player: Variant = after.get("player_position", [])
	var moved: bool = _positions_equal(before_player, after_player) == false
	var wall_facing: bool = _is_wall_facing_recorded_turn(before_player, after_player, action, before)
	if moved:
		events.append(SubmissionSfxRouter.EVENT_YOU_MOVE)
	elif CARDINAL_ACTIONS.has(action):
		if wall_facing:
			events.append(SubmissionSfxRouter.EVENT_WALL_BUMP)
		else:
			events.append(SubmissionSfxRouter.EVENT_BLOCKED_OR_INVALID)
	if _any_echo_moved(before.get("echo_positions", []), after.get("echo_positions", [])):
		events.append(SubmissionSfxRouter.EVENT_ECHO_MOVE)
	if _plate_ids_added(before, after):
		events.append(SubmissionSfxRouter.EVENT_PLATE_ACTIVATE)
	if _door_open_count(before, after) > 0:
		events.append(SubmissionSfxRouter.EVENT_DOOR_OPEN)
	return _dedupe_preserve_order(events)


func _is_wall_facing_recorded_turn(before_player: Variant, after_player: Variant, action: String, before_state: Dictionary) -> bool:
	var before_position: Vector2i = _position_to_vector(before_player)
	var after_position: Vector2i = _position_to_vector(after_player)
	if not CARDINAL_ACTIONS.has(action) or before_position == Vector2i(-2147483648, -2147483648) or after_position == Vector2i(-2147483648, -2147483648):
		return false
	var delta: Vector2i = _action_delta(action)
	var target: Vector2i = before_position + delta
	if not _is_outside_terrain(target) and not _is_wall_cell(target):
		return false
	if _is_closed_door_position(target, before_state):
		return false
	return before_position == after_position


func _is_outside_terrain(position: Vector2i) -> bool:
	if position.x < 0 or position.y < 0 or position.y >= level.terrain_rows.size():
		return true
	return position.x >= String(level.terrain_rows[position.y]).length()


func _is_closed_door_position(position: Vector2i, state_candidate: Dictionary) -> bool:
	for door in level.get("doors", []):
		var candidate_pos: Array = door.get("position", [])
		if candidate_pos.size() == 2 and int(candidate_pos[0]) == position.x and int(candidate_pos[1]) == position.y:
			var door_id := String(door.get("id", ""))
			var open: bool = false
			for door_state in state_candidate.get("door_states", []):
				if String(door_state.get("id", "")) == door_id:
					open = bool(door_state.get("open", false))
			return not open
	return false


func _door_state_by_id(door_id: String) -> bool:
	for door in state.door_states:
		if door.id == door_id:
			return door.open
	return false


func _plate_ids_added(before_state: Dictionary, after_state: Dictionary) -> bool:
	if not before_state.get("player_position", []) is Array or not after_state.get("player_position", []) is Array:
		return false
	var before_pressed: Array = simulation.pressed_plate_ids(level, before_state)
	var after_pressed: Array = simulation.pressed_plate_ids(level, after_state)
	for plate_id in after_pressed:
		if not before_pressed.has(plate_id):
			return true
	return false


func _door_open_count(before_state: Dictionary, after_state: Dictionary) -> int:
	var before_by_id: Dictionary = {}
	var after_by_id: Dictionary = {}
	for door in before_state.get("door_states", []):
		before_by_id[String(door.get("id", ""))] = bool(door.get("open", false))
	for door in after_state.get("door_states", []):
		after_by_id[String(door.get("id", ""))] = bool(door.get("open", false))
	var count: int = 0
	for door_id in after_by_id.keys():
		var after_open: bool = after_by_id[door_id]
		var before_open: bool = bool(before_by_id.get(door_id, false))
		if after_open and not before_open:
			count += 1
	return count


func _dedupe_preserve_order(events: Array[String]) -> Array[String]:
	var seen: Dictionary = {}
	var ordered: Array[String] = []
	for event_id in events:
		if seen.has(event_id):
			continue
		seen[event_id] = true
		ordered.append(event_id)
	return ordered


func _positions_equal(a: Variant, b: Variant) -> bool:
	var a_position: Vector2i = _position_to_vector(a)
	var b_position: Vector2i = _position_to_vector(b)
	return a_position != Vector2i(-2147483648, -2147483648) and a_position == b_position


func _position_to_vector(value: Variant) -> Vector2i:
	if value is Vector2i:
		return value
	if value is Vector2:
		return Vector2i(value)
	if value is Array and value.size() == 2:
		return Vector2i(int(value[0]), int(value[1]))
	return Vector2i(-2147483648, -2147483648)


func _you_snapshot() -> Dictionary:
	var position: Array = state.get("player_position", [])
	return {
		"position": position.duplicate() if position is Array else [],
		"visual_family": "concrete_person",
		"bounds": {
			"x": _center(position).x - 16.0,
			"y": _center(position).y - 16.0,
			"width": 32.0,
			"height": 32.0,
		},
	}


func _wall_adjacency_snapshot() -> Array:
	if level.is_empty():
		return []
	var rows: Array = level.get("terrain_rows", [])
	var descriptors: Array = []
	for y in rows.size():
		var row := String(rows[y])
		for x in row.length():
			if row[x] == ".":
				continue
			var bounds := _cell_bounds(x, y)
			var descriptor := {
				"cell": [x, y],
				"adjacency_mask": _wall_adjacency_mask(x, y),
				"signature": "wall_%d_%d_%d" % [x, y, _wall_adjacency_mask(x, y)],
				"bounds": {
					"x": bounds.position.x,
					"y": bounds.position.y,
					"width": bounds.size.x,
					"height": bounds.size.y,
				},
			}
			descriptors.append(descriptor)
	descriptors.sort_custom(func(a: Dictionary, b: Dictionary): return a.get("cell", [0, 0])[0] < b.get("cell", [0, 0])[0] if a.get("cell", [0, 0])[1] == b.get("cell", [0, 0])[1] else a.get("cell", [0, 0])[1] < b.get("cell", [0, 0])[1])
	return descriptors


func _cell_bounds(x: int, y: int) -> Rect2:
	var origin := _board_origin() + Vector2(x, y) * CELL
	return Rect2(origin, Vector2(CELL - CELL_GAP, CELL - CELL_GAP))


func _floor_mark_count() -> int:
	if level.is_empty():
		return 0
	var rows: Array = level.get("terrain_rows", [])
	var count: int = 0
	for y in rows.size():
		var row := String(rows[y])
		for x in row.length():
			if row[x] != ".":
				continue
			if (x + y) % 5 == 0:
				count += 1
	return count


func _exit_snapshot() -> Dictionary:
	if level.is_empty() or not level.has("exit"):
		return {"position": [], "bounds": {"x": 0, "y": 0, "width": 0, "height": 0}, "visual_state": "missing"}
	var position: Array = level.exit.position
	var bounds := _cell_bounds(int(position[0]), int(position[1]))
	return {
		"position": position.duplicate(),
		"visual_state": "destination_doorway",
		"bounds": {
			"x": bounds.position.x,
			"y": bounds.position.y,
			"width": bounds.size.x,
			"height": bounds.size.y,
		},
	}


func _any_echo_moved(before_echoes: Array, after_echoes: Array) -> bool:
	var before_by_id := {}
	for echo in before_echoes:
		before_by_id[echo.id] = echo.position
	for echo in after_echoes:
		if before_by_id.has(echo.id) and before_by_id[echo.id] != echo.position:
			return true
	return false


func get_echo_delay_badges_snapshot() -> Array[String]:
	var badges: Array[String] = []
	for echo in state.get("echo_positions", []):
		var definition := _echo_definition_by_id(echo.id)
		badges.append("E%d" % int(definition.get("delay", 0)))
	return badges


func _draw_schema_v2_descriptors(tokens_only: bool) -> void:
	for descriptor in get_schema_v2_presentation_snapshot():
		if (int(descriptor.layer) >= 5) != tokens_only:
			continue
		var bounds: Dictionary = descriptor.bounds
		var rect := Rect2(float(bounds.x), float(bounds.y), float(bounds.width), float(bounds.height))
		var center := rect.get_center()
		match descriptor.family:
			"crate":
				draw_rect(rect, Color("9a6a38"))
				draw_rect(rect, Color("fff1c2"), false, 2)
				draw_line(rect.position + Vector2(4, 4), rect.end - Vector2(4, 4), Color("fff1c2"), 2)
				draw_line(Vector2(rect.end.x - 4, rect.position.y + 4), Vector2(rect.position.x + 4, rect.end.y - 4), Color("fff1c2"), 2)
			"floor_key":
				draw_circle(center - Vector2(8, 0), 7, Color("fde68a"), false, 2)
				draw_line(center - Vector2(1, 0), center + Vector2(13, 0), Color("fde68a"), 3)
				draw_line(center + Vector2(8, 0), center + Vector2(8, 5), Color("fde68a"), 2)
				draw_string(ThemeDB.fallback_font, rect.position + Vector2(2, 13), descriptor.type_group_token, HORIZONTAL_ALIGNMENT_LEFT, -1, 11, Color("fff7d6"))
			"lock":
				draw_rect(Rect2(center - Vector2(12, 4), Vector2(24, 17)), Color("7f1d1d"))
				draw_arc(center - Vector2(0, 4), 9, PI, TAU, 16, Color("fecaca"), 2)
				draw_line(center + Vector2(-9, 5), center + Vector2(9, 5), Color("fecaca"), 2)
				draw_string(ThemeDB.fallback_font, rect.position + Vector2(2, 13), descriptor.type_group_token, HORIZONTAL_ALIGNMENT_LEFT, -1, 11, Color("fff1f2"))
			"sensor":
				var active: bool = String(descriptor.state_variant).ends_with("ACTIVE")
				draw_arc(center, 19, 0, TAU, 24, Color("e0e7ff"), 3 if active else 1.5)
				if active: draw_arc(center, 13, 0, TAU, 20, Color("c4b5fd"), 2)
				draw_string(ThemeDB.fallback_font, center + Vector2(-6, 6), descriptor.glyph_token, HORIZONTAL_ALIGNMENT_CENTER, 12, 15, Color("ffffff"))
			"barrier":
				if descriptor.state_variant == "CLOSED":
					draw_rect(rect, Color("7f1d1d", 0.92))
					for offset in [-8.0, 0.0, 8.0]: draw_line(center + Vector2(offset, -16), center + Vector2(offset, 16), Color("fee2e2"), 2)
				else:
					draw_rect(rect, Color("a7f3d0", 0.14), false, 2)
					draw_line(rect.position, rect.end, Color("a7f3d0"), 2 if descriptor.state_variant == "OPEN" else 4)
					draw_line(Vector2(rect.end.x, rect.position.y), Vector2(rect.position.x, rect.end.y), Color("a7f3d0"), 2 if descriptor.state_variant == "OPEN" else 4)
				draw_string(ThemeDB.fallback_font, center + Vector2(-9, 5), descriptor.type_group_token, HORIZONTAL_ALIGNMENT_CENTER, 18, 11, Color("ffffff"))
			"latch":
				var activated: bool = String(descriptor.state_variant) == "ACTIVATED"
				var diamond := PackedVector2Array([center + Vector2(0, -15), center + Vector2(15, 0), center + Vector2(0, 15), center + Vector2(-15, 0)])
				draw_colored_polygon(diamond, Color("86efac") if activated else Color("334155"))
				for i in diamond.size(): draw_line(diamond[i], diamond[(i + 1) % diamond.size()], Color("ecfdf5"), 2)
				draw_string(ThemeDB.fallback_font, center + Vector2(-6, 5), descriptor.glyph_token, HORIZONTAL_ALIGNMENT_CENTER, 12, 14, Color("052e16"))
				_draw_schema_token(rect, descriptor.type_group_token)
			"held_key":
				draw_rect(rect, Color("172554", 0.96))
				draw_rect(rect, Color("bfdbfe"), false, 1.5)
				draw_string(ThemeDB.fallback_font, rect.position + Vector2(4, 16), "HELD " + descriptor.type_group_token, HORIZONTAL_ALIGNMENT_LEFT, -1, 12, Color("eff6ff"))


func _draw_schema_token(rect: Rect2, token: String) -> void:
	if token != "":
		draw_string(ThemeDB.fallback_font, rect.position + Vector2(1, 13), token, HORIZONTAL_ALIGNMENT_LEFT, -1, 11, Color("ffffff"))


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
	_draw_echo_divergence_feedback()


func _draw_echo_divergence_feedback() -> void:
	var feedback: Dictionary = visual_feedback.echo_divergence
	if not feedback.get("visible", false):
		return
	var badge: Rect2 = feedback.badge_rect
	draw_rect(badge, Color("111827", 0.96))
	draw_rect(badge, Color("f8fafc"), false, 1.5)
	var copy := "%s · %s" % [feedback.headline, feedback.detail]
	draw_string(ThemeDB.fallback_font, badge.position + Vector2(6, 14), copy, HORIZONTAL_ALIGNMENT_LEFT, badge.size.x - 12, 14, Color("f8fafc"))
	for actor in feedback.actors:
		var center := _center(actor.after_position)
		var radius: float = 26.0 if actor.outline_style == "SOLID" else 31.0
		if actor.outline_style == "SOLID":
			draw_arc(center, radius, 0, TAU, 32, Color("f8fafc", 0.9), 2)
		else:
			_draw_dashed_arc(center, radius, Color("f8fafc", 0.9), 2)
		var marker := center + Vector2(radius - 4, -radius + 4)
		match actor.outcome:
			"MOVED":
				draw_line(marker + Vector2(-5, 0), marker + Vector2(5, 0), Color("f8fafc"), 2)
				draw_line(marker + Vector2(1, -4), marker + Vector2(5, 0), Color("f8fafc"), 2)
				draw_line(marker + Vector2(1, 4), marker + Vector2(5, 0), Color("f8fafc"), 2)
			"BLOCKED":
				draw_line(marker + Vector2(-4, -4), marker + Vector2(4, 4), Color("f8fafc"), 2)
				draw_line(marker + Vector2(-4, 4), marker + Vector2(4, -4), Color("f8fafc"), 2)
			"WAITED":
				draw_line(marker + Vector2(-3, -4), marker + Vector2(-3, 4), Color("f8fafc"), 2)
				draw_line(marker + Vector2(3, -4), marker + Vector2(3, 4), Color("f8fafc"), 2)


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
	var background := Color("2563eb", 0.22)
	var frame := Color("60a5fa")
	var bounds := Rect2(center - Vector2(22, 22), Vector2(44, 44))
	draw_rect(Rect2(bounds.position + Vector2(5, 0), Vector2(34, 44)), Color("dbeafe", 0.15))
	draw_rect(bounds, background)
	draw_rect(bounds, frame, false, 3)
	draw_line(Vector2(bounds.position.x + 5, bounds.position.y + 16), Vector2(bounds.end.x - 5, bounds.position.y + 16), frame, 3)
	draw_line(Vector2(bounds.position.x + 5, bounds.position.y + 28), Vector2(bounds.end.x - 5, bounds.position.y + 28), frame, 3)
	var threshold := PackedVector2Array([Vector2(bounds.position.x + 6, bounds.position.y + 34), Vector2(bounds.end.x - 6, bounds.position.y + 34), Vector2(bounds.end.x - 17, bounds.end.y - 2), Vector2(bounds.position.x + 17, bounds.end.y - 2)])
	draw_colored_polygon(threshold, frame)
	var threshold_outline := PackedVector2Array([threshold[0], threshold[1], threshold[2], threshold[3], threshold[0]])
	draw_polyline(threshold_outline, frame, 2)


func _draw_exit_overlay(center: Vector2) -> void:
	var arrow := PackedVector2Array([center + Vector2(-8, 9), center + Vector2(0, 0), center + Vector2(8, 9)])
	draw_polyline(PackedVector2Array([arrow[0], arrow[1], arrow[2]]), Color("ecfeff"), 2)
	draw_line(arrow[1], arrow[1] + Vector2(0, 12), Color("ecfeff"), 2)
	draw_string(ThemeDB.fallback_font, center + Vector2(-14, -30), "EXIT", HORIZONTAL_ALIGNMENT_CENTER, 46, 14, Color("dbeafe"))


func _draw_plate_token(plate_center: Vector2, plate: Dictionary, active: bool) -> void:
	var base := Rect2(plate_center - Vector2(16, 10), Vector2(32, 20))
	var paper: Color = SubmissionVisualTheme.color_for_token("paper_background")
	var warn: Color = SubmissionVisualTheme.color_for_token("secondary_ink")
	draw_rect(base, warn.darkened(0.28))
	draw_rect(Rect2(base.position + Vector2(2, 4), Vector2(28, 12)), paper)
	draw_rect(Rect2(base.position + Vector2(4, 6), Vector2(24, 8)), warn, false, 1.2)
	if active:
		draw_rect(Rect2(base.position + Vector2(8, 8), Vector2(16, 4)), SubmissionVisualTheme.color_for_token("success_mark"))
		draw_line(plate_center + Vector2(-7, 0), plate_center + Vector2(7, 0), SubmissionVisualTheme.color_for_token("success_mark"), 2.2)
		draw_circle(plate_center + Vector2(0, 1), 5, Color("ecfccb", 0.96))
	else:
		draw_line(plate_center + Vector2(-8, 0), plate_center + Vector2(8, 0), warn, 1.8)
		draw_circle(plate_center + Vector2(0, 1), 4, Color("fef3c7", 0.95))
		draw_string(ThemeDB.fallback_font, plate_center + Vector2(-3, 5), "P", HORIZONTAL_ALIGNMENT_CENTER, -1, 10, Color("ffffff"))
	draw_rect(base, warn, false, 2)
	if _uses_convergence_cues():
		var identity := _dependency_identity(plate.id)
		draw_string(ThemeDB.fallback_font, base.position + Vector2(2, -3), identity.label, HORIZONTAL_ALIGNMENT_LEFT, -1, 10, warn)


func _draw_door_token(door_center: Vector2, open: bool) -> void:
	var frame: Rect2 = Rect2(door_center - Vector2(21, 20), Vector2(42, 40))
	var panel: Rect2 = Rect2(door_center - Vector2(14, 14), Vector2(28, 28))
	if open:
		draw_rect(frame, Color("111827"), false, 4)
		draw_line(frame.position, frame.position + Vector2(0, frame.size.y), Color("6ee7b7"), 3)
		draw_line(frame.position + Vector2(frame.size.x, 0), frame.end, Color("6ee7b7"), 3)
		draw_line(frame.position, frame.position + Vector2(frame.size.x, 0), Color("6ee7b7"), 3)
		draw_line(frame.position + Vector2(5, frame.size.y - 3), frame.end - Vector2(5, 3), Color("6ee7b7"), 2)
		draw_polyline(PackedVector2Array([
			frame.position + Vector2(8, 8),
			frame.position + Vector2(8, frame.size.y - 8),
			frame.position + Vector2(14, frame.size.y - 12),
		]), Color("34d399", 0.7), 2)
	else:
		draw_rect(frame, Color("111827"), false, 4)
		draw_rect(panel, Color("7f1d1d", 0.88))
		draw_rect(panel, Color("fecaca"), false, 2)
		draw_line(panel.position + Vector2(0, 9), panel.position + Vector2(panel.size.x, 9), Color("fecaca"), 1.5)
		draw_line(panel.position + Vector2(0, 19), panel.position + Vector2(panel.size.x, 19), Color("fecaca"), 1.5)
		draw_line(panel.position + Vector2(-3, panel.size.y * 0.5), panel.position + Vector2(panel.size.x + 3, panel.size.y * 0.5), Color("fca5a5"), 3)
		draw_circle(panel.position + Vector2(panel.size.x - 5, panel.size.y * 0.5 - 4), 2.5, Color("fef3c7"))
		for hinge_y in [6.0, 22.0]:
			draw_rect(Rect2(panel.position + Vector2(1, hinge_y), Vector2(3, 5)), Color("d1d5db"))


func _draw_echo_token(center: Vector2, definition: Dictionary) -> void:
	var delay: int = int(definition.get("delay", 0))
	var echo_ink := SubmissionVisualTheme.color_for_token("echo_ink")
	var ghost_fill := Color(echo_ink, 0.24)
	draw_circle(center, 16, SubmissionVisualTheme.color_for_token("paper_background"))
	draw_circle(center + Vector2(0, -6), 5, ghost_fill)
	draw_arc(center + Vector2(0, -6), 5, 0, TAU, 20, echo_ink, 2)
	draw_rect(Rect2(center + Vector2(-6, -1), Vector2(12, 11)), ghost_fill)
	draw_line(center + Vector2(-6, 1), center + Vector2(-11, 7), echo_ink, 2)
	draw_line(center + Vector2(6, 1), center + Vector2(11, 7), echo_ink, 2)
	draw_line(center + Vector2(-3, 10), center + Vector2(-7, 15), echo_ink, 2)
	draw_line(center + Vector2(3, 10), center + Vector2(7, 15), echo_ink, 2)
	draw_line(center + Vector2(-5, 3), center + Vector2(5, 3), Color(echo_ink, 0.7), 1.5)
	if delay >= 4:
		draw_arc(center, 20, 0, TAU, 40, Color("c4b5fd"), 2.6)
		_draw_dashed_arc(center, 14, SubmissionVisualTheme.color_for_token("primary_ink"), 2)
	else:
		_draw_dashed_arc(center, 17, echo_ink, 2)
	if _uses_convergence_cues() and delay >= 3:
		_draw_dashed_arc(center, 21, Color("a5b4fc"), 2)
	var badge_offset := Vector2(10, -22) if delay == 4 else Vector2(-26, -22)
	draw_string(ThemeDB.fallback_font, center + badge_offset, "E%d" % delay, HORIZONTAL_ALIGNMENT_LEFT, -1, 13, SubmissionVisualTheme.color_for_token("echo_ink"))
	if delay > 1:
		draw_polyline(PackedVector2Array([center + Vector2(-16, -16), center + Vector2(-22, -22), center + Vector2(-18, -10)]), Color("dbeafe", 0.6), 1.5)
		draw_polyline(PackedVector2Array([center + Vector2(16, -16), center + Vector2(22, -22), center + Vector2(18, -10)]), Color("dbeafe", 0.35), 1.0)


func _draw_you_token(center: Vector2) -> void:
	var outline := Color("94a3b8")
	var core := SubmissionVisualTheme.color_for_token("primary_ink")
	var paper: Color = SubmissionVisualTheme.color_for_token("paper_background")
	draw_circle(center, 14, paper)
	draw_circle(center, 10, core)
	draw_circle(center + Vector2(0, -2), 4, Color("111827", 0.95))
	draw_rect(Rect2(center.x - 5, center.y + 2, 10, 9), core.lightened(0.12))
	draw_rect(Rect2(center.x - 5, center.y - 2, 10, 4), core.lightened(0.2))
	draw_line(center + Vector2(0, 4), center + Vector2(0, 12), outline, 2.5)
	draw_line(center + Vector2(0, 6), center + Vector2(4, 11), outline, 2)
	draw_line(center + Vector2(0, 6), center + Vector2(-4, 11), outline, 2)
	draw_circle(center + Vector2(7, 2), 3, Color("dbeafe", 0.55))
	draw_circle(center + Vector2(-7, 2), 3, Color("dbeafe", 0.55))
	draw_rect(Rect2(center + Vector2(-6, -16), Vector2(12, 7)), Color("cbd5e1", 0.2), false, 1.5)
	draw_line(center + Vector2(-1, -14), center + Vector2(2, -22), outline, 2.3)
	draw_circle(center + Vector2(0, -18), 3, Color("f8fafc"))


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
	if is_final_acknowledgement_visible():
		completion_label.position = FINAL_ACKNOWLEDGEMENT_RECT.position
		completion_label.size = FINAL_ACKNOWLEDGEMENT_RECT.size
		completion_label.add_theme_font_size_override("font_size", 22)
		completion_label.text = FINAL_ACKNOWLEDGEMENT_COPY
		timeline_label.visible = false
	else:
		completion_label.position = COMPLETION_RECT.position
		completion_label.size = COMPLETION_RECT.size
		completion_label.add_theme_font_size_override("font_size", 28)
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
	if is_final_acknowledgement_visible():
		help_expanded = false
	help_card.visible = help_expanded
	var contextual_help := bridge_contextual_help_applicable(level)
	help_body.add_theme_font_size_override("font_size", 16 if contextual_help else 18)
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
		if contextual_help:
			sections.append(BRIDGE_CONTEXTUAL_HELP)
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
	_update_echo_divergence_feedback(before, result)
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


func _update_echo_divergence_feedback(before: Dictionary, result: Dictionary) -> void:
	var after: Dictionary = result.state
	if level.get("echoes", []).size() < 2 or after.get("completed", false):
		return
	var actors: Array = []
	for actor_action in result.actor_actions.get("echoes", []):
		var echo_id: String = actor_action.id
		var before_position: Array = _echo_position_in_state(before, echo_id)
		var after_position: Array = _echo_position_in_state(after, echo_id)
		if before_position.is_empty() or after_position.is_empty():
			continue
		var definition: Dictionary = _echo_definition_by_id(echo_id)
		var delay := int(definition.get("delay", 0))
		var replay_action: String = actor_action.action
		var outcome := "WAITED" if replay_action == "WAIT" else ("BLOCKED" if CARDINAL_ACTIONS.has(replay_action) and before_position == after_position else "MOVED")
		var radius: float = 26.0 if delay == 2 else 31.0
		actors.append({
			"id": echo_id,
			"delay": delay,
			"badge": "E%d" % delay,
			"action": replay_action,
			"before_position": before_position.duplicate(),
			"after_position": after_position.duplicate(),
			"outcome": outcome,
			"outline_style": "SOLID" if delay == 2 else "DOUBLE_DASHED",
			"marker_rect": Rect2(_center(after_position) - Vector2(radius, radius), Vector2(radius * 2.0, radius * 2.0)),
		})
	actors.sort_custom(func(a: Dictionary, b: Dictionary):
		return a.id < b.id if a.delay == b.delay else a.delay < b.delay
	)
	if actors.size() < 2:
		return
	var first: Dictionary = actors[0]
	var second: Dictionary = actors[1]
	var before_signed := [
		int(first.before_position[0]) - int(second.before_position[0]),
		int(first.before_position[1]) - int(second.before_position[1]),
	]
	var after_signed := [
		int(first.after_position[0]) - int(second.after_position[0]),
		int(first.after_position[1]) - int(second.after_position[1]),
	]
	var before_manhattan := absi(int(before_signed[0])) + absi(int(before_signed[1]))
	var after_manhattan := absi(int(after_signed[0])) + absi(int(after_signed[1]))
	var changed := before_signed != after_signed or before_manhattan != after_manhattan
	visual_feedback.echo_divergence = {
		"visible": changed,
		"headline": "ECHO SPACING CHANGED" if changed else "",
		"detail": "%s %s · %s %s" % [first.badge, first.outcome, second.badge, second.outcome],
		"actors": actors,
		"pair": {
			"ordered_ids": [first.id, second.id],
			"before_signed": before_signed,
			"after_signed": after_signed,
			"before_manhattan": before_manhattan,
			"after_manhattan": after_manhattan,
			"changed": changed,
		},
		"badge_rect": ECHO_DIVERGENCE_BADGE_RECT,
		"visual_state": "STATIC_OUTCOME_CUE" if reduced_motion else "SEGMENTED_OUTCOME_CUE",
	}


func _echo_position_in_state(snapshot_state: Dictionary, echo_id: String) -> Array:
	for echo_state in snapshot_state.get("echo_positions", []):
		if echo_state.get("id", "") == echo_id:
			return echo_state.position
	return []


func _reset_visual_feedback() -> void:
	visual_feedback = {
		"echo_trails": [],
		"blocked_door": {"visible": false},
		"teaching_badge": {"visible": false},
		"echo_divergence": {
			"visible": false,
			"headline": "",
			"detail": "",
			"actors": [],
			"pair": {},
			"badge_rect": ECHO_DIVERGENCE_BADGE_RECT,
			"visual_state": "STATIC_OUTCOME_CUE",
		},
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

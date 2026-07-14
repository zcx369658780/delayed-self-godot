extends Node2D

signal gameplay_completed(level_id: String, turns: int)
signal request_back

const LevelLoader = preload("res://scripts/simulation/level_loader.gd")
const Simulation = preload("res://scripts/simulation/simulation.gd")
const LEVEL_PATH := "res://data/levels/vertical_slice_delay_3.json"
const HUD_MODES := ["INTRO_MINIMAL", "GUIDED_ECHO", "STANDARD_COMPACT"]
const CELL := 54.0
const ORIGIN := Vector2(48, 150)

var level: Dictionary = {}
var state: Dictionary = {}
var load_error := ""
var simulation := Simulation.new()
var configured_level_id := "vertical_slice_delay_3"
var configured_level_path := LEVEL_PATH
var route_payload: Dictionary = {}
var hosted_by_app := false

@onready var status_label: Label = $Hud/Status
@onready var objective_label: Label = $Hud/Objective
@onready var legend_label: Label = $Hud/Legend
@onready var echo_next_label: Label = $Hud/EchoNext
@onready var history_label: Label = $Hud/History
@onready var completion_label: Label = $Hud/Completion


func _ready() -> void:
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
		if hosted_by_app:
			request_back.emit()
		else:
			get_tree().quit()
		return
	if load_error != "" or event.is_echo():
		return
	if event.is_action_pressed("restart_level"):
		state = simulation.construct_initial_state(level)
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
		var was_completed: bool = state.completed
		var result := simulation.transition(level, state, action)
		if result.ok:
			state = result.state
			if not was_completed and state.completed and hosted_by_app:
				gameplay_completed.emit(configured_level_id, state.turn_index - 1)
		else:
			printerr(result.status)
		_update_hud()
		queue_redraw()


func is_runtime_ready() -> bool:
	return load_error == "" and not level.is_empty() and not state.is_empty() and status_label != null and objective_label != null and legend_label != null and echo_next_label != null and history_label != null and completion_label != null


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
	return {"status": status_label.text, "objective": objective_label.text, "legend": legend_label.text, "echo_next": echo_next_label.text, "history": history_label.text, "completion": completion_label.text if completion_label.visible else ""}


func _draw() -> void:
	draw_rect(Rect2(Vector2.ZERO, Vector2(960, 540)), Color("111827"))
	if load_error != "":
		return
	for y in level.terrain_rows.size():
		for x in level.terrain_rows[y].length():
			var rectangle := Rect2(ORIGIN + Vector2(x, y) * CELL, Vector2(CELL - 3, CELL - 3))
			draw_rect(rectangle, Color("263449") if level.terrain_rows[y][x] == "." else Color("0a0f1a"))
	for plate in level.plates:
		var active := simulation.pressed_plate_ids(level, state).has(plate.id)
		draw_circle(_center(plate.position), 15, Color("fbbf24") if active else Color("7c5b18"))
	for door in level.doors:
		var open: bool = _door_open(door.id)
		var rect := Rect2(_center(door.position) - Vector2(21, 24), Vector2(42, 48))
		draw_rect(rect, Color("34d399", 0.28) if open else Color("ef4444"))
		draw_rect(rect, Color("6ee7b7") if open else Color("fecaca"), false, 3)
	var exit_position: Vector2 = _center(level.exit.position)
	_draw_exit_base(exit_position)
	for echo in state.echo_positions:
		var echo_center := _center(echo.position)
		draw_circle(echo_center, 16, Color("a78bfa", 0.72))
		draw_arc(echo_center, 20, 0, TAU, 24, Color("ddd6fe"), 2)
		var echo_letter_center := echo_center + Vector2(10, -8) if echo.position == state.player_position else echo_center
		_draw_actor_letter(echo_letter_center, "E", Color("f5f3ff"))
	draw_circle(_center(state.player_position), 15, Color("f8fafc"))
	draw_circle(_center(state.player_position), 7, Color("22d3ee"))
	_draw_actor_letter(_center(state.player_position), "Y", Color("082f49"))
	_draw_exit_overlay(exit_position)


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
		echo_next_label.text = ""
		history_label.text = ""
		completion_label.visible = false
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


func _update_intro_hud() -> void:
	objective_label.text = "GOAL: Move YOU (white) onto EXIT."
	legend_label.text = "ENTITY KEY\nYOU — white / cyan core\nEXIT — blue diamond"
	echo_next_label.visible = false
	echo_next_label.text = ""
	status_label.text = "%s\n\nTurn: %d\n\n%s" % [level.title.to_upper(), state.turn_index, "COMPLETE — YOU reached EXIT\nPress R to restart" if state.completed else "Move YOU to EXIT."]
	history_label.text = "Move: Arrows/WASD   Restart: R   %s: Esc" % ["Back" if hosted_by_app else "Quit"]


func _update_guided_echo_hud() -> void:
	objective_label.text = "GOAL: Move YOU (white) onto EXIT.\nThe ECHO (purple) cannot finish.\nLet ECHO hold PLATE while YOU cross DOOR."
	legend_label.text = "ENTITY KEY\nYOU — white / cyan core\nECHO — purple outline\nPLATE — amber pad\nDOOR — red closed / green open\nEXIT — blue diamond"
	var has_echo: bool = not level.echoes.is_empty() and not state.echo_positions.is_empty()
	var has_door: bool = not level.doors.is_empty() and not state.door_states.is_empty()
	echo_next_label.visible = has_echo and not state.completed
	echo_next_label.text = "Echo next: %s" % simulation.echo_action_for_state(level, state, level.echoes[0].id) if has_echo else ""
	var delay_text := "\nEcho delay: %d" % level.echoes[0].delay if has_echo else ""
	var door_text := "\nDoor: %s" % ("OPEN" if state.door_states[0].open else "CLOSED") if has_door else ""
	status_label.text = "%s\n\nTurn: %d%s%s\n\n%s" % [level.title.to_upper(), state.turn_index, delay_text, door_text, "COMPLETE — YOU reached EXIT\nPress R to restart" if state.completed else "Current actions replay 3 turns later."]
	history_label.text = "History (oldest → newest)\n%s\n\nMove: Arrows/WASD   Wait: Space   Restart: R   %s: Esc" % ["  •  ".join(state.history), "Back" if hosted_by_app else "Quit"]


func _update_standard_hud() -> void:
	objective_label.text = "GOAL: Move YOU (white) onto EXIT.\nThe ECHO (purple) cannot finish.\nUse the ECHO to hold the PLATE so YOU can cross the DOOR."
	legend_label.text = "ENTITY KEY\nYOU — white / cyan core\nECHO — purple outline\nPLATE — amber pad\nDOOR — red closed / green open\nEXIT — blue diamond"
	var has_echo: bool = not level.echoes.is_empty() and not state.echo_positions.is_empty()
	var has_door: bool = not level.doors.is_empty() and not state.door_states.is_empty()
	echo_next_label.visible = has_echo and not state.completed
	echo_next_label.text = "Echo next: %s" % simulation.echo_action_for_state(level, state, level.echoes[0].id) if has_echo else ""
	var delay_text := "\nEcho delay: %d" % level.echoes[0].delay if has_echo else ""
	var door_text := "\nDoor: %s" % ("OPEN" if state.door_states[0].open else "CLOSED") if has_door else ""
	status_label.text = "%s\n\nTurn: %d%s%s\n\n%s" % [level.title.to_upper(), state.turn_index, delay_text, door_text, "COMPLETE — YOU reached EXIT\nPress R to restart" if state.completed else "Your actions replay 3 turns later."]
	history_label.text = "History (oldest → newest)\n%s\n\nMove: Arrows/WASD   Wait: Space   Restart: R   %s: Esc" % ["  •  ".join(state.history), "Back" if hosted_by_app else "Quit"]


func _door_open(id: String) -> bool:
	for door in state.door_states:
		if door.id == id:
			return door.open
	return false


func _center(position: Array) -> Vector2:
	return ORIGIN + Vector2(position[0], position[1]) * CELL + Vector2.ONE * (CELL - 3) * 0.5


func _codes(errors: Array) -> String:
	var codes: PackedStringArray = []
	for error in errors:
		codes.append(error.code)
	return ", ".join(codes)

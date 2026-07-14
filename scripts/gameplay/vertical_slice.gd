extends Node2D

const LevelLoader = preload("res://scripts/simulation/level_loader.gd")
const Simulation = preload("res://scripts/simulation/simulation.gd")
const LEVEL_PATH := "res://data/levels/vertical_slice_delay_3.json"
const CELL := 54.0
const ORIGIN := Vector2(48, 150)

var level: Dictionary = {}
var state: Dictionary = {}
var load_error := ""
var simulation := Simulation.new()

@onready var status_label: Label = $Hud/Status
@onready var history_label: Label = $Hud/History


func _ready() -> void:
	var loaded := LevelLoader.new().load_file(LEVEL_PATH)
	if not loaded.ok:
		load_error = "INVALID_LEVEL: " + _codes(loaded.errors)
		printerr(load_error)
	else:
		level = loaded.level
		state = simulation.construct_initial_state(level)
	_update_hud()
	queue_redraw()


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
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
		var result := simulation.transition(level, state, action)
		if result.ok:
			state = result.state
		else:
			printerr(result.status)
		_update_hud()
		queue_redraw()


func is_runtime_ready() -> bool:
	return load_error == "" and not level.is_empty() and not state.is_empty() and status_label != null and history_label != null


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
	draw_circle(exit_position, 21, Color("60a5fa", 0.25))
	draw_arc(exit_position, 21, 0, TAU, 32, Color("93c5fd"), 4)
	for echo in state.echo_positions:
		draw_circle(_center(echo.position), 16, Color("a78bfa", 0.72))
		draw_arc(_center(echo.position), 20, 0, TAU, 24, Color("ddd6fe"), 2)
	draw_circle(_center(state.player_position), 15, Color("f8fafc"))
	draw_circle(_center(state.player_position), 7, Color("22d3ee"))


func _update_hud() -> void:
	if load_error != "":
		status_label.text = "Level load failed\n" + load_error
		history_label.text = ""
		return
	var delay: int = level.echoes[0].delay
	status_label.text = "THREE TURNS LATE\n\nTurn: %d\nEcho delay: %d\nDoor: %s\n\n%s" % [state.turn_index, delay, "OPEN" if state.door_states[0].open else "CLOSED", "COMPLETE — press R to restart" if state.completed else "Let your echo hold the plate."]
	history_label.text = "History (oldest → newest)\n%s\n\nMove: Arrow keys / WASD\nWait: Space    Restart: R    Quit: Esc" % "  •  ".join(state.history)


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

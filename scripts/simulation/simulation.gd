class_name DelayedSelfSimulation
extends RefCounted

const ACTIONS := ["UP", "RIGHT", "DOWN", "LEFT", "WAIT"]
const DELTAS := {"UP": [0, -1], "RIGHT": [1, 0], "DOWN": [0, 1], "LEFT": [-1, 0], "WAIT": [0, 0]}


func construct_initial_state(level: Dictionary) -> Dictionary:
	var echoes: Array = []
	var max_delay := 0
	for echo in level.get("echoes", []):
		echoes.append({"id": echo.id, "position": echo.spawn.duplicate()})
		max_delay = maxi(max_delay, int(echo.delay))
	echoes.sort_custom(func(a, b): return a.id < b.id)
	var doors: Array = []
	for door in level.get("doors", []):
		doors.append({"id": door.id, "open": door.initial_open})
	doors.sort_custom(func(a, b): return a.id < b.id)
	var history: Array = []
	for ignored in max_delay:
		history.append("WAIT")
	return {"turn_index": 1, "player_position": level.player_spawn.duplicate(), "echo_positions": echoes, "door_states": doors, "history": history, "completed": false}


func restart(level: Dictionary) -> Dictionary:
	var state := construct_initial_state(level)
	return _success(state, {"player": null, "echoes": _null_echo_actions(level)}, pressed_plate_ids(level, state))


func transition(level: Dictionary, state: Dictionary, action) -> Dictionary:
	if not action is String or not ACTIONS.has(action):
		return {"ok": false, "status": "INVALID_ACTION", "state": state.duplicate(true)}
	var state_error := _validate_state(level, state)
	if state_error != "":
		return {"ok": false, "status": "INVALID_STATE", "detail": state_error, "state": state.duplicate(true)}
	if state.completed:
		return {"ok": false, "status": "TERMINAL_STATE", "state": state.duplicate(true)}
	var next: Dictionary = state.duplicate(true)
	var actor_actions := {"player": action, "echoes": []}
	var closed_doors := {}
	for door_state in state.door_states:
		if not door_state.open:
			closed_doors[_door_position(level, door_state.id)] = true
	next.player_position = _destination(level, state.player_position, action, closed_doors)
	for index in state.echo_positions.size():
		var echo_state = state.echo_positions[index]
		var echo_action := echo_action_for_state(level, state, echo_state.id)
		actor_actions.echoes.append({"id": echo_state.id, "action": echo_action})
		next.echo_positions[index].position = _destination(level, echo_state.position, echo_action, closed_doors)
	var pressed := pressed_plate_ids(level, next)
	for door_index in next.door_states.size():
		var door_definition = _find_by_id(level.doors, next.door_states[door_index].id)
		var open := true
		for plate_id in door_definition.all_plate_ids:
			open = open and pressed.has(plate_id)
		next.door_states[door_index].open = open
	next.completed = next.player_position == level.exit.position
	if not next.history.is_empty():
		next.history.pop_front()
		next.history.append(action)
	next.turn_index += 1
	return _success(next, actor_actions, pressed)


func echo_action_for_state(level: Dictionary, state: Dictionary, echo_id: String) -> String:
	var echo_definition := _find_by_id(level.get("echoes", []), echo_id)
	if echo_definition.is_empty():
		return "WAIT"
	var history: Array = state.get("history", [])
	var index := history.size() - int(echo_definition.delay)
	if index < 0 or index >= history.size():
		return "WAIT"
	var action = history[index]
	return action if action is String and ACTIONS.has(action) else "WAIT"


func replay(level: Dictionary, actions: Array, start_state = null) -> Dictionary:
	var state: Dictionary = construct_initial_state(level) if start_state == null else start_state.duplicate(true)
	var transitions: Array = []
	var keys: Array = [canonical_key(state)]
	for action in actions:
		var result := transition(level, state, action)
		if not result.ok:
			return {"ok": false, "status": result.status, "state": state, "transitions": transitions, "canonical_keys": keys}
		state = result.state
		transitions.append(result)
		keys.append(canonical_key(state))
	return {"ok": true, "status": "REPLAYED", "state": state, "transitions": transitions, "canonical_keys": keys}


func canonical_key(state: Dictionary) -> String:
	var echoes: Array = []
	for echo in state.echo_positions:
		echoes.append([echo.id, int(echo.position[0]), int(echo.position[1])])
	var doors: Array = []
	for door in state.door_states:
		doors.append([door.id, door.open])
	return JSON.stringify([[int(state.player_position[0]), int(state.player_position[1])], echoes, doors, state.history, state.completed], "", false)


func pressed_plate_ids(level: Dictionary, state: Dictionary) -> Array:
	var occupied := {_position_key(state.player_position): true}
	for echo in state.echo_positions:
		occupied[_position_key(echo.position)] = true
	var pressed: Array = []
	for plate in level.get("plates", []):
		if occupied.has(_position_key(plate.position)):
			pressed.append(plate.id)
	pressed.sort()
	return pressed


func _validate_state(level: Dictionary, state: Dictionary) -> String:
	var required := ["turn_index", "player_position", "echo_positions", "door_states", "history", "completed"]
	for field in required:
		if not state.has(field):
			return "missing_%s" % field
	if not _integer_number(state.turn_index) or state.turn_index < 1 or typeof(state.completed) != TYPE_BOOL:
		return "scalar_shape"
	if not _valid_position(level, state.player_position, true):
		return "player_position"
	var max_delay := 0
	if not state.echo_positions is Array or state.echo_positions.size() != level.get("echoes", []).size():
		return "echo_set"
	for index in level.get("echoes", []).size():
		var definition = level.echoes[index]
		var value = state.echo_positions[index]
		max_delay = maxi(max_delay, int(definition.delay))
		if not value is Dictionary or value.get("id") != definition.id or not _valid_position(level, value.get("position"), true):
			return "echo_state"
	if not state.door_states is Array or state.door_states.size() != level.get("doors", []).size():
		return "door_set"
	for index in level.get("doors", []).size():
		var door_state = state.door_states[index]
		if not door_state is Dictionary or door_state.get("id") != level.doors[index].id or typeof(door_state.get("open")) != TYPE_BOOL:
			return "door_state"
	if not state.history is Array or state.history.size() != max_delay:
		return "history_size"
	for item in state.history:
		if not item is String or not ACTIONS.has(item):
			return "history_action"
	var pressed := pressed_plate_ids(level, state)
	for index in level.get("doors", []).size():
		var expected := true
		for plate_id in level.doors[index].all_plate_ids:
			expected = expected and pressed.has(plate_id)
		if state.door_states[index].open != expected:
			return "door_invariant"
	if state.completed != (state.player_position == level.exit.position):
		return "completion_invariant"
	return ""


func _valid_position(level: Dictionary, position, allow_door: bool) -> bool:
	if not position is Array or position.size() != 2 or not _integer_number(position[0]) or not _integer_number(position[1]):
		return false
	if position[1] < 0 or position[1] >= level.terrain_rows.size() or position[0] < 0 or position[0] >= level.terrain_rows[0].length():
		return false
	return level.terrain_rows[position[1]][position[0]] == "."


func _destination(level: Dictionary, origin: Array, action: String, closed_doors: Dictionary) -> Array:
	var delta: Array = DELTAS[action]
	var proposed := [origin[0] + delta[0], origin[1] + delta[1]]
	if not _valid_position(level, proposed, true) or closed_doors.has(_position_key(proposed)):
		return origin.duplicate()
	return proposed


func _door_position(level: Dictionary, door_id: String) -> String:
	return _position_key(_find_by_id(level.doors, door_id).position)


func _find_by_id(items: Array, id: String) -> Dictionary:
	for item in items:
		if item.id == id:
			return item
	return {}


func _null_echo_actions(level: Dictionary) -> Array:
	var result: Array = []
	for echo in level.get("echoes", []):
		result.append({"id": echo.id, "action": null})
	return result


func _success(state: Dictionary, actor_actions: Dictionary, pressed: Array) -> Dictionary:
	return {"ok": true, "status": "OK", "state": state, "actor_actions": actor_actions, "pressed_plate_ids": pressed, "canonical_key": canonical_key(state)}


func _position_key(position: Array) -> String:
	return "%d,%d" % [int(position[0]), int(position[1])]


func _integer_number(value) -> bool:
	return typeof(value) == TYPE_INT or (typeof(value) == TYPE_FLOAT and is_finite(value) and value == floor(value))

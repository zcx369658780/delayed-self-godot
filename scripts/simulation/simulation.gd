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
	for door in level.get("doors", []): doors.append({"id": door.id, "open": door.initial_open})
	doors.sort_custom(func(a, b): return a.id < b.id)
	var history: Array = []
	for ignored in max_delay: history.append("WAIT")
	var state := {"turn_index": 1, "player_position": level.player_spawn.duplicate(), "echo_positions": echoes, "door_states": doors, "history": history, "completed": false}
	if _is_v2(level):
		var crates: Array = []
		for crate in level.crates: crates.append({"id": crate.id, "position": crate.position.duplicate()})
		crates.sort_custom(func(a, b): return a.id < b.id)
		var barriers: Array = []
		for group in level.barrier_groups: barriers.append({"id": group.id, "open": group.initial_open})
		barriers.sort_custom(func(a, b): return a.id < b.id)
		var keys: Array = []
		for key in level.keys: keys.append(key.id)
		keys.sort()
		var latches: Array = []
		for latch in level.latches: latches.append({"id": latch.id, "activated": false})
		latches.sort_custom(func(a, b): return a.id < b.id)
		state["barrier_states"] = barriers
		state["crate_positions"] = crates
		state["remaining_key_ids"] = keys
		state["held_keys"] = []
		state["removed_lock_ids"] = []
		state["latch_states"] = latches
	return state


func restart(level: Dictionary) -> Dictionary:
	var state := construct_initial_state(level)
	return _success(state, {"player": null, "echoes": _null_echo_actions(level)}, pressed_plate_ids(level, state))


func transition(level: Dictionary, state: Dictionary, action) -> Dictionary:
	if not action is String or not ACTIONS.has(action): return {"ok": false, "status": "INVALID_ACTION", "state": state.duplicate(true)}
	var state_error := _validate_state(level, state)
	if state_error != "": return {"ok": false, "status": "INVALID_STATE", "detail": state_error, "state": state.duplicate(true)}
	if state.completed: return {"ok": false, "status": "TERMINAL_STATE", "state": state.duplicate(true)}
	return _transition_v2(level, state, action) if _is_v2(level) else _transition_v1(level, state, action)


func _transition_v1(level: Dictionary, state: Dictionary, action: String) -> Dictionary:
	var next: Dictionary = state.duplicate(true)
	var actor_actions := {"player": action, "echoes": []}
	var closed_doors := {}
	for door_state in state.door_states:
		if not door_state.open: closed_doors[_door_position(level, door_state.id)] = true
	next.player_position = _destination(level, state.player_position, action, closed_doors)
	for index in state.echo_positions.size():
		var echo_state = state.echo_positions[index]
		var echo_action := echo_action_for_state(level, state, echo_state.id)
		actor_actions.echoes.append({"id": echo_state.id, "action": echo_action})
		next.echo_positions[index].position = _destination(level, echo_state.position, echo_action, closed_doors)
	var pressed := pressed_plate_ids(level, next)
	for door_index in next.door_states.size():
		var definition = _find_by_id(level.doors, next.door_states[door_index].id)
		var open := true
		for plate_id in definition.all_plate_ids: open = open and pressed.has(plate_id)
		next.door_states[door_index].open = open
	next.completed = next.player_position == level.exit.position
	_shift_history(next, action)
	return _success(next, actor_actions, pressed)


func _transition_v2(level: Dictionary, state: Dictionary, action: String) -> Dictionary:
	var next: Dictionary = state.duplicate(true)
	var actor_actions := {"player": action, "echoes": []}
	var blocked := _blocked_cells_v2(level, state)
	var crate_by_cell := _crates_by_cell(state)
	var crate_move := {}
	var player_destination := _proposed(state.player_position, action)
	if crate_by_cell.has(_position_key(player_destination)) and action != "WAIT":
		var pushed := _proposed(player_destination, action)
		if _traversable_v2(level, pushed, blocked) and not crate_by_cell.has(_position_key(pushed)) and not _actor_occupies(state, pushed):
			crate_move = {"from": player_destination, "to": pushed}
			player_destination = player_destination
		else:
			player_destination = state.player_position.duplicate()
	elif not _traversable_v2(level, player_destination, blocked):
		var lock := _lock_at(level, player_destination)
		if not lock.is_empty() and state.held_keys.has(lock.key_type):
			next.held_keys.erase(lock.key_type)
			next.removed_lock_ids.append(lock.id)
			next.removed_lock_ids.sort()
			player_destination = player_destination
		else:
			player_destination = state.player_position.duplicate()
	next.player_position = player_destination
	for index in state.echo_positions.size():
		var echo_state = state.echo_positions[index]
		var echo_action := echo_action_for_state(level, state, echo_state.id)
		actor_actions.echoes.append({"id": echo_state.id, "action": echo_action})
		var destination := _proposed(echo_state.position, echo_action)
		if not _traversable_v2(level, destination, blocked) or crate_by_cell.has(_position_key(destination)) or (not crate_move.is_empty() and destination == crate_move.to): destination = echo_state.position.duplicate()
		next.echo_positions[index].position = destination
	if not crate_move.is_empty():
		for crate in next.crate_positions:
			if crate.position == crate_move.from: crate.position = crate_move.to.duplicate()
	for key_id in state.remaining_key_ids.duplicate():
		var definition := _find_by_id(level.keys, key_id)
		if not definition.is_empty() and next.player_position == definition.position:
			next.remaining_key_ids.erase(key_id)
			next.held_keys.append(definition.key_type)
			next.held_keys.sort()
	var pressed := pressed_plate_ids(level, next)
	var sensor_ids := pressed_sensor_ids(level, next)
	for latch_state in next.latch_states:
		if latch_state.activated: continue
		var latch := _find_by_id(level.latches, latch_state.id)
		if _activator_pressed(latch.activator, latch.position, next): latch_state.activated = true
	for door_index in next.door_states.size():
		var door = _find_by_id(level.doors, next.door_states[door_index].id)
		var open := true
		for plate_id in door.all_plate_ids: open = open and pressed.has(plate_id)
		next.door_states[door_index].open = open
	for group_state in next.barrier_states:
		var group := _find_by_id(level.barrier_groups, group_state.id)
		var requested_open := true
		for sensor_id in group.all_sensor_ids: requested_open = requested_open and sensor_ids.has(sensor_id)
		for latch_state in next.latch_states:
			var latch := _find_by_id(level.latches, latch_state.id)
			if latch_state.activated and latch.target_barrier_group_id == group.id: requested_open = latch.target_open
		if not requested_open and _group_occupied(group, next): requested_open = true
		group_state.open = requested_open
	next.completed = next.player_position == level.exit.position
	_shift_history(next, action)
	var result := _success(next, actor_actions, pressed)
	result["pressed_sensor_ids"] = sensor_ids
	return result


func echo_action_for_state(level: Dictionary, state: Dictionary, echo_id: String) -> String:
	var index := echo_history_index_for_state(level, state, echo_id)
	var history: Array = state.get("history", [])
	if index < 0 or index >= history.size(): return "WAIT"
	var action = history[index]
	return action if action is String and ACTIONS.has(action) else "WAIT"


func echo_history_index_for_state(level: Dictionary, state: Dictionary, echo_id: String) -> int:
	var definition := _find_by_id(level.get("echoes", []), echo_id)
	if definition.is_empty() or not state.get("history", []) is Array: return -1
	var index: int = state.history.size() - int(definition.delay)
	return index if index >= 0 and index < state.history.size() else -1


func replay(level: Dictionary, actions: Array, start_state = null) -> Dictionary:
	var state: Dictionary = construct_initial_state(level) if start_state == null else start_state.duplicate(true)
	var transitions: Array = []
	var keys: Array = [canonical_key(state)]
	for action in actions:
		var result := transition(level, state, action)
		if not result.ok: return {"ok": false, "status": result.status, "state": state, "transitions": transitions, "canonical_keys": keys}
		state = result.state; transitions.append(result); keys.append(canonical_key(state))
	return {"ok": true, "status": "REPLAYED", "state": state, "transitions": transitions, "canonical_keys": keys}


func canonical_key(state: Dictionary) -> String:
	var echoes: Array = []
	for echo in state.echo_positions: echoes.append([echo.id, int(echo.position[0]), int(echo.position[1])])
	var doors: Array = []
	for door in state.door_states: doors.append([door.id, door.open])
	if not state.has("barrier_states"): return JSON.stringify([[int(state.player_position[0]), int(state.player_position[1])], echoes, doors, state.history, state.completed], "", false)
	var barriers: Array = []; for barrier in state.barrier_states: barriers.append([barrier.id, barrier.open])
	var crates: Array = []; for crate in state.crate_positions: crates.append([crate.id, int(crate.position[0]), int(crate.position[1])])
	var latches: Array = []; for latch in state.latch_states: latches.append([latch.id, latch.activated])
	return JSON.stringify([[int(state.player_position[0]), int(state.player_position[1])], echoes, doors, barriers, crates, state.remaining_key_ids, state.held_keys, state.removed_lock_ids, latches, state.history, state.completed], "", false)


func pressed_plate_ids(level: Dictionary, state: Dictionary) -> Array:
	var occupied := {_position_key(state.player_position): true}
	for echo in state.echo_positions: occupied[_position_key(echo.position)] = true
	var pressed: Array = []
	for plate in level.get("plates", []):
		if occupied.has(_position_key(plate.position)): pressed.append(plate.id)
	pressed.sort()
	return pressed


func pressed_sensor_ids(level: Dictionary, state: Dictionary) -> Array:
	var result: Array = []
	for sensor in level.get("sensors", []):
		if _activator_pressed(sensor.activator, sensor.position, state) or (sensor.include_crates and _crates_by_cell(state).has(_position_key(sensor.position))): result.append(sensor.id)
	result.sort()
	return result


func _validate_state(level: Dictionary, state: Dictionary) -> String:
	var required := ["turn_index", "player_position", "echo_positions", "door_states", "history", "completed"]
	if _is_v2(level): required.append_array(["barrier_states", "crate_positions", "remaining_key_ids", "held_keys", "removed_lock_ids", "latch_states"])
	for field in required:
		if not state.has(field): return "missing_%s" % field
	if not _integer_number(state.turn_index) or state.turn_index < 1 or typeof(state.completed) != TYPE_BOOL or not _valid_position(level, state.player_position): return "scalar_shape"
	var max_delay := 0
	if not state.echo_positions is Array or state.echo_positions.size() != level.get("echoes", []).size(): return "echo_set"
	for index in level.get("echoes", []).size():
		var definition = level.echoes[index]; var value = state.echo_positions[index]; max_delay = maxi(max_delay, int(definition.delay))
		if not value is Dictionary or value.get("id") != definition.id or not _valid_position(level, value.get("position")): return "echo_state"
	if not state.door_states is Array or state.door_states.size() != level.get("doors", []).size(): return "door_set"
	for index in level.get("doors", []).size():
		var door_state = state.door_states[index]
		if not door_state is Dictionary or door_state.get("id") != level.doors[index].id or typeof(door_state.get("open")) != TYPE_BOOL: return "door_state"
	if not state.history is Array or state.history.size() != max_delay: return "history_size"
	for item in state.history:
		if not item is String or not ACTIONS.has(item): return "history_action"
	var pressed := pressed_plate_ids(level, state)
	for index in level.get("doors", []).size():
		var expected := true
		for plate_id in level.doors[index].all_plate_ids: expected = expected and pressed.has(plate_id)
		if state.door_states[index].open != expected: return "door_invariant"
	if _is_v2(level):
		if not state.crate_positions is Array or state.crate_positions.size() != level.crates.size(): return "crate_set"
		for index in level.crates.size():
			if state.crate_positions[index].id != level.crates[index].id or not _valid_position(level, state.crate_positions[index].position): return "crate_state"
		if not state.barrier_states is Array or state.barrier_states.size() != level.barrier_groups.size(): return "barrier_set"
		for index in level.barrier_groups.size():
			if state.barrier_states[index].id != level.barrier_groups[index].id or typeof(state.barrier_states[index].open) != TYPE_BOOL: return "barrier_state"
		for lock_id in state.removed_lock_ids:
			if _find_by_id(level.locks, lock_id).is_empty(): return "removed_lock"
	if state.completed != (state.player_position == level.exit.position): return "completion_invariant"
	return ""


func _is_v2(level: Dictionary) -> bool: return int(level.get("schema_version", 1)) == 2
func _valid_position(level: Dictionary, position) -> bool:
	if not position is Array or position.size() != 2 or not _integer_number(position[0]) or not _integer_number(position[1]): return false
	return position[1] >= 0 and position[1] < level.terrain_rows.size() and position[0] >= 0 and position[0] < level.terrain_rows[0].length() and level.terrain_rows[position[1]][position[0]] == "."
func _proposed(origin: Array, action: String) -> Array:
	var delta: Array = DELTAS[action]; return [origin[0] + delta[0], origin[1] + delta[1]]
func _destination(level: Dictionary, origin: Array, action: String, closed: Dictionary) -> Array:
	var proposed := _proposed(origin, action); return origin.duplicate() if not _valid_position(level, proposed) or closed.has(_position_key(proposed)) else proposed
func _blocked_cells_v2(level: Dictionary, state: Dictionary) -> Dictionary:
	var blocked := {}
	for door in state.door_states:
		if not door.open: blocked[_door_position(level, door.id)] = true
	for barrier in state.barrier_states:
		if not barrier.open:
			for cell in _find_by_id(level.barrier_groups, barrier.id).cells: blocked[_position_key(cell)] = true
	for lock in level.locks:
		if not state.removed_lock_ids.has(lock.id): blocked[_position_key(lock.position)] = true
	return blocked
func _traversable_v2(level: Dictionary, position: Array, blocked: Dictionary) -> bool: return _valid_position(level, position) and not blocked.has(_position_key(position))
func _crates_by_cell(state: Dictionary) -> Dictionary:
	var result := {}
	for crate in state.get("crate_positions", []): result[_position_key(crate.position)] = crate.id
	return result
func _actor_occupies(state: Dictionary, position: Array) -> bool:
	if state.player_position == position: return true
	for echo in state.echo_positions:
		if echo.position == position: return true
	return false
func _lock_at(level: Dictionary, position: Array) -> Dictionary:
	for lock in level.get("locks", []):
		if lock.position == position: return lock
	return {}
func _activator_pressed(activator: String, position: Array, state: Dictionary) -> bool:
	if (activator == "ANY_ACTOR" or activator == "YOU_ONLY") and state.player_position == position: return true
	if activator == "ANY_ACTOR" or activator == "ECHO_ONLY":
		for echo in state.echo_positions:
			if echo.position == position: return true
	return false
func _group_occupied(group: Dictionary, state: Dictionary) -> bool:
	for cell in group.cells:
		if _actor_occupies(state, cell) or _crates_by_cell(state).has(_position_key(cell)): return true
	return false
func _door_position(level: Dictionary, door_id: String) -> String: return _position_key(_find_by_id(level.doors, door_id).position)
func _find_by_id(items: Array, id: String) -> Dictionary:
	for item in items:
		if item.id == id: return item
	return {}
func _shift_history(state: Dictionary, action: String) -> void:
	if not state.history.is_empty(): state.history.pop_front(); state.history.append(action)
	state.turn_index += 1
func _null_echo_actions(level: Dictionary) -> Array:
	var result: Array = []
	for echo in level.get("echoes", []):
		result.append({"id": echo.id, "action": null})
	return result
func _success(state: Dictionary, actor_actions: Dictionary, pressed: Array) -> Dictionary: return {"ok": true, "status": "OK", "state": state, "actor_actions": actor_actions, "pressed_plate_ids": pressed, "canonical_key": canonical_key(state)}
func _position_key(position: Array) -> String: return "%d,%d" % [int(position[0]), int(position[1])]
func _integer_number(value) -> bool: return typeof(value) == TYPE_INT or (typeof(value) == TYPE_FLOAT and is_finite(value) and value == floor(value))

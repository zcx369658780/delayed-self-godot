class_name SchemaV2Presentation
extends RefCounted

## Pure, simulation-derived descriptors for the minimum schema-v2 visual language.
## Bounds are scalar dictionaries so snapshots remain JSON-safe and detached from Godot objects.

static func build(level: Dictionary, state: Dictionary, board_rect: Rect2, cell_pitch: float, content_area: Rect2) -> Array:
	if int(level.get("schema_version", 1)) != 2 or state.is_empty():
		return []
	var descriptors: Array = []
	var key_tokens := _numbered_tokens(level.get("keys", []), "key_type", "K")
	var group_tokens := _numbered_tokens(level.get("barrier_groups", []), "id", "G")
	var groups := _by_id(level.get("barrier_groups", []))
	var barriers := _by_id(state.get("barrier_states", []))
	var latches := _by_id(state.get("latch_states", []))
	var occupied := _occupied_cells(state)
	var crates := _crate_cells(state)

	for crate in state.get("crate_positions", []):
		descriptors.append(_cell_descriptor("crate", "crate:%s" % crate.id, crate.position, 2, "BOX_CROSS", "CR", "", "CRATE_BOX_CROSS", board_rect, cell_pitch, content_area, "MUTABLE"))
	for key in level.get("keys", []):
		if state.get("remaining_key_ids", []).has(key.id):
			descriptors.append(_cell_descriptor("floor_key", "key:%s" % key.id, key.position, 2, "KEY_TEETH", "K", key_tokens.get(key.key_type, "K?"), "KEY_TEETH_%s" % key_tokens.get(key.key_type, "K?"), board_rect, cell_pitch, content_area, "ON_FLOOR"))
	for lock in level.get("locks", []):
		if not state.get("removed_lock_ids", []).has(lock.id):
			descriptors.append(_cell_descriptor("lock", "lock:%s" % lock.id, lock.position, 2, "LOCK_CROSSBAR", "L", key_tokens.get(lock.key_type, "K?"), "LOCK_CROSSBAR_%s" % key_tokens.get(lock.key_type, "K?"), board_rect, cell_pitch, content_area, "LOCKED"))
	for sensor in level.get("sensors", []):
		var active := _sensor_active(sensor, state, crates)
		var activator: String = sensor.get("activator", "ANY_ACTOR")
		var groups_for_sensor := _groups_for_sensor(level.get("barrier_groups", []), sensor.id, group_tokens)
		var suffix := "ACTIVE_RING" if active else "INACTIVE_FRAME"
		descriptors.append(_cell_descriptor("sensor", "sensor:%s" % sensor.id, sensor.position, 1, "SENSOR_%s_%s" % [activator, suffix], _sensor_glyph(activator), ",".join(groups_for_sensor), "SENSOR_%s_%s" % [activator, suffix], board_rect, cell_pitch, content_area, "%s_%s" % [activator, "ACTIVE" if active else "INACTIVE"]))
	for group in level.get("barrier_groups", []):
		var barrier_state: Dictionary = barriers.get(group.id, {})
		var requested := _requested_open(group, level, state, crates, latches)
		var effective := bool(barrier_state.get("open", group.get("initial_open", false)))
		var occupied_group := _group_occupied(group, occupied, crates)
		var deferred := not requested and effective and occupied_group
		var variant := "OPEN_DEFERRED" if deferred else ("OPEN" if effective else "CLOSED")
		var source := _open_source(group, level, state, crates, latches)
		for cell in group.get("cells", []):
			var descriptor := _cell_descriptor("barrier", "barrier:%s:%d:%d" % [group.id, int(cell[0]), int(cell[1])], cell, 1 if effective else 2, "BARRIER_%s" % variant, "G", group_tokens.get(group.id, "G?"), "BARRIER_%s_%s" % [variant, group_tokens.get(group.id, "G?")], board_rect, cell_pitch, content_area, variant)
			descriptor["requested_open"] = requested
			descriptor["effective_open"] = effective
			descriptor["closure_deferred"] = deferred
			descriptor["open_source"] = source
			descriptors.append(descriptor)
	for latch in level.get("latches", []):
		var activated := bool(latches.get(latch.id, {}).get("activated", false))
		var target: String = latch.get("target_barrier_group_id", "")
		var variant := "ACTIVATED" if activated else "INACTIVE"
		descriptors.append(_cell_descriptor("latch", "latch:%s" % latch.id, latch.position, 2, "LATCH_%s" % variant, "✓" if activated else "◇", group_tokens.get(target, "G?"), "LATCH_%s" % variant, board_rect, cell_pitch, content_area, variant))
	var held: Array = state.get("held_keys", []).duplicate()
	held.sort()
	for index in held.size():
		var token: String = key_tokens.get(held[index], "K?")
		var x := content_area.position.x + content_area.size.x - 82.0
		var y := content_area.position.y + 12.0 + float(index) * 28.0
		descriptors.append({"family": "held_key", "stable_id": "held_key:%s:%d" % [held[index], index], "cell": [], "position": {"x": x, "y": y}, "layer": 5, "state_variant": "HELD", "shape_token": "INVENTORY_KEY", "glyph_token": "K", "type_group_token": token, "bounds": _bounds(Rect2(x, y, 70, 22)), "monochrome_signature": "INVENTORY_KEY_%s" % token})
	descriptors.sort_custom(func(a: Dictionary, b: Dictionary): return a.stable_id < b.stable_id if int(a.layer) == int(b.layer) else int(a.layer) < int(b.layer))
	return descriptors.duplicate(true)


static func _cell_descriptor(family: String, stable_id: String, cell: Array, layer: int, shape: String, glyph: String, token: String, signature: String, board_rect: Rect2, cell_pitch: float, content_area: Rect2, variant: String) -> Dictionary:
	var rect := Rect2(board_rect.position + Vector2(int(cell[0]), int(cell[1])) * cell_pitch + Vector2(7, 7), Vector2(cell_pitch - 17, cell_pitch - 17)).intersection(content_area)
	return {"family": family, "stable_id": stable_id, "cell": [int(cell[0]), int(cell[1])], "position": {"x": rect.get_center().x, "y": rect.get_center().y}, "layer": layer, "state_variant": variant, "shape_token": shape, "glyph_token": glyph, "type_group_token": token, "bounds": _bounds(rect), "monochrome_signature": signature}


static func _bounds(rect: Rect2) -> Dictionary:
	return {"x": rect.position.x, "y": rect.position.y, "width": rect.size.x, "height": rect.size.y}


static func _numbered_tokens(items: Array, field: String, prefix: String) -> Dictionary:
	var values: Array = []
	for item in items:
		var value = item.get(field, "")
		if value is String and not values.has(value): values.append(value)
	values.sort()
	var result := {}
	for index in values.size(): result[values[index]] = "%s%d" % [prefix, index + 1]
	return result


static func _by_id(items: Array) -> Dictionary:
	var result := {}
	for item in items:
		if item is Dictionary: result[item.get("id", "")] = item
	return result


static func _occupied_cells(state: Dictionary) -> Dictionary:
	var result := {_cell_key(state.get("player_position", [])): true}
	for echo in state.get("echo_positions", []): result[_cell_key(echo.get("position", []))] = true
	return result


static func _crate_cells(state: Dictionary) -> Dictionary:
	var result := {}
	for crate in state.get("crate_positions", []): result[_cell_key(crate.get("position", []))] = true
	return result


static func _cell_key(cell: Array) -> String:
	return "%d,%d" % [int(cell[0]) if cell.size() > 0 else -1, int(cell[1]) if cell.size() > 1 else -1]


static func _sensor_active(sensor: Dictionary, state: Dictionary, crates: Dictionary) -> bool:
	var position: Array = sensor.get("position", [])
	var activator: String = sensor.get("activator", "")
	if (activator == "ANY_ACTOR" or activator == "YOU_ONLY") and state.get("player_position", []) == position: return true
	if activator == "ANY_ACTOR" or activator == "ECHO_ONLY":
		for echo in state.get("echo_positions", []):
			if echo.get("position", []) == position: return true
	return bool(sensor.get("include_crates", false)) and crates.has(_cell_key(position))


static func _requested_open(group: Dictionary, level: Dictionary, state: Dictionary, crates: Dictionary, latches: Dictionary) -> bool:
	var sensors := _by_id(level.get("sensors", []))
	var requested := true
	for sensor_id in group.get("all_sensor_ids", []): requested = requested and _sensor_active(sensors.get(sensor_id, {}), state, crates)
	for latch in level.get("latches", []):
		if latch.get("target_barrier_group_id", "") == group.get("id", "") and bool(latches.get(latch.get("id", ""), {}).get("activated", false)):
			requested = bool(latch.get("target_open", false))
	return requested


static func _open_source(group: Dictionary, level: Dictionary, state: Dictionary, crates: Dictionary, latches: Dictionary) -> String:
	for latch in level.get("latches", []):
		if latch.get("target_barrier_group_id", "") == group.get("id", "") and bool(latches.get(latch.get("id", ""), {}).get("activated", false)): return "LATCH"
	return "SENSORS" if _requested_open(group, level, state, crates, latches) else "CLOSED_REQUEST"


static func _group_occupied(group: Dictionary, occupied: Dictionary, crates: Dictionary) -> bool:
	for cell in group.get("cells", []):
		if occupied.has(_cell_key(cell)) or crates.has(_cell_key(cell)): return true
	return false


static func _groups_for_sensor(groups: Array, sensor_id: String, tokens: Dictionary) -> Array:
	var result: Array = []
	for group in groups:
		if group.get("all_sensor_ids", []).has(sensor_id): result.append(tokens.get(group.get("id", ""), "G?"))
	result.sort()
	return result


static func _sensor_glyph(activator: String) -> String:
	return "Y" if activator == "YOU_ONLY" else ("E" if activator == "ECHO_ONLY" else "A")

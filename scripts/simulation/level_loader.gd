class_name DelayedSelfLevelLoader
extends RefCounted

const TOP_FIELDS := ["schema_version", "level_id", "title", "terrain_rows", "player_spawn", "echoes", "plates", "doors", "exit", "metadata", "validation"]
const ID_PATTERN := "^[a-z][a-z0-9]*(?:_[a-z0-9]+)*$"


func load_file(path: String) -> Dictionary:
	var file := FileAccess.open(path, FileAccess.READ)
	if file == null:
		return _invalid([_error("JSON_PARSE_ERROR", "$", "Unable to read level JSON")])
	var json := JSON.new()
	if json.parse(file.get_as_text()) != OK:
		return _invalid([_error("JSON_PARSE_ERROR", "$", json.get_error_message())])
	return validate_dict(json.data)


func validate_dict(source) -> Dictionary:
	var errors: Array = []
	if not source is Dictionary:
		return _invalid([_error("SCHEMA_SHAPE_ERROR", "$", "Top level must be an object")])
	_shape_object(source, "$", TOP_FIELDS, TOP_FIELDS, errors)
	if not source.has("schema_version") or not _integer_number(source.get("schema_version")) or int(source.get("schema_version")) != 1:
		_add(errors, "UNSUPPORTED_SCHEMA_VERSION", "$.schema_version", "Only schema version 1 is supported")
	_validate_string(source.get("level_id"), "$.level_id", 1, 64, true, errors)
	_validate_string(source.get("title"), "$.title", 1, 120, false, errors)

	var rows = source.get("terrain_rows")
	var width := 0
	var height := 0
	if not rows is Array or rows.size() < 1 or rows.size() > 64:
		_add(errors, "SCHEMA_SHAPE_ERROR", "$.terrain_rows", "Terrain must contain 1 to 64 rows")
	else:
		height = rows.size()
		for index in rows.size():
			var row = rows[index]
			if not row is String or row.length() < 1 or row.length() > 64:
				_add(errors, "SCHEMA_SHAPE_ERROR", "$.terrain_rows[%d]" % index, "Row must be a string of 1 to 64 cells")
				continue
			if index == 0:
				width = row.length()
			elif row.length() != width:
				_add(errors, "RAGGED_TERRAIN", "$.terrain_rows[%d]" % index, "Terrain rows must be rectangular")
			for character in row:
				if character != "#" and character != ".":
					_add(errors, "SCHEMA_SHAPE_ERROR", "$.terrain_rows[%d]" % index, "Terrain uses only # and .")

	_validate_coordinate(source.get("player_spawn"), "$.player_spawn", errors)
	var echoes = source.get("echoes")
	var plates = source.get("plates")
	var doors = source.get("doors")
	if not echoes is Array or echoes.size() > 8:
		_add(errors, "SCHEMA_SHAPE_ERROR", "$.echoes", "Echoes must be an array with at most 8 entries")
		echoes = []
	if not plates is Array or plates.size() > 64:
		_add(errors, "SCHEMA_SHAPE_ERROR", "$.plates", "Plates must be an array with at most 64 entries")
		plates = []
	if not doors is Array or doors.size() > 64:
		_add(errors, "SCHEMA_SHAPE_ERROR", "$.doors", "Doors must be an array with at most 64 entries")
		doors = []

	var echo_ids := {}
	for index in echoes.size():
		var item = echoes[index]
		var path := "$.echoes[%d]" % index
		if not item is Dictionary:
			_add(errors, "SCHEMA_SHAPE_ERROR", path, "Echo must be an object")
			continue
		_shape_object(item, path, ["id", "delay", "spawn"], ["id", "delay", "spawn"], errors)
		_validate_string(item.get("id"), path + ".id", 1, 64, true, errors)
		_track_id(item.get("id"), echo_ids, path + ".id", errors)
		if not _integer_number(item.get("delay")) or item.get("delay") < 1 or item.get("delay") > 16:
			_add(errors, "SCHEMA_SHAPE_ERROR", path + ".delay", "Delay must be an integer from 1 to 16")
		_validate_coordinate(item.get("spawn"), path + ".spawn", errors)

	var plate_ids := {}
	for index in plates.size():
		var item = plates[index]
		var path := "$.plates[%d]" % index
		if not item is Dictionary:
			_add(errors, "SCHEMA_SHAPE_ERROR", path, "Plate must be an object")
			continue
		_shape_object(item, path, ["id", "position"], ["id", "position"], errors)
		_validate_string(item.get("id"), path + ".id", 1, 64, true, errors)
		_track_id(item.get("id"), plate_ids, path + ".id", errors)
		_validate_coordinate(item.get("position"), path + ".position", errors)

	var door_ids := {}
	for index in doors.size():
		var item = doors[index]
		var path := "$.doors[%d]" % index
		if not item is Dictionary:
			_add(errors, "SCHEMA_SHAPE_ERROR", path, "Door must be an object")
			continue
		_shape_object(item, path, ["id", "position", "initial_open", "all_plate_ids"], ["id", "position", "initial_open", "all_plate_ids"], errors)
		_validate_string(item.get("id"), path + ".id", 1, 64, true, errors)
		_track_id(item.get("id"), door_ids, path + ".id", errors)
		_validate_coordinate(item.get("position"), path + ".position", errors)
		if typeof(item.get("initial_open")) != TYPE_BOOL:
			_add(errors, "SCHEMA_SHAPE_ERROR", path + ".initial_open", "initial_open must be boolean")
		var references = item.get("all_plate_ids")
		if not references is Array or references.size() < 1 or references.size() > 64:
			_add(errors, "SCHEMA_SHAPE_ERROR", path + ".all_plate_ids", "Door needs 1 to 64 plate references")
		else:
			var seen := {}
			for ref_index in references.size():
				var reference = references[ref_index]
				_validate_string(reference, path + ".all_plate_ids[%d]" % ref_index, 1, 64, true, errors)
				if reference is String and seen.has(reference):
					_add(errors, "DUPLICATE_PLATE_REFERENCE", path + ".all_plate_ids", "Plate reference is duplicated")
				seen[reference] = true

	var exit_data = source.get("exit")
	if not exit_data is Dictionary:
		_add(errors, "SCHEMA_SHAPE_ERROR", "$.exit", "Exit must be an object")
	else:
		_shape_object(exit_data, "$.exit", ["position"], ["position"], errors)
		_validate_coordinate(exit_data.get("position"), "$.exit.position", errors)

	var metadata = source.get("metadata")
	if not metadata is Dictionary:
		_add(errors, "SCHEMA_SHAPE_ERROR", "$.metadata", "Metadata must be an object")
		metadata = {}
	else:
		_shape_object(metadata, "$.metadata", ["teaching_goal", "intended_mechanics", "notes", "allow_zero_echo_tutorial"], ["teaching_goal", "intended_mechanics", "notes", "allow_zero_echo_tutorial"], errors)
		_validate_string(metadata.get("teaching_goal"), "$.metadata.teaching_goal", 1, 500, false, errors)
		_validate_string(metadata.get("notes"), "$.metadata.notes", 0, 2000, false, errors)
		if typeof(metadata.get("allow_zero_echo_tutorial")) != TYPE_BOOL:
			_add(errors, "SCHEMA_SHAPE_ERROR", "$.metadata.allow_zero_echo_tutorial", "Tutorial flag must be boolean")
		var mechanics = metadata.get("intended_mechanics")
		if not mechanics is Array or mechanics.size() > 32:
			_add(errors, "SCHEMA_SHAPE_ERROR", "$.metadata.intended_mechanics", "Mechanics must be an array with at most 32 items")
		else:
			var seen_mechanics := {}
			for index in mechanics.size():
				_validate_string(mechanics[index], "$.metadata.intended_mechanics[%d]" % index, 1, 64, true, errors)
				if seen_mechanics.has(mechanics[index]):
					_add(errors, "SCHEMA_SHAPE_ERROR", "$.metadata.intended_mechanics", "Mechanics must be unique")
				seen_mechanics[mechanics[index]] = true

	var validation = source.get("validation")
	if not validation is Dictionary:
		_add(errors, "SCHEMA_SHAPE_ERROR", "$.validation", "Validation must be an object")
	else:
		_shape_object(validation, "$.validation", ["recommended_search_depth"], ["recommended_search_depth", "expected_min_turns"], errors)
		_validate_bounded_int(validation.get("recommended_search_depth"), "$.validation.recommended_search_depth", 1, 10000, errors)
		if validation.has("expected_min_turns"):
			_validate_bounded_int(validation.get("expected_min_turns"), "$.validation.expected_min_turns", 1, 10000, errors)

	if echoes.is_empty() and metadata.get("allow_zero_echo_tutorial") != true:
		_add(errors, "ECHO_REQUIRED", "$.echoes", "Zero-echo levels require the explicit tutorial flag")

	_cross_validate(source, rows, width, height, echoes, plates, doors, plate_ids, errors)
	if not errors.is_empty():
		return _invalid(errors)
	var normalized: Dictionary = source.duplicate(true)
	_normalize_numbers(normalized)
	normalized["echoes"].sort_custom(func(a, b): return a["id"] < b["id"])
	normalized["plates"].sort_custom(func(a, b): return a["id"] < b["id"])
	normalized["doors"].sort_custom(func(a, b): return a["id"] < b["id"])
	for door in normalized["doors"]:
		door["all_plate_ids"].sort()
	return {"ok": true, "status": "VALID_LEVEL", "errors": [], "level": normalized}


func _cross_validate(source: Dictionary, rows, width: int, height: int, echoes: Array, plates: Array, doors: Array, plate_ids: Dictionary, errors: Array) -> void:
	var positions := {}
	var actors: Array = [{"path": "$.player_spawn", "position": source.get("player_spawn")}]
	for index in echoes.size():
		if echoes[index] is Dictionary:
			actors.append({"path": "$.echoes[%d].spawn" % index, "position": echoes[index].get("spawn")})
	for actor in actors:
		_check_placement(actor.position, actor.path, rows, width, height, errors)
	for index in plates.size():
		if plates[index] is Dictionary:
			_check_static(plates[index].get("position"), "$.plates[%d].position" % index, rows, width, height, positions, errors)
	for index in doors.size():
		if doors[index] is Dictionary:
			_check_static(doors[index].get("position"), "$.doors[%d].position" % index, rows, width, height, positions, errors)
	var exit_position = source.get("exit", {}).get("position") if source.get("exit") is Dictionary else null
	_check_static(exit_position, "$.exit.position", rows, width, height, positions, errors)
	var forbidden := {}
	for door in doors:
		if door is Dictionary and _coordinate_ok(door.get("position")):
			forbidden[_coord_key(door["position"])] = true
	if _coordinate_ok(exit_position):
		forbidden[_coord_key(exit_position)] = true
	for actor in actors:
		if _coordinate_ok(actor.position) and forbidden.has(_coord_key(actor.position)):
			_add(errors, "ACTOR_ON_FORBIDDEN_STATIC", actor.path, "Actor spawn overlaps a door or exit")
	var occupied := {}
	for actor in actors:
		if _coordinate_ok(actor.position):
			occupied[_coord_key(actor.position)] = true
	for index in doors.size():
		var door = doors[index]
		if not door is Dictionary:
			continue
		var references = door.get("all_plate_ids", [])
		if references is Array:
			for reference in references:
				if reference is String and not plate_ids.has(reference):
					_add(errors, "UNKNOWN_PLATE_REFERENCE", "$.doors[%d].all_plate_ids" % index, "Door references an unknown plate")
		var should_open := true
		for reference in references if references is Array else []:
			var found := false
			for plate in plates:
				if plate is Dictionary and plate.get("id") == reference and _coordinate_ok(plate.get("position")) and occupied.has(_coord_key(plate["position"])):
					found = true
			should_open = should_open and found
		if typeof(door.get("initial_open")) == TYPE_BOOL and door["initial_open"] != should_open:
			_add(errors, "INITIAL_DOOR_STATE_MISMATCH", "$.doors[%d].initial_open" % index, "Initial door state is not combinationally consistent")


func _check_static(position, path: String, rows, width: int, height: int, positions: Dictionary, errors: Array) -> void:
	_check_placement(position, path, rows, width, height, errors)
	if _coordinate_ok(position):
		var key := _coord_key(position)
		if positions.has(key):
			_add(errors, "STATIC_POSITION_OVERLAP", path, "Static overlay positions must be pairwise distinct")
		positions[key] = true


func _check_placement(position, path: String, rows, width: int, height: int, errors: Array) -> void:
	if not _coordinate_ok(position):
		return
	var x: int = int(position[0])
	var y: int = int(position[1])
	if x < 0 or y < 0 or x >= width or y >= height:
		_add(errors, "OUT_OF_BOUNDS", path, "Coordinate is outside actual terrain")
	elif rows is Array and y < rows.size() and rows[y] is String and x < rows[y].length() and rows[y][x] != ".":
		_add(errors, "NOT_FLOOR", path, "Overlay must be placed on floor terrain")


func _shape_object(value: Dictionary, path: String, required: Array, allowed: Array, errors: Array) -> void:
	for field in required:
		if not value.has(field):
			_add(errors, "SCHEMA_SHAPE_ERROR", path + "." + field, "Required field is missing")
	for field in value.keys():
		if not allowed.has(field):
			_add(errors, "SCHEMA_SHAPE_ERROR", path + "." + str(field), "Unknown field is rejected")


func _validate_coordinate(value, path: String, errors: Array) -> void:
	if not _coordinate_ok(value) or value[0] < 0 or value[0] > 63 or value[1] < 0 or value[1] > 63:
		_add(errors, "SCHEMA_SHAPE_ERROR", path, "Coordinate must be two integers from 0 to 63")


func _coordinate_ok(value) -> bool:
	return value is Array and value.size() == 2 and _integer_number(value[0]) and _integer_number(value[1])


func _validate_string(value, path: String, minimum: int, maximum: int, stable_id: bool, errors: Array) -> void:
	if not value is String or value.length() < minimum or value.length() > maximum:
		_add(errors, "SCHEMA_SHAPE_ERROR", path, "String length is outside the schema bounds")
	elif stable_id:
		var regex := RegEx.new()
		regex.compile(ID_PATTERN)
		if regex.search(value) == null:
			_add(errors, "SCHEMA_SHAPE_ERROR", path, "ID must be lower snake case")


func _validate_bounded_int(value, path: String, minimum: int, maximum: int, errors: Array) -> void:
	if not _integer_number(value) or value < minimum or value > maximum:
		_add(errors, "SCHEMA_SHAPE_ERROR", path, "Integer is outside the schema bounds")


func _track_id(value, seen: Dictionary, path: String, errors: Array) -> void:
	if value is String:
		if seen.has(value):
			_add(errors, "DUPLICATE_ID", path, "ID is duplicated within its entity family")
		seen[value] = true


func _coord_key(position: Array) -> String:
	return "%d,%d" % [int(position[0]), int(position[1])]


func _integer_number(value) -> bool:
	return typeof(value) == TYPE_INT or (typeof(value) == TYPE_FLOAT and is_finite(value) and value == floor(value))


func _normalize_numbers(level: Dictionary) -> void:
	level.schema_version = int(level.schema_version)
	level.player_spawn = [int(level.player_spawn[0]), int(level.player_spawn[1])]
	for echo in level.echoes:
		echo.delay = int(echo.delay)
		echo.spawn = [int(echo.spawn[0]), int(echo.spawn[1])]
	for plate in level.plates:
		plate.position = [int(plate.position[0]), int(plate.position[1])]
	for door in level.doors:
		door.position = [int(door.position[0]), int(door.position[1])]
	level.exit.position = [int(level.exit.position[0]), int(level.exit.position[1])]
	level.validation.recommended_search_depth = int(level.validation.recommended_search_depth)
	if level.validation.has("expected_min_turns"):
		level.validation.expected_min_turns = int(level.validation.expected_min_turns)


func _add(errors: Array, code: String, path: String, message: String) -> void:
	for existing in errors:
		if existing.code == code and existing.path == path:
			return
	errors.append(_error(code, path, message))


func _error(code: String, path: String, message: String) -> Dictionary:
	return {"code": code, "path": path, "message": message}


func _invalid(errors: Array) -> Dictionary:
	return {"ok": false, "status": "INVALID_LEVEL", "errors": errors, "level": null}

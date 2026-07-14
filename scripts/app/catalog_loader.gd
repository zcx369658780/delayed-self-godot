class_name DelayedSelfCatalogLoader
extends RefCounted

const LevelLoader = preload("res://scripts/simulation/level_loader.gd")
const TOP_FIELDS := ["catalog_version", "entries"]
const REQUIRED_ENTRY_FIELDS := ["level_id", "level_path", "sequence", "display_title_key", "classification", "unlock_prerequisites", "hud_mode", "final_level"]
const OPTIONAL_ENTRY_FIELDS := ["best_turn_threshold"]
const CLASSIFICATIONS := ["tutorial", "standard"]
const HUD_MODES := ["INTRO_MINIMAL", "GUIDED_ECHO", "STANDARD_COMPACT"]
const ID_PATTERN := "^[a-z][a-z0-9]*(?:_[a-z0-9]+)*$"
const KEY_PATTERN := "^[a-z][a-z0-9_]*(?:\\.[a-z][a-z0-9_]*)+$"
const PATH_PATTERN := "^res://data/levels/[a-z0-9_/-]+\\.json$"


func load_file(path: String) -> Dictionary:
	var file := FileAccess.open(path, FileAccess.READ)
	if file == null:
		return _invalid([_error("CATALOG_JSON_PARSE_ERROR", "$", "Unable to read catalog JSON")])
	var json := JSON.new()
	if json.parse(file.get_as_text()) != OK:
		return _invalid([_error("CATALOG_JSON_PARSE_ERROR", "$", json.get_error_message())])
	return validate_dict(json.data)


func validate_dict(source, allow_repository_test_paths: bool = false) -> Dictionary:
	var errors: Array = []
	if not source is Dictionary:
		return _invalid([_error("CATALOG_SHAPE_ERROR", "$", "Top level must be an object")])
	_check_fields(source, "$", TOP_FIELDS, TOP_FIELDS, errors)
	if not _integer(source.get("catalog_version")):
		_add(errors, "CATALOG_SHAPE_ERROR", "$.catalog_version", "catalog_version must be an integer")
	elif int(source.catalog_version) != 1:
		_add(errors, "CATALOG_UNSUPPORTED_VERSION", "$.catalog_version", "Only catalog version 1 is supported")
	var entries = source.get("entries")
	if not entries is Array or entries.size() < 1 or entries.size() > 64:
		_add(errors, "CATALOG_SHAPE_ERROR", "$.entries", "entries must contain 1 to 64 objects")
		return _invalid(errors)

	var ids := {}
	var sequences := {}
	var normalized_entries: Array = []
	var final_count := 0
	for index in entries.size():
		var value = entries[index]
		var path := "$.entries[%d]" % index
		if not value is Dictionary:
			_add(errors, "CATALOG_SHAPE_ERROR", path, "entry must be an object")
			continue
		_check_fields(value, path, REQUIRED_ENTRY_FIELDS, REQUIRED_ENTRY_FIELDS + OPTIONAL_ENTRY_FIELDS, errors)
		_validate_pattern(value.get("level_id"), path + ".level_id", ID_PATTERN, errors, 64)
		_validate_pattern(value.get("display_title_key"), path + ".display_title_key", KEY_PATTERN, errors, 160)
		_validate_level_path(value.get("level_path"), path + ".level_path", allow_repository_test_paths, errors)
		var level_id = value.get("level_id")
		if level_id is String:
			if ids.has(level_id):
				_add(errors, "CATALOG_DUPLICATE_LEVEL_ID", path + ".level_id", "level_id is duplicated")
			ids[level_id] = true
		if not _integer(value.get("sequence")) or value.sequence < 1 or value.sequence > 999:
			_add(errors, "CATALOG_SHAPE_ERROR", path + ".sequence", "sequence must be an integer from 1 to 999")
		else:
			var sequence := int(value.sequence)
			if sequences.has(sequence):
				_add(errors, "CATALOG_DUPLICATE_SEQUENCE", path + ".sequence", "sequence is duplicated")
			sequences[sequence] = true
		if not value.get("classification") is String:
			_add(errors, "CATALOG_SHAPE_ERROR", path + ".classification", "classification must be a string")
		elif not CLASSIFICATIONS.has(value.classification):
			_add(errors, "CATALOG_UNKNOWN_CLASSIFICATION", path + ".classification", "classification is unsupported")
		if not value.get("hud_mode") is String:
			_add(errors, "CATALOG_SHAPE_ERROR", path + ".hud_mode", "hud_mode must be a string")
		elif not HUD_MODES.has(value.hud_mode):
			_add(errors, "CATALOG_UNKNOWN_HUD_MODE", path + ".hud_mode", "hud_mode is unsupported")
		if typeof(value.get("final_level")) != TYPE_BOOL:
			_add(errors, "CATALOG_SHAPE_ERROR", path + ".final_level", "final_level must be boolean")
		elif value.final_level:
			final_count += 1
		if value.has("best_turn_threshold") and (not _integer(value.best_turn_threshold) or value.best_turn_threshold < 1):
			_add(errors, "CATALOG_SHAPE_ERROR", path + ".best_turn_threshold", "best_turn_threshold must be a positive integer")
		var prerequisites = value.get("unlock_prerequisites")
		if not prerequisites is Array:
			_add(errors, "CATALOG_SHAPE_ERROR", path + ".unlock_prerequisites", "unlock_prerequisites must be an array")
		else:
			var seen := {}
			for prerequisite_index in prerequisites.size():
				var prerequisite = prerequisites[prerequisite_index]
				_validate_pattern(prerequisite, path + ".unlock_prerequisites[%d]" % prerequisite_index, ID_PATTERN, errors, 64)
				if prerequisite is String and seen.has(prerequisite):
					_add(errors, "CATALOG_DUPLICATE_PREREQUISITE", path + ".unlock_prerequisites", "prerequisite is duplicated")
				if prerequisite == level_id:
					_add(errors, "CATALOG_SELF_PREREQUISITE", path + ".unlock_prerequisites", "entry cannot require itself")
				seen[prerequisite] = true
		if errors.is_empty():
			normalized_entries.append(value.duplicate(true))

	for sequence in range(1, entries.size() + 1):
		if not sequences.has(sequence):
			_add(errors, "CATALOG_NONCONTIGUOUS_SEQUENCE", "$.entries", "sequence values must be contiguous from 1")
			break
	if final_count != 1:
		_add(errors, "CATALOG_FINAL_COUNT_INVALID", "$.entries", "runtime catalog requires exactly one final entry")
	if not errors.is_empty():
		return _invalid(errors)

	for index in normalized_entries.size():
		var entry: Dictionary = normalized_entries[index]
		for prerequisite in entry.unlock_prerequisites:
			if not ids.has(prerequisite):
				_add(errors, "CATALOG_UNKNOWN_PREREQUISITE", "$.entries[%d].unlock_prerequisites" % index, "prerequisite is not in this catalog")
	if not errors.is_empty():
		return _invalid(errors)

	var reachable := {}
	var changed := true
	while changed:
		changed = false
		for entry in normalized_entries:
			if reachable.has(entry.level_id):
				continue
			var ready := true
			for prerequisite in entry.unlock_prerequisites:
				ready = ready and reachable.has(prerequisite)
			if ready:
				reachable[entry.level_id] = true
				changed = true
	if reachable.size() != normalized_entries.size():
		_add(errors, "CATALOG_PREREQUISITE_CYCLE", "$.entries", "prerequisite graph contains a cycle")
		_add(errors, "CATALOG_UNREACHABLE_ENTRY", "$.entries", "one or more entries are unreachable from a root")
		return _invalid(errors)

	for index in normalized_entries.size():
		var entry: Dictionary = normalized_entries[index]
		if not FileAccess.file_exists(entry.level_path):
			_add(errors, "CATALOG_LEVEL_FILE_MISSING", "$.entries[%d].level_path" % index, "formal level file does not exist")
			continue
		var formal := LevelLoader.new().load_file(entry.level_path)
		if not formal.ok:
			_add(errors, "CATALOG_FORMAL_LEVEL_INVALID", "$.entries[%d].level_path" % index, "formal level was rejected by LevelLoader")
			continue
		if formal.level.level_id != entry.level_id:
			_add(errors, "CATALOG_LEVEL_ID_MISMATCH", "$.entries[%d].level_id" % index, "catalog and formal level IDs differ")
			continue
		entry["formal_title"] = formal.level.title
		entry["formal_level"] = formal.level
	if not errors.is_empty():
		return _invalid(errors)
	normalized_entries.sort_custom(func(a, b): return a.sequence < b.sequence)
	return {"ok": true, "status": "VALID_CATALOG", "errors": [], "catalog": {"catalog_version": 1, "entries": normalized_entries}}


func _check_fields(value: Dictionary, path: String, required: Array, allowed: Array, errors: Array) -> void:
	for key in value.keys():
		if not allowed.has(key):
			_add(errors, "CATALOG_UNKNOWN_FIELD", path + "." + str(key), "field is not allowed")
	for key in required:
		if not value.has(key):
			_add(errors, "CATALOG_SHAPE_ERROR", path + "." + key, "required field is missing")


func _validate_pattern(value, path: String, pattern: String, errors: Array, max_length: int = 0) -> void:
	if not value is String or value.is_empty():
		_add(errors, "CATALOG_SHAPE_ERROR", path, "value must be a non-empty string")
		return
	if max_length > 0 and value.length() > max_length:
		_add(errors, "CATALOG_SHAPE_ERROR", path, "value exceeds the maximum length")
		return
	var regex := RegEx.new()
	regex.compile(pattern)
	if regex.search(value) == null:
		_add(errors, "CATALOG_INVALID_FORMAT", path, "value has an invalid format")


func _validate_level_path(value, path: String, allow_repository_test_paths: bool, errors: Array) -> void:
	if allow_repository_test_paths and value is String and (value.begins_with("res://tests/app/") or value.begins_with("res://docs/level_design/examples/")) and value.ends_with(".json"):
		return
	_validate_pattern(value, path, PATH_PATTERN, errors)


func _integer(value) -> bool:
	return typeof(value) == TYPE_INT or (typeof(value) == TYPE_FLOAT and is_finite(value) and value == floor(value))


func _invalid(errors: Array) -> Dictionary:
	return {"ok": false, "status": "INVALID_CATALOG", "errors": errors, "catalog": {}}


func _error(code: String, path: String, message: String) -> Dictionary:
	return {"code": code, "path": path, "message": message.left(160)}


func _add(errors: Array, code: String, path: String, message: String) -> void:
	errors.append(_error(code, path, message))

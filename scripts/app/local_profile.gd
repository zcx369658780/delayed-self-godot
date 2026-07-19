class_name DelayedSelfLocalProfile
extends RefCounted

const PRODUCTION_PROFILE_PATH := "user://delayed_self_profile.json"
const TEST_PROFILE_ROOT := "user://delayed_self_test_profiles/"
const PROFILE_FILENAME := "delayed_self_profile.json"
const MAX_FIXTURE_ID_LENGTH := 64


static func build_test_profile_path(fixture_id: String) -> Dictionary:
	var fixture_result := _validate_fixture_id(fixture_id)
	if not fixture_result.ok:
		return {
			"ok": false,
			"status": fixture_result.status,
		}
	return {
		"ok": true,
		"status": "TEST_PROFILE_PATH_BUILT",
		"path": TEST_PROFILE_ROOT + fixture_id + "/" + PROFILE_FILENAME,
		"fixture_id": fixture_id,
	}


static func validate_test_profile_path(path: String) -> Dictionary:
	if path == PRODUCTION_PROFILE_PATH:
		return _rejected("PRODUCTION_PROFILE_PATH_REJECTED")
	if not path.begins_with(TEST_PROFILE_ROOT):
		return _rejected("TEST_PROFILE_ROOT_REJECTED")
	var remainder := path.substr(TEST_PROFILE_ROOT.length())
	var segments := remainder.split("/", true)
	if segments.size() != 2:
		return _rejected("TEST_PROFILE_PATH_SHAPE_REJECTED")
	var fixture_id: String = segments[0]
	if segments[1] != PROFILE_FILENAME:
		return _rejected("TEST_PROFILE_FILENAME_REJECTED")
	var built := build_test_profile_path(fixture_id)
	if not built.ok:
		return _rejected(str(built.status))
	if built.path != path:
		return _rejected("NON_CANONICAL_TEST_PROFILE_PATH_REJECTED")
	return {
		"ok": true,
		"status": "VALID_TEST_PROFILE_PATH",
		"path": path,
		"fixture_id": fixture_id,
	}


static func _validate_fixture_id(fixture_id: String) -> Dictionary:
	if fixture_id.is_empty():
		return _rejected("EMPTY_FIXTURE_ID")
	if fixture_id.length() > MAX_FIXTURE_ID_LENGTH:
		return _rejected("FIXTURE_ID_TOO_LONG")
	if not _is_ascii_alphanumeric(fixture_id.unicode_at(0)):
		return _rejected("FIXTURE_ID_INVALID_FIRST_CHARACTER")
	for index in range(1, fixture_id.length()):
		var codepoint := fixture_id.unicode_at(index)
		if not _is_ascii_alphanumeric(codepoint) and codepoint != 95 and codepoint != 45:
			return _rejected("FIXTURE_ID_INVALID_CHARACTER")
	return {
		"ok": true,
		"status": "VALID_FIXTURE_ID",
	}


static func _is_ascii_alphanumeric(codepoint: int) -> bool:
	return (
		(codepoint >= 48 and codepoint <= 57)
		or (codepoint >= 65 and codepoint <= 90)
		or (codepoint >= 97 and codepoint <= 122)
	)


static func _rejected(status: String) -> Dictionary:
	return {
		"ok": false,
		"status": status,
	}


var _configured: bool = false
var _catalog_facts: Dictionary = {}
var _test_profile_path: String = ""


func configure_test(catalog_facts: Dictionary, canonical_test_profile_path: String) -> Dictionary:
	if _configured:
		return _configuration_rejected("TEST_STORE_ALREADY_CONFIGURED")
	var path_validation: Dictionary = validate_test_profile_path(canonical_test_profile_path)
	if not bool(path_validation.get("ok", false)):
		return _configuration_rejected(str(path_validation.get("status", "TEST_PROFILE_PATH_REJECTED")))
	var catalog_validation: Dictionary = _validate_catalog_facts(catalog_facts)
	if not bool(catalog_validation.get("ok", false)):
		return _configuration_rejected(str(catalog_validation.get("status", "CATALOG_FACTS_INVALID")))
	_catalog_facts = (catalog_validation.get("catalog_facts", {}) as Dictionary).duplicate(true)
	_test_profile_path = str(path_validation.get("path", ""))
	_configured = true
	return {
		"ok": true,
		"status": "TEST_STORE_CONFIGURED",
		"configuration": get_configuration_snapshot(),
	}


func is_configured() -> bool:
	return _configured


func get_configuration_snapshot() -> Dictionary:
	if not _configured:
		return {
			"configured": false,
		}
	return {
		"configured": true,
		"test_profile_path": _test_profile_path,
		"catalog_facts": _catalog_facts.duplicate(true),
	}


func _validate_catalog_facts(catalog_facts: Dictionary) -> Dictionary:
	var level_ids_value: Variant = catalog_facts.get("level_ids", null)
	var prerequisites_value: Variant = catalog_facts.get("prerequisites", null)
	if not level_ids_value is Array or not prerequisites_value is Dictionary:
		return _configuration_rejected("CATALOG_FACTS_INVALID")
	var level_ids: Array = level_ids_value
	var supplied_prerequisites: Dictionary = prerequisites_value
	if level_ids.is_empty():
		return _configuration_rejected("CATALOG_FACTS_INVALID")
	var known: Dictionary = {}
	var copied_level_ids: Array = []
	for raw_level_id: Variant in level_ids:
		if not raw_level_id is String:
			return _configuration_rejected("CATALOG_FACTS_INVALID")
		var level_id: String = raw_level_id
		if level_id.is_empty() or known.has(level_id):
			return _configuration_rejected("CATALOG_FACTS_INVALID")
		known[level_id] = true
		copied_level_ids.append(level_id)
	var copied_prerequisites: Dictionary = {}
	for known_id_value: Variant in copied_level_ids:
		var known_id: String = str(known_id_value)
		var prerequisite_value: Variant = supplied_prerequisites.get(known_id, null)
		if not prerequisite_value is Array:
			return _configuration_rejected("CATALOG_FACTS_INVALID")
		var prerequisite_ids: Array = prerequisite_value
		var copied_prerequisite_ids: Array = []
		for raw_prerequisite_id: Variant in prerequisite_ids:
			if not raw_prerequisite_id is String:
				return _configuration_rejected("CATALOG_FACTS_INVALID")
			var prerequisite_id: String = raw_prerequisite_id
			if prerequisite_id == known_id or not known.has(prerequisite_id) or copied_prerequisite_ids.has(prerequisite_id):
				return _configuration_rejected("CATALOG_FACTS_INVALID")
			copied_prerequisite_ids.append(prerequisite_id)
		copied_prerequisite_ids.sort()
		copied_prerequisites[known_id] = copied_prerequisite_ids
	return {
		"ok": true,
		"status": "CATALOG_FACTS_VALID",
		"catalog_facts": {
			"level_ids": copied_level_ids,
			"prerequisites": copied_prerequisites,
		},
	}


func _configuration_rejected(status: String) -> Dictionary:
	return {
		"ok": false,
		"status": status,
		"configuration": get_configuration_snapshot(),
	}

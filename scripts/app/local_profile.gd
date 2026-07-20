class_name DelayedSelfLocalProfile
extends RefCounted

const PRODUCTION_PROFILE_PATH := "user://delayed_self_profile.json"
const TEST_PROFILE_ROOT := "user://delayed_self_test_profiles/"
const PROFILE_FILENAME := "delayed_self_profile.json"
const MAX_FIXTURE_ID_LENGTH := 64
const MODE_TEST: String = "TEST"
const MODE_PRODUCTION: String = "PRODUCTION"
const ACCESS_READ_ONLY: String = "READ_ONLY"
const ACCESS_WRITE_ON_INTENT: String = "WRITE_ON_INTENT"


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
var _mode: String = ""
var _access_policy: String = ""
var _target_path: String = ""

const ProfileCodec = preload("res://scripts/app/profile_codec.gd")
const MAX_PROFILE_SOURCE_BYTES: int = 65536
const OWNED_NAME_LIMIT: int = 8

var _committed_profile: Dictionary = {}
var _committed_json: String = ""
var _committed_target_verified: bool = false
var _pending_recovery: bool = false
var _pending_recovery_source: String = ""
var _recovery_sibling_name: String = ""
var _write_disabled: bool = false
var _failure_seam: String = "NONE"
var _activation_backup_required: bool = false
var _activation_backup_created: bool = false


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
	_mode = MODE_TEST
	_access_policy = ACCESS_WRITE_ON_INTENT
	_target_path = str(path_validation.get("path", ""))
	_configured = true
	return {
		"ok": true,
		"status": "TEST_STORE_CONFIGURED",
		"configuration": get_configuration_snapshot(),
	}


func configure_production(catalog_facts: Dictionary, access_policy: String) -> Dictionary:
	if _configured:
		return _configuration_rejected("PRODUCTION_STORE_ALREADY_CONFIGURED")
	if not [ACCESS_READ_ONLY, ACCESS_WRITE_ON_INTENT].has(access_policy):
		return _configuration_rejected("PRODUCTION_ACCESS_POLICY_REJECTED")
	var catalog_validation: Dictionary = _validate_catalog_facts(catalog_facts)
	if not bool(catalog_validation.get("ok", false)):
		return _configuration_rejected(str(catalog_validation.get("status", "CATALOG_FACTS_INVALID")))
	_catalog_facts = (catalog_validation.get("catalog_facts", {}) as Dictionary).duplicate(true)
	_mode = MODE_PRODUCTION
	_access_policy = access_policy
	_target_path = PRODUCTION_PROFILE_PATH
	_configured = true
	return {
		"ok": true,
		"status": "PRODUCTION_STORE_CONFIGURED",
		"configuration": get_configuration_snapshot(),
	}


func is_configured() -> bool:
	return _configured


func get_configuration_snapshot() -> Dictionary:
	if not _configured:
		return {
			"configured": false,
		}
	if _mode == MODE_TEST:
		return {
			"configured": true,
			"test_profile_path": _target_path,
			"catalog_facts": _catalog_facts.duplicate(true),
		}
	return {
		"configured": true,
		"mode": MODE_PRODUCTION,
		"access_policy": _access_policy,
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


func load_profile() -> Dictionary:
	if not is_configured():
		return _store_rejected("STORE_NOT_CONFIGURED")
	if _write_disabled:
		return _store_rejected("RECOVERY_FAILED")
	if not FileAccess.file_exists(_target_path):
		_set_clean_default()
		_committed_target_verified = false
		_activation_backup_required = false
		return _store_result("MISSING_CLEAN")
	var source: Dictionary = _read_target_bytes()
	if not bool(source.get("ok", false)):
		return _handle_unreadable_source()
	var raw_bytes: PackedByteArray = source.get("bytes", PackedByteArray())
	var parsed: Dictionary = _parse_json_bytes(raw_bytes)
	if not bool(parsed.get("ok", false)):
		return _handle_unreadable_source()
	var parsed_value: Variant = parsed.get("value", null)
	var schema: Dictionary = ProfileCodec.classify_profile_schema(parsed_value)
	var schema_status: String = str(schema.get("status", "PROFILE_VERSION_INVALID"))
	if schema_status == "PROFILE_VERSION_UNSUPPORTED":
		return _handle_unsupported_source()
	if schema_status != "PROFILE_VERSION_SUPPORTED":
		return _handle_unreadable_source()
	var normalized: Dictionary = ProfileCodec.normalize_profile(parsed_value, _catalog_facts)
	if not bool(normalized.get("ok", false)):
		return _handle_unreadable_source()
	var serialized: Dictionary = ProfileCodec.serialize_profile(normalized.get("profile", {}))
	if not bool(serialized.get("ok", false)):
		return _handle_unreadable_source()
	_committed_profile = (serialized.get("profile", {}) as Dictionary).duplicate(true)
	_committed_json = str(serialized.get("json", ""))
	_committed_target_verified = true
	_pending_recovery = bool(normalized.get("sanitized", false))
	_pending_recovery_source = _target_path if _pending_recovery else ""
	_activation_backup_required = _mode == MODE_PRODUCTION
	if _pending_recovery and _mode == MODE_PRODUCTION:
		return _store_result("SANITIZED_PENDING_RECOVERY")
	return _store_result("SANITIZED" if _pending_recovery else "LOADED")


func persist_profile(candidate_profile: Dictionary) -> Dictionary:
	if not is_configured():
		return _store_rejected("STORE_NOT_CONFIGURED")
	if _mode == MODE_PRODUCTION and _access_policy != ACCESS_WRITE_ON_INTENT:
		return _store_rejected("PRODUCTION_WRITE_POLICY_REJECTED")
	if _write_disabled:
		return _store_rejected("RECOVERY_FAILED")
	var normalized: Dictionary = ProfileCodec.normalize_profile(candidate_profile, _catalog_facts)
	if not bool(normalized.get("ok", false)):
		return _store_rejected("CANDIDATE_REJECTED")
	var serialized: Dictionary = ProfileCodec.serialize_profile(normalized.get("profile", {}))
	if not bool(serialized.get("ok", false)):
		return _store_rejected("CANDIDATE_REJECTED")
	var intended_profile: Dictionary = serialized.get("profile", {})
	var intended_json: String = str(serialized.get("json", ""))
	if _committed_target_verified and not _pending_recovery and intended_json == _committed_json and not _committed_json.is_empty():
		return _store_result("NO_CHANGE")
	if _pending_recovery and not _preserve_recovery_copy():
		_write_disabled = true
		return _store_rejected("RECOVERY_FAILED")
	if _mode == MODE_PRODUCTION and _activation_backup_required and not _activation_backup_created:
		if not _preserve_activation_backup():
			_write_disabled = true
			return _store_rejected("ACTIVATION_BACKUP_FAILED")
	var transaction: Dictionary = _transactional_replace(intended_json)
	if not bool(transaction.get("ok", false)):
		var rejected: Dictionary = _store_rejected("WRITE_FAILED")
		rejected["stage"] = str(transaction.get("stage", "UNKNOWN"))
		return rejected
	_committed_profile = intended_profile.duplicate(true)
	_committed_json = intended_json
	_committed_target_verified = true
	_pending_recovery = false
	_pending_recovery_source = ""
	_activation_backup_required = false
	return _store_result("PERSISTED")


func reset_test_profile() -> Dictionary:
	if not is_configured():
		return _store_rejected("STORE_NOT_CONFIGURED")
	if _mode != MODE_TEST:
		return _store_rejected("TEST_MODE_REQUIRED")
	if _write_disabled:
		return _store_rejected("RECOVERY_FAILED")
	if FileAccess.file_exists(_target_path):
		if DirAccess.remove_absolute(ProjectSettings.globalize_path(_target_path)) != OK:
			return _store_rejected("WRITE_FAILED")
	_set_clean_default()
	_committed_target_verified = false
	_pending_recovery = false
	_pending_recovery_source = ""
	return _store_result("RESET")


func get_committed_profile() -> Dictionary:
	if not is_configured():
		return _store_rejected("STORE_NOT_CONFIGURED")
	if _committed_profile.is_empty():
		_set_clean_default()
	return _store_result("COMMITTED")


func set_test_failure_seam(stage: String) -> Dictionary:
	if not is_configured():
		return _store_rejected("STORE_NOT_CONFIGURED")
	if _mode != MODE_TEST:
		return _store_rejected("TEST_MODE_REQUIRED")
	if not ["NONE", "RECOVERY_COPY", "TEMP_WRITE", "TEMP_READBACK", "REPLACE", "POST_REPLACE_VERIFY"].has(stage):
		return _store_rejected("FAILURE_SEAM_REJECTED")
	_failure_seam = stage
	return _store_result("FAILURE_SEAM_SET")


func _set_clean_default() -> void:
	var default_result: Dictionary = ProfileCodec.default_profile()
	var serialized: Dictionary = ProfileCodec.serialize_profile(default_result.get("profile", {}))
	_committed_profile = (serialized.get("profile", {}) as Dictionary).duplicate(true)
	_committed_json = str(serialized.get("json", ""))


func _store_result(status: String) -> Dictionary:
	var result: Dictionary = {
		"ok": true,
		"status": status,
		"profile": _committed_profile.duplicate(true),
		"configured": _configured,
	}
	if _mode == MODE_TEST and not _recovery_sibling_name.is_empty():
		result["recovery_sibling_name"] = _recovery_sibling_name
	return result


func _store_rejected(status: String) -> Dictionary:
	return {
		"ok": false,
		"status": status,
		"configured": _configured,
	}


func _read_target_bytes() -> Dictionary:
	var file := FileAccess.open(_target_path, FileAccess.READ)
	if file == null:
		return {"ok": false}
	var length: int = file.get_length()
	if length > MAX_PROFILE_SOURCE_BYTES:
		file.close()
		return {"ok": false}
	var bytes: PackedByteArray = file.get_buffer(length)
	file.close()
	if bytes.size() != length:
		return {"ok": false}
	return {"ok": true, "bytes": bytes}


func _parse_json_bytes(bytes: PackedByteArray) -> Dictionary:
	var json := JSON.new()
	if json.parse(bytes.get_string_from_utf8()) != OK:
		return {"ok": false}
	return {"ok": true, "value": _coerce_json_integral_numbers(json.data)}


func _coerce_json_integral_numbers(value: Variant) -> Variant:
	# Godot's JSON parser represents all JSON numbers as floats. This decoder-only
	# conversion restores exact integral values before the frozen codec decides
	# whether their profile locations are valid.
	if value is float and value == floor(value):
		return int(value)
	if value is Array:
		var copied_array: Array = []
		for item: Variant in value:
			copied_array.append(_coerce_json_integral_numbers(item))
		return copied_array
	if value is Dictionary:
		var copied_dictionary: Dictionary = {}
		for key: Variant in value.keys():
			copied_dictionary[key] = _coerce_json_integral_numbers(value.get(key))
		return copied_dictionary
	return value


func _recover_or_disable() -> Dictionary:
	if _preserve_recovery_copy():
		_set_clean_default()
		_committed_target_verified = false
		_pending_recovery = false
		_pending_recovery_source = ""
		return _store_result("RECOVERED_CLEAN")
	_write_disabled = true
	return _store_rejected("RECOVERY_FAILED")


func _handle_unreadable_source() -> Dictionary:
	if _mode == MODE_PRODUCTION and _access_policy == ACCESS_READ_ONLY:
		return _store_rejected("RECOVERY_REQUIRED_READ_ONLY")
	return _recover_or_disable()


func _handle_unsupported_source() -> Dictionary:
	if _mode == MODE_PRODUCTION and _access_policy == ACCESS_READ_ONLY:
		_write_disabled = true
		return _store_rejected("UNSUPPORTED_VERSION_READ_ONLY")
	if _mode == MODE_PRODUCTION:
		if not _preserve_recovery_copy():
			_write_disabled = true
			return _store_rejected("RECOVERY_FAILED")
		_set_clean_default()
		_committed_target_verified = false
		_pending_recovery = false
		_pending_recovery_source = ""
		_write_disabled = true
		return _store_result("UNSUPPORTED_VERSION_PRESERVED")
	return _recover_or_disable()


func _preserve_recovery_copy() -> bool:
	if _failure_seam == "RECOVERY_COPY":
		return false
	if _mode == MODE_PRODUCTION and _access_policy != ACCESS_WRITE_ON_INTENT:
		return false
	var source_path: String = _pending_recovery_source if not _pending_recovery_source.is_empty() else _target_path
	var source_os_path: String = ProjectSettings.globalize_path(source_path)
	for index in range(OWNED_NAME_LIMIT):
		var recovery_path: String = _owned_sibling_path("recovery", index)
		if FileAccess.file_exists(recovery_path):
			continue
		if DirAccess.copy_absolute(source_os_path, ProjectSettings.globalize_path(recovery_path)) == OK:
			_recovery_sibling_name = recovery_path.get_file()
			return true
	return false


func _preserve_activation_backup() -> bool:
	if _mode != MODE_PRODUCTION or _access_policy != ACCESS_WRITE_ON_INTENT:
		return false
	var source_os_path: String = ProjectSettings.globalize_path(_target_path)
	for index in range(OWNED_NAME_LIMIT):
		var backup_path: String = _owned_sibling_path("activation_backup", index)
		if FileAccess.file_exists(backup_path):
			continue
		if DirAccess.copy_absolute(source_os_path, ProjectSettings.globalize_path(backup_path)) == OK:
			_activation_backup_created = true
			return true
	return false


func _transactional_replace(intended_json: String) -> Dictionary:
	var directory_path: String = _target_path.get_base_dir()
	if DirAccess.make_dir_recursive_absolute(ProjectSettings.globalize_path(directory_path)) != OK:
		return {"ok": false, "stage": "DIRECTORY"}
	var temp_path: String = _first_available_owned_path("temp")
	if temp_path.is_empty():
		return {"ok": false, "stage": "TEMP_NAME"}
	if not _write_temp(temp_path, intended_json):
		_remove_owned(temp_path)
		return {"ok": false, "stage": "TEMP_WRITE"}
	if not _verify_temp(temp_path, intended_json):
		_remove_owned(temp_path)
		return {"ok": false, "stage": "TEMP_READBACK"}
	var had_old_target: bool = FileAccess.file_exists(_target_path)
	var backup_path: String = ""
	if had_old_target:
		backup_path = _first_available_owned_path("transaction")
		if backup_path.is_empty() or DirAccess.copy_absolute(ProjectSettings.globalize_path(_target_path), ProjectSettings.globalize_path(backup_path)) != OK:
			_remove_owned(temp_path)
			return {"ok": false, "stage": "BACKUP"}
	var renamed: bool = DirAccess.rename_absolute(ProjectSettings.globalize_path(temp_path), ProjectSettings.globalize_path(_target_path)) == OK
	if not renamed:
		_cleanup_transaction(temp_path, backup_path)
		return {"ok": false, "stage": "RENAME"}
	if _failure_seam == "REPLACE" or not _verify_target(intended_json) or _failure_seam == "POST_REPLACE_VERIFY":
		var restored: bool = _restore_old_target(had_old_target, backup_path)
		_cleanup_transaction(temp_path, backup_path)
		return {"ok": false, "stage": "ROLLBACK", "restored": restored}
	_cleanup_transaction(temp_path, backup_path)
	return {"ok": true}


func _write_temp(temp_path: String, intended_json: String) -> bool:
	if _failure_seam == "TEMP_WRITE":
		return false
	var file := FileAccess.open(temp_path, FileAccess.WRITE)
	if file == null:
		return false
	file.store_string(intended_json)
	file.flush()
	file.close()
	return true


func _verify_temp(temp_path: String, intended_json: String) -> bool:
	if _failure_seam == "TEMP_READBACK":
		return false
	var file := FileAccess.open(temp_path, FileAccess.READ)
	if file == null or file.get_length() > MAX_PROFILE_SOURCE_BYTES:
		if file != null:
			file.close()
		return false
	var bytes: PackedByteArray = file.get_buffer(file.get_length())
	file.close()
	var parsed: Dictionary = _parse_json_bytes(bytes)
	if not bool(parsed.get("ok", false)):
		return false
	var normalized: Dictionary = ProfileCodec.normalize_profile(parsed.get("value", null), _catalog_facts)
	if not bool(normalized.get("ok", false)):
		return false
	var serialized: Dictionary = ProfileCodec.serialize_profile(normalized.get("profile", {}))
	return bool(serialized.get("ok", false)) and str(serialized.get("json", "")) == intended_json


func _verify_target(intended_json: String) -> bool:
	var source: Dictionary = _read_target_bytes()
	if not bool(source.get("ok", false)):
		return false
	var parsed: Dictionary = _parse_json_bytes(source.get("bytes", PackedByteArray()))
	if not bool(parsed.get("ok", false)):
		return false
	var normalized: Dictionary = ProfileCodec.normalize_profile(parsed.get("value", null), _catalog_facts)
	if not bool(normalized.get("ok", false)):
		return false
	var serialized: Dictionary = ProfileCodec.serialize_profile(normalized.get("profile", {}))
	return bool(serialized.get("ok", false)) and str(serialized.get("json", "")) == intended_json


func _restore_old_target(had_old_target: bool, backup_path: String) -> bool:
	if not had_old_target:
		return DirAccess.remove_absolute(ProjectSettings.globalize_path(_target_path)) == OK
	var backup := FileAccess.open(backup_path, FileAccess.READ)
	if backup == null:
		return false
	var bytes: PackedByteArray = backup.get_buffer(backup.get_length())
	backup.close()
	var target := FileAccess.open(_target_path, FileAccess.WRITE)
	if target == null:
		return false
	target.store_buffer(bytes)
	target.flush()
	target.close()
	return true


func _first_available_owned_path(kind: String) -> String:
	for index in range(OWNED_NAME_LIMIT):
		var candidate: String = _owned_sibling_path(kind, index)
		if not FileAccess.file_exists(candidate):
			return candidate
	return ""


func _owned_sibling_path(kind: String, index: int) -> String:
	if _mode == MODE_PRODUCTION:
		return _target_path.get_base_dir() + "/.delayed_self_profile_" + kind + "_" + str(index) + ".json"
	return _target_path.get_base_dir() + "/.delayed_self_0023w_" + kind + "_" + str(index) + ".json"


func _cleanup_transaction(temp_path: String, backup_path: String) -> void:
	_remove_owned(temp_path)
	_remove_owned(backup_path)


func _remove_owned(path: String) -> void:
	if not path.is_empty() and FileAccess.file_exists(path):
		DirAccess.remove_absolute(ProjectSettings.globalize_path(path))

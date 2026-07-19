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

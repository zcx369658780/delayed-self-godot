extends SceneTree

const LocalProfile = preload("res://scripts/app/local_profile.gd")

var assertions := 0
var failures := 0
var positive_cases := 0
var negative_cases := 0


func _init() -> void:
	_run()


func _run() -> void:
	var sixty_four := "A" + "a".repeat(63)
	var positives := [
		{"fixture_id": "a", "path": "user://delayed_self_test_profiles/a/delayed_self_profile.json"},
		{"fixture_id": "fixture_001", "path": "user://delayed_self_test_profiles/fixture_001/delayed_self_profile.json"},
		{"fixture_id": "A-Z_09", "path": "user://delayed_self_test_profiles/A-Z_09/delayed_self_profile.json"},
		{"fixture_id": sixty_four, "path": "user://delayed_self_test_profiles/%s/delayed_self_profile.json" % sixty_four},
	]
	for test_case in positives:
		_test_positive(str(test_case.fixture_id), str(test_case.path))
	var negatives := [
		LocalProfile.PRODUCTION_PROFILE_PATH,
		"user://delayed_self_test_profiles/",
		"user://delayed_self_test_profiles/a",
		"user://delayed_self_test_profiles/a/",
		"user://delayed_self_test_profiles/a/profile.json",
		"user://delayed_self_test_profiles//delayed_self_profile.json",
		"user://delayed_self_test_profiles/%s/delayed_self_profile.json" % ("A" + "a".repeat(64)),
		"user://delayed_self_test_profiles/-leading/delayed_self_profile.json",
		"user://delayed_self_test_profiles/_leading/delayed_self_profile.json",
		"user://delayed_self_test_profiles/has space/delayed_self_profile.json",
		"user://delayed_self_test_profiles/has.dot/delayed_self_profile.json",
		"user://delayed_self_test_profiles/has:colon/delayed_self_profile.json",
		"user://delayed_self_test_profiles/a/b/delayed_self_profile.json",
		"user://delayed_self_test_profiles/back\\slash/delayed_self_profile.json",
		"user://delayed_self_test_profiles/非ascii/delayed_self_profile.json",
		"user://delayed_self_test_profiles/control%schar/delayed_self_profile.json" % String.chr(1),
		"user://delayed_self_test_profiles/./delayed_self_profile.json",
		"user://delayed_self_test_profiles/../delayed_self_profile.json",
		"user://delayed_self_test_profiles/a//delayed_self_profile.json",
		"user://delayed_self_test_profiles/a/delayed_self_profile.json/",
		"user://delayed_self_test_profiles_evil/a/delayed_self_profile.json",
		"res://delayed_self_test_profiles/a/delayed_self_profile.json",
		"delayed_self_test_profiles/a/delayed_self_profile.json",
		"C:\\delayed_self_test_profiles\\a\\delayed_self_profile.json",
		"C:/delayed_self_test_profiles/a/delayed_self_profile.json",
		"\\\\server\\share\\delayed_self_profile.json",
		"/absolute/delayed_self_profile.json",
		"file://delayed_self_test_profiles/a/delayed_self_profile.json",
		"user:\\\\delayed_self_test_profiles\\a\\delayed_self_profile.json",
		"user://delayed_self_test_profiles/%2e/delayed_self_profile.json",
		"user://delayed_self_test_profiles/%2e%2e/delayed_self_profile.json",
		"user://delayed_self_test_profiles/a%2fb/delayed_self_profile.json",
		"user://delayed_self_test_profiles/a%s b/delayed_self_profile.json" % String.chr(0x2215),
		"user://delayed_self_test_profiles/a%sb/delayed_self_profile.json" % String.chr(0xff0f),
		"user://delayed_self_test_profiles/a%sb/delayed_self_profile.json" % String.chr(0x29f5),
		"user://delayed_self_test_profiles/a/delayed_self_profile.json?x=1",
		"user://delayed_self_test_profiles/a/delayed_self_profile.json#fragment",
		"user://delayed_self_test_profiles/a/delayed_self_profile.json.extra",
		"user://delayed_self_test_profiles/a/delayed_self_profile.json/extra",
	]
	for path in negatives:
		_test_negative(str(path))
	for invalid_fixture in [
		"",
		"A" + "a".repeat(64),
		"-leading",
		"_leading",
		"has space",
		"has.dot",
		"has:colon",
		"has/slash",
		"has\\backslash",
		"非ascii",
		"control%schar" % String.chr(2),
	]:
		var first := LocalProfile.build_test_profile_path(str(invalid_fixture))
		var second := LocalProfile.build_test_profile_path(str(invalid_fixture))
		_expect(not first.ok and not first.has("path"), "builder rejects invalid fixture without usable path")
		_expect(first == second, "invalid builder result is deterministic")
	_expect(LocalProfile.PRODUCTION_PROFILE_PATH == "user://delayed_self_profile.json", "production authority is fixed only for explicit rejection")
	_expect(LocalProfile.TEST_PROFILE_ROOT == "user://delayed_self_test_profiles/", "test root authority includes exact trailing slash")
	_expect(LocalProfile.PROFILE_FILENAME == "delayed_self_profile.json", "test filename authority is exact")
	print("TASK_0023R_ASSERTIONS=%d positives=%d negatives=%d" % [assertions, positive_cases, negative_cases])
	if failures > 0:
		printerr("TASK_0023R_PROFILE_TEST_ISOLATION_GATE_FAIL failures=%d assertions=%d" % [failures, assertions])
		quit(1)
	else:
		print("TASK_0023R_PROFILE_TEST_ISOLATION_GATE_PASS")
		quit(0)


func _test_positive(fixture_id: String, path: String) -> void:
	positive_cases += 1
	var first_build := LocalProfile.build_test_profile_path(fixture_id)
	var second_build := LocalProfile.build_test_profile_path(fixture_id)
	_expect(first_build.ok and first_build.path == path, "builder returns exact canonical positive path")
	_expect(first_build == second_build, "valid builder result is deterministic")
	var first_validation := LocalProfile.validate_test_profile_path(path)
	var second_validation := LocalProfile.validate_test_profile_path(path)
	_expect(first_validation.ok and first_validation.path == path and first_validation.fixture_id == fixture_id, "validator accepts exact canonical positive path")
	_expect(first_validation == second_validation, "valid validator result is deterministic")
	_expect(first_validation.path == LocalProfile.build_test_profile_path(first_validation.fixture_id).path, "accepted path exactly round-trips through builder")


func _test_negative(path: String) -> void:
	negative_cases += 1
	var first := LocalProfile.validate_test_profile_path(path)
	var second := LocalProfile.validate_test_profile_path(path)
	_expect(not first.ok and not first.has("path"), "validator rejects negative path without usable path")
	_expect(first == second, "rejected validator result is deterministic")


func _expect(condition: bool, label: String) -> void:
	assertions += 1
	if not condition:
		failures += 1
		printerr("TEST_FAIL: " + label)

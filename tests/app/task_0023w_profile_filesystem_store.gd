extends SceneTree

const LocalProfileScript = preload("res://scripts/app/local_profile.gd")
const ProfileCodec = preload("res://scripts/app/profile_codec.gd")
const FIXTURE_ID := "task_0023w_profile_filesystem_store"
const MAX_BYTES := 65536

var assertions: int = 0
var failures: int = 0
var target_path: String = ""
var fixture_dir: String = ""
var catalog_facts: Dictionary = {
	"level_ids": ["alpha", "beta"],
	"prerequisites": {"alpha": [], "beta": ["alpha"]},
}


func _init() -> void:
	var built: Dictionary = LocalProfileScript.build_test_profile_path(FIXTURE_ID)
	if not bool(built.get("ok", false)):
		_abort("fixture builder rejected the fixed task ID")
		return
	target_path = str(built.get("path", ""))
	fixture_dir = target_path.get_base_dir()
	if DirAccess.dir_exists_absolute(ProjectSettings.globalize_path(fixture_dir)):
		_abort("fixed fixture directory already exists")
		return
	_test_unconfigured_and_configuration_gate()
	_make_fixture_dir()
	_test_missing_persist_reload_no_change_and_snapshot()
	_test_sanitize_and_recovery_collisions()
	_test_fatal_recovery_cases()
	_test_failure_seams_and_rollback()
	_test_invalid_candidate_and_reset()
	_cleanup_exact_inventory()
	print("TASK_0023W_ASSERTIONS=%d" % assertions)
	if failures > 0:
		printerr("TASK_0023W_PROFILE_FILESYSTEM_STORE_FAIL failures=%d" % failures)
		quit(1)
		return
	print("TASK_0023W_PROFILE_FILESYSTEM_STORE_TESTS_PASS")
	quit(0)


func _fresh_store() -> RefCounted:
	var store: RefCounted = LocalProfileScript.new()
	return store


func _configured_store() -> RefCounted:
	var store: RefCounted = _fresh_store()
	var configured: Dictionary = store.configure_test(catalog_facts, target_path)
	_expect(bool(configured.get("ok", false)), "fixed canonical configuration succeeds")
	return store


func _test_unconfigured_and_configuration_gate() -> void:
	var store: RefCounted = _fresh_store()
	_expect(store.load_profile().get("status", "") == "STORE_NOT_CONFIGURED", "load rejects before configuration")
	_expect(store.persist_profile({}).get("status", "") == "STORE_NOT_CONFIGURED", "persist rejects before configuration")
	_expect(store.reset_test_profile().get("status", "") == "STORE_NOT_CONFIGURED", "reset rejects before configuration")
	_expect(store.get_committed_profile().get("status", "") == "STORE_NOT_CONFIGURED", "snapshot rejects before configuration")
	_expect(store.set_test_failure_seam("NONE").get("status", "") == "STORE_NOT_CONFIGURED", "seam rejects before configuration")
	_expect(not DirAccess.dir_exists_absolute(ProjectSettings.globalize_path(fixture_dir)), "unconfigured calls caused zero fixture I/O")
	var invalid: Dictionary = store.configure_test(catalog_facts, LocalProfileScript.PRODUCTION_PROFILE_PATH)
	_expect(not bool(invalid.get("ok", false)) and not store.is_configured(), "production configuration rejects without fallback")


func _make_fixture_dir() -> void:
	_expect(DirAccess.make_dir_recursive_absolute(ProjectSettings.globalize_path(fixture_dir)) == OK, "fixture directory is created only after configuration gate test")


func _test_missing_persist_reload_no_change_and_snapshot() -> void:
	var store: RefCounted = _configured_store()
	var missing: Dictionary = store.load_profile()
	_expect(missing.get("status", "") == "MISSING_CLEAN" and not FileAccess.file_exists(target_path), "missing target remains clean without eager write")
	var default_profile: Dictionary = missing.get("profile", {})
	var persisted: Dictionary = store.persist_profile(default_profile)
	_expect(persisted.get("status", "") == "PERSISTED" and FileAccess.file_exists(target_path), "first persist writes canonical target")
	var canonical: String = _canonical_json(default_profile)
	_expect(_read_bytes(target_path).get_string_from_utf8() == canonical, "first persist bytes are deterministic canonical JSON")
	var fresh: RefCounted = _configured_store()
	_expect(fresh.load_profile().get("status", "") == "LOADED", "fresh configured store reloads valid target")
	var before_time: int = FileAccess.get_modified_time(target_path)
	var no_change: Dictionary = fresh.persist_profile(fresh.get_committed_profile().get("profile", {}))
	_expect(no_change.get("status", "") == "NO_CHANGE" and FileAccess.get_modified_time(target_path) == before_time, "equivalent persist is no-change without metadata rewrite")
	var changed: Dictionary = _profile_with_alpha(4)
	_expect(fresh.persist_profile(changed).get("status", "") == "PERSISTED", "changed persist commits")
	_expect(fresh.get_committed_profile().get("profile", {}) == _canonical_profile(changed), "committed state updates after verified persist")
	var snapshot: Dictionary = fresh.get_committed_profile()
	snapshot["profile"]["progress"]["completed_level_ids"].append("mutated")
	_expect(not fresh.get_committed_profile().get("profile", {}).get("progress", {}).get("completed_level_ids", []).has("mutated"), "committed snapshots are defensive")


func _test_sanitize_and_recovery_collisions() -> void:
	_write_text(target_path, JSON.stringify({"profile_schema_version": 1, "progress": {"completed_level_ids": ["alpha", "unknown"], "best_turns": {"alpha": 5, "unknown": 2}}, "settings": {"language": "en", "window_mode": "windowed", "reduced_motion": false}}))
	var original: PackedByteArray = _read_bytes(target_path)
	var collision: String = _owned("recovery", 0)
	_write_text(collision, "collision")
	var store: RefCounted = _configured_store()
	_expect(store.load_profile().get("status", "") == "SANITIZED", "salvageable v1 loads as sanitized")
	_expect(_read_bytes(target_path) == original, "sanitized load defers source rewrite")
	_expect(store.persist_profile(store.get_committed_profile().get("profile", {})).get("status", "") == "PERSISTED", "pending sanitation prevents no-change")
	_expect(_read_bytes(collision).get_string_from_utf8() == "collision", "recovery collision is never overwritten")
	_expect(_read_bytes(_owned("recovery", 1)) == original, "next bounded recovery sibling preserves exact source")
	_expect(_read_bytes(target_path).get_string_from_utf8() == _canonical_json(store.get_committed_profile().get("profile", {})), "sanitized persist commits canonical bytes")


func _test_fatal_recovery_cases() -> void:
	var cases: Array[PackedByteArray] = [
		"{bad".to_utf8_buffer(),
		"{\"profile_schema_version\":1".to_utf8_buffer(),
		PackedByteArray(),
		"[]".to_utf8_buffer(),
		JSON.stringify({"profile_schema_version": 2, "progress": {}, "settings": {}}).to_utf8_buffer(),
	]
	var oversized := PackedByteArray()
	oversized.resize(MAX_BYTES + 1)
	cases.append(oversized)
	for source_bytes in cases:
		_write_bytes(target_path, source_bytes)
		var store: RefCounted = _configured_store()
		var loaded: Dictionary = store.load_profile()
		_expect(loaded.get("status", "") == "RECOVERED_CLEAN", "fatal source is preserved then recovers clean")
		_expect(_read_bytes(target_path) == source_bytes, "fatal recovery leaves original target untouched")


func _test_failure_seams_and_rollback() -> void:
	_write_text(target_path, _canonical_json(_profile_with_alpha(3)))
	var recovery_store: RefCounted = _configured_store()
	recovery_store.set_test_failure_seam("RECOVERY_COPY")
	_write_text(target_path, "not-json")
	var before_recovery: PackedByteArray = _read_bytes(target_path)
	_expect(recovery_store.load_profile().get("status", "") == "RECOVERY_FAILED", "recovery failure is deterministic")
	_expect(_read_bytes(target_path) == before_recovery and recovery_store.persist_profile(_profile_with_alpha(2)).get("status", "") == "RECOVERY_FAILED", "recovery failure preserves source and disables writes")
	_expect(recovery_store.reset_test_profile().get("status", "") == "RECOVERY_FAILED", "recovery failure disables reset")
	for seam in ["TEMP_WRITE", "TEMP_READBACK", "REPLACE", "POST_REPLACE_VERIFY"]:
		_write_text(target_path, _canonical_json(_profile_with_alpha(3)))
		var old_bytes: PackedByteArray = _read_bytes(target_path)
		var store: RefCounted = _configured_store()
		_expect(store.load_profile().get("status", "") == "LOADED", "seam case starts from valid committed target")
		var old_profile: Dictionary = store.get_committed_profile().get("profile", {})
		store.set_test_failure_seam(seam)
		_expect(store.persist_profile(_profile_with_alpha(2)).get("status", "") == "WRITE_FAILED", seam + " returns write failure")
		_expect(_read_bytes(target_path) == old_bytes and store.get_committed_profile().get("profile", {}) == old_profile, seam + " preserves exact target and committed state")
		store.set_test_failure_seam("NONE")


func _test_invalid_candidate_and_reset() -> void:
	_write_text(target_path, _canonical_json(_profile_with_alpha(3)))
	var store: RefCounted = _configured_store()
	store.load_profile()
	var before: PackedByteArray = _read_bytes(target_path)
	_expect(store.persist_profile({}).get("status", "") == "CANDIDATE_REJECTED" and _read_bytes(target_path) == before, "invalid candidate causes no I/O mutation")
	_expect(store.reset_test_profile().get("status", "") == "RESET" and not FileAccess.file_exists(target_path), "reset removes only exact target without eager rewrite")
	_expect(store.get_committed_profile().get("profile", {}) == _canonical_profile(ProfileCodec.default_profile().get("profile", {})), "reset restores clean in-memory default")


func _profile_with_alpha(turns: int) -> Dictionary:
	return {
		"profile_schema_version": 1,
		"progress": {"completed_level_ids": ["alpha"], "best_turns": {"alpha": turns}},
		"settings": {"language": "en", "window_mode": "windowed", "reduced_motion": false},
	}


func _canonical_profile(profile: Dictionary) -> Dictionary:
	return ProfileCodec.normalize_profile(profile, catalog_facts).get("profile", {})


func _canonical_json(profile: Dictionary) -> String:
	return str(ProfileCodec.serialize_profile(_canonical_profile(profile)).get("json", ""))


func _owned(kind: String, index: int) -> String:
	return fixture_dir + "/.delayed_self_0023w_" + kind + "_" + str(index) + ".json"


func _write_text(path: String, text: String) -> void:
	_write_bytes(path, text.to_utf8_buffer())


func _write_bytes(path: String, bytes: PackedByteArray) -> void:
	var file := FileAccess.open(path, FileAccess.WRITE)
	file.store_buffer(bytes)
	file.flush()
	file.close()


func _read_bytes(path: String) -> PackedByteArray:
	var file := FileAccess.open(path, FileAccess.READ)
	if file == null:
		return PackedByteArray()
	var bytes: PackedByteArray = file.get_buffer(file.get_length())
	file.close()
	return bytes


func _cleanup_exact_inventory() -> void:
	if FileAccess.file_exists(target_path):
		DirAccess.remove_absolute(ProjectSettings.globalize_path(target_path))
	for kind in ["temp", "transaction", "recovery"]:
		for index in range(8):
			var path: String = _owned(kind, index)
			if FileAccess.file_exists(path):
				DirAccess.remove_absolute(ProjectSettings.globalize_path(path))
	_expect(DirAccess.remove_absolute(ProjectSettings.globalize_path(fixture_dir)) == OK, "exact fixture directory is removed after owned inventory cleanup")


func _expect(condition: bool, label: String) -> void:
	assertions += 1
	if not condition:
		failures += 1
		printerr("TEST_FAIL: " + label)


func _abort(reason: String) -> void:
	printerr("TASK_0023W_PROFILE_FILESYSTEM_STORE_BLOCKED: " + reason)
	quit(1)

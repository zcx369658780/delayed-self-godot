extends SceneTree

const AdapterScript = preload("res://scripts/app/profile_progress_adapter.gd")
const ProfileCodec = preload("res://scripts/app/profile_codec.gd")
const MemoryProgressScript = preload("res://scripts/app/memory_progress.gd")

var assertions: int = 0
var failures: int = 0
var catalog: Dictionary = {"entries": [
	{"level_id": "alpha", "unlock_prerequisites": []},
	{"level_id": "beta", "unlock_prerequisites": ["alpha"]},
	{"level_id": "gamma", "unlock_prerequisites": ["alpha", "beta"]},
]}


func _init() -> void:
	_test_configuration_and_rejections()
	_test_load_prepare_commit_reset()
	_test_sanitization_and_atomicity()
	_test_memory_progress_regression()
	print("TASK_0023X_ASSERTIONS=%d" % assertions)
	if failures > 0:
		printerr("TASK_0023X_PROFILE_MEMORY_PROGRESS_ADAPTER_FAIL failures=%d" % failures)
		quit(1)
		return
	print("TASK_0023X_PROFILE_MEMORY_PROGRESS_ADAPTER_TESTS_PASS")
	quit(0)


func _adapter() -> RefCounted:
	var adapter: RefCounted = AdapterScript.new()
	_expect(bool(adapter.configure(catalog).get("ok", false)), "valid catalog configures")
	return adapter


func _test_configuration_and_rejections() -> void:
	var fresh: RefCounted = AdapterScript.new()
	_expect(fresh.load_profile({}).get("status", "") == "NOT_CONFIGURED", "load rejects before config")
	_expect(fresh.commit_profile({}).get("status", "") == "NOT_CONFIGURED", "commit rejects before config")
	_expect(fresh.prepare_completion("alpha", 1).get("status", "") == "PROFILE_NOT_READY", "prepare rejects before config")
	_expect(fresh.reset_to_default().get("status", "") == "NOT_CONFIGURED", "reset rejects before config")
	for invalid in [{}, {"entries": []}, {"entries": [{"level_id": "a", "unlock_prerequisites": []}, {"level_id": "a", "unlock_prerequisites": []}]}, {"entries": [{"level_id": "a", "unlock_prerequisites": ["missing"]}]}, {"entries": [{"level_id": "a", "unlock_prerequisites": ["a"]}]}]:
		var adapter: RefCounted = AdapterScript.new()
		_expect(not bool(adapter.configure(invalid).get("ok", false)) and not adapter.is_configured(), "malformed catalog rejects fresh")
	var retry: RefCounted = AdapterScript.new()
	retry.configure({})
	_expect(bool(retry.configure(catalog).get("ok", false)), "failed first config permits valid retry")
	var snapshot: Dictionary = retry.snapshot()
	catalog["entries"][0]["level_id"] = "mutated"
	_expect(retry.snapshot().get("catalog_facts", {}).get("level_ids", []) == ["alpha", "beta", "gamma"], "catalog copy is defensive")
	snapshot["catalog_facts"]["level_ids"].append("mutated")
	_expect(not retry.snapshot().get("catalog_facts", {}).get("level_ids", []).has("mutated"), "snapshot is defensive")
	catalog = {"entries": [{"level_id": "alpha", "unlock_prerequisites": []}, {"level_id": "beta", "unlock_prerequisites": ["alpha"]}, {"level_id": "gamma", "unlock_prerequisites": ["alpha", "beta"]}]}


func _test_load_prepare_commit_reset() -> void:
	var adapter: RefCounted = _adapter()
	var default_profile: Dictionary = ProfileCodec.default_profile().get("profile", {})
	var loaded: Dictionary = adapter.load_profile(default_profile)
	_expect(loaded.get("status", "") == "LOADED" and adapter.is_unlocked("alpha") and not adapter.is_unlocked("beta"), "default loads root unlock only")
	_expect(adapter.prepare_completion("beta", 1).get("status", "") == "PROGRESS_REJECTED", "locked completion rejects")
	var prepared: Dictionary = adapter.prepare_completion("alpha", 5)
	_expect(prepared.get("status", "") == "CANDIDATE_READY" and adapter.get_profile_snapshot().get("profile", {}) == default_profile, "prepare does not mutate retained profile")
	_expect((prepared.get("profile", {}) as Dictionary).get("settings", {}) == default_profile.get("settings", {}), "candidate preserves settings")
	_expect(adapter.commit_profile(prepared.get("profile", {})).get("status", "") == "COMMITTED" and adapter.is_unlocked("beta"), "explicit commit updates runtime unlock")
	_expect(adapter.prepare_completion("alpha", 6).get("status", "") == "NO_CHANGE", "worse best turn is no change")
	var lower: Dictionary = adapter.prepare_completion("alpha", 3)
	_expect(lower.get("status", "") == "CANDIDATE_READY", "lower best turn prepares candidate")
	adapter.commit_profile(lower.get("profile", {}))
	_expect(adapter.get_profile_snapshot().get("profile", {}).get("progress", {}).get("best_turns", {}).get("alpha", 0) == 3, "commit retains lower best turn")
	var partial: Dictionary = default_profile.duplicate(true)
	partial["progress"]["completed_level_ids"] = ["alpha", "beta"]
	partial["progress"]["best_turns"] = {"alpha": 4}
	adapter.load_profile(partial)
	_expect(adapter.is_unlocked("gamma") and not adapter.get_profile_snapshot().get("profile", {}).get("progress", {}).get("best_turns", {}).has("beta"), "completed entry without best turn is retained")
	_expect(adapter.reset_to_default().get("status", "") == "RESET" and adapter.snapshot().get("runtime", {}).get("completed_level_ids", []).is_empty() and adapter.is_unlocked("alpha"), "memory-only reset restores default roots")


func _test_sanitization_and_atomicity() -> void:
	var adapter: RefCounted = _adapter()
	adapter.load_profile(ProfileCodec.default_profile().get("profile", {}))
	var before: Dictionary = adapter.snapshot()
	var invalid: Dictionary = {"profile_schema_version": 2, "progress": {}, "settings": {}}
	_expect(not bool(adapter.load_profile(invalid).get("ok", false)) and adapter.snapshot() == before, "invalid root rejects atomically")
	var raw: Dictionary = ProfileCodec.default_profile().get("profile", {}).duplicate(true)
	raw["extra"] = true
	raw["progress"]["completed_level_ids"] = ["gamma", "alpha", "alpha", "unknown"]
	raw["progress"]["best_turns"] = {"alpha": 4, "gamma": 1, "unknown": 2}
	var sanitized: Dictionary = adapter.load_profile(raw)
	_expect(sanitized.get("status", "") == "SANITIZED", "codec sanitation status is retained")
	_expect(sanitized.get("runtime", {}).get("completed_level_ids", []) == ["alpha"], "unknown duplicate and prerequisite-invalid completions sanitize")
	var profile_snapshot: Dictionary = adapter.get_profile_snapshot()
	profile_snapshot["profile"]["settings"]["language"] = "mutated"
	_expect(adapter.get_profile_snapshot().get("profile", {}).get("settings", {}).get("language", "") == "en", "profile snapshots are defensive")


func _test_memory_progress_regression() -> void:
	var progress: RefCounted = MemoryProgressScript.new(catalog)
	_expect(progress.is_unlocked("alpha") and progress.record_completion("alpha", 7), "existing constructor and record behavior remain")
	var before: Dictionary = progress.snapshot()
	_expect(not progress.replace_profile_progress(["beta"], {"beta": 1}) and progress.snapshot() == before, "hydration rejection preserves existing state")
	progress.reset_test_profile()
	_expect(progress.snapshot().get("completed_level_ids", []).is_empty() and progress.is_unlocked("alpha"), "existing reset semantics remain")


func _expect(condition: bool, label: String) -> void:
	assertions += 1
	if not condition:
		failures += 1
		printerr("TEST_FAIL: " + label)

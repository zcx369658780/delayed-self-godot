extends SceneTree

const LocalProfileScript = preload("res://scripts/app/local_profile.gd")

var assertions: int = 0
var failures: int = 0


func _init() -> void:
	_test_valid_configuration_and_defensive_copies()
	_test_path_rejections_and_fresh_retry()
	_test_catalog_rejections()
	_test_reconfiguration_and_determinism()
	print("TASK_0023V_ASSERTIONS=%d" % assertions)
	if failures > 0:
		printerr("TASK_0023V_PROFILE_STORE_INSTANCE_CONFIGURATION_FAIL failures=%d" % failures)
		quit(1)
		return
	print("TASK_0023V_PROFILE_STORE_INSTANCE_CONFIGURATION_TESTS_PASS")
	quit(0)


func _catalog_facts() -> Dictionary:
	return {
		"level_ids": ["alpha", "beta"],
		"prerequisites": {"alpha": [], "beta": ["alpha"]},
	}


func _canonical_path(fixture_id: String) -> String:
	var built: Dictionary = LocalProfileScript.build_test_profile_path(fixture_id)
	_expect(bool(built.get("ok", false)), "fixture builder accepts task synthetic ID")
	return str(built.get("path", ""))


func _fresh_store() -> RefCounted:
	var store: RefCounted = LocalProfileScript.new()
	return store


func _test_valid_configuration_and_defensive_copies() -> void:
	var facts: Dictionary = _catalog_facts()
	var store: RefCounted = _fresh_store()
	_expect(not store.is_configured(), "fresh store is unconfigured")
	var configured: Dictionary = store.configure_test(facts, _canonical_path("ConfigOne"))
	_expect(bool(configured.get("ok", false)) and configured.get("status", "") == "TEST_STORE_CONFIGURED", "valid canonical path configures once")
	_expect(store.is_configured(), "configured state is observable")
	var snapshot: Dictionary = store.get_configuration_snapshot()
	_expect(snapshot.get("test_profile_path", "") == _canonical_path("ConfigOne"), "snapshot retains only canonical virtual path")
	facts["level_ids"].append("mutated")
	facts["prerequisites"]["beta"].append("mutated")
	var after_input_mutation: Dictionary = store.get_configuration_snapshot()
	_expect(after_input_mutation.get("catalog_facts", {}) == _catalog_facts(), "retained catalog is defensively copied")
	snapshot["catalog_facts"]["level_ids"].append("snapshot_mutation")
	_expect(store.get_configuration_snapshot().get("catalog_facts", {}) == _catalog_facts(), "returned snapshot is a defensive copy")


func _test_path_rejections_and_fresh_retry() -> void:
	var facts: Dictionary = _catalog_facts()
	var production_store: RefCounted = _fresh_store()
	var production: Dictionary = production_store.configure_test(facts, LocalProfileScript.PRODUCTION_PROFILE_PATH)
	_expect(not bool(production.get("ok", false)) and not production_store.is_configured(), "production path rejects without fallback")
	_expect(production.get("configuration", {}) == {"configured": false}, "production rejection retains no path")
	var invalid_store: RefCounted = _fresh_store()
	var invalid: Dictionary = invalid_store.configure_test(facts, "user://delayed_self_test_profiles//delayed_self_profile.json")
	_expect(not bool(invalid.get("ok", false)) and not invalid_store.is_configured(), "invalid test path rejects without configuration")
	var retry: Dictionary = invalid_store.configure_test(facts, _canonical_path("RetryOne"))
	_expect(bool(retry.get("ok", false)) and invalid_store.is_configured(), "failed first configuration permits later valid configuration")


func _test_catalog_rejections() -> void:
	var path: String = _canonical_path("CatalogReject")
	var invalid_facts: Array = [
		{},
		{"level_ids": [], "prerequisites": {}},
		{"level_ids": ["alpha", "alpha"], "prerequisites": {"alpha": []}},
		{"level_ids": ["alpha"], "prerequisites": {}},
		{"level_ids": ["alpha"], "prerequisites": {"alpha": ["missing"]}},
		{"level_ids": ["alpha"], "prerequisites": {"alpha": ["alpha"]}},
		{"level_ids": ["alpha"], "prerequisites": {"alpha": ["alpha", "alpha"]}},
	]
	for raw_facts: Variant in invalid_facts:
		var store: RefCounted = _fresh_store()
		var result: Dictionary = store.configure_test(raw_facts as Dictionary, path)
		_expect(not bool(result.get("ok", false)) and not store.is_configured(), "invalid catalog facts reject without partial configuration")


func _test_reconfiguration_and_determinism() -> void:
	var facts: Dictionary = _catalog_facts()
	var store: RefCounted = _fresh_store()
	var first: Dictionary = store.configure_test(facts, _canonical_path("StableOne"))
	var before: Dictionary = store.get_configuration_snapshot()
	var second: Dictionary = store.configure_test(facts, _canonical_path("StableTwo"))
	_expect(bool(first.get("ok", false)) and not bool(second.get("ok", false)), "second configuration rejects")
	_expect(store.get_configuration_snapshot() == before, "second configuration preserves original snapshot")
	var repeat_store: RefCounted = _fresh_store()
	var repeat_first: Dictionary = repeat_store.configure_test(_catalog_facts(), _canonical_path("StableOne"))
	_expect(first == repeat_first, "successful configuration result is deterministic")
	var rejected_one: Dictionary = LocalProfileScript.validate_test_profile_path(LocalProfileScript.PRODUCTION_PROFILE_PATH)
	var rejected_two: Dictionary = LocalProfileScript.validate_test_profile_path(LocalProfileScript.PRODUCTION_PROFILE_PATH)
	_expect(rejected_one == rejected_two and not rejected_one.has("path"), "accepted policy rejection remains deterministic")


func _expect(condition: bool, label: String) -> void:
	assertions += 1
	if not condition:
		failures += 1
		printerr("TEST_FAIL: " + label)

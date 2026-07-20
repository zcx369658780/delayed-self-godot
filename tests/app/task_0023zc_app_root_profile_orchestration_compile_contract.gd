extends SceneTree

const AppRootScene = preload("res://scenes/app/app_root.tscn")
const CANONICAL_TEST_PROFILE_PATH: String = "user://delayed_self_test_profiles/task_0023zc_compile_only/delayed_self_profile.json"
const PRODUCTION_PROFILE_PATH: String = "user://delayed_self_profile.json"

var assertions: int = 0
var failures: int = 0


func _initialize() -> void:
	call_deferred("_run")


func _run() -> void:
	_test_off_tree_configuration_contract()
	await _test_unconfigured_tree_contract()
	print("TASK_0023ZC_ASSERTIONS=%d" % assertions)
	if failures == 0:
		print("TASK_0023ZC_APP_ROOT_PROFILE_ORCHESTRATION_COMPILE_CONTRACT_PASS")
		quit(0)
	else:
		print("TASK_0023ZC_APP_ROOT_PROFILE_ORCHESTRATION_COMPILE_CONTRACT_FAIL failures=%d" % failures)
		quit(1)


func _test_off_tree_configuration_contract() -> void:
	var app: Node = AppRootScene.instantiate()
	var production_rejection: Dictionary = app.configure_test_profile(PRODUCTION_PROFILE_PATH)
	_expect(not bool(production_rejection.get("ok", false)) and not bool(production_rejection.get("configured", true)), "production Profile path rejects without configuration")
	var invalid_rejection: Dictionary = app.configure_test_profile("res://delayed_self_profile.json")
	_expect(not bool(invalid_rejection.get("ok", false)) and not bool(invalid_rejection.get("configured", true)), "invalid non-test path rejects without fallback")
	var valid_configuration: Dictionary = app.configure_test_profile(CANONICAL_TEST_PROFILE_PATH)
	_expect(bool(valid_configuration.get("ok", false)) and bool(valid_configuration.get("configured", false)), "valid canonical path succeeds after rejected attempts")
	var immutable_configuration: Dictionary = app.configure_test_profile("user://delayed_self_test_profiles/other_compile_only/delayed_self_profile.json")
	_expect(not bool(immutable_configuration.get("ok", false)) and str(immutable_configuration.get("status", "")) == "APP_PROFILE_ALREADY_CONFIGURED", "first valid configuration is immutable")
	var session: Dictionary = app.get_test_profile_session_snapshot()
	var session_keys: Array = session.keys()
	session_keys.sort()
	_expect(session_keys == ["boot_status", "configured", "load_status", "mode", "persist_status", "progress"], "session snapshot exposes only bounded status and progress keys")
	_expect(str(session.get("mode", "")) == "TEST_PROFILE" and bool(session.get("configured", false)) and not JSON.stringify(session).contains(CANONICAL_TEST_PROFILE_PATH), "session snapshot does not expose retained path")
	var progress: Dictionary = session.get("progress", {})
	_expect(_has_exact_progress_keys(progress), "configured pre-boot progress surface retains the exact public shape")
	var seam_rejection: Dictionary = app.set_test_profile_failure_seam("TEMP_WRITE")
	_expect(not bool(seam_rejection.get("ok", false)) and str(seam_rejection.get("status", "")) == "APP_PROFILE_STORE_NOT_READY", "failure seam rejects before store construction")
	app.free()
	_expect(not is_instance_valid(app), "configured off-tree AppRoot frees without boot or tree entry")


func _test_unconfigured_tree_contract() -> void:
	var app: Node = AppRootScene.instantiate()
	root.add_child(app)
	await process_frame
	_expect(app.get_current_route() == "MAIN_MENU" and app.get_active_screen_count() == 1, "unconfigured AppRoot boots normal Main Menu")
	var session: Dictionary = app.get_test_profile_session_snapshot()
	_expect(str(session.get("mode", "")) == "MEMORY_ONLY" and not bool(session.get("configured", true)) and str(session.get("boot_status", "")) == "MEMORY_ONLY_READY", "normal boot remains memory-only")
	var progress: Dictionary = app.get_progress_snapshot()
	_expect(_has_exact_progress_keys(progress), "memory-only progress snapshot has exactly three public keys")
	var completed: Array = progress.get("completed_level_ids", [])
	var best_turns: Dictionary = progress.get("best_turns", {})
	var unlocked: Array = progress.get("unlocked_level_ids", [])
	_expect(completed.is_empty() and best_turns.is_empty() and unlocked == ["tutorial_reach_exit"], "memory-only progress initially unlocks only Tutorial 0")
	completed.append("mutation_attempt")
	best_turns["mutation_attempt"] = 1
	unlocked.clear()
	var defensive: Dictionary = app.get_progress_snapshot()
	_expect((defensive.get("completed_level_ids", []) as Array).is_empty() and (defensive.get("best_turns", {}) as Dictionary).is_empty() and defensive.get("unlocked_level_ids", []) == ["tutorial_reach_exit"], "memory-only public progress snapshot is defensive")
	var late_configuration: Dictionary = app.configure_test_profile(CANONICAL_TEST_PROFILE_PATH)
	_expect(not bool(late_configuration.get("ok", false)) and str(late_configuration.get("status", "")) == "APP_PROFILE_CONFIGURATION_TOO_LATE", "valid configuration rejects after tree entry")
	var late_session: Dictionary = app.get_test_profile_session_snapshot()
	_expect(str(late_session.get("mode", "")) == "MEMORY_ONLY" and not bool(late_session.get("configured", true)), "late rejection cannot switch normal boot mode")
	app.boot_with_user_args(PackedStringArray(["--level-id=tutorial_reach_exit"]))
	await process_frame
	var gameplay: Node = app.get_active_screen()
	var route_payload: Dictionary = gameplay.get_route_payload() if gameplay != null and gameplay.has_method("get_route_payload") else {}
	_expect(app.get_current_route() == "GAMEPLAY" and bool(route_payload.get("development_direct", false)) and str(route_payload.get("level_id", "")) == "tutorial_reach_exit", "unconfigured direct-development routing remains unchanged")
	app.queue_free()
	await process_frame


func _has_exact_progress_keys(progress: Dictionary) -> bool:
	var keys: Array = progress.keys()
	keys.sort()
	return keys == ["best_turns", "completed_level_ids", "unlocked_level_ids"]


func _expect(condition: bool, label: String) -> void:
	assertions += 1
	if not condition:
		failures += 1
		print("TASK_0023ZC_ASSERT_FAIL label=" + label)

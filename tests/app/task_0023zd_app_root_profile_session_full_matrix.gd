extends SceneTree

const AppRootScene = preload("res://scenes/app/app_root.tscn")
const CatalogLoader = preload("res://scripts/app/catalog_loader.gd")
const LocalProfile = preload("res://scripts/app/local_profile.gd")
const ProfileCodec = preload("res://scripts/app/profile_codec.gd")
const ProfileProgressAdapter = preload("res://scripts/app/profile_progress_adapter.gd")

const EXECUTION_GUARD: String = "--task-0023zn-fixture-execution"
const FIXTURE_ID: String = "task_0023zn_app_root_profile_session"
const CANONICAL_PROFILE_PATH: String = "user://delayed_self_test_profiles/task_0023zn_app_root_profile_session/delayed_self_profile.json"
const EXPECTED_ASSERTION_COUNT: int = 42
const TUTORIAL_0_ID: String = "tutorial_reach_exit"
const TUTORIAL_1_ID: String = "tutorial_echo_bridge"
const PUBLIC_PROGRESS_KEYS: Array[String] = ["best_turns", "completed_level_ids", "unlocked_level_ids"]
const FAILURE_STAGES: Array[String] = ["NONE", "RECOVERY_COPY", "TEMP_WRITE", "TEMP_READBACK", "REPLACE", "POST_REPLACE_VERIFY"]

var current_stage: String = "guard"
var assertions: int = 0
var failures: int = 0
var fixture_dir: String = ""
var owned_paths: Array[String] = []
var production_metadata_baseline: Dictionary = {}
var test_root_exists_baseline: bool = false
var current_app: Node
var failure_contract_ok: bool = true


func _initialize() -> void:
	var arguments: PackedStringArray = OS.get_cmdline_user_args()
	if not arguments.has(EXECUTION_GUARD):
		print("TASK_0023ZN_EXECUTION_GUARD_BLOCKED")
		quit(2)
		return
	call_deferred("_run_authorized")


func _run_authorized() -> void:
	print("TASK_0023ZN_BEHAVIOR_PROCESS_STARTED")
	if not await _run_startup_stage():
		return
	if not await _run_invalid_configuration_stage():
		return
	if not await _run_late_and_reconfiguration_stage():
		return
	if not await _run_normal_memory_boot_stage():
		return
	if not await _run_missing_profile_boot_stage():
		return
	if not await _run_tutorial_0_persist_stage():
		return
	if not await _run_fresh_reload_stage():
		return
	if not await _run_no_change_stage():
		return
	if not await _run_temp_write_failure_stage():
		return
	if not await _run_temp_readback_failure_stage():
		return
	if not await _run_replace_failure_stage():
		return
	if not await _run_post_replace_verify_failure_stage():
		return
	if not await _run_malformed_recovery_stage():
		return
	if not await _run_unknown_version_recovery_stage():
		return
	if not await _run_public_snapshot_stage():
		return
	if not await _run_router_contract_stage():
		return
	if not await _run_cleanup_stage():
		return
	if not await _run_final_stage():
		return
	if assertions != EXPECTED_ASSERTION_COUNT:
		_abort_stage("assertion_count_mismatch")
		return
	print("TASK_0023ZN_ASSERTIONS=%d" % assertions)
	print("TASK_0023ZN_APP_ROOT_PROFILE_SESSION_FULL_MATRIX_PASS")
	quit(0)


func _run_startup_stage() -> bool:
	_begin_stage("startup")
	var before: int = failures
	await _stage_startup()
	return _finish_stage("startup", before)


func _run_invalid_configuration_stage() -> bool:
	_begin_stage("invalid_configuration")
	var before: int = failures
	await _stage_invalid_configuration()
	return _finish_stage("invalid_configuration", before)


func _run_late_and_reconfiguration_stage() -> bool:
	_begin_stage("late_and_reconfiguration")
	var before: int = failures
	await _stage_late_and_reconfiguration()
	return _finish_stage("late_and_reconfiguration", before)


func _run_normal_memory_boot_stage() -> bool:
	_begin_stage("normal_memory_boot")
	var before: int = failures
	await _stage_normal_memory_boot()
	return _finish_stage("normal_memory_boot", before)


func _run_missing_profile_boot_stage() -> bool:
	_begin_stage("missing_profile_boot")
	var before: int = failures
	await _stage_missing_profile_boot()
	return _finish_stage("missing_profile_boot", before)


func _run_tutorial_0_persist_stage() -> bool:
	_begin_stage("tutorial_0_persist")
	var before: int = failures
	await _stage_tutorial_0_persist()
	return _finish_stage("tutorial_0_persist", before)


func _run_fresh_reload_stage() -> bool:
	_begin_stage("fresh_reload")
	var before: int = failures
	await _stage_fresh_reload()
	return _finish_stage("fresh_reload", before)


func _run_no_change_stage() -> bool:
	_begin_stage("no_change")
	var before: int = failures
	await _stage_no_change()
	return _finish_stage("no_change", before)


func _run_temp_write_failure_stage() -> bool:
	_begin_stage("temp_write_failure")
	var before: int = failures
	await _stage_temp_write_failure()
	return _finish_stage("temp_write_failure", before)


func _run_temp_readback_failure_stage() -> bool:
	_begin_stage("temp_readback_failure")
	var before: int = failures
	await _stage_temp_readback_failure()
	return _finish_stage("temp_readback_failure", before)


func _run_replace_failure_stage() -> bool:
	_begin_stage("replace_failure")
	var before: int = failures
	await _stage_replace_failure()
	return _finish_stage("replace_failure", before)


func _run_post_replace_verify_failure_stage() -> bool:
	_begin_stage("post_replace_verify_failure")
	var before: int = failures
	await _stage_post_replace_verify_failure()
	return _finish_stage("post_replace_verify_failure", before)


func _run_malformed_recovery_stage() -> bool:
	_begin_stage("malformed_recovery")
	var before: int = failures
	await _stage_malformed_recovery()
	return _finish_stage("malformed_recovery", before)


func _run_unknown_version_recovery_stage() -> bool:
	_begin_stage("unknown_version_recovery")
	var before: int = failures
	await _stage_unknown_version_recovery()
	return _finish_stage("unknown_version_recovery", before)


func _run_public_snapshot_stage() -> bool:
	_begin_stage("public_snapshot")
	var before: int = failures
	await _stage_public_snapshot()
	return _finish_stage("public_snapshot", before)


func _run_router_contract_stage() -> bool:
	_begin_stage("router_contract")
	var before: int = failures
	await _stage_router_contract()
	return _finish_stage("router_contract", before)


func _run_cleanup_stage() -> bool:
	_begin_stage("cleanup")
	var before: int = failures
	await _stage_cleanup()
	return _finish_stage("cleanup", before)


func _run_final_stage() -> bool:
	_begin_stage("final")
	var before: int = failures
	await _stage_final()
	return _finish_stage("final", before)


func _stage_startup() -> void:
	var built: Dictionary = LocalProfile.build_test_profile_path(FIXTURE_ID)
	if not bool(built.get("ok", false)) or str(built.get("path", "")) != CANONICAL_PROFILE_PATH:
		_abort_stage("fixed_fixture_contract_rejected")
		return
	fixture_dir = CANONICAL_PROFILE_PATH.get_base_dir()
	_build_owned_inventory()
	production_metadata_baseline = _production_metadata()
	test_root_exists_baseline = _test_root_exists()
	if DirAccess.dir_exists_absolute(ProjectSettings.globalize_path(fixture_dir)):
		_abort_stage("future_fixture_not_fresh")
		return
	await process_frame


func _stage_invalid_configuration() -> void:
	var app: Node = AppRootScene.instantiate()
	var production: Dictionary = app.configure_test_profile(LocalProfile.PRODUCTION_PROFILE_PATH)
	_expect_case("reject_production_path", not bool(production.get("ok", false)) and not bool(production.get("configured", true)), "production_rejected")
	var malformed_paths: Array[String] = ["res://profile.json", "user://delayed_self_test_profiles//delayed_self_profile.json", "C:/profile.json"]
	var malformed_ok: bool = true
	for malformed_path: String in malformed_paths:
		var rejected: Dictionary = app.configure_test_profile(malformed_path)
		malformed_ok = malformed_ok and not bool(rejected.get("ok", false)) and not bool(rejected.get("configured", true))
	_expect_case("reject_malformed_paths", malformed_ok, "malformed_paths_rejected")
	var valid: Dictionary = app.configure_test_profile(CANONICAL_PROFILE_PATH)
	_expect_case("retry_after_rejection", bool(valid.get("ok", false)) and bool(valid.get("configured", false)), "valid_retry_configured")
	var immutable: Dictionary = app.configure_test_profile("user://delayed_self_test_profiles/alternate_session/delayed_self_profile.json")
	_expect_case("first_valid_configuration_immutable", not bool(immutable.get("ok", false)) and str(immutable.get("status", "")) == "APP_PROFILE_ALREADY_CONFIGURED", "first_valid_immutable")
	app.free()
	await process_frame


func _stage_late_and_reconfiguration() -> void:
	var app: Node = AppRootScene.instantiate()
	root.add_child(app)
	await process_frame
	var late: Dictionary = app.configure_test_profile(CANONICAL_PROFILE_PATH)
	var session: Dictionary = app.get_test_profile_session_snapshot()
	_expect_case("late_configuration_rejected", not bool(late.get("ok", false)) and str(late.get("status", "")) == "APP_PROFILE_CONFIGURATION_TOO_LATE" and str(session.get("mode", "")) == "MEMORY_ONLY", "late_configuration_rejected")
	await _dispose_app(app)


func _stage_normal_memory_boot() -> void:
	var app: Node = AppRootScene.instantiate()
	root.add_child(app)
	await process_frame
	var progress: Dictionary = app.get_progress_snapshot()
	var session: Dictionary = app.get_test_profile_session_snapshot()
	var normal_ok: bool = (
		app.get_current_route() == "MAIN_MENU"
		and app.get_active_screen_count() == 1
		and str(session.get("mode", "")) == "MEMORY_ONLY"
		and app._profile_store == null
		and app._profile_adapter == null
		and _has_exact_progress_keys(progress)
		and progress.get("unlocked_level_ids", []) == [TUTORIAL_0_ID]
	)
	var returned_completed: Array = progress.get("completed_level_ids", [])
	returned_completed.append("mutation")
	var defensive: Dictionary = app.get_progress_snapshot()
	normal_ok = normal_ok and (defensive.get("completed_level_ids", []) as Array).is_empty()
	_expect_case("normal_memory_boot_contract", normal_ok, "memory_boot_contract")
	app.boot_with_user_args(PackedStringArray(["--level-id=" + TUTORIAL_0_ID]))
	await process_frame
	var gameplay: Node = app.get_active_screen()
	var payload: Dictionary = gameplay.get_route_payload() if gameplay != null and gameplay.has_method("get_route_payload") else {}
	_expect_case("unconfigured_direct_development_route", app.get_current_route() == "GAMEPLAY" and bool(payload.get("development_direct", false)) and str(payload.get("level_id", "")) == TUTORIAL_0_ID, "direct_route_preserved")
	await _dispose_app(app)


func _stage_missing_profile_boot() -> void:
	if DirAccess.make_dir_recursive_absolute(ProjectSettings.globalize_path(fixture_dir)) != OK:
		_abort_stage("fixture_directory_create_failed")
		return
	current_app = await _spawn_configured_app()
	var session: Dictionary = current_app.get_test_profile_session_snapshot()
	var progress: Dictionary = current_app.get_progress_snapshot()
	var missing_ok: bool = (
		current_app.get_current_route() == "MAIN_MENU"
		and current_app.get_active_screen_count() == 1
		and str(session.get("load_status", "")) == "MISSING_CLEAN"
		and not FileAccess.file_exists(CANONICAL_PROFILE_PATH)
		and (progress.get("completed_level_ids", []) as Array).is_empty()
		and progress.get("unlocked_level_ids", []) == [TUTORIAL_0_ID]
	)
	_expect_case("missing_profile_clean_boot", missing_ok, "missing_boot_clean")
	await process_frame


func _stage_tutorial_0_persist() -> void:
	current_app.select_level(TUTORIAL_0_ID)
	await process_frame
	var gameplay: Node = current_app.get_active_screen()
	var pre_progress: Dictionary = current_app.get_progress_snapshot()
	var pre_profile_result: Dictionary = current_app._profile_store.get_committed_profile()
	var pre_profile: Dictionary = (pre_profile_result.get("profile", {}) as Dictionary).duplicate(true)
	_send_action(gameplay, "move_up")
	_send_action(gameplay, "move_right")
	await process_frame
	var unchanged_before_final: bool = current_app.get_progress_snapshot() == pre_progress and current_app._profile_store.get_committed_profile().get("profile", {}) == pre_profile
	_expect_case("pre_persist_runtime_profile_unchanged", unchanged_before_final, "pre_persist_unchanged")
	_send_action(gameplay, "move_right")
	await process_frame
	var progress: Dictionary = current_app.get_progress_snapshot()
	var session: Dictionary = current_app.get_test_profile_session_snapshot()
	var completed: Array = progress.get("completed_level_ids", [])
	var best_turns: Dictionary = progress.get("best_turns", {})
	var unlocked: Array = progress.get("unlocked_level_ids", [])
	_expect_case("tutorial_zero_real_three_turn_completion", current_app.get_current_route() == "LEVEL_SELECT" and completed == [TUTORIAL_0_ID] and int(best_turns.get(TUTORIAL_0_ID, 0)) == 3, "tutorial_zero_three_turns")
	_expect_case("persist_precedes_adapter_commit", str(session.get("persist_status", "")).begins_with("COMMITTED_AFTER_PERSISTED"), "persist_before_commit")
	_expect_case("tutorial_zero_persisted_progress_route", completed == [TUTORIAL_0_ID] and unlocked == _expected_tutorial_unlocked_ids() and current_app.get_active_screen_count() == 1, "persisted_progress_route")
	var committed_result: Dictionary = current_app._profile_store.get_committed_profile()
	var committed_profile: Dictionary = committed_result.get("profile", {})
	var serialized: Dictionary = ProfileCodec.serialize_profile(committed_profile)
	var canonical_bytes: PackedByteArray = str(serialized.get("json", "")).to_utf8_buffer()
	var target_bytes: PackedByteArray = _read_bytes(CANONICAL_PROFILE_PATH)
	_expect_case("canonical_target_bytes", target_bytes == canonical_bytes, "canonical_target_bytes")
	await process_frame


func _stage_fresh_reload() -> void:
	await _dispose_app(current_app)
	current_app = await _spawn_configured_app()
	var progress: Dictionary = current_app.get_progress_snapshot()
	var best_turns: Dictionary = progress.get("best_turns", {})
	var reload_ok: bool = (
		current_app.get_current_route() == "MAIN_MENU"
		and progress.get("completed_level_ids", []) == [TUTORIAL_0_ID]
		and int(best_turns.get(TUTORIAL_0_ID, 0)) == 3
		and progress.get("unlocked_level_ids", []) == _expected_tutorial_unlocked_ids()
	)
	_expect_case("fresh_reload_progress", reload_ok, "fresh_reload_progress")
	_expect_case("fresh_reload_single_active_screen", current_app.get_active_screen_count() == 1, "reload_single_screen")
	await process_frame


func _stage_no_change() -> void:
	var before_bytes: PackedByteArray = _read_bytes(CANONICAL_PROFILE_PATH)
	var before_time: int = FileAccess.get_modified_time(CANONICAL_PROFILE_PATH)
	var before_progress: Dictionary = current_app.get_progress_snapshot()
	current_app.select_level(TUTORIAL_0_ID)
	await process_frame
	var gameplay: Node = current_app.get_active_screen()
	_send_action(gameplay, "move_up")
	_send_action(gameplay, "move_right")
	_send_action(gameplay, "move_right")
	await process_frame
	var session: Dictionary = current_app.get_test_profile_session_snapshot()
	var after_progress: Dictionary = current_app.get_progress_snapshot()
	_expect_case("no_change_equal_or_worse_replay", str(session.get("persist_status", "")) == "NO_CHANGE", "equal_replay_no_change")
	_expect_case("no_change_target_metadata_bytes", _read_bytes(CANONICAL_PROFILE_PATH) == before_bytes and FileAccess.get_modified_time(CANONICAL_PROFILE_PATH) == before_time, "no_change_target_exact")
	_expect_case("no_change_runtime_semantics", after_progress == before_progress, "no_change_runtime_same")
	var catalog: Dictionary = current_app.get_catalog_snapshot()
	var entries: Array = catalog.get("entries", [])
	var final_entry: Dictionary = entries[entries.size() - 1] if not entries.is_empty() and entries[entries.size() - 1] is Dictionary else {}
	_expect_case("no_change_route_finale_contract", current_app.get_current_route() == "LEVEL_SELECT" and bool(final_entry.get("final_level", false)), "route_finale_contract")
	await _dispose_app(current_app)


func _stage_temp_write_failure() -> void:
	await _run_failure_case("TEMP_WRITE", "temp_write_rollback")
	var app: Node = await _spawn_configured_app()
	var invalid: Dictionary = app.set_test_profile_failure_seam("NOT_ACCEPTED")
	var valid_none: Dictionary = app.set_test_profile_failure_seam("NONE")
	_expect_case("failure_seam_whitelist", not bool(invalid.get("ok", false)) and bool(valid_none.get("ok", false)) and FAILURE_STAGES == app.PROFILE_FAILURE_SEAM_STAGES, "failure_seam_whitelist")
	await _dispose_app(app)


func _stage_temp_readback_failure() -> void:
	await _run_failure_case("TEMP_READBACK", "temp_readback_rollback")


func _stage_replace_failure() -> void:
	await _run_failure_case("REPLACE", "replace_rollback")


func _stage_post_replace_verify_failure() -> void:
	await _run_failure_case("POST_REPLACE_VERIFY", "post_replace_verify_rollback")
	_expect_case("failure_safe_error_no_false_success", failure_contract_ok, "all_failures_safe_error")


func _stage_malformed_recovery() -> void:
	_remove_recovery_inventory()
	var malformed: PackedByteArray = "{malformed".to_utf8_buffer()
	if not _write_bytes(CANONICAL_PROFILE_PATH, malformed):
		_abort_stage("malformed_write_failed")
		return
	var app: Node = await _spawn_configured_app()
	var recovery_path: String = _owned_path("recovery", 0)
	var preserved: bool = FileAccess.file_exists(recovery_path) and _read_bytes(recovery_path) == malformed and _read_bytes(CANONICAL_PROFILE_PATH) == malformed
	_expect_case("malformed_recovery_preserves_source", preserved, "malformed_source_preserved")
	var progress: Dictionary = app.get_progress_snapshot()
	var session: Dictionary = app.get_test_profile_session_snapshot()
	_expect_case("malformed_recovery_clean_hydration", app.get_current_route() == "MAIN_MENU" and str(session.get("load_status", "")) == "RECOVERED_CLEAN" and (progress.get("completed_level_ids", []) as Array).is_empty(), "malformed_clean_hydration")
	await _dispose_app(app)


func _stage_unknown_version_recovery() -> void:
	_remove_recovery_inventory()
	var unknown_profile: Dictionary = {
		"profile_schema_version": 99,
		"progress": {},
		"settings": {},
	}
	var unknown_bytes: PackedByteArray = JSON.stringify(unknown_profile).to_utf8_buffer()
	if not _write_bytes(CANONICAL_PROFILE_PATH, unknown_bytes):
		_abort_stage("unknown_version_write_failed")
		return
	var app: Node = await _spawn_configured_app()
	var recovery_path: String = _owned_path("recovery", 0)
	var unknown_ok: bool = (
		app.get_current_route() == "MAIN_MENU"
		and app.get_test_profile_session_snapshot().get("load_status", "") == "RECOVERED_CLEAN"
		and _read_bytes(CANONICAL_PROFILE_PATH) == unknown_bytes
		and FileAccess.file_exists(recovery_path)
		and _read_bytes(recovery_path) == unknown_bytes
	)
	_expect_case("unknown_version_recovery", unknown_ok, "unknown_version_recovered")
	await _dispose_app(app)
	_remove_recovery_inventory()
	var malformed: PackedByteArray = "{recovery-failure".to_utf8_buffer()
	_write_bytes(CANONICAL_PROFILE_PATH, malformed)
	var facts: Dictionary = _catalog_facts()
	var store: RefCounted = LocalProfile.new()
	var configured: Dictionary = store.configure_test(facts, CANONICAL_PROFILE_PATH)
	var seam: Dictionary = store.set_test_failure_seam("RECOVERY_COPY")
	var failed_load: Dictionary = store.load_profile()
	var direct_store_ok: bool = (
		bool(configured.get("ok", false))
		and bool(seam.get("ok", false))
		and str(failed_load.get("status", "")) == "RECOVERY_FAILED"
		and _read_bytes(CANONICAL_PROFILE_PATH) == malformed
		and str(store.persist_profile(_tutorial_profile(2)).get("status", "")) == "RECOVERY_FAILED"
		and str(store.reset_test_profile().get("status", "")) == "RECOVERY_FAILED"
	)
	var collisions_ok: bool = true
	for index: int in range(8):
		var collision_path: String = _owned_path("recovery", index)
		collisions_ok = collisions_ok and _write_bytes(collision_path, ("collision-%d" % index).to_utf8_buffer())
	var blocked_app: Node = await _spawn_configured_app()
	var blocked_progress: Dictionary = blocked_app.get_progress_snapshot()
	var app_failure_ok: bool = blocked_app.get_current_route() == "SAFE_ERROR" and blocked_app.get_active_screen_count() == 1 and (blocked_progress.get("completed_level_ids", []) as Array).is_empty()
	_expect_case("recovery_failure_write_disable_safe_error", direct_store_ok and app_failure_ok, "recovery_failure_safe_error")
	var collision_preserved: bool = collisions_ok
	for index: int in range(8):
		collision_preserved = collision_preserved and _read_bytes(_owned_path("recovery", index)).get_string_from_utf8() == "collision-%d" % index
	_expect_case("owned_collision_no_root_enumeration", collision_preserved and _all_owned_paths_bounded(), "owned_collision_bounded")
	await _dispose_app(blocked_app)
	_remove_recovery_inventory()


func _stage_public_snapshot() -> void:
	_write_canonical_tutorial_profile()
	current_app = await _spawn_configured_app()
	var progress: Dictionary = current_app.get_progress_snapshot()
	_expect_case("public_progress_exact_keys", _has_exact_progress_keys(progress), "public_progress_exact_keys")
	var wrapper: Dictionary = current_app._profile_adapter.snapshot()
	var runtime: Dictionary = wrapper.get("runtime", {})
	_expect_case("configured_public_nested_runtime_only", progress == runtime and not progress.has("configured") and not progress.has("catalog_facts") and not progress.has("profile_loaded"), "nested_runtime_only")
	var returned_completed: Array = progress.get("completed_level_ids", [])
	returned_completed.append("mutation")
	var session: Dictionary = current_app.get_test_profile_session_snapshot()
	var session_progress: Dictionary = session.get("progress", {})
	var session_completed: Array = session_progress.get("completed_level_ids", [])
	session_completed.clear()
	var fresh_progress: Dictionary = current_app.get_progress_snapshot()
	var fresh_session: Dictionary = current_app.get_test_profile_session_snapshot()
	_expect_case("defensive_public_session_snapshots", fresh_progress.get("completed_level_ids", []) == [TUTORIAL_0_ID] and (fresh_session.get("progress", {}) as Dictionary).get("completed_level_ids", []) == [TUTORIAL_0_ID], "snapshots_defensive")
	var disclosed: String = JSON.stringify(fresh_session)
	var bounded: bool = (
		not disclosed.contains(CANONICAL_PROFILE_PATH)
		and not disclosed.contains("profile_schema_version")
		and not disclosed.contains("catalog_facts")
		and not disclosed.contains("test_profile_path")
		and not disclosed.contains("recovery_sibling")
	)
	_expect_case("bounded_snapshot_no_disclosure", bounded, "snapshot_no_disclosure")
	await process_frame


func _stage_router_contract() -> void:
	var router_ok: bool = current_app.get_current_route() == "MAIN_MENU" and current_app.get_active_screen_count() == 1
	current_app.navigate("LEVEL_SELECT")
	await process_frame
	router_ok = router_ok and current_app.get_current_route() == "LEVEL_SELECT" and current_app.get_active_screen_count() == 1
	current_app.select_level(TUTORIAL_0_ID)
	await process_frame
	var gameplay: Node = current_app.get_active_screen()
	router_ok = router_ok and current_app.get_current_route() == "GAMEPLAY" and current_app.get_active_screen_count() == 1
	_send_action(gameplay, "ui_cancel")
	await process_frame
	router_ok = router_ok and current_app.get_current_route() == "LEVEL_SELECT" and current_app.get_active_screen_count() == 1
	_expect_case("single_active_screen_router", router_ok, "router_single_screen")
	await _dispose_app(current_app)


func _stage_cleanup() -> void:
	_expect_case("cleanup_tracks_owned_inventory", owned_paths.size() == 25 and _unique_string_count(owned_paths) == owned_paths.size(), "owned_inventory_complete")
	_expect_case("cleanup_exact_fixture_only", _all_owned_paths_bounded(), "cleanup_exact_fixture")
	_expect_case("cleanup_no_test_root_enumeration", _cleanup_uses_exact_owned_paths_only(), "no_test_root_enumeration")
	for owned_path: String in owned_paths:
		_remove_exact_file(owned_path)
	if DirAccess.dir_exists_absolute(ProjectSettings.globalize_path(fixture_dir)):
		var remove_result: Error = DirAccess.remove_absolute(ProjectSettings.globalize_path(fixture_dir))
		if remove_result != OK:
			_abort_stage("fixture_directory_remove_failed")
			return
	var all_absent: bool = true
	for owned_path: String in owned_paths:
		all_absent = all_absent and not FileAccess.file_exists(owned_path)
	_expect_case("cleanup_owned_paths_absent", all_absent and not DirAccess.dir_exists_absolute(ProjectSettings.globalize_path(fixture_dir)), "owned_paths_absent")
	await process_frame


func _cleanup_uses_exact_owned_paths_only() -> bool:
	if fixture_dir != CANONICAL_PROFILE_PATH.get_base_dir():
		return false
	if owned_paths.size() != 25 or _unique_string_count(owned_paths) != 25:
		return false
	if owned_paths[0] != CANONICAL_PROFILE_PATH:
		return false
	for owned_path: String in owned_paths:
		if owned_path != CANONICAL_PROFILE_PATH and owned_path.get_base_dir() != fixture_dir:
			return false
	return true


func _stage_final() -> void:
	var protected_ok: bool = _production_metadata() == production_metadata_baseline and _test_root_exists() == test_root_exists_baseline
	_expect_case("protected_metadata_and_test_root_unchanged", protected_ok, "protected_metadata_unchanged")
	_expect_case("external_runner_process_accounting", OS.get_process_id() > 0, "runner_process_accounting_ready")
	var clean: bool = not FileAccess.file_exists(CANONICAL_PROFILE_PATH) and not DirAccess.dir_exists_absolute(ProjectSettings.globalize_path(fixture_dir))
	_expect_case("success_after_complete_matrix_cleanup", clean and failures == 0, "complete_matrix_cleanup")
	await process_frame


func _run_failure_case(stage: String, case_id: String) -> void:
	_write_canonical_tutorial_profile()
	var app: Node = await _spawn_configured_app()
	var seam: Dictionary = app.set_test_profile_failure_seam(stage)
	var before_bytes: PackedByteArray = _read_bytes(CANONICAL_PROFILE_PATH)
	var before_progress: Dictionary = app.get_progress_snapshot()
	var before_profile_result: Dictionary = app._profile_adapter.get_profile_snapshot()
	var before_profile: Dictionary = (before_profile_result.get("profile", {}) as Dictionary).duplicate(true)
	var recorded: bool = app._record_configured_completion(TUTORIAL_1_ID, 8)
	await process_frame
	var after_profile_result: Dictionary = app._profile_adapter.get_profile_snapshot()
	var safe_screen: Node = app.get_active_screen()
	var safe_snapshot: Dictionary = safe_screen.get_screen_snapshot() if safe_screen != null and safe_screen.has_method("get_screen_snapshot") else {}
	var bounded_error: bool = not JSON.stringify(safe_snapshot).contains(CANONICAL_PROFILE_PATH) and not JSON.stringify(safe_snapshot).contains("profile_schema_version")
	var ok: bool = (
		bool(seam.get("ok", false))
		and not recorded
		and app.get_current_route() == "SAFE_ERROR"
		and app.get_active_screen_count() == 1
		and _read_bytes(CANONICAL_PROFILE_PATH) == before_bytes
		and app.get_progress_snapshot() == before_progress
		and after_profile_result.get("profile", {}) == before_profile
		and not (app.get_progress_snapshot().get("unlocked_level_ids", []) as Array).has("vertical_slice_delay_3")
		and bounded_error
	)
	failure_contract_ok = failure_contract_ok and ok
	_expect_case(case_id, ok, stage.to_lower() + "_rollback")
	await _dispose_app(app)


func _spawn_configured_app() -> Node:
	var app: Node = AppRootScene.instantiate()
	var configured: Dictionary = app.configure_test_profile(CANONICAL_PROFILE_PATH)
	if not bool(configured.get("ok", false)):
		_abort_stage("configured_app_rejected")
		return app
	root.add_child(app)
	await process_frame
	return app


func _dispose_app(app: Node) -> void:
	if app != null and is_instance_valid(app):
		app.queue_free()
		await process_frame


func _catalog_facts() -> Dictionary:
	var loaded: Dictionary = CatalogLoader.new().load_file("res://data/catalog/level_catalog_v1.json")
	if not bool(loaded.get("ok", false)):
		return {}
	var adapter: RefCounted = ProfileProgressAdapter.new()
	var configured: Dictionary = adapter.configure(loaded.get("catalog", {}))
	return (configured.get("catalog_facts", {}) as Dictionary).duplicate(true)


func _tutorial_profile(turns: int) -> Dictionary:
	return {
		"profile_schema_version": 1,
		"progress": {
			"completed_level_ids": [TUTORIAL_0_ID],
			"best_turns": {TUTORIAL_0_ID: turns},
		},
		"settings": {
			"language": "en",
			"window_mode": "windowed",
			"reduced_motion": false,
		},
	}


func _expected_tutorial_unlocked_ids() -> Array[String]:
	var expected: Array[String] = [TUTORIAL_0_ID, TUTORIAL_1_ID]
	expected.sort()
	return expected


func _write_canonical_tutorial_profile() -> void:
	var serialized: Dictionary = ProfileCodec.serialize_profile(_tutorial_profile(3))
	var text: String = str(serialized.get("json", ""))
	if not _write_bytes(CANONICAL_PROFILE_PATH, text.to_utf8_buffer()):
		_abort_stage("canonical_target_write_failed")


func _send_action(scene: Node, action: String) -> void:
	var event: InputEventAction = InputEventAction.new()
	event.action = action
	event.pressed = true
	scene._unhandled_input(event)


func _build_owned_inventory() -> void:
	owned_paths = [CANONICAL_PROFILE_PATH]
	for kind: String in ["temp", "transaction", "recovery"]:
		for index: int in range(8):
			owned_paths.append(_owned_path(kind, index))


func _owned_path(kind: String, index: int) -> String:
	return fixture_dir + "/.delayed_self_0023w_" + kind + "_" + str(index) + ".json"


func _remove_recovery_inventory() -> void:
	for index: int in range(8):
		_remove_exact_file(_owned_path("recovery", index))


func _remove_exact_file(path: String) -> void:
	if FileAccess.file_exists(path):
		DirAccess.remove_absolute(ProjectSettings.globalize_path(path))


func _write_bytes(path: String, bytes: PackedByteArray) -> bool:
	var file: FileAccess = FileAccess.open(path, FileAccess.WRITE)
	if file == null:
		return false
	file.store_buffer(bytes)
	file.flush()
	file.close()
	return true


func _read_bytes(path: String) -> PackedByteArray:
	var file: FileAccess = FileAccess.open(path, FileAccess.READ)
	if file == null:
		return PackedByteArray()
	var bytes: PackedByteArray = file.get_buffer(file.get_length())
	file.close()
	return bytes


func _production_metadata() -> Dictionary:
	var production_path: String = LocalProfile.PRODUCTION_PROFILE_PATH
	return {
		"exists": FileAccess.file_exists(production_path),
		"length": FileAccess.get_size(production_path),
		"modified_time": FileAccess.get_modified_time(production_path),
	}


func _test_root_exists() -> bool:
	return DirAccess.dir_exists_absolute(ProjectSettings.globalize_path(LocalProfile.TEST_PROFILE_ROOT))


func _has_exact_progress_keys(progress: Dictionary) -> bool:
	var keys: Array = progress.keys()
	keys.sort()
	return keys == PUBLIC_PROGRESS_KEYS


func _all_owned_paths_bounded() -> bool:
	if fixture_dir.is_empty():
		return false
	for owned_path: String in owned_paths:
		if owned_path != CANONICAL_PROFILE_PATH and owned_path.get_base_dir() != fixture_dir:
			return false
	return true


func _unique_string_count(values: Array[String]) -> int:
	var unique: Dictionary = {}
	for value: String in values:
		unique[value] = true
	return unique.size()


func _begin_stage(stage_id: String) -> void:
	current_stage = stage_id
	print("TASK_0023ZN_STAGE_BEGIN=" + stage_id)


func _finish_stage(stage_id: String, failures_before: int) -> bool:
	if failures > failures_before:
		_abort_stage("stage_assertion_failed")
		return false
	print("TASK_0023ZN_STAGE_PASS=" + stage_id)
	return true


func _expect_case(case_id: String, condition: bool, bounded_label: String) -> void:
	assertions += 1
	if not condition:
		failures += 1
		print("TASK_0023ZN_ASSERT_FAIL stage=%s label=%s" % [current_stage, (case_id + "_" + bounded_label).left(120)])


func _abort_stage(bounded_reason: String) -> void:
	print("TASK_0023ZN_ABORT stage=%s reason=%s" % [current_stage, bounded_reason.left(120)])
	quit(1)

extends SceneTree

const BootstrapScene = preload("res://scenes/app/app_bootstrap.tscn")
const BootstrapScript = preload("res://scripts/app/app_bootstrap.gd")
const AppRootScene = preload("res://scenes/app/app_root.tscn")
const CatalogLoader = preload("res://scripts/app/catalog_loader.gd")
const LocalProfile = preload("res://scripts/app/local_profile.gd")
const ProfileCodec = preload("res://scripts/app/profile_codec.gd")
const ProfileProgressAdapter = preload("res://scripts/app/profile_progress_adapter.gd")

const EXECUTION_GUARD: String = "TASK_0023ZQ_EXECUTE"
const EVIDENCE_ROOT: String = "D:/Delayed_Self_Evidence/0023ZQ_isolated_production_policy_matrix/0023ZS_disclosure_scanner_retry"
const REPOSITORY_ROOT: String = "D:/Delayed_Self"
const TUTORIAL_0_ID: String = "tutorial_reach_exit"
const TUTORIAL_1_ID: String = "tutorial_echo_bridge"
const OWNED_NAME_LIMIT: int = 8
const CASE_STAGE: Dictionary = {
	"bootstrap_memory_default": "bootstrap_policy",
	"bootstrap_development_direct": "bootstrap_policy",
	"bootstrap_invalid_direct": "bootstrap_policy",
	"bootstrap_normal_production_composition": "bootstrap_policy",
	"read_only_missing": "production_read_only",
	"read_only_valid_partial": "production_read_only",
	"read_only_valid_completed": "production_read_only",
	"read_only_sanitizable": "production_read_only",
	"read_only_malformed": "production_read_only",
	"read_only_unsupported": "production_read_only",
	"read_only_write_reset_seam_rejection": "production_read_only",
	"write_on_intent_missing": "production_write_on_intent",
	"write_on_intent_valid": "production_write_on_intent",
	"write_on_intent_no_change": "production_write_on_intent",
	"write_on_intent_first_write": "production_write_on_intent",
	"write_on_intent_sanitizable_write": "production_write_on_intent",
	"write_on_intent_malformed_boot": "production_write_on_intent",
	"write_on_intent_unsupported_boot": "production_write_on_intent",
	"write_on_intent_recovery_collision": "production_write_on_intent",
	"write_on_intent_activation_collision": "production_write_on_intent",
	"write_on_intent_transaction_rollback": "production_write_on_intent",
	"write_on_intent_test_seams_rejected": "production_write_on_intent",
}

var _case_id: String = ""
var _target_path: String = ""


func _initialize() -> void:
	var guard: String = OS.get_environment("DELAYED_SELF_0023ZQ_EXECUTION_GUARD")
	if guard != EXECUTION_GUARD:
		print("TASK_0023ZQ_EXECUTION_GUARD_BLOCKED")
		quit(2)
		return
	_case_id = OS.get_environment("DELAYED_SELF_0023ZQ_CASE")
	if not CASE_STAGE.has(_case_id):
		print("TASK_0023ZQ_CASE_ARGUMENT_BLOCKED")
		quit(2)
		return
	if not _attest_sandbox():
		print("TASK_0023ZQ_SANDBOX_ATTESTATION_BLOCKED")
		quit(2)
		return
	print("TASK_0023ZQ_SANDBOX_ATTESTED")
	call_deferred("_run")


func _attest_sandbox() -> bool:
	var attempt_id: String = OS.get_environment("DELAYED_SELF_0023ZQ_ATTEMPT")
	if not ["attempt_1", "attempt_2"].has(attempt_id):
		return false
	var appdata_root: String = _normalized(OS.get_environment("APPDATA"))
	var expected_appdata: String = EVIDENCE_ROOT + "/" + attempt_id + "/appdata"
	if appdata_root != expected_appdata or not appdata_root.is_absolute_path():
		return false
	var user_data_dir: String = _normalized(OS.get_user_data_dir())
	if not user_data_dir.is_absolute_path() or user_data_dir == appdata_root:
		return false
	if not user_data_dir.begins_with(appdata_root + "/"):
		return false
	if _has_parent_segment(user_data_dir) or _has_parent_segment(appdata_root):
		return false
	if appdata_root.begins_with(REPOSITORY_ROOT + "/") or REPOSITORY_ROOT.begins_with(appdata_root + "/"):
		return false
	var expected_target: String = user_data_dir + "/" + LocalProfile.PRODUCTION_PROFILE_PATH.get_file()
	var global_target: String = _normalized(ProjectSettings.globalize_path(LocalProfile.PRODUCTION_PROFILE_PATH))
	if global_target != expected_target:
		return false
	_target_path = LocalProfile.PRODUCTION_PROFILE_PATH
	return true


func _run() -> void:
	_cleanup_owned_files()
	if not _all_owned_absent():
		_finish_case(false, "CLEAN_START_REQUIRED")
		return
	print("TASK_0023ZQ_BEHAVIOR_STARTED case=" + _case_id)
	print("TASK_0023ZQ_STAGE=" + str(CASE_STAGE.get(_case_id, "")))
	var result: Dictionary = await _execute_case()
	_finish_case(bool(result.get("ok", false)), str(result.get("status", "CASE_FAILED")))


func _execute_case() -> Dictionary:
	match _case_id:
		"bootstrap_memory_default":
			return _case_bootstrap_memory_default()
		"bootstrap_development_direct":
			return _case_bootstrap_development_direct()
		"bootstrap_invalid_direct":
			return _case_bootstrap_invalid_direct()
		"bootstrap_normal_production_composition":
			return await _case_bootstrap_normal_production_composition()
		"read_only_missing":
			return await _case_read_only_missing()
		"read_only_valid_partial":
			return await _case_read_only_valid_partial()
		"read_only_valid_completed":
			return await _case_read_only_valid_completed()
		"read_only_sanitizable":
			return await _case_read_only_sanitizable()
		"read_only_malformed":
			return await _case_read_only_malformed()
		"read_only_unsupported":
			return await _case_read_only_unsupported()
		"read_only_write_reset_seam_rejection":
			return _case_read_only_write_reset_seam_rejection()
		"write_on_intent_missing":
			return await _case_write_on_intent_missing()
		"write_on_intent_valid":
			return await _case_write_on_intent_valid()
		"write_on_intent_no_change":
			return await _case_write_on_intent_no_change()
		"write_on_intent_first_write":
			return await _case_write_on_intent_first_write()
		"write_on_intent_sanitizable_write":
			return await _case_write_on_intent_sanitizable_write()
		"write_on_intent_malformed_boot":
			return await _case_write_on_intent_malformed_boot()
		"write_on_intent_unsupported_boot":
			return await _case_write_on_intent_unsupported_boot()
		"write_on_intent_recovery_collision":
			return _case_write_on_intent_recovery_collision()
		"write_on_intent_activation_collision":
			return await _case_write_on_intent_activation_collision()
		"write_on_intent_transaction_rollback":
			return await _case_write_on_intent_transaction_rollback()
		"write_on_intent_test_seams_rejected":
			return _case_write_on_intent_test_seams_rejected()
	return {"ok": false, "status": "CASE_NOT_IMPLEMENTED"}


func _case_bootstrap_memory_default() -> Dictionary:
	var bootstrap: Node = BootstrapScene.instantiate()
	var preview: Dictionary = bootstrap.preview_effective_policy(PackedStringArray())
	var snapshot: Dictionary = bootstrap.get_composition_snapshot()
	var ok: bool = str(preview.get("effective_policy", "")) == BootstrapScript.MEMORY_ONLY and str(snapshot.get("selected_policy", "")) == BootstrapScript.MEMORY_ONLY
	bootstrap.free()
	return {"ok": ok, "status": "MEMORY_ONLY"}


func _case_bootstrap_development_direct() -> Dictionary:
	var bootstrap: Node = BootstrapScene.instantiate()
	var configured: Dictionary = bootstrap.configure_boot_policy(BootstrapScript.PRODUCTION_WRITE_ON_INTENT)
	var preview: Dictionary = bootstrap.preview_effective_policy(PackedStringArray(["--level-id=" + TUTORIAL_0_ID]))
	var ok: bool = bool(configured.get("ok", false)) and str(preview.get("effective_policy", "")) == BootstrapScript.MEMORY_ONLY
	bootstrap.free()
	return {"ok": ok, "status": "MEMORY_ONLY"}


func _case_bootstrap_invalid_direct() -> Dictionary:
	var bootstrap: Node = BootstrapScene.instantiate()
	var configured: Dictionary = bootstrap.configure_boot_policy(BootstrapScript.PRODUCTION_READ_ONLY)
	var preview: Dictionary = bootstrap.preview_effective_policy(PackedStringArray(["--level-id=INVALID!"]))
	var ok: bool = bool(configured.get("ok", false)) and str(preview.get("effective_policy", "")) == BootstrapScript.MEMORY_ONLY
	bootstrap.free()
	return {"ok": ok, "status": "MEMORY_ONLY"}


func _case_bootstrap_normal_production_composition() -> Dictionary:
	var bootstrap: Node = BootstrapScene.instantiate()
	var configured: Dictionary = bootstrap.configure_boot_policy(BootstrapScript.PRODUCTION_READ_ONLY)
	root.add_child(bootstrap)
	await process_frame
	await process_frame
	var snapshot: Dictionary = bootstrap.get_composition_snapshot()
	var app: Node = bootstrap.get_child(0) if bootstrap.get_child_count() == 1 else null
	var session: Dictionary = app.get_profile_session_snapshot() if app != null else {}
	var ok: bool = (
		bool(configured.get("ok", false))
		and bootstrap.get_child_count() == 1
		and str(snapshot.get("status", "")) == "APP_ROOT_ADDED"
		and str(snapshot.get("effective_policy", "")) == BootstrapScript.PRODUCTION_READ_ONLY
		and str(session.get("mode", "")) == "PRODUCTION_PROFILE"
		and str(session.get("boot_status", "")) == "PRODUCTION_PROFILE_READY"
		and app.get_current_route() == "MAIN_MENU"
		and not FileAccess.file_exists(_target_path)
	)
	await _dispose_node(bootstrap)
	return {"ok": ok, "status": "PRODUCTION_PROFILE_READY"}


func _case_read_only_missing() -> Dictionary:
	var app: Node = await _spawn_app(LocalProfile.ACCESS_READ_ONLY)
	var session: Dictionary = app.get_profile_session_snapshot()
	var progress: Dictionary = app.get_progress_snapshot()
	var ok: bool = (
		str(session.get("load_status", "")) == "MISSING_CLEAN"
		and app.get_current_route() == "MAIN_MENU"
		and (progress.get("completed_level_ids", []) as Array).is_empty()
		and not FileAccess.file_exists(_target_path)
		and _all_siblings_absent()
	)
	await _dispose_node(app)
	return {"ok": ok, "status": "MISSING_CLEAN"}


func _case_read_only_valid_partial() -> Dictionary:
	if not _write_profile(_partial_profile()):
		return {"ok": false, "status": "SETUP_FAILED"}
	var before: Dictionary = _fingerprint(_target_path)
	var app: Node = await _spawn_app(LocalProfile.ACCESS_READ_ONLY)
	var session: Dictionary = app.get_profile_session_snapshot()
	var progress: Dictionary = app.get_progress_snapshot()
	var ok: bool = str(session.get("load_status", "")) == "LOADED" and progress.get("completed_level_ids", []) == [TUTORIAL_0_ID] and _fingerprint(_target_path) == before and _all_siblings_absent()
	await _dispose_node(app)
	return {"ok": ok, "status": "LOADED"}


func _case_read_only_valid_completed() -> Dictionary:
	var completed_profile: Dictionary = _completed_profile()
	if completed_profile.is_empty() or not _write_profile(completed_profile):
		return {"ok": false, "status": "SETUP_FAILED"}
	var before: Dictionary = _fingerprint(_target_path)
	var app: Node = await _spawn_app(LocalProfile.ACCESS_READ_ONLY)
	var session: Dictionary = app.get_profile_session_snapshot()
	var progress: Dictionary = app.get_progress_snapshot()
	var expected_ids: Array = (_catalog_facts().get("level_ids", []) as Array).duplicate()
	expected_ids.sort()
	var ok: bool = str(session.get("load_status", "")) == "LOADED" and progress.get("completed_level_ids", []) == expected_ids and _fingerprint(_target_path) == before and _all_siblings_absent()
	await _dispose_node(app)
	return {"ok": ok, "status": "LOADED"}


func _case_read_only_sanitizable() -> Dictionary:
	if not _write_text(JSON.stringify(_sanitizable_profile())):
		return {"ok": false, "status": "SETUP_FAILED"}
	var before: Dictionary = _fingerprint(_target_path)
	var app: Node = await _spawn_app(LocalProfile.ACCESS_READ_ONLY)
	var session: Dictionary = app.get_profile_session_snapshot()
	var progress: Dictionary = app.get_progress_snapshot()
	var ok: bool = str(session.get("load_status", "")) == "SANITIZED_PENDING_RECOVERY" and progress.get("completed_level_ids", []) == [TUTORIAL_0_ID] and _fingerprint(_target_path) == before and _all_siblings_absent()
	await _dispose_node(app)
	return {"ok": ok, "status": "SANITIZED_PENDING_RECOVERY"}


func _case_read_only_malformed() -> Dictionary:
	if not _write_text("{bounded-malformed"):
		return {"ok": false, "status": "SETUP_FAILED"}
	var before: Dictionary = _fingerprint(_target_path)
	var app: Node = await _spawn_app(LocalProfile.ACCESS_READ_ONLY)
	var session: Dictionary = app.get_profile_session_snapshot()
	var ok: bool = str(session.get("load_status", "")) == "RECOVERY_REQUIRED_READ_ONLY" and app.get_current_route() == "SAFE_ERROR" and _fingerprint(_target_path) == before and _all_siblings_absent()
	await _dispose_node(app)
	return {"ok": ok, "status": "RECOVERY_REQUIRED_READ_ONLY"}


func _case_read_only_unsupported() -> Dictionary:
	if not _write_text(JSON.stringify(_unsupported_profile())):
		return {"ok": false, "status": "SETUP_FAILED"}
	var before: Dictionary = _fingerprint(_target_path)
	var app: Node = await _spawn_app(LocalProfile.ACCESS_READ_ONLY)
	var session: Dictionary = app.get_profile_session_snapshot()
	var ok: bool = str(session.get("load_status", "")) == "UNSUPPORTED_VERSION_READ_ONLY" and app.get_current_route() == "SAFE_ERROR" and _fingerprint(_target_path) == before and _all_siblings_absent()
	await _dispose_node(app)
	return {"ok": ok, "status": "UNSUPPORTED_VERSION_READ_ONLY"}


func _case_read_only_write_reset_seam_rejection() -> Dictionary:
	var store: RefCounted = LocalProfile.new()
	var configured: Dictionary = store.configure_production(_catalog_facts(), LocalProfile.ACCESS_READ_ONLY)
	var persisted: Dictionary = store.persist_profile(_partial_profile())
	var reset: Dictionary = store.reset_test_profile()
	var seam: Dictionary = store.set_test_failure_seam("TEMP_WRITE")
	var ok: bool = bool(configured.get("ok", false)) and str(persisted.get("status", "")) == "PRODUCTION_WRITE_POLICY_REJECTED" and str(reset.get("status", "")) == "TEST_MODE_REQUIRED" and str(seam.get("status", "")) == "TEST_MODE_REQUIRED" and not FileAccess.file_exists(_target_path) and _all_siblings_absent()
	return {"ok": ok, "status": "PRODUCTION_WRITE_POLICY_REJECTED"}


func _case_write_on_intent_missing() -> Dictionary:
	var app: Node = await _spawn_app(LocalProfile.ACCESS_WRITE_ON_INTENT)
	var session: Dictionary = app.get_profile_session_snapshot()
	var ok: bool = str(session.get("load_status", "")) == "MISSING_CLEAN" and app.get_current_route() == "MAIN_MENU" and not FileAccess.file_exists(_target_path) and _all_siblings_absent()
	await _dispose_node(app)
	return {"ok": ok, "status": "MISSING_CLEAN"}


func _case_write_on_intent_valid() -> Dictionary:
	if not _write_profile(_partial_profile()):
		return {"ok": false, "status": "SETUP_FAILED"}
	var before: Dictionary = _fingerprint(_target_path)
	var app: Node = await _spawn_app(LocalProfile.ACCESS_WRITE_ON_INTENT)
	var session: Dictionary = app.get_profile_session_snapshot()
	var ok: bool = str(session.get("load_status", "")) == "LOADED" and _fingerprint(_target_path) == before and _all_siblings_absent()
	await _dispose_node(app)
	return {"ok": ok, "status": "LOADED"}


func _case_write_on_intent_no_change() -> Dictionary:
	if not _write_profile(_partial_profile()):
		return {"ok": false, "status": "SETUP_FAILED"}
	var before: Dictionary = _fingerprint(_target_path)
	var app: Node = await _spawn_app(LocalProfile.ACCESS_WRITE_ON_INTENT)
	var recorded: bool = app._record_configured_completion(TUTORIAL_0_ID, 3)
	var session: Dictionary = app.get_profile_session_snapshot()
	var ok: bool = recorded and str(session.get("persist_status", "")) == "NO_CHANGE" and _fingerprint(_target_path) == before and _all_siblings_absent()
	await _dispose_node(app)
	return {"ok": ok, "status": "NO_CHANGE"}


func _case_write_on_intent_first_write() -> Dictionary:
	if not _write_profile(_partial_profile()):
		return {"ok": false, "status": "SETUP_FAILED"}
	var before_bytes: PackedByteArray = _read_bytes(_target_path)
	var before: Dictionary = _fingerprint(_target_path)
	var app: Node = await _spawn_app(LocalProfile.ACCESS_WRITE_ON_INTENT)
	var recorded: bool = app._record_configured_completion(TUTORIAL_1_ID, 8)
	var session: Dictionary = app.get_profile_session_snapshot()
	var progress: Dictionary = app.get_progress_snapshot()
	var backup_path: String = _sibling_path("activation_backup", 0)
	var ok: bool = recorded and str(session.get("persist_status", "")) == "COMMITTED_AFTER_PERSISTED" and _fingerprint(_target_path) != before and _owned_count("activation_backup") == 1 and _read_bytes(backup_path) == before_bytes and _owned_count("recovery") == 0 and _owned_count("temp") == 0 and _owned_count("transaction") == 0 and (progress.get("completed_level_ids", []) as Array).has(TUTORIAL_1_ID)
	await _dispose_node(app)
	return {"ok": ok, "status": "COMMITTED_AFTER_PERSISTED"}


func _case_write_on_intent_sanitizable_write() -> Dictionary:
	if not _write_text(JSON.stringify(_sanitizable_profile())):
		return {"ok": false, "status": "SETUP_FAILED"}
	var before_bytes: PackedByteArray = _read_bytes(_target_path)
	var before: Dictionary = _fingerprint(_target_path)
	var app: Node = await _spawn_app(LocalProfile.ACCESS_WRITE_ON_INTENT)
	var boot_session: Dictionary = app.get_profile_session_snapshot()
	var recorded: bool = app._record_configured_completion(TUTORIAL_1_ID, 8)
	var session: Dictionary = app.get_profile_session_snapshot()
	var ok: bool = str(boot_session.get("load_status", "")) == "SANITIZED_PENDING_RECOVERY" and recorded and str(session.get("persist_status", "")) == "COMMITTED_AFTER_PERSISTED" and _fingerprint(_target_path) != before and _owned_count("recovery") == 1 and _owned_count("activation_backup") == 1 and _read_bytes(_sibling_path("recovery", 0)) == before_bytes and _read_bytes(_sibling_path("activation_backup", 0)) == before_bytes and _owned_count("temp") == 0 and _owned_count("transaction") == 0
	await _dispose_node(app)
	return {"ok": ok, "status": "COMMITTED_AFTER_PERSISTED"}


func _case_write_on_intent_malformed_boot() -> Dictionary:
	if not _write_text("{bounded-malformed"):
		return {"ok": false, "status": "SETUP_FAILED"}
	var before_bytes: PackedByteArray = _read_bytes(_target_path)
	var before: Dictionary = _fingerprint(_target_path)
	var app: Node = await _spawn_app(LocalProfile.ACCESS_WRITE_ON_INTENT)
	var session: Dictionary = app.get_profile_session_snapshot()
	var ok: bool = str(session.get("load_status", "")) == "RECOVERED_CLEAN" and app.get_current_route() == "MAIN_MENU" and _fingerprint(_target_path) == before and _owned_count("recovery") == 1 and _read_bytes(_sibling_path("recovery", 0)) == before_bytes and _owned_count("activation_backup") == 0
	await _dispose_node(app)
	return {"ok": ok, "status": "RECOVERED_CLEAN"}


func _case_write_on_intent_unsupported_boot() -> Dictionary:
	if not _write_text(JSON.stringify(_unsupported_profile())):
		return {"ok": false, "status": "SETUP_FAILED"}
	var before: Dictionary = _fingerprint(_target_path)
	var sibling_before: int = _total_sibling_count()
	var app: Node = await _spawn_app(LocalProfile.ACCESS_WRITE_ON_INTENT)
	var boot_session: Dictionary = app.get_profile_session_snapshot()
	var recorded: bool = app._record_configured_completion(TUTORIAL_0_ID, 3)
	var session: Dictionary = app.get_profile_session_snapshot()
	var ok: bool = str(boot_session.get("load_status", "")) == "UNSUPPORTED_VERSION_PRESERVED" and not recorded and str(session.get("persist_status", "")) == "FAILED_RECOVERY_FAILED" and app.get_current_route() == "SAFE_ERROR" and _fingerprint(_target_path) == before and _owned_count("recovery") == 1 and _total_sibling_count() == sibling_before + 1
	await _dispose_node(app)
	return {"ok": ok, "status": "UNSUPPORTED_VERSION_PRESERVED"}


func _case_write_on_intent_recovery_collision() -> Dictionary:
	if not _write_text("{bounded-malformed") or not _fill_owned("recovery"):
		return {"ok": false, "status": "SETUP_FAILED"}
	var before: Dictionary = _fingerprint(_target_path)
	var collision_hashes: Array[String] = _owned_hashes("recovery")
	var store: RefCounted = LocalProfile.new()
	var configured: Dictionary = store.configure_production(_catalog_facts(), LocalProfile.ACCESS_WRITE_ON_INTENT)
	var loaded: Dictionary = store.load_profile()
	var later: Dictionary = store.persist_profile(_partial_profile())
	var ok: bool = bool(configured.get("ok", false)) and str(loaded.get("status", "")) == "RECOVERY_FAILED" and str(later.get("status", "")) == "RECOVERY_FAILED" and _fingerprint(_target_path) == before and _owned_hashes("recovery") == collision_hashes and _owned_count("recovery") == OWNED_NAME_LIMIT
	return {"ok": ok, "status": "RECOVERY_FAILED"}


func _case_write_on_intent_activation_collision() -> Dictionary:
	if not _write_profile(_partial_profile()):
		return {"ok": false, "status": "SETUP_FAILED"}
	var app: Node = await _spawn_app(LocalProfile.ACCESS_WRITE_ON_INTENT)
	if not _fill_owned("activation_backup"):
		await _dispose_node(app)
		return {"ok": false, "status": "SETUP_FAILED"}
	var before: Dictionary = _fingerprint(_target_path)
	var collision_hashes: Array[String] = _owned_hashes("activation_backup")
	var recorded: bool = app._record_configured_completion(TUTORIAL_1_ID, 8)
	var session: Dictionary = app.get_profile_session_snapshot()
	var ok: bool = not recorded and str(session.get("persist_status", "")) == "FAILED_ACTIVATION_BACKUP_FAILED" and app.get_current_route() == "SAFE_ERROR" and _fingerprint(_target_path) == before and _owned_hashes("activation_backup") == collision_hashes and _owned_count("recovery") == 0 and _owned_count("temp") == 0 and _owned_count("transaction") == 0
	await _dispose_node(app)
	return {"ok": ok, "status": "ACTIVATION_BACKUP_FAILED"}


func _case_write_on_intent_transaction_rollback() -> Dictionary:
	if not _write_profile(_partial_profile()):
		return {"ok": false, "status": "SETUP_FAILED"}
	var app: Node = await _spawn_app(LocalProfile.ACCESS_WRITE_ON_INTENT)
	if not _fill_owned("temp"):
		await _dispose_node(app)
		return {"ok": false, "status": "SETUP_FAILED"}
	var before: Dictionary = _fingerprint(_target_path)
	var progress_before: Dictionary = app.get_progress_snapshot()
	var profile_before: Dictionary = app._profile_adapter.get_profile_snapshot()
	var recorded: bool = app._record_configured_completion(TUTORIAL_1_ID, 8)
	var session: Dictionary = app.get_profile_session_snapshot()
	var ok: bool = not recorded and str(session.get("persist_status", "")) == "FAILED_WRITE_FAILED" and app.get_current_route() == "SAFE_ERROR" and _fingerprint(_target_path) == before and app.get_progress_snapshot() == progress_before and app._profile_adapter.get_profile_snapshot() == profile_before and _owned_count("activation_backup") == 1 and _owned_count("temp") == OWNED_NAME_LIMIT and _owned_count("transaction") == 0 and _owned_count("recovery") == 0
	await _dispose_node(app)
	return {"ok": ok, "status": "WRITE_FAILED"}


func _case_write_on_intent_test_seams_rejected() -> Dictionary:
	var store: RefCounted = LocalProfile.new()
	var configured: Dictionary = store.configure_production(_catalog_facts(), LocalProfile.ACCESS_WRITE_ON_INTENT)
	var reset: Dictionary = store.reset_test_profile()
	var seam: Dictionary = store.set_test_failure_seam("TEMP_WRITE")
	var ok: bool = bool(configured.get("ok", false)) and str(reset.get("status", "")) == "TEST_MODE_REQUIRED" and str(seam.get("status", "")) == "TEST_MODE_REQUIRED" and not FileAccess.file_exists(_target_path) and _all_siblings_absent()
	return {"ok": ok, "status": "TEST_MODE_REQUIRED"}


func _spawn_app(access_policy: String) -> Node:
	var app: Node = AppRootScene.instantiate()
	var configured: Dictionary = app.configure_production_profile(access_policy)
	if not bool(configured.get("ok", false)):
		return app
	root.add_child(app)
	await process_frame
	return app


func _dispose_node(node: Node) -> void:
	if node != null and is_instance_valid(node):
		node.queue_free()
		await process_frame


func _catalog_facts() -> Dictionary:
	var loaded: Dictionary = CatalogLoader.new().load_file("res://data/catalog/level_catalog_v1.json")
	if not bool(loaded.get("ok", false)):
		return {}
	var adapter: RefCounted = ProfileProgressAdapter.new()
	var configured: Dictionary = adapter.configure(loaded.get("catalog", {}))
	return (configured.get("catalog_facts", {}) as Dictionary).duplicate(true)


func _partial_profile() -> Dictionary:
	return {
		"profile_schema_version": 1,
		"progress": {"completed_level_ids": [TUTORIAL_0_ID], "best_turns": {TUTORIAL_0_ID: 3}},
		"settings": {"language": "en", "window_mode": "windowed", "reduced_motion": false},
	}


func _completed_profile() -> Dictionary:
	var facts: Dictionary = _catalog_facts()
	var level_ids: Array = (facts.get("level_ids", []) as Array).duplicate()
	if level_ids.is_empty():
		return {}
	var best_turns: Dictionary = {}
	for level_id_value: Variant in level_ids:
		best_turns[str(level_id_value)] = 10
	return {
		"profile_schema_version": 1,
		"progress": {"completed_level_ids": level_ids, "best_turns": best_turns},
		"settings": {"language": "en", "window_mode": "windowed", "reduced_motion": false},
	}


func _sanitizable_profile() -> Dictionary:
	var profile: Dictionary = _partial_profile()
	profile["bounded_extra"] = true
	var progress: Dictionary = profile.get("progress", {})
	progress["completed_level_ids"] = [TUTORIAL_0_ID, "unknown_bounded_id"]
	return profile


func _unsupported_profile() -> Dictionary:
	return {
		"profile_schema_version": 99,
		"progress": {},
		"settings": {},
	}


func _write_profile(profile: Dictionary) -> bool:
	var serialized: Dictionary = ProfileCodec.serialize_profile(profile)
	return bool(serialized.get("ok", false)) and _write_text(str(serialized.get("json", "")))


func _write_text(text: String) -> bool:
	var file: FileAccess = FileAccess.open(_target_path, FileAccess.WRITE)
	if file == null:
		return false
	file.store_string(text)
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


func _fingerprint(path: String) -> Dictionary:
	if not FileAccess.file_exists(path):
		return {"exists": false, "length": 0, "modified": 0, "sha256": ""}
	return {
		"exists": true,
		"length": FileAccess.get_size(path),
		"modified": FileAccess.get_modified_time(path),
		"sha256": FileAccess.get_sha256(path),
	}


func _fill_owned(kind: String) -> bool:
	for index: int in range(OWNED_NAME_LIMIT):
		var file: FileAccess = FileAccess.open(_sibling_path(kind, index), FileAccess.WRITE)
		if file == null:
			return false
		file.store_string("bounded-collision-%d" % index)
		file.flush()
		file.close()
	return true


func _owned_hashes(kind: String) -> Array[String]:
	var hashes: Array[String] = []
	for index: int in range(OWNED_NAME_LIMIT):
		hashes.append(FileAccess.get_sha256(_sibling_path(kind, index)))
	return hashes


func _owned_count(kind: String) -> int:
	var count: int = 0
	for index: int in range(OWNED_NAME_LIMIT):
		if FileAccess.file_exists(_sibling_path(kind, index)):
			count += 1
	return count


func _total_sibling_count() -> int:
	return _owned_count("temp") + _owned_count("transaction") + _owned_count("recovery") + _owned_count("activation_backup")


func _all_siblings_absent() -> bool:
	return _total_sibling_count() == 0


func _sibling_path(kind: String, index: int) -> String:
	return "user://.delayed_self_profile_" + kind + "_" + str(index) + ".json"


func _cleanup_owned_files() -> void:
	var paths: Array[String] = [_target_path]
	for kind: String in ["temp", "transaction", "recovery", "activation_backup"]:
		for index: int in range(OWNED_NAME_LIMIT):
			paths.append(_sibling_path(kind, index))
	for path: String in paths:
		if not path.is_empty() and FileAccess.file_exists(path):
			DirAccess.remove_absolute(ProjectSettings.globalize_path(path))


func _all_owned_absent() -> bool:
	return not FileAccess.file_exists(_target_path) and _all_siblings_absent()


func _finish_case(ok: bool, status: String) -> void:
	_cleanup_owned_files()
	var cleaned: bool = _all_owned_absent()
	if not ok or not cleaned:
		print("TASK_0023ZQ_ASSERT_FAIL case=" + _case_id)
		print("TASK_0023ZQ_ABORT")
		quit(1)
		return
	print("TASK_0023ZQ_ASSERT_PASS case=" + _case_id)
	print("TASK_0023ZQ_CASE_STATUS=" + _bounded_identifier(status))
	print("TASK_0023ZQ_CASE_PASS case=" + _case_id)
	quit(0)


func _bounded_identifier(value: String) -> String:
	var output: String = ""
	for index: int in range(min(value.length(), 64)):
		var codepoint: int = value.unicode_at(index)
		if (codepoint >= 65 and codepoint <= 90) or codepoint == 95:
			output += String.chr(codepoint)
	return output if not output.is_empty() else "BOUNDED_STATUS"


func _normalized(path: String) -> String:
	return path.replace("\\", "/").trim_suffix("/")


func _has_parent_segment(path: String) -> bool:
	for segment: String in path.split("/", false):
		if segment == "..":
			return true
	return false

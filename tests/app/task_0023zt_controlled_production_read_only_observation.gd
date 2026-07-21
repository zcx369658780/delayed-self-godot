extends SceneTree

const AUTH_ENV: String = "DELAYED_SELF_0023ZU_PRODUCTION_READ_AUTHORIZATION"
const AUTH_VALUE: String = "TASK_0023ZU_OWNER_AUTHORIZED_PRODUCTION_READ_ONLY"
const AUTH_ARGUMENT: String = "--task-0023zu-controlled-production-read-only"
const BOOTSTRAP_PATH: String = "res://scripts/app/app_bootstrap.gd"


func _initialize() -> void:
	var environment_authorized: bool = OS.get_environment(AUTH_ENV) == AUTH_VALUE
	var argument_authorized: bool = OS.get_cmdline_user_args() == PackedStringArray([AUTH_ARGUMENT])
	if not environment_authorized or not argument_authorized:
		print("TASK_0023ZU_CONTROLLED_PRODUCTION_READ_ONLY_GUARD_BLOCKED")
		quit(2)
		return
	call_deferred("_run_authorized_observation")


func _run_authorized_observation() -> void:
	var bootstrap_script: Script = load(BOOTSTRAP_PATH)
	if bootstrap_script == null:
		_fail("BOOTSTRAP_LOAD_FAILED")
		return
	var bootstrap: Node = bootstrap_script.new()
	var configured: Dictionary = bootstrap.configure_boot_policy("PRODUCTION_READ_ONLY")
	if not bool(configured.get("ok", false)):
		bootstrap.free()
		_fail("CONFIGURATION_FAILED")
		return
	get_root().add_child(bootstrap)
	print("TASK_0023ZU_OBSERVATION_STARTED")
	for _frame: int in range(3):
		await process_frame
	if bootstrap.get_child_count() != 1:
		_fail("COMPOSITION_CARDINALITY")
		return
	var app_root: Node = bootstrap.get_child(0)
	var composition: Dictionary = bootstrap.get_composition_snapshot()
	var session: Dictionary = app_root.get_profile_session_snapshot()
	var progress: Dictionary = app_root.get_progress_snapshot()
	var load_status: String = _bounded_identifier(str(session.get("load_status", "UNBOUNDED")))
	var boot_status: String = _bounded_identifier(str(session.get("boot_status", "UNBOUNDED")))
	var route: String = _bounded_identifier(str(app_root.get_current_route()))
	var allowed: bool = _allowed_outcome(load_status, boot_status, route)
	allowed = allowed and str(composition.get("effective_policy", "")) == "PRODUCTION_READ_ONLY"
	allowed = allowed and str(session.get("mode", "")) == "PRODUCTION_PROFILE"
	allowed = allowed and bool(session.get("configured", false))
	allowed = allowed and not bool(session.get("write_authorized", true))
	allowed = allowed and progress.keys().size() == 3
	if not allowed:
		_fail("BOUNDED_OUTCOME_REJECTED")
		return
	print("TASK_0023ZU_LOAD_STATUS=" + load_status)
	print("TASK_0023ZU_BOOT_STATUS=" + boot_status)
	print("TASK_0023ZU_ROUTE=" + route)
	print("TASK_0023ZU_COMPLETED_COUNT=%d" % (progress.get("completed_level_ids", []) as Array).size())
	print("TASK_0023ZU_BEST_TURN_COUNT=%d" % (progress.get("best_turns", {}) as Dictionary).size())
	print("TASK_0023ZU_UNLOCKED_COUNT=%d" % (progress.get("unlocked_level_ids", []) as Array).size())
	print("TASK_0023ZU_PUBLIC_PROGRESS_KEY_COUNT=%d" % progress.keys().size())
	print("TASK_0023ZU_CONTROLLED_PRODUCTION_READ_ONLY_OBSERVATION_PASS")
	quit(0)


func _allowed_outcome(load_status: String, boot_status: String, route: String) -> bool:
	var matrix: Dictionary = {
		"MISSING_CLEAN": ["PRODUCTION_PROFILE_READY", "MAIN_MENU"],
		"LOADED": ["PRODUCTION_PROFILE_READY", "MAIN_MENU"],
		"SANITIZED_PENDING_RECOVERY": ["PRODUCTION_PROFILE_READY", "MAIN_MENU"],
		"RECOVERY_REQUIRED_READ_ONLY": ["FAILED_RECOVERY_REQUIRED_READ_ONLY", "SAFE_ERROR"],
		"UNSUPPORTED_VERSION_READ_ONLY": ["FAILED_UNSUPPORTED_VERSION_READ_ONLY", "SAFE_ERROR"],
	}
	return matrix.has(load_status) and matrix[load_status] == [boot_status, route]


func _bounded_identifier(value: String) -> String:
	if value.is_empty() or value.length() > 64:
		return "UNBOUNDED"
	for index: int in range(value.length()):
		var codepoint: int = value.unicode_at(index)
		if not ((codepoint >= 65 and codepoint <= 90) or codepoint == 95):
			return "UNBOUNDED"
	return value


func _fail(reason: String) -> void:
	print("TASK_0023ZU_CONTROLLED_PRODUCTION_READ_ONLY_OBSERVATION_FAIL=" + _bounded_identifier(reason))
	quit(1)

extends SceneTree

const AppRootScene = preload("res://scenes/app/app_root.tscn")
const LocalProfile = preload("res://scripts/app/local_profile.gd")

const EXECUTION_GUARD: String = "--task-0023zf-tutorial-persist-diagnostic"
const FIXTURE_ID: String = "task_0023zf_tutorial_persist_diagnostic"
const CANONICAL_PROFILE_PATH: String = "user://delayed_self_test_profiles/task_0023zf_tutorial_persist_diagnostic/delayed_self_profile.json"
const TUTORIAL_0_ID: String = "tutorial_reach_exit"
const TUTORIAL_1_ID: String = "tutorial_echo_bridge"
const EXPECTED_PERSIST_STATUS: String = "COMMITTED_AFTER_PERSISTED"
const ALLOWED_CLASSIFICATIONS: Array[String] = [
	"EXPECTED_CONTRACT_OBSERVED",
	"ROUTE_FRAME_TIMING",
	"ROUTE_FAILURE_STABLE",
	"RUNTIME_PROGRESS_COMMIT_MISMATCH",
	"BEST_TURNS_MISMATCH",
	"PERSISTENCE_STATUS_MISMATCH",
	"ACTIVE_SCREEN_CONTRACT_MISMATCH",
	"UNRESOLVED_SUBCONDITION",
]

var fixture_directory: String = ""
var owned_paths: Array[String] = []
var production_metadata_baseline: Dictionary = {}
var test_root_exists_baseline: bool = false


func _initialize() -> void:
	var arguments: PackedStringArray = OS.get_cmdline_user_args()
	if not arguments.has(EXECUTION_GUARD):
		print("TASK_0023ZF_EXECUTION_GUARD_BLOCKED")
		quit(2)
		return
	call_deferred("_run_authorized")


func _run_authorized() -> void:
	var built: Dictionary = LocalProfile.build_test_profile_path(FIXTURE_ID)
	if not bool(built.get("ok", false)) or str(built.get("path", "")) != CANONICAL_PROFILE_PATH:
		_abort("fixture_contract_rejected")
		return
	fixture_directory = CANONICAL_PROFILE_PATH.get_base_dir()
	_build_owned_inventory()
	production_metadata_baseline = _production_metadata()
	test_root_exists_baseline = _test_root_exists()
	if not _exact_fixture_absent():
		_abort("fixture_not_fresh")
		return
	if DirAccess.make_dir_recursive_absolute(ProjectSettings.globalize_path(fixture_directory)) != OK:
		_abort("fixture_directory_create_failed")
		return

	var app: Node = AppRootScene.instantiate()
	var configured_result: Dictionary = app.configure_test_profile(CANONICAL_PROFILE_PATH)
	if not bool(configured_result.get("ok", false)):
		app.free()
		_abort("configuration_rejected")
		return
	root.add_child(app)
	await process_frame

	var initial_session: Dictionary = app.get_test_profile_session_snapshot()
	var initial_progress: Dictionary = app.get_progress_snapshot()
	var initial_completed: Array = initial_progress.get("completed_level_ids", [])
	var initial_unlocked: Array = initial_progress.get("unlocked_level_ids", [])
	var boot_ok: bool = (
		app.get_current_route() == "MAIN_MENU"
		and app.get_active_screen_count() == 1
		and str(initial_session.get("load_status", "")) == "MISSING_CLEAN"
		and not FileAccess.file_exists(CANONICAL_PROFILE_PATH)
		and initial_completed.is_empty()
		and initial_unlocked == [TUTORIAL_0_ID]
	)
	if not boot_ok:
		_abort("missing_profile_boot_contract_failed")
		return

	app.select_level(TUTORIAL_0_ID)
	await process_frame
	var gameplay: Node = app.get_active_screen()
	if gameplay == null:
		_abort("gameplay_screen_missing")
		return
	_send_action(gameplay, "move_up")
	_send_action(gameplay, "move_right")
	await process_frame
	_send_action(gameplay, "move_right")
	await process_frame
	var immediate: Dictionary = _bounded_observation(app)
	await process_frame
	var delayed: Dictionary = _bounded_observation(app)
	var delayed_session: Dictionary = app.get_test_profile_session_snapshot()
	var load_status: String = _bounded_identifier(delayed_session.get("load_status", ""))
	var boot_status: String = _bounded_identifier(delayed_session.get("boot_status", ""))
	var configured: bool = bool(delayed_session.get("configured", false))
	var classification: String = _classify(immediate, delayed)

	if _production_metadata() != production_metadata_baseline or _test_root_exists() != test_root_exists_baseline:
		_abort("protected_state_changed")
		return
	_print_observation(immediate, delayed, load_status, boot_status, configured)
	print("TASK_0023ZF_CLASSIFICATION=%s" % classification)
	quit(0)


func _bounded_observation(app: Node) -> Dictionary:
	var progress: Dictionary = app.get_progress_snapshot()
	var session: Dictionary = app.get_test_profile_session_snapshot()
	var completed: Array = progress.get("completed_level_ids", [])
	var best_turns: Dictionary = progress.get("best_turns", {})
	var unlocked: Array = progress.get("unlocked_level_ids", [])
	var best_present: bool = best_turns.has(TUTORIAL_0_ID)
	var best_value: int = int(best_turns.get(TUTORIAL_0_ID, -1))
	return {
		"route_class": _route_class(str(app.get_current_route())),
		"active_screen_count": clampi(app.get_active_screen_count(), 0, 99),
		"completed_count": clampi(completed.size(), 0, 99),
		"tutorial_completed": completed.has(TUTORIAL_0_ID),
		"tutorial_best_turns_present": best_present,
		"tutorial_best_turns_value": clampi(best_value, -1, 999999),
		"tutorial_one_unlocked": unlocked.has(TUTORIAL_1_ID),
		"persist_status": _bounded_identifier(session.get("persist_status", "")),
		"target_exists": FileAccess.file_exists(CANONICAL_PROFILE_PATH),
	}


func _classify(immediate: Dictionary, delayed: Dictionary) -> String:
	var immediate_expected: bool = _full_contract_expected(immediate)
	var delayed_expected: bool = _full_contract_expected(delayed)
	var delayed_progress_persist_target: bool = _progress_persist_target_expected(delayed)
	var classification: String = "UNRESOLVED_SUBCONDITION"
	if immediate_expected and delayed_expected:
		classification = "EXPECTED_CONTRACT_OBSERVED"
	elif str(immediate.get("route_class", "OTHER")) != "LEVEL_SELECT" and str(delayed.get("route_class", "OTHER")) == "LEVEL_SELECT" and delayed_progress_persist_target:
		classification = "ROUTE_FRAME_TIMING"
	elif str(delayed.get("persist_status", "")) != EXPECTED_PERSIST_STATUS or not bool(delayed.get("target_exists", false)):
		classification = "PERSISTENCE_STATUS_MISMATCH"
	elif bool(delayed.get("tutorial_completed", false)) and (not bool(delayed.get("tutorial_best_turns_present", false)) or int(delayed.get("tutorial_best_turns_value", -1)) != 3):
		classification = "BEST_TURNS_MISMATCH"
	elif bool(delayed.get("target_exists", false)) and str(delayed.get("persist_status", "")) == EXPECTED_PERSIST_STATUS and (not bool(delayed.get("tutorial_completed", false)) or not bool(delayed.get("tutorial_one_unlocked", false))):
		classification = "RUNTIME_PROGRESS_COMMIT_MISMATCH"
	elif int(delayed.get("active_screen_count", -1)) != 1:
		classification = "ACTIVE_SCREEN_CONTRACT_MISMATCH"
	elif delayed_progress_persist_target and str(delayed.get("route_class", "OTHER")) != "LEVEL_SELECT":
		classification = "ROUTE_FAILURE_STABLE"
	if not ALLOWED_CLASSIFICATIONS.has(classification):
		return "UNRESOLVED_SUBCONDITION"
	return classification


func _full_contract_expected(observation: Dictionary) -> bool:
	return (
		str(observation.get("route_class", "OTHER")) == "LEVEL_SELECT"
		and int(observation.get("active_screen_count", -1)) == 1
		and _progress_persist_target_expected(observation)
	)


func _progress_persist_target_expected(observation: Dictionary) -> bool:
	return (
		int(observation.get("completed_count", -1)) == 1
		and bool(observation.get("tutorial_completed", false))
		and bool(observation.get("tutorial_best_turns_present", false))
		and int(observation.get("tutorial_best_turns_value", -1)) == 3
		and bool(observation.get("tutorial_one_unlocked", false))
		and str(observation.get("persist_status", "")) == EXPECTED_PERSIST_STATUS
		and bool(observation.get("target_exists", false))
	)


func _print_observation(immediate: Dictionary, delayed: Dictionary, load_status: String, boot_status: String, configured: bool) -> void:
	print(
		"TASK_0023ZF_OBSERVATION immediate_route=%s immediate_screen=%d immediate_completed_count=%d immediate_tutorial_completed=%s immediate_best_present=%s immediate_best=%d immediate_tutorial_one_unlocked=%s immediate_persist=%s immediate_target=%s delayed_route=%s delayed_screen=%d delayed_completed_count=%d delayed_tutorial_completed=%s delayed_best_present=%s delayed_best=%d delayed_tutorial_one_unlocked=%s delayed_persist=%s delayed_target=%s load=%s boot=%s configured=%s"
		% [
			str(immediate.get("route_class", "OTHER")),
			int(immediate.get("active_screen_count", -1)),
			int(immediate.get("completed_count", -1)),
			_bool_text(bool(immediate.get("tutorial_completed", false))),
			_bool_text(bool(immediate.get("tutorial_best_turns_present", false))),
			int(immediate.get("tutorial_best_turns_value", -1)),
			_bool_text(bool(immediate.get("tutorial_one_unlocked", false))),
			str(immediate.get("persist_status", "")),
			_bool_text(bool(immediate.get("target_exists", false))),
			str(delayed.get("route_class", "OTHER")),
			int(delayed.get("active_screen_count", -1)),
			int(delayed.get("completed_count", -1)),
			_bool_text(bool(delayed.get("tutorial_completed", false))),
			_bool_text(bool(delayed.get("tutorial_best_turns_present", false))),
			int(delayed.get("tutorial_best_turns_value", -1)),
			_bool_text(bool(delayed.get("tutorial_one_unlocked", false))),
			str(delayed.get("persist_status", "")),
			_bool_text(bool(delayed.get("target_exists", false))),
			load_status,
			boot_status,
			_bool_text(configured),
		]
	)


func _route_class(route: String) -> String:
	if ["LEVEL_SELECT", "GAMEPLAY", "SAFE_ERROR", "MAIN_MENU"].has(route):
		return route
	return "OTHER"


func _bounded_identifier(value: Variant) -> String:
	var raw: String = str(value).left(64).to_upper()
	var bounded: String = ""
	for index: int in range(raw.length()):
		var code: int = raw.unicode_at(index)
		var allowed: bool = (code >= 65 and code <= 90) or (code >= 48 and code <= 57) or code == 95
		bounded += raw[index] if allowed else "_"
	return bounded if not bounded.is_empty() else "EMPTY"


func _bool_text(value: bool) -> String:
	return "true" if value else "false"


func _send_action(scene: Node, action: String) -> void:
	var event: InputEventAction = InputEventAction.new()
	event.action = action
	event.pressed = true
	scene._unhandled_input(event)


func _build_owned_inventory() -> void:
	owned_paths = [CANONICAL_PROFILE_PATH]
	for kind: String in ["temp", "transaction", "recovery"]:
		for index: int in range(8):
			owned_paths.append(fixture_directory + "/.delayed_self_0023w_" + kind + "_" + str(index) + ".json")


func _exact_fixture_absent() -> bool:
	if DirAccess.dir_exists_absolute(ProjectSettings.globalize_path(fixture_directory)):
		return false
	for path: String in owned_paths:
		if FileAccess.file_exists(path):
			return false
	return true


func _production_metadata() -> Dictionary:
	var production_path: String = LocalProfile.PRODUCTION_PROFILE_PATH
	return {
		"exists": FileAccess.file_exists(production_path),
		"length": FileAccess.get_size(production_path),
		"modified_time": FileAccess.get_modified_time(production_path),
	}


func _test_root_exists() -> bool:
	return DirAccess.dir_exists_absolute(ProjectSettings.globalize_path(LocalProfile.TEST_PROFILE_ROOT))


func _abort(reason: String) -> void:
	print("TASK_0023ZF_DIAGNOSTIC_ABORT=%s" % _bounded_identifier(reason))
	quit(1)

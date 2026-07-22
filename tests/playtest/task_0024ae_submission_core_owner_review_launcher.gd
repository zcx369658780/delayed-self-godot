extends SceneTree

const AppRootScene = preload("res://scenes/app/app_root.tscn")

const QUALIFICATION_FLAG: String = "--task-0024ae-route-qualification"
const STAGING_CATALOG_PATH: String = "res://tests/playtest/fixtures/task_0024ae_submission_core_staging_catalog.json"
const FIXTURE_DIRECTORY: String = "user://delayed_self_test_profiles/task_0024ae_owner_curriculum"
const PROFILE_PATH: String = FIXTURE_DIRECTORY + "/delayed_self_profile.json"
const PASS_MARKER: String = "TASK_0024AE_ISOLATED_STAGING_OWNER_ROUTE_PASS"
const FAIL_PREFIX: String = "TASK_0024AE_ISOLATED_STAGING_OWNER_ROUTE_FAIL"
const RECORD_LIMIT_BYTES: int = 1800
const OWNED_NAME_LIMIT: int = 8

const LEVEL_IDS: Array[String] = [
	"tutorial_reach_exit",
	"tutorial_echo_bridge",
	"vertical_slice_delay_3",
	"door_one_turn_late",
	"two_keys_one_door",
	"staggered_doors",
	"echo_spacing_bridge",
	"two_echo_convergence",
	"crate_shadow_timing",
	"key_route_commitment",
	"identity_shift_bridge",
	"lasting_echo_latch",
]
const LEVEL_PATHS: Array[String] = [
	"res://data/levels/tutorial_reach_exit.json",
	"res://data/levels/tutorial_echo_bridge.json",
	"res://data/levels/vertical_slice_delay_3.json",
	"res://data/levels/door_one_turn_late.json",
	"res://data/levels/two_keys_one_door.json",
	"res://data/levels/staggered_doors.json",
	"res://data/levels/echo_spacing_bridge.json",
	"res://data/levels/two_echo_convergence.json",
	"res://data/levels/crate_shadow_timing.json",
	"res://data/levels/key_route_commitment.json",
	"res://data/levels/identity_shift_bridge.json",
	"res://data/levels/lasting_echo_latch.json",
]
const ACCEPTED_TURNS: Array[int] = [3, 9, 9, 9, 12, 15, 16, 19, 14, 19, 18, 21]

var failure_reason: String = ""
var owned_paths: Array[String] = []
var active_app: Node
var production_data_probe_count: int = 0
var test_root_enumeration_count: int = 0


func _initialize() -> void:
	_build_owned_paths()
	var arguments: PackedStringArray = OS.get_cmdline_args()
	if arguments.has(QUALIFICATION_FLAG):
		call_deferred("_run_qualification")
	else:
		call_deferred("_run_interactive")


func _run_interactive() -> void:
	active_app = await _spawn_configured_app()
	if active_app == null:
		print(FAIL_PREFIX + " " + failure_reason)
		quit(1)
		return
	_emit_record("TASK_0024AE_CONFIGURATION_JSON", {
		"mode": "INTERACTIVE_STAGING",
		"catalog_path": STAGING_CATALOG_PATH,
		"profile_path": PROFILE_PATH,
		"route": active_app.get_current_route(),
		"presentation_readiness": "BLOCKED_SCHEMA_V2_VISUALS",
	})


func _run_qualification() -> void:
	if not _cleanup_exact_owned_paths():
		_finish_failure()
		return
	active_app = await _spawn_configured_app()
	if active_app == null:
		_cleanup_exact_owned_paths()
		_finish_failure()
		return
	var session: Dictionary = active_app.get_profile_session_snapshot()
	var test_session: Dictionary = active_app.get_test_profile_session_snapshot()
	var catalog: Dictionary = active_app.get_catalog_snapshot()
	var entries: Array = catalog.get("entries", [])
	if not _require(
		str(session.get("mode", "")) == "TEST_PROFILE"
		and not bool(session.get("write_authorized", true))
		and str(test_session.get("boot_status", "")) == "TEST_PROFILE_READY"
		and str(test_session.get("load_status", "")) == "MISSING_CLEAN",
		"initial_test_session_invalid"
	):
		await _finish_qualification_failure()
		return
	_emit_record("TASK_0024AE_CONFIGURATION_JSON", {
		"mode": session.get("mode", ""),
		"write_authorized": session.get("write_authorized", true),
		"boot_status": test_session.get("boot_status", ""),
		"load_status": test_session.get("load_status", ""),
		"catalog_path": STAGING_CATALOG_PATH,
		"profile_path": PROFILE_PATH,
		"configured_before_tree": true,
	})
	if not _validate_runtime_catalog(entries):
		await _finish_qualification_failure()
		return
	_emit_record("TASK_0024AE_CATALOG_JSON", {
		"entry_count": entries.size(),
		"ordered_ids": LEVEL_IDS,
		"sole_finale": LEVEL_IDS[11],
		"sequence_8_staging_final": false,
		"catalog_path": STAGING_CATALOG_PATH,
	})
	var initial_progress: Dictionary = active_app.get_progress_snapshot()
	if not _require(
		(initial_progress.get("completed_level_ids", []) as Array).is_empty()
		and initial_progress.get("unlocked_level_ids", []) == [LEVEL_IDS[0]],
		"initial_unlock_state_invalid"
	):
		await _finish_qualification_failure()
		return
	var final_gameplay: Node
	for index: int in range(LEVEL_IDS.size()):
		var level_id: String = LEVEL_IDS[index]
		var before: Dictionary = active_app.get_progress_snapshot()
		if not _require((before.get("unlocked_level_ids", []) as Array).has(level_id), "level_not_unlocked_%d" % (index + 1)):
			break
		active_app.select_level(level_id)
		await process_frame
		var gameplay: Node = active_app.get_active_screen()
		var payload: Dictionary = gameplay.get_route_payload() if gameplay != null and gameplay.has_method("get_route_payload") else {}
		var expected_final: bool = index == LEVEL_IDS.size() - 1
		if not _require(
			active_app.get_current_route() == "GAMEPLAY"
			and active_app.get_active_screen_count() == 1
			and str(payload.get("level_id", "")) == level_id
			and str(payload.get("level_path", "")) == LEVEL_PATHS[index]
			and bool(payload.get("final_level", false)) == expected_final
			and not bool(payload.get("development_direct", true)),
			"route_payload_invalid_%d" % (index + 1)
		):
			break
		if expected_final and gameplay.get("state") is Dictionary:
			var final_state: Dictionary = (gameplay.get("state") as Dictionary).duplicate(true)
			final_state["completed"] = true
			gameplay.set("state", final_state)
		gameplay.emit_signal("gameplay_completed", level_id, ACCEPTED_TURNS[index])
		await process_frame
		var after: Dictionary = active_app.get_progress_snapshot()
		var completed: Array = after.get("completed_level_ids", [])
		var best_turns: Dictionary = after.get("best_turns", {})
		var expected_completed: Array[String] = _sorted_prefix(index + 1)
		var expected_unlocked: Array[String] = _sorted_prefix(mini(index + 2, LEVEL_IDS.size()))
		var route_after: String = str(active_app.get_current_route())
		if not _require(
			completed == expected_completed
			and int(best_turns.get(level_id, 0)) == ACCEPTED_TURNS[index]
			and after.get("unlocked_level_ids", []) == expected_unlocked
			and route_after == ("GAMEPLAY" if expected_final else "LEVEL_SELECT"),
			"completion_progress_invalid_%d" % (index + 1)
		):
			break
		_emit_record("TASK_0024AE_ROUTE_JSON", {
			"sequence": index + 1,
			"level_id": level_id,
			"level_path": LEVEL_PATHS[index],
			"turns": ACCEPTED_TURNS[index],
			"development_direct": false,
			"final_level": expected_final,
			"route_after": route_after,
			"completed_count": completed.size(),
			"unlocked_count": (after.get("unlocked_level_ids", []) as Array).size(),
			"persist_status": active_app.get_test_profile_session_snapshot().get("persist_status", ""),
		})
		if expected_final:
			final_gameplay = gameplay
	if not failure_reason.is_empty():
		await _finish_qualification_failure()
		return
	var final_progress: Dictionary = active_app.get_progress_snapshot()
	var final_acknowledgement: bool = final_gameplay != null and final_gameplay.has_method("is_final_acknowledgement_visible") and final_gameplay.is_final_acknowledgement_visible()
	if not _require(
		final_acknowledgement
		and active_app.get_current_route() == "GAMEPLAY"
		and (final_progress.get("completed_level_ids", []) as Array).size() == 12
		and (final_progress.get("unlocked_level_ids", []) as Array).size() == 12
		and not (final_progress.get("unlocked_level_ids", []) as Array).has("sequence_13"),
		"staging_finale_invalid"
	):
		await _finish_qualification_failure()
		return
	_emit_record("TASK_0024AE_FINALE_JSON", {
		"level_id": LEVEL_IDS[11],
		"current_route": active_app.get_current_route(),
		"acknowledgement_visible": final_acknowledgement,
		"sequence_13_unlocked": false,
		"staging_only": true,
	})
	await _dispose_active_app()
	active_app = await _spawn_configured_app()
	if active_app == null:
		await _finish_qualification_failure()
		return
	var reload_session: Dictionary = active_app.get_test_profile_session_snapshot()
	var reload_progress: Dictionary = active_app.get_progress_snapshot()
	var reload_best: Dictionary = reload_progress.get("best_turns", {})
	var reload_ok: bool = (
		str(reload_session.get("load_status", "")) == "LOADED"
		and reload_progress.get("completed_level_ids", []) == _sorted_prefix(12)
		and reload_progress.get("unlocked_level_ids", []) == _sorted_prefix(12)
		and reload_best.size() == 12
	)
	for index: int in range(LEVEL_IDS.size()):
		reload_ok = reload_ok and int(reload_best.get(LEVEL_IDS[index], 0)) == ACCEPTED_TURNS[index]
	if not _require(reload_ok, "persisted_reload_invalid"):
		await _finish_qualification_failure()
		return
	_emit_record("TASK_0024AE_RELOAD_JSON", {
		"load_status": reload_session.get("load_status", ""),
		"completed_count": (reload_progress.get("completed_level_ids", []) as Array).size(),
		"best_turn_count": reload_best.size(),
		"unlocked_count": (reload_progress.get("unlocked_level_ids", []) as Array).size(),
		"exact_turns": true,
	})
	_emit_record("TASK_0024AE_BOUNDARY_JSON", {
		"profile_path": PROFILE_PATH,
		"owned_path_count": owned_paths.size(),
		"production_data_probe_count": production_data_probe_count,
		"test_root_enumeration_count": test_root_enumeration_count,
		"production_write_authorized": active_app.get_profile_session_snapshot().get("write_authorized", true),
		"catalog_admission_status": "NOT_AUTHORIZED",
		"presentation_readiness": "BLOCKED_SCHEMA_V2_VISUALS",
	})
	await _dispose_active_app()
	if not _cleanup_exact_owned_paths():
		_finish_failure()
		return
	var all_absent: bool = _all_exact_owned_paths_absent()
	var fixture_directory_absent: bool = not DirAccess.dir_exists_absolute(ProjectSettings.globalize_path(FIXTURE_DIRECTORY))
	if not _require(all_absent and fixture_directory_absent, "owned_cleanup_incomplete"):
		_finish_failure()
		return
	_emit_record("TASK_0024AE_CLEANUP_JSON", {
		"exact_owned_path_count": owned_paths.size(),
		"all_exact_owned_paths_absent": all_absent,
		"fixture_directory_absent": fixture_directory_absent,
		"broad_enumeration_used": false,
		"production_data_probe_count": production_data_probe_count,
	})
	print(PASS_MARKER)
	quit(0)


func _spawn_configured_app() -> Node:
	var app: Node = AppRootScene.instantiate()
	if app.is_inside_tree() or bool(app._boot_started):
		_failure("app_not_pre_tree")
		app.free()
		return null
	app.catalog_path = STAGING_CATALOG_PATH
	var configured: Dictionary = app.configure_test_profile(PROFILE_PATH)
	if not (
		bool(configured.get("ok", false))
		and str(configured.get("status", "")) == "APP_TEST_PROFILE_CONFIGURED"
		and str(configured.get("mode", "")) == "TEST_PROFILE"
		and not app.is_inside_tree()
		and not bool(app._boot_started)
	):
		_failure("test_profile_configuration_rejected")
		app.free()
		return null
	root.add_child(app)
	await process_frame
	if app.get_current_route() == "SAFE_ERROR":
		_failure("configured_app_boot_failed")
		app.queue_free()
		await process_frame
		return null
	return app


func _validate_runtime_catalog(entries: Array) -> bool:
	if not _require(entries.size() == 12, "catalog_entry_count"):
		return false
	var final_count: int = 0
	for index: int in range(entries.size()):
		var entry: Dictionary = entries[index]
		if not _require(
			str(entry.get("level_id", "")) == LEVEL_IDS[index]
			and str(entry.get("level_path", "")) == LEVEL_PATHS[index]
			and int(entry.get("sequence", 0)) == index + 1,
			"catalog_entry_invalid_%d" % (index + 1)
		):
			return false
		if bool(entry.get("final_level", false)):
			final_count += 1
	return _require(final_count == 1 and bool((entries[11] as Dictionary).get("final_level", false)) and not bool((entries[7] as Dictionary).get("final_level", true)), "catalog_finale_invalid")


func _build_owned_paths() -> void:
	owned_paths = [PROFILE_PATH]
	for kind: String in ["temp", "transaction", "recovery"]:
		for index: int in range(OWNED_NAME_LIMIT):
			owned_paths.append(FIXTURE_DIRECTORY + "/.delayed_self_0023w_" + kind + "_" + str(index) + ".json")


func _cleanup_exact_owned_paths() -> bool:
	if owned_paths.size() != 25 or owned_paths[0] != PROFILE_PATH:
		return _failure("owned_inventory_invalid")
	for path: String in owned_paths:
		if path.get_base_dir() != FIXTURE_DIRECTORY:
			return _failure("owned_path_outside_fixture")
		if FileAccess.file_exists(path):
			var remove_result: Error = DirAccess.remove_absolute(ProjectSettings.globalize_path(path))
			if remove_result != OK:
				return _failure("owned_file_remove_failed")
	if DirAccess.dir_exists_absolute(ProjectSettings.globalize_path(FIXTURE_DIRECTORY)):
		var directory_result: Error = DirAccess.remove_absolute(ProjectSettings.globalize_path(FIXTURE_DIRECTORY))
		if directory_result != OK:
			return _failure("fixture_directory_not_exactly_empty")
	return true


func _all_exact_owned_paths_absent() -> bool:
	for path: String in owned_paths:
		if FileAccess.file_exists(path):
			return false
	return true


func _sorted_prefix(count: int) -> Array[String]:
	var result: Array[String] = []
	for index: int in range(count):
		result.append(LEVEL_IDS[index])
	result.sort()
	return result


func _dispose_active_app() -> void:
	if active_app != null and is_instance_valid(active_app):
		active_app.queue_free()
		await process_frame
	active_app = null


func _finish_qualification_failure() -> void:
	await _dispose_active_app()
	_cleanup_exact_owned_paths()
	_finish_failure()


func _finish_failure() -> void:
	print(FAIL_PREFIX + " " + (failure_reason if not failure_reason.is_empty() else "unknown"))
	quit(1)


func _require(condition: bool, reason: String) -> bool:
	if condition:
		return true
	return _failure(reason)


func _failure(reason: String) -> bool:
	if failure_reason.is_empty():
		failure_reason = reason.left(96)
	return false


func _emit_record(prefix: String, payload: Dictionary) -> void:
	var line: String = prefix + " " + JSON.stringify(payload)
	if line.to_utf8_buffer().size() >= RECORD_LIMIT_BYTES:
		_failure("record_over_bound_" + prefix)
		return
	print(line)

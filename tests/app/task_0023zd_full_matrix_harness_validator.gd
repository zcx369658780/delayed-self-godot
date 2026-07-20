extends SceneTree

const BEHAVIOR_PATH: String = "res://tests/app/task_0023zd_app_root_profile_session_full_matrix.gd"
const MANIFEST_PATH: String = "res://tests/app/task_0023zd_full_matrix_manifest.json"
const RUNNER_PATH: String = "res://tests/app/task_0023zd_capture_profile_session.ps1"
const APP_ROOT_PATH: String = "res://scripts/app/app_root.gd"
const FIXTURE_ID: String = "task_0023ze_app_root_profile_session"
const CANONICAL_PROFILE_PATH: String = "user://delayed_self_test_profiles/task_0023ze_app_root_profile_session/delayed_self_profile.json"
const EXECUTION_GUARD: String = "--task-0023ze-fixture-execution"

const STAGE_ORDER: Array[String] = [
	"startup",
	"invalid_configuration",
	"late_and_reconfiguration",
	"normal_memory_boot",
	"missing_profile_boot",
	"tutorial_0_persist",
	"fresh_reload",
	"no_change",
	"temp_write_failure",
	"temp_readback_failure",
	"replace_failure",
	"post_replace_verify_failure",
	"malformed_recovery",
	"unknown_version_recovery",
	"public_snapshot",
	"router_contract",
	"cleanup",
	"final",
]

const CASE_IDS: Array[String] = [
	"reject_production_path",
	"reject_malformed_paths",
	"retry_after_rejection",
	"first_valid_configuration_immutable",
	"late_configuration_rejected",
	"normal_memory_boot_contract",
	"unconfigured_direct_development_route",
	"missing_profile_clean_boot",
	"tutorial_zero_real_three_turn_completion",
	"pre_persist_runtime_profile_unchanged",
	"persist_precedes_adapter_commit",
	"tutorial_zero_persisted_progress_route",
	"canonical_target_bytes",
	"fresh_reload_progress",
	"single_active_screen_router",
	"no_change_equal_or_worse_replay",
	"no_change_target_metadata_bytes",
	"no_change_runtime_semantics",
	"no_change_route_finale_contract",
	"temp_write_rollback",
	"temp_readback_rollback",
	"replace_rollback",
	"post_replace_verify_rollback",
	"failure_safe_error_no_false_success",
	"failure_seam_whitelist",
	"malformed_recovery_preserves_source",
	"malformed_recovery_clean_hydration",
	"unknown_version_recovery",
	"recovery_failure_write_disable_safe_error",
	"owned_collision_no_root_enumeration",
	"public_progress_exact_keys",
	"configured_public_nested_runtime_only",
	"defensive_public_session_snapshots",
	"bounded_snapshot_no_disclosure",
	"cleanup_tracks_owned_inventory",
	"cleanup_exact_fixture_only",
	"cleanup_no_test_root_enumeration",
	"cleanup_owned_paths_absent",
	"protected_metadata_and_test_root_unchanged",
	"external_runner_process_accounting",
	"success_after_complete_matrix_cleanup",
]

const ACCEPTED_FAILURE_STAGES: Array[String] = [
	"NONE",
	"RECOVERY_COPY",
	"TEMP_WRITE",
	"TEMP_READBACK",
	"REPLACE",
	"POST_REPLACE_VERIFY",
]

const EXPECTED_FROZEN_SHA256: Dictionary = {
	"res://scripts/app/app_root.gd": "f6050d344a44d718aeef1f97729aa5a394defea55b7568fe0999ca6006e0e83c",
	"res://scripts/app/profile_codec.gd": "31dc4fc8173ffd1b2130ecbcc8d1e89e1538c0c493abc004429c93f4b93a7925",
	"res://scripts/app/local_profile.gd": "c3a01ba4e8152441683825a3bc684cb00b10788ed5cb7161c976082718f2ad0b",
	"res://scripts/app/profile_progress_adapter.gd": "4c35ee3f0ec1c932ab30ffa3c3130870a3febfc7b2f2a6a219efd2a819f5f563",
	"res://scripts/app/memory_progress.gd": "41651ebcff17fd09247c3e5e820fff940c896efc25c5ba17ee7af668bbd4d567",
	"res://tests/app/task_0023r_profile_test_isolation_gate.gd": "91dfff14694098a448b4a0e0aee24e2167e619c7f1f95746761c976441c3d455",
	"res://tests/app/task_0023t_profile_codec_compile_smoke.gd": "46d820f585c53ef08f4e85be242ec1979ed19db07a9b2239615e7a097c4bdac5",
	"res://tests/app/task_0023t_pure_profile_codec.gd": "4f467fce85fe80a15f2a646ef11184bd98dd24dc727343c6ab9e136a072ad1aa",
	"res://tests/app/task_0023v_profile_store_instance_compile_smoke.gd": "0c74e76d1badbfd80b8897cfe1ca96add0af3aa2f3317393eae04f6877c4e1f7",
	"res://tests/app/task_0023v_profile_store_instance_configuration.gd": "c0cd2ca319298235ce9c8f1e65b2d1a9af9df75436a3c6f17b006bbaeb9f8671",
	"res://tests/app/task_0023w_profile_store_compile_smoke.gd": "6c1f998c6b2ae0a16d7071ea118add4817b08207a9b2d26295a5be2d4c50bbe0",
	"res://tests/app/task_0023w_profile_filesystem_store.gd": "f54d28b08354560652f310c25a5255ea38be92fc1e3016576cb04b08c66bfc2c",
	"res://tests/app/task_0023x_profile_memory_progress_adapter_compile_smoke.gd": "5d4a3f2782e7d62fd3b387666ed105fceb7b4e7a1a6d73f5219f18509641f2d0",
	"res://tests/app/task_0023x_profile_memory_progress_adapter.gd": "9caf087bc247d635c46d770ea8b69dc85095d90fd40eb4702cfddd9b0761399d",
	"res://tests/app/task_0023zc_app_root_profile_orchestration_parser_smoke.gd": "2ddefd01652bc5e0247c498b4ef0b2cb88349fc45c089ac2d8fae5cfe30c114f",
	"res://tests/app/task_0023zc_app_root_profile_orchestration_compile_contract.gd": "a0c9a6cf009b108aeeabdd030d9b3f909a7b7902372d8922e8a55ae32f9d621c",
}

var assertions: int = 0
var failures: int = 0


func _initialize() -> void:
	call_deferred("_run")


func _run() -> void:
	var behavior: String = _read_text(BEHAVIOR_PATH)
	var manifest_text: String = _read_text(MANIFEST_PATH)
	var runner: String = _read_text(RUNNER_PATH)
	var app_root: String = _read_text(APP_ROOT_PATH)
	var parsed_value: Variant = JSON.parse_string(manifest_text)
	_expect(parsed_value is Dictionary, "manifest_json_dictionary")
	if not parsed_value is Dictionary:
		_finish()
		return
	var manifest: Dictionary = parsed_value
	_validate_manifest(manifest)
	_validate_behavior(behavior, manifest)
	_validate_runner(runner, manifest)
	_validate_app_root_ordering(app_root)
	_validate_frozen_hashes()
	_finish()


func _validate_manifest(manifest: Dictionary) -> void:
	var expected_keys: Array[String] = [
		"accepted_failure_stages",
		"canonical_profile_path",
		"case_ids",
		"evidence_files",
		"execution_guard",
		"fixture_id",
		"forbidden_disclosures",
		"future_task",
		"schema_version",
		"stage_order",
	]
	var actual_keys: Array = manifest.keys()
	actual_keys.sort()
	_expect(actual_keys == expected_keys, "manifest_exact_top_level_keys")
	_expect(int(manifest.get("schema_version", 0)) == 1, "manifest_schema_version")
	_expect(str(manifest.get("future_task", "")) == "0023ZE", "manifest_future_task")
	_expect(str(manifest.get("fixture_id", "")) == FIXTURE_ID, "manifest_fixture_id")
	_expect(str(manifest.get("canonical_profile_path", "")) == CANONICAL_PROFILE_PATH, "manifest_canonical_path")
	_expect(str(manifest.get("execution_guard", "")) == EXECUTION_GUARD, "manifest_execution_guard")
	_expect(manifest.get("stage_order", []) == STAGE_ORDER, "manifest_stage_order")
	_expect(manifest.get("case_ids", []) == CASE_IDS, "manifest_case_order")
	_expect(_unique_count(manifest.get("stage_order", [])) == STAGE_ORDER.size(), "manifest_unique_stages")
	_expect(_unique_count(manifest.get("case_ids", [])) == CASE_IDS.size(), "manifest_unique_cases")
	_expect(manifest.get("accepted_failure_stages", []) == ACCEPTED_FAILURE_STAGES, "manifest_failure_stages")
	var disclosures: Array = manifest.get("forbidden_disclosures", [])
	for required: String in ["Profile content", "virtual paths", "globalized paths", "raw filesystem errors", "store objects", "adapter objects", "sibling filenames"]:
		_expect(disclosures.has(required), "manifest_disclosure_" + required.to_snake_case())
	var evidence: Dictionary = manifest.get("evidence_files", {})
	_expect(evidence.keys().size() == 2 and evidence.has("qualification") and evidence.has("attempt_templates"), "manifest_evidence_shape")
	_expect((evidence.get("qualification", []) as Array).size() == 11, "manifest_qualification_inventory_count")
	_expect((evidence.get("attempt_templates", []) as Array).size() == 17, "manifest_attempt_inventory_count")


func _validate_behavior(behavior: String, manifest: Dictionary) -> void:
	_expect(not behavior.is_empty(), "behavior_source_readable")
	_expect(behavior.count(FIXTURE_ID) == 2, "behavior_fixture_id_exact_constant_and_path")
	_expect(behavior.count(CANONICAL_PROFILE_PATH) == 1, "behavior_canonical_path_unique")
	_expect(behavior.contains('const EXECUTION_GUARD: String = "' + EXECUTION_GUARD + '"'), "behavior_guard_constant")
	_expect(behavior.contains('print("TASK_0023ZD_EXECUTION_GUARD_BLOCKED")'), "behavior_guard_marker")
	_expect(behavior.contains("quit(2)"), "behavior_guard_exit_two")
	var init_start: int = behavior.find("func _initialize()")
	var run_start: int = behavior.find("func _run_authorized()")
	var init_block: String = behavior.substr(init_start, run_start - init_start) if init_start >= 0 and run_start > init_start else ""
	_expect(not init_block.is_empty(), "behavior_initialization_block")
	_expect(init_block.find("arguments.has(EXECUTION_GUARD)") >= 0 and init_block.find("arguments.has(EXECUTION_GUARD)") < init_block.find('call_deferred("_run_authorized")'), "behavior_guard_before_deferred_run")
	_expect(not init_block.contains("AppRootScene.instantiate") and not init_block.contains("FileAccess") and not init_block.contains("DirAccess") and not init_block.contains("build_test_profile_path"), "behavior_guard_before_sensitive_flow")
	for stage: String in STAGE_ORDER:
		_expect(behavior.contains("func _run_" + stage + "_stage()"), "behavior_stage_runner_" + stage)
		_expect(behavior.contains("func _stage_" + stage + "()"), "behavior_stage_function_" + stage)
		_expect(behavior.contains('_begin_stage("' + stage + '")'), "behavior_stage_begin_" + stage)
		_expect(behavior.contains('_finish_stage("' + stage + '", before)'), "behavior_stage_finish_" + stage)
	var previous_position: int = -1
	for stage: String in STAGE_ORDER:
		var stage_call: String = "_run_" + stage + "_stage()"
		var position: int = behavior.find(stage_call, previous_position + 1)
		_expect(position > previous_position, "behavior_stage_order_" + stage)
		previous_position = position
	for case_id: String in CASE_IDS:
		_expect(behavior.contains('"' + case_id + '"'), "behavior_case_" + case_id)
	_expect(behavior.count("_expect_case(") >= 35, "behavior_common_assertion_helper_used")
	_expect(not behavior.contains("assert("), "behavior_no_direct_assert")
	for forbidden: String in ["TODO", "FIXME", "placeholder", "assert(true)", "skip_stage", "SKIP_STAGE"]:
		_expect(not behavior.contains(forbidden), "behavior_no_" + forbidden.to_snake_case())
	_expect(behavior.contains("TASK_0023ZE_BEHAVIOR_PROCESS_STARTED"), "behavior_process_marker")
	_expect(behavior.contains("TASK_0023ZE_STAGE_BEGIN="), "behavior_stage_begin_protocol")
	_expect(behavior.contains("TASK_0023ZE_STAGE_PASS="), "behavior_stage_pass_protocol")
	_expect(behavior.contains("TASK_0023ZE_ASSERT_FAIL stage=%s label=%s"), "behavior_failure_protocol")
	_expect(behavior.contains("TASK_0023ZE_ABORT stage=%s reason=%s"), "behavior_abort_protocol")
	_expect(behavior.contains("TASK_0023ZE_ASSERTIONS=%d"), "behavior_assertion_count_protocol")
	_expect(behavior.contains("TASK_0023ZE_APP_ROOT_PROFILE_SESSION_FULL_MATRIX_PASS"), "behavior_terminal_marker")
	_expect(behavior.contains('["best_turns", "completed_level_ids", "unlocked_level_ids"]'), "behavior_exact_public_keys")
	_expect(behavior.contains('wrapper.get("runtime", {})'), "behavior_nested_runtime_assertion")
	_expect(behavior.contains("persist_precedes_adapter_commit"), "behavior_persist_commit_case")
	_expect(behavior.contains("TEMP_WRITE") and behavior.contains("TEMP_READBACK") and behavior.contains("POST_REPLACE_VERIFY"), "behavior_failure_matrix")
	_expect(behavior.contains("RECOVERED_CLEAN") and behavior.contains("RECOVERY_COPY"), "behavior_recovery_matrix")
	_expect(behavior.contains("fresh_reload_progress") and behavior.contains("no_change_equal_or_worse_replay"), "behavior_reload_no_change_matrix")
	_expect(behavior.contains("cleanup_no_test_root_enumeration") and behavior.contains("_remove_exact_file"), "behavior_cleanup_matrix")
	_expect(manifest.get("case_ids", []) == CASE_IDS, "behavior_manifest_case_alignment")


func _validate_runner(runner: String, manifest: Dictionary) -> void:
	_expect(not runner.is_empty(), "runner_source_readable")
	_expect(runner.contains("[ValidateSet('Qualify', 'Execute')]"), "runner_exact_modes")
	_expect(runner.contains("Set-StrictMode -Version Latest"), "runner_strict_mode")
	_expect(runner.contains("$ErrorActionPreference = 'Stop'"), "runner_error_stop")
	_expect(runner.contains("Start-Process -FilePath $GodotPath") and runner.contains("-Wait -PassThru"), "runner_wait_passthru")
	_expect(runner.contains("-RedirectStandardOutput $stdoutPath") and runner.contains("-RedirectStandardError $stderrPath"), "runner_independent_capture")
	var qualify_start: int = runner.find("if ($Mode -eq 'Qualify') {", runner.find("New-Item"))
	var execute_start: int = runner.find("$attemptPrefix =")
	var qualify_block: String = runner.substr(qualify_start, execute_start - qualify_start) if qualify_start >= 0 and execute_start > qualify_start else ""
	_expect(not qualify_block.is_empty(), "runner_qualify_block")
	_expect(qualify_block.contains("$parserScript") and not qualify_block.contains("$executionGuard") and not qualify_block.contains("$fullMatrixScript"), "runner_qualify_parser_only")
	_expect(runner.contains("if ($AttemptNumber -le 0)"), "runner_execute_positive_attempt")
	_expect(runner.contains("if ($ScriptPath -ne $fullMatrixScript)"), "runner_execute_exact_script")
	_expect(runner.contains("'--', $executionGuard"), "runner_execute_guard")
	_expect(runner.contains("Get-FutureFixtureExactState"), "runner_execute_fixture_state")
	_expect(runner.contains("git") and runner.contains("'diff', '--binary', '--no-ext-diff'"), "runner_worktree_patch")
	_expect(runner.contains("Get-FileHash -LiteralPath $patchPath -Algorithm SHA256"), "runner_patch_hash")
	_expect(runner.contains("TASK_0023ZE_(BEHAVIOR_PROCESS_STARTED|STAGE_BEGIN=|STAGE_PASS=|ASSERT_FAIL|ABORT|ASSERTIONS=|APP_ROOT_PROFILE_SESSION_FULL_MATRIX_PASS)"), "runner_stage_summary")
	_expect(runner.contains("PASS_CANDIDATE") and runner.contains("CONTROLLED_ABORT") and runner.contains("ASSERTION_FAILURE") and runner.contains("UNCLASSIFIED_NONPASS"), "runner_classification")
	_expect(not runner.contains("Get-ChildItem -LiteralPath $testRoot") and not runner.contains("ReadAllText($productionProfile)") and not runner.contains("Get-Content -LiteralPath $productionProfile"), "runner_no_protected_content_or_root_enumeration")
	var evidence: Dictionary = manifest.get("evidence_files", {})
	for qualification_name_value: Variant in evidence.get("qualification", []):
		var qualification_name: String = str(qualification_name_value)
		var qualification_suffix: String = qualification_name.trim_prefix("capture_qualification")
		_expect(runner.contains("$prefix + '" + qualification_suffix + "'"), "runner_qualification_file_" + qualification_name)
	for template_value: Variant in evidence.get("attempt_templates", []):
		var template: String = str(template_value)
		var suffix: String = template.trim_prefix("attempt_<N>")
		_expect(runner.contains("$attemptPrefix + '" + suffix + "'"), "runner_attempt_file_" + template.replace("<N>", "n"))
	_expect(runner.contains("Assert-Inventory"), "runner_fail_closed_inventory")
	_expect(runner.contains("ExecutionGuardPassed=False") and runner.contains("ExecutionGuardPassed=True"), "runner_guard_inventory")


func _validate_app_root_ordering(app_root: String) -> void:
	var prepare_position: int = app_root.find("_profile_adapter.prepare_completion")
	var persist_position: int = app_root.find("_profile_store.persist_profile", prepare_position)
	var accepted_position: int = app_root.find("PROFILE_PERSIST_ACCEPTED_STATUSES.has", persist_position)
	var commit_position: int = app_root.find("_profile_adapter.commit_profile", accepted_position)
	_expect(prepare_position >= 0 and persist_position > prepare_position and accepted_position > persist_position and commit_position > accepted_position, "accepted_app_root_persist_before_commit")
	var adapter_position: int = app_root.find("ProfileProgressAdapter.new")
	var facts_position: int = app_root.find("catalog_facts", adapter_position)
	var store_position: int = app_root.find("LocalProfile.new", facts_position)
	var load_position: int = app_root.find("store.load_profile", store_position)
	var hydrate_position: int = app_root.find("adapter.load_profile", load_position)
	_expect(adapter_position >= 0 and facts_position > adapter_position and store_position > facts_position and load_position > store_position and hydrate_position > load_position, "accepted_app_root_boot_order")
	_expect(app_root.contains('adapter_snapshot.get("runtime", {})'), "accepted_app_root_nested_runtime")


func _validate_frozen_hashes() -> void:
	for path_value: Variant in EXPECTED_FROZEN_SHA256.keys():
		var path: String = str(path_value)
		var expected: String = str(EXPECTED_FROZEN_SHA256.get(path, ""))
		_expect(_sha256(path) == expected, "frozen_hash_" + path.get_file().to_snake_case())


func _sha256(path: String) -> String:
	var bytes: PackedByteArray = FileAccess.get_file_as_bytes(path)
	var context: HashingContext = HashingContext.new()
	if context.start(HashingContext.HASH_SHA256) != OK:
		return ""
	if context.update(bytes) != OK:
		return ""
	var digest: PackedByteArray = context.finish()
	return digest.hex_encode()


func _read_text(path: String) -> String:
	if path.begins_with("res://tests/app/task_0023zd_") or path == APP_ROOT_PATH:
		return FileAccess.get_file_as_string(path)
	return ""


func _unique_count(values: Array) -> int:
	var unique: Dictionary = {}
	for value: Variant in values:
		unique[str(value)] = true
	return unique.size()


func _expect(condition: bool, label: String) -> void:
	assertions += 1
	if not condition:
		failures += 1
		print("TASK_0023ZD_VALIDATOR_ASSERT_FAIL label=" + label.left(140))


func _finish() -> void:
	print("TASK_0023ZD_VALIDATOR_ASSERTIONS=%d" % assertions)
	if failures == 0:
		print("TASK_0023ZD_FULL_MATRIX_HARNESS_VALIDATOR_PASS")
		quit(0)
	else:
		print("TASK_0023ZD_FULL_MATRIX_HARNESS_VALIDATOR_FAIL failures=%d" % failures)
		quit(1)

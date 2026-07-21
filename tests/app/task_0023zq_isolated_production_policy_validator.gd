extends SceneTree

const CASE_PATH: String = "res://tests/app/task_0023zq_isolated_production_policy_case.gd"
const PARSER_PATH: String = "res://tests/app/task_0023zq_isolated_production_policy_parser_smoke.gd"
const VALIDATOR_PATH: String = "res://tests/app/task_0023zq_isolated_production_policy_validator.gd"
const MANIFEST_PATH: String = "res://tests/app/task_0023zq_isolated_production_policy_manifest.json"
const RUNNER_PATH: String = "res://tests/app/task_0023zq_capture_isolated_production_policy.ps1"

var assertions: int = 0
var failures: int = 0


func _initialize() -> void:
	call_deferred("_run")


func _run() -> void:
	var case_source: String = _read_text(CASE_PATH)
	var parser_source: String = _read_text(PARSER_PATH)
	var validator_source: String = _read_text(VALIDATOR_PATH)
	var manifest_text: String = _read_text(MANIFEST_PATH)
	var runner_source: String = _read_text(RUNNER_PATH)
	var parsed: Variant = JSON.parse_string(manifest_text)
	_expect(not case_source.is_empty(), "case_exists")
	_expect(not parser_source.is_empty(), "parser_exists")
	_expect(not validator_source.is_empty(), "validator_exists")
	_expect(not manifest_text.is_empty(), "manifest_exists")
	_expect(not runner_source.is_empty(), "runner_exists")
	_expect(parsed is Dictionary, "manifest_dictionary")
	if parsed is Dictionary:
		var manifest: Dictionary = parsed
		_validate_manifest(manifest, case_source)
		_validate_attestation(case_source)
		_validate_runner(manifest, runner_source)
		_validate_frozen(manifest)
	_validate_disclosure(case_source, runner_source)
	print("TASK_0023ZQ_VALIDATOR_ASSERTIONS=%d" % assertions)
	if failures == 0:
		print("TASK_0023ZQ_ISOLATED_PRODUCTION_POLICY_VALIDATOR_PASS")
		quit(0)
	else:
		print("TASK_0023ZQ_ISOLATED_PRODUCTION_POLICY_VALIDATOR_FAIL failures=%d" % failures)
		quit(1)


func _validate_manifest(manifest: Dictionary, case_source: String) -> void:
	_expect(int(manifest.get("schema_version", 0)) == 1, "manifest_schema")
	var stages: Array = manifest.get("stages", [])
	var cases: Array = manifest.get("cases", [])
	_expect(stages == ["bootstrap_policy", "production_read_only", "production_write_on_intent"], "ordered_stages")
	_expect(cases.size() == 22, "case_cardinality")
	_expect(int(manifest.get("expected_assertion_count", 0)) == cases.size(), "assertion_cardinality")
	_expect(_unique_strings(stages), "unique_stages")
	var ids: Array[String] = []
	for case_value: Variant in cases:
		_expect(case_value is Dictionary, "case_dictionary")
		if not case_value is Dictionary:
			continue
		var case_entry: Dictionary = case_value
		var case_id: String = str(case_entry.get("id", ""))
		var stage: String = str(case_entry.get("stage", ""))
		ids.append(case_id)
		_expect(not case_id.is_empty() and stages.has(stage), "case_identity_" + case_id)
		_expect(_is_bounded_identifier(str(case_entry.get("expected_status", ""))), "bounded_status_" + case_id)
		for field: String in ["target_creation", "target_mutation", "recovery_sibling", "activation_backup", "transaction_sibling", "write_disabled"]:
			_expect(case_entry.get(field, null) is bool, "boolean_" + field + "_" + case_id)
		var dictionary_regex: RegEx = RegEx.new()
		dictionary_regex.compile('(?m)^\\s*"' + case_id + '":\\s*"' + stage + '"')
		_expect(dictionary_regex.search_all(case_source).size() == 1, "stage_mapping_" + case_id)
		var branch_regex: RegEx = RegEx.new()
		branch_regex.compile('(?m)^\\s*"' + case_id + '":\\s*$')
		_expect(branch_regex.search_all(case_source).size() == 1, "dispatch_mapping_" + case_id)
		_expect(case_source.count("func _case_" + case_id + "()") == 1, "function_mapping_" + case_id)
	_expect(_unique_strings(ids), "unique_case_ids")
	_expect(ids.size() == int(manifest.get("expected_assertion_count", 0)), "one_to_one_assertions")
	var markers: Dictionary = manifest.get("expected_markers_per_case", {})
	for marker: String in ["sandbox_attested", "behavior_started", "stage", "assert_pass", "case_status", "case_pass"]:
		_expect(int(markers.get(marker, 0)) == 1, "marker_once_" + marker)
	var required: Array = manifest.get("required_attempt_evidence", [])
	_expect(required.size() == 6 and _unique_strings(required), "required_evidence_inventory")


func _validate_attestation(case_source: String) -> void:
	var initialize_block: String = _function_block(case_source, "func _initialize", "func _attest_sandbox")
	_expect(initialize_block.find("EXECUTION_GUARD") < initialize_block.find("_attest_sandbox()"), "guard_before_attestation")
	_expect(initialize_block.find("_attest_sandbox()") < initialize_block.find('call_deferred("_run")'), "attestation_before_behavior")
	_expect(initialize_block.contains("TASK_0023ZQ_EXECUTION_GUARD_BLOCKED") and initialize_block.contains("quit(2)"), "guard_fail_closed")
	_expect(initialize_block.contains("TASK_0023ZQ_SANDBOX_ATTESTATION_BLOCKED"), "attestation_fail_closed")
	_expect(case_source.count("OS.get_user_data_dir()") == 1, "single_user_data_query_in_attestation")
	var attestation: String = _function_block(case_source, "func _attest_sandbox", "func _run")
	_expect(attestation.contains("is_absolute_path"), "attestation_absolute")
	_expect(attestation.contains("begins_with(appdata_root + \"/\")"), "attestation_strict_child")
	_expect(attestation.contains("user_data_dir == appdata_root"), "attestation_not_root")
	_expect(attestation.contains("_has_parent_segment"), "attestation_no_parent_escape")
	_expect(attestation.contains("EVIDENCE_ROOT") and attestation.contains("REPOSITORY_ROOT"), "attestation_external_repo_separation")
	_expect(case_source.contains("0023ZS_disclosure_scanner_retry"), "fresh_retry_evidence_root")
	_expect(attestation.contains("ProjectSettings.globalize_path(LocalProfile.PRODUCTION_PROFILE_PATH)"), "attestation_exact_target")
	_expect(not initialize_block.contains("FileAccess") and not initialize_block.contains("DirAccess") and not initialize_block.contains("instantiate()") and not initialize_block.contains("configure_production"), "no_operation_before_attestation")
	_expect(not case_source.contains("configure_test("), "no_test_store_configuration")
	_expect(not case_source.contains("configure_test_profile("), "no_test_app_configuration")
	_expect(not case_source.contains("build_test_profile_path("), "no_test_path_builder")
	_expect(not case_source.contains("validate_test_profile_path("), "no_test_path_validator")
	_expect(not case_source.contains("TEST_PROFILE_ROOT"), "no_test_root_reference")
	_expect(not case_source.contains("delayed_self_test_profiles"), "no_test_root_literal")
	_expect(not case_source.contains('"delayed_self_profile.json"'), "target_name_not_hardcoded")


func _validate_runner(manifest: Dictionary, runner_source: String) -> void:
	_expect(runner_source.contains("function Invoke-BoundedGodotProcess"), "bounded_process_helper")
	_expect(runner_source.contains("[System.Diagnostics.ProcessStartInfo]::new()"), "child_process_api")
	_expect(runner_source.contains("$psi.FileName = $GodotExe"), "exact_executable_filename")
	_expect(runner_source.contains("foreach ($argument in $GodotArguments)"), "separate_argument_iteration")
	_expect(runner_source.contains("$psi.ArgumentList.Add([string]$argument)"), "argument_list_api")
	_expect(runner_source.count("Invoke-BoundedGodotProcess -GodotArguments") == 2, "single_helper_for_qualification_and_behavior")
	_expect(not runner_source.contains(".Arguments =") and not runner_source.contains("Quote-Argument"), "no_flattened_process_arguments")
	_expect(not runner_source.contains("Invoke-Expression") and not runner_source.contains("cmd /c") and not runner_source.contains("Start-Process"), "no_forbidden_shell_launch")
	_expect(runner_source.contains("$psi.EnvironmentVariables[[string]$name]") and runner_source.contains("'APPDATA' = $appdataRoot") and runner_source.contains("'LOCALAPPDATA' = $localappdataRoot"), "process_local_appdata")
	_expect(runner_source.contains("DELAYED_SELF_0023ZQ_EXECUTION_GUARD") and runner_source.contains("DELAYED_SELF_0023ZQ_ATTEMPT") and runner_source.contains("DELAYED_SELF_0023ZQ_CASE"), "bounded_child_environment")
	_expect(not runner_source.contains("setx") and not runner_source.contains("SetEnvironmentVariable") and not runner_source.contains("HKCU") and not runner_source.contains("HKLM"), "no_persistent_environment_or_registry")
	_expect(not runner_source.contains("New-Item -ItemType SymbolicLink") and not runner_source.contains("New-Item -ItemType Junction"), "no_links")
	_expect(runner_source.contains("ReparsePoint"), "reparse_rejection")
	_expect(runner_source.contains("Assert-ExactOwnedPath") and runner_source.contains("AllowedOwnedNames"), "exact_owned_cleanup")
	_expect(runner_source.contains("Attempt 1 complete-pass evidence is required before Attempt 2"), "attempt_two_gated")
	_expect(runner_source.contains("classification -ne 'PASS_COMPLETE_MATRIX'") and runner_source.contains("cleanupComplete"), "attempt_pass_and_cleanup_required")
	_expect(runner_source.contains("Test-ForbiddenDisclosure"), "disclosure_scan")
	_expect(runner_source.contains("function Test-WindowsAbsoluteDrivePath"), "drive_path_classifier_helper")
	_expect(runner_source.contains("(?<![A-Za-z0-9+.\\-])[A-Za-z]:[\\\\/]"), "drive_path_left_boundary")
	_expect(runner_source.contains("function Test-UncPath") and runner_source.contains("Test-UncPath $Text"), "unc_classifier_active")
	_expect(runner_source.contains("$drivePositiveVectors") and runner_source.contains("$uncPositiveVectors") and runner_source.contains("$driveNegativeVectors"), "scanner_vector_groups")
	_expect(runner_source.contains("$scannerAssertions -ne 11") and runner_source.contains("TASK_0023ZS_DISCLOSURE_SCANNER_ASSERTIONS="), "scanner_vector_cardinality")
	_expect(runner_source.contains("TASK_0023ZS_DISCLOSURE_SCANNER_QUALIFICATION_PASS"), "scanner_qualification_marker")
	_expect(runner_source.contains("file:///C:/Users/player/file.txt") and runner_source.contains("https://godotengine.org") and runner_source.contains("res://scenes/app/app_root.tscn"), "scanner_required_vectors")
	_expect(not runner_source.contains("-replace 'https://") and not runner_source.contains("StartsWith('http") and not runner_source.contains("Godot Engine v4.x - https://godotengine.org') { return"), "no_uri_or_banner_whitelist")
	_expect(runner_source.contains("marker_cardinality.csv"), "marker_audit")
	_expect(runner_source.contains("case_results.csv"), "case_results")
	_expect(runner_source.contains("attempt_summary.json"), "attempt_summary")
	_expect(runner_source.contains("TASK_0023ZQ_ATTEMPT_CLASSIFICATION=PASS_COMPLETE_MATRIX"), "complete_matrix_marker")
	_expect(runner_source.contains("TASK_0023ZQ_ATTEMPT_ABORTED"), "bounded_abort_marker")
	var cases: Array = manifest.get("cases", [])
	for case_value: Variant in cases:
		if not case_value is Dictionary:
			continue
		var case_entry: Dictionary = case_value
		var write_expected: bool = bool(case_entry.get("target_creation", false)) or bool(case_entry.get("target_mutation", false)) or bool(case_entry.get("recovery_sibling", false)) or bool(case_entry.get("activation_backup", false)) or bool(case_entry.get("transaction_sibling", false))
		if write_expected:
			_expect(case_entry.has("expected_status"), "write_case_audited_" + str(case_entry.get("id", "")))
		else:
			_expect(not bool(case_entry.get("target_creation", true)) and not bool(case_entry.get("target_mutation", true)), "no_write_case_declared_" + str(case_entry.get("id", "")))


func _validate_frozen(manifest: Dictionary) -> void:
	var frozen: Dictionary = manifest.get("frozen_sha256", {})
	_expect(frozen.size() == 10, "frozen_manifest_cardinality")
	for path_value: Variant in frozen.keys():
		var path: String = str(path_value)
		_expect(FileAccess.file_exists(path), "frozen_exists_" + path.get_file().to_snake_case())
		_expect(FileAccess.get_sha256(path) == str(frozen.get(path, "")), "frozen_hash_" + path.get_file().to_snake_case())
	var project: String = _read_text("res://project.godot")
	_expect(project.contains('run/main_scene="res://scenes/app/app_root.tscn"'), "main_scene_unchanged")
	_expect(not project.contains("[autoload]"), "autoload_absent")


func _validate_disclosure(case_source: String, runner_source: String) -> void:
	for line: String in case_source.split("\n"):
		if line.strip_edges().begins_with("print("):
			_expect(not line.contains("_target_path") and not line.contains("appdata_root") and not line.contains("user_data_dir") and not line.contains("JSON.stringify") and not line.contains("FileAccess"), "bounded_print_line")
	_expect(case_source.contains("_bounded_identifier(status)"), "bounded_status_output")
	_expect(runner_source.contains("Test-WindowsAbsoluteDrivePath") and runner_source.contains("Test-UncPath"), "absolute_path_scan")
	_expect(not runner_source.contains("Write-Output $stdout") and not runner_source.contains("Write-Host $stdout"), "runner_no_raw_stdout_echo")


func _function_block(source: String, start_marker: String, end_marker: String) -> String:
	var start: int = source.find(start_marker)
	var finish: int = source.find(end_marker, start + start_marker.length())
	if start < 0 or finish < 0:
		return ""
	return source.substr(start, finish - start)


func _unique_strings(values: Array) -> bool:
	var seen: Dictionary = {}
	for value: Variant in values:
		var text: String = str(value)
		if text.is_empty() or seen.has(text):
			return false
		seen[text] = true
	return true


func _is_bounded_identifier(value: String) -> bool:
	if value.is_empty() or value.length() > 64:
		return false
	for index: int in range(value.length()):
		var codepoint: int = value.unicode_at(index)
		if not ((codepoint >= 65 and codepoint <= 90) or codepoint == 95):
			return false
	return true


func _read_text(path: String) -> String:
	var file: FileAccess = FileAccess.open(path, FileAccess.READ)
	if file == null:
		return ""
	var text: String = file.get_as_text()
	file.close()
	return text


func _expect(condition: bool, label: String) -> void:
	assertions += 1
	if not condition:
		failures += 1
		print("TASK_0023ZQ_VALIDATOR_ASSERT_FAIL label=" + label)

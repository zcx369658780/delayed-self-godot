extends SceneTree

const OBSERVATION_PATH: String = "res://tests/app/task_0023zt_controlled_production_read_only_observation.gd"
const PARSER_PATH: String = "res://tests/app/task_0023zt_controlled_production_read_only_parser_smoke.gd"
const VALIDATOR_PATH: String = "res://tests/app/task_0023zt_controlled_production_read_only_validator.gd"
const MANIFEST_PATH: String = "res://tests/app/task_0023zt_controlled_production_read_only_manifest.json"
const RUNNER_PATH: String = "res://tests/app/task_0023zt_capture_controlled_production_read_only.ps1"

var assertions: int = 0
var failures: int = 0


func _initialize() -> void:
	call_deferred("_run")


func _run() -> void:
	var observation: String = _read_text(OBSERVATION_PATH)
	var parser: String = _read_text(PARSER_PATH)
	var validator: String = _read_text(VALIDATOR_PATH)
	var manifest_text: String = _read_text(MANIFEST_PATH)
	var runner: String = _read_text(RUNNER_PATH)
	var parsed: Variant = JSON.parse_string(manifest_text)
	for source: String in [observation, parser, validator, manifest_text, runner]:
		_expect(not source.is_empty(), "artifact_exists")
	_expect(parsed is Dictionary, "manifest_dictionary")
	if parsed is Dictionary:
		_validate_manifest(parsed as Dictionary)
		_validate_guards(parsed as Dictionary, observation, runner)
		_validate_observation(observation)
		_validate_runner(runner)
		_validate_frozen(parsed as Dictionary)
	print("TASK_0023ZT_VALIDATOR_ASSERTIONS=%d" % assertions)
	if failures == 0:
		print("TASK_0023ZT_CONTROLLED_PRODUCTION_READ_ONLY_VALIDATOR_PASS")
		quit(0)
	else:
		print("TASK_0023ZT_CONTROLLED_PRODUCTION_READ_ONLY_VALIDATOR_FAIL failures=%d" % failures)
		quit(1)


func _validate_manifest(manifest: Dictionary) -> void:
	_expect(int(manifest.get("schema_version", 0)) == 1, "schema")
	_expect(str(manifest.get("future_task_id", "")) == "0023ZU", "future_task")
	_expect(str(manifest.get("owner_parameter_name", "")) == "OwnerAuthorization", "owner_parameter")
	_expect(str(manifest.get("owner_authorization", "")) == "TASK_0023ZU_OWNER_AUTHORIZED_PRODUCTION_READ_ONLY", "owner_value")
	_expect(str(manifest.get("child_environment_name", "")) == "DELAYED_SELF_0023ZU_PRODUCTION_READ_AUTHORIZATION", "child_environment")
	_expect(str(manifest.get("child_environment_value", "")) == str(manifest.get("owner_authorization", "")), "child_value")
	_expect(str(manifest.get("engine_user_argument", "")) == "--task-0023zu-controlled-production-read-only", "user_argument")
	_expect(str(manifest.get("required_active_status", "")) == "OWNER_AUTHORIZED_CONTROLLED_PRODUCTION_READ_ONLY_EXECUTION", "active_status")
	_expect(str(manifest.get("future_evidence_root", "")) == "D:\\Delayed_Self_Evidence\\0023ZU_controlled_production_read_only\\", "future_root")
	_expect(int(manifest.get("maximum_guard_passing_processes", 0)) == 1, "single_process")
	_expect(manifest.get("sibling_categories", []) == ["recovery", "activation_backup", "temp", "transaction"], "sibling_categories")
	_expect(int(manifest.get("sibling_index_min", -1)) == 0 and int(manifest.get("sibling_index_max", -1)) == 7, "sibling_bound")
	var outcomes: Array = manifest.get("allowed_outcomes", [])
	_expect(outcomes.size() == 5, "outcome_cardinality")
	var expected_outcomes: Array = [
		["MISSING_CLEAN", "PRODUCTION_PROFILE_READY", "MAIN_MENU"],
		["LOADED", "PRODUCTION_PROFILE_READY", "MAIN_MENU"],
		["SANITIZED_PENDING_RECOVERY", "PRODUCTION_PROFILE_READY", "MAIN_MENU"],
		["RECOVERY_REQUIRED_READ_ONLY", "FAILED_RECOVERY_REQUIRED_READ_ONLY", "SAFE_ERROR"],
		["UNSUPPORTED_VERSION_READ_ONLY", "FAILED_UNSUPPORTED_VERSION_READ_ONLY", "SAFE_ERROR"],
	]
	for index: int in range(expected_outcomes.size()):
		var entry: Dictionary = outcomes[index] if index < outcomes.size() and outcomes[index] is Dictionary else {}
		_expect([entry.get("load_status", ""), entry.get("boot_status", ""), entry.get("route", "")] == expected_outcomes[index], "outcome_%d" % index)
	var allowed: Array = manifest.get("allowed_retained_fields", [])
	for field: String in ["target_exists_before", "target_exists_after", "length_before", "length_after", "last_write_time_utc_before", "last_write_time_utc_after", "load_status", "boot_status", "route", "completed_count", "best_turn_count", "unlocked_count", "public_progress_key_count", "native_exit", "stderr_byte_count"]:
		_expect(allowed.has(field), "allowed_" + field)
	var forbidden: Array = manifest.get("forbidden_disclosure_categories", [])
	for category: String in ["profile_content", "content_hash", "completed_level_ids", "best_turn_values", "settings_values", "ordinary_absolute_user_data_path", "ordinary_absolute_profile_path", "sibling_filenames", "raw_filesystem_errors", "store_objects", "adapter_objects"]:
		_expect(forbidden.has(category), "forbidden_" + category)
	_expect(manifest.get("required_evidence_files", []) == ["stdout.txt", "stderr.txt", "audit.json"], "evidence_inventory")
	var markers: Dictionary = manifest.get("expected_markers", {})
	_expect(markers.size() == 2 and int(markers.get("observation_started", 0)) == 1 and int(markers.get("observation_pass", 0)) == 1, "marker_cardinality")


func _validate_guards(manifest: Dictionary, observation: String, runner: String) -> void:
	var initialize: String = _function_block(observation, "func _initialize", "func _run_authorized_observation")
	_expect(observation.contains('const AUTH_ENV: String = "' + str(manifest.get("child_environment_name", "")) + '"') and initialize.contains("OS.get_environment(AUTH_ENV)"), "observation_env_guard")
	_expect(observation.contains('const AUTH_VALUE: String = "' + str(manifest.get("child_environment_value", "")) + '"') and initialize.contains("== AUTH_VALUE"), "observation_env_value")
	_expect(observation.contains('const AUTH_ARGUMENT: String = "' + str(manifest.get("engine_user_argument", "")) + '"') and initialize.contains("PackedStringArray([AUTH_ARGUMENT])"), "observation_argument_guard")
	_expect(initialize.contains("OS.get_environment") and initialize.contains("OS.get_cmdline_user_args"), "dual_child_guard_calls")
	_expect(initialize.contains("TASK_0023ZU_CONTROLLED_PRODUCTION_READ_ONLY_GUARD_BLOCKED"), "bounded_blocked_marker")
	_expect(observation.count("TASK_0023ZU_CONTROLLED_PRODUCTION_READ_ONLY_GUARD_BLOCKED") == 1, "one_blocked_marker_source")
	_expect(initialize.contains("quit(2)"), "blocked_exit_two")
	_expect(not initialize.contains("load(") and not initialize.contains("instantiate") and not initialize.contains("FileAccess") and not initialize.contains("DirAccess") and not initialize.contains("globalize_path") and not initialize.contains("get_user_data_dir") and not initialize.contains("configure_boot_policy"), "no_pre_guard_operation")
	var owner_check: int = runner.find("if ($OwnerAuthorization -cne $ExpectedAuthorization)")
	var current_read: int = runner.find("[IO.File]::ReadAllText($CurrentAuthorityPath)")
	var ordinary_discovery: int = runner.find("$OrdinaryUserDataRoot =")
	var process_start: int = runner.find("$process.Start()")
	_expect(owner_check >= 0 and owner_check < current_read, "owner_before_current")
	_expect(current_read >= 0 and current_read < ordinary_discovery, "current_before_discovery")
	_expect(ordinary_discovery >= 0 and ordinary_discovery < process_start, "discovery_before_single_process")
	_expect(runner.contains("$RequiredTaskLine = '# Task 0023ZU'"), "exact_current_task")
	_expect(runner.contains("OWNER_AUTHORIZED_CONTROLLED_PRODUCTION_READ_ONLY_EXECUTION"), "exact_current_status")


func _validate_observation(observation: String) -> void:
	_expect(observation.contains('configure_boot_policy("PRODUCTION_READ_ONLY")'), "read_only_policy")
	_expect(not observation.contains("PRODUCTION_WRITE_ON_INTENT"), "no_write_policy")
	_expect(observation.count("get_root().add_child(bootstrap)") == 1, "one_composition_root")
	_expect(observation.contains("range(3)"), "bounded_frames")
	_expect(observation.contains("get_profile_session_snapshot()") and observation.contains("get_progress_snapshot()") and observation.contains("get_current_route()"), "bounded_snapshots")
	_expect(not observation.contains("configure_test") and not observation.contains("configure_test_profile") and not observation.contains("persist") and not observation.contains("reset") and not observation.contains("failure_seam"), "no_forbidden_behavior")
	_expect(not observation.contains("OS.get_user_data_dir") and not observation.contains("ProjectSettings.globalize_path") and not observation.contains("FileAccess") and not observation.contains("DirAccess"), "no_filesystem_behavior")
	_expect(observation.contains("progress.keys().size() == 3"), "exact_progress_keys")
	_expect(not observation.contains("JSON.stringify") and not observation.contains("print(progress") and not observation.contains("print(session"), "no_raw_objects")
	_expect(observation.count("TASK_0023ZU_CONTROLLED_PRODUCTION_READ_ONLY_OBSERVATION_PASS") == 1, "one_pass_marker")


func _validate_runner(runner: String) -> void:
	_expect(runner.contains("[System.Diagnostics.ProcessStartInfo]::new()"), "process_start_info")
	_expect(runner.contains("$psi.FileName = $GodotExe"), "filename_binding")
	_expect(runner.contains("$psi.ArgumentList.Add([string]$argument)"), "argument_list")
	_expect(not runner.contains(".Arguments =") and not runner.contains("Start-Process") and not runner.contains("Invoke-Expression") and not runner.contains("cmd /c"), "no_flattened_shell")
	_expect(runner.count("$process.Start()") == 1, "one_process_start")
	_expect(runner.contains("$psi.EnvironmentVariables[$ChildGuardName] = $ExpectedAuthorization"), "child_environment_only")
	_expect(not runner.contains("SetEnvironmentVariable") and not runner.contains("setx") and not runner.contains("$env:APPDATA =") and not runner.contains("$env:LOCALAPPDATA ="), "no_environment_override")
	_expect(runner.contains("for ($index = 0; $index -le 7; $index++)"), "eight_indices")
	_expect(runner.contains("@('recovery', 'activation_backup', 'temp', 'transaction')"), "four_categories")
	_expect(runner.contains(".delayed_self_profile_") and runner.contains("Test-Path -LiteralPath $candidate -PathType Leaf"), "direct_exact_sibling_checks")
	_expect(not runner.contains("Get-ChildItem") and not runner.contains("-Recurse") and not runner.contains("-Filter") and not runner.contains("-Include"), "no_enumeration_or_glob")
	_expect(not runner.contains("Remove-Item") and not runner.contains("Move-Item") and not runner.contains("Copy-Item") and not runner.contains("Rename-Item") and not runner.contains("restore") and not runner.contains("cleanup"), "no_cleanup_or_restore")
	_expect(runner.contains("$metadataEqual") and runner.contains("$siblingsEqual"), "pre_post_equality")
	_expect(runner.contains("$nativeExit -eq 0") and runner.contains("$stderrBytes -eq 0"), "native_exit_and_stderr")
	_expect(runner.contains("Test-NoDisclosure") and not runner.contains("Write-Output $stdout") and not runner.contains("Write-Host $stdout"), "bounded_retention")
	_expect(runner.contains("Get-Process -Name 'godot*'") and runner.contains("-eq 0"), "residue_check")
	_expect(runner.contains("D:\\Delayed_Self_Evidence\\0023ZU_controlled_production_read_only"), "fixed_future_root")


func _validate_frozen(manifest: Dictionary) -> void:
	var frozen: Dictionary = manifest.get("frozen_sha256", {})
	_expect(frozen.size() == 14, "frozen_cardinality")
	for path_value: Variant in frozen.keys():
		var path: String = str(path_value)
		_expect(FileAccess.file_exists(path), "frozen_exists")
		_expect(FileAccess.get_sha256(path) == str(frozen.get(path, "")), "frozen_hash")
	var project: String = _read_text("res://project.godot")
	_expect(project.contains('run/main_scene="res://scenes/app/app_root.tscn"'), "main_scene")
	_expect(not project.contains("[autoload]"), "no_autoload")


func _function_block(source: String, start_marker: String, end_marker: String) -> String:
	var start: int = source.find(start_marker)
	var finish: int = source.find(end_marker, start + start_marker.length())
	if start < 0 or finish < 0:
		return ""
	return source.substr(start, finish - start)


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
		print("TASK_0023ZT_VALIDATOR_ASSERT_FAIL label=" + label)

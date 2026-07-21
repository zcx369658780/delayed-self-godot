extends SceneTree

const CaseScript = preload("res://tests/app/task_0023zq_isolated_production_policy_case.gd")
const ValidatorScript = preload("res://tests/app/task_0023zq_isolated_production_policy_validator.gd")
const BootstrapScript = preload("res://scripts/app/app_bootstrap.gd")
const AppRootScript = preload("res://scripts/app/app_root.gd")
const LocalProfile = preload("res://scripts/app/local_profile.gd")
const ProfileCodec = preload("res://scripts/app/profile_codec.gd")


func _initialize() -> void:
	call_deferred("_run")


func _run() -> void:
	var manifest_path: String = "res://tests/app/task_0023zq_isolated_production_policy_manifest.json"
	var runner_path: String = "res://tests/app/task_0023zq_capture_isolated_production_policy.ps1"
	var ok: bool = (
		CaseScript != null
		and ValidatorScript != null
		and BootstrapScript != null
		and AppRootScript != null
		and LocalProfile != null
		and ProfileCodec != null
		and FileAccess.file_exists(manifest_path)
		and FileAccess.file_exists(runner_path)
		and JSON.parse_string(_read_text(manifest_path)) is Dictionary
		and not _read_text(runner_path).is_empty()
	)
	if not ok:
		quit(1)
		return
	print("TASK_0023ZQ_ISOLATED_PRODUCTION_POLICY_PARSER_SMOKE_PASS")
	quit(0)


func _read_text(path: String) -> String:
	var file: FileAccess = FileAccess.open(path, FileAccess.READ)
	if file == null:
		return ""
	var text: String = file.get_as_text()
	file.close()
	return text

extends SceneTree

const ObservationScript = preload("res://tests/app/task_0023zt_controlled_production_read_only_observation.gd")
const ValidatorScript = preload("res://tests/app/task_0023zt_controlled_production_read_only_validator.gd")
const BootstrapScript = preload("res://scripts/app/app_bootstrap.gd")
const AppRootScript = preload("res://scripts/app/app_root.gd")
const LocalProfileScript = preload("res://scripts/app/local_profile.gd")
const CodecScript = preload("res://scripts/app/profile_codec.gd")
const AdapterScript = preload("res://scripts/app/profile_progress_adapter.gd")


func _initialize() -> void:
	call_deferred("_run")


func _run() -> void:
	var manifest_path: String = "res://tests/app/task_0023zt_controlled_production_read_only_manifest.json"
	var runner_path: String = "res://tests/app/task_0023zt_capture_controlled_production_read_only.ps1"
	var manifest: Variant = JSON.parse_string(_read_text(manifest_path))
	var ok: bool = (
		ObservationScript != null
		and ValidatorScript != null
		and BootstrapScript != null
		and AppRootScript != null
		and LocalProfileScript != null
		and CodecScript != null
		and AdapterScript != null
		and manifest is Dictionary
		and not _read_text(runner_path).is_empty()
	)
	if not ok:
		quit(1)
		return
	print("TASK_0023ZT_CONTROLLED_PRODUCTION_READ_ONLY_PARSER_SMOKE_PASS")
	quit(0)


func _read_text(path: String) -> String:
	var file: FileAccess = FileAccess.open(path, FileAccess.READ)
	if file == null:
		return ""
	var text: String = file.get_as_text()
	file.close()
	return text

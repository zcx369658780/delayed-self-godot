extends SceneTree

const BootstrapScript = preload("res://scripts/app/app_bootstrap.gd")
const BootstrapScene = preload("res://scenes/app/app_bootstrap.tscn")
const AppRootScript = preload("res://scripts/app/app_root.gd")
const LocalProfile = preload("res://scripts/app/local_profile.gd")
const ProfileCodec = preload("res://scripts/app/profile_codec.gd")


func _initialize() -> void:
	call_deferred("_run")


func _run() -> void:
	if BootstrapScript == null or BootstrapScene == null or AppRootScript == null or LocalProfile == null or ProfileCodec == null:
		quit(1)
		return
	var supported: Dictionary = ProfileCodec.classify_profile_schema({"profile_schema_version": 1})
	var unsupported: Dictionary = ProfileCodec.classify_profile_schema({"profile_schema_version": 2})
	var invalid: Dictionary = ProfileCodec.classify_profile_schema({})
	var bootstrap: Node = BootstrapScene.instantiate()
	var normal: Dictionary = bootstrap.preview_effective_policy(PackedStringArray())
	var direct: Dictionary = bootstrap.preview_effective_policy(PackedStringArray(["--level-id=tutorial_reach_exit"]))
	var main_scene: String = str(ProjectSettings.get_setting("application/run/main_scene", ""))
	var ok: bool = (
		str(supported.get("status", "")) == "PROFILE_VERSION_SUPPORTED"
		and str(unsupported.get("status", "")) == "PROFILE_VERSION_UNSUPPORTED"
		and str(invalid.get("status", "")) == "PROFILE_VERSION_INVALID"
		and str(normal.get("effective_policy", "")) == BootstrapScript.MEMORY_ONLY
		and str(direct.get("effective_policy", "")) == BootstrapScript.MEMORY_ONLY
		and main_scene == "res://scenes/app/app_root.tscn"
	)
	bootstrap.free()
	if not ok:
		quit(1)
		return
	print("TASK_0023ZP_PRODUCTION_ACTIVATION_COMPILE_SMOKE_PASS")
	quit(0)

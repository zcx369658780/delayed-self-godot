extends SceneTree

const LocalProfileScript = preload("res://scripts/app/local_profile.gd")


func _init() -> void:
	var catalog_facts: Dictionary = {"level_ids": ["alpha"], "prerequisites": {"alpha": []}}
	var path_result: Dictionary = LocalProfileScript.build_test_profile_path("InstanceCompile")
	var store: RefCounted = LocalProfileScript.new()
	var configured: Dictionary = store.configure_test(catalog_facts, str(path_result.get("path", "")))
	if bool(configured.get("ok", false)) and store.is_configured():
		print("TASK_0023V_PROFILE_STORE_INSTANCE_COMPILE_SMOKE_PASS")
		quit(0)
		return
	printerr("TASK_0023V_PROFILE_STORE_INSTANCE_COMPILE_SMOKE_FAIL")
	quit(1)

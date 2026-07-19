extends SceneTree

const LocalProfileScript = preload("res://scripts/app/local_profile.gd")


func _init() -> void:
	var store: RefCounted = LocalProfileScript.new()
	var catalog_facts: Dictionary = {
		"level_ids": ["alpha"],
		"prerequisites": {"alpha": []},
	}
	var built: Dictionary = LocalProfileScript.build_test_profile_path("task_0023w_profile_filesystem_store")
	var configured: Dictionary = store.configure_test(catalog_facts, str(built.get("path", "")))
	var unconfigured: RefCounted = LocalProfileScript.new()
	var load_result: Dictionary = unconfigured.load_profile()
	var persist_result: Dictionary = unconfigured.persist_profile({})
	var reset_result: Dictionary = unconfigured.reset_test_profile()
	var committed_result: Dictionary = unconfigured.get_committed_profile()
	var seam_result: Dictionary = unconfigured.set_test_failure_seam("NONE")
	if not bool(configured.get("ok", false)) or load_result.is_empty() or persist_result.is_empty() or reset_result.is_empty() or committed_result.is_empty() or seam_result.is_empty():
		printerr("TASK_0023W_PROFILE_STORE_COMPILE_SMOKE_FAIL")
		quit(1)
		return
	print("TASK_0023W_PROFILE_STORE_COMPILE_SMOKE_PASS")
	quit(0)

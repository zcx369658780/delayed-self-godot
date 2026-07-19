extends SceneTree

const AdapterScript = preload("res://scripts/app/profile_progress_adapter.gd")
const ProfileCodec = preload("res://scripts/app/profile_codec.gd")
const MemoryProgressScript = preload("res://scripts/app/memory_progress.gd")


func _init() -> void:
	var adapter: RefCounted = AdapterScript.new()
	var catalog: Dictionary = {"entries": [{"level_id": "alpha", "unlock_prerequisites": []}]}
	var configured: Dictionary = adapter.configure(catalog)
	var default_profile: Dictionary = ProfileCodec.default_profile().get("profile", {})
	var loaded: Dictionary = adapter.load_profile(default_profile)
	var prepared: Dictionary = adapter.prepare_completion("alpha", 1)
	var committed: Dictionary = adapter.commit_profile(prepared.get("profile", default_profile))
	var reset: Dictionary = adapter.reset_to_default()
	var state: Dictionary = adapter.snapshot()
	var profile: Dictionary = adapter.get_profile_snapshot()
	var runtime: RefCounted = MemoryProgressScript.new(catalog)
	if not bool(configured.get("ok", false)) or loaded.is_empty() or committed.is_empty() or reset.is_empty() or state.is_empty() or profile.is_empty() or runtime.snapshot().is_empty():
		printerr("TASK_0023X_PROFILE_MEMORY_PROGRESS_ADAPTER_COMPILE_SMOKE_FAIL")
		quit(1)
		return
	print("TASK_0023X_PROFILE_MEMORY_PROGRESS_ADAPTER_COMPILE_SMOKE_PASS")
	quit(0)

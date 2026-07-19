extends SceneTree

const LocalProfile = preload("res://scripts/app/local_profile.gd")
const ProfileCodec = preload("res://scripts/app/profile_codec.gd")


func _init() -> void:
	var catalog_facts: Dictionary = {
		"level_ids": ["one"],
		"prerequisites": {"one": []},
	}
	var defaults: Dictionary = ProfileCodec.default_profile()
	var normalized: Dictionary = ProfileCodec.normalize_profile(defaults.get("profile", {}), catalog_facts)
	var serialized: Dictionary = ProfileCodec.serialize_profile(normalized.get("profile", {}))
	if not defaults.get("ok", false) or not normalized.get("ok", false) or not serialized.get("ok", false):
		printerr("TASK_0023T_PROFILE_CODEC_COMPILE_SMOKE_FAIL")
		quit(1)
		return
	if LocalProfile.validate_test_profile_path("user://delayed_self_test_profiles/a/delayed_self_profile.json").ok:
		print("TASK_0023T_PROFILE_CODEC_COMPILE_SMOKE_PASS")
		quit(0)
		return
	printerr("TASK_0023T_PROFILE_CODEC_COMPILE_SMOKE_FAIL")
	quit(1)

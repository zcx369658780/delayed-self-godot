extends SceneTree

const LocalProfile = preload("res://scripts/app/local_profile.gd")
const ProfileCodec = preload("res://scripts/app/profile_codec.gd")

var assertions: int = 0
var failures: int = 0
var catalog_facts: Dictionary = {
	"level_ids": ["alpha", "beta", "gamma"],
	"prerequisites": {
		"alpha": [],
		"beta": ["alpha"],
		"gamma": ["beta"],
	},
}


func _init() -> void:
	_test_defaults()
	_test_normalization()
	_test_rejections()
	_test_serialization()
	_test_candidates()
	_test_path_policy()
	print("TASK_0023T_ASSERTIONS=%d" % assertions)
	if failures > 0:
		printerr("TASK_0023T_PURE_PROFILE_CODEC_FAIL failures=%d" % failures)
		quit(1)
		return
	print("TASK_0023T_PURE_PROFILE_CODEC_TESTS_PASS")
	quit(0)


func _test_defaults() -> void:
	var first: Dictionary = ProfileCodec.default_profile()
	var second: Dictionary = ProfileCodec.default_profile()
	_expect(bool(first.get("ok", false)), "default profile is structured success")
	_expect(first.get("profile", {}) == {"profile_schema_version": 1, "progress": {"completed_level_ids": [], "best_turns": {}}, "settings": {"language": "en", "window_mode": "windowed", "reduced_motion": false}}, "default profile has exact v1 values")
	var first_profile: Dictionary = first.get("profile", {})
	var first_progress: Dictionary = first_profile.get("progress", {})
	var first_completed: Array = first_progress.get("completed_level_ids", [])
	first_completed.append("mutated")
	_expect(not (second.get("profile", {}) as Dictionary).get("progress", {}).get("completed_level_ids", []).has("mutated"), "defaults do not share mutable arrays")


func _test_normalization() -> void:
	var raw: Dictionary = {
		"profile_schema_version": 1,
		"progress": {
			"completed_level_ids": ["gamma", "alpha", "alpha", "unknown", "beta"],
			"best_turns": {"gamma": 9, "beta": 0, "alpha": 5, "unknown": 2},
		},
		"settings": {"language": "zh-Hans", "window_mode": "fullscreen", "reduced_motion": true},
	}
	var raw_before: Dictionary = raw.duplicate(true)
	var normalized: Dictionary = ProfileCodec.normalize_profile(raw, catalog_facts)
	_expect(bool(normalized.get("ok", false)), "valid containers normalize")
	_expect(bool(normalized.get("sanitized", false)), "invalid individual entries are marked sanitized")
	var profile: Dictionary = normalized.get("profile", {})
	_expect(profile.get("progress", {}).get("completed_level_ids", []) == ["alpha", "beta", "gamma"], "known prerequisite-closed IDs are sorted")
	_expect(profile.get("progress", {}).get("best_turns", {}) == {"alpha": 5, "gamma": 9}, "invalid best turns are removed")
	_expect(profile.get("settings", {}) == {"language": "zh-Hans", "window_mode": "fullscreen", "reduced_motion": true}, "valid settings remain")
	_expect(raw == raw_before, "normalization does not mutate input")
	var inconsistent: Dictionary = raw.duplicate(true)
	inconsistent["progress"]["completed_level_ids"] = ["gamma"]
	inconsistent["progress"]["best_turns"] = {"gamma": 3}
	var inconsistent_result: Dictionary = ProfileCodec.normalize_profile(inconsistent, catalog_facts)
	_expect((inconsistent_result.get("profile", {}) as Dictionary).get("progress", {}).get("completed_level_ids", []).is_empty(), "prerequisite-inconsistent completion is iteratively removed")
	var invalid_settings: Dictionary = raw.duplicate(true)
	invalid_settings["settings"] = {"language": "fr", "window_mode": "borderless", "reduced_motion": "no"}
	var settings_result: Dictionary = ProfileCodec.normalize_profile(invalid_settings, catalog_facts)
	_expect((settings_result.get("profile", {}) as Dictionary).get("settings", {}) == {"language": "en", "window_mode": "windowed", "reduced_motion": false}, "invalid settings default independently")


func _test_rejections() -> void:
	for value: Variant in [null, [], "text", {"profile_schema_version": 2, "progress": {}, "settings": {}}, {"profile_schema_version": 1, "progress": [], "settings": {}}]:
		var result: Dictionary = ProfileCodec.normalize_profile(value, catalog_facts)
		_expect(not bool(result.get("ok", false)) and result.has("status"), "wrong root/version/container rejects structurally")
	var bad_catalog: Dictionary = {"level_ids": ["alpha"], "prerequisites": {"alpha": ["missing"]}}
	var default_result: Dictionary = ProfileCodec.default_profile()
	var catalog_result: Dictionary = ProfileCodec.normalize_profile(default_result.get("profile", {}), bad_catalog)
	_expect(not bool(catalog_result.get("ok", false)), "invalid catalog facts reject without profile invention")


func _test_serialization() -> void:
	var profile: Dictionary = {
		"profile_schema_version": 1,
		"progress": {"completed_level_ids": ["gamma", "alpha", "beta"], "best_turns": {"gamma": 8, "alpha": 3, "beta": 4}},
		"settings": {"language": "en", "window_mode": "windowed", "reduced_motion": false},
	}
	var first: Dictionary = ProfileCodec.serialize_profile(profile)
	var second: Dictionary = ProfileCodec.serialize_profile(profile.duplicate(true))
	_expect(bool(first.get("ok", false)) and first.get("json", "") == second.get("json", ""), "equivalent profiles serialize byte-identically")
	var json_text: String = str(first.get("json", ""))
	_expect(json_text.find("\"alpha\"") < json_text.find("\"beta\"") and json_text.find("\"beta\"") < json_text.find("\"gamma\""), "serialized IDs and best-turn keys have stable sorted order")
	_expect(not bool(ProfileCodec.serialize_profile({}).get("ok", false)), "invalid shape cannot serialize")


func _test_candidates() -> void:
	var initial_result: Dictionary = ProfileCodec.default_profile()
	var initial: Dictionary = initial_result.get("profile", {})
	var initial_before: Dictionary = initial.duplicate(true)
	var unknown: Dictionary = ProfileCodec.build_progress_candidate(initial, "unknown", 1, catalog_facts)
	_expect(not bool(unknown.get("ok", false)) and unknown.get("status", "") == "PROGRESS_REJECTED", "unknown level rejects")
	var locked: Dictionary = ProfileCodec.build_progress_candidate(initial, "beta", 1, catalog_facts)
	_expect(not bool(locked.get("ok", false)), "locked level rejects")
	var invalid_turns: Dictionary = ProfileCodec.build_progress_candidate(initial, "alpha", 0, catalog_facts)
	_expect(not bool(invalid_turns.get("ok", false)), "non-positive turns reject")
	var first: Dictionary = ProfileCodec.build_progress_candidate(initial, "alpha", 7, catalog_facts)
	_expect(bool(first.get("ok", false)) and first.get("status", "") == "CANDIDATE_READY", "first completion creates a candidate")
	_expect(initial == initial_before, "candidate build does not mutate committed input")
	var first_profile: Dictionary = first.get("profile", {})
	var no_change: Dictionary = ProfileCodec.build_progress_candidate(first_profile, "alpha", 7, catalog_facts)
	_expect(bool(no_change.get("ok", false)) and no_change.get("status", "") == "NO_CHANGE", "equal best turn is no change")
	var higher: Dictionary = ProfileCodec.build_progress_candidate(first_profile, "alpha", 8, catalog_facts)
	_expect(higher.get("status", "") == "NO_CHANGE", "higher best turn is no change")
	var lower: Dictionary = ProfileCodec.build_progress_candidate(first_profile, "alpha", 5, catalog_facts)
	_expect(lower.get("status", "") == "CANDIDATE_READY", "lower best turn creates a candidate")
	_expect((lower.get("profile", {}) as Dictionary).get("progress", {}).get("best_turns", {}).get("alpha", -1) == 5, "better turn is retained")
	var beta: Dictionary = ProfileCodec.build_progress_candidate(first_profile, "beta", 6, catalog_facts)
	_expect(beta.get("status", "") == "CANDIDATE_READY", "unlocked successor creates a candidate")
	var repeat: Dictionary = ProfileCodec.build_progress_candidate(initial, "alpha", 7, catalog_facts)
	_expect(first == repeat, "candidate calls are deterministic")


func _test_path_policy() -> void:
	var built: Dictionary = LocalProfile.build_test_profile_path("A-Z_09")
	var valid: Dictionary = LocalProfile.validate_test_profile_path(str(built.get("path", "")))
	var rejected: Dictionary = LocalProfile.validate_test_profile_path(LocalProfile.PRODUCTION_PROFILE_PATH)
	_expect(bool(built.get("ok", false)) and bool(valid.get("ok", false)), "accepted 0023R builder and validator semantics remain exact")
	_expect(not bool(rejected.get("ok", false)) and not rejected.has("path"), "production path remains a no-path rejection")
	_expect(built == LocalProfile.build_test_profile_path("A-Z_09"), "path builder remains deterministic")


func _expect(condition: bool, label: String) -> void:
	assertions += 1
	if not condition:
		failures += 1
		printerr("TEST_FAIL: " + label)

class_name DelayedSelfProfileCodec
extends RefCounted

const PROFILE_SCHEMA_VERSION: int = 1
const DEFAULT_LANGUAGE: String = "en"
const DEFAULT_WINDOW_MODE: String = "windowed"
const DEFAULT_REDUCED_MOTION: bool = false
const VALID_LANGUAGES: Array[String] = ["en", "zh-Hans"]
const VALID_WINDOW_MODES: Array[String] = ["windowed", "fullscreen"]


static func classify_profile_schema(raw_value: Variant) -> Dictionary:
	if not raw_value is Dictionary:
		return {"status": "PROFILE_ROOT_INVALID"}
	var root: Dictionary = raw_value
	var version_value: Variant = root.get("profile_schema_version", null)
	if not version_value is int:
		return {"status": "PROFILE_VERSION_INVALID"}
	if int(version_value) == PROFILE_SCHEMA_VERSION:
		return {"status": "PROFILE_VERSION_SUPPORTED"}
	return {"status": "PROFILE_VERSION_UNSUPPORTED"}


static func default_profile() -> Dictionary:
	return {
		"ok": true,
		"status": "DEFAULT_PROFILE",
		"profile": _canonical_profile([], {}, _default_settings()),
	}


static func normalize_profile(raw_value: Variant, catalog_facts: Dictionary) -> Dictionary:
	var catalog_result: Dictionary = _catalog_maps(catalog_facts)
	if not bool(catalog_result.get("ok", false)):
		return _rejected("CATALOG_FACTS_INVALID")
	if not raw_value is Dictionary:
		return _rejected("PROFILE_ROOT_INVALID")
	var root: Dictionary = raw_value
	var version_value: Variant = root.get("profile_schema_version", null)
	var progress_value: Variant = root.get("progress", null)
	var settings_value: Variant = root.get("settings", null)
	if (
		not version_value is int
		or int(version_value) != PROFILE_SCHEMA_VERSION
		or not progress_value is Dictionary
		or not settings_value is Dictionary
	):
		return _rejected("PROFILE_STRUCTURE_INVALID")
	var progress: Dictionary = progress_value
	var settings: Dictionary = settings_value
	var completed_value: Variant = progress.get("completed_level_ids", null)
	var best_turns_value: Variant = progress.get("best_turns", null)
	if not completed_value is Array or not best_turns_value is Dictionary:
		return _rejected("PROFILE_PROGRESS_INVALID")
	var raw_completed: Array = completed_value
	var raw_best_turns: Dictionary = best_turns_value
	var known: Dictionary = catalog_result.get("known", {})
	var prerequisites: Dictionary = catalog_result.get("prerequisites", {})
	var sanitized: bool = root.size() != 3 or progress.size() != 2 or settings.size() != 3
	var completed: Dictionary = {}
	for raw_id_value: Variant in raw_completed:
		if not raw_id_value is String:
			sanitized = true
			continue
		var level_id: String = raw_id_value
		if not known.has(level_id) or completed.has(level_id):
			sanitized = true
			continue
		completed[level_id] = true
	var removed: bool = true
	while removed:
		removed = false
		var retained_ids: Array = completed.keys()
		for retained_value: Variant in retained_ids:
			var retained_id: String = str(retained_value)
			var prerequisite_values: Array = prerequisites.get(retained_id, [])
			for prerequisite_value: Variant in prerequisite_values:
				var prerequisite_id: String = str(prerequisite_value)
				if not completed.has(prerequisite_id):
					completed.erase(retained_id)
					sanitized = true
					removed = true
					break
	var completed_ids: Array = completed.keys()
	completed_ids.sort()
	var best_turns: Dictionary = {}
	var raw_best_ids: Array = raw_best_turns.keys()
	raw_best_ids.sort()
	for best_id_value: Variant in raw_best_ids:
		if not best_id_value is String:
			sanitized = true
			continue
		var best_id: String = best_id_value
		var turns_value: Variant = raw_best_turns.get(best_id, null)
		if not completed.has(best_id) or not turns_value is int or int(turns_value) < 1:
			sanitized = true
			continue
		best_turns[best_id] = int(turns_value)
	var normalized_settings_result: Dictionary = _normalize_settings(settings)
	var normalized_settings: Dictionary = normalized_settings_result.get("settings", _default_settings())
	if bool(normalized_settings_result.get("sanitized", false)):
		sanitized = true
	return {
		"ok": true,
		"status": "SANITIZED" if sanitized else "NORMALIZED",
		"sanitized": sanitized,
		"profile": _canonical_profile(completed_ids, best_turns, normalized_settings),
	}


static func serialize_profile(profile: Dictionary) -> Dictionary:
	var shape_result: Dictionary = _canonicalize_profile_shape(profile)
	if not bool(shape_result.get("ok", false)):
		return _rejected("PROFILE_SERIALIZATION_REJECTED")
	var canonical_profile: Dictionary = shape_result.get("profile", {})
	var json_text: String = JSON.stringify(canonical_profile)
	return {
		"ok": true,
		"status": "SERIALIZED",
		"profile": canonical_profile,
		"json": json_text,
	}


static func build_progress_candidate(current_profile: Dictionary, level_id: String, turns: int, catalog_facts: Dictionary) -> Dictionary:
	var normalized: Dictionary = normalize_profile(current_profile, catalog_facts)
	if not bool(normalized.get("ok", false)):
		return _rejected("PROGRESS_REJECTED")
	var catalog_result: Dictionary = _catalog_maps(catalog_facts)
	if not bool(catalog_result.get("ok", false)) or turns < 1 or not catalog_result.get("known", {}).has(level_id):
		return _rejected("PROGRESS_REJECTED")
	var normalized_profile: Dictionary = normalized.get("profile", {})
	var candidate: Dictionary = normalized_profile.duplicate(true)
	var candidate_progress: Dictionary = candidate.get("progress", {})
	var candidate_completed: Array = candidate_progress.get("completed_level_ids", []).duplicate()
	var candidate_best_turns: Dictionary = candidate_progress.get("best_turns", {}).duplicate(true)
	var already_completed: bool = candidate_completed.has(level_id)
	if not already_completed:
		var prerequisites: Dictionary = catalog_result.get("prerequisites", {})
		var needed: Array = prerequisites.get(level_id, [])
		for prerequisite_value: Variant in needed:
			var prerequisite_id: String = str(prerequisite_value)
			if not candidate_completed.has(prerequisite_id):
				return _rejected("PROGRESS_REJECTED")
		candidate_completed.append(level_id)
		candidate_completed.sort()
	var best_value: Variant = candidate_best_turns.get(level_id, null)
	if already_completed and best_value is int and turns >= int(best_value):
		return {
			"ok": true,
			"status": "NO_CHANGE",
			"profile": normalized_profile,
		}
	candidate_best_turns[level_id] = turns
	candidate_progress["completed_level_ids"] = candidate_completed
	candidate_progress["best_turns"] = candidate_best_turns
	var serialized: Dictionary = serialize_profile(candidate)
	if not bool(serialized.get("ok", false)):
		return _rejected("PROGRESS_REJECTED")
	return {
		"ok": true,
		"status": "CANDIDATE_READY",
		"profile": serialized.get("profile", {}),
	}


static func _catalog_maps(catalog_facts: Dictionary) -> Dictionary:
	var level_ids_value: Variant = catalog_facts.get("level_ids", null)
	var prerequisites_value: Variant = catalog_facts.get("prerequisites", null)
	if not level_ids_value is Array or not prerequisites_value is Dictionary:
		return _rejected("CATALOG_FACTS_INVALID")
	var level_ids: Array = level_ids_value
	var supplied_prerequisites: Dictionary = prerequisites_value
	var known: Dictionary = {}
	for raw_id_value: Variant in level_ids:
		if not raw_id_value is String:
			return _rejected("CATALOG_FACTS_INVALID")
		var level_id: String = raw_id_value
		if level_id.is_empty() or known.has(level_id):
			return _rejected("CATALOG_FACTS_INVALID")
		known[level_id] = true
	var prerequisites: Dictionary = {}
	for known_id_value: Variant in known.keys():
		var known_id: String = str(known_id_value)
		var required_value: Variant = supplied_prerequisites.get(known_id, null)
		if not required_value is Array:
			return _rejected("CATALOG_FACTS_INVALID")
		var required_ids: Array = required_value
		var canonical_required: Array = []
		for prerequisite_value: Variant in required_ids:
			if not prerequisite_value is String:
				return _rejected("CATALOG_FACTS_INVALID")
			var prerequisite_id: String = prerequisite_value
			if not known.has(prerequisite_id) or canonical_required.has(prerequisite_id):
				return _rejected("CATALOG_FACTS_INVALID")
			canonical_required.append(prerequisite_id)
		canonical_required.sort()
		prerequisites[known_id] = canonical_required
	return {
		"ok": true,
		"status": "CATALOG_FACTS_READY",
		"known": known,
		"prerequisites": prerequisites,
	}


static func _normalize_settings(settings: Dictionary) -> Dictionary:
	var normalized: Dictionary = _default_settings()
	var sanitized: bool = false
	var language_value: Variant = settings.get("language", null)
	var window_mode_value: Variant = settings.get("window_mode", null)
	var reduced_motion_value: Variant = settings.get("reduced_motion", null)
	if language_value is String and VALID_LANGUAGES.has(language_value):
		normalized["language"] = language_value
	else:
		sanitized = true
	if window_mode_value is String and VALID_WINDOW_MODES.has(window_mode_value):
		normalized["window_mode"] = window_mode_value
	else:
		sanitized = true
	if reduced_motion_value is bool:
		normalized["reduced_motion"] = reduced_motion_value
	else:
		sanitized = true
	return {
		"settings": normalized,
		"sanitized": sanitized,
	}


static func _canonicalize_profile_shape(profile: Dictionary) -> Dictionary:
	var version_value: Variant = profile.get("profile_schema_version", null)
	var progress_value: Variant = profile.get("progress", null)
	var settings_value: Variant = profile.get("settings", null)
	if (
		not version_value is int
		or int(version_value) != PROFILE_SCHEMA_VERSION
		or not progress_value is Dictionary
		or not settings_value is Dictionary
	):
		return _rejected("PROFILE_SERIALIZATION_REJECTED")
	var progress: Dictionary = progress_value
	var settings: Dictionary = settings_value
	var completed_value: Variant = progress.get("completed_level_ids", null)
	var best_turns_value: Variant = progress.get("best_turns", null)
	if not completed_value is Array or not best_turns_value is Dictionary:
		return _rejected("PROFILE_SERIALIZATION_REJECTED")
	var completed: Array = completed_value.duplicate()
	completed.sort()
	var best_turns: Dictionary = best_turns_value
	var ordered_best_turns: Dictionary = {}
	var best_ids: Array = best_turns.keys()
	best_ids.sort()
	for best_id_value: Variant in best_ids:
		if not best_id_value is String:
			return _rejected("PROFILE_SERIALIZATION_REJECTED")
		var best_id: String = best_id_value
		ordered_best_turns[best_id] = best_turns.get(best_id)
	var normalized_settings_result: Dictionary = _normalize_settings(settings)
	if bool(normalized_settings_result.get("sanitized", false)):
		return _rejected("PROFILE_SERIALIZATION_REJECTED")
	var normalized_settings: Dictionary = normalized_settings_result.get("settings", _default_settings())
	return {
		"ok": true,
		"status": "PROFILE_CANONICAL",
		"profile": _canonical_profile(completed, ordered_best_turns, normalized_settings),
	}


static func _canonical_profile(completed_ids: Array, best_turns: Dictionary, settings: Dictionary) -> Dictionary:
	var ordered_completed: Array = completed_ids.duplicate()
	ordered_completed.sort()
	var ordered_best_turns: Dictionary = {}
	var best_ids: Array = best_turns.keys()
	best_ids.sort()
	for best_id_value: Variant in best_ids:
		var best_id: String = str(best_id_value)
		ordered_best_turns[best_id] = best_turns.get(best_id)
	return {
		"profile_schema_version": PROFILE_SCHEMA_VERSION,
		"progress": {
			"completed_level_ids": ordered_completed,
			"best_turns": ordered_best_turns,
		},
		"settings": {
			"language": settings.get("language", DEFAULT_LANGUAGE),
			"window_mode": settings.get("window_mode", DEFAULT_WINDOW_MODE),
			"reduced_motion": settings.get("reduced_motion", DEFAULT_REDUCED_MOTION),
		},
	}


static func _default_settings() -> Dictionary:
	return {
		"language": DEFAULT_LANGUAGE,
		"window_mode": DEFAULT_WINDOW_MODE,
		"reduced_motion": DEFAULT_REDUCED_MOTION,
	}


static func _rejected(status: String) -> Dictionary:
	return {
		"ok": false,
		"status": status,
	}

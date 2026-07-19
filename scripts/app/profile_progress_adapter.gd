class_name DelayedSelfProfileProgressAdapter
extends RefCounted

const ProfileCodec = preload("res://scripts/app/profile_codec.gd")
const MemoryProgressScript = preload("res://scripts/app/memory_progress.gd")

var _configured: bool = false
var _catalog: Dictionary = {}
var _catalog_facts: Dictionary = {}
var _runtime: RefCounted
var _profile: Dictionary = {}
var _has_profile: bool = false


func configure(catalog: Dictionary) -> Dictionary:
	if _configured:
		return _rejected("ALREADY_CONFIGURED")
	var validated: Dictionary = _validate_catalog(catalog)
	if not bool(validated.get("ok", false)):
		return _rejected(str(validated.get("status", "CATALOG_INVALID")))
	_catalog = (validated.get("catalog", {}) as Dictionary).duplicate(true)
	_catalog_facts = (validated.get("facts", {}) as Dictionary).duplicate(true)
	_runtime = MemoryProgressScript.new(_catalog)
	_configured = true
	return {"ok": true, "status": "CONFIGURED", "catalog_facts": _catalog_facts.duplicate(true)}


func is_configured() -> bool:
	return _configured


func load_profile(profile: Dictionary) -> Dictionary:
	if not _configured:
		return _rejected("NOT_CONFIGURED")
	return _normalize_and_apply(profile, "LOADED")


func commit_profile(profile: Dictionary) -> Dictionary:
	if not _configured:
		return _rejected("NOT_CONFIGURED")
	return _normalize_and_apply(profile, "COMMITTED")


func prepare_completion(level_id: String, turns: int) -> Dictionary:
	if not _configured or not _has_profile:
		return _rejected("PROFILE_NOT_READY")
	var candidate: Dictionary = ProfileCodec.build_progress_candidate(_profile, level_id, turns, _catalog_facts)
	if not bool(candidate.get("ok", false)):
		return _rejected(str(candidate.get("status", "PROGRESS_REJECTED")))
	return {"ok": true, "status": str(candidate.get("status", "")), "profile": (candidate.get("profile", {}) as Dictionary).duplicate(true)}


func reset_to_default() -> Dictionary:
	if not _configured:
		return _rejected("NOT_CONFIGURED")
	var default_result: Dictionary = ProfileCodec.default_profile()
	return _normalize_and_apply(default_result.get("profile", {}), "RESET")


func snapshot() -> Dictionary:
	if not _configured:
		return {"configured": false}
	return {"configured": true, "catalog_facts": _catalog_facts.duplicate(true), "runtime": _runtime.snapshot().duplicate(true), "profile_loaded": _has_profile}


func get_profile_snapshot() -> Dictionary:
	if not _configured or not _has_profile:
		return _rejected("PROFILE_NOT_READY")
	return {"ok": true, "status": "PROFILE_SNAPSHOT", "profile": _profile.duplicate(true)}


func is_unlocked(level_id: String) -> bool:
	return _configured and _runtime.is_unlocked(level_id)


func _normalize_and_apply(profile: Dictionary, base_status: String) -> Dictionary:
	var normalized: Dictionary = ProfileCodec.normalize_profile(profile, _catalog_facts)
	if not bool(normalized.get("ok", false)):
		return _rejected(str(normalized.get("status", "PROFILE_REJECTED")))
	var next_profile: Dictionary = (normalized.get("profile", {}) as Dictionary).duplicate(true)
	var progress: Dictionary = next_profile.get("progress", {})
	if not _runtime.replace_profile_progress(progress.get("completed_level_ids", []), progress.get("best_turns", {})):
		return _rejected("RUNTIME_PROGRESS_REJECTED")
	_profile = next_profile
	_has_profile = true
	return {"ok": true, "status": "SANITIZED" if bool(normalized.get("sanitized", false)) else base_status, "profile": _profile.duplicate(true), "runtime": _runtime.snapshot().duplicate(true)}


func _validate_catalog(catalog: Dictionary) -> Dictionary:
	var raw_entries: Variant = catalog.get("entries", null)
	if not raw_entries is Array or raw_entries.is_empty():
		return _rejected("CATALOG_INVALID")
	var entries: Array = raw_entries
	var known: Dictionary = {}
	var copied_entries: Array = []
	for raw_entry: Variant in entries:
		if not raw_entry is Dictionary or not raw_entry.get("level_id") is String or not raw_entry.get("unlock_prerequisites") is Array:
			return _rejected("CATALOG_INVALID")
		var level_id: String = raw_entry["level_id"]
		if level_id.is_empty() or known.has(level_id):
			return _rejected("CATALOG_INVALID")
		known[level_id] = true
		copied_entries.append({"level_id": level_id, "unlock_prerequisites": []})
	var prerequisites: Dictionary = {}
	for entry_value: Variant in entries:
		var entry: Dictionary = entry_value
		var level_id: String = entry["level_id"]
		var copied: Array = []
		for prerequisite_value: Variant in entry["unlock_prerequisites"]:
			if not prerequisite_value is String or prerequisite_value == level_id or not known.has(prerequisite_value) or copied.has(prerequisite_value):
				return _rejected("CATALOG_INVALID")
			copied.append(prerequisite_value)
		copied.sort()
		prerequisites[level_id] = copied
	for copied_entry_value: Variant in copied_entries:
		var copied_entry: Dictionary = copied_entry_value
		copied_entry["unlock_prerequisites"] = (prerequisites[copied_entry["level_id"]] as Array).duplicate()
	var level_ids: Array = known.keys()
	level_ids.sort()
	return {"ok": true, "status": "CATALOG_VALID", "catalog": {"entries": copied_entries}, "facts": {"level_ids": level_ids, "prerequisites": prerequisites}}


func _rejected(status: String) -> Dictionary:
	return {"ok": false, "status": status}

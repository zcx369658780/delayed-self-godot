class_name DelayedSelfMemoryProgress
extends RefCounted

var _prerequisites: Dictionary = {}
var _completed: Dictionary = {}
var _best_turns: Dictionary = {}


func _init(catalog: Dictionary = {}) -> void:
	for entry in catalog.get("entries", []):
		if entry is Dictionary and entry.get("level_id") is String and entry.get("unlock_prerequisites") is Array:
			_prerequisites[entry.level_id] = entry.unlock_prerequisites.duplicate()


func snapshot() -> Dictionary:
	var completed_level_ids: Array = _completed.keys()
	completed_level_ids.sort()
	var unlocked_level_ids: Array = []
	for level_id in _prerequisites.keys():
		if is_unlocked(level_id):
			unlocked_level_ids.append(level_id)
	unlocked_level_ids.sort()
	return {
		"completed_level_ids": completed_level_ids,
		"best_turns": _best_turns.duplicate(true),
		"unlocked_level_ids": unlocked_level_ids,
	}


func is_unlocked(level_id: String) -> bool:
	if not _prerequisites.has(level_id):
		return false
	for prerequisite in _prerequisites[level_id]:
		if not _completed.has(prerequisite):
			return false
	return true


func record_completion(level_id: String, turns: int) -> bool:
	if not _prerequisites.has(level_id) or not is_unlocked(level_id) or turns < 1:
		return false
	_completed[level_id] = true
	if not _best_turns.has(level_id) or turns < int(_best_turns[level_id]):
		_best_turns[level_id] = turns
	return true


func reset_test_profile() -> void:
	_completed.clear()
	_best_turns.clear()


func replace_profile_progress(completed_level_ids: Array, best_turns: Dictionary) -> bool:
	var next_completed: Dictionary = {}
	for value: Variant in completed_level_ids:
		if not value is String:
			return false
		var level_id: String = value
		if level_id.is_empty() or not _prerequisites.has(level_id) or next_completed.has(level_id):
			return false
		next_completed[level_id] = true
	for level_id_value: Variant in next_completed.keys():
		var completed_id: String = str(level_id_value)
		for prerequisite_value: Variant in _prerequisites[completed_id]:
			if not next_completed.has(prerequisite_value):
				return false
	var next_best_turns: Dictionary = {}
	for key: Variant in best_turns.keys():
		if not key is String or not next_completed.has(key):
			return false
		var turns: Variant = best_turns[key]
		if not turns is int or int(turns) < 1:
			return false
		next_best_turns[key] = int(turns)
	_completed = next_completed
	_best_turns = next_best_turns
	return true

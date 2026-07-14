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

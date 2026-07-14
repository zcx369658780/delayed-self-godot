class_name DelayedSelfRouteRequest
extends RefCounted

const ID_PATTERN := "^[a-z][a-z0-9]*(?:_[a-z0-9]+)*$"


static func parse_user_args(arguments: PackedStringArray) -> Dictionary:
	var requested: Array[String] = []
	for argument in arguments:
		if argument.begins_with("--level-id="):
			requested.append(argument.trim_prefix("--level-id="))
	if requested.is_empty():
		return {"ok": true, "status": "NO_DIRECT_LEVEL", "level_id": ""}
	if requested.size() != 1:
		return {"ok": false, "status": "DIRECT_LEVEL_ARGUMENT_DUPLICATE", "level_id": ""}
	var regex := RegEx.new()
	regex.compile(ID_PATTERN)
	if regex.search(requested[0]) == null:
		return {"ok": false, "status": "DIRECT_LEVEL_ARGUMENT_INVALID", "level_id": ""}
	return {"ok": true, "status": "DIRECT_LEVEL_REQUEST", "level_id": requested[0]}

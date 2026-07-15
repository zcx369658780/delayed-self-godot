class_name DelayedSelfTimelineModel
extends RefCounted

const ACTION_GLYPHS := {
	"UP": "↑",
	"RIGHT": "→",
	"DOWN": "↓",
	"LEFT": "←",
	"WAIT": "•",
}


func build(level: Dictionary, state: Dictionary, simulation) -> Dictionary:
	var echoes: Array = level.get("echoes", [])
	if echoes.is_empty():
		return {"visible": false, "max_delay": 0, "slots": [], "echo_pointers": []}
	var history: Array = state.get("history", [])
	var slots: Array = []
	for index in history.size():
		var action := _safe_action(history[index])
		slots.append({
			"history_index": index,
			"slot_number": index + 1,
			"action": action,
			"glyph": ACTION_GLYPHS[action],
			"accessible_label": action,
		})
	var pointers: Array = []
	for echo in echoes:
		var history_index: int = simulation.echo_history_index_for_state(level, state, echo.id)
		var action := _safe_action(history[history_index]) if history_index >= 0 and history_index < history.size() else "WAIT"
		pointers.append({
			"echo_id": echo.id,
			"delay": int(echo.delay),
			"history_index": history_index,
			"slot_number": history_index + 1 if history_index >= 0 else 0,
			"action": action,
			"glyph": ACTION_GLYPHS[action],
		})
	return {"visible": true, "max_delay": history.size(), "slots": slots, "echo_pointers": pointers}


func compact_text(model: Dictionary) -> String:
	if not model.get("visible", false):
		return ""
	var slot_parts := PackedStringArray()
	for slot in model.slots:
		slot_parts.append("[%d %s %s]" % [slot.slot_number, slot.glyph, slot.accessible_label])
	var pointer_parts := PackedStringArray()
	for pointer in model.echo_pointers:
		pointer_parts.append("ECHO d%d → slot %d: %s %s next" % [pointer.delay, pointer.slot_number, pointer.glyph, pointer.action])
	return "TIMELINE  oldest → newest\n%s\n%s" % ["  ".join(slot_parts), "  |  ".join(pointer_parts)]


func expanded_text(model: Dictionary) -> String:
	if not model.get("visible", false):
		return ""
	return "%s\nEach ECHO pointer marks the slot replayed next.\nBlocked moves keep their original action." % compact_text(model)


func _safe_action(value) -> String:
	return value if value is String and ACTION_GLYPHS.has(value) else "WAIT"

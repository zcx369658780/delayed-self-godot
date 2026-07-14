class_name DelayedSelfLevelSelect
extends Control

signal level_selected(level_id: String)
signal back_requested

var _entries: Array = []
var _progress


func configure(entries: Array, progress) -> void:
	_entries = entries.duplicate(true)
	_progress = progress


func _ready() -> void:
	set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	var background := ColorRect.new()
	background.color = Color("101827")
	background.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	add_child(background)
	var panel := VBoxContainer.new()
	panel.name = "LevelEntries"
	panel.position = Vector2(180, 70)
	panel.size = Vector2(600, 410)
	panel.add_theme_constant_override("separation", 12)
	add_child(panel)
	var title := Label.new()
	title.text = "LEVEL SELECT"
	title.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	title.add_theme_font_size_override("font_size", 30)
	panel.add_child(title)
	_entries.sort_custom(func(a, b): return a.sequence < b.sequence)
	for entry in _entries:
		var unlocked: bool = _progress != null and _progress.is_unlocked(entry.level_id)
		var button := Button.new()
		button.name = "Level_" + entry.level_id
		button.text = "%02d  %s%s" % [entry.sequence, entry.formal_title, "" if unlocked else "  [LOCKED: %s]" % ", ".join(entry.unlock_prerequisites)]
		button.disabled = not unlocked
		button.custom_minimum_size = Vector2(0, 56)
		button.pressed.connect(func(): level_selected.emit(entry.level_id))
		panel.add_child(button)
	var back := Button.new()
	back.text = "Back"
	back.custom_minimum_size = Vector2(0, 48)
	back.pressed.connect(func(): back_requested.emit())
	panel.add_child(back)


func get_screen_snapshot() -> Dictionary:
	var visible_entries: Array = []
	for entry in _entries:
		visible_entries.append({"level_id": entry.level_id, "title": entry.formal_title, "unlocked": _progress.is_unlocked(entry.level_id), "prerequisites": entry.unlock_prerequisites.duplicate()})
	return {"screen": "LEVEL_SELECT", "entries": visible_entries}

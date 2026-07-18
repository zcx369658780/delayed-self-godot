class_name DelayedSelfLevelSelect
extends Control

signal level_selected(level_id: String)
signal back_requested

var _entries: Array = []
var _progress
var _outer_panel: VBoxContainer
var _title: Label
var _entry_scroll: ScrollContainer
var _entry_list: VBoxContainer
var _back_button: Button
var _entry_buttons: Dictionary = {}
var _highest_unlocked_button: Button


func configure(entries: Array, progress) -> void:
	_entries = entries.duplicate(true)
	_progress = progress


func _ready() -> void:
	set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	var background := ColorRect.new()
	background.name = "Background"
	background.color = Color("101827")
	background.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	add_child(background)
	_outer_panel = VBoxContainer.new()
	_outer_panel.name = "OuterPanel"
	_outer_panel.position = Vector2(180, 54)
	_outer_panel.size = Vector2(600, 432)
	_outer_panel.add_theme_constant_override("separation", 10)
	add_child(_outer_panel)
	_title = Label.new()
	_title.name = "Title"
	_title.text = "LEVEL SELECT"
	_title.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	_title.custom_minimum_size = Vector2(0, 42)
	_title.add_theme_font_size_override("font_size", 30)
	_outer_panel.add_child(_title)
	_entry_scroll = ScrollContainer.new()
	_entry_scroll.name = "EntryScroll"
	_entry_scroll.custom_minimum_size = Vector2(0, 312)
	_entry_scroll.size_flags_vertical = Control.SIZE_EXPAND_FILL
	_entry_scroll.horizontal_scroll_mode = ScrollContainer.SCROLL_MODE_DISABLED
	_entry_scroll.vertical_scroll_mode = ScrollContainer.SCROLL_MODE_AUTO
	_entry_scroll.follow_focus = true
	_entry_scroll.clip_contents = true
	_outer_panel.add_child(_entry_scroll)
	_entry_scroll.get_h_scroll_bar().focus_mode = Control.FOCUS_NONE
	_entry_scroll.get_v_scroll_bar().focus_mode = Control.FOCUS_NONE
	_entry_list = VBoxContainer.new()
	_entry_list.name = "LevelEntries"
	_entry_list.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	_entry_list.add_theme_constant_override("separation", 10)
	_entry_scroll.add_child(_entry_list)
	_entries.sort_custom(func(a, b): return a.sequence < b.sequence)
	for entry in _entries:
		var unlocked: bool = _progress != null and _progress.is_unlocked(entry.level_id)
		var button := Button.new()
		button.name = "Level_" + entry.level_id
		button.text = "%02d  %s%s" % [entry.sequence, entry.formal_title, "" if unlocked else "  [LOCKED: %s]" % ", ".join(entry.unlock_prerequisites)]
		button.disabled = not unlocked
		button.custom_minimum_size = Vector2(0, 56)
		button.size_flags_horizontal = Control.SIZE_EXPAND_FILL
		button.pressed.connect(func():
			if not button.disabled:
				level_selected.emit(entry.level_id)
		)
		button.focus_entered.connect(func(): _ensure_button_visible(button))
		_entry_buttons[entry.level_id] = button
		if unlocked:
			_highest_unlocked_button = button
		_entry_list.add_child(button)
	_back_button = Button.new()
	_back_button.name = "Back"
	_back_button.text = "Back"
	_back_button.custom_minimum_size = Vector2(0, 48)
	_back_button.pressed.connect(func(): back_requested.emit())
	_outer_panel.add_child(_back_button)
	_configure_focus_navigation()
	call_deferred("_reveal_highest_unlocked")


func _reveal_highest_unlocked() -> void:
	var tree := get_tree()
	if tree == null:
		return
	await tree.process_frame
	if not is_inside_tree():
		return
	await tree.process_frame
	if not is_inside_tree():
		return
	if is_instance_valid(_highest_unlocked_button):
		_entry_scroll.ensure_control_visible(_highest_unlocked_button)


func _ensure_button_visible(button: Button) -> void:
	if is_instance_valid(_entry_scroll) and is_instance_valid(button):
		_entry_scroll.call_deferred("ensure_control_visible", button)


func _configure_focus_navigation() -> void:
	var enabled_buttons: Array[Button] = []
	for entry in _entries:
		var button: Button = _entry_buttons[entry.level_id]
		if not button.disabled:
			enabled_buttons.append(button)
	if enabled_buttons.is_empty():
		_back_button.focus_neighbor_top = _back_button.get_path_to(_back_button)
		_back_button.focus_neighbor_bottom = _back_button.get_path_to(_back_button)
		_back_button.focus_previous = _back_button.get_path_to(_back_button)
		_back_button.focus_next = _back_button.get_path_to(_back_button)
		return
	for index in enabled_buttons.size():
		var button := enabled_buttons[index]
		var previous: Control = _back_button if index == 0 else enabled_buttons[index - 1]
		var next: Control = _back_button if index == enabled_buttons.size() - 1 else enabled_buttons[index + 1]
		button.focus_neighbor_top = button.get_path_to(previous)
		button.focus_neighbor_bottom = button.get_path_to(next)
		button.focus_previous = button.get_path_to(previous)
		button.focus_next = button.get_path_to(next)
	var first: Button = enabled_buttons[0]
	var last: Button = enabled_buttons[-1]
	_back_button.focus_neighbor_top = _back_button.get_path_to(last)
	_back_button.focus_neighbor_bottom = _back_button.get_path_to(first)
	_back_button.focus_previous = _back_button.get_path_to(last)
	_back_button.focus_next = _back_button.get_path_to(first)


func get_screen_snapshot() -> Dictionary:
	var visible_entries: Array = []
	for entry in _entries:
		var button: Button = _entry_buttons.get(entry.level_id)
		var button_rect := button.get_global_rect() if is_instance_valid(button) else Rect2()
		var scroll_rect := _entry_scroll.get_global_rect() if is_instance_valid(_entry_scroll) else Rect2()
		visible_entries.append({
			"level_id": entry.level_id,
			"title": entry.formal_title,
			"unlocked": _progress.is_unlocked(entry.level_id),
			"prerequisites": entry.unlock_prerequisites.duplicate(),
			"rect": button_rect,
			"disabled": button.disabled if is_instance_valid(button) else true,
			"intersects_scroll": button_rect.intersects(scroll_rect),
			"has_focus": button.has_focus() if is_instance_valid(button) else false,
		})
	var scroll_bar := _entry_scroll.get_v_scroll_bar()
	var horizontal_scroll_bar := _entry_scroll.get_h_scroll_bar()
	var focus_owner := get_viewport().gui_get_focus_owner()
	return {
		"screen": "LEVEL_SELECT",
		"entries": visible_entries,
		"highest_unlocked_id": _highest_unlocked_button.name.trim_prefix("Level_") if is_instance_valid(_highest_unlocked_button) else "",
		"scroll": {
			"value": _entry_scroll.scroll_vertical,
			"maximum": maxf(0.0, scroll_bar.max_value - scroll_bar.page),
			"page": scroll_bar.page,
			"horizontal_value": _entry_scroll.scroll_horizontal,
			"horizontal_maximum": maxf(0.0, horizontal_scroll_bar.max_value - horizontal_scroll_bar.page),
		},
		"rects": {
			"title": _title.get_global_rect(),
			"scroll": _entry_scroll.get_global_rect(),
			"content": _entry_list.get_global_rect(),
			"back": _back_button.get_global_rect(),
			"outer": _outer_panel.get_global_rect(),
		},
		"focused_control": focus_owner.name if is_instance_valid(focus_owner) else "",
	}

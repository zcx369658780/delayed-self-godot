class_name SubmissionVisualTheme
extends RefCounted

# Paper/ink style contract used by the Task 0024BAD visual slice.
# All methods are pure and deterministic; none read/write runtime state.

const CANVAS_SIZE := Vector2(960.0, 540.0)
const CELL_SIZE := 60.0

const _COLOR_TOKENS := {
	"paper_background": Color8(247, 240, 226, 255),
	"primary_ink": Color8(24, 24, 24, 255),
	"secondary_ink": Color8(69, 72, 81, 255),
	"echo_ink": Color8(67, 56, 112, 255),
	"warning_mark": Color8(203, 68, 75, 255),
	"success_mark": Color8(35, 139, 87, 255),
	"disabled_mark": Color8(148, 163, 184, 255),
	"grid_line": Color8(215, 205, 188, 255),
	"focus_outline": Color8(253, 224, 71, 255),
}

const _ENTITY_TOKEN_MAP := {
	"paper_field": {"shape_token": "PAPER_CANVAS", "glyph_token": " ", "monochrome_signature": "PAPER_FIELD_CANVAS"},
	"wall": {"shape_token": "WALL_DENSE_HATCH", "glyph_token": "#", "monochrome_signature": "WALL_DENSE_HATCH"},
	"floor": {"shape_token": "FLOOR_SPARSE_TICKS", "glyph_token": "·", "monochrome_signature": "FLOOR_SPARSE_TICKS"},
	"you": {
		"core": {"shape_token": "YOU_SOLID_CORE", "glyph_token": "Y", "monochrome_signature": "YOU_SOLID"},
		"solid": {"shape_token": "YOU_SOLID_CORE", "glyph_token": "Y", "monochrome_signature": "YOU_SOLID"},
		"echo_overlap": {"shape_token": "YOU_ECHO_OVERLAP", "glyph_token": "↔", "monochrome_signature": "YOU_ECHO_OVERLAP"},
	},
	"echo": {
		"default": {"shape_token": "ECHO_DASHED_DOUBLET", "glyph_token": "E", "monochrome_signature": "ECHO_DASHED"},
		"2": {"shape_token": "ECHO_DASHED_DELAY_2", "glyph_token": "E2", "monochrome_signature": "ECHO_DELAY_2"},
		"3": {"shape_token": "ECHO_DASHED_DELAY_3", "glyph_token": "E3", "monochrome_signature": "ECHO_DELAY_3"},
		"4": {"shape_token": "ECHO_DOUBLE_RING_DELAY_4", "glyph_token": "E4", "monochrome_signature": "ECHO_DELAY_4"},
	},
	"exit": {"shape_token": "EXIT_DOUBLE_DIAMOND", "glyph_token": "⇢", "monochrome_signature": "EXIT_DOUBLE_DIAMOND"},
	"plate": {
		"inactive": {"shape_token": "PLATE_HOLLOW", "glyph_token": "◯", "monochrome_signature": "PLATE_INACTIVE"},
		"active": {"shape_token": "PLATE_FILLED", "glyph_token": "◉", "monochrome_signature": "PLATE_ACTIVE"},
	},
	"door": {
		"closed": {"shape_token": "DOOR_BARS_CLOSED", "glyph_token": "||", "monochrome_signature": "DOOR_CLOSED"},
		"open": {"shape_token": "DOOR_OPEN_FRAME", "glyph_token": "<>", "monochrome_signature": "DOOR_OPEN"},
	},
	"blocked": {"shape_token": "ACTION_BLOCKED_X", "glyph_token": "×", "monochrome_signature": "ACTION_BLOCKED"},
	"timeline_current": {"shape_token": "TIMELINE_CURRENT", "glyph_token": "C", "monochrome_signature": "TIMELINE_CURRENT"},
	"timeline_echo": {"shape_token": "TIMELINE_ECHO", "glyph_token": "E", "monochrome_signature": "TIMELINE_ECHO"},
	"timeline_action": {"shape_token": "TIMELINE_ACTION", "glyph_token": "→", "monochrome_signature": "TIMELINE_ACTION"},
	"ui_focused": {"shape_token": "UI_FOCUS_RING", "glyph_token": "◉", "monochrome_signature": "UI_FOCUS"},
	"ui_selected": {"shape_token": "UI_SELECTED", "glyph_token": "✓", "monochrome_signature": "UI_SELECTED"},
	"ui_locked": {"shape_token": "UI_LOCKED", "glyph_token": "▩", "monochrome_signature": "UI_LOCKED"},
	"ui_completed": {"shape_token": "UI_COMPLETED", "glyph_token": "★", "monochrome_signature": "UI_COMPLETED"},
}

const _UI_STYLE_MAP := {
	"play_button": {"shape_token": "PAPER_PANEL", "glyph_token": "▶", "monochrome_signature": "UI_PLAY"},
	"quit_button": {"shape_token": "PAPER_PANEL", "glyph_token": "⎋", "monochrome_signature": "UI_QUIT"},
	"back_button": {"shape_token": "PAPER_PANEL", "glyph_token": "↩", "monochrome_signature": "UI_BACK"},
	"level_row": {"shape_token": "LEVEL_CELL_PANEL", "glyph_token": "", "monochrome_signature": "UI_LEVEL_ROW"},
}


static func apply_control_tree(root: Control) -> void:
	if root == null:
		return
	var theme := _build_theme()
	root.theme = theme
	var queue: Array = [root]
	while not queue.is_empty():
		var node: Variant = queue.pop_front()
		if not node is Control:
			continue
		var control: Control = node
		_apply_control_overrides(control)
		for child in control.get_children():
			queue.append(child)


static func color_for_token(token_name: String) -> Color:
	return _COLOR_TOKENS.get(token_name, Color8(24, 24, 24, 255))


static func shape_token_for_family(family: String, state_variant: String = "", metadata: Dictionary = {}) -> String:
	var normalized: String = String(family).to_lower()
	var family_tokens: Dictionary = _ENTITY_TOKEN_MAP.get(normalized, {})
	if family_tokens.is_empty():
		return "RAW"
	if normalized == "you":
		return family_tokens.get(_coalesce_variant(family_tokens, "solid", ["active", "default", "core", state_variant]), {}).get("shape_token", "YOU_SOLID_CORE")
	if normalized == "echo":
		var delay_key: String = str(int(metadata.get("delay", -1)))
		var delay_tokens: Dictionary = family_tokens.get(delay_key, family_tokens.get("default", {}))
		return delay_tokens.get("shape_token", "ECHO_DASHED_DOUBLET")
	if normalized == "plate":
		var key: String = state_variant.to_lower()
		if not family_tokens.has(key):
			key = "inactive"
		return family_tokens.get(key, family_tokens.get("inactive")).get("shape_token", "PLATE_HOLLOW")
	if normalized == "door":
		var key: String = state_variant.to_lower()
		if not family_tokens.has(key):
			key = "closed"
		return family_tokens.get(key).get("shape_token", "DOOR_BARS_CLOSED")
	if normalized == "timeline_current":
		return family_tokens.shape_token
	return family_tokens.get("shape_token", "RAW")


static func glyph_for_family(family: String, state_variant: String = "", metadata: Dictionary = {}) -> String:
	var normalized: String = String(family).to_lower()
	var family_tokens: Dictionary = _ENTITY_TOKEN_MAP.get(normalized, {})
	if family_tokens.is_empty():
		return "?"
	if normalized == "you":
		return family_tokens.get(_coalesce_variant(family_tokens, "solid", ["active", "default", "core", state_variant]), {}).get("glyph_token", "Y")
	if normalized == "echo":
		var delay_key: String = str(int(metadata.get("delay", -1)))
		var delay_tokens: Dictionary = family_tokens.get(delay_key, family_tokens.get("default", {}))
		return delay_tokens.get("glyph_token", "E")
	if normalized == "plate":
		var key: String = state_variant.to_lower()
		if not family_tokens.has(key):
			key = "inactive"
		return family_tokens.get(key).get("glyph_token", "◯")
	if normalized == "door":
		var key: String = state_variant.to_lower()
		if not family_tokens.has(key):
			key = "closed"
		return family_tokens.get(key).get("glyph_token", "||")
	if normalized == "wall":
		return family_tokens.glyph_token
	if normalized == "floor":
		return family_tokens.glyph_token
	return str(family_tokens.get("glyph_token", "?"))


static func monochrome_signature_for_family(family: String, state_variant: String = "", metadata: Dictionary = {}) -> String:
	var normalized: String = String(family).to_lower()
	var family_tokens: Dictionary = _ENTITY_TOKEN_MAP.get(normalized, {})
	if family_tokens.is_empty():
		return "RAW_SIGNATURE"
	if normalized == "you":
		return family_tokens.get(_coalesce_variant(family_tokens, "solid", ["active", "default", "core", state_variant]), {}).get("monochrome_signature", "YOU_SOLID")
	if normalized == "echo":
		var delay_key: String = str(int(metadata.get("delay", -1)))
		var delay_tokens: Dictionary = family_tokens.get(delay_key, family_tokens.get("default", {}))
		return delay_tokens.get("monochrome_signature", "ECHO_DASHED")
	if normalized == "plate":
		var key: String = state_variant.to_lower()
		if not family_tokens.has(key):
			key = "inactive"
		return family_tokens.get(key).get("monochrome_signature", "PLATE")
	if normalized == "door":
		var key: String = state_variant.to_lower()
		if not family_tokens.has(key):
			key = "closed"
		return family_tokens.get(key).get("monochrome_signature", "DOOR")
	return str(family_tokens.get("monochrome_signature", "UNKNOWN_SIGNATURE"))


static func style_token_for_ui(state: String) -> Dictionary:
	return _UI_STYLE_MAP.get(state, {"shape_token": "UI_RAW", "glyph_token": "?", "monochrome_signature": "UI_%s" % String(state).to_upper()})


static func descriptor_style_signature(descriptor: Dictionary) -> Dictionary:
	if descriptor.is_empty():
		return {"family": "", "shape_token": "EMPTY", "glyph_token": "", "monochrome_signature": "EMPTY"}
	var family := String(descriptor.get("family", ""))
	var stable_state := String(descriptor.get("state_variant", ""))
	var metadata := {}
	var token := _descriptor_delay_token(descriptor)
	var signature := monochrome_signature_for_family(family, stable_state, token)
	return {
		"family": family,
		"shape_token": shape_token_for_family(family, stable_state, token),
		"glyph_token": glyph_for_family(family, stable_state, token),
		"type_group_token": str(descriptor.get("type_group_token", "")),
		"state_variant": stable_state,
		"monochrome_signature": signature,
	}


static func visual_token_contract() -> Dictionary:
	return {
		"canvas_size": CANVAS_SIZE,
		"cell_size": CELL_SIZE,
		"colors": _COLOR_TOKENS.duplicate(true),
		"entities": _ENTITY_TOKEN_MAP.duplicate(true),
		"ui": _UI_STYLE_MAP.duplicate(true),
	}


static func entity_contract() -> Dictionary:
	return {
		"paper_field": true,
		"floor": true,
		"wall": true,
		"you": true,
		"echo": true,
		"exit": true,
		"plate_inactive": true,
		"plate_active": true,
		"door_open": true,
		"door_closed": true,
		"blocked": true,
		"timeline_current": true,
		"timeline_echo": true,
		"timeline_action": true,
		"ui_focused": true,
		"ui_selected": true,
		"ui_locked": true,
		"ui_completed": true,
	}


static func _descriptor_delay_token(descriptor: Dictionary) -> Dictionary:
	if not descriptor is Dictionary:
		return {}
	var family := String(descriptor.get("family", ""))
	if family != "sensor":
		return {}
	var state_variant := String(descriptor.get("state_variant", ""))
	var delay_match := _extract_delay_from_state_variant(state_variant)
	if delay_match >= 0:
		return {"delay": delay_match}
	var glyph_hint := String(descriptor.get("glyph_token", ""))
	if glyph_hint.begins_with("E"):
		var parsed := int(glyph_hint.trim_prefix("E"))
		if parsed > 0:
			return {"delay": parsed}
	return {}


static func _extract_delay_from_state_variant(state_variant: String) -> int:
	for marker in ["2", "3", "4", "5", "6", "7", "8", "9"]:
		if state_variant.find(marker) >= 0:
			return int(marker)
	return -1


static func _coalesce_variant(family_tokens: Dictionary, default_key: String, candidates: Array) -> String:
	for candidate in candidates:
		var key := String(candidate).to_lower()
		if family_tokens.has(key):
			return key
	return default_key


static func _build_theme() -> Theme:
	var theme := Theme.new()
	theme.default_font_size = 18
	theme.default_font_size = 18
	for node_type in ["Label", "Button", "RichTextLabel", "LineEdit", "TextEdit", "CodeEdit"]:
		theme.set_color("font_color", node_type, color_for_token("primary_ink"))
		theme.set_color("font_shadow_color", node_type, Color8(255, 255, 255, 16))
		theme.set_color("font_focus_color", node_type, color_for_token("focus_outline"))
		var font := ThemeDB.fallback_font
		theme.set_font("font", node_type, font)
	for node_type in ["Panel", "PanelContainer", "ScrollContainer"]:
		var panel := StyleBoxFlat.new()
		panel.bg_color = color_for_token("paper_background").darkened(0.06)
		panel.border_color = color_for_token("primary_ink")
		panel.border_width_top = 2
		panel.border_width_left = 2
		panel.border_width_right = 2
		panel.border_width_bottom = 2
		theme.set_stylebox("panel", node_type, panel)
	for node_type in ["Button", "CheckButton", "ColorRect", "MarginContainer", "VBoxContainer", "HBoxContainer", "Control"]:
		var focus_box := StyleBoxFlat.new()
		focus_box.draw_center = true
		focus_box.bg_color = Color8(251, 243, 227, 200)
		focus_box.border_color = color_for_token("focus_outline")
		focus_box.border_width_top = 1
		focus_box.border_width_left = 1
		focus_box.border_width_right = 1
		focus_box.border_width_bottom = 1
		focus_box.shadow_color = color_for_token("primary_ink")
		focus_box.shadow_size = 3
		focus_box.shadow_offset = Vector2.ZERO
		var idle_box := StyleBoxFlat.new()
		idle_box.bg_color = Color8(250, 248, 239, 210)
		idle_box.border_color = color_for_token("secondary_ink")
		idle_box.border_width_top = 1
		idle_box.border_width_left = 1
		idle_box.border_width_right = 1
		idle_box.border_width_bottom = 1
		idle_box.set_content_margin_all(5.0)
		theme.set_stylebox("focus", node_type, focus_box)
		theme.set_stylebox("hover", node_type, focus_box)
		theme.set_stylebox("pressed", node_type, idle_box)
		theme.set_stylebox("normal", node_type, idle_box)
		theme.set_stylebox("normal", "Button", idle_box)
		theme.set_stylebox("hover", "Button", focus_box)
		theme.set_stylebox("pressed", "Button", idle_box)
		theme.set_color("font_color", "Button", color_for_token("primary_ink"))
		theme.set_color("font_hover_color", "Button", color_for_token("focus_outline"))
		theme.set_color("font_pressed_color", "Button", color_for_token("primary_ink"))
		theme.set_color("font_disabled_color", "Button", color_for_token("disabled_mark"))
	return theme


static func _apply_control_overrides(control: Control) -> void:
	control.clip_children = Control.CLIP_CHILDREN_AND_DRAW
	if control is Button:
		control.mouse_filter = Control.MOUSE_FILTER_PASS
	elif control is Label:
		control.text_direction = Control.TEXT_DIRECTION_AUTO
		control.text_overrun_behavior = TextServer.OVERRUN_TRIM_ELLIPSIS
		control.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
		control.vertical_alignment = VERTICAL_ALIGNMENT_CENTER

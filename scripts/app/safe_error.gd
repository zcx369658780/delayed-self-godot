class_name DelayedSelfSafeError
extends Control

signal main_menu_requested

var error_code := "APP_UNKNOWN_ERROR"
var diagnostic_context := "No diagnostic context."


func configure(code: String, context: String) -> void:
	error_code = code.left(80)
	diagnostic_context = context.replace("\n", " ").left(240)


func _ready() -> void:
	set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	var background := ColorRect.new()
	background.color = Color("180f18")
	background.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	add_child(background)
	var panel := VBoxContainer.new()
	panel.position = Vector2(180, 125)
	panel.size = Vector2(600, 300)
	panel.add_theme_constant_override("separation", 18)
	add_child(panel)
	var title := Label.new()
	title.text = "SAFE ERROR"
	title.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	title.add_theme_font_size_override("font_size", 30)
	panel.add_child(title)
	var code_label := Label.new()
	code_label.text = error_code
	code_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	code_label.add_theme_color_override("font_color", Color("fca5a5"))
	code_label.add_theme_font_size_override("font_size", 22)
	panel.add_child(code_label)
	var context_label := Label.new()
	context_label.text = diagnostic_context
	context_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	context_label.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	panel.add_child(context_label)
	var back := Button.new()
	back.text = "Return to Main Menu"
	back.custom_minimum_size = Vector2(0, 52)
	back.pressed.connect(func(): main_menu_requested.emit())
	panel.add_child(back)


func get_screen_snapshot() -> Dictionary:
	return {"screen": "SAFE_ERROR", "error_code": error_code, "context": diagnostic_context}

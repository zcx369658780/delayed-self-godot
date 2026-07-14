class_name DelayedSelfMainMenu
extends Control

signal play_requested
signal quit_requested


func _ready() -> void:
	set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	var background := ColorRect.new()
	background.color = Color("101827")
	background.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	add_child(background)
	var panel := VBoxContainer.new()
	panel.name = "MenuActions"
	panel.position = Vector2(300, 145)
	panel.size = Vector2(360, 260)
	panel.add_theme_constant_override("separation", 18)
	add_child(panel)
	var title := Label.new()
	title.text = "迟到的我 / DELAYED SELF\nDevelopment Shell"
	title.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	title.add_theme_font_size_override("font_size", 30)
	panel.add_child(title)
	var play := Button.new()
	play.text = "Play"
	play.custom_minimum_size = Vector2(0, 56)
	play.pressed.connect(func(): play_requested.emit())
	panel.add_child(play)
	var quit := Button.new()
	quit.text = "Quit"
	quit.custom_minimum_size = Vector2(0, 56)
	quit.pressed.connect(func(): quit_requested.emit())
	panel.add_child(quit)


func get_screen_snapshot() -> Dictionary:
	return {"screen": "MAIN_MENU", "title": "迟到的我 / DELAYED SELF", "actions": ["Play", "Quit"]}

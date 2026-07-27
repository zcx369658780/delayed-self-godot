class_name DelayedSelfMainMenu
extends Control

signal play_requested
signal quit_requested

const SubmissionVisualTheme = preload("res://scripts/presentation/submission_visual_theme.gd")
const SubmissionSfxRouter = preload("res://scripts/audio/submission_sfx_router.gd")


func _ready() -> void:
	set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	var background := ColorRect.new()
	background.name = "PaperField"
	background.color = SubmissionVisualTheme.color_for_token("paper_background")
	background.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	add_child(background)
	var panel := VBoxContainer.new()
	panel.name = "MenuActions"
	panel.position = Vector2(220, 145)
	panel.size = Vector2(520, 260)
	panel.add_theme_constant_override("separation", 18)
	add_child(panel)
	var title := Label.new()
	title.name = "Title"
	title.text = "迟到的我 / DELAYED SELF\nA PUZZLE ABOUT ARRIVING LATE"
	title.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	title.add_theme_font_size_override("font_size", 30)
	panel.add_child(title)
	var play := Button.new()
	play.name = "Play"
	play.text = "Play"
	play.custom_minimum_size = Vector2(0, 56)
	play.pressed.connect(func():
		SubmissionSfxRouter.ensure_router(get_tree()).play_event("ui_confirm")
		play_requested.emit()
	)
	play.focus_entered.connect(func(): SubmissionSfxRouter.ensure_router(get_tree()).play_event("ui_focus_or_move"))
	panel.add_child(play)
	var quit := Button.new()
	quit.name = "Quit"
	quit.text = "Quit"
	quit.custom_minimum_size = Vector2(0, 56)
	quit.pressed.connect(func():
		SubmissionSfxRouter.ensure_router(get_tree()).play_event("ui_confirm")
		quit_requested.emit()
	)
	quit.focus_entered.connect(func(): SubmissionSfxRouter.ensure_router(get_tree()).play_event("ui_focus_or_move"))
	panel.add_child(quit)
	SubmissionVisualTheme.apply_control_tree(self)
	play.grab_focus()


func get_screen_snapshot() -> Dictionary:
	return {"screen": "MAIN_MENU", "title": "迟到的我 / DELAYED SELF", "actions": ["Play", "Quit"]}

extends SceneTree

const AppRootScene = preload("res://scenes/app/app_root.tscn")

var capture_case := ""


func _init() -> void:
	for argument in OS.get_cmdline_user_args():
		if argument.begins_with("--case="):
			capture_case = argument.trim_prefix("--case=")
	call_deferred("_prepare")


func _prepare() -> void:
	if capture_case.is_empty():
		printerr("TASK_0011R_CAPTURE_CASE_REQUIRED")
		quit(1)
		return
	var target_size := _target_size(capture_case)
	DisplayServer.window_set_size(target_size)
	var app = AppRootScene.instantiate()
	root.add_child(app)
	await process_frame
	await process_frame
	match capture_case:
		"main_menu_960x540":
			pass
		"level_select_960x540":
			app.navigate("LEVEL_SELECT")
		"level5_exact_1280x720", "level5_wide_1440x720":
			app.boot_with_user_args(["--level-id=two_keys_one_door"])
		"help_exact_1280x720":
			app.boot_with_user_args(["--level-id=two_keys_one_door"])
			await process_frame
			app.get_active_screen().toggle_help()
		"level4_open_1280x720":
			app.boot_with_user_args(["--level-id=door_one_turn_late"])
			await process_frame
			for action in ["move_right", "move_right", "move_up", "move_up", "move_up"]:
				_send_action(app.get_active_screen(), action)
		"resize_state_1280x800":
			app.boot_with_user_args(["--level-id=two_keys_one_door"])
			await process_frame
			var gameplay = app.get_active_screen()
			_send_action(gameplay, "move_right")
			gameplay.toggle_help()
			var before_state: Dictionary = gameplay.state.duplicate(true)
			var before_key: String = gameplay.get_hud_snapshot().canonical_key
			DisplayServer.window_set_size(Vector2i(1280, 800))
			await process_frame
			await process_frame
			if gameplay.state != before_state or gameplay.get_hud_snapshot().canonical_key != before_key or not gameplay.get_hud_snapshot().help_expanded:
				printerr("TASK_0011R_RESIZE_STATE_CHANGED")
				quit(1)
				return
		_:
			printerr("TASK_0011R_CAPTURE_CASE_UNKNOWN " + capture_case)
			quit(1)
			return
	await process_frame
	await process_frame
	var snapshot: Dictionary = app.get_window_presentation_snapshot(DisplayServer.window_get_size())
	print("TASK_0011R_CAPTURE_READY case=%s route=%s client=%s content_rect=%s scale=%s bars=%s" % [capture_case, app.get_current_route(), snapshot.client_size, snapshot.content_rect, snapshot.scale, snapshot.bars])


func _target_size(case_name: String) -> Vector2i:
	match case_name:
		"main_menu_960x540", "level_select_960x540":
			return Vector2i(960, 540)
		"level5_wide_1440x720":
			return Vector2i(1440, 720)
		"resize_state_1280x800":
			return Vector2i(960, 540)
		_:
			return Vector2i(1280, 720)


func _send_action(scene: Node, action: String) -> void:
	var event := InputEventAction.new()
	event.action = action
	event.pressed = true
	scene._unhandled_input(event)

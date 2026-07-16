extends SceneTree

var failures := 0


func _init() -> void:
	call_deferred("_run")


func _run() -> void:
	_test_logical_reference_and_scale_policy()
	_test_reference_transform()
	await _test_app_root_policy_and_resize_state()
	if failures > 0:
		printerr("TASK_0011R_WINDOW_FILL_FOCUSED_FAIL failures=%d" % failures)
		quit(1)
	else:
		print("TASK_0011R_WINDOW_FILL_FOCUSED_PASS")
		quit(0)


func _test_logical_reference_and_scale_policy() -> void:
	_require(ProjectSettings.get_setting("display/window/size/viewport_width") == 960, "logical width remains 960")
	_require(ProjectSettings.get_setting("display/window/size/viewport_height") == 540, "logical height remains 540")
	_require(ProjectSettings.get_setting("display/window/stretch/mode") == "canvas_items", "complete logical canvas uses canvas_items scaling")
	_require(ProjectSettings.get_setting("display/window/stretch/aspect") == "keep", "logical aspect ratio is preserved")


func _test_reference_transform() -> void:
	var window_presentation = load("res://scripts/app/window_presentation.gd")
	_require(window_presentation != null, "window presentation policy is loadable")
	if window_presentation == null:
		return
	var exact: Dictionary = window_presentation.content_transform(Vector2i(1280, 720))
	_require(exact.content_rect == Rect2(0, 0, 1280, 720) and is_equal_approx(exact.scale, 4.0 / 3.0), "1280x720 fills at uniform 4/3 scale")
	var wide: Dictionary = window_presentation.content_transform(Vector2i(1440, 720))
	_require(wide.content_rect == Rect2(80, 0, 1280, 720) and wide.bars == {"left": 80.0, "right": 80.0, "top": 0.0, "bottom": 0.0}, "wide client has symmetric pillarboxing")
	var tall: Dictionary = window_presentation.content_transform(Vector2i(1280, 800))
	_require(tall.content_rect == Rect2(0, 40, 1280, 720) and tall.bars == {"left": 0.0, "right": 0.0, "top": 40.0, "bottom": 40.0}, "tall client has symmetric letterboxing")
	_require(window_presentation.content_transform(Vector2i(1280, 800)) == tall, "resize transform is deterministic and idempotent")


func _test_app_root_policy_and_resize_state() -> void:
	var packed = load("res://scenes/app/app_root.tscn")
	var window_presentation = load("res://scripts/app/window_presentation.gd")
	var app = packed.instantiate()
	root.add_child(app)
	await process_frame
	_require(RenderingServer.get_default_clear_color() == window_presentation.BAR_COLOR, "unavoidable aspect bars use the intentional dark background")
	_require(app.has_method("get_window_presentation_snapshot"), "AppRoot exposes its shared physical-window policy")
	if not app.has_method("get_window_presentation_snapshot"):
		app.queue_free()
		await process_frame
		return
	var menu_policy: Dictionary = app.get_window_presentation_snapshot(Vector2i(1440, 720))
	_require(menu_policy.logical_size == Vector2(960, 540) and menu_policy.content_rect == Rect2(80, 0, 1280, 720), "Main Menu uses the shared centered policy")
	_require(app.get_active_screen().get_parent() == app.route_host, "Main Menu is hosted by the one full-client RouteHost")
	app.navigate("LEVEL_SELECT")
	await process_frame
	var select_policy: Dictionary = app.get_window_presentation_snapshot(Vector2i(1440, 720))
	_require(select_policy.content_rect == menu_policy.content_rect and app.get_active_screen().get_parent() == app.route_host, "Level Select retains the same host and scale policy")
	app.boot_with_user_args(["--level-id=two_keys_one_door"])
	await process_frame
	var gameplay = app.get_active_screen()
	var event := InputEventAction.new()
	event.action = "move_right"
	event.pressed = true
	gameplay._unhandled_input(event)
	gameplay.toggle_help()
	var state_before: Dictionary = gameplay.state.duplicate(true)
	var key_before: String = gameplay.get_hud_snapshot().canonical_key
	var history_before: Array = gameplay.state.history.duplicate(true)
	DisplayServer.window_set_size(Vector2i(1440, 720))
	await process_frame
	await process_frame
	_require(gameplay.state == state_before and gameplay.state.history == history_before and gameplay.get_hud_snapshot().canonical_key == key_before, "window resize does not transition or mutate gameplay state")
	_require(gameplay.get_hud_snapshot().help_expanded, "Help remains open across resize")
	var gameplay_policy: Dictionary = app.get_window_presentation_snapshot(Vector2i(1440, 720))
	_require(gameplay_policy.content_rect == menu_policy.content_rect and gameplay.get_parent() == app.route_host, "Gameplay and overlays retain the same host and scale policy")
	var presentation: Dictionary = gameplay.get_presentation_snapshot()
	_require(presentation.viewport == Rect2(0, 0, 960, 540) and presentation.surfaces.help.rect == Rect2(96, 54, 768, 432), "accepted logical Gameplay and Help rectangles remain unchanged")
	app.navigate("UNKNOWN_ROUTE")
	await process_frame
	var error_policy: Dictionary = app.get_window_presentation_snapshot(Vector2i(1440, 720))
	_require(error_policy.content_rect == menu_policy.content_rect and app.get_active_screen().get_parent() == app.route_host, "Safe Error retains the same host and scale policy")
	app.queue_free()
	await process_frame


func _require(condition: bool, label: String) -> void:
	if not condition:
		failures += 1
		printerr("TASK_0011R_FAIL: " + label)

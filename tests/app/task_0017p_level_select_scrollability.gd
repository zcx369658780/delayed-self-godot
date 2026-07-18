extends RefCounted

const CatalogLoader = preload("res://scripts/app/catalog_loader.gd")
const ProgressStore = preload("res://scripts/app/memory_progress.gd")
const LevelSelectScene = preload("res://scenes/ui/level_select.tscn")
const AppRootScene = preload("res://scenes/app/app_root.tscn")

var assertions := 0
var failures := 0


func run(tree: SceneTree) -> Dictionary:
	await _test_product_catalog(tree)
	await _test_synthetic_eight(tree)
	await _test_synthetic_twelve(tree)
	await _test_app_root_and_window(tree)
	return {"assertions": assertions, "failures": failures}


func _test_product_catalog(tree: SceneTree) -> void:
	var loaded := CatalogLoader.new().load_file("res://data/catalog/level_catalog_v1.json")
	_expect(loaded.ok and loaded.catalog.entries.size() == 8, "Task 0017P supports the exact eight-entry product catalog")
	if not loaded.ok:
		return
	var initial_progress = ProgressStore.new(loaded.catalog)
	var initial = await _spawn_level_select(tree, loaded.catalog.entries, initial_progress)
	var initial_snapshot: Dictionary = initial.get_screen_snapshot()
	_expect(initial_snapshot.entries.size() == 8 and initial_snapshot.highest_unlocked_id == "tutorial_reach_exit", "product initial progress identifies only the first unlocked entry")
	_expect(initial_snapshot.scroll.value == 0 and initial_snapshot.entries[0].intersects_scroll, "product initial progress remains at the top and does not jump to locked tail")
	_expect(_fixed_regions_valid(initial_snapshot), "product title, scroll region, and Back are bounded and non-overlapping")
	_expect(initial_snapshot.scroll.horizontal_value == 0 and initial_snapshot.scroll.horizontal_maximum == 0, "product list has no horizontal scrolling or overflow")
	initial.queue_free()
	await tree.process_frame

	var completed_progress = ProgressStore.new(loaded.catalog)
	for entry in loaded.catalog.entries:
		_expect(completed_progress.record_completion(entry.level_id, maxi(1, int(entry.sequence))), "product progress completion remains valid for " + entry.level_id)
	var completed = await _spawn_level_select(tree, loaded.catalog.entries, completed_progress)
	var completed_snapshot: Dictionary = completed.get_screen_snapshot()
	_expect(completed_snapshot.highest_unlocked_id == "two_echo_convergence" and completed_snapshot.entries[-1].intersects_scroll, "product highest-sequence unlocked entry is auto-visible")
	await _assert_every_entry_focus_reachable(tree, completed, 8, "product")
	completed.queue_free()
	await tree.process_frame


func _test_synthetic_eight(tree: SceneTree) -> void:
	var entries := _synthetic_entries(8)
	var initial_progress = ProgressStore.new({"entries": entries})
	var initial = await _spawn_level_select(tree, entries, initial_progress)
	var initial_snapshot: Dictionary = initial.get_screen_snapshot()
	_expect(initial_snapshot.entries.size() == 8 and initial_snapshot.scroll.maximum > 0, "synthetic eight-entry list requires bounded vertical scrolling")
	_expect(initial_snapshot.scroll.value == 0 and initial_snapshot.highest_unlocked_id == "synthetic_01", "synthetic eight-entry initial progress stays at top")
	_expect(initial_snapshot.entries[0].intersects_scroll and not initial_snapshot.entries[-1].intersects_scroll, "synthetic eight-entry top view shows first and clips only tail inside scroll region")
	var emitted: Array = []
	initial.level_selected.connect(func(level_id): emitted.append(level_id))
	_entry_button(initial, "synthetic_01").pressed.emit()
	_entry_button(initial, "synthetic_08").pressed.emit()
	_expect(emitted == ["synthetic_01"], "enabled first entry emits while locked final entry emits nothing")
	_entry_button(initial, "synthetic_01").grab_focus()
	await tree.process_frame
	_send_focus_next()
	await tree.process_frame
	_expect(initial.get_screen_snapshot().focused_control == "Back", "focus skips all locked entries and reaches fixed Back")
	initial.queue_free()
	await tree.process_frame

	var progress = ProgressStore.new({"entries": entries})
	for index in 7:
		_expect(progress.record_completion(entries[index].level_id, index + 1), "synthetic eight progress unlocks sequence %d" % (index + 2))
	var screen = await _spawn_level_select(tree, entries, progress)
	var bottom: Dictionary = screen.get_screen_snapshot()
	_expect(bottom.highest_unlocked_id == "synthetic_08" and bottom.entries[-1].intersects_scroll and bottom.scroll.value > 0, "synthetic eighth entry is automatically visible after unlock")
	_expect(_fixed_regions_valid(bottom), "synthetic eight title and Back remain fixed after auto-scroll")
	var selected: Array = []
	screen.level_selected.connect(func(level_id): selected.append(level_id))
	for id in ["synthetic_01", "synthetic_04", "synthetic_08"]:
		_entry_button(screen, id).pressed.emit()
	_expect(selected == ["synthetic_01", "synthetic_04", "synthetic_08"], "first, middle, and last enabled entries emit exact IDs")
	await _assert_every_entry_focus_reachable(tree, screen, 8, "synthetic eight")
	screen.queue_free()
	await tree.process_frame


func _test_synthetic_twelve(tree: SceneTree) -> void:
	var entries := _synthetic_entries(12)
	var initial_progress = ProgressStore.new({"entries": entries})
	var initial = await _spawn_level_select(tree, entries, initial_progress)
	var top: Dictionary = initial.get_screen_snapshot()
	_expect(top.entries.size() == 12 and top.scroll.maximum > 0 and top.scroll.value == 0, "synthetic twelve-entry list opens at top")
	_expect(top.entries[0].intersects_scroll and not top.entries[-1].intersects_scroll and _fixed_regions_valid(top), "synthetic twelve top state clips tail only within bounded scroll")
	_send_wheel_down(initial)
	await tree.process_frame
	await tree.process_frame
	_expect(initial.get_screen_snapshot().scroll.value > 0, "mouse wheel scrolls the bounded entry region")
	initial.queue_free()
	await tree.process_frame

	var partial_progress = ProgressStore.new({"entries": entries})
	for index in 8:
		_expect(partial_progress.record_completion(entries[index].level_id, index + 1), "synthetic twelve partial progress unlocks through sequence %d" % (index + 2))
	var partial = await _spawn_level_select(tree, entries, partial_progress)
	var partial_snapshot: Dictionary = partial.get_screen_snapshot()
	_expect(partial_snapshot.highest_unlocked_id == "synthetic_09" and partial_snapshot.entries[8].intersects_scroll, "highest unlocked middle-tail entry is auto-visible without selecting it")
	_expect(partial_snapshot.focused_control.is_empty(), "auto-visibility does not steal focus or select an entry")
	_expect(not partial_snapshot.entries[9].unlocked and partial_snapshot.entries[9].disabled, "auto-visibility does not mutate locked progress")
	partial.queue_free()
	await tree.process_frame

	var full_progress = ProgressStore.new({"entries": entries})
	for index in 12:
		_expect(full_progress.record_completion(entries[index].level_id, index + 1), "synthetic twelve full progress records sequence %d" % (index + 1))
	var full = await _spawn_level_select(tree, entries, full_progress)
	var scroll: ScrollContainer = full.get_node("OuterPanel/EntryScroll")
	scroll.scroll_vertical = int(full.get_screen_snapshot().scroll.maximum)
	await tree.process_frame
	await tree.process_frame
	var bottom: Dictionary = full.get_screen_snapshot()
	_expect(bottom.entries[-1].intersects_scroll and is_equal_approx(float(bottom.scroll.value), float(bottom.scroll.maximum)), "synthetic twelve final entry is reachable at maximum scroll")
	_expect(_fixed_regions_valid(bottom) and _inside_viewport(bottom.rects.back), "Back remains visible at maximum scroll")
	_expect(bottom.scroll.horizontal_value == 0 and bottom.scroll.horizontal_maximum == 0, "synthetic twelve list has no horizontal overflow")
	var first: Button = _entry_button(full, "synthetic_01")
	first.grab_focus()
	await tree.process_frame
	for index in 11:
		_send_focus_next()
		await tree.process_frame
		await tree.process_frame
	var focused_last: Dictionary = full.get_screen_snapshot()
	print("TASK_0017P_FOCUS_TRACE=" + JSON.stringify({"focused_control": focused_last.focused_control, "scroll": focused_last.scroll, "focused_entries": focused_last.entries.filter(func(entry): return entry.has_focus).map(func(entry): return entry.level_id)}))
	_expect(focused_last.focused_control == "Level_synthetic_12" and focused_last.entries[-1].intersects_scroll, "keyboard focus navigation reaches and reveals the final enabled entry")
	_send_focus_next()
	await tree.process_frame
	_expect(full.get_screen_snapshot().focused_control == "Back", "focus navigation proceeds from final entry to fixed Back without trapping")
	await _assert_every_entry_focus_reachable(tree, full, 12, "synthetic twelve")
	full.queue_free()
	await tree.process_frame


func _test_app_root_and_window(tree: SceneTree) -> void:
	var app = AppRootScene.instantiate()
	tree.root.add_child(app)
	await tree.process_frame
	app.navigate("LEVEL_SELECT")
	await tree.process_frame
	await tree.process_frame
	var snapshot: Dictionary = app.get_active_screen().get_screen_snapshot()
	_expect(app.get_current_route() == "LEVEL_SELECT" and snapshot.entries.size() == 8, "AppRoot still routes to the product Level Select")
	_expect(_fixed_regions_valid(snapshot) and snapshot.scroll.horizontal_maximum == 0, "AppRoot Level Select exposes the bounded scroll contract")
	var presentation: Dictionary = app.get_window_presentation_snapshot(Vector2i(1280, 800))
	_expect(presentation.content_rect == Rect2(0, 40, 1280, 720), "accepted resized window transform remains unchanged")
	app.navigate("UNKNOWN_0017P_ROUTE")
	await tree.process_frame
	_expect(app.get_current_route() == "SAFE_ERROR" and app.get_active_screen().get_screen_snapshot().error_code == "APP_UNKNOWN_ROUTE", "Safe Error routing remains unchanged")
	app.queue_free()
	await tree.process_frame


func _spawn_level_select(tree: SceneTree, entries: Array, progress):
	var screen = LevelSelectScene.instantiate()
	screen.configure(entries, progress)
	tree.root.add_child(screen)
	await tree.process_frame
	await tree.process_frame
	await tree.process_frame
	await tree.process_frame
	return screen


func _synthetic_entries(count: int) -> Array:
	var entries := []
	for index in count:
		var sequence := index + 1
		entries.append({
			"level_id": "synthetic_%02d" % sequence,
			"sequence": sequence,
			"formal_title": "Synthetic Level %02d" % sequence,
			"unlock_prerequisites": [] if index == 0 else ["synthetic_%02d" % index],
		})
	return entries


func _assert_every_entry_focus_reachable(tree: SceneTree, screen: Node, count: int, label: String) -> void:
	for index in count:
		var id := "synthetic_%02d" % (index + 1) if label.begins_with("synthetic") else _product_id(index)
		var button: Button = _entry_button(screen, id)
		button.grab_focus()
		await tree.process_frame
		await tree.process_frame
		var entry: Dictionary = screen.get_screen_snapshot().entries[index]
		_expect(button.has_focus() and entry.intersects_scroll, "%s entry %d is reachable and visible through focus" % [label, index + 1])


func _product_id(index: int) -> String:
	return ["tutorial_reach_exit", "tutorial_echo_bridge", "vertical_slice_delay_3", "door_one_turn_late", "two_keys_one_door", "staggered_doors", "echo_spacing_bridge", "two_echo_convergence"][index]


func _entry_button(screen: Node, id: String) -> Button:
	return screen.get_node("OuterPanel/EntryScroll/LevelEntries/Level_" + id)


func _fixed_regions_valid(snapshot: Dictionary) -> bool:
	return _inside_viewport(snapshot.rects.title) and _inside_viewport(snapshot.rects.scroll) and _inside_viewport(snapshot.rects.back) and not snapshot.rects.title.intersects(snapshot.rects.scroll) and not snapshot.rects.scroll.intersects(snapshot.rects.back)


func _inside_viewport(rect: Rect2) -> bool:
	return rect.position.x >= 0 and rect.position.y >= 0 and rect.end.x <= 960 and rect.end.y <= 540


func _send_focus_next() -> void:
	var event := InputEventAction.new()
	event.action = "ui_focus_next"
	event.pressed = true
	Input.parse_input_event(event)
	var released := event.duplicate()
	released.pressed = false
	Input.parse_input_event(released)


func _send_wheel_down(screen: Node) -> void:
	var scroll: ScrollContainer = screen.get_node("OuterPanel/EntryScroll")
	var event := InputEventMouseButton.new()
	event.button_index = MOUSE_BUTTON_WHEEL_DOWN
	event.pressed = true
	event.position = scroll.get_global_rect().get_center()
	event.global_position = event.position
	screen.get_viewport().push_input(event, true)


func _expect(condition: bool, label: String) -> void:
	assertions += 1
	if not condition:
		failures += 1
		printerr("TEST_FAIL: " + label)

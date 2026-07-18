extends SceneTree

const CatalogLoader = preload("res://scripts/app/catalog_loader.gd")
const ProgressStore = preload("res://scripts/app/memory_progress.gd")
const LevelSelectScene = preload("res://scenes/ui/level_select.tscn")
const AppRootScene = preload("res://scenes/app/app_root.tscn")

var output_directory := ""
var records: Array = []
var failures := 0


func _init() -> void:
	var arguments: Array = OS.get_cmdline_user_args()
	arguments.append_array(OS.get_cmdline_args())
	for argument in arguments:
		if argument.begins_with("--evidence-dir="):
			output_directory = argument.trim_prefix("--evidence-dir=")
	call_deferred("_capture")


func _capture() -> void:
	if output_directory.is_empty() or not DirAccess.dir_exists_absolute(output_directory):
		printerr("TASK_0017P_CAPTURE_INVALID_EVIDENCE_DIRECTORY")
		quit(1)
		return
	root.size = Vector2i(960, 540)
	var loaded := CatalogLoader.new().load_file("res://data/catalog/level_catalog_v1.json")
	if not loaded.ok:
		printerr("TASK_0017P_CAPTURE_PRODUCT_CATALOG_INVALID")
		quit(1)
		return
	var product = await _spawn(loaded.catalog.entries, ProgressStore.new(loaded.catalog))
	if not await _record("01_product_seven_entries.png", product, false):
		return
	await _remove(product)

	var eight := _synthetic_entries(8)
	var eight_initial = await _spawn(eight, ProgressStore.new({"entries": eight}))
	if not await _record("02_synthetic_eight_top.png", eight_initial, false):
		return
	await _remove(eight_initial)
	var eight_progress = ProgressStore.new({"entries": eight})
	_complete_through(eight_progress, eight, 7)
	var eight_bottom = await _spawn(eight, eight_progress)
	if not await _record("03_synthetic_eight_final_visible.png", eight_bottom, false):
		return
	await _remove(eight_bottom)

	var twelve := _synthetic_entries(12)
	var twelve_partial_progress = ProgressStore.new({"entries": twelve})
	_complete_through(twelve_partial_progress, twelve, 8)
	var twelve_partial = await _spawn(twelve, twelve_partial_progress)
	if not await _record("04_highest_unlocked_entry_visible.png", twelve_partial, false):
		return
	await _remove(twelve_partial)
	var twelve_top = await _spawn(twelve, ProgressStore.new({"entries": twelve}))
	if not await _record("05_synthetic_twelve_top.png", twelve_top, false):
		return
	await _remove(twelve_top)
	var twelve_full_progress = ProgressStore.new({"entries": twelve})
	_complete_through(twelve_full_progress, twelve, 12)
	var twelve_bottom = await _spawn(twelve, twelve_full_progress)
	var scroll: ScrollContainer = twelve_bottom.get_node("OuterPanel/EntryScroll")
	scroll.scroll_vertical = int(twelve_bottom.get_screen_snapshot().scroll.maximum)
	await _frames()
	if not await _record("06_synthetic_twelve_bottom_back_fixed.png", twelve_bottom, false):
		return
	var last: Button = twelve_bottom.get_node("OuterPanel/EntryScroll/LevelEntries/Level_synthetic_12")
	last.grab_focus()
	await _frames()
	if not await _record("07_keyboard_focus_last_enabled.png", twelve_bottom, false):
		return
	if not await _record("08_grayscale_focus_and_disabled.png", twelve_bottom, true):
		return
	await _remove(twelve_bottom)

	root.size = Vector2i(1280, 800)
	var app = AppRootScene.instantiate()
	root.add_child(app)
	await _frames()
	app.navigate("LEVEL_SELECT")
	await _frames()
	var window_snapshot: Dictionary = app.get_window_presentation_snapshot(Vector2i(1280, 800))
	_expect(window_snapshot.content_rect == Rect2(0, 40, 1280, 720), "resized window keeps accepted centered content transform")
	if not await _record_app("09_resized_window_transform.png", app):
		return
	app.queue_free()
	await _frames()

	var snapshot_file := FileAccess.open(output_directory.path_join("presentation_snapshots.txt"), FileAccess.WRITE)
	if snapshot_file == null:
		printerr("TASK_0017P_CAPTURE_SNAPSHOT_WRITE_FAILED")
		quit(1)
		return
	snapshot_file.store_string(var_to_str(records))
	snapshot_file.close()
	if failures > 0:
		printerr("TASK_0017P_VIEWPORT_CAPTURES_FAIL failures=%d" % failures)
		quit(1)
		return
	print("TASK_0017P_VIEWPORT_CAPTURES_PASS captures=9")
	quit(0)


func _spawn(entries: Array, progress):
	var screen = LevelSelectScene.instantiate()
	screen.configure(entries, progress)
	root.add_child(screen)
	await _frames()
	await _frames()
	return screen


func _remove(screen: Node) -> void:
	screen.queue_free()
	await _frames()


func _record(filename: String, screen: Node, grayscale: bool) -> bool:
	var snapshot: Dictionary = screen.get_screen_snapshot()
	_expect(_inside(snapshot.rects.title, Vector2(960, 540)), filename + " keeps title in viewport")
	_expect(_inside(snapshot.rects.back, Vector2(960, 540)), filename + " keeps Back in viewport")
	_expect(not snapshot.rects.title.intersects(snapshot.rects.scroll) and not snapshot.rects.scroll.intersects(snapshot.rects.back), filename + " keeps fixed regions separate")
	_expect(snapshot.scroll.horizontal_value == 0 and snapshot.scroll.horizontal_maximum == 0, filename + " has no horizontal overflow")
	if filename.begins_with("03_"):
		_expect(snapshot.entries[-1].intersects_scroll and snapshot.highest_unlocked_id == "synthetic_08", filename + " shows final eighth entry")
	if filename.begins_with("04_"):
		_expect(snapshot.entries[8].intersects_scroll and snapshot.highest_unlocked_id == "synthetic_09" and not snapshot.entries[9].unlocked, filename + " shows highest unlocked without unlocking tail")
	if filename.begins_with("06_") or filename.begins_with("07_") or filename.begins_with("08_"):
		_expect(snapshot.entries[-1].intersects_scroll and is_equal_approx(float(snapshot.scroll.value), float(snapshot.scroll.maximum)), filename + " shows final twelfth entry at bottom")
	if filename.begins_with("07_") or filename.begins_with("08_"):
		_expect(snapshot.focused_control == "Level_synthetic_12", filename + " retains keyboard focus on final enabled entry")
	records.append({"file": filename, "viewport": Vector2i(960, 540), "snapshot": snapshot, "grayscale": grayscale})
	return _save(filename, grayscale)


func _record_app(filename: String, app: Node) -> bool:
	var snapshot: Dictionary = app.get_active_screen().get_screen_snapshot()
	_expect(snapshot.entries.size() == 7 and _inside(snapshot.rects.title, Vector2(1280, 800)) and _inside(snapshot.rects.back, Vector2(1280, 800)), filename + " keeps product Level Select reachable after resize")
	records.append({"file": filename, "viewport": Vector2i(1280, 800), "level_select": snapshot, "window": app.get_window_presentation_snapshot(Vector2i(1280, 800))})
	return _save(filename, false)


func _save(filename: String, grayscale: bool) -> bool:
	var image := root.get_texture().get_image()
	if grayscale:
		image.convert(Image.FORMAT_L8)
	var path := output_directory.path_join(filename)
	var error := image.save_png(path)
	if error != OK:
		printerr("TASK_0017P_CAPTURE_SAVE_FAILED path=%s error=%d" % [path, error])
		quit(1)
		return false
	print("CAPTURE_SAVED " + path)
	if failures > 0:
		printerr("TASK_0017P_CAPTURE_AUDIT_ABORT failures=%d" % failures)
		quit(1)
		return false
	return true


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


func _complete_through(progress, entries: Array, count: int) -> void:
	for index in count:
		progress.record_completion(entries[index].level_id, index + 1)


func _inside(rect: Rect2, bounds: Vector2) -> bool:
	return rect.position.x >= 0 and rect.position.y >= 0 and rect.end.x <= bounds.x and rect.end.y <= bounds.y


func _frames() -> void:
	await process_frame
	await process_frame


func _expect(condition: bool, label: String) -> void:
	if not condition:
		failures += 1
		printerr("CAPTURE_AUDIT_FAIL: " + label)

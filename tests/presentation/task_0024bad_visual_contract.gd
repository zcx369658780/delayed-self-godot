extends SceneTree

const GameplayScene = preload("res://scenes/vertical_slice/vertical_slice.tscn")
const MainMenuScene = preload("res://scenes/ui/main_menu.tscn")
const LevelLoader = preload("res://scripts/simulation/level_loader.gd")
const Simulation = preload("res://scripts/simulation/simulation.gd")
const Presentation = preload("res://scripts/gameplay/schema_v2_presentation.gd")
const SubmissionVisualTheme = preload("res://scripts/presentation/submission_visual_theme.gd")

const REQUIRED_FAMILIES := [
	"paper_field",
	"floor",
	"wall",
	"you",
	"echo",
	"exit",
	"plate_inactive",
	"plate_active",
	"door_open",
	"door_closed",
	"blocked",
	"timeline_current",
	"timeline_echo",
	"timeline_action",
	"ui_focused",
	"ui_selected",
	"ui_locked",
	"ui_completed",
]

const EXPECTED_LEVEL_PATHS := [
	"res://data/levels/tutorial_reach_exit.json",
	"res://data/levels/tutorial_echo_bridge.json",
	"res://data/levels/vertical_slice_delay_3.json",
	"res://data/levels/door_one_turn_late.json",
	"res://data/levels/two_keys_one_door.json",
	"res://data/levels/staggered_doors.json",
	"res://data/levels/echo_spacing_bridge.json",
	"res://data/levels/two_echo_convergence.json",
]

var assertions := 0
var failures := 0
var loader := LevelLoader.new()
var simulation := Simulation.new()


func _init() -> void:
	call_deferred("_run")


func _run() -> void:
	var result: Dictionary = await run(self)
	if int(result.failures) == 0:
		print("TASK_0024BAD_VISUAL_CONTRACT_PASS assertions=%d" % int(result.assertions))
	else:
		printerr("TASK_0024BAD_VISUAL_CONTRACT_FAIL failures=%d assertions=%d" % [int(result.failures), int(result.assertions)])
	quit(0 if int(result.failures) == 0 else 1)


func run(tree: SceneTree) -> Dictionary:
	_test_theme_api_purity()
	_test_visual_signatures()
	await _test_runtime_focus_style(tree)
	for path in EXPECTED_LEVEL_PATHS:
		await _test_level_presentation_contract(tree, path)
	return {"assertions": assertions, "failures": failures}


func _test_theme_api_purity() -> void:
	var contract_a: Dictionary = SubmissionVisualTheme.visual_token_contract()
	var contract_b: Dictionary = SubmissionVisualTheme.visual_token_contract()
	_expect(contract_a == contract_b, "visual token contract is deterministic and pure")
	var contract_entity: Dictionary = SubmissionVisualTheme.entity_contract()
	for family in REQUIRED_FAMILIES:
		_expect(bool(contract_entity.get(family, false)), "required visual family contract includes %s" % family)


func _test_visual_signatures() -> void:
	var paper: String = SubmissionVisualTheme.monochrome_signature_for_family("paper_field")
	var wall: String = SubmissionVisualTheme.monochrome_signature_for_family("wall")
	var floor: String = SubmissionVisualTheme.monochrome_signature_for_family("floor")
	var you: String = SubmissionVisualTheme.monochrome_signature_for_family("you")
	var echo: String = SubmissionVisualTheme.monochrome_signature_for_family("echo")
	var plate_inactive: String = SubmissionVisualTheme.monochrome_signature_for_family("plate", "inactive")
	var plate_active: String = SubmissionVisualTheme.monochrome_signature_for_family("plate", "active")
	var door_closed: String = SubmissionVisualTheme.monochrome_signature_for_family("door", "closed")
	var door_open: String = SubmissionVisualTheme.monochrome_signature_for_family("door", "open")
	var timeline: String = SubmissionVisualTheme.monochrome_signature_for_family("timeline_current")
	var echo2: String = SubmissionVisualTheme.monochrome_signature_for_family("echo", "", {"delay": 2})
	var echo3: String = SubmissionVisualTheme.monochrome_signature_for_family("echo", "", {"delay": 3})
	var echo4: String = SubmissionVisualTheme.monochrome_signature_for_family("echo", "", {"delay": 4})
	var focus: Dictionary = SubmissionVisualTheme.style_token_for_ui("ui_focused")
	var locked: Dictionary = SubmissionVisualTheme.style_token_for_ui("ui_locked")
	var selected: Dictionary = SubmissionVisualTheme.style_token_for_ui("ui_selected")
	var completed: Dictionary = SubmissionVisualTheme.style_token_for_ui("ui_completed")
	_expect(paper != wall, "paper and wall signatures differ")
	_expect(wall != floor, "wall and floor signatures differ")
	_expect(you != echo, "YOU and ECHO signatures differ without stereo")
	_expect(plate_inactive != plate_active, "inactive vs active plate signature differs")
	_expect(door_closed != door_open, "open/closed door signatures differ")
	_expect(timeline != wall and timeline != floor, "timeline signature is not reused terrain")
	_expect(echo2 != echo3 and echo3 != echo4 and echo2 != echo4, "E2/E3/E4 signatures are distinct")
	_expect(focus.monochrome_signature != locked.monochrome_signature, "ui focus and locked signatures differ")
	_expect(selected.monochrome_signature != completed.monochrome_signature, "ui selected and completed signatures differ")
	_expect(SubmissionVisualTheme.glyph_for_family("echo", "", {"delay": 2}) == "E2", "echo delay-2 glyph is readable as E2")
	_expect(SubmissionVisualTheme.glyph_for_family("echo", "", {"delay": 3}) == "E3", "echo delay-3 glyph is readable as E3")
	_expect(SubmissionVisualTheme.glyph_for_family("echo", "", {"delay": 4}) == "E4", "echo delay-4 glyph is readable as E4")


func _test_runtime_focus_style(tree: SceneTree) -> void:
	var menu := MainMenuScene.instantiate()
	tree.root.add_child(menu)
	await tree.process_frame
	var play: Button = menu.get_node("MenuActions/Play")
	var focus_box: StyleBoxFlat = play.get_theme_stylebox("focus") as StyleBoxFlat
	_expect(focus_box != null, "runtime Play button has a focus StyleBox")
	_expect(focus_box.border_width_left >= 1 and focus_box.shadow_size >= 2 and focus_box.shadow_offset == Vector2.ZERO, "runtime focus uses visible inner and outer outlines")
	menu.queue_free()
	await tree.process_frame


func _test_level_presentation_contract(tree: SceneTree, path: String) -> void:
	var loaded := loader.load_file(path)
	_expect(loaded.ok and loaded.level is Dictionary and not loaded.level.is_empty(), "level payload loads for %s" % path.get_file().get_basename())
	if not loaded.ok or not loaded.level is Dictionary:
		return
	var level: Dictionary = loaded.level
	var board_rect := _board_rect(level)
	var initial_state := simulation.construct_initial_state(level)
	var before := _snapshot(level, initial_state)
	_expect(before.all(_descriptor_contract), "presentation contract holds for %s" % level.get("level_id", path.get_file()))
	_expect(before.all(func(d): return _in_bounds(d.bounds)), "presentation bounds in 960x540 for %s" % level.get("level_id", path.get_file()))
	_expect(before == _snapshot(level, simulation.construct_initial_state(level)), "presentation contract is deterministic for %s")
	var copied := before.duplicate(true)
	if not copied.is_empty():
		copied[0]["family"] = "MUTATED"
	_expect(_snapshot(level, initial_state) == before, "presentation snapshot is mutation-safe for %s" % path.get_file())
	var scene = GameplayScene.instantiate()
	scene.configure_route_payload({"level_id": level.get("level_id", path.get_file()), "level_path": path, "hud_mode": "STANDARD_COMPACT", "classification": "standard", "development_direct": true, "final_level": false})
	tree.root.add_child(scene)
	await tree.process_frame
	_expect(scene.get_schema_v2_presentation_snapshot() == before, "runtime snapshot equals helper snapshot for %s" % path.get_file())
	var expected_badges: Array[String] = []
	for echo in level.get("echoes", []):
		expected_badges.append("E%d" % int(echo.get("delay", 0)))
	_expect(scene.get_echo_delay_badges_snapshot() == expected_badges, "runtime ECHO delay badges are explicit for %s" % path.get_file())
	scene.queue_free()
	await tree.process_frame
	var restart: Dictionary = simulation.restart(level).state
	var after_restart := _snapshot(level, restart)
	_expect(after_restart == before, "presentation snapshot restores after restart for %s" % path.get_file())


func _snapshot(level: Dictionary, state: Dictionary) -> Array:
	return Presentation.build(level, state, _board_rect(level), 60.0, Rect2(0, 0, 960, 540))


func _board_rect(level: Dictionary) -> Rect2:
	var rows: Array = level.get("terrain_rows", [])
	if rows.is_empty():
		return Rect2(0, 0, 960, 540)
	var size := Vector2(rows[0].length(), rows.size()) * 60.0
	return Rect2(Vector2(24, 84) + (Vector2(540, 420) - size) * 0.5, size)


func _descriptor_contract(descriptor: Dictionary) -> bool:
	if not descriptor is Dictionary:
		return false
	for required in ["family", "stable_id", "cell", "position", "layer", "state_variant", "shape_token", "glyph_token", "type_group_token", "bounds", "monochrome_signature"]:
		if not descriptor.has(required):
			return false
	if not descriptor.bounds is Dictionary:
		return false
	for bound_key in ["x", "y", "width", "height"]:
		if not descriptor.bounds.has(bound_key):
			return false
	return descriptor.bounds.x >= 0 and descriptor.bounds.y >= 0 and descriptor.bounds.width > 0 and descriptor.bounds.height > 0


func _in_bounds(bounds: Dictionary) -> bool:
	return float(bounds.get("x", -1.0)) >= 0.0 and float(bounds.get("y", -1.0)) >= 0.0 and float(bounds.get("x", -1.0)) + float(bounds.get("width", 0.0)) <= 960.0 and float(bounds.get("y", -1.0)) + float(bounds.get("height", 0.0)) <= 540.0


func _expect(condition: bool, label: String) -> void:
	assertions += 1
	if not condition:
		failures += 1
		printerr("TASK_0024BAD_VISUAL_CONTRACT_FAIL " + label)

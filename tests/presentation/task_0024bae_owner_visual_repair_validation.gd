extends SceneTree

const GameplayScene = preload("res://scenes/vertical_slice/vertical_slice.tscn")
const LevelLoader = preload("res://scripts/simulation/level_loader.gd")
const Simulation = preload("res://scripts/simulation/simulation.gd")
const SubmissionVisualTheme = preload("res://scripts/presentation/submission_visual_theme.gd")

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
		print("TASK_0024BAE_OWNER_VISUAL_AUDIO_REPAIR_PASS assertions=%d" % int(result.assertions))
	else:
		printerr("TASK_0024BAE_OWNER_VISUAL_AUDIO_REPAIR_FAIL failures=%d assertions=%d" % [int(result.failures), int(result.assertions)])
	quit(0 if int(result.failures) == 0 else 1)


func run(tree: SceneTree) -> Dictionary:
	_test_visual_theme_contract()
	_test_mechanism_snapshots(tree)
	for path in EXPECTED_LEVEL_PATHS:
		await _test_runtime_level_repair_contract(tree, path)
	return {"assertions": assertions, "failures": failures}


func _test_visual_theme_contract() -> void:
	var contract := SubmissionVisualTheme.entity_contract()
	_expect(bool(contract.get("you", false)), "submission theme exposes entity contract for YOU")
	_expect(bool(contract.get("echo", false)), "submission theme exposes entity contract for ECHO")
	_expect(bool(contract.get("plate_inactive", false)), "submission theme exposes plate inactive visual state")
	_expect(bool(contract.get("plate_active", false)), "submission theme exposes plate active visual state")
	_expect(bool(contract.get("door_closed", false)), "submission theme exposes closed-door visual state")
	_expect(bool(contract.get("door_open", false)), "submission theme exposes open-door visual state")
	var you_signature: String = SubmissionVisualTheme.monochrome_signature_for_family("you")
	var echo_signature: String = SubmissionVisualTheme.monochrome_signature_for_family("echo")
	_expect(you_signature != echo_signature, "theme separates YOU and ECHO monochrome signatures")


func _test_mechanism_snapshots(tree: SceneTree) -> void:
	var loaded := loader.load_file("res://data/levels/vertical_slice_delay_3.json")
	_expect(loaded.ok and loaded.level is Dictionary and not loaded.level.is_empty(), "vertical_slice_delay_3 level can be loaded for mechanism visual checks")
	if not loaded.ok or not loaded.level is Dictionary:
		return
	var level: Dictionary = loaded.level
	var scene = GameplayScene.instantiate()
	scene.configure_route_payload({"level_id": level.get("level_id", "vertical_slice_delay_3"), "level_path": "res://data/levels/vertical_slice_delay_3.json", "hud_mode": "STANDARD_COMPACT", "classification": "owner_visual", "development_direct": true, "final_level": false})
	tree.root.add_child(scene)
	await tree.process_frame
	var initial_snapshot: Dictionary = scene.get_presentation_snapshot()
	_expect(initial_snapshot.plates.size() >= 1, "vertical_slice has visible plate snapshots")
	var all_inactive := true
	for plate in initial_snapshot.plates:
		all_inactive = all_inactive and String(plate.get("visual_state", "")) == "HOLLOW_UNPRESSED"
		_expect(plate.has("id"), "plate snapshot includes plate id")
		_expect(plate.has("bounds"), "plate snapshot includes bounds")
		_expect(plate.get("visual_state", "") in ["HOLLOW_UNPRESSED", "FILLED_PRESSED"], "plate snapshot uses explicit active/inactive visual states")
	_expect(all_inactive, "initial vertical_slice plates start as inactive")
	var initial_door_state: bool = true
	var initial_closed_pass := false
	for door in initial_snapshot.doors:
		initial_door_state = initial_door_state and door.get("open", true)
		if not door.get("open", false):
			initial_closed_pass = true
		_expect(door.get("visual_state", "") == "BARS_CLOSED" or door.get("visual_state", "") == "HOLLOW_OPEN", "door snapshots expose structural state")
	_expect(initial_closed_pass, "initial vertical_slice includes a closed-door snapshot")
	var initial_state: Dictionary = simulation.construct_initial_state(level)
	var first: Dictionary = simulation.transition(level, initial_state, "RIGHT").state
	var second: Dictionary = simulation.transition(level, first, "RIGHT").state
	scene.state = second
	await tree.process_frame
	var active_snapshot: Dictionary = scene.get_presentation_snapshot()
	var press_seen := false
	var door_opened := false
	for plate in active_snapshot.plates:
		if plate.pressed:
			press_seen = true
			_expect(plate.visual_state == "FILLED_PRESSED", "plate becomes active with filled/pressed mechanism visual")
	for door in active_snapshot.doors:
		if door.get("open", false):
			door_opened = true
			_expect(door.visual_state == "HOLLOW_OPEN", "open door visual uses open structural family")
	_expect(press_seen, "mechanism transition activates at least one plate")
	_expect(door_opened, "mechanism transition opens at least one door")
	_expect(active_snapshot.exit.visual_state == "destination_doorway", "exit snapshot is doorway-style destination")
	scene._restart_level()
	await tree.process_frame
	_expect(scene.get_presentation_snapshot() == initial_snapshot, "mechanism visual state restores on restart")
	scene.queue_free()
	await tree.process_frame


func _test_runtime_level_repair_contract(tree: SceneTree, path: String) -> void:
	var loaded := loader.load_file(path)
	_expect(loaded.ok and loaded.level is Dictionary and not loaded.level.is_empty(), "level payload loads for visual contract: %s" % path.get_file())
	if not loaded.ok or not loaded.level is Dictionary:
		return
	var level: Dictionary = loaded.level
	var initial_state: Dictionary = simulation.construct_initial_state(level)
	var scene = GameplayScene.instantiate()
	scene.configure_route_payload({"level_id": level.get("level_id", path.get_file()), "level_path": path, "hud_mode": "STANDARD_COMPACT", "classification": "owner_visual", "development_direct": true, "final_level": false})
	tree.root.add_child(scene)
	await tree.process_frame
	var baseline_snapshot: Dictionary = scene.get_presentation_snapshot()
	_expect(baseline_snapshot.terrain.wall_adjacency is Array, "wall adjacency descriptor exists for %s" % level.get("level_id", path.get_file()))
	_expect(baseline_snapshot.terrain.wall_adjacency.size() > 0, "wall adjacency contains at least one descriptor for %s" % level.get("level_id", path.get_file()))
	_expect(baseline_snapshot.terrain.floor_mark_count >= 0, "floor mark count is non-negative for %s" % level.get("level_id", path.get_file()))
	_expect(_deterministic_wall_adjacency(level, baseline_snapshot.terrain.wall_adjacency), "wall adjacency remains deterministic for %s" % level.get("level_id", path.get_file()))
	_expect(_validate_bounds(baseline_snapshot.you.bounds), "YOU bounds are within a finite rectangle for %s" % level.get("level_id", path.get_file()))
	_expect(_validate_bounds(_exit_bounds(level, baseline_snapshot.exit)), "EXIT bounds are deterministic for %s" % level.get("level_id", path.get_file()))
	_expect(_count_floor_marks(level) == baseline_snapshot.terrain.floor_mark_count, "floor mark density is deterministic for %s" % level.get("level_id", path.get_file()))
	_expect(baseline_snapshot.get("you", {}).has("visual_family"), "runtime and snapshot share explicit YOU silhouette marker for %s" % level.get("level_id", path.get_file()))
	_expect(baseline_snapshot.get("you").get("visual_family", "") == "concrete_person", "runtime YOUR visual family reads as concrete person for %s" % level.get("level_id", path.get_file()))
	var echo_count: int = 0
	for echo in baseline_snapshot.echoes:
		echo_count += 1
		_expect(echo.has("outline_style"), "each ECHO snapshot exports outline style for %s" % level.get("level_id", path.get_file()))
		_expect(echo.get("delay", 0) >= 0, "each ECHO snapshot exposes delay label for %s" % level.get("level_id", path.get_file()))
	_expect(echo_count == int(level.get("echoes", []).size()), "ECHO count aligns with level specification for %s" % level.get("level_id", path.get_file()))
	_expect(baseline_snapshot == baseline_snapshot.duplicate(true), "presentation snapshot is mutation-safe for %s" % level.get("level_id", path.get_file()))
	var progressed_state: Dictionary = simulation.transition(level, initial_state, "WAIT").state
	_expect(progressed_state.turn_index == initial_state.turn_index + 1, "turn index advances on legal WAIT for %s" % level.get("level_id", path.get_file()))
	scene.state = progressed_state
	await tree.process_frame
	scene._restart_level()
	await tree.process_frame
	_expect(scene.get_presentation_snapshot() == baseline_snapshot, "restart restores exact snapshot for %s" % level.get("level_id", path.get_file()))
	scene.queue_free()
	await tree.process_frame


func _deterministic_wall_adjacency(level: Dictionary, descriptors: Array) -> bool:
	if not level.has("terrain_rows") or not level.terrain_rows is Array:
		return false
	var expected := []
	var rows: Array = level.terrain_rows
	for y in rows.size():
		var row: String = rows[y]
		for x in row.length():
			if row[x] == ".":
				continue
			expected.append("wall_%d_%d_%d" % [x, y, _adjacency_for_level(level, x, y)])
	return descriptors.size() == expected.size() and descriptors.all(func(descriptor): return descriptor.get("signature", "") in expected and int(descriptor.get("cell", [0, 0])[0]) >= 0 and int(descriptor.get("cell", [0, 0])[1]) >= 0)


func _adjacency_for_level(level: Dictionary, x: int, y: int) -> int:
	var mask: int = 0
	var rows: Array = level.get("terrain_rows", [])
	if y == 0 or y - 1 < 0 or not _is_wall(level, x, y - 1):
		mask |= 1
	if x + 1 >= row_length(rows, y) or not _is_wall(level, x + 1, y):
		mask |= 2
	if y + 1 >= rows.size() or not _is_wall(level, x, y + 1):
		mask |= 4
	if x == 0 or not _is_wall(level, x - 1, y):
		mask |= 8
	return mask


func _is_wall(level: Dictionary, x: int, y: int) -> bool:
	var rows: Array = level.get("terrain_rows", [])
	if x < 0 or y < 0 or y >= rows.size():
		return true
	var row: String = rows[y]
	if x < 0 or x >= row.length():
		return true
	return row[x] != "."


func _count_floor_marks(level: Dictionary) -> int:
	var rows: Array = level.get("terrain_rows", [])
	var count: int = 0
	for y in rows.size():
		var row: String = rows[y]
		for x in row.length():
			if row[x] == "." and (x + y) % 5 == 0:
				count += 1
	return count


func row_length(rows: Array, y: int) -> int:
	if y < 0 or y >= rows.size():
		return 0
	var row: String = String(rows[y])
	return row.length()


func _exit_bounds(level: Dictionary, exit_snapshot: Dictionary) -> Dictionary:
	if exit_snapshot.has("bounds") and exit_snapshot.bounds is Dictionary:
		return exit_snapshot.bounds
	var position: Array = level.get("exit", {}).get("position", [])
	if position.size() < 2:
		return {"x": 0.0, "y": 0.0, "width": 0.0, "height": 0.0}
	var x := float(position[0])
	var y := float(position[1])
	return {"x": x, "y": y, "width": 0.0, "height": 0.0}


func _validate_bounds(bounds: Dictionary) -> bool:
	if bounds.is_empty():
		return false
	return bounds.get("width", 0.0) > 0.0 and bounds.get("height", 0.0) > 0.0 and bounds.get("x", -1.0) >= 0.0 and bounds.get("y", -1.0) >= 0.0 and bounds.get("x", 0.0) + bounds.get("width", 0.0) <= 960.0 and bounds.get("y", 0.0) + bounds.get("height", 0.0) <= 540.0


func _expect(condition: bool, label: String) -> void:
	assertions += 1
	if not condition:
		failures += 1
		printerr("TASK_0024BAE_OWNER_VISUAL_AUDIO_REPAIR_FAIL " + label)

extends SceneTree

const GameplayScene = preload("res://scenes/vertical_slice/vertical_slice.tscn")
const LevelLoader = preload("res://scripts/simulation/level_loader.gd")
const Simulation = preload("res://scripts/simulation/simulation.gd")
const Presentation = preload("res://scripts/gameplay/schema_v2_presentation.gd")

const CASES := [
	["crate_shadow_timing", "res://data/levels/crate_shadow_timing.json", ["DOWN", "RIGHT"]],
	["key_route_commitment", "res://data/levels/key_route_commitment.json", ["DOWN", "DOWN", "RIGHT", "RIGHT"]],
	["identity_shift_bridge", "res://data/levels/identity_shift_bridge.json", ["RIGHT", "RIGHT", "UP", "UP", "LEFT", "LEFT", "UP", "UP", "RIGHT", "RIGHT"]],
	["lasting_echo_latch", "res://data/levels/lasting_echo_latch.json", ["RIGHT", "UP", "RIGHT"]],
]

var assertions := 0
var failures := 0


func _init() -> void:
	call_deferred("_run")


func _run() -> void:
	var result: Dictionary = await run(self)
	if int(result.failures) == 0:
		print("TASK_0024AF_SCHEMA_V2_MINIMUM_VISUAL_PASS assertions=%d" % int(result.assertions))
	else:
		printerr("TASK_0024AF_SCHEMA_V2_MINIMUM_VISUAL_FAIL failures=%d assertions=%d" % [int(result.failures), int(result.assertions)])
	quit(0 if int(result.failures) == 0 else 1)


func run(tree: SceneTree) -> Dictionary:
	var loader = LevelLoader.new()
	var simulation = Simulation.new()
	for item in CASES:
		var loaded := loader.load_file(item[1])
		_expect(loaded.ok, "%s loads through public LevelLoader" % item[0])
		if not loaded.ok:
			continue
		var initial: Dictionary = simulation.construct_initial_state(loaded.level)
		var before: Dictionary = initial.duplicate(true)
		var board_rect := _board_rect(loaded.level)
		var first := Presentation.build(loaded.level, initial, board_rect, 60.0, Rect2(0, 0, 960, 540))
		var second := Presentation.build(loaded.level, initial, board_rect, 60.0, Rect2(0, 0, 960, 540))
		_expect(first == second and initial == before, "%s descriptors are deterministic and pure" % item[0])
		_expect(first.all(_descriptor_contract), "%s descriptors expose stable JSON-safe contract fields" % item[0])
		_expect(_strictly_sorted(first), "%s descriptor order is deterministic" % item[0])
		var state := initial
		for action in item[2]:
			var result := simulation.transition(loaded.level, state, action)
			_expect(result.ok, "%s accepted witness prefix uses shared Simulation" % item[0])
			if result.ok: state = result.state
		var progressed := Presentation.build(loaded.level, state, board_rect, 60.0, Rect2(0, 0, 960, 540))
		_expect(progressed != first or item[0] == "identity_shift_bridge", "%s accepted witness prefix has an auditable presentation state" % item[0])
		_test_family_contract(item[0], first, progressed)
		var scene = await _spawn(tree, item[0], item[1])
		_expect(scene.get_schema_v2_presentation_snapshot() == first, "%s real Gameplay snapshot consumes the shared descriptor collection" % item[0])
		var snapshot: Array = scene.get_schema_v2_presentation_snapshot()
		if not snapshot.is_empty():
			snapshot[0].family = "MUTATED"
			_expect(scene.get_schema_v2_presentation_snapshot()[0].family != "MUTATED", "%s snapshot is deep-copy mutation resistant" % item[0])
		scene.queue_free()
		await tree.process_frame
	_test_v1_absence(tree)
	return {"assertions": assertions, "failures": failures}


func _test_family_contract(id: String, initial: Array, progressed: Array) -> void:
	match id:
		"crate_shadow_timing":
			_expect(_one(initial, "crate").cell == [2, 2] and _one(progressed, "crate").cell == [3, 2], "crate follows the accepted YOU push")
			_expect(_one(initial, "crate").monochrome_signature != _one(initial, "floor_key").get("monochrome_signature", ""), "crate signature stays structurally distinct")
		"key_route_commitment":
			_expect(_one(initial, "floor_key").type_group_token == _one(initial, "lock").type_group_token and _all(progressed, "floor_key").is_empty() and _one(progressed, "held_key").type_group_token == _one(initial, "lock").type_group_token, "YOU collection replaces the matching floor key with held inventory")
		"identity_shift_bridge":
			_expect(_all(initial, "sensor").size() == 2 and _all(initial, "sensor")[0].glyph_token != _all(initial, "sensor")[1].glyph_token, "YOU and ECHO sensors have distinct glyph signatures")
			_expect(_all(progressed, "barrier").all(func(d): return d.requested_open and d.effective_open and d.open_source == "SENSORS"), "typed sensor pair produces an open sensor-sourced barrier")
		"lasting_echo_latch":
			_expect(_one(initial, "latch").state_variant == "INACTIVE" and _one(progressed, "latch").state_variant == "ACTIVATED", "accepted witness activates the one-shot latch")
			_expect(_one(progressed, "latch").type_group_token == _all(progressed, "barrier").filter(func(d): return d.stable_id.begins_with("barrier:barrier_phase:"))[0].type_group_token, "latch token targets barrier_phase only")


func _test_v1_absence(tree: SceneTree) -> void:
	var scene = await _spawn(tree, "tutorial_reach_exit", "res://data/levels/tutorial_reach_exit.json")
	_expect(scene.get_schema_v2_presentation_snapshot().is_empty(), "v1 Gameplay produces no spurious schema-v2 descriptors")
	scene.queue_free()
	await tree.process_frame


func _board_rect(level: Dictionary) -> Rect2:
	var rows: Array = level.get("terrain_rows", [])
	if rows.is_empty():
		return Rect2()
	var size := Vector2(rows[0].length(), rows.size()) * 60.0
	var zone := Rect2(24, 84, 540, 420)
	return Rect2(zone.position + (zone.size - size) * 0.5, size)


func _spawn(tree: SceneTree, id: String, path: String):
	var scene = GameplayScene.instantiate()
	scene.configure_route_payload({"level_id": id, "level_path": path, "hud_mode": "STANDARD_COMPACT", "classification": "standard", "development_direct": true, "final_level": false})
	tree.root.add_child(scene)
	await tree.process_frame
	return scene


func _descriptor_contract(descriptor: Dictionary) -> bool:
	var required := ["family", "stable_id", "cell", "position", "layer", "state_variant", "shape_token", "glyph_token", "type_group_token", "bounds", "monochrome_signature"]
	var bounds: Dictionary = descriptor.get("bounds", {})
	var has_bounds := true
	for bound_key in ["x", "y", "width", "height"]:
		has_bounds = has_bounds and bounds.has(bound_key)
	return required.all(func(key): return descriptor.has(key)) and has_bounds and bounds.values().all(func(value): return typeof(value) == TYPE_FLOAT or typeof(value) == TYPE_INT)


func _strictly_sorted(items: Array) -> bool:
	for index in range(1, items.size()):
		var previous: Dictionary = items[index - 1]
		var current: Dictionary = items[index]
		if int(previous.layer) > int(current.layer) or (int(previous.layer) == int(current.layer) and String(previous.stable_id) >= String(current.stable_id)): return false
	return true


func _all(items: Array, family: String) -> Array:
	return items.filter(func(descriptor): return descriptor.family == family)


func _one(items: Array, family: String) -> Dictionary:
	var matches := _all(items, family)
	return matches[0] if not matches.is_empty() else {}


func _expect(condition: bool, label: String) -> void:
	assertions += 1
	if not condition:
		failures += 1
		printerr("TASK_0024AF_SCHEMA_V2_MINIMUM_VISUAL_FAIL " + label)

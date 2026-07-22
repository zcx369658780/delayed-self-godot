extends SceneTree

## This validator intentionally drives the public loader and Simulation.  It does
## not recreate transition, collision, restart, or descriptor mechanics.
const GameplayScene = preload("res://scenes/vertical_slice/vertical_slice.tscn")
const LevelLoader = preload("res://scripts/simulation/level_loader.gd")
const Simulation = preload("res://scripts/simulation/simulation.gd")
const Presentation = preload("res://scripts/gameplay/schema_v2_presentation.gd")
const ACTIONS := ["UP", "RIGHT", "DOWN", "LEFT", "WAIT"]
const V2 := [
	["crate_shadow_timing", "res://data/levels/crate_shadow_timing.json"],
	["key_route_commitment", "res://data/levels/key_route_commitment.json"],
	["identity_shift_bridge", "res://data/levels/identity_shift_bridge.json"],
	["lasting_echo_latch", "res://data/levels/lasting_echo_latch.json"],
]
const V1 := ["door_one_turn_late", "echo_spacing_bridge", "staggered_doors", "tutorial_echo_bridge", "tutorial_reach_exit", "two_echo_convergence", "two_keys_one_door", "vertical_slice_delay_3"]

var assertions := 0
var failures := 0
var loader = LevelLoader.new()
var simulation = Simulation.new()

func _init() -> void:
	call_deferred("_run")

func _run() -> void:
	for item in V2:
		var loaded := loader.load_file(item[1])
		_expect(loaded.ok, "%s public LevelLoader" % item[0])
		if loaded.ok: await _base_contract(item[0], item[1], loaded.level)
	await _crate_lifecycle()
	await _key_lifecycle()
	await _sensor_lifecycle()
	await _latch_lifecycle()
	await _fit_layering_and_v1()
	_emit("summary", {"assertions": assertions, "failures": failures})
	if failures == 0:
		print("TASK_0024AG_SCHEMA_V2_VISUAL_CORRECTION_PASS assertions=%d" % assertions)
		quit(0)
	printerr("TASK_0024AG_SCHEMA_V2_VISUAL_CORRECTION_FAIL failures=%d assertions=%d" % [failures, assertions])
	quit(1)

func _base_contract(id: String, path: String, level: Dictionary) -> void:
	var initial := simulation.construct_initial_state(level)
	var before := initial.duplicate(true)
	var first := _snapshot(level, initial)
	var second := _snapshot(level, initial)
	_expect(first == second and initial == before, "%s pure deterministic helper" % id)
	_expect(first.all(_descriptor_contract) and _strictly_sorted(first), "%s complete ordered descriptor contract" % id)
	_expect(_expected_count(level, initial) == first.size(), "%s descriptor count exactly matches visible v2 state" % id)
	var scene = await _spawn(id, path)
	_expect(scene.get_schema_v2_presentation_snapshot() == first, "%s Gameplay uses helper output" % id)
	var copy: Array = scene.get_schema_v2_presentation_snapshot()
	if not copy.is_empty(): copy[0]["family"] = "MUTATED"
	_expect(scene.get_schema_v2_presentation_snapshot() == first, "%s Gameplay snapshot deep copy" % id)
	scene.queue_free()
	await process_frame
	_emit("inventory", {"level": id, "descriptor_count": first.size(), "families": _families(first)})

func _crate_lifecycle() -> void:
	var level := _load(V2[0][1])
	var initial := simulation.construct_initial_state(level)
	var moved := _find(level, func(s): return _one(_snapshot(level, s), "crate").get("cell", []) != [2, 2])
	_expect(not moved.is_empty(), "crate accepted YOU push witness exists")
	_expect(_one(_snapshot(level, initial), "crate").get("cell", []) == [2, 2], "crate initial cell")
	if not moved.is_empty():
		_expect(_one(_snapshot(level, moved.state), "crate").get("cell", []) == [3, 2], "crate exact YOU movement")
		_expect(not _echo_moved_crate(level, moved.actions), "ECHO never pushes crate in witness prefix")
	var restored := simulation.construct_initial_state(level)
	_expect(_snapshot(level, restored) == _snapshot(level, initial), "crate restart restoration")
	_emit("crate_lifecycle", {"initial": _one(_snapshot(level, initial), "crate").get("cell", []), "moved": _one(_snapshot(level, moved.get("state", initial)), "crate").get("cell", [])})

func _key_lifecycle() -> void:
	var level := _load(V2[1][1])
	var initial := simulation.construct_initial_state(level)
	var collected := _find(level, func(s): return not s.get("remaining_key_ids", []).has("key_main") and s.get("removed_lock_ids", []).is_empty())
	var consumed := _find(level, func(s): return s.get("removed_lock_ids", []).has("lock_main") and s.get("held_keys", []).is_empty())
	var start := _snapshot(level, initial)
	_expect(_one(start, "floor_key").get("type_group_token", "") == _one(start, "lock").get("type_group_token", ""), "key and lock stable matching token")
	_expect(not collected.is_empty() and not consumed.is_empty(), "key collection and lock consumption witnesses exist")
	if not collected.is_empty(): _expect(_all(_snapshot(level, collected.state), "floor_key").is_empty() and _all(_snapshot(level, collected.state), "held_key").size() == 1, "YOU collection exchanges floor and inventory")
	if not consumed.is_empty(): _expect(_all(_snapshot(level, consumed.state), "lock").is_empty() and _all(_snapshot(level, consumed.state), "held_key").is_empty(), "matching lock consumes held key")
	_expect(_snapshot(level, simulation.construct_initial_state(level)) == start, "key restart restoration")
	_emit("key_lock_lifecycle", {"collected": not collected.is_empty(), "consumed": not consumed.is_empty()})

func _sensor_lifecycle() -> void:
	var level := _load(V2[2][1])
	var initial := _snapshot(level, simulation.construct_initial_state(level))
	var active := _find(level, func(s): return _all(_snapshot(level, s), "sensor").all(func(d): return String(d.state_variant).ends_with("ACTIVE")) and _all(_snapshot(level, s), "barrier").all(func(d): return bool(d.effective_open)))
	_expect(_all(initial, "sensor").size() == 2 and _all(initial, "sensor")[0].monochrome_signature != _all(initial, "sensor")[1].monochrome_signature, "typed inactive sensors retain distinct monochrome signatures")
	_expect(not active.is_empty(), "paired typed sensor occupancy witness exists")
	if not active.is_empty():
		var descriptors := _snapshot(level, active.state)
		_expect(_all(descriptors, "sensor").all(func(d): return String(d.state_variant).ends_with("ACTIVE")), "both correct sensors active")
		_expect(_all(descriptors, "barrier").all(func(d): return d.open_source == "SENSORS" and d.type_group_token == "G1"), "group token and open barrier state")
	_expect(_snapshot(level, simulation.construct_initial_state(level)) == initial, "sensor restart closed inactive restoration")
	_emit("sensor_barrier_lifecycle", {"paired_active": not active.is_empty(), "initial_barriers": _all(initial, "barrier").size()})

func _latch_lifecycle() -> void:
	var level := _load(V2[3][1])
	var initial := _snapshot(level, simulation.construct_initial_state(level))
	var active := _find(level, func(s): return bool(s.get("latch_states", [{}])[0].get("activated", false)))
	_expect(_one(initial, "latch").get("state_variant", "") == "INACTIVE", "latch initial presentation")
	_expect(not active.is_empty(), "latch activation witness exists")
	if not active.is_empty():
		var descriptors := _snapshot(level, active.state)
		_expect(_one(descriptors, "latch").get("state_variant", "") == "ACTIVATED", "latch committed presentation")
		var phase := _all(descriptors, "barrier").filter(func(d): return String(d.stable_id).begins_with("barrier:barrier_phase:"))
		var typed := _all(descriptors, "barrier").filter(func(d): return String(d.stable_id).begins_with("barrier:barrier_typed:"))
		_expect(not phase.is_empty() and not typed.is_empty() and phase[0].type_group_token != typed[0].type_group_token and _one(descriptors, "latch").type_group_token == phase[0].type_group_token, "latch targets phase group only")
	_expect(_snapshot(level, simulation.construct_initial_state(level)) == initial, "latch restart restoration")
	_emit("latch_lifecycle", {"activated": not active.is_empty()})

func _fit_layering_and_v1() -> void:
	var signatures := {}
	for item in V2:
		var level := _load(item[1])
		var snap := _snapshot(level, simulation.construct_initial_state(level))
		for d in snap:
			var b: Dictionary = d.bounds
			_expect(b.x >= 0 and b.y >= 0 and b.x + b.width <= 960 and b.y + b.height <= 540, "%s descriptor fits gameplay area" % item[0])
			_expect(_layer_ok(d), "%s layer family ordering" % item[0])
			if ["crate","floor_key","held_key","lock","sensor","barrier","latch"].has(d.family): signatures[d.monochrome_signature] = true
	_expect(signatures.size() >= 13, "required monochrome structural signatures do not collapse")
	for id in V1:
		var loaded := loader.load_file("res://data/levels/%s.json" % id)
		_expect(loaded.ok, "%s loads" % id)
		if loaded.ok: _expect(_snapshot(loaded.level, simulation.construct_initial_state(loaded.level)).is_empty(), "%s has no v2 descriptors" % id)
	_emit("fit_layering_v1_regression", {"v1_checked": V1.size(), "unique_signatures": signatures.size()})

func _find(level: Dictionary, predicate: Callable) -> Dictionary:
	var queue := [{"state": simulation.construct_initial_state(level), "actions": []}]
	var seen := {}
	while not queue.is_empty() and seen.size() < 4000:
		var node: Dictionary = queue.pop_front()
		var key := simulation.canonical_key(node.state)
		if seen.has(key): continue
		seen[key] = true
		if predicate.call(node.state): return node
		for action in ACTIONS:
			var result := simulation.transition(level, node.state, action)
			if result.ok:
				var next_actions: Array = node.actions.duplicate(); next_actions.append(action)
				queue.append({"state": result.state, "actions": next_actions})
	return {}

func _echo_moved_crate(level: Dictionary, actions: Array) -> bool:
	var state := simulation.construct_initial_state(level)
	for action in actions:
		var before := state.duplicate(true)
		var result := simulation.transition(level, state, action)
		if not result.ok: return true
		state = result.state
		if before.get("crate_positions", []) != state.get("crate_positions", []) and before.get("player_position", []) == state.get("player_position", []): return true
	return false

func _snapshot(level: Dictionary, state: Dictionary) -> Array:
	return Presentation.build(level, state, _board_rect(level), 60.0, Rect2(0, 0, 960, 540))

func _expected_count(level: Dictionary, state: Dictionary) -> int:
	return state.get("crate_positions", []).size() + state.get("remaining_key_ids", []).size() + (level.get("locks", []).size() - state.get("removed_lock_ids", []).size()) + level.get("sensors", []).size() + level.get("barrier_groups", []).reduce(func(n, g): return n + g.cells.size(), 0) + level.get("latches", []).size() + state.get("held_keys", []).size()

func _load(path: String) -> Dictionary:
	var loaded := loader.load_file(path)
	_expect(loaded.ok, "load %s" % path)
	return loaded.level if loaded.ok else {}

func _spawn(id: String, path: String):
	var scene = GameplayScene.instantiate()
	scene.configure_route_payload({"level_id": id, "level_path": path, "hud_mode": "STANDARD_COMPACT", "classification": "standard", "development_direct": true, "final_level": false})
	root.add_child(scene); await process_frame
	return scene

func _board_rect(level: Dictionary) -> Rect2:
	var rows: Array = level.get("terrain_rows", [])
	var size := Vector2(rows[0].length(), rows.size()) * 60.0
	return Rect2(Vector2(24, 84) + (Vector2(540, 420) - size) * 0.5, size)

func _descriptor_contract(d: Dictionary) -> bool:
	for key in ["family","stable_id","cell","position","layer","state_variant","shape_token","glyph_token","type_group_token","bounds","monochrome_signature"]:
		if not d.has(key) or d[key] == null: return false
	return d.bounds.has_all(["x","y","width","height"]) and d.position.has_all(["x","y"])

func _strictly_sorted(items: Array) -> bool:
	for i in range(1, items.size()):
		if int(items[i - 1].layer) > int(items[i].layer) or (int(items[i - 1].layer) == int(items[i].layer) and String(items[i - 1].stable_id) >= String(items[i].stable_id)): return false
	return true

func _layer_ok(d: Dictionary) -> bool:
	return (d.family == "barrier" and int(d.layer) <= 2) or (d.family == "sensor" and int(d.layer) == 1) or (d.family in ["crate","floor_key","lock","latch"] and int(d.layer) == 2) or (d.family == "held_key" and int(d.layer) == 5)

func _all(items: Array, family: String) -> Array: return items.filter(func(d): return d.family == family)
func _one(items: Array, family: String) -> Dictionary:
	var values := _all(items, family); return values[0] if not values.is_empty() else {}
func _families(items: Array) -> Array:
	var result: Array = []
	for descriptor in items:
		result.append(descriptor.family)
	return result
func _expect(ok: bool, label: String) -> void:
	assertions += 1
	if not ok: failures += 1; printerr("TASK_0024AG_SCHEMA_V2_VISUAL_CORRECTION_FAIL " + label)
func _emit(kind: String, body: Dictionary) -> void:
	body["schema_version"] = 1; body["kind"] = kind; print("TASK_0024AG_EVIDENCE " + JSON.stringify(body))

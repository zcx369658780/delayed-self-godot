extends SceneTree

## Task 0024AI validates the public loader-to-Gameplay route contract before
## sampling schema-v2 descriptors.  Simulation remains transition authority.
const GameplayScene = preload("res://scenes/vertical_slice/vertical_slice.tscn")
const LevelLoader = preload("res://scripts/simulation/level_loader.gd")
const Simulation = preload("res://scripts/simulation/simulation.gd")
const Presentation = preload("res://scripts/gameplay/schema_v2_presentation.gd")
const CANDIDATES := {
	"crate": "res://data/levels/crate_shadow_timing.json",
	"key": "res://data/levels/key_route_commitment.json",
	"sensor": "res://data/levels/identity_shift_bridge.json",
	"latch": "res://data/levels/lasting_echo_latch.json",
}
const V1 := ["door_one_turn_late", "echo_spacing_bridge", "staggered_doors", "tutorial_echo_bridge", "tutorial_reach_exit", "two_echo_convergence", "two_keys_one_door", "vertical_slice_delay_3"]
const WITNESSES := {
	"crate": ["DOWN", "RIGHT", "DOWN", "DOWN", "DOWN", "RIGHT", "RIGHT", "UP", "RIGHT", "UP", "RIGHT", "UP", "RIGHT", "UP"],
	"key": ["DOWN", "DOWN", "RIGHT", "RIGHT", "LEFT", "LEFT", "UP", "UP", "RIGHT", "RIGHT", "UP", "RIGHT", "RIGHT", "RIGHT", "RIGHT", "UP", "UP", "LEFT", "LEFT"],
	"sensor": ["RIGHT", "RIGHT", "UP", "UP", "LEFT", "LEFT", "UP", "UP", "RIGHT", "RIGHT", "RIGHT", "RIGHT", "RIGHT", "RIGHT", "RIGHT", "RIGHT", "DOWN", "DOWN"],
	"latch": ["RIGHT", "UP", "RIGHT", "UP", "UP", "UP", "UP", "LEFT", "LEFT", "UP", "UP", "RIGHT", "RIGHT", "RIGHT", "RIGHT", "RIGHT", "RIGHT", "RIGHT", "RIGHT", "DOWN", "DOWN"],
}
const REQUIRED := ["crate", "floor_key", "held_key", "lock", "sensor_you_inactive", "sensor_you_active", "sensor_echo_inactive", "sensor_echo_active", "barrier_closed", "barrier_open", "barrier_open_deferred", "latch_inactive", "latch_activated"]
var assertions := 0
var failures := 0
var loader = LevelLoader.new()
var simulation = Simulation.new()
var registry := {}

func _init() -> void: call_deferred("_run")

func _run() -> void:
	var levels := {}
	for alias in CANDIDATES:
		var path: String = CANDIDATES[alias]
		var loaded := loader.load_file(path)
		_expect(loaded.ok and loaded.level is Dictionary and not String(loaded.level.get("level_id", "")).is_empty(), "%s public loaded exact nonempty level ID" % alias)
		if loaded.ok and loaded.level is Dictionary and not String(loaded.level.get("level_id", "")).is_empty():
			levels[alias] = loaded.level
			await _candidate_route_preflight(alias, path, loaded.level)
	if failures == 0 and levels.size() == CANDIDATES.size():
		for alias in CANDIDATES: await _base_contract(alias, CANDIDATES[alias], levels[alias])
		_crate(levels.crate); _key(levels.key); _sensor(levels.sensor); _latch(levels.latch)
		_registry_contract(); _fit_layering_and_v1(levels)
	_emit("summary", {"assertions": assertions, "failures": failures, "signature_count": registry.size(), "candidate_count": levels.size()})
	if failures == 0:
		print("TASK_0024AI_CANDIDATE_ROUTE_DYNAMIC_SIGNATURE_PASS assertions=%d" % assertions)
		quit(0)
	printerr("TASK_0024AI_CANDIDATE_ROUTE_DYNAMIC_SIGNATURE_FAIL failures=%d assertions=%d" % [failures, assertions])
	quit(1)

func _candidate_route_preflight(alias: String, path: String, level: Dictionary) -> void:
	var actual_id := String(level.get("level_id", ""))
	var expected := _snapshot(level, simulation.construct_initial_state(level))
	var scene = GameplayScene.instantiate()
	var configured: bool = scene.configure_route_payload({"level_id": actual_id, "level_path": path, "hud_mode": "STANDARD_COMPACT", "classification": "candidate", "development_direct": true, "final_level": false})
	_expect(configured, "%s route payload configures with loaded ID" % alias)
	root.add_child(scene)
	await process_frame
	var runtime_ready: bool = scene.is_runtime_ready()
	var route: Dictionary = scene.get_route_payload()
	var actual: Array = scene.get_schema_v2_presentation_snapshot()
	_expect(scene.load_error == "" and scene.load_error != "LEVEL_ID_MISMATCH", "%s no Gameplay level ID mismatch" % alias)
	_expect(runtime_ready, "%s Gameplay runtime ready" % alias)
	_expect(route.get("level_id", "") == actual_id and route.get("level_path", "") == path, "%s route binds exact public loaded ID and path" % alias)
	_expect(actual == expected, "%s Gameplay snapshot equals helper initial state" % alias)
	var copy: Array = actual.duplicate(true)
	if not copy.is_empty(): copy[0]["family"] = "MUTATED"
	_expect(scene.get_schema_v2_presentation_snapshot() == expected, "%s Gameplay snapshot deep-copy resistant" % alias)
	_emit("candidate_route_preflight", {"alias": alias, "loaded_level_id": actual_id, "exact_path": path, "configure_status": configured, "runtime_ready": runtime_ready, "snapshot_equal": actual == expected})
	scene.queue_free()
	await process_frame
	_expect(not is_instance_valid(scene), "%s scene freed before next candidate" % alias)

func _base_contract(alias: String, path: String, level: Dictionary) -> void:
	var initial := simulation.construct_initial_state(level); var before := initial.duplicate(true); var first := _snapshot(level, initial)
	_expect(first == _snapshot(level, initial) and initial == before, "%s helper deterministic and pure" % alias)
	_expect(first.all(_descriptor_contract) and _strictly_sorted(first), "%s descriptor contract and order" % alias)
	_expect(first.size() == _expected_count(level, initial), "%s exact initial inventory" % alias)
	_emit("inventory", {"alias": alias, "level_id": level.level_id, "descriptor_count": first.size(), "families": _families(first)})

func _crate(level: Dictionary) -> void:
	var states := _states(level, WITNESSES.crate); var initial := _snapshot(level, states[0]); var at2 := _snapshot(level, states[2]); var at3 := _snapshot(level, states[3])
	var first := _one(initial, "crate"); var moved := _one(at2, "crate")
	_expect(first.cell == [2, 2] and moved.cell == [3, 2] and _one(at3, "crate").cell == moved.cell, "crate action 2 YOU pushes and action 3 ECHO is inert")
	_expect(first.monochrome_signature == moved.monochrome_signature, "crate movement retains structure")
	_register("crate", level.level_id, 0, first, "initial; action 2 moved YOU crate; action 3 ECHO inert")
	_expect(_snapshot(level, simulation.construct_initial_state(level)) == initial, "crate restart restoration")
	_emit("crate_lifecycle", {"initial_cell": first.cell, "action_2_cell": moved.cell, "action_3_cell": _one(at3, "crate").cell})

func _key(level: Dictionary) -> void:
	var states := _states(level, WITNESSES.key); var initial := _snapshot(level, states[0]); var at4 := _snapshot(level, states[4]); var at12 := _snapshot(level, states[12])
	var floor := _one(initial, "floor_key"); var lock := _one(initial, "lock"); var held := _one(at4, "held_key")
	_expect(floor.type_group_token == lock.type_group_token and floor.monochrome_signature != lock.monochrome_signature, "key lock token common but structures distinct")
	_expect(_all(at4, "floor_key").is_empty() and _all(at4, "held_key").size() == 1 and _all(at12, "lock").is_empty() and _all(at12, "held_key").is_empty(), "key action 4 held and action 12 consumes lock/key")
	_register("floor_key", level.level_id, 0, floor, "initial floor key"); _register("lock", level.level_id, 0, lock, "initial lock"); _register("held_key", level.level_id, 4, held, "action 4 held inventory")
	_expect(_snapshot(level, simulation.construct_initial_state(level)) == initial, "key restart restoration")
	_emit("key_lock_inventory_lifecycle", {"action_4_held": _all(at4, "held_key").size(), "action_12_locks": _all(at12, "lock").size()})

func _sensor(level: Dictionary) -> void:
	var states := _states(level, WITNESSES.sensor); var initial := _snapshot(level, states[0]); var at10 := _snapshot(level, states[10]); var at11 := _snapshot(level, states[11]); var at12 := _snapshot(level, states[12]); var at13 := _snapshot(level, states[13])
	var you0 := _by_variant(_all(initial, "sensor"), "YOU_INACTIVE"); var echo0 := _by_variant(_all(initial, "sensor"), "ECHO_INACTIVE"); var you10 := _by_variant(_all(at10, "sensor"), "YOU_ACTIVE"); var echo10 := _by_variant(_all(at10, "sensor"), "ECHO_ACTIVE")
	_expect(not you0.is_empty() and not echo0.is_empty() and not you10.is_empty() and not echo10.is_empty(), "sensor action 10 correct typed actors active")
	_expect(_all(at10, "barrier").all(func(d): return bool(d.effective_open)), "sensor action 10 barrier group open")
	for snap in [at11, at12]: _expect(not _all(snap, "barrier").filter(func(d): return d.state_variant == "OPEN_DEFERRED" and bool(d.closure_deferred)).is_empty(), "sensor actions 11/12 occupied closure deferred")
	_expect(_all(at13, "barrier").all(func(d): return d.state_variant == "CLOSED"), "sensor action 13 closes after vacancy")
	_expect(_all(_snapshot(level, states[9]), "sensor").all(func(d): return not String(d.state_variant).ends_with("ACTIVE")), "wrong actor cannot impersonate active sensor")
	_register("sensor_you_inactive", level.level_id, 0, you0, "initial YOU sensor"); _register("sensor_echo_inactive", level.level_id, 0, echo0, "initial ECHO sensor"); _register("sensor_you_active", level.level_id, 10, you10, "action 10 YOU sensor"); _register("sensor_echo_active", level.level_id, 10, echo10, "action 10 ECHO sensor"); _register("barrier_open", level.level_id, 10, _one(at10, "barrier"), "action 10 open"); _register("barrier_open_deferred", level.level_id, 11, _one(at11, "barrier"), "action 11 deferred"); _register("barrier_closed", level.level_id, 13, _one(at13, "barrier"), "action 13 closed")
	_expect(_snapshot(level, simulation.construct_initial_state(level)) == initial, "sensor restart restoration")
	_emit("sensor_barrier_lifecycle", {"action_10_open": _all(at10, "barrier").size(), "action_11_deferred": _all(at11, "barrier").size(), "action_12_deferred": _all(at12, "barrier").size()})

func _latch(level: Dictionary) -> void:
	var states := _states(level, WITNESSES.latch); var initial := _snapshot(level, states[0]); var at3 := _snapshot(level, states[3]); var at13 := _snapshot(level, states[13]); var at16 := _snapshot(level, states[16]); var final := _snapshot(level, states[WITNESSES.latch.size()])
	var inactive := _one(initial, "latch"); var active := _one(at3, "latch"); var phase3 := _barrier_group(at3, "barrier_phase"); var typed13 := _barrier_group(at13, "barrier_typed"); var typed16 := _barrier_group(at16, "barrier_typed")
	_expect(inactive.state_variant == "INACTIVE" and active.state_variant == "ACTIVATED", "latch action 3 activates")
	_expect(not phase3.is_empty() and bool(phase3[0].effective_open) and not typed13.is_empty() and bool(typed13[0].effective_open) and not typed16.is_empty() and not bool(typed16[0].effective_open), "latch phase open action 3 and typed group action 13/16")
	_expect(_one(at13, "latch").state_variant == "ACTIVATED" and _one(at16, "latch").state_variant == "ACTIVATED" and _one(final, "latch").monochrome_signature == active.monochrome_signature, "latch activation persists")
	_expect(phase3[0].type_group_token != typed13[0].type_group_token, "latch phase and typed groups distinct")
	_register("latch_inactive", level.level_id, 0, inactive, "initial latch"); _register("latch_activated", level.level_id, 3, active, "action 3 persistent activation")
	_expect(_snapshot(level, simulation.construct_initial_state(level)) == initial, "latch restart restoration")
	_emit("latch_lifecycle", {"action_3": active.state_variant, "action_13_typed_open": typed13[0].effective_open if not typed13.is_empty() else null, "action_16_typed_open": typed16[0].effective_open if not typed16.is_empty() else null})

func _registry_contract() -> void:
	_expect(registry.size() == REQUIRED.size() and registry.keys().all(func(k): return REQUIRED.has(k)), "registry exactly thirteen required labels")
	var signatures := {}; var map := {}
	for label in REQUIRED:
		var entry: Dictionary = registry.get(label, {}); _expect(not entry.is_empty() and _descriptor_contract(entry.get("descriptor", {})) and not String(entry.get("monochrome_signature", "")).is_empty(), "registry %s complete descriptor" % label)
		if not entry.is_empty(): signatures[entry.monochrome_signature] = true; map[label] = entry.monochrome_signature
	_expect(signatures.size() == REQUIRED.size(), "registry signatures pairwise distinct")
	_emit("lifecycle_signature_registry", {"count": registry.size(), "label_to_signature": map, "dynamic_sources": true})

func _fit_layering_and_v1(levels: Dictionary) -> void:
	for alias in levels:
		for d in _snapshot(levels[alias], simulation.construct_initial_state(levels[alias])):
			var b: Dictionary = d.bounds; _expect(b.x >= 0 and b.y >= 0 and b.x + b.width <= 960 and b.y + b.height <= 540 and _layer_ok(d), "%s fit/layer" % alias)
	for id in V1:
		var loaded := loader.load_file("res://data/levels/%s.json" % id); _expect(loaded.ok and _snapshot(loaded.level, simulation.construct_initial_state(loaded.level)).is_empty(), "%s v1 no spurious v2 descriptor" % id)
	_emit("fit_layering_v1_regression", {"v1_checked": V1.size(), "logical_area": [960, 540]})

func _register(label: String, level_id: String, turn: int, descriptor: Dictionary, evidence: String) -> void:
	_expect(not registry.has(label), "registry label unique %s" % label)
	registry[label] = {"source_level_id": level_id, "turn_action_index": turn, "descriptor_family": descriptor.get("family", ""), "stable_id": descriptor.get("stable_id", ""), "state_variant": descriptor.get("state_variant", ""), "shape_token": descriptor.get("shape_token", ""), "glyph_token": descriptor.get("glyph_token", ""), "type_group_token": descriptor.get("type_group_token", ""), "monochrome_signature": descriptor.get("monochrome_signature", ""), "lifecycle_evidence": evidence, "descriptor": descriptor.duplicate(true)}
func _states(level: Dictionary, actions: Array) -> Array:
	var result := [simulation.construct_initial_state(level)]
	for action in actions:
		var transition := simulation.transition(level, result.back(), action); _expect(transition.ok, "accepted witness action %s" % action); result.append(transition.state if transition.ok else result.back())
	return result
func _snapshot(level: Dictionary, state: Dictionary) -> Array: return Presentation.build(level, state, _board_rect(level), 60.0, Rect2(0, 0, 960, 540))
func _board_rect(level: Dictionary) -> Rect2:
	var rows: Array = level.get("terrain_rows", []); var size := Vector2(rows[0].length(), rows.size()) * 60.0; return Rect2(Vector2(24, 84) + (Vector2(540, 420) - size) * 0.5, size)
func _expected_count(level: Dictionary, state: Dictionary) -> int: return state.get("crate_positions", []).size() + state.get("remaining_key_ids", []).size() + level.get("locks", []).size() - state.get("removed_lock_ids", []).size() + level.get("sensors", []).size() + level.get("barrier_groups", []).reduce(func(n, g): return n + g.cells.size(), 0) + level.get("latches", []).size() + state.get("held_keys", []).size()
func _descriptor_contract(d: Dictionary) -> bool:
	for key in ["family", "stable_id", "cell", "position", "layer", "state_variant", "shape_token", "glyph_token", "type_group_token", "bounds", "monochrome_signature"]:
		if not d.has(key) or d[key] == null: return false
	return d.bounds.has_all(["x", "y", "width", "height"]) and d.position.has_all(["x", "y"])
func _strictly_sorted(items: Array) -> bool:
	for i in range(1, items.size()):
		if int(items[i - 1].layer) > int(items[i].layer) or (int(items[i - 1].layer) == int(items[i].layer) and String(items[i - 1].stable_id) >= String(items[i].stable_id)): return false
	return true
func _layer_ok(d: Dictionary) -> bool: return (d.family == "barrier" and int(d.layer) <= 2) or (d.family == "sensor" and int(d.layer) == 1) or (d.family in ["crate", "floor_key", "lock", "latch"] and int(d.layer) == 2) or (d.family == "held_key" and int(d.layer) == 5)
func _all(items: Array, family: String) -> Array: return items.filter(func(d): return d.family == family)
func _one(items: Array, family: String) -> Dictionary:
	var values := _all(items, family); return values[0] if not values.is_empty() else {}
func _by_variant(items: Array, variant: String) -> Dictionary:
	var values := items.filter(func(d): return d.get("state_variant", "") == variant); return values[0] if not values.is_empty() else {}
func _barrier_group(items: Array, group: String) -> Array: return _all(items, "barrier").filter(func(d): return String(d.get("stable_id", "")).begins_with("barrier:%s:" % group))
func _families(items: Array) -> Array:
	var result: Array = []
	for descriptor in items:
		result.append(descriptor.family)
	return result
func _expect(ok: bool, label: String) -> void:
	assertions += 1
	if not ok: failures += 1; printerr("TASK_0024AI_CANDIDATE_ROUTE_DYNAMIC_SIGNATURE_FAIL " + label)
func _emit(kind: String, body: Dictionary) -> void:
	body["schema_version"] = 1; body["kind"] = kind; print("TASK_0024AI_EVIDENCE " + JSON.stringify(body))

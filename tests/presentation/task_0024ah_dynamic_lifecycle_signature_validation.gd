extends SceneTree

## Task 0024AH samples real helper/Gameplay descriptors at the accepted witness
## turns.  Simulation remains the sole transition authority.
const GameplayScene = preload("res://scenes/vertical_slice/vertical_slice.tscn")
const LevelLoader = preload("res://scripts/simulation/level_loader.gd")
const Simulation = preload("res://scripts/simulation/simulation.gd")
const Presentation = preload("res://scripts/gameplay/schema_v2_presentation.gd")
const V2 := {
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
var assertions := 0
var failures := 0
var loader = LevelLoader.new()
var simulation = Simulation.new()
var registry := {}

func _init() -> void: call_deferred("_run")

func _run() -> void:
	var levels := {}
	for key in V2:
		levels[key] = _load(V2[key])
		if not levels[key].is_empty(): await _base_contract(key, V2[key], levels[key])
	if levels.size() == V2.size():
		_crate(levels["crate"])
		_key(levels["key"])
		_sensor(levels["sensor"])
		_latch(levels["latch"])
		_registry_contract()
		_fit_layering_and_v1(levels)
	_emit("summary", {"assertions": assertions, "failures": failures, "signature_count": registry.size()})
	if failures == 0:
		print("TASK_0024AH_DYNAMIC_LIFECYCLE_SIGNATURE_PASS assertions=%d" % assertions)
		quit(0)
	printerr("TASK_0024AH_DYNAMIC_LIFECYCLE_SIGNATURE_FAIL failures=%d assertions=%d" % [failures, assertions])
	quit(1)

func _base_contract(id: String, path: String, level: Dictionary) -> void:
	var initial := simulation.construct_initial_state(level)
	var before := initial.duplicate(true)
	var first := _snapshot(level, initial)
	_expect(first == _snapshot(level, initial) and initial == before, "%s helper deterministic and pure" % id)
	_expect(first.all(_descriptor_contract) and _strictly_sorted(first), "%s descriptor contract and order" % id)
	_expect(first.size() == _expected_count(level, initial), "%s exact initial inventory" % id)
	var scene = await _spawn(id, path)
	_expect(scene.get_schema_v2_presentation_snapshot() == first, "%s Gameplay snapshot equals helper" % id)
	var copy: Array = scene.get_schema_v2_presentation_snapshot()
	if not copy.is_empty(): copy[0]["family"] = "MUTATED"
	_expect(scene.get_schema_v2_presentation_snapshot() == first, "%s Gameplay snapshot deep copy" % id)
	scene.queue_free()
	await process_frame
	_emit("inventory", {"level": id, "descriptor_count": first.size(), "families": _families(first)})

func _crate(level: Dictionary) -> void:
	var states := _states(level, WITNESSES.crate)
	var initial := _snapshot(level, states[0]); var after_2 := _snapshot(level, states[2]); var after_3 := _snapshot(level, states[3])
	var crate0 := _one(initial, "crate"); var crate2 := _one(after_2, "crate")
	_expect(crate0.get("cell", []) == [2, 2] and crate2.get("cell", []) == [3, 2], "crate fixed witness action 2 moves YOU crate")
	_expect(crate0.get("monochrome_signature", "") == crate2.get("monochrome_signature", ""), "crate structural signature stable across movement")
	_expect(_one(after_3, "crate").get("cell", []) == crate2.get("cell", []), "crate action 3 ECHO contact does not push")
	_register("crate", "crate_shadow_timing", 0, crate0, "initial crate; action 2 same structural descriptor")
	_expect(_snapshot(level, simulation.construct_initial_state(level)) == initial, "crate restart restores descriptor")
	_emit("crate_lifecycle", {"initial_cell": crate0.get("cell", []), "action_2_cell": crate2.get("cell", []), "action_3_cell": _one(after_3, "crate").get("cell", [])})

func _key(level: Dictionary) -> void:
	var states := _states(level, WITNESSES.key)
	var initial := _snapshot(level, states[0]); var at4 := _snapshot(level, states[4]); var at12 := _snapshot(level, states[12])
	var floor := _one(initial, "floor_key"); var lock := _one(initial, "lock"); var held := _one(at4, "held_key")
	_expect(floor.get("type_group_token", "") == lock.get("type_group_token", "") and floor.get("monochrome_signature", "") != lock.get("monochrome_signature", ""), "key lock shared token distinct signatures")
	_expect(_all(at4, "floor_key").is_empty() and _all(at4, "held_key").size() == 1, "key action 4 inventory transition")
	_expect(_all(at12, "lock").is_empty() and _all(at12, "held_key").is_empty(), "key action 12 consumes lock and inventory")
	_register("floor_key", "key_route_commitment", 0, floor, "initial floor key")
	_register("lock", "key_route_commitment", 0, lock, "initial matching lock")
	_register("held_key", "key_route_commitment", 4, held, "action 4 held inventory key")
	_expect(_snapshot(level, simulation.construct_initial_state(level)) == initial, "key restart restores floor key lock and inventory")
	_emit("key_lock_inventory_lifecycle", {"action_4_held": _all(at4, "held_key").size(), "action_12_locks": _all(at12, "lock").size()})

func _sensor(level: Dictionary) -> void:
	var states := _states(level, WITNESSES.sensor)
	var initial := _snapshot(level, states[0]); var at10 := _snapshot(level, states[10]); var at11 := _snapshot(level, states[11]); var at12 := _snapshot(level, states[12]); var at13 := _snapshot(level, states[13])
	var sensors0 := _all(initial, "sensor"); var sensors10 := _all(at10, "sensor")
	_expect(sensors0.size() == 2 and sensors10.size() == 2, "sensor witness exposes both typed sensors")
	var you0 := _by_variant(sensors0, "YOU_INACTIVE"); var echo0 := _by_variant(sensors0, "ECHO_INACTIVE")
	var you10 := _by_variant(sensors10, "YOU_ACTIVE"); var echo10 := _by_variant(sensors10, "ECHO_ACTIVE")
	_expect(not you0.is_empty() and not echo0.is_empty() and not you10.is_empty() and not echo10.is_empty(), "sensor fixed action 10 correct identities activate")
	_expect(_all(at10, "barrier").all(func(d): return bool(d.get("effective_open", false))), "sensor action 10 group open")
	for snap in [at11, at12]:
		var deferred := _all(snap, "barrier").filter(func(d): return String(d.get("state_variant", "")) == "OPEN_DEFERRED")
		_expect(not deferred.is_empty() and deferred.all(func(d): return bool(d.get("closure_deferred", false))), "sensor actions 11/12 deferred occupied bridge")
		if deferred.size() >= 2: _expect(deferred[0].get("type_group_token", "") == deferred[1].get("type_group_token", "") and deferred[0].get("monochrome_signature", "") == deferred[1].get("monochrome_signature", ""), "deferred grouped bridge common token/signature")
	_expect(_all(at13, "barrier").all(func(d): return String(d.get("state_variant", "")) == "CLOSED"), "sensor action 13 closes after vacancy")
	# Before the accepted paired-identity state, no wrong actor can present the correct active signature.
	_expect(_all(_snapshot(level, states[9]), "sensor").all(func(d): return not String(d.get("state_variant", "")).ends_with("ACTIVE")), "wrong actor/control state never impersonates active signature")
	_register("sensor_you_inactive", "identity_shift_bridge", 0, you0, "initial YOU sensor")
	_register("sensor_echo_inactive", "identity_shift_bridge", 0, echo0, "initial ECHO sensor")
	_register("sensor_you_active", "identity_shift_bridge", 10, you10, "action 10 YOU sensor")
	_register("sensor_echo_active", "identity_shift_bridge", 10, echo10, "action 10 ECHO sensor")
	_register("barrier_open", "identity_shift_bridge", 10, _one(at10, "barrier"), "action 10 sensor-open group")
	_register("barrier_open_deferred", "identity_shift_bridge", 11, _one(at11, "barrier"), "action 11 deferred closure")
	_register("barrier_closed", "identity_shift_bridge", 13, _one(at13, "barrier"), "action 13 vacant closed group")
	_expect(_snapshot(level, simulation.construct_initial_state(level)) == initial, "sensor restart restores inactive closed")
	_emit("sensor_barrier_lifecycle", {"action_10_open": _all(at10, "barrier").size(), "action_11_deferred": _all(at11, "barrier").size()})

func _latch(level: Dictionary) -> void:
	var states := _states(level, WITNESSES.latch)
	var initial := _snapshot(level, states[0]); var at3 := _snapshot(level, states[3]); var at13 := _snapshot(level, states[13]); var at16 := _snapshot(level, states[16]); var final := _snapshot(level, states[WITNESSES.latch.size()])
	var inactive := _one(initial, "latch"); var active := _one(at3, "latch")
	_expect(inactive.get("state_variant", "") == "INACTIVE" and active.get("state_variant", "") == "ACTIVATED", "latch action 3 activates")
	var phase3 := _barrier_group(at3, "barrier_phase"); var typed13 := _barrier_group(at13, "barrier_typed"); var typed16 := _barrier_group(at16, "barrier_typed")
	_expect(not phase3.is_empty() and bool(phase3[0].get("effective_open", false)), "latch action 3 phase remains open")
	_expect(not typed13.is_empty() and bool(typed13[0].get("effective_open", false)) and _one(at13, "latch").get("state_variant", "") == "ACTIVATED", "latch action 13 typed open and persistent activation")
	_expect(not typed16.is_empty() and not bool(typed16[0].get("effective_open", true)) and _one(at16, "latch").get("state_variant", "") == "ACTIVATED", "latch action 16 typed closed activation persists")
	_expect(_one(final, "latch").get("monochrome_signature", "") == active.get("monochrome_signature", "") and _all(final, "latch").size() == 1, "latch later turns retain one activated affordance")
	_expect(not phase3.is_empty() and not typed13.is_empty() and phase3[0].get("type_group_token", "") != typed13[0].get("type_group_token", ""), "latch phase and typed groups distinct")
	_register("latch_inactive", "lasting_echo_latch", 0, inactive, "initial target group latch")
	_register("latch_activated", "lasting_echo_latch", 3, active, "action 3 activated persistent latch")
	_expect(_snapshot(level, simulation.construct_initial_state(level)) == initial, "latch restart restores initial states")
	_emit("latch_lifecycle", {"action_3": active.get("state_variant", ""), "action_16_typed_open": typed16[0].get("effective_open", null) if not typed16.is_empty() else null})

func _registry_contract() -> void:
	var required := ["crate", "floor_key", "held_key", "lock", "sensor_you_inactive", "sensor_you_active", "sensor_echo_inactive", "sensor_echo_active", "barrier_closed", "barrier_open", "barrier_open_deferred", "latch_inactive", "latch_activated"]
	_expect(registry.size() == 13 and registry.keys().all(func(k): return required.has(k)), "registry exact thirteen labels")
	var signatures := {}
	for label in required:
		var entry: Dictionary = registry.get(label, {})
		_expect(not entry.is_empty() and _descriptor_contract(entry.get("descriptor", {})) and not String(entry.get("monochrome_signature", "")).is_empty(), "registry %s retained contract" % label)
		if not entry.is_empty(): signatures[entry.monochrome_signature] = true
	_expect(signatures.size() == 13, "registry signatures pairwise distinct")
	var map := {}
	for label in required:
		map[label] = registry.get(label, {}).get("monochrome_signature", "")
	_emit("lifecycle_signature_registry", {"count": registry.size(), "label_to_signature": map, "dynamic_sources": true})

func _fit_layering_and_v1(levels: Dictionary) -> void:
	for id in levels:
		for d in _snapshot(levels[id], simulation.construct_initial_state(levels[id])):
			var b: Dictionary = d.bounds
			_expect(b.x >= 0 and b.y >= 0 and b.x + b.width <= 960 and b.y + b.height <= 540 and _layer_ok(d), "%s fit/layer" % id)
	for id in V1:
		var loaded := loader.load_file("res://data/levels/%s.json" % id)
		_expect(loaded.ok and _snapshot(loaded.level, simulation.construct_initial_state(loaded.level)).is_empty(), "%s v1 regression" % id)
	_emit("fit_layering_v1_regression", {"v1_checked": V1.size(), "logical_area": [960, 540]})

func _register(label: String, level_id: String, turn: int, descriptor: Dictionary, evidence: String) -> void:
	_expect(not registry.has(label), "registry label unique %s" % label)
	registry[label] = {"source_level_id": level_id, "turn_action_index": turn, "descriptor_family": descriptor.get("family", ""), "stable_id": descriptor.get("stable_id", ""), "state_variant": descriptor.get("state_variant", ""), "shape_token": descriptor.get("shape_token", ""), "glyph_token": descriptor.get("glyph_token", ""), "type_group_token": descriptor.get("type_group_token", ""), "monochrome_signature": descriptor.get("monochrome_signature", ""), "lifecycle_evidence": evidence, "descriptor": descriptor.duplicate(true)}

func _states(level: Dictionary, actions: Array) -> Array:
	var result := [simulation.construct_initial_state(level)]
	for action in actions:
		var transition := simulation.transition(level, result.back(), action)
		_expect(transition.ok, "accepted witness action %s" % action)
		result.append(transition.state if transition.ok else result.back())
	return result
func _snapshot(level: Dictionary, state: Dictionary) -> Array: return Presentation.build(level, state, _board_rect(level), 60.0, Rect2(0, 0, 960, 540))
func _load(path: String) -> Dictionary:
	var loaded := loader.load_file(path); _expect(loaded.ok, "public LevelLoader %s" % path); return loaded.level if loaded.ok else {}
func _spawn(id: String, path: String):
	var scene = GameplayScene.instantiate(); scene.configure_route_payload({"level_id": id, "level_path": path, "hud_mode": "STANDARD_COMPACT", "classification": "standard", "development_direct": true, "final_level": false}); root.add_child(scene); await process_frame; return scene
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
	var a := _all(items, family)
	return a[0] if not a.is_empty() else {}
func _by_variant(items: Array, variant: String) -> Dictionary:
	var a := items.filter(func(d): return d.get("state_variant", "") == variant)
	return a[0] if not a.is_empty() else {}
func _barrier_group(items: Array, group: String) -> Array: return _all(items, "barrier").filter(func(d): return String(d.get("stable_id", "")).begins_with("barrier:%s:" % group))
func _families(items: Array) -> Array:
	var result: Array = []
	for d in items: result.append(d.family)
	return result
func _expect(ok: bool, label: String) -> void:
	assertions += 1
	if not ok:
		failures += 1
		printerr("TASK_0024AH_DYNAMIC_LIFECYCLE_SIGNATURE_FAIL " + label)
func _emit(kind: String, body: Dictionary) -> void:
	body["schema_version"] = 1
	body["kind"] = kind
	print("TASK_0024AH_EVIDENCE " + JSON.stringify(body))

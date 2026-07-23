extends SceneTree

## Task 0024AJ: all observations are derived from the public level contract.
## Simulation stays the only transition authority; this file never mutates product state.
const GameplayScene = preload("res://scenes/vertical_slice/vertical_slice.tscn")
const LevelLoader = preload("res://scripts/simulation/level_loader.gd")
const Simulation = preload("res://scripts/simulation/simulation.gd")
const Presentation = preload("res://scripts/gameplay/schema_v2_presentation.gd")
const CANDIDATES := {"crate": "res://data/levels/crate_shadow_timing.json", "key": "res://data/levels/key_route_commitment.json", "sensor": "res://data/levels/identity_shift_bridge.json", "latch": "res://data/levels/lasting_echo_latch.json"}
const V1 := ["door_one_turn_late", "echo_spacing_bridge", "staggered_doors", "tutorial_echo_bridge", "tutorial_reach_exit", "two_echo_convergence", "two_keys_one_door", "vertical_slice_delay_3"]
const WITNESSES := {"crate": ["DOWN", "RIGHT", "DOWN", "DOWN", "DOWN", "RIGHT", "RIGHT", "UP", "RIGHT", "UP", "RIGHT", "UP", "RIGHT", "UP"], "key": ["DOWN", "DOWN", "RIGHT", "RIGHT", "LEFT", "LEFT", "UP", "UP", "RIGHT", "RIGHT", "UP", "RIGHT", "RIGHT", "RIGHT", "RIGHT", "UP", "UP", "LEFT", "LEFT"], "sensor": ["RIGHT", "RIGHT", "UP", "UP", "LEFT", "LEFT", "UP", "UP", "RIGHT", "RIGHT", "RIGHT", "RIGHT", "RIGHT", "RIGHT", "RIGHT", "RIGHT", "DOWN", "DOWN"], "latch": ["RIGHT", "UP", "RIGHT", "UP", "UP", "UP", "UP", "LEFT", "LEFT", "UP", "UP", "RIGHT", "RIGHT", "RIGHT", "RIGHT", "RIGHT", "RIGHT", "RIGHT", "RIGHT", "DOWN", "DOWN"]}
const REQUIRED := ["crate", "floor_key", "held_key", "lock", "sensor_you_inactive", "sensor_you_active", "sensor_echo_inactive", "sensor_echo_active", "barrier_closed", "barrier_open", "barrier_open_deferred", "latch_inactive", "latch_activated"]
const SENSOR_STABLE_IDS := ["sensor:sensor_you", "sensor:sensor_echo"]
const SENSOR_PUBLIC_VARIANTS := ["YOU_ONLY_INACTIVE", "YOU_ONLY_ACTIVE", "ECHO_ONLY_INACTIVE", "ECHO_ONLY_ACTIVE"]
const REGISTRY_EXPECTED := {"crate": ["crate", "MUTABLE"], "floor_key": ["floor_key", "ON_FLOOR"], "held_key": ["held_key", "HELD"], "lock": ["lock", "LOCKED"], "sensor_you_inactive": ["sensor", "YOU_ONLY_INACTIVE"], "sensor_you_active": ["sensor", "YOU_ONLY_ACTIVE"], "sensor_echo_inactive": ["sensor", "ECHO_ONLY_INACTIVE"], "sensor_echo_active": ["sensor", "ECHO_ONLY_ACTIVE"], "barrier_closed": ["barrier", "CLOSED"], "barrier_open": ["barrier", "OPEN"], "barrier_open_deferred": ["barrier", "OPEN_DEFERRED"], "latch_inactive": ["latch", "INACTIVE"], "latch_activated": ["latch", "ACTIVATED"]}
var assertions: int = 0
var failures: int = 0
var loader = LevelLoader.new()
var simulation = Simulation.new()
var registry: Dictionary = {}
var emitted_kinds: Dictionary = {}
var preflight_records: Array = []
var group_action_records: Array = []

func _init() -> void: call_deferred("_run")
func _run() -> void:
	var levels: Dictionary = {}
	for alias in CANDIDATES:
		var path: String = String(CANDIDATES[alias]); var loaded: Dictionary = loader.load_file(path)
		_expect(bool(loaded.get("ok", false)) and loaded.get("level", null) is Dictionary and not String(loaded.level.get("level_id", "")).is_empty(), "%s public Loader exact nonempty ID" % alias)
		if bool(loaded.get("ok", false)) and loaded.get("level", null) is Dictionary: levels[alias] = loaded.level; await _candidate_preflight(alias, path, loaded.level)
	if failures == 0 and levels.size() == CANDIDATES.size():
		_emit("multi_subagent_ledger", {"validation_role": "AJ validation worker", "external_roles_required": ["source_contract_mapper", "independent_reviewer"]})
		_emit("adapter_parser_qualification", {"adapter": "tests/tools/task_0024aj_invoke_wrapper_case.ps1", "capture_parser": "tests/tools/task_0024aj_evidence_capture_parser.ps1", "status": "EXTERNAL_DRIVER_REQUIRED"})
		_emit("static_preservation", {"audit": "tests/tools/task_0024aj_static_preservation.ps1", "status": "EXTERNAL_DRIVER_REQUIRED"})
		_emit("candidate_route_preflight", {"candidate_count": preflight_records.size(), "records": preflight_records})
		for alias in levels: _base_contract(alias, levels[alias])
		_crate(levels.crate); _key(levels.key); _sensor(levels.sensor); _latch(levels.latch); _registry_contract(); _fit_layering_v1(levels)
		_emit("summary", {"assertions": assertions, "failures": failures, "signature_count": registry.size(), "candidate_count": levels.size()})
	if failures == 0:
		print("TASK_0024AJ_SENSOR_CONTRACT_DYNAMIC_SIGNATURE_PASS assertions=%d" % assertions)
		quit(0)
		return
	printerr("TASK_0024AJ_SENSOR_CONTRACT_DYNAMIC_SIGNATURE_FAIL failures=%d assertions=%d" % [failures, assertions]); quit(1)

func _candidate_preflight(alias: String, path: String, level: Dictionary) -> void:
	var level_id: String = String(level.get("level_id", "")); var initial: Dictionary = simulation.construct_initial_state(level); var expected: Array = _snapshot(level, initial)
	var scene: Variant = GameplayScene.instantiate(); var payload := {"level_id": level_id, "level_path": path, "hud_mode": "STANDARD_COMPACT", "classification": "candidate", "development_direct": true, "final_level": false}
	var configured: bool = bool(scene.configure_route_payload(payload)); _expect(configured, "%s configures before tree entry" % alias); root.add_child(scene); await process_frame
	var actual: Array = scene.get_schema_v2_presentation_snapshot(); var route: Dictionary = scene.get_route_payload()
	_expect(String(scene.load_error) == "" and scene.is_runtime_ready(), "%s runtime ready without LEVEL_ID_MISMATCH" % alias)
	_expect(route.get("level_id", "") == level_id and route.get("level_path", "") == path, "%s route retains public Loader ID/path" % alias)
	_expect(actual == expected, "%s Gameplay equals pure initial snapshot" % alias)
	var copy: Array = actual.duplicate(true); if not copy.is_empty(): copy[0]["family"] = "MUTATED"
	_expect(scene.get_schema_v2_presentation_snapshot() == expected, "%s Gameplay snapshot deep-copy resistant" % alias)
	preflight_records.append({"alias": alias, "loaded_level_id": level_id, "exact_path": path, "runtime_ready": scene.is_runtime_ready(), "snapshot_equal": actual == expected})
	scene.queue_free(); await process_frame; _expect(not is_instance_valid(scene), "%s freed before next candidate" % alias)

func _base_contract(alias: String, level: Dictionary) -> void:
	var state: Dictionary = simulation.construct_initial_state(level); var before: Dictionary = state.duplicate(true); var first: Array = _snapshot(level, state)
	_expect(first == _snapshot(level, state) and state == before, "%s helper deterministic and pure" % alias)
	_expect(first.all(_descriptor_contract) and _strictly_sorted(first), "%s descriptor contract and order" % alias)

func _crate(level: Dictionary) -> void:
	var states: Array = _states(level, WITNESSES.crate); var initial: Array = _snapshot(level, states[0]); var at2: Array = _snapshot(level, states[2]); var at3: Array = _snapshot(level, states[3]); var first: Dictionary = _one(initial, "crate")
	_expect(first.get("cell", []) == [2,2] and _one(at2, "crate").get("cell", []) == [3,2] and _one(at3, "crate").get("cell", []) == [3,2], "crate YOU push and ECHO inert")
	_register("crate", level.level_id, 0, first, "initial then action 2 YOU push/action 3 ECHO inert", {})
	_emit("crate_lifecycle", {"initial_cell": first.get("cell", []), "action_2_cell": _one(at2, "crate").get("cell", []), "action_3_cell": _one(at3, "crate").get("cell", [])})

func _key(level: Dictionary) -> void:
	var states: Array = _states(level, WITNESSES.key); var initial: Array = _snapshot(level, states[0]); var at4: Array = _snapshot(level, states[4]); var at12: Array = _snapshot(level, states[12])
	_expect(_all(at4, "floor_key").is_empty() and _all(at4, "held_key").size() == 1 and _all(at12, "lock").is_empty() and _all(at12, "held_key").is_empty(), "key action 4 held; action 12 consumes")
	_register("floor_key", level.level_id, 0, _one(initial, "floor_key"), "initial floor key", {}); _register("lock", level.level_id, 0, _one(initial, "lock"), "initial lock", {}); _register("held_key", level.level_id, 4, _one(at4, "held_key"), "action 4 held inventory", {})
	_emit("key_lock_inventory_lifecycle", {"action_4_held": _all(at4, "held_key").size(), "action_12_locks": _all(at12, "lock").size()})

func _sensor(level: Dictionary) -> void:
	var you_def: Dictionary = _definition_by_id(level.get("sensors", []), "sensor_you"); var echo_def: Dictionary = _definition_by_id(level.get("sensors", []), "sensor_echo")
	_expect(not you_def.is_empty() and not echo_def.is_empty(), "stable sensor definitions exist")
	var states: Array = _states(level, WITNESSES.sensor); var initial: Array = _snapshot(level, states[0]); var at10: Array = _snapshot(level, states[10]); var at11: Array = _snapshot(level, states[11]); var at12: Array = _snapshot(level, states[12]); var at13: Array = _snapshot(level, states[13])
	var you0: Dictionary = _sensor_descriptor(initial, you_def, false); var echo0: Dictionary = _sensor_descriptor(initial, echo_def, false); var you10: Dictionary = _sensor_descriptor(at10, you_def, true); var echo10: Dictionary = _sensor_descriptor(at10, echo_def, true)
	var reversed: Array = initial.duplicate(true); reversed.reverse()
	_expect(_sensor_descriptor(reversed, you_def, false) == you0 and _sensor_descriptor(reversed, echo_def, false) == echo0, "stable-ID selector is independent of descriptor array order")
	_expect(you_def.get("activator", "") == "YOU_ONLY" and echo_def.get("activator", "") == "ECHO_ONLY" and [you0.get("stable_id", ""), echo0.get("stable_id", "")].all(func(id: String) -> bool: return SENSOR_STABLE_IDS.has(id)) and [you0.get("state_variant", ""), you10.get("state_variant", ""), echo0.get("state_variant", ""), echo10.get("state_variant", "")].all(func(variant: String) -> bool: return SENSOR_PUBLIC_VARIANTS.has(variant)), "accepted public sensor IDs and variants exposed")
	_expect(_sensor_public_contract(you_def, you0, you10, "Y") and _sensor_public_contract(echo_def, echo0, echo10, "E"), "stable-ID public activator sensor contract")
	_expect(you0.get("type_group_token", "") == echo0.get("type_group_token", "") and you0.get("monochrome_signature", "") != echo0.get("monochrome_signature", "") and you10.get("monochrome_signature", "") != echo10.get("monochrome_signature", ""), "sensors share group token but retain identity signatures")
	var group: String = _common_barrier_group(level, you_def, echo_def); _expect(not group.is_empty(), "both sensors share dependent barrier group")
	var public_cells: Array = _definition_by_id(level.get("barrier_groups", []), group).get("cells", [])
	_expect(_barrier_group(initial, group).size() == public_cells.size() and _barrier_group(initial, group).all(func(d: Dictionary) -> bool: return d.get("state_variant", "") == "CLOSED" and not bool(d.get("requested_open", true)) and not bool(d.get("effective_open", true)) and not bool(d.get("closure_deferred", true))), "initial sensor pair inactive and exact full barrier group closed")
	_expect(_all(at10, "barrier").all(func(d: Dictionary) -> bool: return bool(d.get("effective_open", false))), "action 10 all group cells open")
	_expect(not you10.is_empty() and not echo10.is_empty() and _barrier_group(at10, group).size() == public_cells.size(), "actor occupancy preserves both sensor and every barrier descriptor")
	for action_snapshot in [at11, at12]:
		var affected: Array = _barrier_group(action_snapshot, group); var first: Dictionary = affected[0] if not affected.is_empty() else {}
		_expect(affected.size() == 2 and affected.all(func(d: Dictionary) -> bool: return d.get("state_variant", "") == "OPEN_DEFERRED" and bool(d.get("closure_deferred", false)) and d.get("type_group_token", "") == first.get("type_group_token", "") and d.get("monochrome_signature", "") == first.get("monochrome_signature", "")), "actions 11/12 every occupied barrier cell OPEN_DEFERRED with common group signature")
	_expect(_barrier_group(at13, group).all(func(d: Dictionary) -> bool: return d.get("state_variant", "") == "CLOSED"), "action 13 every group cell closed after vacancy")
	_expect(int(_one(_barrier_group(at10, group), "barrier").get("layer", -1)) == 1 and int(_one(_barrier_group(at11, group), "barrier").get("layer", -1)) == 1 and int(_one(_barrier_group(at13, group), "barrier").get("layer", -1)) == 2, "barrier layering follows underlay-open then blocker-closed")
	_assert_group_action_contract(level, group, public_cells, 10, states[10], at10, true, true, false, false)
	_assert_group_action_contract(level, group, public_cells, 11, states[11], at11, false, true, true, true)
	_assert_group_action_contract(level, group, public_cells, 12, states[12], at12, false, true, true, true)
	_assert_group_action_contract(level, group, public_cells, 13, states[13], at13, false, false, false, false)
	_register("sensor_you_inactive", level.level_id, 0, you0, "initial public YOU_ONLY inactive", _occupancy(level, states[0])); _register("sensor_echo_inactive", level.level_id, 0, echo0, "initial public ECHO_ONLY inactive", _occupancy(level, states[0])); _register("sensor_you_active", level.level_id, 10, you10, "action 10 public YOU_ONLY active", _occupancy(level, states[10])); _register("sensor_echo_active", level.level_id, 10, echo10, "action 10 public ECHO_ONLY active", _occupancy(level, states[10]))
	_register("barrier_open", level.level_id, 10, _one(_barrier_group(at10, group), "barrier"), "action 10 open", _occupancy(level, states[10])); _register("barrier_open_deferred", level.level_id, 11, _one(_barrier_group(at11, group), "barrier"), "action 11 deferred", _occupancy(level, states[11])); _register("barrier_closed", level.level_id, 13, _one(_barrier_group(at13, group), "barrier"), "action 13 closed", _occupancy(level, states[13]))
	_swapped_identity_control(level, you_def, echo_def, group)
	_expect(_snapshot(level, simulation.construct_initial_state(level)) == initial, "sensor restart restores exact initial descriptors")
	_emit("sensor_public_contract_inventory", {"sensor_you": you_def, "sensor_echo": echo_def, "barrier_group": group})
	_emit("sensor_barrier_lifecycle", {"action_10": [you10.get("state_variant"), echo10.get("state_variant")], "action_11_all_deferred": _barrier_group(at11, group).size(), "action_12_all_deferred": _barrier_group(at12, group).size(), "action_13_closed": _barrier_group(at13, group).size(), "per_group_actions": group_action_records})

func _swapped_identity_control(level: Dictionary, you_def: Dictionary, echo_def: Dictionary, group: String) -> void:
	var original_digest: String = JSON.stringify(level).sha256_text()
	var control: Dictionary = level.duplicate(true); var c_you: Dictionary = _definition_by_id(control.sensors, "sensor_you"); var c_echo: Dictionary = _definition_by_id(control.sensors, "sensor_echo")
	c_you["activator"] = "ECHO_ONLY"; c_echo["activator"] = "YOU_ONLY"
	_expect(JSON.stringify(level).sha256_text() == original_digest, "control leaves original semantic definition unchanged")
	_expect(_swap_only(control, level), "Task 0024AB control differs only by two stable-ID activators")
	var prefix: Array = WITNESSES.sensor.slice(0, 10); var control_states: Array = _states(control, prefix); var action10_state: Dictionary = control_states[10]
	var snap: Array = _snapshot(control, action10_state); var c_you_d: Dictionary = _sensor_descriptor(snap, c_you, false); var c_echo_d: Dictionary = _sensor_descriptor(snap, c_echo, false); var occ: Dictionary = _occupancy(control, action10_state)
	_expect(action10_state.player_position == you_def.position and action10_state.echo_positions[0].position == echo_def.position, "swapped control reaches action 10 paired physical occupancy")
	_expect(not c_you_d.is_empty() and not c_echo_d.is_empty() and c_you_d.state_variant == "ECHO_ONLY_INACTIVE" and c_echo_d.state_variant == "YOU_ONLY_INACTIVE", "swapped activators keep wrong actors inactive")
	_expect(simulation.pressed_sensor_ids(control, action10_state).is_empty(), "swapped control presses neither sensor at paired occupancy")
	_expect(_barrier_group(snap, group).all(func(d: Dictionary) -> bool: return not bool(d.get("effective_open", false))), "swapped identity does not present correct-pair open")
	var block: Dictionary = simulation.transition(control, action10_state, WITNESSES.sensor[10]); var block_state: Dictionary = block.get("state", {})
	_expect(bool(block.get("ok", false)) and block_state.get("player_position", []) == action10_state.get("player_position", []), "swapped control action 11 reaches closed bridge and blocks progress")
	_emit("swapped_identity_wrong_actor_control", {"control_source": "Task 0024AB literal stable-ID activator swap", "control_digest": JSON.stringify(control).sha256_text(), "action_10_reached": true, "block_action": WITNESSES.sensor[10], "block_player_unchanged": block_state.get("player_position", []) == action10_state.get("player_position", []), "sensor_you": {"stable_id": c_you_d.get("stable_id"), "occupying_actor": "YOU", "required_activator": c_you.activator, "state_variant": c_you_d.get("state_variant"), "signature": c_you_d.get("monochrome_signature")}, "sensor_echo": {"stable_id": c_echo_d.get("stable_id"), "occupying_actor": "ECHO", "required_activator": c_echo.activator, "state_variant": c_echo_d.get("state_variant"), "signature": c_echo_d.get("monochrome_signature")}, "occupancy": occ})

func _swap_only(control: Dictionary, original: Dictionary) -> bool:
	var normalized_control: Dictionary = control.duplicate(true); var normalized_original: Dictionary = original.duplicate(true)
	for sensor in normalized_control.get("sensors", []): sensor.erase("activator")
	for sensor in normalized_original.get("sensors", []): sensor.erase("activator")
	return JSON.stringify(normalized_control) == JSON.stringify(normalized_original) and _definition_by_id(control.sensors, "sensor_you").get("activator", "") == "ECHO_ONLY" and _definition_by_id(control.sensors, "sensor_echo").get("activator", "") == "YOU_ONLY"

func _assert_group_action_contract(level: Dictionary, group_id: String, public_cells: Array, action: int, state: Dictionary, snapshot: Array, requested: bool, effective: bool, deferred: bool, occupied: bool) -> void:
	var descriptors: Array = _barrier_group(snapshot, group_id)
	var occupied_cells: Array = []; var cell_actors: Dictionary = {}
	for cell in public_cells:
		var actors: Array = []
		if state.get("player_position", []) == cell:
			occupied_cells.append(cell)
			actors.append("YOU")
		for echo in state.get("echo_positions", []):
			if echo.get("position", []) == cell:
				if not occupied_cells.has(cell):
					occupied_cells.append(cell)
				actors.append("ECHO:%s" % echo.get("id", ""))
		cell_actors[JSON.stringify(cell)] = actors
	_expect(descriptors.size() == public_cells.size() and descriptors.all(func(d: Dictionary) -> bool: return public_cells.has(d.get("cell", [])) and bool(d.get("requested_open", false)) == requested and bool(d.get("effective_open", false)) == effective and bool(d.get("closure_deferred", false)) == deferred), "action %d group %s public-cell requested/effective/deferred contract" % [action, group_id])
	_expect((not occupied_cells.is_empty()) == occupied, "action %d group %s actor occupancy contract" % [action, group_id])
	if action == 11 or action == 12:
		_expect(not occupied_cells.is_empty() and occupied_cells.all(func(cell: Array) -> bool: return public_cells.has(cell)), "action %d group %s has occupied public cell" % [action, group_id])
		if action == 12:
			var union: Array = occupied_cells.duplicate()
			for prior in group_action_records:
				if int(prior.get("action", -1)) == 11:
					for prior_cell in prior.get("occupied_cells", []):
						if not union.has(prior_cell): union.append(prior_cell)
			_expect(union.size() == public_cells.size() and union.all(func(cell: Array) -> bool: return public_cells.has(cell)), "actions 11/12 group %s occupied public-cell union equals full group" % group_id)
	group_action_records.append({"action": action, "group_id": group_id, "public_cell_count": public_cells.size(), "descriptor_count": descriptors.size(), "requested_open": requested, "effective_open": effective, "closure_deferred": deferred, "occupied_cells": occupied_cells, "actors_by_public_cell": cell_actors})

func _latch(level: Dictionary) -> void:
	var states: Array = _states(level, WITNESSES.latch); var initial: Array = _snapshot(level, states[0]); var at3: Array = _snapshot(level, states[3])
	_expect(_one(initial, "latch").get("state_variant", "") == "INACTIVE" and _one(at3, "latch").get("state_variant", "") == "ACTIVATED", "latch action 3 activates")
	_register("latch_inactive", level.level_id, 0, _one(initial, "latch"), "initial latch", {}); _register("latch_activated", level.level_id, 3, _one(at3, "latch"), "action 3 persistent activation", {})
	_emit("latch_lifecycle", {"action_3_state": _one(at3, "latch").get("state_variant", "")})

func _registry_contract() -> void:
	_expect(registry.size() == REQUIRED.size() and registry.keys().all(func(k: String) -> bool: return REQUIRED.has(k)), "registry exactly thirteen labels")
	var signatures: Dictionary = {}; var label_map: Dictionary = {}
	for label in REQUIRED:
		var entry: Dictionary = registry.get(label, {}); var expected: Array = REGISTRY_EXPECTED.get(label, [])
		_expect(not entry.is_empty() and _descriptor_contract(entry.get("descriptor", {})) and not String(entry.get("monochrome_signature", "")).is_empty() and expected.size() == 2 and entry.get("descriptor_family", "") == expected[0] and entry.get("state_variant", "") == expected[1], "registry %s full intended descriptor" % label)
		if not entry.is_empty(): signatures[entry.monochrome_signature] = true; label_map[label] = entry.monochrome_signature
	_expect(signatures.size() == REQUIRED.size(), "all thirteen monochrome signatures pairwise distinct"); _emit("lifecycle_signature_registry", {"count": registry.size(), "label_to_signature": label_map})

func _fit_layering_v1(levels: Dictionary) -> void:
	var ordering := {"terrain": 0, "underlay_open_edges": 1, "blockers_interactables": 2, "actors": 3, "tokens": 4, "inventory": 5}
	_expect(ordering.terrain < ordering.underlay_open_edges and ordering.underlay_open_edges < ordering.blockers_interactables and ordering.blockers_interactables < ordering.actors and ordering.actors < ordering.tokens and ordering.tokens < ordering.inventory, "full terrain-underlay-blocker-actor-token-inventory order")
	for alias in levels:
		for d in _snapshot(levels[alias], simulation.construct_initial_state(levels[alias])):
			var b: Dictionary = d.get("bounds", {}); _expect(float(b.get("x", -1)) >= 0 and float(b.get("y", -1)) >= 0 and float(b.get("x", 9999)) + float(b.get("width", 0)) <= 960 and float(b.get("y", 9999)) + float(b.get("height", 0)) <= 540 and _layer_ok(d), "%s fit/layer" % alias)
	for level_id in V1:
		var loaded: Dictionary = loader.load_file("res://data/levels/%s.json" % level_id); _expect(bool(loaded.get("ok", false)) and _snapshot(loaded.level, simulation.construct_initial_state(loaded.level)).is_empty(), "%s v1 no v2 descriptor" % level_id)
	_emit("fit_layering_v1_regression", {"v1_checked": V1.size(), "logical_area": [960, 540], "layer_order": ordering, "actor_occupancy_preserves_underlay_identity": true})

func _sensor_public_contract(definition: Dictionary, inactive: Dictionary, active: Dictionary, glyph: String) -> bool:
	var activator: String = String(definition.get("activator", "")); return inactive.get("stable_id", "") == "sensor:%s" % definition.get("id", "") and active.get("stable_id", "") == inactive.get("stable_id", "") and inactive.get("cell", []) == definition.get("position", []) and inactive.get("state_variant", "") == activator + "_INACTIVE" and active.get("state_variant", "") == activator + "_ACTIVE" and inactive.get("glyph_token", "") == glyph and active.get("glyph_token", "") == glyph and inactive.get("shape_token", "") != active.get("shape_token", "") and inactive.get("monochrome_signature", "") != active.get("monochrome_signature", "")
func _sensor_descriptor(items: Array, definition: Dictionary, active: bool) -> Dictionary:
	var variant: String = String(definition.get("activator", "")) + ("_ACTIVE" if active else "_INACTIVE"); var stable: String = "sensor:%s" % definition.get("id", "")
	var found: Array = items.filter(func(d: Dictionary) -> bool: return d.get("stable_id", "") == stable and d.get("state_variant", "") == variant); return found[0] if found.size() == 1 else {}
func _definition_by_id(definitions: Array, wanted: String) -> Dictionary:
	var found: Array = definitions.filter(func(d: Dictionary) -> bool: return d.get("id", "") == wanted); return found[0] if found.size() == 1 else {}
func _common_barrier_group(level: Dictionary, a: Dictionary, b: Dictionary) -> String:
	for group in level.get("barrier_groups", []):
		if group.get("all_sensor_ids", []).has(a.get("id", "")) and group.get("all_sensor_ids", []).has(b.get("id", "")):
			return String(group.get("id", ""))
	return ""
func _occupancy(level: Dictionary, state: Dictionary) -> Dictionary: return {"player": state.get("player_position", []), "echoes": state.get("echo_positions", []), "pressed_sensor_ids": simulation.pressed_sensor_ids(level, state)}
func _register(label: String, level_id: String, turn: int, descriptor: Dictionary, evidence: String, occupancy: Dictionary) -> void:
	_expect(not registry.has(label), "registry unique %s" % label); registry[label] = {"source_level_id": level_id, "turn_action_index": turn, "descriptor_family": descriptor.get("family", ""), "stable_id": descriptor.get("stable_id", ""), "cell": descriptor.get("cell", []), "state_variant": descriptor.get("state_variant", ""), "shape_token": descriptor.get("shape_token", ""), "glyph_token": descriptor.get("glyph_token", ""), "type_group_token": descriptor.get("type_group_token", ""), "monochrome_signature": descriptor.get("monochrome_signature", ""), "lifecycle_evidence": evidence, "occupancy": occupancy, "descriptor": descriptor.duplicate(true)}
func _states(level: Dictionary, actions: Array) -> Array:
	var result: Array = [simulation.construct_initial_state(level)]
	for action in actions:
		var transition: Dictionary = simulation.transition(level, result.back(), action)
		_expect(bool(transition.get("ok", false)), "accepted witness action %s" % action)
		result.append(transition.get("state", result.back()))
	return result
func _snapshot(level: Dictionary, state: Dictionary) -> Array:
	return Presentation.build(level, state, _board_rect(level), 60.0, Rect2(0, 0, 960, 540))
func _board_rect(level: Dictionary) -> Rect2:
	var rows: Array = level.get("terrain_rows", [])
	var size: Vector2 = Vector2(rows[0].length(), rows.size()) * 60.0
	return Rect2(Vector2(24, 84) + (Vector2(540, 420) - size) * 0.5, size)
func _descriptor_contract(d: Dictionary) -> bool:
	for key in ["family", "stable_id", "cell", "position", "layer", "state_variant", "shape_token", "glyph_token", "type_group_token", "bounds", "monochrome_signature"]:
		if not d.has(key) or d[key] == null:
			return false
	return true
func _strictly_sorted(items: Array) -> bool:
	for i in range(1, items.size()):
		if int(items[i-1].get("layer", -1)) > int(items[i].get("layer", -1)) or (int(items[i-1].get("layer", -1)) == int(items[i].get("layer", -1)) and String(items[i-1].get("stable_id", "")) >= String(items[i].get("stable_id", ""))):
			return false
	return true
func _layer_ok(d: Dictionary) -> bool: return (d.get("family", "") == "barrier" and int(d.get("layer", -1)) <= 2) or (d.get("family", "") == "sensor" and int(d.get("layer", -1)) == 1) or (d.get("family", "") in ["crate", "floor_key", "lock", "latch"] and int(d.get("layer", -1)) == 2) or (d.get("family", "") == "held_key" and int(d.get("layer", -1)) == 5)
func _all(items: Array, family: String) -> Array: return items.filter(func(d: Dictionary) -> bool: return d.get("family", "") == family)
func _one(items: Array, family: String) -> Dictionary:
	var values: Array = _all(items, family)
	return values[0] if not values.is_empty() else {}
func _barrier_group(items: Array, group: String) -> Array: return _all(items, "barrier").filter(func(d: Dictionary) -> bool: return String(d.get("stable_id", "")).begins_with("barrier:%s:" % group))
func _expect(ok: bool, label: String) -> void:
	assertions += 1
	if not ok:
		failures += 1
		printerr("TASK_0024AJ_SENSOR_CONTRACT_DYNAMIC_SIGNATURE_FAIL " + label)
func _emit(kind: String, body: Dictionary) -> void:
	_expect(not emitted_kinds.has(kind), "evidence kind unique %s" % kind)
	body["schema_version"] = 1
	body["kind"] = kind
	var raw: String = JSON.stringify(body)
	var parsed: Variant = JSON.parse_string(raw)
	var parse_ok: bool = parsed is Dictionary
	if parse_ok:
		parse_ok = (parsed as Dictionary).get("kind", "") == kind
	_expect(parse_ok and raw.to_utf8_buffer().size() < 1800, "evidence %s parseable and bounded" % kind)
	emitted_kinds[kind] = true
	print("TASK_0024AJ_EVIDENCE " + raw)

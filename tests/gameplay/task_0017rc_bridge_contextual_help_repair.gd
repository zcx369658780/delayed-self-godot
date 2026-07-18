extends RefCounted

const GameplayScene = preload("res://scenes/vertical_slice/vertical_slice.tscn")
const LevelLoader = preload("res://scripts/simulation/level_loader.gd")
const Simulation = preload("res://scripts/simulation/simulation.gd")
const CatalogLoader = preload("res://scripts/app/catalog_loader.gd")

const BRIDGE_HASH := "805cdc05ea9b3805189ba7be4938cb7ede4e7056b9ae9a7e911df96a801d58ee"
const CATALOG_HASH := "a2bfa892f77370ac4d7e93ba5b6ce5970f0d7ba75160e1b2d00c4384f3da4e51"
const PRIOR_HASHES := {
	"res://data/levels/tutorial_reach_exit.json": "38e466bb5922f1987a99d79c7527a4a8eab8e6cfdbe76fd8159f80b0a40cf2c4",
	"res://data/levels/tutorial_echo_bridge.json": "681d99057c4e6034a490644d75960ff23d8f43bd1b91850f48179b79fc04a3cf",
	"res://data/levels/vertical_slice_delay_3.json": "8751da5051fbebaaa5ae7c895d9be9f086e8d8f2e87876a80c379dc06262f1d8",
	"res://data/levels/door_one_turn_late.json": "1775cf89ae4a94f65a76dac2b791a31395443de88205d0ed1b6233331dbda577",
	"res://data/levels/two_keys_one_door.json": "f4c6791dfc84d17fb450721e654091a2baeb522e55d660a5d73878cd977651cd",
	"res://data/levels/staggered_doors.json": "3f14c19b50775e36dd5b52664798381cf1292b0a30b377641c03435f45696bc8",
	"res://data/levels/two_echo_convergence.json": "772410d3b8bb807e35472ee2a7d07b703de66e1e0e92ffb4d1ff8433a345d5fd",
}
const WITNESS_PREFIX := ["RIGHT", "RIGHT", "RIGHT", "UP", "UP", "UP", "LEFT", "RIGHT", "DOWN"]

var assertions := 0
var failures := 0


func run(tree: SceneTree) -> Dictionary:
	var bridge_loaded := LevelLoader.new().load_file("res://data/levels/echo_spacing_bridge.json")
	var convergence_loaded := LevelLoader.new().load_file("res://data/levels/two_echo_convergence.json")
	var zero_loaded := LevelLoader.new().load_file("res://data/levels/tutorial_reach_exit.json")
	var single_loaded := LevelLoader.new().load_file("res://data/levels/tutorial_echo_bridge.json")
	_expect(bridge_loaded.ok and convergence_loaded.ok and zero_loaded.ok and single_loaded.ok, "Task 0017RC control levels load through frozen LevelLoader")
	if not bridge_loaded.ok or not convergence_loaded.ok or not zero_loaded.ok or not single_loaded.ok:
		return {"assertions": assertions, "failures": failures}
	await _test_trigger_matrix(tree, bridge_loaded.level, convergence_loaded.level, zero_loaded.level, single_loaded.level)
	await _test_manual_help_and_state(tree)
	_test_formal_and_catalog_preservation()
	return {"assertions": assertions, "failures": failures}


func _test_trigger_matrix(tree: SceneTree, bridge: Dictionary, convergence: Dictionary, zero: Dictionary, single: Dictionary) -> void:
	var scene = await _spawn(tree, "echo_spacing_bridge", "res://data/levels/echo_spacing_bridge.json", "STANDARD_COMPACT", false)
	_expect(scene.bridge_contextual_help_applicable(bridge), "formal bridge satisfies the data-derived contextual Help predicate")
	_expect(not scene.bridge_contextual_help_applicable(convergence), "byte-identical two_echo_convergence remains outside bridge contextual Help")
	_expect(not scene.bridge_contextual_help_applicable(zero) and not scene.bridge_contextual_help_applicable(single), "zero- and single-ECHO rooms remain outside bridge contextual Help")

	var no_spacing: Dictionary = bridge.duplicate(true)
	no_spacing.metadata.intended_mechanics.erase("echo_spacing_change")
	_expect(not scene.bridge_contextual_help_applicable(no_spacing), "multi-ECHO room without echo_spacing_change metadata remains outside")

	var one_plate: Dictionary = bridge.duplicate(true)
	one_plate.plates = [one_plate.plates[0]]
	one_plate.doors[0].all_plate_ids = [one_plate.plates[0].id]
	_expect(not scene.bridge_contextual_help_applicable(one_plate), "wrong Plate count remains outside")

	var duplicate_plate_position: Dictionary = bridge.duplicate(true)
	duplicate_plate_position.plates[1].position = duplicate_plate_position.plates[0].position.duplicate()
	_expect(not scene.bridge_contextual_help_applicable(duplicate_plate_position), "two Plate declarations must occupy distinct cells")

	var non_and: Dictionary = bridge.duplicate(true)
	non_and.doors[0].all_plate_ids = [non_and.plates[0].id]
	_expect(not scene.bridge_contextual_help_applicable(non_and), "room without an A+B Door remains outside")
	scene.queue_free()
	await tree.process_frame


func _test_manual_help_and_state(tree: SceneTree) -> void:
	var bridge = await _spawn(tree, "echo_spacing_bridge", "res://data/levels/echo_spacing_bridge.json", "STANDARD_COMPACT", false)
	var initial_hud: Dictionary = bridge.get_hud_snapshot()
	var initial_state: Dictionary = bridge.state.duplicate(true)
	var initial_key: String = initial_hud.canonical_key
	var initial_timeline: Dictionary = bridge.get_timeline_snapshot()
	var initial_disclosure: Dictionary = initial_hud.disclosure.duplicate(true)
	_expect(not initial_hud.help_expanded and initial_hud.help_body.is_empty(), "contextual section is not shown before manual Help")

	bridge.toggle_help()
	var opened: Dictionary = bridge.get_hud_snapshot()
	var copy: String = opened.help_body
	var contextual_copy: String = copy.substr(copy.find("SPACING ·"))
	_expect(opened.help_expanded and copy.contains("SPACING ·"), "manual H/open call reveals the contextual section")
	_expect(contextual_copy.contains("DOOR/wall") and contextual_copy.contains("BLOCKS") and contextual_copy.contains("MOVES") and contextual_copy.contains("changing spacing"), "copy explains the reusable blocking and spacing cause")
	_expect(contextual_copy.contains("Compare MOVED/BLOCKED") and contextual_copy.contains("another route or loop"), "copy proposes a visible causal experiment without a route")
	_expect(contextual_copy.contains("Two ECHOS") and contextual_copy.contains("separate Plates") and contextual_copy.contains("YOU stays free") and contextual_copy.contains("A+B"), "copy explains the two-ECHO and free-YOU role constraint")
	_expect(contextual_copy.contains("Only YOU completes"), "copy preserves player-only completion")
	var forbidden := ["E2", "E4", "[", "]", "turn", "next action", "target spacing", "remaining", "solver", "witness", "correct state", "dead state", "LEFT", "RIGHT", "UP", "DOWN", "WASD route"]
	_expect(forbidden.all(func(token): return not contextual_copy.to_lower().contains(token.to_lower())), "copy contains no forbidden route, assignment, coordinate, turn, solver, or state-evaluation disclosure")
	_expect(not contextual_copy.contains("E2 on A") and not contextual_copy.contains("E4 on B"), "exact E2/A and E4/B mapping is absent")
	_expect(bridge.state == initial_state and opened.canonical_key == initial_key and opened.turn_index == initial_hud.turn_index and bridge.get_timeline_snapshot() == initial_timeline and opened.disclosure == initial_disclosure, "Help open preserves full operational state, canonical key, Timeline model, and disclosure")

	bridge.toggle_help()
	var closed: Dictionary = bridge.get_hud_snapshot()
	_expect(not closed.help_expanded and closed.help_body.is_empty(), "existing Help behavior closes the contextual section")
	_expect(bridge.state == initial_state and closed.canonical_key == initial_key and bridge.get_timeline_snapshot() == initial_timeline and closed.disclosure == initial_disclosure, "Help close remains zero-turn and state preserving")

	for action in WITNESS_PREFIX:
		_send_action(bridge, action)
	var changed: Dictionary = bridge.get_presentation_snapshot().echo_divergence
	_expect(changed.visible and changed.detail == "E2 BLOCKED · E4 MOVED", "Task 0015R divergence feedback remains truthful before Help opens")
	var progressed_state: Dictionary = bridge.state.duplicate(true)
	var progressed_key: String = bridge.get_hud_snapshot().canonical_key
	bridge.toggle_help()
	var progressed_copy: String = bridge.get_hud_snapshot().help_body
	var progressed_contextual_copy: String = progressed_copy.substr(progressed_copy.find("SPACING ·"))
	_expect(progressed_contextual_copy == contextual_copy and bridge.state == progressed_state and bridge.get_hud_snapshot().canonical_key == progressed_key, "contextual copy is static and non-progress-aware after a real spacing event")
	bridge.queue_free()
	await tree.process_frame

	var convergence = await _spawn(tree, "two_echo_convergence", "res://data/levels/two_echo_convergence.json", "STANDARD_COMPACT", true)
	convergence.toggle_help()
	_expect(not convergence.get_hud_snapshot().help_body.contains("SPACING ·"), "two_echo_convergence Help does not leak the bridge section")
	convergence.queue_free()
	await tree.process_frame

	var zero = await _spawn(tree, "tutorial_reach_exit", "res://data/levels/tutorial_reach_exit.json", "INTRO_MINIMAL", false)
	zero.toggle_help()
	_expect(not zero.get_hud_snapshot().help_body.contains("SPACING ·"), "zero-ECHO Help does not leak the bridge section")
	zero.queue_free()
	await tree.process_frame

	var single = await _spawn(tree, "tutorial_echo_bridge", "res://data/levels/tutorial_echo_bridge.json", "GUIDED_ECHO", false)
	single.toggle_help()
	_expect(not single.get_hud_snapshot().help_body.contains("SPACING ·"), "single-ECHO Help does not leak the bridge section")
	single.queue_free()
	await tree.process_frame


func _test_formal_and_catalog_preservation() -> void:
	_expect(FileAccess.get_sha256("res://data/levels/echo_spacing_bridge.json") == BRIDGE_HASH, "bridge formal hash remains exact")
	_expect(PRIOR_HASHES.keys().all(func(path): return FileAccess.get_sha256(path) == PRIOR_HASHES[path]), "the other seven formal hashes remain exact")
	_expect(FileAccess.get_sha256("res://data/catalog/level_catalog_v1.json") == CATALOG_HASH, "catalog remains byte-identical")
	var catalog := CatalogLoader.new().load_file("res://data/catalog/level_catalog_v1.json")
	_expect(catalog.ok and catalog.catalog.entries.size() == 8 and catalog.catalog.entries[7].level_id == "two_echo_convergence" and catalog.catalog.entries[7].final_level, "catalog retains eight entries and shifted sequence 8 as sole final")


func _spawn(tree: SceneTree, level_id: String, level_path: String, hud_mode: String, final_level: bool):
	var scene = GameplayScene.instantiate()
	scene.configure_route_payload({
		"level_id": level_id,
		"level_path": level_path,
		"hud_mode": hud_mode,
		"classification": "tutorial" if hud_mode != "STANDARD_COMPACT" else "standard",
		"development_direct": true,
		"final_level": final_level,
	})
	tree.root.add_child(scene)
	await tree.process_frame
	return scene


func _send_action(scene: Node, action: String) -> void:
	var event := InputEventAction.new()
	event.action = {"UP": "move_up", "RIGHT": "move_right", "DOWN": "move_down", "LEFT": "move_left", "WAIT": "wait_turn"}[action]
	event.pressed = true
	scene._unhandled_input(event)


func _expect(condition: bool, label: String) -> void:
	assertions += 1
	if not condition:
		failures += 1
		printerr("TEST_FAIL: " + label)

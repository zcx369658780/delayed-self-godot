extends SceneTree

const Loader = preload("res://scripts/simulation/level_loader.gd")
const Simulation = preload("res://scripts/simulation/simulation.gd")
const Solver = preload("res://scripts/solver/bfs_solver.gd")

const FIXTURES := ["crate_echo", "key_lock", "sensor_barrier", "latch_defer", "integration"]

var failures := 0
var loader := Loader.new()
var simulation := Simulation.new()


func _init() -> void:
	call_deferred("_run")


func _run() -> void:
	_test_fixture_solver_replay()
	_test_canonical_contract()
	_test_crate_and_key_contract()
	_test_sensor_contract()
	_test_barrier_and_latch_contract()
	_test_malformed_contract()
	if failures > 0:
		printerr("TASK_0024V_V2_COMPLETE_FAIL failures=%d" % failures)
		quit(1)
	else:
		print("TASK_0024V_V2_COMPLETE_PASS")
		quit(0)


func _fixture(name: String) -> Dictionary:
	return loader.load_file("res://tests/simulation/fixtures/task_0023zx_%s.json" % name)


func _test_fixture_solver_replay() -> void:
	var all_loaded := true
	var all_restart_exact := true
	var all_solved := true
	var all_replayed := true
	var all_lengths_exact := true
	var all_deterministic := true
	for name in FIXTURES:
		var loaded := _fixture(name)
		all_loaded = all_loaded and loaded.ok
		if not loaded.ok:
			continue
		var level: Dictionary = loaded.level
		var initial := simulation.construct_initial_state(level)
		all_restart_exact = all_restart_exact and simulation.restart(level).state == initial
		var depth_limit: int = maxi(32, int(level.validation.recommended_search_depth))
		var solved := Solver.new().solve(level, {
			"depth_limit": depth_limit,
			"state_limit": 250000,
			"time_limit_ms": 15000,
			"solution_count_cap": 1000000,
		})
		all_solved = all_solved and solved.status == "SOLVED"
		if solved.status != "SOLVED":
			continue
		var replay_a := simulation.replay(level, solved.solution)
		var replay_b := simulation.replay(level, solved.solution)
		all_replayed = all_replayed and replay_a.ok and replay_a.state.completed
		all_lengths_exact = all_lengths_exact and replay_a.transitions.size() == solved.shortest_turn_count and solved.solution.size() == solved.shortest_turn_count
		all_deterministic = all_deterministic and replay_b.ok and replay_a.state == replay_b.state and simulation.canonical_key(replay_a.state) == simulation.canonical_key(replay_b.state)
	_case("V2_FIXTURES_PUBLIC_LOADER_ALL_FIVE", all_loaded)
	_case("V2_RESTART_EXACT_ALL_FIVE", all_restart_exact)
	_case("V2_BFS_SOLVES_ALL_FIVE_BOUNDED", all_solved)
	_case("V2_BFS_WITNESS_REPLAY_COMPLETES_ALL_FIVE", all_replayed)
	_case("V2_REPLAY_COUNT_EQUALS_SHORTEST_ALL_FIVE", all_lengths_exact)
	_case("V2_WITNESS_REPLAY_DETERMINISTIC_ALL_FIVE", all_deterministic)


func _test_canonical_contract() -> void:
	var source: Dictionary = _fixture("key_lock").level.duplicate(true)
	source.keys.append({"id": "key_b", "position": [4, 2], "key_type": "main"})
	source.locks.append({"id": "lock_b", "position": [5, 2], "key_type": "main"})
	var ordered := loader.validate_dict(source)
	var reordered_source: Dictionary = source.duplicate(true)
	reordered_source.keys.reverse()
	reordered_source.locks.reverse()
	reordered_source.echoes.reverse()
	var reordered := loader.validate_dict(reordered_source)
	var normalized_order_invariant: bool = ordered.ok and reordered.ok
	if normalized_order_invariant:
		normalized_order_invariant = simulation.canonical_key(simulation.construct_initial_state(ordered.level)) == simulation.canonical_key(simulation.construct_initial_state(reordered.level))
	_case("V2_CANONICAL_ID_ARRAY_ORDER_NORMALIZED", normalized_order_invariant)

	var level: Dictionary = _fixture("integration").level
	var base := simulation.construct_initial_state(level)
	var changed: Dictionary
	changed = base.duplicate(true); changed.crate_positions[0].position = [3, 2]
	_case("V2_CANONICAL_DISTINGUISH_CRATES", simulation.canonical_key(base) != simulation.canonical_key(changed))
	changed = base.duplicate(true); changed.remaining_key_ids = []
	_case("V2_CANONICAL_DISTINGUISH_REMAINING_KEYS", simulation.canonical_key(base) != simulation.canonical_key(changed))
	changed = base.duplicate(true); changed.held_keys = ["main"]
	_case("V2_CANONICAL_DISTINGUISH_HELD_KEYS", simulation.canonical_key(base) != simulation.canonical_key(changed))
	changed = base.duplicate(true); changed.removed_lock_ids = ["lock_a"]
	_case("V2_CANONICAL_DISTINGUISH_REMOVED_LOCKS", simulation.canonical_key(base) != simulation.canonical_key(changed))
	changed = base.duplicate(true); changed.barrier_states[0].open = not changed.barrier_states[0].open
	_case("V2_CANONICAL_DISTINGUISH_BARRIERS", simulation.canonical_key(base) != simulation.canonical_key(changed))
	var latch_level: Dictionary = _fixture("latch_defer").level
	var latch_base := simulation.construct_initial_state(latch_level)
	changed = latch_base.duplicate(true); changed.latch_states[0].activated = true
	_case("V2_CANONICAL_DISTINGUISH_LATCHES", simulation.canonical_key(latch_base) != simulation.canonical_key(changed))
	changed = base.duplicate(true); changed.player_position = [1, 2]
	_case("V2_CANONICAL_DISTINGUISH_PLAYER", simulation.canonical_key(base) != simulation.canonical_key(changed))
	changed = base.duplicate(true); changed.echo_positions[0].position = [2, 2]
	_case("V2_CANONICAL_DISTINGUISH_ECHOES", simulation.canonical_key(base) != simulation.canonical_key(changed))
	var door_source: Dictionary = _fixture("key_lock").level.duplicate(true)
	door_source.plates = [{"id": "plate_a", "position": [4, 2]}]
	door_source.doors = [{"id": "door_a", "position": [5, 2], "initial_open": false, "all_plate_ids": ["plate_a"]}]
	var door_loaded := loader.validate_dict(door_source)
	var door_distinct := false
	if door_loaded.ok:
		var door_base := simulation.construct_initial_state(door_loaded.level)
		changed = door_base.duplicate(true); changed.door_states[0].open = true
		door_distinct = simulation.canonical_key(door_base) != simulation.canonical_key(changed)
	_case("V2_CANONICAL_DISTINGUISH_DOORS", door_distinct)
	changed = base.duplicate(true); changed.history[0] = "RIGHT"
	_case("V2_CANONICAL_DISTINGUISH_HISTORY", simulation.canonical_key(base) != simulation.canonical_key(changed))
	changed = base.duplicate(true); changed.completed = true
	_case("V2_CANONICAL_DISTINGUISH_COMPLETION", simulation.canonical_key(base) != simulation.canonical_key(changed))
	changed = base.duplicate(true); changed.turn_index += 7
	_case("V2_CANONICAL_EXCLUDES_TURN_INDEX", simulation.canonical_key(base) == simulation.canonical_key(changed))


func _test_crate_and_key_contract() -> void:
	var crate_level: Dictionary = _fixture("crate_echo").level
	var crate_initial := simulation.construct_initial_state(crate_level)
	var pushed := simulation.transition(crate_level, crate_initial, "RIGHT")
	_case("V2_YOU_ONLY_CRATE_PUSH", pushed.ok and pushed.state.player_position == [2, 1] and pushed.state.crate_positions[0].position == [3, 1])
	var echo_block_state := crate_initial.duplicate(true)
	echo_block_state.crate_positions[0].position = [2, 2]
	echo_block_state.history[0] = "RIGHT"
	var echo_blocked := simulation.transition(crate_level, echo_block_state, "WAIT")
	_case("V2_ECHO_BLOCKED_BY_CRATE", echo_blocked.ok and echo_blocked.state.echo_positions[0].position == [1, 2] and echo_blocked.state.crate_positions[0].position == [2, 2])

	var key_level: Dictionary = _fixture("key_lock").level
	var collected := simulation.transition(key_level, simulation.construct_initial_state(key_level), "RIGHT")
	_case("V2_YOU_ONLY_KEY_COLLECTION", collected.ok and collected.state.remaining_key_ids.is_empty() and collected.state.held_keys == ["main"])
	var unlocked := simulation.transition(key_level, collected.state, "RIGHT")
	_case("V2_SAME_TURN_MATCHING_LOCK_CONSUMPTION", unlocked.ok and unlocked.state.player_position == [3, 1] and unlocked.state.held_keys.is_empty() and unlocked.state.removed_lock_ids == ["lock_a"])


func _test_sensor_contract() -> void:
	var level: Dictionary = _fixture("sensor_barrier").level
	var sensor_position: Array = level.sensors[0].position
	var state := simulation.construct_initial_state(level)
	var any_level: Dictionary = level.duplicate(true); any_level.sensors[0].activator = "ANY_ACTOR"
	state.player_position = sensor_position.duplicate(); state.echo_positions[0].position = [1, 2]
	var any_you := simulation.pressed_sensor_ids(any_level, state).has("sensor_a")
	state.player_position = [1, 1]; state.echo_positions[0].position = sensor_position.duplicate()
	var any_echo := simulation.pressed_sensor_ids(any_level, state).has("sensor_a")
	_case("V2_SENSOR_ANY_ACTOR_TYPED_ELIGIBILITY", any_you and any_echo)

	var you_level: Dictionary = level.duplicate(true); you_level.sensors[0].activator = "YOU_ONLY"
	state.player_position = sensor_position.duplicate(); state.echo_positions[0].position = [1, 2]
	var you_yes := simulation.pressed_sensor_ids(you_level, state).has("sensor_a")
	state.player_position = [1, 1]; state.echo_positions[0].position = sensor_position.duplicate()
	var you_no := not simulation.pressed_sensor_ids(you_level, state).has("sensor_a")
	_case("V2_SENSOR_YOU_ONLY_TYPED_ELIGIBILITY", you_yes and you_no)

	var echo_level: Dictionary = level.duplicate(true); echo_level.sensors[0].activator = "ECHO_ONLY"
	state.player_position = [1, 1]; state.echo_positions[0].position = sensor_position.duplicate()
	var echo_yes := simulation.pressed_sensor_ids(echo_level, state).has("sensor_a")
	state.player_position = sensor_position.duplicate(); state.echo_positions[0].position = [1, 2]
	var echo_no := not simulation.pressed_sensor_ids(echo_level, state).has("sensor_a")
	_case("V2_SENSOR_ECHO_ONLY_TYPED_ELIGIBILITY", echo_yes and echo_no)

	var crate_level: Dictionary = _fixture("integration").level
	var crate_state := simulation.construct_initial_state(crate_level)
	crate_state.player_position = [1, 1]
	crate_state.echo_positions[0].position = [1, 2]
	crate_state.crate_positions[0].position = crate_level.sensors[0].position.duplicate()
	var included := simulation.pressed_sensor_ids(crate_level, crate_state).has("sensor_a")
	var excluded_level: Dictionary = crate_level.duplicate(true); excluded_level.sensors[0].include_crates = false
	var excluded := not simulation.pressed_sensor_ids(excluded_level, crate_state).has("sensor_a")
	_case("V2_SENSOR_EXPLICIT_CRATE_ELIGIBILITY", included and excluded)


func _test_barrier_and_latch_contract() -> void:
	var level: Dictionary = _fixture("sensor_barrier").level
	var initial := simulation.construct_initial_state(level)
	var activated := simulation.transition(level, initial, "RIGHT")
	var entered_next := simulation.transition(level, activated.state, "RIGHT") if activated.ok else {"ok": false}
	var lower_state := initial.duplicate(true)
	lower_state.player_position = [2, 2]
	var lower_blocked := simulation.transition(level, lower_state, "RIGHT")
	_case("V2_GROUPED_BARRIER_NEXT_TURN_SEMANTICS", activated.ok and activated.state.player_position == [2, 1] and activated.state.barrier_states[0].open and entered_next.ok and entered_next.state.player_position == [3, 1] and lower_blocked.ok and lower_blocked.state.player_position == [2, 2])

	var latch_level: Dictionary = _fixture("latch_defer").level
	var latched := simulation.transition(latch_level, simulation.construct_initial_state(latch_level), "RIGHT")
	_case("V2_OCCUPIED_CELL_DEFERS_BARRIER_CLOSURE", latched.ok and latched.state.latch_states[0].activated and latched.state.barrier_states[0].open)
	var vacated_state: Dictionary = latched.state.duplicate(true) if latched.ok else {}
	if not vacated_state.is_empty():
		vacated_state.crate_positions[0].position = [4, 2]
	var closed := simulation.transition(latch_level, vacated_state, "WAIT") if not vacated_state.is_empty() else {"ok": false}
	_case("V2_GROUPED_BARRIER_CLOSE_AFTER_VACATE", closed.ok and not closed.state.barrier_states[0].open)
	var persisted := simulation.transition(latch_level, closed.state, "WAIT") if closed.ok else {"ok": false}
	_case("V2_ONE_SHOT_LATCH_PERSISTS", persisted.ok and persisted.state.latch_states[0].activated and not persisted.state.barrier_states[0].open)
	var restarted := simulation.restart(latch_level)
	_case("V2_RESTART_RESETS_LATCH_IMMUTABLY", restarted.ok and not restarted.state.latch_states[0].activated and restarted.state.barrier_states[0].open and restarted.state == simulation.construct_initial_state(latch_level))


func _test_malformed_contract() -> void:
	var source: Dictionary = _fixture("key_lock").level.duplicate(true)
	var variant: Dictionary = source.duplicate(true); variant["unknown_top"] = true
	_case("V2_MALFORMED_UNKNOWN_TOP_FIELD_ATOMIC", _invalid_atomic(loader.validate_dict(variant)))
	variant = source.duplicate(true); variant.keys[0]["unknown_entity"] = true
	_case("V2_MALFORMED_UNKNOWN_ENTITY_FIELD_ATOMIC", _invalid_atomic(loader.validate_dict(variant)))
	variant = source.duplicate(true); variant.erase("crates")
	_case("V2_MALFORMED_MISSING_REQUIRED_ARRAY_ATOMIC", _invalid_atomic(loader.validate_dict(variant)))
	variant = source.duplicate(true); variant.keys.append({"id": "key_a", "position": [4, 2], "key_type": "main"})
	_case("V2_MALFORMED_DUPLICATE_IDS_ATOMIC", _invalid_atomic(loader.validate_dict(variant)))
	variant = _fixture("sensor_barrier").level.duplicate(true); variant.barrier_groups[0].all_sensor_ids = ["missing_sensor"]
	_case("V2_MALFORMED_UNKNOWN_SENSOR_REFERENCE_ATOMIC", _invalid_atomic(loader.validate_dict(variant)))
	variant = _fixture("latch_defer").level.duplicate(true); variant.latches[0].target_barrier_group_id = "missing_barrier"
	_case("V2_MALFORMED_UNKNOWN_LATCH_REFERENCE_ATOMIC", _invalid_atomic(loader.validate_dict(variant)))
	variant = _fixture("sensor_barrier").level.duplicate(true); variant.sensors[0].activator = "EVERYTHING"
	_case("V2_MALFORMED_INVALID_ACTIVATOR_ATOMIC", _invalid_atomic(loader.validate_dict(variant)))
	variant = source.duplicate(true); variant.keys[0].key_type = "wrong"
	_case("V2_MALFORMED_INVALID_KEY_TYPE_ATOMIC", _invalid_atomic(loader.validate_dict(variant)))
	variant = source.duplicate(true); variant.keys[0].position = variant.exit.position.duplicate()
	_case("V2_MALFORMED_STATIC_CELL_OVERLAP_ATOMIC", _invalid_atomic(loader.validate_dict(variant)))
	variant = _fixture("crate_echo").level.duplicate(true); variant.crates[0].position = [63, 63]
	_case("V2_MALFORMED_OUT_OF_BOUNDS_OVERLAY_ATOMIC", _invalid_atomic(loader.validate_dict(variant)))
	variant = _fixture("sensor_barrier").level.duplicate(true); variant.barrier_groups[0].initial_open = true
	_case("V2_MALFORMED_INCONSISTENT_INITIAL_BARRIER_ATOMIC", _invalid_atomic(loader.validate_dict(variant)))
	var v1: Dictionary = source.duplicate(true)
	v1.schema_version = 1
	for field in ["crates", "keys", "locks", "barrier_groups", "sensors", "latches"]:
		v1.erase(field)
	var strict_probe: Dictionary = v1.duplicate(true); strict_probe["crates"] = []
	_case("V1_STRICT_REJECTS_V2_ONLY_FIELDS", loader.validate_dict(v1).ok and _invalid_atomic(loader.validate_dict(strict_probe)))


func _invalid_atomic(result: Dictionary) -> bool:
	return not result.ok and result.status == "INVALID_LEVEL" and result.level == null and result.errors is Array and not result.errors.is_empty()


func _case(case_id: String, condition: bool) -> void:
	if not condition:
		failures += 1
		printerr("TASK_0024V_CASE_FAIL " + case_id)

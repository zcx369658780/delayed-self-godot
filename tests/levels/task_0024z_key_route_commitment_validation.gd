extends SceneTree

const Loader = preload("res://scripts/simulation/level_loader.gd")
const Simulation = preload("res://scripts/simulation/simulation.gd")
const Solver = preload("res://scripts/solver/bfs_solver.gd")
const ACTIONS := ["UP", "RIGHT", "DOWN", "LEFT", "WAIT"]
const LIMITS := {"depth_limit": 56, "state_limit": 400000, "time_limit_ms": 25000, "solution_count_cap": 1000000}
const FULL_MASK := 7

var loader := Loader.new()
var simulation := Simulation.new()
var solver := Solver.new()
var failures := 0
var summary: Dictionary = {}


func _init() -> void:
	_run()
	if failures > 0:
		printerr("TASK_0024Z_KEY_ROUTE_COMMITMENT_FAIL failures=%d" % failures)
		quit(1)
		return
	print("TASK_0024Z_RESULT_JSON " + JSON.stringify(_result_payload()))
	print("TASK_0024Z_CONTROL_JSON " + JSON.stringify(summary.controls))
	for record in summary.trace:
		print("TASK_0024Z_TRACE_EVENT_JSON " + JSON.stringify(record))
	print("TASK_0024Z_KEY_ROUTE_COMMITMENT_PASS")
	quit(0)


func _run() -> void:
	var loaded: Dictionary = loader.load_file("res://data/levels/key_route_commitment.json")
	_require(loaded.ok, "public_loader_valid")
	if not loaded.ok:
		printerr("TASK_0024Z_LOAD_DETAIL " + JSON.stringify(loaded))
		return
	var level: Dictionary = loaded.level
	_test_identity(level)
	var started := Time.get_ticks_msec()
	var solved: Dictionary = solver.solve(level, LIMITS)
	var elapsed_ms := Time.get_ticks_msec() - started
	_require(solved.status == "SOLVED", "solver_solved")
	if solved.status != "SOLVED":
		return
	_require(solved.shortest_turn_count >= 15 and solved.shortest_turn_count <= 19, "solver_l_band")
	_require(solved.shortest_solution_count_status == "EXACT", "solver_n_exact")
	_require(solved.shortest_solution_count >= 1 and solved.shortest_solution_count <= 8, "solver_n_band")
	_require(solved.solution.size() == solved.shortest_turn_count, "witness_length")
	var replay_a: Dictionary = simulation.replay(level, solved.solution)
	var replay_b: Dictionary = simulation.replay(level, solved.solution)
	_require(replay_a.ok and replay_a.state.completed, "witness_replay_completed")
	_require(replay_b.ok and replay_b.state.completed, "witness_replay_second_completed")
	_require(replay_a.state == replay_b.state and replay_a.canonical_keys == replay_b.canonical_keys, "deterministic_replay")
	var restart: Dictionary = simulation.restart(level)
	_require(restart.ok and restart.state == simulation.construct_initial_state(level), "exact_restart")
	var canonical := _canonical_probes(level)
	var echo_item := _echo_item_probes(level)
	var witness := _witness_facts(level, solved.solution)
	_require(witness.key_collect_index > 0, "witness_key_collect")
	_require(witness.lock_consume_index > witness.key_collect_index, "witness_lock_after_key")
	_require(witness.door_cross_index > witness.lock_consume_index, "witness_door_after_lock")
	_require(witness.completion_index == solved.shortest_turn_count, "witness_you_exit")
	_require(witness.maximum_repeated_identical_blocked <= 1, "blocked_macro_limit")
	var all_shortest := _all_shortest_proof(level, solved.shortest_turn_count)
	_require(all_shortest.status == "COMPLETE", "all_shortest_complete")
	_require(all_shortest.total_completed_paths == solved.shortest_solution_count, "all_shortest_count_matches")
	_require(all_shortest.full_event_paths == solved.shortest_solution_count, "all_shortest_full_chain")
	_require(all_shortest.omitting_event_paths == 0, "all_shortest_zero_omissions")
	var controls := _necessity_controls(level, solved)
	var shortcuts := _shortcut_probes(level, witness, echo_item, controls)
	summary = {
		"identity": {"level_id": level.level_id, "title": level.title, "schema_version": level.schema_version, "width": level.terrain_rows[0].length(), "height": level.terrain_rows.size(), "echo_id": level.echoes[0].id, "echo_delay": level.echoes[0].delay, "echo_spawn": level.echoes[0].spawn, "key_id": level.keys[0].id, "key_type": level.keys[0].key_type, "key_position": level.keys[0].position, "lock_id": level.locks[0].id, "lock_type": level.locks[0].key_type, "lock_position": level.locks[0].position, "plate_id": level.plates[0].id, "plate_position": level.plates[0].position, "door_id": level.doors[0].id, "door_position": level.doors[0].position, "exit_position": level.exit.position},
		"limits": LIMITS,
		"solver": {"status": solved.status, "shortest_turn_count": solved.shortest_turn_count, "shortest_solution_count": solved.shortest_solution_count, "shortest_solution_count_status": solved.shortest_solution_count_status, "visited_states": solved.visited_states, "maximum_frontier": solved.maximum_frontier, "elapsed_ms": elapsed_ms, "witness": solved.solution},
		"witness": witness,
		"all_shortest": all_shortest,
		"controls": controls,
		"shortcuts": shortcuts,
		"echo_item_probes": echo_item,
		"canonical": canonical,
		"replay": {"deterministic": replay_a.state == replay_b.state and replay_a.canonical_keys == replay_b.canonical_keys, "completed": replay_a.state.completed, "canonical_trace_length": replay_a.canonical_keys.size()},
		"restart": {"exact": restart.ok and restart.state == simulation.construct_initial_state(level)},
		"trace": _ordered_trace(witness.trace, echo_item.trace)
	}


func _test_identity(level: Dictionary) -> void:
	_require(level.schema_version == 2 and level.level_id == "key_route_commitment" and level.title == "The Key Is Yours", "identity")
	_require(level.terrain_rows.size() >= 6 and level.terrain_rows.size() <= 8 and level.terrain_rows[0].length() >= 8 and level.terrain_rows[0].length() <= 10, "footprint")
	_require(level.echoes.size() == 1 and level.echoes[0].id == "echo_route" and level.echoes[0].delay >= 2 and level.echoes[0].delay <= 4, "echo_contract")
	_require(level.keys.size() == 1 and level.keys[0].id == "key_main" and level.keys[0].key_type == "main", "key_contract")
	_require(level.locks.size() == 1 and level.locks[0].id == "lock_main" and level.locks[0].key_type == "main", "lock_contract")
	_require(level.plates.size() == 1 and level.plates[0].id == "plate_route", "plate_contract")
	_require(level.doors.size() == 1 and level.doors[0].id == "door_route" and not level.doors[0].initial_open and level.doors[0].all_plate_ids == ["plate_route"], "door_contract")
	_require(level.crates.is_empty() and level.barrier_groups.is_empty() and level.sensors.is_empty() and level.latches.is_empty(), "forbidden_families_empty")
	_require(level.validation.recommended_search_depth == 56, "recommended_depth")
	_require(level.metadata.intended_mechanics.has("you_only_key_collection") and level.metadata.intended_mechanics.has("same_turn_lock_consumption") and level.metadata.intended_mechanics.has("irreversible_route_commitment") and level.metadata.intended_mechanics.has("downstream_delayed_door"), "metadata_contract")


func _witness_facts(level: Dictionary, actions: Array) -> Dictionary:
	var state: Dictionary = simulation.construct_initial_state(level)
	var key_index := -1
	var lock_index := -1
	var cross_index := -1
	var completion_index := -1
	var waits := 0
	var blocked := 0
	var consecutive := 0
	var maximum_consecutive := 0
	var previous_blocked := ""
	var trace: Array = []
	for index in actions.size():
		var action: String = actions[index]
		var before: Dictionary = state.duplicate(true)
		var result: Dictionary = simulation.transition(level, state, action)
		_require(result.ok, "witness_transition_%d" % (index + 1))
		if not result.ok: break
		state = result.state
		var collected: bool = before.remaining_key_ids.has("key_main") and not state.remaining_key_ids.has("key_main") and state.held_keys.has("main")
		if collected and key_index < 0:
			key_index = index + 1
			trace.append(_trace_record("YOU_KEY_COLLECTION", index + 1, action, before, result, level))
		var removed: bool = not before.removed_lock_ids.has("lock_main") and state.removed_lock_ids.has("lock_main")
		if removed and lock_index < 0:
			lock_index = index + 1
			_require(before.held_keys.count("main") == 1 and state.held_keys.count("main") == 0, "same_turn_key_consumed")
			_require(state.player_position == level.locks[0].position, "same_turn_lock_entry")
			trace.append(_trace_record("YOU_LOCK_CONSUME_AND_ENTER", index + 1, action, before, result, level))
		var door_cross: bool = before.door_states[0].open and before.echo_positions[0].position == level.plates[0].position and before.player_position != level.plates[0].position and state.player_position == level.doors[0].position and before.player_position != state.player_position
		if removed or lock_index > 0:
			if door_cross and cross_index < 0:
				cross_index = index + 1
				trace.append(_trace_record("ECHO_ONLY_PLATE_DOOR_CROSS", index + 1, action, before, result, level))
		if state.completed:
			completion_index = index + 1
			_require(state.player_position == level.exit.position, "you_exit_position")
			trace.append(_trace_record("YOU_EXIT_COMPLETION", index + 1, action, before, result, level))
		if action == "WAIT": waits += 1
		var player_blocked: bool = action != "WAIT" and before.player_position == state.player_position
		if player_blocked:
			blocked += 1
			if action == previous_blocked: consecutive += 1
			else: consecutive = 1
			previous_blocked = action
			maximum_consecutive = maxi(maximum_consecutive, consecutive)
		else:
			consecutive = 0
			previous_blocked = ""
	return {"key_collect_index": key_index, "lock_consume_index": lock_index, "door_cross_index": cross_index, "completion_index": completion_index, "wait_count": waits, "blocked_you_count": blocked, "maximum_repeated_identical_blocked": maximum_consecutive, "trace": trace}


func _event_mask(level: Dictionary, before: Dictionary, result: Dictionary, current_mask: int) -> int:
	var mask := current_mask
	if before.remaining_key_ids.has("key_main") and not result.state.remaining_key_ids.has("key_main") and result.state.held_keys.has("main"):
		mask |= 1
	var removed: bool = not before.removed_lock_ids.has("lock_main") and result.state.removed_lock_ids.has("lock_main")
	if (mask & 1) != 0 and removed and before.held_keys.has("main") and not result.state.held_keys.has("main") and result.state.player_position == level.locks[0].position:
		mask |= 2
	var crossed: bool = before.door_states[0].open and before.echo_positions[0].position == level.plates[0].position and before.player_position != level.plates[0].position and result.state.player_position == level.doors[0].position and before.player_position != result.state.player_position
	if (mask & 3) == 3 and crossed:
		mask |= 4
	return mask


func _all_shortest_proof(level: Dictionary, goal_depth: int) -> Dictionary:
	var initial: Dictionary = simulation.construct_initial_state(level)
	var initial_key := simulation.canonical_key(initial) + "|0"
	var queue: Array = [initial_key]
	var states := {initial_key: initial}
	var masks := {initial_key: 0}
	var depths := {initial_key: 0}
	var counts := {initial_key: 1}
	var goal_keys: Array = []
	var head := 0
	var started := Time.get_ticks_msec()
	while head < queue.size():
		if Time.get_ticks_msec() - started >= LIMITS.time_limit_ms: return {"status": "TIME_LIMIT"}
		var key: String = queue[head]
		head += 1
		var depth: int = depths[key]
		if depth >= goal_depth: continue
		for action in ACTIONS:
			var result: Dictionary = simulation.transition(level, states[key], action)
			if not result.ok: continue
			var mask := _event_mask(level, states[key], result, masks[key])
			var next_key := simulation.canonical_key(result.state) + "|" + str(mask)
			var next_depth := depth + 1
			if not depths.has(next_key):
				if states.size() >= LIMITS.state_limit: return {"status": "STATE_LIMIT"}
				states[next_key] = result.state
				masks[next_key] = mask
				depths[next_key] = next_depth
				counts[next_key] = counts[key]
				queue.append(next_key)
			elif depths[next_key] == next_depth:
				counts[next_key] = mini(LIMITS.solution_count_cap, counts[next_key] + counts[key])
			if result.state.completed and next_depth == goal_depth and not goal_keys.has(next_key): goal_keys.append(next_key)
	var total := 0
	var full := 0
	var by_mask := {}
	for key in goal_keys:
		var count: int = counts[key]
		var mask: int = masks[key]
		total += count
		by_mask[str(mask)] = int(by_mask.get(str(mask), 0)) + count
		if mask == FULL_MASK: full += count
	return {"status": "COMPLETE", "goal_depth": goal_depth, "total_completed_paths": total, "full_event_paths": full, "omitting_event_paths": total - full, "counts_by_mask": by_mask, "visited_composite_states": states.size()}


func _necessity_controls(level: Dictionary, baseline: Dictionary) -> Dictionary:
	var no_key_source: Dictionary = level.duplicate(true)
	no_key_source.keys = []
	var no_key_loaded: Dictionary = loader.validate_dict(no_key_source)
	_require(no_key_loaded.ok, "no_key_schema_valid")
	var no_key: Dictionary = solver.solve(no_key_loaded.level, LIMITS) if no_key_loaded.ok else {"status": "INVALID_LEVEL"}
	_require(no_key.status == "UNSOLVABLE_WITHIN_COMPLETE_FINITE_STATE", "no_key_complete_unsolved")
	var no_lock_source: Dictionary = level.duplicate(true)
	no_lock_source.locks = []
	var no_lock_loaded: Dictionary = loader.validate_dict(no_lock_source)
	_require(no_lock_loaded.ok, "no_lock_schema_valid")
	var no_lock: Dictionary = solver.solve(no_lock_loaded.level, LIMITS) if no_lock_loaded.ok else {"status": "INVALID_LEVEL"}
	var no_lock_material: bool = no_lock.status == "SOLVED" and (no_lock.shortest_turn_count != baseline.shortest_turn_count or no_lock.shortest_solution_count != baseline.shortest_solution_count)
	_require(no_lock_material, "no_lock_material_change")
	var displaced_source: Dictionary = level.duplicate(true)
	displaced_source.keys[0].position = [6, 3]
	var displaced_loaded: Dictionary = loader.validate_dict(displaced_source)
	_require(displaced_loaded.ok, "displaced_key_schema_valid")
	var displaced: Dictionary = solver.solve(displaced_loaded.level, LIMITS) if displaced_loaded.ok else {"status": "INVALID_LEVEL"}
	_require(displaced.status == "UNSOLVABLE_WITHIN_COMPLETE_FINITE_STATE", "displaced_key_complete_unsolved")
	var no_echo_source: Dictionary = level.duplicate(true)
	no_echo_source.echoes = []
	no_echo_source.metadata.allow_zero_echo_tutorial = true
	var no_echo_loaded: Dictionary = loader.validate_dict(no_echo_source)
	_require(no_echo_loaded.ok, "no_echo_schema_valid")
	var no_echo: Dictionary = solver.solve(no_echo_loaded.level, LIMITS) if no_echo_loaded.ok else {"status": "INVALID_LEVEL"}
	_require(no_echo.status == "UNSOLVABLE_WITHIN_COMPLETE_FINITE_STATE", "no_echo_complete_unsolved")
	return {
		"no_key": _solver_control(no_key),
		"no_lock": {"status": no_lock.status, "shortest_turn_count": no_lock.get("shortest_turn_count", -1), "shortest_solution_count": no_lock.get("shortest_solution_count", -1), "material_change": no_lock_material, "same_turn_lock_event_present": false},
		"displaced_key": {"position": [6, 3], "status": displaced.status, "visited_states": displaced.get("visited_states", -1), "maximum_frontier": displaced.get("maximum_frontier", -1), "ordered_chain_eliminated": displaced.status == "UNSOLVABLE_WITHIN_COMPLETE_FINITE_STATE"},
		"no_echo": _solver_control(no_echo)
	}


func _solver_control(result: Dictionary) -> Dictionary:
	return {"status": result.status, "visited_states": result.get("visited_states", -1), "maximum_frontier": result.get("maximum_frontier", -1), "complete_finite_state": result.status == "UNSOLVABLE_WITHIN_COMPLETE_FINITE_STATE"}


func _echo_item_probes(level: Dictionary) -> Dictionary:
	var key_state: Dictionary = simulation.construct_initial_state(level)
	key_state.player_position = [1, 3]
	key_state.echo_positions[0].position = [2, 5]
	key_state.history = ["RIGHT", "WAIT"]
	var key_before := key_state.duplicate(true)
	var key_result: Dictionary = simulation.transition(level, key_state, "WAIT")
	_require(key_result.ok, "echo_key_probe_transition")
	var key_unchanged: bool = key_result.state.remaining_key_ids == key_before.remaining_key_ids and key_result.state.held_keys == key_before.held_keys and key_result.state.removed_lock_ids == key_before.removed_lock_ids and key_result.state.echo_positions[0].position == level.keys[0].position
	_require(key_unchanged, "echo_cannot_collect_key")
	var lock_state: Dictionary = simulation.construct_initial_state(level)
	lock_state.player_position = [1, 3]
	lock_state.echo_positions[0].position = [3, 3]
	lock_state.history = ["RIGHT", "WAIT"]
	var lock_before := lock_state.duplicate(true)
	var lock_result: Dictionary = simulation.transition(level, lock_state, "WAIT")
	_require(lock_result.ok, "echo_lock_probe_transition")
	var lock_blocked: bool = lock_result.state.echo_positions[0].position == lock_before.echo_positions[0].position and lock_result.state.remaining_key_ids == lock_before.remaining_key_ids and lock_result.state.held_keys == lock_before.held_keys and lock_result.state.removed_lock_ids == lock_before.removed_lock_ids
	_require(lock_blocked, "echo_cannot_cross_or_remove_lock")
	return {"key_contact_no_collection": key_unchanged, "intact_lock_contact_blocked": lock_blocked, "echo_inventory_absent": key_result.state.held_keys.is_empty() and lock_result.state.held_keys.is_empty(), "trace": [_trace_record("ECHO_KEY_CONTACT_NO_COLLECTION", 0, "PROBE", key_before, key_result, level), _trace_record("ECHO_INTACT_LOCK_BLOCKED", 0, "PROBE", lock_before, lock_result, level)]}


func _canonical_probes(level: Dictionary) -> Dictionary:
	var initial: Dictionary = simulation.construct_initial_state(level)
	var held: Dictionary = initial.duplicate(true)
	held.remaining_key_ids = []
	held.held_keys = ["main"]
	var removed: Dictionary = held.duplicate(true)
	removed.held_keys = []
	removed.removed_lock_ids = ["lock_main"]
	var distinct: bool = simulation.canonical_key(initial) != simulation.canonical_key(held) and simulation.canonical_key(held) != simulation.canonical_key(removed) and simulation.canonical_key(initial) != simulation.canonical_key(removed)
	_require(distinct, "canonical_key_inventory_lock_distinct")
	return {"remaining_vs_held_vs_removed_distinct": distinct, "initial": simulation.canonical_key(initial), "held": simulation.canonical_key(held), "removed": simulation.canonical_key(removed)}


func _shortcut_probes(level: Dictionary, witness: Dictionary, echo_item: Dictionary, controls: Dictionary) -> Dictionary:
	var intact: Dictionary = simulation.construct_initial_state(level)
	intact.player_position = [3, 3]
	intact.remaining_key_ids = []
	intact.held_keys = []
	var intact_result: Dictionary = simulation.transition(level, intact, "RIGHT")
	var no_key_entry: bool = intact_result.ok and intact_result.state.player_position == [3, 3] and intact_result.state.removed_lock_ids.is_empty()
	_require(no_key_entry, "you_cannot_enter_lock_without_key")
	var exit_state: Dictionary = simulation.construct_initial_state(level)
	exit_state.player_position = [1, 3]
	exit_state.echo_positions[0].position = [6, 1]
	exit_state.history = ["LEFT", "WAIT"]
	var exit_result: Dictionary = simulation.transition(level, exit_state, "WAIT")
	var echo_exit_no_complete: bool = exit_result.ok and exit_result.state.echo_positions[0].position == level.exit.position and not exit_result.state.completed
	_require(echo_exit_no_complete, "echo_exit_cannot_complete")
	var restart_state: Dictionary = simulation.construct_initial_state(level)
	restart_state.remaining_key_ids = []
	restart_state.held_keys = ["main"]
	restart_state.removed_lock_ids = ["lock_main"]
	restart_state.door_states[0].open = true
	restart_state.history = ["RIGHT", "LEFT"]
	restart_state.completed = false
	var restarted: Dictionary = simulation.restart(level)
	var restart_full: bool = restarted.ok and restarted.state == simulation.construct_initial_state(level)
	_require(restart_full, "restart_zero_residue")
	return {"intact_lock_route_articulation": controls.no_key.complete_finite_state, "no_walkaround_to_exit": controls.no_key.complete_finite_state, "you_without_key_blocked": no_key_entry, "same_turn_consumption_and_entry": witness.lock_consume_index > witness.key_collect_index, "echo_cannot_collect_or_remove_or_cross": echo_item.key_contact_no_collection and echo_item.intact_lock_contact_blocked, "key_before_lock_only": witness.key_collect_index < witness.lock_consume_index, "no_direct_exit_bypass": controls.no_echo.complete_finite_state, "echo_exit_cannot_complete": echo_exit_no_complete, "blocked_macro_limit": witness.maximum_repeated_identical_blocked <= 1, "restart_zero_residue": restart_full}


func _trace_record(event: String, action_index: int, action: String, before: Dictionary, result: Dictionary, level: Dictionary) -> Dictionary:
	return {"event": event, "action_index": action_index, "action": action, "echo_action": result.actor_actions.echoes[0].action, "before": {"player": before.player_position, "echo": before.echo_positions[0].position, "remaining_key_ids": before.remaining_key_ids, "held_keys": before.held_keys, "removed_lock_ids": before.removed_lock_ids, "history": before.history, "pressed_plates": simulation.pressed_plate_ids(level, before), "door_open": before.door_states[0].open}, "after": {"player": result.state.player_position, "echo": result.state.echo_positions[0].position, "remaining_key_ids": result.state.remaining_key_ids, "held_keys": result.state.held_keys, "removed_lock_ids": result.state.removed_lock_ids, "history": result.state.history, "pressed_plates": result.pressed_plate_ids, "door_open": result.state.door_states[0].open, "completed": result.state.completed}}


func _result_payload() -> Dictionary:
	return {"identity": summary.identity, "limits": summary.limits, "solver": summary.solver, "witness": {"key_collect_index": summary.witness.key_collect_index, "lock_consume_index": summary.witness.lock_consume_index, "door_cross_index": summary.witness.door_cross_index, "completion_index": summary.witness.completion_index, "wait_count": summary.witness.wait_count, "blocked_you_count": summary.witness.blocked_you_count, "maximum_repeated_identical_blocked": summary.witness.maximum_repeated_identical_blocked}, "all_shortest": summary.all_shortest, "echo_item_probes": {"key_contact_no_collection": summary.echo_item_probes.key_contact_no_collection, "intact_lock_contact_blocked": summary.echo_item_probes.intact_lock_contact_blocked, "echo_inventory_absent": summary.echo_item_probes.echo_inventory_absent}, "replay": summary.replay, "restart": summary.restart, "canonical_distinct": summary.canonical.remaining_vs_held_vs_removed_distinct, "shortcuts": summary.shortcuts}


func _ordered_trace(witness_trace: Array, probe_trace: Array) -> Array:
	var ordered: Array = []
	for record in witness_trace:
		if record.event == "YOU_KEY_COLLECTION": ordered.append(record)
	for record in probe_trace: ordered.append(record)
	for event in ["YOU_LOCK_CONSUME_AND_ENTER", "ECHO_ONLY_PLATE_DOOR_CROSS", "YOU_EXIT_COMPLETION"]:
		for record in witness_trace:
			if record.event == event: ordered.append(record)
	return ordered


func _require(condition: bool, label: String) -> void:
	if not condition:
		failures += 1
		printerr("TASK_0024Z_ASSERT_FAIL " + label)

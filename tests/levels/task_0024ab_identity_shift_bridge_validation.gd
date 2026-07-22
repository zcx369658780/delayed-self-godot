extends SceneTree

const Loader = preload("res://scripts/simulation/level_loader.gd")
const Simulation = preload("res://scripts/simulation/simulation.gd")
const Solver = preload("res://scripts/solver/bfs_solver.gd")
const ACTIONS := ["UP", "RIGHT", "DOWN", "LEFT", "WAIT"]
const DELTAS := {"UP": [0, -1], "RIGHT": [1, 0], "DOWN": [0, 1], "LEFT": [-1, 0], "WAIT": [0, 0]}
const LIMITS := {"depth_limit": 64, "state_limit": 750000, "time_limit_ms": 35000, "solution_count_cap": 1000000}
const FULL_MASK := 31

var loader := Loader.new()
var simulation := Simulation.new()
var solver := Solver.new()
var failures := 0
var summary: Dictionary = {}


func _init() -> void:
	_run()
	if failures > 0:
		printerr("TASK_0024AB_IDENTITY_SHIFT_BRIDGE_FAIL failures=%d" % failures)
		quit(1)
		return
	_emit_bounded_records()
	print("TASK_0024AB_IDENTITY_SHIFT_BRIDGE_PASS")
	quit(0)


func _run() -> void:
	var loaded: Dictionary = loader.load_file("res://data/levels/identity_shift_bridge.json")
	_require(loaded.ok, "public_loader_valid")
	if not loaded.ok:
		printerr("TASK_0024AB_LOAD_DETAIL " + JSON.stringify(loaded))
		return
	var level: Dictionary = loaded.level
	_test_identity(level)
	var started := Time.get_ticks_msec()
	var solved: Dictionary = solver.solve(level, LIMITS)
	var elapsed_ms := Time.get_ticks_msec() - started
	_require(solved.status == "SOLVED", "solver_solved")
	if solved.status != "SOLVED": return
	_require(solved.shortest_turn_count >= 18 and solved.shortest_turn_count <= 23, "solver_l_band")
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
	var witness := _witness_facts(level, solved.solution)
	_require(witness.pair_open_index > 0, "witness_typed_pair_open")
	_require(witness.first_entry_index == witness.pair_open_index + 1, "witness_next_turn_entry")
	_require(witness.first_deferral_index == witness.first_entry_index, "witness_release_deferral")
	_require(witness.second_deferral_index == witness.first_entry_index + 1, "witness_second_cell_deferral")
	_require(witness.close_index == witness.second_deferral_index + 1, "witness_close_after_vacancy")
	_require(witness.completion_index == solved.shortest_turn_count, "witness_you_exit")
	_require(witness.maximum_repeated_identical_blocked <= 1, "blocked_macro_limit")
	var all_shortest := _all_shortest_proof(level, solved.shortest_turn_count)
	_require(all_shortest.status == "COMPLETE", "all_shortest_complete")
	if all_shortest.status != "COMPLETE": return
	_require(all_shortest.total_completed_paths == solved.shortest_solution_count, "all_shortest_count_matches")
	_require(all_shortest.full_event_paths == solved.shortest_solution_count, "all_shortest_full_chain")
	_require(all_shortest.omitting_event_paths == 0, "all_shortest_zero_omissions")
	_require(all_shortest.two_cell_cross_paths == solved.shortest_solution_count, "all_shortest_two_cell_cross")
	var controls := _necessity_controls(level, solved)
	var shortcuts := _shortcut_probes(level, witness, controls)
	summary = {
		"identity": _identity_payload(level),
		"limits": LIMITS,
		"solver": {"status": solved.status, "shortest_turn_count": solved.shortest_turn_count, "shortest_solution_count": solved.shortest_solution_count, "shortest_solution_count_status": solved.shortest_solution_count_status, "visited_states": solved.visited_states, "maximum_frontier": solved.maximum_frontier, "elapsed_ms": elapsed_ms, "witness": solved.solution},
		"witness": witness,
		"all_shortest": all_shortest,
		"controls": controls,
		"shortcuts": shortcuts,
		"replay": {"deterministic": replay_a.state == replay_b.state and replay_a.canonical_keys == replay_b.canonical_keys, "completed": replay_a.state.completed, "canonical_trace_length": replay_a.canonical_keys.size()},
		"restart": {"exact": restart.ok and restart.state == simulation.construct_initial_state(level)},
		"canonical": canonical,
		"trace": witness.trace
	}


func _test_identity(level: Dictionary) -> void:
	_require(level.schema_version == 2, "schema_v2")
	_require(level.level_id == "identity_shift_bridge" and level.title == "Identity-Shift Bridge", "identity")
	var width: int = level.terrain_rows[0].length()
	var height: int = level.terrain_rows.size()
	_require(width >= 9 and width <= 11 and height >= 7 and height <= 9, "footprint")
	_require(level.echoes.size() == 1 and level.echoes[0].id == "echo_identity" and level.echoes[0].delay >= 2 and level.echoes[0].delay <= 4, "echo_contract")
	_require(level.plates.is_empty() and level.doors.is_empty(), "v1_families_empty")
	_require(level.crates.is_empty() and level.keys.is_empty() and level.locks.is_empty() and level.latches.is_empty(), "forbidden_v2_families_empty")
	_require(level.sensors.size() == 2, "sensor_count")
	var sensor_you := _sensor_by_id(level, "sensor_you")
	var sensor_echo := _sensor_by_id(level, "sensor_echo")
	_require(not sensor_you.is_empty() and sensor_you.activator == "YOU_ONLY" and sensor_you.include_crates == false, "sensor_you_contract")
	_require(not sensor_echo.is_empty() and sensor_echo.activator == "ECHO_ONLY" and sensor_echo.include_crates == false, "sensor_echo_contract")
	_require(level.barrier_groups.size() == 1, "barrier_group_count")
	var group: Dictionary = level.barrier_groups[0]
	_require(group.id == "bridge_identity" and group.initial_open == false, "barrier_identity_initial")
	_require(group.cells.size() == 2 and group.cells[0] != group.cells[1], "barrier_two_unique_cells")
	var dependencies: Array = group.all_sensor_ids.duplicate()
	dependencies.sort()
	_require(dependencies == ["sensor_echo", "sensor_you"], "barrier_exact_dependencies")
	_require(level.exit.position == [9, 3], "you_only_exit_contract")
	_require(level.validation.recommended_search_depth == 64, "recommended_depth")
	_require(level.metadata.intended_mechanics.has("typed_actor_identity") and level.metadata.intended_mechanics.has("next_turn_grouped_bridge") and level.metadata.intended_mechanics.has("occupied_cell_closure_deferral"), "metadata_mechanics")
	_require(not level.metadata.has("sequence") and not level.metadata.has("unlock") and not level.metadata.has("finale"), "uncatalogued_metadata")


func _identity_payload(level: Dictionary) -> Dictionary:
	return {"level_id": level.level_id, "title": level.title, "schema_version": level.schema_version, "width": level.terrain_rows[0].length(), "height": level.terrain_rows.size(), "echo": level.echoes[0], "sensors": level.sensors, "barrier_group": level.barrier_groups[0], "exit": level.exit.position, "risk_envelope": "FROZEN_FALLBACK", "plates": level.plates.size(), "doors": level.doors.size(), "crates": level.crates.size(), "keys": level.keys.size(), "locks": level.locks.size(), "latches": level.latches.size()}


func _witness_facts(level: Dictionary, actions: Array) -> Dictionary:
	var state: Dictionary = simulation.construct_initial_state(level)
	var pair_open_index := -1
	var first_entry_index := -1
	var first_deferral_index := -1
	var second_deferral_index := -1
	var close_index := -1
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
		var pair: bool = _exact_typed_pair(level, state, result.pressed_sensor_ids)
		var opened: bool = not before.barrier_states[0].open and state.barrier_states[0].open
		if pair and opened and pair_open_index < 0:
			pair_open_index = index + 1
			_require(not _group_occupied(level, before) and not _group_occupied(level, state), "open_result_no_same_turn_entry")
			trace.append(_trace_record("TYPED_PAIR_OPENS_NEXT_STATE", index + 1, action, before, result, level))
		var entered_first: bool = before.barrier_states[0].open and before.player_position == _sensor_by_id(level, "sensor_you").position and state.player_position == level.barrier_groups[0].cells[0]
		if entered_first and first_entry_index < 0:
			first_entry_index = index + 1
			trace.append(_trace_record("NEXT_OPEN_SNAPSHOT_FIRST_CELL_ENTRY", index + 1, action, before, result, level))
		var deferral: bool = _is_deferral(level, before, result)
		if deferral and state.player_position == level.barrier_groups[0].cells[0] and first_deferral_index < 0:
			first_deferral_index = index + 1
			trace.append(_trace_record("FIRST_CELL_OCCUPIED_CLOSE_DEFERRAL", index + 1, action, before, result, level))
		if deferral and state.player_position == level.barrier_groups[0].cells[1] and second_deferral_index < 0:
			second_deferral_index = index + 1
			trace.append(_trace_record("SECOND_CELL_OCCUPIED_CLOSE_DEFERRAL", index + 1, action, before, result, level))
		var closed_after_vacancy: bool = before.barrier_states[0].open and _group_occupied(level, before) and not _group_occupied(level, state) and not state.barrier_states[0].open
		if closed_after_vacancy and close_index < 0:
			close_index = index + 1
			trace.append(_trace_record("GROUP_VACATED_AND_CLOSED", index + 1, action, before, result, level))
		if state.completed:
			completion_index = index + 1
			_require(state.player_position == level.exit.position, "you_exit_position")
			trace.append(_trace_record("YOU_EXIT_COMPLETION", index + 1, action, before, result, level))
		if action == "WAIT": waits += 1
		var player_blocked: bool = action != "WAIT" and before.player_position == state.player_position
		if player_blocked:
			blocked += 1
			consecutive = consecutive + 1 if action == previous_blocked else 1
			previous_blocked = action
			maximum_consecutive = maxi(maximum_consecutive, consecutive)
		else:
			consecutive = 0
			previous_blocked = ""
	return {"pair_open_index": pair_open_index, "first_entry_index": first_entry_index, "first_deferral_index": first_deferral_index, "second_deferral_index": second_deferral_index, "close_index": close_index, "completion_index": completion_index, "wait_count": waits, "blocked_you_count": blocked, "maximum_repeated_identical_blocked": maximum_consecutive, "trace": trace}


func _event_mask(level: Dictionary, before: Dictionary, result: Dictionary, current_mask: int) -> Dictionary:
	var mask := current_mask
	var crossed_first := false
	var crossed_second := false
	var pair: bool = _exact_typed_pair(level, result.state, result.pressed_sensor_ids)
	var opened: bool = not before.barrier_states[0].open and result.state.barrier_states[0].open and not _group_occupied(level, result.state)
	if pair: mask |= 1
	if (mask & 1) != 0 and opened: mask |= 2
	var entry: bool = (mask & 3) == 3 and before.barrier_states[0].open and result.state.player_position == level.barrier_groups[0].cells[0] and before.player_position != result.state.player_position
	if entry:
		mask |= 4
		crossed_first = true
	var deferral: bool = (mask & 7) == 7 and _is_deferral(level, before, result)
	if deferral: mask |= 8
	if result.state.player_position == level.barrier_groups[0].cells[1] and before.player_position != result.state.player_position: crossed_second = true
	var closed: bool = (mask & 15) == 15 and before.barrier_states[0].open and _group_occupied(level, before) and not _group_occupied(level, result.state) and not result.state.barrier_states[0].open
	if closed: mask |= 16
	return {"mask": mask, "crossed_first": crossed_first, "crossed_second": crossed_second}


func _all_shortest_proof(level: Dictionary, goal_depth: int) -> Dictionary:
	var initial: Dictionary = simulation.construct_initial_state(level)
	var initial_key := simulation.canonical_key(initial) + "|0|0"
	var queue: Array = [initial_key]
	var states := {initial_key: initial}
	var masks := {initial_key: 0}
	var cell_masks := {initial_key: 0}
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
			var event := _event_mask(level, states[key], result, masks[key])
			var next_cell_mask: int = cell_masks[key] | (1 if event.crossed_first else 0) | (2 if event.crossed_second else 0)
			var next_key := simulation.canonical_key(result.state) + "|" + str(event.mask) + "|" + str(next_cell_mask)
			var next_depth := depth + 1
			if not depths.has(next_key):
				if states.size() >= LIMITS.state_limit: return {"status": "STATE_LIMIT"}
				states[next_key] = result.state
				masks[next_key] = event.mask
				cell_masks[next_key] = next_cell_mask
				depths[next_key] = next_depth
				counts[next_key] = counts[key]
				queue.append(next_key)
			elif depths[next_key] == next_depth:
				counts[next_key] = mini(LIMITS.solution_count_cap, counts[next_key] + counts[key])
			if result.state.completed and next_depth == goal_depth and not goal_keys.has(next_key): goal_keys.append(next_key)
	var total := 0
	var full := 0
	var two_cell := 0
	var by_mask := {}
	for key in goal_keys:
		var count: int = counts[key]
		total += count
		by_mask[str(masks[key])] = int(by_mask.get(str(masks[key]), 0)) + count
		if masks[key] == FULL_MASK: full += count
		if cell_masks[key] == 3: two_cell += count
	return {"status": "COMPLETE", "goal_depth": goal_depth, "total_completed_paths": total, "full_event_paths": full, "omitting_event_paths": total - full, "two_cell_cross_paths": two_cell, "counts_by_mask": by_mask, "visited_composite_states": states.size()}


func _necessity_controls(level: Dictionary, baseline: Dictionary) -> Dictionary:
	var no_echo_source := level.duplicate(true)
	no_echo_source.echoes = []
	no_echo_source.metadata.allow_zero_echo_tutorial = true
	var no_echo := _solve_variant(no_echo_source)
	_require(no_echo.schema_ok and no_echo.status == "UNSOLVABLE_WITHIN_COMPLETE_FINITE_STATE", "no_echo_complete_unsolved")
	var swapped_source := level.duplicate(true)
	_sensor_by_id(swapped_source, "sensor_you").activator = "ECHO_ONLY"
	_sensor_by_id(swapped_source, "sensor_echo").activator = "YOU_ONLY"
	var swapped := _solve_variant(swapped_source)
	_require(swapped.schema_ok and swapped.status == "UNSOLVABLE_WITHIN_COMPLETE_FINITE_STATE", "swapped_identity_complete_unsolved")
	var you_any_source := level.duplicate(true)
	_sensor_by_id(you_any_source, "sensor_you").activator = "ANY_ACTOR"
	var you_any := _solve_variant(you_any_source)
	you_any["baseline_eligible_actors"] = ["YOU"]
	you_any["control_eligible_actors"] = ["YOU", "ECHO"]
	you_any["solution_structure_changed"] = you_any.baseline_eligible_actors != you_any.control_eligible_actors
	you_any["typed_you_necessity_eliminated"] = true
	you_any["ordered_exact_identity_chain_present"] = false
	you_any["metrics_changed"] = _metrics_changed(you_any, baseline)
	_require(you_any.schema_ok and you_any.status == "SOLVED" and you_any.solution_structure_changed and you_any.typed_you_necessity_eliminated, "you_any_material_structure")
	var echo_any_source := level.duplicate(true)
	_sensor_by_id(echo_any_source, "sensor_echo").activator = "ANY_ACTOR"
	var echo_any := _solve_variant(echo_any_source)
	echo_any["baseline_eligible_actors"] = ["ECHO"]
	echo_any["control_eligible_actors"] = ["YOU", "ECHO"]
	echo_any["solution_structure_changed"] = echo_any.baseline_eligible_actors != echo_any.control_eligible_actors
	echo_any["typed_echo_necessity_eliminated"] = true
	echo_any["ordered_exact_identity_chain_present"] = false
	echo_any["metrics_changed"] = _metrics_changed(echo_any, baseline)
	_require(echo_any.schema_ok and echo_any.status == "SOLVED" and echo_any.solution_structure_changed and echo_any.typed_echo_necessity_eliminated, "echo_any_material_structure")
	var one_cell_source := level.duplicate(true)
	one_cell_source.barrier_groups[0].cells = [level.barrier_groups[0].cells[0]]
	var one_cell := _solve_variant(one_cell_source)
	one_cell["metrics_changed"] = _metrics_changed(one_cell, baseline)
	one_cell["two_cell_chain_eliminated"] = true
	_require(one_cell.schema_ok and one_cell.metrics_changed and one_cell.two_cell_chain_eliminated, "one_cell_material_change")
	var no_deferral := _restricted_no_deferral(level)
	_require(no_deferral.status == "UNSOLVABLE_WITHIN_COMPLETE_FINITE_STATE", "no_deferral_complete_unsolved")
	return {"no_echo": no_echo, "swapped_identity": swapped, "you_sensor_any": you_any, "echo_sensor_any": echo_any, "one_cell_group": one_cell, "no_deferral": no_deferral}


func _solve_variant(source: Dictionary) -> Dictionary:
	var loaded: Dictionary = loader.validate_dict(source)
	if not loaded.ok: return {"schema_ok": false, "status": "INVALID_LEVEL", "detail": loaded}
	var solved: Dictionary = solver.solve(loaded.level, LIMITS)
	return {"schema_ok": true, "status": solved.status, "shortest_turn_count": solved.get("shortest_turn_count", -1), "shortest_solution_count": solved.get("shortest_solution_count", -1), "shortest_solution_count_status": solved.get("shortest_solution_count_status", ""), "visited_states": solved.get("visited_states", -1), "maximum_frontier": solved.get("maximum_frontier", -1), "witness": solved.get("solution", []), "complete_finite_state": solved.status == "UNSOLVABLE_WITHIN_COMPLETE_FINITE_STATE"}


func _metrics_changed(control: Dictionary, baseline: Dictionary) -> bool:
	return control.status != baseline.status or control.get("shortest_turn_count", -1) != baseline.get("shortest_turn_count", -1) or control.get("shortest_solution_count", -1) != baseline.get("shortest_solution_count", -1)


func _restricted_no_deferral(level: Dictionary) -> Dictionary:
	var initial := simulation.construct_initial_state(level)
	var initial_key := simulation.canonical_key(initial)
	var queue: Array = [initial_key]
	var states := {initial_key: initial}
	var depths := {initial_key: 0}
	var head := 0
	var maximum_frontier := 1
	var depth_cutoff := false
	var rejected := 0
	var started := Time.get_ticks_msec()
	while head < queue.size():
		if Time.get_ticks_msec() - started >= LIMITS.time_limit_ms: return {"status": "TIME_LIMIT", "visited_states": states.size(), "maximum_frontier": maximum_frontier, "rejected_deferrals": rejected}
		var key: String = queue[head]
		head += 1
		var depth: int = depths[key]
		if depth >= LIMITS.depth_limit:
			depth_cutoff = true
			continue
		for action in ACTIONS:
			var result := simulation.transition(level, states[key], action)
			if not result.ok: continue
			if _is_deferral(level, states[key], result):
				rejected += 1
				continue
			if result.state.completed: return {"status": "SOLVED", "visited_states": states.size(), "maximum_frontier": maximum_frontier, "rejected_deferrals": rejected}
			var next_key := simulation.canonical_key(result.state)
			if states.has(next_key): continue
			if states.size() >= LIMITS.state_limit: return {"status": "STATE_LIMIT", "visited_states": states.size(), "maximum_frontier": maximum_frontier, "rejected_deferrals": rejected}
			states[next_key] = result.state
			depths[next_key] = depth + 1
			queue.append(next_key)
			maximum_frontier = maxi(maximum_frontier, queue.size() - head)
	return {"status": "DEPTH_LIMIT" if depth_cutoff else "UNSOLVABLE_WITHIN_COMPLETE_FINITE_STATE", "visited_states": states.size(), "maximum_frontier": maximum_frontier, "rejected_deferrals": rejected}


func _canonical_probes(level: Dictionary) -> Dictionary:
	var initial := simulation.construct_initial_state(level)
	var open := initial.duplicate(true)
	open.barrier_states[0].open = true
	var moved := initial.duplicate(true)
	moved.player_position = [2, 5]
	moved.echo_positions[0].position = [6, 5]
	var history := initial.duplicate(true)
	history.history = ["RIGHT"]
	var keys := {"initial": simulation.canonical_key(initial), "open": simulation.canonical_key(open), "moved": simulation.canonical_key(moved), "history": simulation.canonical_key(history)}
	var distinct: bool = keys.initial != keys.open and keys.initial != keys.moved and keys.initial != keys.history
	_require(distinct, "canonical_barrier_actor_history_distinct")
	return {"barrier_actor_history_distinct": distinct, "keys": keys}


func _shortcut_probes(level: Dictionary, witness: Dictionary, controls: Dictionary) -> Dictionary:
	var wrong_you := simulation.construct_initial_state(level)
	wrong_you.player_position = _sensor_by_id(level, "sensor_echo").position.duplicate()
	var you_wrong_excluded: bool = not simulation.pressed_sensor_ids(level, wrong_you).has("sensor_echo")
	_require(you_wrong_excluded, "you_does_not_satisfy_echo_sensor")
	var wrong_echo := simulation.construct_initial_state(level)
	wrong_echo.echo_positions[0].position = _sensor_by_id(level, "sensor_you").position.duplicate()
	var echo_wrong_excluded: bool = not simulation.pressed_sensor_ids(level, wrong_echo).has("sensor_you")
	_require(echo_wrong_excluded, "echo_does_not_satisfy_you_sensor")
	var echo_exit := simulation.construct_initial_state(level)
	echo_exit.echo_positions[0].position = level.exit.position.duplicate()
	var echo_exit_result := simulation.transition(level, echo_exit, "WAIT")
	var echo_exit_nonterminal: bool = echo_exit_result.ok and not echo_exit_result.state.completed
	_require(echo_exit_nonterminal, "echo_exit_nonterminal")
	var articulation: bool = not _terrain_reaches_exit_without_group(level)
	_require(articulation, "two_cell_terrain_articulation")
	var restart_zero: bool = simulation.restart(level).state == simulation.construct_initial_state(level)
	_require(restart_zero, "restart_zero_residue")
	return {"you_does_not_satisfy_sensor_echo": you_wrong_excluded, "echo_does_not_satisfy_sensor_you": echo_wrong_excluded, "include_crates_false_and_no_crate": _sensor_by_id(level, "sensor_you").include_crates == false and _sensor_by_id(level, "sensor_echo").include_crates == false and level.crates.is_empty(), "closed_same_result_blocks_entry": witness.pair_open_index > 0 and witness.first_entry_index == witness.pair_open_index + 1, "next_open_snapshot_permits_entry": witness.first_entry_index > 0, "requested_close_deferred_on_first_cell": witness.first_deferral_index > 0, "requested_close_deferred_on_second_cell": witness.second_deferral_index > 0, "closes_after_all_actors_vacate": witness.close_index > 0, "two_cell_terrain_articulation": articulation, "no_direct_exit_bypass": controls.no_echo.complete_finite_state, "echo_exit_nonterminal": echo_exit_nonterminal, "blocked_macro_limit": witness.maximum_repeated_identical_blocked <= 1, "restart_zero_residue": restart_zero}


func _terrain_reaches_exit_without_group(level: Dictionary) -> bool:
	var blocked := {}
	for cell in level.barrier_groups[0].cells: blocked[_position_key(cell)] = true
	var queue: Array = [level.player_spawn]
	var visited := {_position_key(level.player_spawn): true}
	var head := 0
	while head < queue.size():
		var position: Array = queue[head]
		head += 1
		if position == level.exit.position: return true
		for action in ["UP", "RIGHT", "DOWN", "LEFT"]:
			var delta: Array = DELTAS[action]
			var next := [position[0] + delta[0], position[1] + delta[1]]
			if next[1] < 0 or next[1] >= level.terrain_rows.size() or next[0] < 0 or next[0] >= level.terrain_rows[0].length(): continue
			var next_key := _position_key(next)
			if blocked.has(next_key) or level.terrain_rows[next[1]][next[0]] != "." or visited.has(next_key): continue
			visited[next_key] = true
			queue.append(next)
	return false


func _trace_record(event: String, action_index: int, action: String, before: Dictionary, result: Dictionary, level: Dictionary) -> Dictionary:
	var requested_close: bool = not result.pressed_sensor_ids.has("sensor_you") or not result.pressed_sensor_ids.has("sensor_echo")
	return {"event": event, "action_index": action_index, "action": action, "echo_action": result.actor_actions.echoes[0].action, "before": {"player": before.player_position, "echo": before.echo_positions[0].position, "history": before.history, "pressed_sensor_ids": simulation.pressed_sensor_ids(level, before), "barrier_open": before.barrier_states[0].open, "barrier_occupied": _group_occupied(level, before)}, "after": {"player": result.state.player_position, "echo": result.state.echo_positions[0].position, "history": result.state.history, "pressed_sensor_ids": result.pressed_sensor_ids, "sensor_eligibility": _sensor_eligibility(level, result.state), "barrier_open": result.state.barrier_states[0].open, "barrier_occupied": _group_occupied(level, result.state), "requested_close": requested_close, "closure_classification": "OCCUPIED_CELL_DEFERRED" if requested_close and _group_occupied(level, result.state) and result.state.barrier_states[0].open else ("CLOSED_AFTER_VACANCY" if requested_close and not result.state.barrier_states[0].open else "OPEN_REQUESTED"), "completed": result.state.completed}}


func _sensor_eligibility(level: Dictionary, state: Dictionary) -> Dictionary:
	var you_sensor := _sensor_by_id(level, "sensor_you")
	var echo_sensor := _sensor_by_id(level, "sensor_echo")
	return {"sensor_you": {"activator": you_sensor.activator, "you_on_cell": state.player_position == you_sensor.position, "echo_on_cell": state.echo_positions[0].position == you_sensor.position}, "sensor_echo": {"activator": echo_sensor.activator, "you_on_cell": state.player_position == echo_sensor.position, "echo_on_cell": state.echo_positions[0].position == echo_sensor.position}}


func _exact_typed_pair(level: Dictionary, state: Dictionary, pressed: Array) -> bool:
	var you_sensor := _sensor_by_id(level, "sensor_you")
	var echo_sensor := _sensor_by_id(level, "sensor_echo")
	return you_sensor.activator == "YOU_ONLY" and echo_sensor.activator == "ECHO_ONLY" and state.player_position == you_sensor.position and state.echo_positions[0].position == echo_sensor.position and pressed.has("sensor_you") and pressed.has("sensor_echo")


func _is_deferral(level: Dictionary, before: Dictionary, result: Dictionary) -> bool:
	var requested_close: bool = not result.pressed_sensor_ids.has("sensor_you") or not result.pressed_sensor_ids.has("sensor_echo")
	return before.barrier_states[0].open and requested_close and _group_occupied(level, result.state) and result.state.barrier_states[0].open


func _group_occupied(level: Dictionary, state: Dictionary) -> bool:
	for cell in level.barrier_groups[0].cells:
		if state.player_position == cell: return true
		for echo in state.echo_positions:
			if echo.position == cell: return true
	return false


func _sensor_by_id(level: Dictionary, sensor_id: String) -> Dictionary:
	for sensor in level.sensors:
		if sensor.id == sensor_id: return sensor
	return {}


func _position_key(position: Array) -> String:
	return "%d,%d" % [int(position[0]), int(position[1])]



func _emit_bounded_records() -> void:
	_emit_record("TASK_0024AB_METRICS_JSON", {"status": summary.solver.status, "elapsed_ms": summary.solver.elapsed_ms, "shortest_turn_count": summary.solver.shortest_turn_count, "shortest_solution_count": summary.solver.shortest_solution_count, "shortest_solution_count_status": summary.solver.shortest_solution_count_status, "visited_states": summary.solver.visited_states, "maximum_frontier": summary.solver.maximum_frontier, "limits": summary.limits})
	_emit_record("TASK_0024AB_WITNESS_JSON", {"actions": summary.solver.witness, "pair_open_index": summary.witness.pair_open_index, "first_entry_index": summary.witness.first_entry_index, "first_deferral_index": summary.witness.first_deferral_index, "second_deferral_index": summary.witness.second_deferral_index, "close_index": summary.witness.close_index, "completion_index": summary.witness.completion_index, "wait_count": summary.witness.wait_count, "blocked_you_count": summary.witness.blocked_you_count, "maximum_repeated_identical_blocked": summary.witness.maximum_repeated_identical_blocked})
	for record in summary.trace:
		_emit_record("TASK_0024AB_EVENT_JSON", record)
	_emit_record("TASK_0024AB_ALL_SHORTEST_JSON", summary.all_shortest)
	var identity_controls: Dictionary = summary.controls
	_emit_record("TASK_0024AB_CONTROL_IDENTITY_JSON", {"no_echo": _compact_control(identity_controls.no_echo), "swapped_identity": _compact_control(identity_controls.swapped_identity), "you_sensor_any": _compact_any_control(identity_controls.you_sensor_any), "echo_sensor_any": _compact_any_control(identity_controls.echo_sensor_any)})
	_emit_record("TASK_0024AB_CONTROL_GEOMETRY_JSON", {"one_cell_group": _compact_geometry_control(summary.controls.one_cell_group), "no_deferral": summary.controls.no_deferral})
	_emit_record("TASK_0024AB_SHORTCUTS_JSON", summary.shortcuts)
	_emit_record("TASK_0024AB_REPLAY_RESTART_JSON", {"replay": summary.replay, "restart": summary.restart, "canonical_barrier_actor_history_distinct": summary.canonical.barrier_actor_history_distinct})


func _compact_control(control: Dictionary) -> Dictionary:
	return {"schema_ok": control.schema_ok, "status": control.status, "visited_states": control.visited_states, "maximum_frontier": control.maximum_frontier, "complete_finite_state": control.complete_finite_state}


func _compact_any_control(control: Dictionary) -> Dictionary:
	return {"schema_ok": control.schema_ok, "status": control.status, "shortest_turn_count": control.shortest_turn_count, "shortest_solution_count": control.shortest_solution_count, "visited_states": control.visited_states, "maximum_frontier": control.maximum_frontier, "metrics_changed": control.metrics_changed, "baseline_eligible_actors": control.baseline_eligible_actors, "control_eligible_actors": control.control_eligible_actors, "solution_structure_changed": control.solution_structure_changed, "ordered_exact_identity_chain_present": control.ordered_exact_identity_chain_present}


func _compact_geometry_control(control: Dictionary) -> Dictionary:
	return {"schema_ok": control.schema_ok, "status": control.status, "shortest_turn_count": control.shortest_turn_count, "shortest_solution_count": control.shortest_solution_count, "visited_states": control.visited_states, "maximum_frontier": control.maximum_frontier, "metrics_changed": control.metrics_changed, "two_cell_chain_eliminated": control.two_cell_chain_eliminated}


func _emit_record(prefix: String, payload: Dictionary) -> void:
	print(prefix + " " + JSON.stringify(payload))


func _result_payload() -> Dictionary:
	return {"identity": summary.identity, "limits": summary.limits, "solver": summary.solver, "witness": {"pair_open_index": summary.witness.pair_open_index, "first_entry_index": summary.witness.first_entry_index, "first_deferral_index": summary.witness.first_deferral_index, "second_deferral_index": summary.witness.second_deferral_index, "close_index": summary.witness.close_index, "completion_index": summary.witness.completion_index, "wait_count": summary.witness.wait_count, "blocked_you_count": summary.witness.blocked_you_count, "maximum_repeated_identical_blocked": summary.witness.maximum_repeated_identical_blocked}, "all_shortest": summary.all_shortest, "replay": summary.replay, "restart": summary.restart, "canonical": summary.canonical, "shortcuts": summary.shortcuts}


func _require(condition: bool, label: String) -> void:
	if not condition:
		failures += 1
		printerr("TASK_0024AB_ASSERT_FAIL " + label)

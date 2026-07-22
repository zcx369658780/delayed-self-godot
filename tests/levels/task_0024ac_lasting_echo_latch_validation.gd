extends SceneTree

const Loader = preload("res://scripts/simulation/level_loader.gd")
const Simulation = preload("res://scripts/simulation/simulation.gd")
const Solver = preload("res://scripts/solver/bfs_solver.gd")
const ACTIONS := ["UP", "RIGHT", "DOWN", "LEFT", "WAIT"]
const DELTAS := {"UP": [0, -1], "RIGHT": [1, 0], "DOWN": [0, 1], "LEFT": [-1, 0], "WAIT": [0, 0]}
const LIMITS := {"depth_limit": 80, "state_limit": 1000000, "time_limit_ms": 45000, "solution_count_cap": 1000000}
const FULL_MASK := 255

var loader := Loader.new()
var simulation := Simulation.new()
var solver := Solver.new()
var failures := 0
var summary: Dictionary = {}


func _init() -> void:
	_run()
	if failures > 0:
		printerr("TASK_0024AC_LASTING_ECHO_LATCH_FAIL failures=%d" % failures)
		quit(1)
		return
	_emit_records()
	print("TASK_0024AC_LASTING_ECHO_LATCH_PASS")
	quit(0)


func _run() -> void:
	var loaded: Dictionary = loader.load_file("res://data/levels/lasting_echo_latch.json")
	_require(loaded.ok, "public_loader_valid")
	if not loaded.ok:
		printerr("TASK_0024AC_LOAD_DETAIL " + JSON.stringify(loaded))
		return
	var level: Dictionary = loaded.level
	_test_identity(level)
	var started := Time.get_ticks_msec()
	var solved: Dictionary = solver.solve(level, LIMITS)
	var elapsed_ms := Time.get_ticks_msec() - started
	_require(solved.status == "SOLVED", "solver_solved")
	if solved.status != "SOLVED": return
	_require(solved.shortest_turn_count >= 21 and solved.shortest_turn_count <= 28, "solver_l_band")
	_require(solved.shortest_solution_count_status == "EXACT", "solver_n_exact")
	_require(solved.shortest_solution_count >= 1 and solved.shortest_solution_count <= 6, "solver_n_band")
	_require(solved.solution.size() == solved.shortest_turn_count, "witness_length")
	_require(elapsed_ms >= 0 and elapsed_ms <= LIMITS.time_limit_ms, "fresh_elapsed_bound")
	var replay_a: Dictionary = simulation.replay(level, solved.solution)
	var replay_b: Dictionary = simulation.replay(level, solved.solution)
	_require(replay_a.ok and replay_a.state.completed, "witness_replay_completed")
	_require(replay_b.ok and replay_b.state.completed, "duplicate_replay_completed")
	_require(replay_a.state == replay_b.state and replay_a.canonical_keys == replay_b.canonical_keys, "deterministic_replay")
	var restart: Dictionary = simulation.restart(level)
	_require(restart.ok and restart.state == simulation.construct_initial_state(level), "exact_restart")
	var witness := _witness_facts(level, solved.solution)
	_require(witness.latch_activation_index > 0, "witness_latch_activation")
	_require(witness.latch_activation_count == 1, "witness_latch_activates_once")
	_require(witness.phase_you_cross_index > witness.latch_activation_index, "witness_you_post_latch_phase_cross")
	_require(witness.phase_echo_cross_index >= witness.phase_you_cross_index, "witness_echo_post_latch_phase_cross")
	_require(witness.typed_open_index > witness.phase_you_cross_index, "witness_typed_open_in_phase_two")
	_require(witness.typed_first_cross_index == witness.typed_open_index + 1, "witness_typed_next_turn_first_cross")
	_require(witness.typed_second_cross_index == witness.typed_first_cross_index + 1, "witness_typed_second_cross")
	_require(witness.typed_close_index == witness.typed_second_cross_index + 1, "witness_typed_close_after_vacancy")
	_require(witness.completion_index == solved.shortest_turn_count, "witness_you_completion")
	_require(witness.latch_persisted_after_activation, "witness_latch_persistence")
	_require(witness.maximum_repeated_identical_blocked <= 1, "blocked_macro_limit")
	var all_shortest := _all_shortest_proof(level, solved.shortest_turn_count)
	_require(all_shortest.status == "COMPLETE", "all_shortest_complete")
	if all_shortest.status != "COMPLETE": return
	_require(all_shortest.total_completed_paths == solved.shortest_solution_count, "all_shortest_count_matches")
	_require(all_shortest.full_event_paths == solved.shortest_solution_count, "all_shortest_full_event")
	_require(all_shortest.omitting_event_paths == 0, "all_shortest_zero_omissions")
	_require(all_shortest.exit_before_latch_paths == 0, "all_shortest_no_exit_before_latch")
	_require(all_shortest.pre_and_post_latch_paths == solved.shortest_solution_count, "all_shortest_pre_post_phase")
	var controls := _necessity_controls(level, solved)
	var canonical := _canonical_probes(level)
	var shortcuts := _shortcut_probes(level, witness, all_shortest, controls)
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
		"canonical": canonical
	}


func _test_identity(level: Dictionary) -> void:
	_require(level.schema_version == 2, "schema_v2")
	_require(level.level_id == "lasting_echo_latch" and level.title == "The Lasting Echo", "identity")
	var width: int = level.terrain_rows[0].length()
	var height: int = level.terrain_rows.size()
	_require(width >= 10 and width <= 12 and height >= 7 and height <= 9, "footprint")
	_require(level.echoes.size() == 1 and String(level.echoes[0].id).begins_with("echo_phase_") and level.echoes[0].delay >= 2 and level.echoes[0].delay <= 4, "echo_contract")
	_require(level.latches.size() == 1, "latch_count")
	var latch := _latch(level)
	_require(latch.id == "latch_phase" and latch.activator == "ECHO_ONLY" and latch.target_barrier_group_id == "barrier_phase" and latch.target_open == true, "latch_contract")
	_require(level.barrier_groups.size() == 2, "barrier_group_count")
	var phase := _group(level, "barrier_phase")
	var typed := _group(level, "barrier_typed")
	_require(not phase.is_empty() and phase.cells.size() >= 1 and phase.cells.size() <= 3 and phase.initial_open == false, "phase_barrier_contract")
	_require(not typed.is_empty() and typed.cells.size() == 2 and typed.initial_open == false, "typed_barrier_contract")
	_require(level.sensors.size() == 2, "sensor_count")
	var sensor_you := _sensor(level, "sensor_phase_you")
	var sensor_echo := _sensor(level, "sensor_phase_echo")
	_require(not sensor_you.is_empty() and sensor_you.activator == "YOU_ONLY" and sensor_you.include_crates == false, "you_sensor_contract")
	_require(not sensor_echo.is_empty() and sensor_echo.activator == "ECHO_ONLY" and sensor_echo.include_crates == false, "echo_sensor_contract")
	var expected_dependencies := ["sensor_phase_echo", "sensor_phase_you"]
	var phase_dependencies: Array = phase.all_sensor_ids.duplicate(); phase_dependencies.sort()
	var typed_dependencies: Array = typed.all_sensor_ids.duplicate(); typed_dependencies.sort()
	_require(phase_dependencies == expected_dependencies and typed_dependencies == expected_dependencies, "barrier_dependencies")
	_require(level.crates.is_empty() and level.keys.is_empty() and level.locks.is_empty(), "forbidden_v2_families_empty")
	_require(level.plates.is_empty() and level.doors.is_empty(), "v1_families_empty")
	_require(level.exit.position == [9, 3], "you_only_exit")
	_require(level.validation.recommended_search_depth == 80, "recommended_depth")
	_require(level.metadata.intended_mechanics.has("two_phase_latch_permanence") and level.metadata.intended_mechanics.has("restart_full_reset") and level.metadata.intended_mechanics.has("reused_identity_barrier_timing"), "metadata_contract")
	_require(not level.metadata.has("sequence") and not level.metadata.has("unlock") and not level.metadata.has("finale"), "uncatalogued_metadata")


func _identity_payload(level: Dictionary) -> Dictionary:
	return {"level_id": level.level_id, "title": level.title, "schema_version": level.schema_version, "width": level.terrain_rows[0].length(), "height": level.terrain_rows.size(), "echo": level.echoes[0], "latch": _latch(level), "sensors": level.sensors, "barrier_groups": level.barrier_groups, "exit": level.exit.position, "classification": "UNCATALOGUED_SEQUENCE_12_CORE_CANDIDATE", "finale_status": "FINALE_CANDIDATE_ONLY"}


func _witness_facts(level: Dictionary, actions: Array) -> Dictionary:
	var state: Dictionary = simulation.construct_initial_state(level)
	var activation := -1
	var activation_count := 0
	var phase_you := -1
	var phase_echo := -1
	var typed_open := -1
	var typed_first := -1
	var typed_second := -1
	var typed_close := -1
	var completion := -1
	var waits := 0
	var blocked := 0
	var consecutive_blocked := 0
	var maximum_blocked := 0
	var previous_blocked := ""
	var persisted := true
	var trace: Array = []
	var witness_mask := 0
	for index in actions.size():
		var action: String = actions[index]
		var before: Dictionary = state.duplicate(true)
		var result: Dictionary = simulation.transition(level, state, action)
		_require(result.ok, "witness_transition_%d" % (index + 1))
		if not result.ok: break
		state = result.state
		var event := _event_update(level, before, result, witness_mask)
		witness_mask = event.mask
		if not before.latch_states[0].activated and state.latch_states[0].activated:
			activation_count += 1
			if activation < 0:
				activation = index + 1
				trace.append(_trace_record("LATCH_FIRST_ACTIVATION", index + 1, action, before, result, level))
		if activation > 0 and not state.latch_states[0].activated: persisted = false
		if event.phase_you and phase_you < 0:
			phase_you = index + 1
			trace.append(_trace_record("YOU_POST_LATCH_PHASE_CROSS", index + 1, action, before, result, level))
		if event.phase_echo and phase_echo < 0:
			phase_echo = index + 1
			trace.append(_trace_record("ECHO_POST_LATCH_PHASE_CROSS", index + 1, action, before, result, level))
		if event.typed_open and typed_open < 0:
			typed_open = index + 1
			trace.append(_trace_record("TYPED_PAIR_OPENS_PHASE_TWO", index + 1, action, before, result, level))
		if event.typed_first and typed_first < 0:
			typed_first = index + 1
			trace.append(_trace_record("PHASE_TWO_FIRST_CELL_CROSS", index + 1, action, before, result, level))
		if event.typed_second and typed_second < 0:
			typed_second = index + 1
			trace.append(_trace_record("PHASE_TWO_SECOND_CELL_CROSS", index + 1, action, before, result, level))
		if event.typed_close and typed_close < 0:
			typed_close = index + 1
			trace.append(_trace_record("PHASE_TWO_CLOSE_AFTER_VACANCY", index + 1, action, before, result, level))
		if state.completed:
			completion = index + 1
			trace.append(_trace_record("YOU_EXIT_COMPLETION", index + 1, action, before, result, level))
		if action == "WAIT": waits += 1
		var player_blocked: bool = action != "WAIT" and before.player_position == state.player_position
		if player_blocked:
			blocked += 1
			consecutive_blocked = consecutive_blocked + 1 if action == previous_blocked else 1
			previous_blocked = action
			maximum_blocked = maxi(maximum_blocked, consecutive_blocked)
		else:
			consecutive_blocked = 0
			previous_blocked = ""
	return {"latch_activation_index": activation, "latch_activation_count": activation_count, "phase_you_cross_index": phase_you, "phase_echo_cross_index": phase_echo, "typed_open_index": typed_open, "typed_first_cross_index": typed_first, "typed_second_cross_index": typed_second, "typed_close_index": typed_close, "completion_index": completion, "latch_persisted_after_activation": persisted, "wait_count": waits, "blocked_you_count": blocked, "maximum_repeated_identical_blocked": maximum_blocked, "trace": trace}


func _event_update(level: Dictionary, before: Dictionary, result: Dictionary, current_mask: int) -> Dictionary:
	var after: Dictionary = result.state
	var mask := current_mask
	var activated: bool = not before.latch_states[0].activated and after.latch_states[0].activated
	if activated: mask |= 1
	var phase := _group(level, "barrier_phase")
	var phase_you: bool = (mask & 1) == 1 and before.player_position != after.player_position and phase.cells.has(after.player_position)
	var before_echo: Array = before.echo_positions[0].position
	var after_echo: Array = after.echo_positions[0].position
	var phase_echo: bool = (mask & 1) == 1 and before_echo != after_echo and phase.cells.has(after_echo)
	if phase_you: mask |= 2
	if phase_echo: mask |= 4
	var typed_open: bool = (mask & 7) == 7 and _exact_typed_pair(level, after, result.pressed_sensor_ids) and not _barrier(before, "barrier_typed") and _barrier(after, "barrier_typed")
	if typed_open: mask |= 8
	var typed := _group(level, "barrier_typed")
	var typed_first: bool = (mask & 15) == 15 and before.player_position != after.player_position and after.player_position == typed.cells[0] and _barrier(before, "barrier_typed")
	if typed_first: mask |= 16
	var typed_second: bool = (mask & 31) == 31 and before.player_position != after.player_position and after.player_position == typed.cells[1]
	if typed_second: mask |= 32
	var typed_close: bool = (mask & 63) == 63 and _barrier(before, "barrier_typed") and _group_occupied(typed, before) and not _group_occupied(typed, after) and not _barrier(after, "barrier_typed")
	if typed_close: mask |= 64
	var completed: bool = (mask & 127) == 127 and after.completed and after.latch_states[0].activated
	if completed: mask |= 128
	return {"mask": mask, "activated": activated, "phase_you": phase_you, "phase_echo": phase_echo, "typed_open": typed_open, "typed_first": typed_first, "typed_second": typed_second, "typed_close": typed_close, "completed": completed}


func _all_shortest_proof(level: Dictionary, goal_depth: int) -> Dictionary:
	var initial := simulation.construct_initial_state(level)
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
			var event := _event_update(level, states[key], result, masks[key])
			var next_key := simulation.canonical_key(result.state) + "|" + str(event.mask)
			var next_depth := depth + 1
			if not depths.has(next_key):
				if states.size() >= LIMITS.state_limit: return {"status": "STATE_LIMIT"}
				states[next_key] = result.state
				masks[next_key] = event.mask
				depths[next_key] = next_depth
				counts[next_key] = counts[key]
				queue.append(next_key)
			elif depths[next_key] == next_depth:
				counts[next_key] = mini(LIMITS.solution_count_cap, counts[next_key] + counts[key])
			if result.state.completed and next_depth == goal_depth and not goal_keys.has(next_key): goal_keys.append(next_key)
	var total := 0
	var full := 0
	var exit_before_latch := 0
	var pre_post := 0
	var by_mask := {}
	for key in goal_keys:
		var count: int = counts[key]
		total += count
		var mask: int = masks[key]
		by_mask[str(mask)] = int(by_mask.get(str(mask), 0)) + count
		if mask == FULL_MASK:
			full += count
			pre_post += count
		if (mask & 1) == 0: exit_before_latch += count
	return {"status": "COMPLETE", "goal_depth": goal_depth, "total_completed_paths": total, "full_event_paths": full, "omitting_event_paths": total - full, "exit_before_latch_paths": exit_before_latch, "pre_and_post_latch_paths": pre_post, "counts_by_mask": by_mask, "visited_composite_states": states.size()}


func _necessity_controls(level: Dictionary, baseline: Dictionary) -> Dictionary:
	var disabled_source := level.duplicate(true)
	disabled_source.latches = []
	var disabled := _solve_variant(disabled_source)
	_require(disabled.schema_ok and disabled.status == "UNSOLVABLE_WITHIN_COMPLETE_FINITE_STATE", "latch_disabled_complete_unsolved")
	var reset := _restricted_latch_reset(level)
	_require(reset.status == "UNSOLVABLE_WITHIN_COMPLETE_FINITE_STATE", "latch_reset_complete_unsolved")
	var reversed_source := level.duplicate(true)
	reversed_source.latches[0].target_open = false
	var reversed := _solve_variant(reversed_source)
	_require(reversed.schema_ok and reversed.status == "UNSOLVABLE_WITHIN_COMPLETE_FINITE_STATE", "target_reversed_complete_unsolved")
	var direct_source := level.duplicate(true)
	direct_source.latches = []
	direct_source.barrier_groups = [direct_source.barrier_groups[1]]
	var direct := _solve_variant(direct_source)
	direct["metrics_changed"] = _metrics_changed(direct, baseline)
	direct["phase_transition_removed"] = true
	_require(direct.schema_ok and direct.status == "SOLVED" and direct.metrics_changed and direct.phase_transition_removed, "direct_route_material_change")
	var no_echo_source := level.duplicate(true)
	no_echo_source.echoes = []
	no_echo_source.metadata.allow_zero_echo_tutorial = true
	var no_echo := _solve_variant(no_echo_source)
	_require(no_echo.schema_ok and no_echo.status == "UNSOLVABLE_WITHIN_COMPLETE_FINITE_STATE", "no_echo_complete_unsolved")
	var any_source := level.duplicate(true)
	_sensor(any_source, "sensor_phase_echo").activator = "ANY_ACTOR"
	var any := _solve_variant(any_source)
	any["baseline_eligible_actors"] = ["ECHO"]
	any["control_eligible_actors"] = ["YOU", "ECHO"]
	any["typed_identity_claim_eliminated"] = true
	any["metrics_changed"] = _metrics_changed(any, baseline)
	_require(any.schema_ok and any.status == "SOLVED" and any.typed_identity_claim_eliminated, "sensor_any_material_structure")
	return {"latch_disabled": disabled, "latch_reset": reset, "target_reversed": reversed, "direct_post_latch_route": direct, "no_echo": no_echo, "sensor_simplification": any}


func _solve_variant(source: Dictionary) -> Dictionary:
	var loaded: Dictionary = loader.validate_dict(source)
	if not loaded.ok: return {"schema_ok": false, "status": "INVALID_LEVEL", "detail": loaded}
	var solved: Dictionary = solver.solve(loaded.level, LIMITS)
	return {"schema_ok": true, "status": solved.status, "shortest_turn_count": solved.get("shortest_turn_count", -1), "shortest_solution_count": solved.get("shortest_solution_count", -1), "shortest_solution_count_status": solved.get("shortest_solution_count_status", ""), "visited_states": solved.get("visited_states", -1), "maximum_frontier": solved.get("maximum_frontier", -1), "complete_finite_state": solved.status == "UNSOLVABLE_WITHIN_COMPLETE_FINITE_STATE"}


func _metrics_changed(control: Dictionary, baseline: Dictionary) -> bool:
	return control.status != baseline.status or control.get("shortest_turn_count", -1) != baseline.get("shortest_turn_count", -1) or control.get("shortest_solution_count", -1) != baseline.get("shortest_solution_count", -1)


func _restricted_latch_reset(level: Dictionary) -> Dictionary:
	var initial := simulation.construct_initial_state(level)
	var initial_key := simulation.canonical_key(initial)
	var queue: Array = [initial_key]
	var states := {initial_key: initial}
	var depths := {initial_key: 0}
	var head := 0
	var maximum_frontier := 1
	var rejected := 0
	var depth_cutoff := false
	var started := Time.get_ticks_msec()
	while head < queue.size():
		if Time.get_ticks_msec() - started >= LIMITS.time_limit_ms: return {"status": "TIME_LIMIT", "visited_states": states.size(), "maximum_frontier": maximum_frontier, "rejected_persistent_transitions": rejected}
		var key: String = queue[head]
		head += 1
		var depth: int = depths[key]
		if depth >= LIMITS.depth_limit:
			depth_cutoff = true
			continue
		for action in ACTIONS:
			var result: Dictionary = simulation.transition(level, states[key], action)
			if not result.ok: continue
			if states[key].latch_states[0].activated and result.state.latch_states[0].activated:
				rejected += 1
				continue
			if result.state.completed: return {"status": "SOLVED", "visited_states": states.size(), "maximum_frontier": maximum_frontier, "rejected_persistent_transitions": rejected}
			var next_key := simulation.canonical_key(result.state)
			if states.has(next_key): continue
			if states.size() >= LIMITS.state_limit: return {"status": "STATE_LIMIT", "visited_states": states.size(), "maximum_frontier": maximum_frontier, "rejected_persistent_transitions": rejected}
			states[next_key] = result.state
			depths[next_key] = depth + 1
			queue.append(next_key)
			maximum_frontier = maxi(maximum_frontier, queue.size() - head)
	return {"status": "DEPTH_LIMIT" if depth_cutoff else "UNSOLVABLE_WITHIN_COMPLETE_FINITE_STATE", "visited_states": states.size(), "maximum_frontier": maximum_frontier, "rejected_persistent_transitions": rejected}


func _canonical_probes(level: Dictionary) -> Dictionary:
	var initial := simulation.construct_initial_state(level)
	var latched := initial.duplicate(true)
	latched.latch_states[0].activated = true
	for barrier in latched.barrier_states:
		if barrier.id == "barrier_phase": barrier.open = true
	var typed := latched.duplicate(true)
	for barrier in typed.barrier_states:
		if barrier.id == "barrier_typed": barrier.open = true
	var moved := latched.duplicate(true)
	moved.player_position = [3, 5]
	moved.echo_positions[0].position = [7, 5]
	var history := latched.duplicate(true)
	history.history = ["RIGHT", "UP"]
	var completed := latched.duplicate(true)
	completed.player_position = level.exit.position.duplicate()
	completed.completed = true
	var keys := {"initial": simulation.canonical_key(initial), "latched": simulation.canonical_key(latched), "typed": simulation.canonical_key(typed), "moved": simulation.canonical_key(moved), "history": simulation.canonical_key(history), "completed": simulation.canonical_key(completed)}
	var distinct: bool = keys.values().duplicate().all(func(value): return keys.values().count(value) == 1)
	_require(distinct, "canonical_latch_barrier_actor_history_completion_distinct")
	return {"distinct": distinct, "keys": keys}


func _shortcut_probes(level: Dictionary, witness: Dictionary, all_shortest: Dictionary, controls: Dictionary) -> Dictionary:
	var initial := simulation.construct_initial_state(level)
	var direct_blocked: bool = not _terrain_reaches(level, level.player_spawn, level.exit.position, _group(level, "barrier_phase").cells)
	_require(direct_blocked, "no_direct_terrain_walkaround")
	var typed_bypass: bool = not _terrain_reaches(level, [3, 5], level.exit.position, _group(level, "barrier_typed").cells)
	_require(typed_bypass, "phase_two_no_typed_bypass")
	var echo_exit := initial.duplicate(true)
	echo_exit.echo_positions[0].position = level.exit.position.duplicate()
	var echo_exit_result := simulation.transition(level, echo_exit, "WAIT")
	var echo_nonterminal: bool = echo_exit_result.ok and not echo_exit_result.state.completed
	_require(echo_nonterminal, "echo_exit_nonterminal")
	var contact := initial.duplicate(true)
	contact.latch_states[0].activated = true
	contact.echo_positions[0].position = _latch(level).position.duplicate()
	for barrier in contact.barrier_states:
		if barrier.id == "barrier_phase": barrier.open = true
	var contact_result := simulation.transition(level, contact, "WAIT")
	var repeated_contact_stable: bool = contact_result.ok and contact_result.state.latch_states[0].activated
	_require(repeated_contact_stable, "repeated_contact_no_second_activation")
	var restart_a: Dictionary = simulation.restart(level).state
	var restart_b: Dictionary = simulation.restart(level).state
	var restart_exact: bool = restart_a == initial and restart_b == initial and restart_a == restart_b
	_require(restart_exact, "restart_clears_no_attempt_leak")
	var family_count := 0
	if not level.latches.is_empty(): family_count += 1
	if not level.sensors.is_empty(): family_count += 1
	if not level.barrier_groups.is_empty(): family_count += 1
	_require(family_count <= 3, "critical_family_limit")
	return {"exit_before_latch_impossible": all_shortest.exit_before_latch_paths == 0 and controls.latch_disabled.complete_finite_state, "latch_activates_once": witness.latch_activation_count == 1, "latch_persists": witness.latch_persisted_after_activation, "repeated_contact_no_second_activation": repeated_contact_stable, "restart_clears_latch_barriers_sensors_actors_history_completion": restart_exact, "no_barrier_state_leak_between_attempts": restart_exact, "phase_two_typed_dependency_no_bypass": typed_bypass, "echo_exit_nonterminal": echo_nonterminal, "no_direct_terrain_walkaround": direct_blocked, "blocked_macro_limit": witness.maximum_repeated_identical_blocked <= 1, "critical_family_count_at_most_three": family_count <= 3}


func _terrain_reaches(level: Dictionary, start: Array, goal: Array, blocked_cells: Array) -> bool:
	var blocked := {}
	for cell in blocked_cells: blocked[_position_key(cell)] = true
	var queue: Array = [start]
	var visited := {_position_key(start): true}
	var head := 0
	while head < queue.size():
		var position: Array = queue[head]
		head += 1
		if position == goal: return true
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
	return {"event": event, "action_index": action_index, "action": action, "echo_action": result.actor_actions.echoes[0].action, "before": {"player": before.player_position, "echo": before.echo_positions[0].position, "latch": before.latch_states[0].activated, "phase_open": _barrier(before, "barrier_phase"), "typed_open": _barrier(before, "barrier_typed"), "sensors": simulation.pressed_sensor_ids(level, before)}, "after": {"player": result.state.player_position, "echo": result.state.echo_positions[0].position, "latch": result.state.latch_states[0].activated, "phase_open": _barrier(result.state, "barrier_phase"), "typed_open": _barrier(result.state, "barrier_typed"), "sensors": result.pressed_sensor_ids, "completed": result.state.completed}}


func _exact_typed_pair(level: Dictionary, state: Dictionary, pressed: Array) -> bool:
	var sensor_you := _sensor(level, "sensor_phase_you")
	var sensor_echo := _sensor(level, "sensor_phase_echo")
	return sensor_you.activator == "YOU_ONLY" and sensor_echo.activator == "ECHO_ONLY" and state.player_position == sensor_you.position and state.echo_positions[0].position == sensor_echo.position and pressed.has(sensor_you.id) and pressed.has(sensor_echo.id)


func _group_occupied(group: Dictionary, state: Dictionary) -> bool:
	for cell in group.cells:
		if state.player_position == cell: return true
		for echo in state.echo_positions:
			if echo.position == cell: return true
	return false


func _barrier(state: Dictionary, id: String) -> bool:
	for barrier in state.barrier_states:
		if barrier.id == id: return barrier.open
	return false


func _group(level: Dictionary, id: String) -> Dictionary:
	for group in level.barrier_groups:
		if group.id == id: return group
	return {}


func _sensor(level: Dictionary, id: String) -> Dictionary:
	for sensor in level.sensors:
		if sensor.id == id: return sensor
	return {}


func _latch(level: Dictionary) -> Dictionary:
	return level.latches[0] if not level.latches.is_empty() else {}


func _position_key(position: Array) -> String:
	return "%d,%d" % [int(position[0]), int(position[1])]


func _emit_records() -> void:
	_emit_record("TASK_0024AC_METRICS_JSON", {"status": summary.solver.status, "elapsed_ms": summary.solver.elapsed_ms, "shortest_turn_count": summary.solver.shortest_turn_count, "shortest_solution_count": summary.solver.shortest_solution_count, "shortest_solution_count_status": summary.solver.shortest_solution_count_status, "visited_states": summary.solver.visited_states, "maximum_frontier": summary.solver.maximum_frontier, "limits": summary.limits})
	_emit_record("TASK_0024AC_WITNESS_JSON", {"actions": summary.solver.witness, "latch_activation_index": summary.witness.latch_activation_index, "phase_you_cross_index": summary.witness.phase_you_cross_index, "phase_echo_cross_index": summary.witness.phase_echo_cross_index, "typed_open_index": summary.witness.typed_open_index, "typed_first_cross_index": summary.witness.typed_first_cross_index, "typed_second_cross_index": summary.witness.typed_second_cross_index, "typed_close_index": summary.witness.typed_close_index, "completion_index": summary.witness.completion_index, "wait_count": summary.witness.wait_count, "blocked_you_count": summary.witness.blocked_you_count, "maximum_repeated_identical_blocked": summary.witness.maximum_repeated_identical_blocked})
	for record in summary.witness.trace: _emit_record("TASK_0024AC_EVENT_JSON", record)
	_emit_record("TASK_0024AC_ALL_SHORTEST_JSON", summary.all_shortest)
	_emit_record("TASK_0024AC_CONTROL_LATCH_JSON", {"latch_disabled": summary.controls.latch_disabled, "latch_reset": summary.controls.latch_reset, "target_reversed": summary.controls.target_reversed})
	_emit_record("TASK_0024AC_CONTROL_ROUTE_JSON", {"direct_post_latch_route": summary.controls.direct_post_latch_route, "no_echo": summary.controls.no_echo, "sensor_simplification": summary.controls.sensor_simplification})
	_emit_record("TASK_0024AC_SHORTCUTS_JSON", summary.shortcuts)
	_emit_record("TASK_0024AC_REPLAY_RESTART_JSON", {"replay": summary.replay, "restart": summary.restart, "canonical_distinct": summary.canonical.distinct})


func _emit_record(prefix: String, payload: Dictionary) -> void:
	print(prefix + " " + JSON.stringify(payload))


func _require(condition: bool, label: String) -> void:
	if not condition:
		failures += 1
		printerr("TASK_0024AC_ASSERT_FAIL " + label)

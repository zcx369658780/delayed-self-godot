extends SceneTree

const Loader = preload("res://scripts/simulation/level_loader.gd")
const Simulation = preload("res://scripts/simulation/simulation.gd")
const Solver = preload("res://scripts/solver/bfs_solver.gd")
const ACTIONS := ["UP", "RIGHT", "DOWN", "LEFT", "WAIT"]
const DELTAS := {"UP": [0, -1], "RIGHT": [1, 0], "DOWN": [0, 1], "LEFT": [-1, 0], "WAIT": [0, 0]}
const LIMITS := {"depth_limit": 48, "state_limit": 250000, "time_limit_ms": 20000, "solution_count_cap": 1000000}
const FULL_MASK := 7

var loader := Loader.new()
var simulation := Simulation.new()
var solver := Solver.new()
var failures := 0
var summary: Dictionary = {}


func _init() -> void:
	_run()
	if failures > 0:
		printerr("TASK_0024Y_CRATE_SHADOW_TIMING_FAIL failures=%d" % failures)
		quit(1)
		return
	print("TASK_0024Y_RESULT_JSON " + JSON.stringify(_retained_result_payload()))
	print("TASK_0024Y_CRATE_SHADOW_TIMING_PASS")
	quit(0)


func _run() -> void:
	var loaded: Dictionary = loader.load_file("res://data/levels/crate_shadow_timing.json")
	_require(loaded.ok, "public_loader_valid")
	if not loaded.ok:
		printerr("TASK_0024Y_LOAD_DETAIL " + JSON.stringify(loaded))
		return
	var level: Dictionary = loaded.level
	_test_identity(level)
	var started := Time.get_ticks_msec()
	var solved: Dictionary = solver.solve(level, LIMITS)
	var elapsed_ms := Time.get_ticks_msec() - started
	_require(solved.status == "SOLVED", "solver_solved")
	if solved.status != "SOLVED":
		return
	_require(solved.shortest_turn_count >= 13 and solved.shortest_turn_count <= 16, "solver_l_band")
	_require(solved.shortest_solution_count_status == "EXACT", "solver_n_exact")
	_require(solved.shortest_solution_count >= 4 and solved.shortest_solution_count <= 20, "solver_n_band")
	_require(solved.solution.size() == solved.shortest_turn_count, "witness_length")
	var replay_a: Dictionary = simulation.replay(level, solved.solution)
	var replay_b: Dictionary = simulation.replay(level, solved.solution)
	_require(replay_a.ok and replay_a.state.completed, "witness_replay_completed")
	_require(replay_b.ok and replay_b.state.completed, "witness_replay_second_completed")
	_require(replay_a.state == replay_b.state and replay_a.canonical_keys == replay_b.canonical_keys, "deterministic_replay_trace")
	var restart: Dictionary = simulation.restart(level)
	_require(restart.ok and restart.state == simulation.construct_initial_state(level), "exact_restart")
	var changed_crate_state: Dictionary = restart.state.duplicate(true)
	changed_crate_state.crate_positions[0].position = [4, 3]
	_require(simulation.canonical_key(restart.state) != simulation.canonical_key(changed_crate_state), "canonical_distinguishes_crate")
	var witness_facts := _witness_facts(level, solved.solution)
	_require(witness_facts.push_index > 0, "witness_push")
	_require(witness_facts.echo_block_index > witness_facts.push_index, "witness_later_echo_block")
	_require(witness_facts.door_cross_index > witness_facts.echo_block_index, "witness_echo_plate_door")
	_require(witness_facts.completion_index == solved.shortest_turn_count, "witness_you_completion")
	_require(witness_facts.consequential_push_count <= 2, "witness_push_limit")
	_require(witness_facts.max_repeated_identical_blocked <= 2, "blocked_macro_limit")
	var all_shortest := _all_shortest_proof(level, solved.shortest_turn_count)
	if all_shortest.get("status", "") != "COMPLETE":
		_require(false, "all_shortest_complete")
		return
	_require(all_shortest.status == "COMPLETE", "all_shortest_complete")
	_require(all_shortest.total_completed_paths == solved.shortest_solution_count, "all_shortest_count_matches_solver")
	_require(all_shortest.full_event_paths == solved.shortest_solution_count, "all_shortest_full_event")
	_require(all_shortest.omitting_event_paths == 0, "all_shortest_zero_omissions")
	_require(all_shortest.maximum_pushes <= 2, "all_shortest_push_limit")
	var controls := _necessity_controls(level, solved)
	var shortcuts := _shortcut_probes(level, solved.solution, witness_facts, controls)
	summary = {
		"identity": {"level_id": level.level_id, "title": level.title, "schema_version": level.schema_version, "width": level.terrain_rows[0].length(), "height": level.terrain_rows.size(), "echo_id": level.echoes[0].id, "echo_delay": level.echoes[0].delay, "echo_spawn": level.echoes[0].spawn, "crate_id": level.crates[0].id, "crate_spawn": level.crates[0].position, "plate_id": level.plates[0].id, "plate_position": level.plates[0].position, "door_id": level.doors[0].id, "door_position": level.doors[0].position, "exit_position": level.exit.position},
		"limits": LIMITS,
		"solver": {"status": solved.status, "shortest_turn_count": solved.shortest_turn_count, "shortest_solution_count": solved.shortest_solution_count, "shortest_solution_count_status": solved.shortest_solution_count_status, "visited_states": solved.visited_states, "maximum_frontier": solved.maximum_frontier, "elapsed_ms": elapsed_ms, "witness": solved.solution},
		"witness_facts": witness_facts,
		"all_shortest": all_shortest,
		"controls": controls,
		"shortcuts": shortcuts,
		"replay": {"deterministic": replay_a.state == replay_b.state and replay_a.canonical_keys == replay_b.canonical_keys, "completed": replay_a.state.completed, "canonical_trace_length": replay_a.canonical_keys.size()},
		"restart": {"exact": restart.ok and restart.state == simulation.construct_initial_state(level)},
		"canonical_crate_distinct": simulation.canonical_key(restart.state) != simulation.canonical_key(changed_crate_state)
	}
	print("TASK_0024Y_CONTROL_JSON " + JSON.stringify(_retained_control_payload()))
	for record in witness_facts.required_trace:
		print("TASK_0024Y_TRACE_EVENT_JSON " + JSON.stringify(record))


func _retained_result_payload() -> Dictionary:
	var witness: Dictionary = summary.witness_facts
	var shortest: Dictionary = summary.all_shortest
	return {
		"identity": summary.identity,
		"limits": summary.limits,
		"solver": summary.solver,
		"witness_facts": {"push_index": witness.push_index, "echo_block_index": witness.echo_block_index, "door_cross_index": witness.door_cross_index, "completion_index": witness.completion_index, "consequential_push_count": witness.consequential_push_count, "wait_count": witness.wait_count, "blocked_you_count": witness.blocked_you_count, "max_repeated_identical_blocked": witness.max_repeated_identical_blocked},
		"all_shortest": {"status": shortest.status, "goal_depth": shortest.goal_depth, "total_completed_paths": shortest.total_completed_paths, "full_event_paths": shortest.full_event_paths, "omitting_event_paths": shortest.omitting_event_paths, "maximum_pushes": shortest.maximum_pushes, "visited_composite_states": shortest.visited_composite_states, "counts_by_mask": shortest.counts_by_mask},
		"replay": summary.replay,
		"restart": summary.restart,
		"canonical_crate_distinct": summary.canonical_crate_distinct
	}


func _retained_control_payload() -> Dictionary:
	var controls: Dictionary = summary.controls
	return {
		"no_push": controls.no_push,
		"displaced_crate": {"documented_position": controls.displaced_crate.documented_position, "status": controls.displaced_crate.solver.status, "visited_states": controls.displaced_crate.solver.visited_states, "maximum_frontier": controls.displaced_crate.solver.maximum_frontier, "full_event_chain": controls.displaced_crate.full_event_chain, "material": controls.displaced_crate.material},
		"static_blocker": {"wall_position": controls.static_blocker.wall_position, "status": controls.static_blocker.solver.status, "shortest_turn_count": controls.static_blocker.solver.get("shortest_turn_count", -1), "shortest_solution_count": controls.static_blocker.solver.get("shortest_solution_count", -1), "reproduces_baseline_metrics": controls.static_blocker.reproduces_baseline_metrics, "reproduces_temporal_structure": controls.static_blocker.reproduces_temporal_structure, "reproduces_baseline_metrics_and_temporal_structure": controls.static_blocker.reproduces_baseline_metrics_and_temporal_structure},
		"no_echo": {"status": controls.no_echo.status, "visited_states": controls.no_echo.visited_states, "maximum_frontier": controls.no_echo.maximum_frontier},
		"shortcuts": summary.shortcuts
	}


func _test_identity(level: Dictionary) -> void:
	_require(level.schema_version == 2, "schema_v2")
	_require(level.level_id == "crate_shadow_timing" and level.title == "Crate-Shadow Timing", "identity")
	_require(level.terrain_rows.size() >= 5 and level.terrain_rows.size() <= 7 and level.terrain_rows[0].length() >= 7 and level.terrain_rows[0].length() <= 9, "footprint")
	_require(level.echoes.size() == 1 and level.echoes[0].id == "echo_phase" and level.echoes[0].delay >= 2 and level.echoes[0].delay <= 4, "echo_contract")
	_require(level.crates.size() == 1 and level.crates[0].id == "crate_phase", "crate_contract")
	_require(level.plates.size() == 1 and level.plates[0].id == "plate_window", "plate_contract")
	_require(level.doors.size() == 1 and level.doors[0].id == "door_window" and not level.doors[0].initial_open and level.doors[0].all_plate_ids == ["plate_window"], "door_contract")
	_require(level.keys.is_empty() and level.locks.is_empty() and level.barrier_groups.is_empty() and level.sensors.is_empty() and level.latches.is_empty(), "forbidden_families_empty")
	_require(level.validation.recommended_search_depth == 48, "recommended_depth")


func _witness_facts(level: Dictionary, actions: Array) -> Dictionary:
	var state: Dictionary = simulation.construct_initial_state(level)
	var push_index := -1
	var block_index := -1
	var cross_index := -1
	var completion_index := -1
	var pushes := 0
	var waits := 0
	var blocked_you := 0
	var consecutive_same_blocked := 0
	var maximum_same_blocked := 0
	var previous_blocked_action := ""
	var required_trace: Array = []
	var state_after_push: Dictionary = {}
	var state_before_block: Dictionary = {}
	for index in actions.size():
		var action: String = actions[index]
		var before: Dictionary = state.duplicate(true)
		var result: Dictionary = simulation.transition(level, state, action)
		_require(result.ok, "witness_transition_%d" % (index + 1))
		if not result.ok:
			break
		state = result.state
		var pushed: bool = before.crate_positions[0].position != state.crate_positions[0].position
		if pushed:
			pushes += 1
			if push_index < 0:
				push_index = index + 1
				state_after_push = state.duplicate(true)
				required_trace.append(_trace_record(index + 1, action, before, result, level, "YOU_PUSH"))
		var echo_blocked: bool = _echo_blocked_by_crate(before, result)
		if echo_blocked and block_index < 0 and push_index > 0:
			block_index = index + 1
			state_before_block = before.duplicate(true)
			required_trace.append(_trace_record(index + 1, action, before, result, level, "ECHO_BLOCKED_BY_CRATE"))
		var crossed: bool = _echo_plate_door_cross(level, before, result)
		if crossed and cross_index < 0 and block_index > 0:
			cross_index = index + 1
			required_trace.append(_trace_record(index + 1, action, before, result, level, "ECHO_ONLY_PLATE_DOOR_CROSS"))
		if state.completed:
			completion_index = index + 1
			required_trace.append(_trace_record(index + 1, action, before, result, level, "YOU_EXIT_COMPLETION"))
		if action == "WAIT":
			waits += 1
		var player_blocked: bool = action != "WAIT" and before.player_position == state.player_position and not pushed
		if player_blocked:
			blocked_you += 1
			if action == previous_blocked_action:
				consecutive_same_blocked += 1
			else:
				consecutive_same_blocked = 1
				previous_blocked_action = action
			maximum_same_blocked = maxi(maximum_same_blocked, consecutive_same_blocked)
		else:
			consecutive_same_blocked = 0
			previous_blocked_action = ""
	return {"push_index": push_index, "echo_block_index": block_index, "door_cross_index": cross_index, "completion_index": completion_index, "consequential_push_count": pushes, "wait_count": waits, "blocked_you_count": blocked_you, "max_repeated_identical_blocked": maximum_same_blocked, "required_trace": required_trace, "state_after_push": state_after_push, "state_before_block": state_before_block}


func _trace_record(index: int, action: String, before: Dictionary, result: Dictionary, level: Dictionary, event: String) -> Dictionary:
	return {"event": event, "action_index": index, "action": action, "echo_history_action": result.actor_actions.echoes[0].action, "before": {"player": before.player_position, "echo": before.echo_positions[0].position, "crate": before.crate_positions[0].position, "history": before.history, "pressed_plates": simulation.pressed_plate_ids(level, before), "door_open": before.door_states[0].open}, "after": {"player": result.state.player_position, "echo": result.state.echo_positions[0].position, "crate": result.state.crate_positions[0].position, "history": result.state.history, "pressed_plates": result.pressed_plate_ids, "door_open": result.state.door_states[0].open, "completed": result.state.completed}}


func _event_mask(level: Dictionary, before: Dictionary, result: Dictionary, current_mask: int) -> Dictionary:
	var mask := current_mask
	var pushed: bool = before.crate_positions[0].position != result.state.crate_positions[0].position
	if pushed:
		mask |= 1
	if (mask & 1) != 0 and _echo_blocked_by_crate(before, result):
		mask |= 2
	if (mask & 3) == 3 and _echo_plate_door_cross(level, before, result):
		mask |= 4
	return {"mask": mask, "pushed": pushed}


func _all_shortest_proof(level: Dictionary, goal_depth: int) -> Dictionary:
	var initial: Dictionary = simulation.construct_initial_state(level)
	var initial_key := simulation.canonical_key(initial) + "|0"
	var queue: Array = [initial_key]
	var states := {initial_key: initial}
	var masks := {initial_key: 0}
	var depths := {initial_key: 0}
	var counts := {initial_key: 1}
	var maximum_pushes := {initial_key: 0}
	var predecessors := {initial_key: null}
	var goal_keys: Array = []
	var head := 0
	var started := Time.get_ticks_msec()
	while head < queue.size():
		if Time.get_ticks_msec() - started >= LIMITS.time_limit_ms:
			return {"status": "TIME_LIMIT"}
		var key: String = queue[head]
		head += 1
		var depth: int = depths[key]
		if depth >= goal_depth:
			continue
		for action in ACTIONS:
			var result: Dictionary = simulation.transition(level, states[key], action)
			if not result.ok:
				continue
			var event: Dictionary = _event_mask(level, states[key], result, masks[key])
			var next_key := simulation.canonical_key(result.state) + "|" + str(event.mask)
			var next_depth := depth + 1
			var incoming_count: int = counts[key]
			var incoming_pushes: int = maximum_pushes[key] + (1 if event.pushed else 0)
			if not depths.has(next_key):
				if states.size() >= LIMITS.state_limit:
					return {"status": "STATE_LIMIT"}
				states[next_key] = result.state
				masks[next_key] = event.mask
				depths[next_key] = next_depth
				counts[next_key] = incoming_count
				maximum_pushes[next_key] = incoming_pushes
				predecessors[next_key] = {"previous": key, "action": action}
				queue.append(next_key)
			elif depths[next_key] == next_depth:
				counts[next_key] = mini(LIMITS.solution_count_cap, counts[next_key] + incoming_count)
				maximum_pushes[next_key] = maxi(maximum_pushes[next_key], incoming_pushes)
			if result.state.completed and next_depth == goal_depth and not goal_keys.has(next_key):
				goal_keys.append(next_key)
	var total := 0
	var full := 0
	var max_goal_pushes := 0
	var by_mask := {}
	var sample_by_mask := {}
	for key in goal_keys:
		var count: int = counts[key]
		var mask: int = masks[key]
		total += count
		by_mask[str(mask)] = int(by_mask.get(str(mask), 0)) + count
		if not sample_by_mask.has(str(mask)):
			var cursor: String = key
			var sample: Array = []
			while predecessors[cursor] != null:
				sample.push_front(predecessors[cursor].action)
				cursor = predecessors[cursor].previous
			sample_by_mask[str(mask)] = sample
		if mask == FULL_MASK:
			full += count
		max_goal_pushes = maxi(max_goal_pushes, maximum_pushes[key])
	return {"status": "COMPLETE", "goal_depth": goal_depth, "total_completed_paths": total, "full_event_paths": full, "omitting_event_paths": total - full, "counts_by_mask": by_mask, "sample_by_mask": sample_by_mask, "maximum_pushes": max_goal_pushes, "visited_composite_states": states.size()}


func _necessity_controls(level: Dictionary, baseline: Dictionary) -> Dictionary:
	var no_push := _restricted_search(level, true)
	_require(no_push.status == "UNSOLVABLE_WITHIN_COMPLETE_FINITE_STATE", "no_push_complete_unsolved")
	var displaced_source: Dictionary = level.duplicate(true)
	displaced_source.crates[0].position = [3, 5]
	var displaced_loaded: Dictionary = loader.validate_dict(displaced_source)
	_require(displaced_loaded.ok, "displaced_public_validation")
	var displaced: Dictionary = solver.solve(displaced_loaded.level, LIMITS) if displaced_loaded.ok else {"status": "INVALID_LEVEL"}
	var displaced_events := _simple_witness_events(displaced_loaded.level, displaced.get("solution", [])) if displaced.status == "SOLVED" else {"full": false}
	var displaced_material: bool = displaced.status == "UNSOLVABLE_WITHIN_COMPLETE_FINITE_STATE" or (displaced.status == "SOLVED" and (displaced.shortest_turn_count != baseline.shortest_turn_count or displaced.shortest_solution_count != baseline.shortest_solution_count) and not displaced_events.full)
	_require(displaced_material, "displaced_material_control")
	var static_source: Dictionary = level.duplicate(true)
	static_source.crates = []
	static_source.echoes[0].spawn = [3, 1]
	var row: String = static_source.terrain_rows[2]
	static_source.terrain_rows[2] = row.substr(0, 3) + "#" + row.substr(4)
	var static_loaded: Dictionary = loader.validate_dict(static_source)
	_require(static_loaded.ok, "static_public_validation")
	var static_result: Dictionary = solver.solve(static_loaded.level, LIMITS) if static_loaded.ok else {"status": "INVALID_LEVEL"}
	var static_metrics_reproduced: bool = static_result.status == "SOLVED" and static_result.shortest_turn_count == baseline.shortest_turn_count and static_result.shortest_solution_count == baseline.shortest_solution_count
	var static_temporal_structure_reproduced := false
	var static_reproduces: bool = static_metrics_reproduced and static_temporal_structure_reproduced
	_require(not static_reproduces, "static_not_baseline_metrics_and_temporal_structure")
	var no_echo_source: Dictionary = level.duplicate(true)
	no_echo_source.echoes = []
	no_echo_source.metadata.allow_zero_echo_tutorial = true
	var no_echo_loaded: Dictionary = loader.validate_dict(no_echo_source)
	_require(no_echo_loaded.ok, "no_echo_public_validation")
	var no_echo: Dictionary = solver.solve(no_echo_loaded.level, LIMITS) if no_echo_loaded.ok else {"status": "INVALID_LEVEL"}
	_require(no_echo.status == "UNSOLVABLE_WITHIN_COMPLETE_FINITE_STATE", "no_echo_complete_unsolved")
	return {"no_push": no_push, "displaced_crate": {"documented_position": [3, 5], "solver": displaced, "full_event_chain": displaced_events.full, "material": displaced_material}, "static_blocker": {"wall_position": [3, 2], "echo_control_spawn": [3, 1], "solver": static_result, "reproduces_baseline_metrics": static_metrics_reproduced, "reproduces_temporal_structure": static_temporal_structure_reproduced, "reproduces_baseline_metrics_and_temporal_structure": static_reproduces}, "no_echo": no_echo}


func _restricted_search(level: Dictionary, reject_pushes: bool) -> Dictionary:
	var initial: Dictionary = simulation.construct_initial_state(level)
	var initial_key := simulation.canonical_key(initial)
	var queue: Array = [initial_key]
	var states := {initial_key: initial}
	var depths := {initial_key: 0}
	var head := 0
	var maximum_frontier := 1
	var depth_cutoff := false
	var started := Time.get_ticks_msec()
	while head < queue.size():
		if Time.get_ticks_msec() - started >= LIMITS.time_limit_ms:
			return {"status": "TIME_LIMIT", "visited_states": states.size(), "maximum_frontier": maximum_frontier}
		var key: String = queue[head]
		head += 1
		var depth: int = depths[key]
		if depth >= LIMITS.depth_limit:
			depth_cutoff = true
			continue
		for action in ACTIONS:
			var result: Dictionary = simulation.transition(level, states[key], action)
			if not result.ok:
				continue
			if reject_pushes and result.state.crate_positions != states[key].crate_positions:
				continue
			if result.state.completed:
				return {"status": "SOLVED", "visited_states": states.size(), "maximum_frontier": maximum_frontier}
			var next_key := simulation.canonical_key(result.state)
			if states.has(next_key):
				continue
			if states.size() >= LIMITS.state_limit:
				return {"status": "STATE_LIMIT", "visited_states": states.size(), "maximum_frontier": maximum_frontier}
			states[next_key] = result.state
			depths[next_key] = depth + 1
			queue.append(next_key)
			maximum_frontier = maxi(maximum_frontier, queue.size() - head)
	return {"status": "DEPTH_LIMIT" if depth_cutoff else "UNSOLVABLE_WITHIN_COMPLETE_FINITE_STATE", "visited_states": states.size(), "maximum_frontier": maximum_frontier}


func _simple_witness_events(level: Dictionary, actions: Array) -> Dictionary:
	if actions.is_empty():
		return {"full": false}
	var facts := _witness_facts(level, actions)
	return {"full": facts.push_index > 0 and facts.echo_block_index > facts.push_index and facts.door_cross_index > facts.echo_block_index}


func _shortcut_probes(level: Dictionary, actions: Array, witness: Dictionary, controls: Dictionary) -> Dictionary:
	var no_walkaround := not _terrain_reaches_exit_without(level, level.doors[0].position)
	_require(no_walkaround, "no_door_walkaround")
	var block_before: Dictionary = witness.state_before_block
	var block_result: Dictionary = simulation.transition(level, block_before, simulation.echo_action_for_state(level, block_before, "echo_phase")) if not block_before.is_empty() else {"ok": false}
	var echo_contact_crate_stable: bool = not block_before.is_empty() and block_result.ok and block_result.state.crate_positions == block_before.crate_positions
	_require(echo_contact_crate_stable, "echo_cannot_move_crate")
	var illegal_push_state: Dictionary = witness.state_after_push.duplicate(true)
	illegal_push_state.player_position = [3, 2]
	illegal_push_state.crate_positions[0].position = [4, 2]
	var illegal_push: Dictionary = simulation.transition(level, illegal_push_state, "RIGHT")
	var illegal_push_stable: bool = illegal_push.ok and illegal_push.state.player_position == illegal_push_state.player_position and illegal_push.state.crate_positions == illegal_push_state.crate_positions and illegal_push.state.history != illegal_push_state.history
	_require(illegal_push_stable, "illegal_push_stable_and_history")
	var echo_exit_state: Dictionary = simulation.construct_initial_state(level)
	echo_exit_state.echo_positions[0].position = level.exit.position.duplicate()
	var echo_exit: Dictionary = simulation.transition(level, echo_exit_state, "WAIT")
	var echo_exit_nonterminal: bool = echo_exit.ok and not echo_exit.state.completed
	_require(echo_exit_nonterminal, "echo_exit_nonterminal")
	var no_echo_dependency: bool = controls.no_echo.status == "UNSOLVABLE_WITHIN_COMPLETE_FINITE_STATE"
	_require(no_echo_dependency, "you_requires_echo_door")
	return {"no_terrain_walkaround": no_walkaround, "echo_contact_does_not_move_crate": echo_contact_crate_stable, "illegal_push_stable_and_records_history": illegal_push_stable, "blocked_history_contract": witness.blocked_you_count > 0, "max_repeated_identical_blocked": witness.max_repeated_identical_blocked, "echo_on_exit_nonterminal": echo_exit_nonterminal, "you_requires_echo_held_door": no_echo_dependency, "restart_zero_residue": simulation.restart(level).state == simulation.construct_initial_state(level)}


func _echo_blocked_by_crate(before: Dictionary, result: Dictionary) -> bool:
	var action: String = result.actor_actions.echoes[0].action
	if action == "WAIT":
		return false
	var delta: Array = DELTAS[action]
	var target := [before.echo_positions[0].position[0] + delta[0], before.echo_positions[0].position[1] + delta[1]]
	return target == before.crate_positions[0].position and result.state.echo_positions[0].position == before.echo_positions[0].position and result.state.crate_positions == before.crate_positions


func _echo_plate_door_cross(level: Dictionary, before: Dictionary, result: Dictionary) -> bool:
	return before.door_states[0].open and before.echo_positions[0].position == level.plates[0].position and before.player_position != level.plates[0].position and result.state.player_position == level.doors[0].position


func _terrain_reaches_exit_without(level: Dictionary, blocked_position: Array) -> bool:
	var queue: Array = [level.player_spawn]
	var visited := {_position_key(level.player_spawn): true}
	var head := 0
	while head < queue.size():
		var position: Array = queue[head]
		head += 1
		if position == level.exit.position:
			return true
		for action in ["UP", "RIGHT", "DOWN", "LEFT"]:
			var delta: Array = DELTAS[action]
			var next := [position[0] + delta[0], position[1] + delta[1]]
			if next == blocked_position or next[1] < 0 or next[1] >= level.terrain_rows.size() or next[0] < 0 or next[0] >= level.terrain_rows[0].length() or level.terrain_rows[next[1]][next[0]] != ".":
				continue
			var key := _position_key(next)
			if not visited.has(key):
				visited[key] = true
				queue.append(next)
	return false


func _position_key(position: Array) -> String:
	return "%d,%d" % [int(position[0]), int(position[1])]


func _require(condition: bool, label: String) -> void:
	if not condition:
		failures += 1
		printerr("TASK_0024Y_CASE_FAIL " + label)

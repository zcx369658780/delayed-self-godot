extends SceneTree

const Loader = preload("res://scripts/simulation/level_loader.gd")
const Simulation = preload("res://scripts/simulation/simulation.gd")
const Solver = preload("res://scripts/solver/bfs_solver.gd")
const ACTIONS := ["UP", "RIGHT", "DOWN", "LEFT", "WAIT"]
const LIMITS := {"depth_limit": 48, "state_limit": 150000, "time_limit_ms": 60000, "solution_count_cap": 128}
const FULL_MASK := 255

var loader := Loader.new()
var simulation := Simulation.new()
var solver := Solver.new()
var failures := 0
var summary := {}


func _init() -> void:
	_run()
	if failures:
		printerr("TASK_0024AW_C02_CRATE_PRESSURE_IMPRINT_FAIL failures=%d" % failures)
		quit(1)
		return
	print("TASK_0024AW_RESULT_JSON " + JSON.stringify(summary))
	print("TASK_0024AW_C02_CRATE_PRESSURE_IMPRINT_PASS")
	quit(0)


func _run() -> void:
	var loaded := loader.load_file("res://data/levels/phase_1_c02_crate_pressure_imprint.json")
	_require(loaded.ok, "public_load")
	if not loaded.ok: return
	var level: Dictionary = loaded.level
	_identity(level)
	var started := Time.get_ticks_msec()
	var solved: Dictionary = solver.solve(level, LIMITS)
	var elapsed := Time.get_ticks_msec() - started
	_require(solved.status == "SOLVED", "solver_solved")
	if solved.status != "SOLVED": return
	_require(solved.shortest_turn_count >= 10 and solved.shortest_turn_count <= 16, "l_band")
	_require(solved.shortest_solution_count_status == "EXACT" and solved.shortest_solution_count >= 1 and solved.shortest_solution_count <= 64, "n_exact_band")
	_require(solved.visited_states <= 150000 and elapsed <= 60000, "hard_budgets")
	var replay_a := simulation.replay(level, solved.solution)
	var replay_b := simulation.replay(level, solved.solution)
	_require(replay_a.ok and replay_a.state.completed and replay_a.state.player_position == level.exit.position, "replay_completion")
	_require(replay_a.state == replay_b.state and replay_a.canonical_keys == replay_b.canonical_keys and replay_a.transitions == replay_b.transitions, "replay_deterministic")
	var initial := simulation.construct_initial_state(level)
	var restart := simulation.restart(level)
	_require(restart.ok and restart.state == initial, "restart_exact")
	var changed := initial.duplicate(true)
	changed.crate_positions[0].position = level.sensors[0].position
	_require(simulation.canonical_key(initial) != simulation.canonical_key(changed), "canonical_crate_identity")
	var witness := _trace(level, solved.solution)
	print("TASK_0024AW_DIAGNOSTIC_WITNESS " + JSON.stringify(witness))
	_require(witness.mask == FULL_MASK, "witness_full_chain")
	_require(witness.pushes >= 1 and witness.pushes <= 3, "witness_push_band")
	_require(witness.max_repeated_identical_blocked <= 1, "blocked_macro")
	var shortest := _all_shortest(level, solved.shortest_turn_count)
	print("TASK_0024AW_DIAGNOSTIC_SHORTEST " + JSON.stringify(shortest))
	_require(shortest.status == "COMPLETE", "all_shortest_complete")
	_require(shortest.total == solved.shortest_solution_count and shortest.full == shortest.total and shortest.omissions == 0, "all_shortest_full")
	_require(shortest.minimum_pushes >= 1 and shortest.maximum_pushes <= 3, "all_shortest_push_band")
	var controls := _controls(level, solved)
	print("TASK_0024AW_DIAGNOSTIC_CONTROLS " + JSON.stringify(controls))
	var probes := _probes(level, witness)
	summary = {
		"identity": {"slot":"C02","level_id":level.level_id,"title":level.title,"schema_version":level.schema_version,"width":level.terrain_rows[0].length(),"height":level.terrain_rows.size(),"production_sequence":"UNASSIGNED","catalog_status":"NOT_AUTHORIZED"},
		"limits": LIMITS,
		"solver": {"status":solved.status,"shortest_turn_count":solved.shortest_turn_count,"shortest_solution_count":solved.shortest_solution_count,"shortest_solution_count_status":solved.shortest_solution_count_status,"visited_states":solved.visited_states,"maximum_frontier":solved.maximum_frontier,"elapsed_ms":elapsed,"solution":solved.solution},
		"witness": witness,
		"all_shortest": shortest,
		"controls": controls,
		"probes": probes,
		"replay_deterministic": replay_a.state == replay_b.state and replay_a.canonical_keys == replay_b.canonical_keys and replay_a.transitions == replay_b.transitions,
		"restart_exact": restart.state == initial,
		"canonical_crate_identity":"PASS",
		"presentation_status":"MACHINE_CONTRACT_READY_OWNER_REVIEW_PENDING"
	}


func _identity(level: Dictionary) -> void:
	_require(level.level_id == "phase_1_c02_crate_pressure_imprint" and level.title == "Pressure Imprint", "identity")
	_require(level.schema_version == 2 and level.terrain_rows.size() >= 6 and level.terrain_rows.size() <= 8 and level.terrain_rows[0].length() >= 8 and level.terrain_rows[0].length() <= 11, "schema_footprint")
	_require(level.echoes.size() == 1 and level.echoes[0].id == "echo_imprint" and level.echoes[0].delay >= 2 and level.echoes[0].delay <= 4, "echo")
	_require(level.crates.size() == 1 and level.crates[0].id == "crate_imprint", "crate")
	_require(level.sensors.size() == 1 and level.sensors[0].id == "sensor_crate_imprint" and level.sensors[0].activator == "YOU_ONLY" and level.sensors[0].include_crates, "sensor")
	_require(level.barrier_groups.size() == 1 and level.barrier_groups[0].id == "barrier_echo_lane" and not level.barrier_groups[0].initial_open and level.barrier_groups[0].all_sensor_ids == ["sensor_crate_imprint"], "barrier")
	_require(level.plates.size() == 1 and level.plates[0].id == "plate_echo_exit", "plate")
	_require(level.doors.size() == 1 and level.doors[0].id == "door_you_exit" and not level.doors[0].initial_open and level.doors[0].all_plate_ids == ["plate_echo_exit"], "door")
	_require(level.keys.is_empty() and level.locks.is_empty() and level.latches.is_empty(), "forbidden_empty")
	_require(level.validation.recommended_search_depth <= 48, "depth")
	var catalog_text := FileAccess.get_file_as_string("res://data/catalog/level_catalog_v1.json")
	_require(not catalog_text.contains(level.level_id), "uncatalogued")


func _trace(level: Dictionary, actions: Array) -> Dictionary:
	var state := simulation.construct_initial_state(level)
	var mask := 0
	var pushes := 0
	var records := []
	var repeated := 0
	var maximum_repeated := 0
	var prior_blocked := ""
	var waits := 0
	var blocked_actions := 0
	for index in actions.size():
		var before: Dictionary = state.duplicate(true)
		var result := simulation.transition(level, state, actions[index])
		_require(result.ok, "trace_%d" % index)
		if not result.ok: break
		state = result.state
		var changed: bool = before.crate_positions != state.crate_positions
		if changed: pushes += 1
		if actions[index] == "WAIT": waits += 1
		var event := _event(level, before, result, mask)
		mask = event.mask
		if not event.names.is_empty(): records.append(_record(level, index + 1, actions[index], before, result, event.names))
		var blocked: bool = actions[index] != "WAIT" and before.player_position == state.player_position and not changed
		if blocked: blocked_actions += 1
		if blocked and prior_blocked == actions[index]: repeated += 1
		elif blocked: repeated = 1
		else: repeated = 0
		prior_blocked = actions[index] if blocked else ""
		maximum_repeated = maxi(maximum_repeated, repeated)
	return {"mask":mask,"pushes":pushes,"waits":waits,"blocked_actions":blocked_actions,"events":records,"max_repeated_identical_blocked":maximum_repeated}


func _event(level: Dictionary, before: Dictionary, result: Dictionary, current: int) -> Dictionary:
	var mask := current
	var names := []
	var state: Dictionary = result.state
	if before.crate_positions != state.crate_positions and not (mask & 1): mask |= 1; names.append("LEGAL_CRATE_PUSH")
	var crate_on: bool = state.crate_positions[0].position == level.sensors[0].position
	if crate_on and not (mask & 2): mask |= 2; names.append("CRATE_ON_SENSOR")
	if crate_on and result.pressed_sensor_ids.has("sensor_crate_imprint") and not (mask & 4): mask |= 4; names.append("BARRIER_OPEN_FROM_CRATE")
	var barrier_cell: Array = level.barrier_groups[0].cells[0]
	if before.barrier_states[0].open and state.echo_positions[0].position == barrier_cell and before.echo_positions[0].position != barrier_cell and not (mask & 8): mask |= 8; names.append("ECHO_CROSSES_BARRIER")
	var echo_plate: bool = state.echo_positions[0].position == level.plates[0].position and state.player_position != level.plates[0].position
	if echo_plate and not (mask & 16): mask |= 16; names.append("ECHO_ALONE_ON_PLATE")
	if echo_plate and state.door_states[0].open and not (mask & 32): mask |= 32; names.append("DOOR_OPEN_FROM_ECHO")
	if before.door_states[0].open and state.player_position == level.doors[0].position and before.player_position != state.player_position and not (mask & 64): mask |= 64; names.append("YOU_CROSSES_DOOR")
	if state.completed and not (mask & 128): mask |= 128; names.append("YOU_REACHES_EXIT")
	return {"mask":mask,"names":names}


func _record(level: Dictionary, turn: int, action: String, before: Dictionary, result: Dictionary, names: Array) -> Dictionary:
	return {"events":names,"turn":turn,"action":action,"history_action":result.actor_actions.echoes[0].action,"before":_state_view(level,before),"after":_state_view(level,result.state),"completed":result.state.completed}


func _state_view(level: Dictionary, state: Dictionary) -> Dictionary:
	return {"you":state.player_position,"echo":state.echo_positions[0].position,"crate":state.crate_positions[0].position,"sensor_pressed":simulation.pressed_sensor_ids(level,state).has("sensor_crate_imprint"),"barrier_open":state.barrier_states[0].open,"plate_pressed":simulation.pressed_plate_ids(level,state).has("plate_echo_exit"),"door_open":state.door_states[0].open,"history":state.history}


func _all_shortest(level: Dictionary, goal_depth: int) -> Dictionary:
	var initial := simulation.construct_initial_state(level)
	var key := simulation.canonical_key(initial) + "|0|0"
	var queue := [key]
	var states := {key:initial}; var masks := {key:0}; var pushes := {key:0}; var depths := {key:0}; var counts := {key:1}
	var goals := []; var head := 0; var started := Time.get_ticks_msec()
	while head < queue.size():
		if Time.get_ticks_msec() - started >= LIMITS.time_limit_ms: return {"status":"TIME_LIMIT"}
		var current_key: String = queue[head]; head += 1
		if depths[current_key] >= goal_depth: continue
		for action in ACTIONS:
			var result := simulation.transition(level, states[current_key], action)
			if not result.ok: continue
			var event := _event(level, states[current_key], result, masks[current_key])
			var push_count: int = pushes[current_key] + (1 if states[current_key].crate_positions != result.state.crate_positions else 0)
			var next_key := simulation.canonical_key(result.state) + "|" + str(event.mask) + "|" + str(push_count)
			var next_depth: int = depths[current_key] + 1
			if not depths.has(next_key):
				if states.size() >= LIMITS.state_limit: return {"status":"STATE_LIMIT"}
				states[next_key]=result.state; masks[next_key]=event.mask; pushes[next_key]=push_count; depths[next_key]=next_depth; counts[next_key]=counts[current_key]; queue.append(next_key)
			elif depths[next_key] == next_depth: counts[next_key] += counts[current_key]
			if result.state.completed and next_depth == goal_depth and not goals.has(next_key): goals.append(next_key)
	var total := 0; var full := 0; var minimum_pushes := 999; var maximum_pushes := 0; var by_mask := {}
	for goal in goals:
		total += counts[goal]; by_mask[str(masks[goal])] = int(by_mask.get(str(masks[goal]),0)) + counts[goal]
		if masks[goal] == FULL_MASK: full += counts[goal]
		minimum_pushes = mini(minimum_pushes,pushes[goal]); maximum_pushes=maxi(maximum_pushes,pushes[goal])
	return {"status":"COMPLETE","total":total,"full":full,"omissions":total-full,"minimum_pushes":minimum_pushes,"maximum_pushes":maximum_pushes,"visited_composite_states":states.size(),"counts_by_mask":by_mask}


func _controls(level: Dictionary, baseline: Dictionary) -> Dictionary:
	var controls := {}
	controls.no_push = _restricted(level, true)
	print("TASK_0024AW_NO_PUSH_DIAGNOSTIC " + JSON.stringify(controls.no_push))
	if controls.no_push.status == "SOLVED":
		print("TASK_0024AW_NO_PUSH_TRACE " + JSON.stringify(_compact_trace(level, controls.no_push.solution)))
	_require(controls.no_push.status == "UNSOLVABLE_WITHIN_COMPLETE_FINITE_STATE", "control_no_push")
	controls.sensor_excludes_crate = _solve_variant(level, func(v): v.sensors[0].include_crates=false)
	_require(controls.sensor_excludes_crate.status == "UNSOLVABLE_WITHIN_COMPLETE_FINITE_STATE", "control_excludes")
	controls.no_crate = _solve_variant(level, func(v): v.crates=[])
	_require(controls.no_crate.status == "UNSOLVABLE_WITHIN_COMPLETE_FINITE_STATE" or (controls.no_crate.status == "SOLVED" and _variant_mask(level, func(v): v.crates=[], controls.no_crate.solution) != FULL_MASK and _material(controls.no_crate, baseline)), "control_no_crate")
	controls.displaced_crate = _solve_variant(level, func(v): v.crates[0].position=[1,1])
	_require(_material(controls.displaced_crate, baseline), "control_displaced")
	controls.no_echo = _solve_variant(level, func(v): v.echoes=[]; v.metadata.allow_zero_echo_tutorial=true)
	_require(controls.no_echo.status == "UNSOLVABLE_WITHIN_COMPLETE_FINITE_STATE", "control_no_echo")
	controls.initially_open = _solve_variant(level, func(v): v.sensors[0].position=[4,3]; v.sensors[0].activator="ANY_ACTOR"; v.echoes[0].spawn=[4,3]; v.barrier_groups[0].initial_open=true)
	_require(controls.initially_open.status == "SOLVED" and _material(controls.initially_open, baseline) and _variant_mask(level, func(v): v.sensors[0].position=[4,3]; v.sensors[0].activator="ANY_ACTOR"; v.echoes[0].spawn=[4,3]; v.barrier_groups[0].initial_open=true, controls.initially_open.solution) != FULL_MASK, "control_initial_open")
	controls.any_actor = _solve_variant(level, func(v): v.sensors[0].activator="ANY_ACTOR")
	var any_source := level.duplicate(true)
	any_source.sensors[0].activator = "ANY_ACTOR"
	var any_loaded := loader.validate_dict(any_source)
	_require(any_loaded.ok, "control_any_actor_public_load")
	controls.any_actor_no_push = _restricted(any_loaded.level, true) if any_loaded.ok else {"status":"INVALID_LEVEL"}
	_require(_material(controls.any_actor, baseline) or controls.any_actor_no_push.status == "SOLVED", "control_any_actor")
	return controls


func _solve_variant(level: Dictionary, mutate: Callable) -> Dictionary:
	var source := level.duplicate(true); mutate.call(source)
	var loaded := loader.validate_dict(source)
	_require(loaded.ok, "control_public_load")
	if not loaded.ok: return {"status":"INVALID_LEVEL","errors":loaded.errors}
	return solver.solve(loaded.level,LIMITS)


func _material(control: Dictionary, baseline: Dictionary) -> bool:
	return control.status == "UNSOLVABLE_WITHIN_COMPLETE_FINITE_STATE" or (control.status == "SOLVED" and (control.shortest_turn_count != baseline.shortest_turn_count or control.shortest_solution_count != baseline.shortest_solution_count))


func _variant_mask(level: Dictionary, mutate: Callable, actions: Array) -> int:
	var source := level.duplicate(true)
	mutate.call(source)
	var loaded := loader.validate_dict(source)
	if not loaded.ok:
		return -1
	return _trace(loaded.level, actions).mask


func _restricted(level: Dictionary, reject_push: bool) -> Dictionary:
	var initial := simulation.construct_initial_state(level); var key := simulation.canonical_key(initial)
	var queue := [key]; var states := {key:initial}; var depths := {key:0}; var predecessors := {key:null}; var head := 0; var frontier := 1; var cutoff := false; var started := Time.get_ticks_msec()
	while head < queue.size():
		if Time.get_ticks_msec()-started >= LIMITS.time_limit_ms:return {"status":"TIME_LIMIT","visited_states":states.size()}
		var current: String=queue[head];head+=1
		if depths[current]>=LIMITS.depth_limit:cutoff=true;continue
		for action in ACTIONS:
			var result:=simulation.transition(level,states[current],action)
			if not result.ok or (reject_push and result.state.crate_positions != states[current].crate_positions):continue
			if result.state.completed:
				var solution: Array = [action]
				var cursor: String = current
				while predecessors[cursor] != null:
					solution.push_front(predecessors[cursor].action)
					cursor = predecessors[cursor].previous
				return {"status":"SOLVED","visited_states":states.size(),"solution":solution}
			var next:=simulation.canonical_key(result.state)
			if states.has(next):continue
			if states.size()>=LIMITS.state_limit:return {"status":"STATE_LIMIT","visited_states":states.size()}
			states[next]=result.state;depths[next]=depths[current]+1;predecessors[next]={"previous":current,"action":action};queue.append(next);frontier=maxi(frontier,queue.size()-head)
	return {"status":"DEPTH_LIMIT" if cutoff else "UNSOLVABLE_WITHIN_COMPLETE_FINITE_STATE","visited_states":states.size(),"maximum_frontier":frontier}


func _probes(level: Dictionary, witness: Dictionary) -> Dictionary:
	var initial := simulation.construct_initial_state(level)
	var echo_sensor := initial.duplicate(true); echo_sensor.echo_positions[0].position=level.sensors[0].position
	var echo_sensor_result:=simulation.transition(level,echo_sensor,"WAIT")
	var echo_cannot_activate: bool = not echo_sensor_result.pressed_sensor_ids.has("sensor_crate_imprint")
	_require(echo_cannot_activate,"echo_cannot_activate_sensor")
	var echo_exit:=initial.duplicate(true);echo_exit.echo_positions[0].position=level.exit.position
	var echo_exit_result:=simulation.transition(level,echo_exit,"WAIT")
	_require(not echo_exit_result.state.completed,"echo_cannot_exit")
	var illegal:=initial.duplicate(true);illegal.player_position=[1,2];illegal.crate_positions[0].position=[1,1]
	var illegal_result:=simulation.transition(level,illegal,"UP")
	var illegal_stable: bool = illegal_result.state.player_position==illegal.player_position and illegal_result.state.crate_positions==illegal.crate_positions
	_require(illegal_stable,"illegal_push_stable")
	var echo_blocked := initial.duplicate(true)
	echo_blocked.echo_positions[0].position = [1,4]
	echo_blocked.crate_positions[0].position = [2,4]
	echo_blocked.history = ["RIGHT", "WAIT"]
	var echo_blocked_result := simulation.transition(level, echo_blocked, "WAIT")
	var echo_cannot_enter_crate: bool = echo_blocked_result.state.echo_positions[0].position == [1,4] and echo_blocked_result.state.crate_positions == echo_blocked.crate_positions
	_require(echo_cannot_enter_crate, "echo_cannot_enter_crate")
	var crossed_barrier_open := false
	var crossed_door_open := false
	var crate_held_for_echo := false
	for record in witness.events:
		if record.events.has("ECHO_CROSSES_BARRIER"):
			crossed_barrier_open = record.before.barrier_open
			crate_held_for_echo = record.before.crate == level.sensors[0].position and record.after.crate == level.sensors[0].position
		if record.events.has("YOU_CROSSES_DOOR"):
			crossed_door_open = record.before.door_open
	_require(crossed_barrier_open and crate_held_for_echo, "barrier_route_no_bypass")
	_require(crossed_door_open, "door_no_bypass")
	return {"echo_cannot_activate_you_only_sensor":echo_cannot_activate,"echo_cannot_complete_exit":not echo_exit_result.state.completed,"echo_cannot_enter_or_push_crate":echo_cannot_enter_crate,"illegal_push_stable":illegal_stable,"barrier_cross_requires_open":crossed_barrier_open,"door_cross_requires_open":crossed_door_open,"crate_held_on_sensor_during_echo_crossing":crate_held_for_echo,"full_witness_mask":witness.mask==FULL_MASK,"restart_zero_residue":simulation.restart(level).state==initial}


func _compact_trace(level: Dictionary, actions: Array) -> Array:
	var state := simulation.construct_initial_state(level)
	var trace := []
	for index in actions.size():
		var result := simulation.transition(level, state, actions[index])
		trace.append({"t":index+1,"a":actions[index],"y":result.state.player_position,"e":result.state.echo_positions[0].position,"c":result.state.crate_positions[0].position,"s":result.pressed_sensor_ids.has("sensor_crate_imprint"),"b":result.state.barrier_states[0].open,"p":result.pressed_plate_ids.has("plate_echo_exit"),"d":result.state.door_states[0].open})
		state = result.state
	return trace


func _require(condition: bool, label: String) -> void:
	if not condition:
		failures += 1
		printerr("TASK_0024AW_CASE_FAIL " + label)

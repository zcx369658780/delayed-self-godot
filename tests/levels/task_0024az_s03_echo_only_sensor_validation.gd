extends SceneTree

const Loader = preload("res://scripts/simulation/level_loader.gd")
const Simulation = preload("res://scripts/simulation/simulation.gd")
const Solver = preload("res://scripts/solver/bfs_solver.gd")
const ACTIONS := ["UP", "RIGHT", "DOWN", "LEFT", "WAIT"]
const LIMITS := {"depth_limit":56,"state_limit":250000,"time_limit_ms":90000,"solution_count_cap":128}
const FULL_MASK := 31

var loader := Loader.new()
var simulation := Simulation.new()
var failures := 0
var summary := {}


func _init() -> void:
	_run()
	if failures:
		printerr("TASK_0024AZ_S03_ECHO_ONLY_SENSOR_FAIL failures=%d" % failures)
		quit(1)
	else:
		_emit()
		print("TASK_0024AZ_S03_ECHO_ONLY_SENSOR_PASS")
		quit(0)


func _run() -> void:
	var loaded := loader.load_file("res://data/levels/phase_1_s03_echo_only_sensor.json")
	if not loaded.ok:
		print("TASK_0024AZ_LOAD_DIAGNOSTIC " + JSON.stringify(loaded.errors))
	_expect(loaded.ok, "public_load")
	if not loaded.ok:
		return
	var level: Dictionary = loaded.level
	_identity(level)
	var started := Time.get_ticks_msec()
	var solved := Solver.new().solve(level, LIMITS)
	var elapsed := Time.get_ticks_msec() - started
	_expect(solved.status == "SOLVED", "solver_solved")
	if solved.status != "SOLVED":
		return
	_expect(solved.shortest_turn_count >= 12 and solved.shortest_turn_count <= 20, "length_band")
	_expect(solved.shortest_turn_count <= 24, "hard_length_cap")
	_expect(solved.shortest_solution_count_status == "EXACT" and solved.shortest_solution_count >= 1 and solved.shortest_solution_count <= 64, "count_band")
	_expect(solved.visited_states <= LIMITS.state_limit and elapsed <= LIMITS.time_limit_ms, "hard_budgets")
	var replay_a := simulation.replay(level, solved.solution)
	var replay_b := simulation.replay(level, solved.solution)
	_expect(replay_a.ok and replay_a.state.completed and replay_a.state.player_position == level.exit.position, "replay_complete")
	_expect(replay_a.state == replay_b.state and replay_a.canonical_keys == replay_b.canonical_keys and replay_a.transitions == replay_b.transitions, "replay_deterministic")
	var initial := simulation.construct_initial_state(level)
	var restart := simulation.restart(level)
	_expect(restart.ok and restart.state == initial, "restart_exact")
	var witness := _trace(level, solved.solution)
	print("TASK_0024AZ_WITNESS_DIAGNOSTIC " + JSON.stringify({"solution":solved.solution,"mask":witness.mask,"waits":witness.waits,"blocked_actions":witness.blocked_actions,"max_repeated_identical_blocked":witness.max_repeated_identical_blocked}))
	_expect(witness.mask == FULL_MASK, "witness_full_mask")
	_expect(witness.max_repeated_identical_blocked <= 1, "blocked_macro")
	var shortest := _all_shortest(level, solved.shortest_turn_count)
	_expect(shortest.status == "COMPLETE", "all_shortest_complete")
	_expect(shortest.total == solved.shortest_solution_count and shortest.full == shortest.total and shortest.omissions == 0, "all_shortest_full")
	var controls := _controls(level, solved)
	var probes := _probes(level, witness)
	summary = {
		"identity":{"candidate_slot":"S03","level_id":level.level_id,"title":level.title,"width":level.terrain_rows[0].length(),"height":level.terrain_rows.size(),"catalog_status":"NOT_AUTHORIZED","production_sequence":"UNASSIGNED"},
		"limits":LIMITS,
		"solver":{"status":solved.status,"shortest_turn_count":solved.shortest_turn_count,"shortest_solution_count":solved.shortest_solution_count,"shortest_solution_count_status":solved.shortest_solution_count_status,"visited_states":solved.visited_states,"maximum_frontier":solved.maximum_frontier,"elapsed_ms":elapsed,"solution":solved.solution},
		"witness":witness,
		"all_shortest":shortest,
		"controls":controls,
		"probes":probes,
		"replay_deterministic":replay_a.state == replay_b.state and replay_a.canonical_keys == replay_b.canonical_keys and replay_a.transitions == replay_b.transitions,
		"restart_exact":restart.state == initial,
		"presentation_status":"MACHINE_CONTRACT_READY_OWNER_REVIEW_PENDING"
	}


func _identity(level: Dictionary) -> void:
	_expect(level.schema_version == 2 and level.level_id == "phase_1_s03_echo_only_sensor" and level.title == "Echo Signal", "identity")
	_expect(level.terrain_rows.size() >= 6 and level.terrain_rows.size() <= 8 and level.terrain_rows[0].length() >= 8 and level.terrain_rows[0].length() <= 11, "footprint")
	_expect(level.echoes.size() == 1 and level.echoes[0].id == "echo_signal" and level.echoes[0].delay >= 2 and level.echoes[0].delay <= 4, "echo")
	_expect(level.sensors.size() == 1 and level.sensors[0].id == "sensor_echo_signal" and level.sensors[0].activator == "ECHO_ONLY" and not level.sensors[0].include_crates, "echo_sensor")
	_expect(level.barrier_groups.size() == 1 and level.barrier_groups[0].id == "barrier_body_route" and not level.barrier_groups[0].initial_open and level.barrier_groups[0].all_sensor_ids == ["sensor_echo_signal"], "barrier")
	_expect(level.crates.is_empty() and level.keys.is_empty() and level.locks.is_empty() and level.plates.is_empty() and level.doors.is_empty() and level.latches.is_empty(), "forbidden_empty")
	_expect(level.validation.recommended_search_depth <= 56, "recommended_depth")
	var catalog := FileAccess.get_file_as_string("res://data/catalog/level_catalog_v1.json")
	_expect(not catalog.contains(level.level_id), "uncatalogued")


func _trace(level: Dictionary, actions: Array) -> Dictionary:
	var state := simulation.construct_initial_state(level)
	var mask := 0
	var records := []
	var waits := 0
	var blocked_actions := 0
	var repeated := 0
	var maximum_repeated := 0
	var prior_blocked := ""
	for index in actions.size():
		var before := state.duplicate(true)
		var result := simulation.transition(level, state, actions[index])
		_expect(result.ok, "trace_%d" % index)
		if not result.ok:
			break
		state = result.state
		var event := _event(level, before, result, mask)
		mask = event.mask
		if not event.names.is_empty():
			records.append({"turn":index+1,"action":actions[index],"echo_action":result.actor_actions.echoes[0].action,"events":event.names,"before":_view(level,before),"after":_view(level,state),"completed":state.completed})
		if actions[index] == "WAIT":
			waits += 1
		var blocked: bool = actions[index] != "WAIT" and before.player_position == state.player_position
		if blocked:
			blocked_actions += 1
		if blocked and prior_blocked == actions[index]:
			repeated += 1
		elif blocked:
			repeated = 1
		else:
			repeated = 0
		prior_blocked = actions[index] if blocked else ""
		maximum_repeated = maxi(maximum_repeated, repeated)
	return {"mask":mask,"events":records,"waits":waits,"blocked_actions":blocked_actions,"max_repeated_identical_blocked":maximum_repeated}


func _event(level: Dictionary, before: Dictionary, result: Dictionary, current: int) -> Dictionary:
	var mask := current
	var names := []
	var state: Dictionary = result.state
	var sensor_position: Array = level.sensors[0].position
	var pressed: Array = simulation.pressed_sensor_ids(level, state)
	var echo_on: bool = state.echo_positions[0].position == sensor_position and pressed.has("sensor_echo_signal")
	var committed: bool = state.player_position[1] <= 3
	if committed and not (mask & 2) and not (mask & 1):
		mask |= 1
		names.append("BODY_ROUTE_COMMITMENT")
	if echo_on and not (mask & 2):
		mask |= 2
		names.append("ECHO_ON_ECHO_ONLY_SENSOR")
	if echo_on and (mask & 1) and state.barrier_states[0].open and not (mask & 4):
		mask |= 4
		names.append("BARRIER_OPEN_FROM_ECHO")
	var crossed := false
	for barrier_cell in level.barrier_groups[0].cells:
		if before.barrier_states[0].open and state.player_position == barrier_cell and before.player_position != state.player_position:
			crossed = true
	if crossed and not (mask & 8):
		mask |= 8
		names.append("YOU_LATER_CROSSES_BARRIER")
	if state.completed and not (mask & 16):
		mask |= 16
		names.append("YOU_REACHES_EXIT")
	return {"mask":mask,"names":names}


func _view(level: Dictionary, state: Dictionary) -> Dictionary:
	var pressed := simulation.pressed_sensor_ids(level,state)
	return {"you":state.player_position,"echo":state.echo_positions[0].position,"echo_sensor":pressed.has("sensor_echo_signal"),"barrier_open":state.barrier_states[0].open,"history":state.history}


func _all_shortest(level: Dictionary, goal_depth: int) -> Dictionary:
	var initial := simulation.construct_initial_state(level)
	var first := simulation.canonical_key(initial) + "|0"
	var queue := [first]
	var states := {first:initial}
	var masks := {first:0}
	var depths := {first:0}
	var counts := {first:1}
	var head := 0
	var goals := []
	var started := Time.get_ticks_msec()
	while head < queue.size():
		if Time.get_ticks_msec() - started >= LIMITS.time_limit_ms:
			return {"status":"TIME_LIMIT"}
		var key: String = queue[head]
		head += 1
		if depths[key] >= goal_depth:
			continue
		for action in ACTIONS:
			var result := simulation.transition(level,states[key],action)
			if not result.ok:
				continue
			var event := _event(level,states[key],result,masks[key])
			var next := simulation.canonical_key(result.state) + "|" + str(event.mask)
			var depth: int = depths[key] + 1
			if not depths.has(next):
				if states.size() >= LIMITS.state_limit:
					return {"status":"STATE_LIMIT"}
				states[next]=result.state
				masks[next]=event.mask
				depths[next]=depth
				counts[next]=counts[key]
				queue.append(next)
			elif depths[next] == depth:
				counts[next] += counts[key]
			if result.state.completed and depth == goal_depth and not goals.has(next):
				goals.append(next)
	var total := 0
	var full := 0
	var by_mask := {}
	for goal in goals:
		total += counts[goal]
		by_mask[str(masks[goal])] = int(by_mask.get(str(masks[goal]),0)) + counts[goal]
		if masks[goal] == FULL_MASK:
			full += counts[goal]
	return {"status":"COMPLETE","total":total,"full":full,"omissions":total-full,"counts_by_mask":by_mask,"visited_composite_states":states.size()}


func _controls(level: Dictionary, baseline: Dictionary) -> Dictionary:
	var controls := {}
	controls.no_echo = _solve(level, func(v): v.echoes=[]; v.metadata.allow_zero_echo_tutorial=true)
	_expect(controls.no_echo.status == "UNSOLVABLE_WITHIN_COMPLETE_FINITE_STATE", "control_no_echo")
	controls.any_actor = _solve(level, func(v): v.sensors[0].activator="ANY_ACTOR")
	var any_mask := _variant_mask(level, func(v): v.sensors[0].activator="ANY_ACTOR", controls.any_actor.solution) if controls.any_actor.status == "SOLVED" else -1
	var any_source := level.duplicate(true)
	any_source.sensors[0].activator = "ANY_ACTOR"
	var any_loaded := loader.validate_dict(any_source)
	var any_state := simulation.construct_initial_state(any_loaded.level)
	any_state.player_position = any_loaded.level.sensors[0].position
	var any_you_substitution: bool = simulation.pressed_sensor_ids(any_loaded.level,any_state).has("sensor_echo_signal")
	_expect(controls.any_actor.status == "SOLVED" and (any_you_substitution or _material(controls.any_actor, baseline) or any_mask != FULL_MASK), "control_any_actor")
	controls.any_actor_mask = any_mask
	controls.any_actor_you_substitution = any_you_substitution
	controls.you_only = _solve(level, func(v): v.sensors[0].activator="YOU_ONLY")
	var you_mask := _variant_mask(level, func(v): v.sensors[0].activator="YOU_ONLY", controls.you_only.solution) if controls.you_only.status == "SOLVED" else -1
	_expect(controls.you_only.status == "UNSOLVABLE_WITHIN_COMPLETE_FINITE_STATE" or (_material(controls.you_only, baseline) and you_mask != FULL_MASK), "control_you_only")
	controls.you_only_mask = you_mask
	controls.dependency_removed = _solve(level, func(v): v.sensors[0].position=[2,1]; v.sensors[0].activator="YOU_ONLY")
	var dependency_mask := _variant_mask(level, func(v): v.sensors[0].position=[2,1]; v.sensors[0].activator="YOU_ONLY", controls.dependency_removed.solution) if controls.dependency_removed.status == "SOLVED" else -1
	_expect(controls.dependency_removed.status == "SOLVED" and dependency_mask != FULL_MASK, "control_dependency_removed")
	controls.dependency_removed_mask = dependency_mask
	controls.initially_open = _solve(level, func(v): v.sensors[0].position=v.echoes[0].spawn; v.echoes[0].delay=4; v.barrier_groups[0].initial_open=true)
	var initially_open_mask := _variant_mask(level, func(v): v.sensors[0].position=v.echoes[0].spawn; v.echoes[0].delay=4; v.barrier_groups[0].initial_open=true, controls.initially_open.solution) if controls.initially_open.status == "SOLVED" else -1
	_expect(controls.initially_open.status == "SOLVED" and initially_open_mask != FULL_MASK, "control_initially_open")
	controls.initially_open_mask = initially_open_mask
	controls.body_route_removed = _solve(level, func(v): v.terrain_rows[4]="###########")
	_expect(controls.body_route_removed.status == "UNSOLVABLE_WITHIN_COMPLETE_FINITE_STATE", "control_body_route_removed")
	controls.echo_route_removed = _solve(level, func(v): v.sensors[0].position=[7,5]; v.terrain_rows[5]="#...###.#.#")
	_expect(controls.echo_route_removed.status == "UNSOLVABLE_WITHIN_COMPLETE_FINITE_STATE", "control_echo_route_removed")
	controls.direct_body_bypass = _solve(level, func(v): v.terrain_rows[4]="#.........#")
	var bypass_mask := _variant_mask(level, func(v): v.terrain_rows[4]="#.........#", controls.direct_body_bypass.solution) if controls.direct_body_bypass.status == "SOLVED" else -1
	_expect(controls.direct_body_bypass.status == "SOLVED" and (_material(controls.direct_body_bypass, baseline) or bypass_mask != FULL_MASK), "control_direct_bypass")
	controls.direct_body_bypass_mask = bypass_mask
	controls.symmetric_path = _solve(level, func(v): v.terrain_rows[4]="#.........#"; v.echoes[0].spawn=[9,5]; v.sensors[0].position=[7,5])
	_expect(_material(controls.symmetric_path,baseline), "control_symmetric")
	return controls


func _solve(level: Dictionary, mutate: Callable) -> Dictionary:
	var source := level.duplicate(true)
	mutate.call(source)
	var loaded := loader.validate_dict(source)
	_expect(loaded.ok, "control_public_load")
	if not loaded.ok:
		return {"status":"INVALID_LEVEL","errors":loaded.errors}
	return Solver.new().solve(loaded.level,LIMITS)


func _material(control: Dictionary, baseline: Dictionary) -> bool:
	return control.status == "UNSOLVABLE_WITHIN_COMPLETE_FINITE_STATE" or (control.status == "SOLVED" and (control.shortest_turn_count != baseline.shortest_turn_count or control.shortest_solution_count != baseline.shortest_solution_count))


func _variant_mask(level: Dictionary, mutate: Callable, actions: Array) -> int:
	var source := level.duplicate(true)
	mutate.call(source)
	var loaded := loader.validate_dict(source)
	if not loaded.ok:
		return -1
	return _trace(loaded.level,actions).mask


func _probes(level: Dictionary, witness: Dictionary) -> Dictionary:
	var initial := simulation.construct_initial_state(level)
	var wrong_you := initial.duplicate(true)
	wrong_you.player_position = level.sensors[0].position
	var you_rejected := not simulation.pressed_sensor_ids(level,wrong_you).has("sensor_echo_signal")
	var echo_valid := initial.duplicate(true)
	echo_valid.echo_positions[0].position = level.sensors[0].position
	var echo_accepted := simulation.pressed_sensor_ids(level,echo_valid).has("sensor_echo_signal")
	var echo_exit := initial.duplicate(true)
	echo_exit.echo_positions[0].position = level.exit.position
	var echo_exit_result := simulation.transition(level,echo_exit,"WAIT")
	var crossed_open := false
	var echo_turn := -1
	var cross_turn := -1
	for record in witness.events:
		if record.events.has("ECHO_ON_ECHO_ONLY_SENSOR"):
			echo_turn = record.turn
		if record.events.has("YOU_LATER_CROSSES_BARRIER"):
			crossed_open = record.before.barrier_open
			cross_turn = record.turn
	_expect(you_rejected,"you_cannot_echo_sensor")
	_expect(echo_accepted,"echo_can_echo_sensor")
	_expect(not echo_exit_result.state.completed,"echo_cannot_exit")
	_expect(crossed_open and cross_turn > echo_turn,"barrier_start_snapshot_and_later_cross")
	return {"you_cannot_activate_echo_only":you_rejected,"echo_can_activate_echo_only":echo_accepted,"echo_cannot_complete_exit":not echo_exit_result.state.completed,"barrier_cross_uses_open_start_snapshot":crossed_open,"echo_sensor_turn":echo_turn,"you_cross_turn":cross_turn,"restart_zero_residue":simulation.restart(level).state==initial}


func _emit() -> void:
	print("TASK_0024AZ_EVIDENCE " + JSON.stringify({"kind":"solver","record":summary.solver}))
	print("TASK_0024AZ_EVIDENCE " + JSON.stringify({"kind":"all_shortest","record":summary.all_shortest}))
	print("TASK_0024AZ_EVIDENCE " + JSON.stringify({"kind":"witness_summary","mask":summary.witness.mask,"waits":summary.witness.waits,"blocked_actions":summary.witness.blocked_actions,"event_count":summary.witness.events.size()}))
	for event in summary.witness.events:
		print("TASK_0024AZ_EVIDENCE " + JSON.stringify({"kind":"witness_event","record":event}))
	for control_name in summary.controls:
		var value = summary.controls[control_name]
		if value is Dictionary:
			var record := {"status":value.get("status"),"shortest_turn_count":value.get("shortest_turn_count"),"shortest_solution_count":value.get("shortest_solution_count"),"shortest_solution_count_status":value.get("shortest_solution_count_status"),"visited_states":value.get("visited_states"),"maximum_frontier":value.get("maximum_frontier")}
			print("TASK_0024AZ_EVIDENCE " + JSON.stringify({"kind":"control","name":control_name,"record":record}))
		else:
			print("TASK_0024AZ_EVIDENCE " + JSON.stringify({"kind":"control_fact","name":control_name,"value":value}))
	print("TASK_0024AZ_EVIDENCE " + JSON.stringify({"kind":"probes","record":summary.probes}))
	print("TASK_0024AZ_EVIDENCE " + JSON.stringify({"kind":"summary","identity":summary.identity,"replay_deterministic":summary.replay_deterministic,"restart_exact":summary.restart_exact,"presentation_status":summary.presentation_status}))


func _expect(condition: bool, label: String) -> void:
	if not condition:
		failures += 1
		printerr("TASK_0024AZ_CASE_FAIL " + label)

extends SceneTree

const LevelLoader = preload("res://scripts/simulation/level_loader.gd")
const Simulation = preload("res://scripts/simulation/simulation.gd")
const Solver = preload("res://scripts/solver/bfs_solver.gd")
const CatalogLoader = preload("res://scripts/app/catalog_loader.gd")
const ProgressStore = preload("res://scripts/app/memory_progress.gd")
const RouteRequest = preload("res://scripts/app/route_request.gd")
const TimelineModel = preload("res://scripts/gameplay/timeline_model.gd")
const WindowPresentation = preload("res://scripts/app/window_presentation.gd")

var failures := 0
var assertions := 0
var loader := LevelLoader.new()
var simulation := Simulation.new()


func _init() -> void:
	call_deferred("_run")


func _run() -> void:
	_test_tutorial_reach_exit_contract()
	_test_tutorial_reach_exit_solver()
	_test_tutorial_echo_bridge_contract()
	_test_tutorial_echo_bridge_solver_and_necessity()
	_test_task_0009ar_levels()
	_test_task_0012_level()
	_test_task_0015_level()
	_test_tracked_catalog()
	_test_catalog_failures()
	_test_memory_progress()
	_test_tracked_progress_chain_and_reset()
	_test_direct_level_parser()
	_test_loader()
	_test_vectors()
	_test_determinism_and_errors()
	_test_solver()
	_test_timeline_model_contract()
	await _test_scene_smoke()
	await _test_tutorial_zero_gameplay_tracer()
	await _test_tutorial_one_gameplay_tracer()
	await _test_task_0011_presentation_recovery()
	await _test_gameplay_configuration_failure()
	await _test_app_shell_tracer()
	await _test_task_0011r_window_fill()
	if failures > 0:
		printerr("TASK_0003_TESTS_FAIL failures=%d assertions=%d" % [failures, assertions])
		quit(1)
	else:
		print("TASK_0003_TESTS_PASS assertions=%d vectors=9" % assertions)
		print("TASK_0006_APP_SHELL_TESTS_PASS")
		print("TASK_0007_TUTORIAL_LEVELS_TESTS_PASS")
		print("TASK_0008_PROGRESSIVE_HUD_TESTS_PASS")
		print("TASK_0009AR_LEVELS_4_5_TESTS_PASS")
		print("TASK_0011_PRESENTATION_RECOVERY_TESTS_PASS")
		print("TASK_0011R_WINDOW_FILL_TESTS_PASS")
		print("TASK_0012_LEVEL_6_STAGGERED_DOORS_TESTS_PASS")
		print("TASK_0015_LEVEL_7_TWO_ECHO_CONVERGENCE_TESTS_PASS")
		quit(0)


func _test_tutorial_reach_exit_contract() -> void:
	var loaded := loader.load_file("res://data/levels/tutorial_reach_exit.json")
	_expect(loaded.ok, "Tutorial 0 loads through the accepted LevelLoader")
	if loaded.ok:
		_expect(loaded.level.level_id == "tutorial_reach_exit" and loaded.level.echoes.is_empty() and loaded.level.plates.is_empty() and loaded.level.doors.is_empty() and loaded.level.metadata.allow_zero_echo_tutorial, "Tutorial 0 is a genuine zero-entity schema-v1 tutorial")


func _test_tutorial_reach_exit_solver() -> void:
	var loaded := loader.load_file("res://data/levels/tutorial_reach_exit.json")
	if not loaded.ok:
		return
	var initial := simulation.construct_initial_state(loaded.level)
	_expect(initial.history.is_empty() and initial.echo_positions.is_empty() and initial.door_states.is_empty(), "Tutorial 0 initial state contains no delayed-system placeholders")
	var limits := {"depth_limit": 12, "state_limit": 10000, "time_limit_ms": 10000, "solution_count_cap": 1000000}
	var result := Solver.new().solve(loaded.level, limits)
	_expect(result.status == "SOLVED" and result.shortest_turn_count >= 2 and result.shortest_turn_count <= 5, "Tutorial 0 solver proves the planned shortest-path band")
	_expect(result.status == "SOLVED" and result.shortest_turn_count == 3 and result.shortest_solution_count == 3 and result.shortest_solution_count_status == "EXACT" and result.visited_states == 6 and result.maximum_frontier == 2, "Tutorial 0 accepted metrics remain exact")
	if result.status != "SOLVED":
		return
	var replay := simulation.replay(loaded.level, result.solution)
	_expect(replay.ok and replay.state.completed and result.solution.size() == result.shortest_turn_count and ["EXACT", "CAPPED"].has(result.shortest_solution_count_status), "Tutorial 0 solver witness replays to completion with valid count semantics")
	_expect(simulation.restart(loaded.level).state == initial, "Tutorial 0 restart exactly reconstructs its initial state")
	print("TUTORIAL_0_SOLVER_RESULT=" + JSON.stringify(result))


func _test_tutorial_echo_bridge_contract() -> void:
	var loaded := loader.load_file("res://data/levels/tutorial_echo_bridge.json")
	_expect(loaded.ok, "Tutorial 1 loads through the accepted LevelLoader")
	if loaded.ok:
		var level: Dictionary = loaded.level
		_expect(level.level_id == "tutorial_echo_bridge" and level.echoes.size() == 1 and level.echoes[0].delay == 3 and level.echoes[0].spawn == level.player_spawn and level.plates.size() == 1 and level.doors.size() == 1 and level.doors[0].all_plate_ids == [level.plates[0].id], "Tutorial 1 has one shared-spawn delay-3 Echo and one Plate/Door chain")


func _test_tutorial_echo_bridge_solver_and_necessity() -> void:
	var loaded := loader.load_file("res://data/levels/tutorial_echo_bridge.json")
	if not loaded.ok:
		return
	var level: Dictionary = loaded.level
	var limits := {"depth_limit": 64, "state_limit": 100000, "time_limit_ms": 10000, "solution_count_cap": 1000000}
	var result := Solver.new().solve(level, limits)
	_expect(result.status == "SOLVED" and result.shortest_turn_count >= 6 and result.shortest_turn_count <= 10, "Tutorial 1 solver proves the planned shortest-path band")
	_expect(result.status == "SOLVED" and result.shortest_turn_count == 9 and result.shortest_solution_count == 12 and result.shortest_solution_count_status == "EXACT" and result.visited_states == 1975 and result.maximum_frontier == 509, "Tutorial 1 accepted metrics remain exact")
	if result.status != "SOLVED":
		return
	var replay := simulation.replay(level, result.solution)
	_expect(replay.ok and replay.state.completed and result.solution.size() == result.shortest_turn_count and ["EXACT", "CAPPED"].has(result.shortest_solution_count_status), "Tutorial 1 solver witness replays to completion with valid count semantics")
	var cooperation_trace := false
	var before: Dictionary = simulation.construct_initial_state(level)
	for transition in replay.transitions:
		var after: Dictionary = transition.state
		if before.door_states[0].open and before.echo_positions[0].position == level.plates[0].position and before.player_position != level.plates[0].position and after.player_position == level.doors[0].position:
			cooperation_trace = true
		before = after
	_expect(cooperation_trace, "Tutorial 1 witness enters the Door from an Echo-only start-of-turn Plate state")
	var no_echo_data: Dictionary = level.duplicate(true)
	no_echo_data.echoes = []
	no_echo_data.metadata.allow_zero_echo_tutorial = true
	var no_echo := loader.validate_dict(no_echo_data)
	_expect(no_echo.ok, "Tutorial 1 no-Echo controlled variant remains schema valid")
	if no_echo.ok:
		var no_echo_result := Solver.new().solve(no_echo.level, limits)
		_expect(no_echo_result.status == "UNSOLVABLE_WITHIN_COMPLETE_FINITE_STATE", "Tutorial 1 no-Echo variant exhausts the finite state space without a player bypass")
		_expect(no_echo_result.visited_states == 10, "Tutorial 1 no-Echo accepted visited-state metric remains exact")
		result["no_echo_variant_status"] = no_echo_result.status
		result["no_echo_variant_visited_states"] = no_echo_result.visited_states
	var echo_on_exit := simulation.construct_initial_state(level)
	echo_on_exit.echo_positions[0].position = level.exit.position.duplicate()
	var echo_only_result := simulation.transition(level, echo_on_exit, "WAIT")
	_expect(echo_only_result.ok and not echo_only_result.state.completed, "Tutorial 1 Echo on EXIT cannot complete for the player")
	_expect(simulation.restart(level).state == simulation.construct_initial_state(level), "Tutorial 1 restart exactly reconstructs its initial state")
	print("TUTORIAL_1_SOLVER_RESULT=" + JSON.stringify(result))


func _test_task_0009ar_levels() -> void:
	var expected_hashes := {
		"res://data/levels/tutorial_reach_exit.json": "38e466bb5922f1987a99d79c7527a4a8eab8e6cfdbe76fd8159f80b0a40cf2c4",
		"res://data/levels/tutorial_echo_bridge.json": "681d99057c4e6034a490644d75960ff23d8f43bd1b91850f48179b79fc04a3cf",
		"res://data/levels/vertical_slice_delay_3.json": "8751da5051fbebaaa5ae7c895d9be9f086e8d8f2e87876a80c379dc06262f1d8",
		"res://data/levels/door_one_turn_late.json": "1775cf89ae4a94f65a76dac2b791a31395443de88205d0ed1b6233331dbda577",
		"res://data/levels/two_keys_one_door.json": "f4c6791dfc84d17fb450721e654091a2baeb522e55d660a5d73878cd977651cd",
	}
	for path in expected_hashes:
		_expect(FileAccess.get_sha256(path) == expected_hashes[path], "accepted formal level hash remains exact: " + path)
	var level_4_loaded := loader.load_file("res://data/levels/door_one_turn_late.json")
	var level_5_loaded := loader.load_file("res://data/levels/two_keys_one_door.json")
	_expect(level_4_loaded.ok and level_5_loaded.ok, "Task 0009AR levels load through unchanged LevelLoader")
	if not level_4_loaded.ok or not level_5_loaded.ok:
		return
	var level_4: Dictionary = level_4_loaded.level
	var level_5: Dictionary = level_5_loaded.level
	_expect(level_4.echoes.size() == 1 and level_4.echoes[0].delay == 2 and level_4.plates.size() == 1 and level_4.doors.size() == 1 and level_4.doors[0].all_plate_ids == [level_4.plates[0].id], "Level 4 exact formal cardinalities and dependency")
	_expect(level_5.echoes.size() == 1 and level_5.echoes[0].delay == 3 and level_5.plates.size() == 2 and level_5.doors.size() == 1 and level_5.doors[0].all_plate_ids == level_5.plates.map(func(plate): return plate.id), "Level 5 exact formal cardinalities and AND dependency")
	var limits_4 := {"depth_limit": 24, "state_limit": 100000, "time_limit_ms": 10000, "solution_count_cap": 1000000}
	var solved_4 := Solver.new().solve(level_4, limits_4)
	var replay_4 := simulation.replay(level_4, solved_4.get("solution", []))
	_expect(solved_4.status == "SOLVED" and solved_4.shortest_turn_count == 9 and solved_4.shortest_solution_count == 7 and solved_4.shortest_solution_count_status == "EXACT" and solved_4.visited_states == 291 and solved_4.maximum_frontier == 116, "Level 4 exact solver metrics")
	_expect(replay_4.ok and replay_4.state.completed and replay_4.transitions.size() == solved_4.shortest_turn_count, "Level 4 witness replays to completion")
	var timing_trace := false
	var before_4 := simulation.construct_initial_state(level_4)
	for index in replay_4.transitions.size() - 1:
		var after_4: Dictionary = replay_4.transitions[index].state
		var next_4: Dictionary = replay_4.transitions[index + 1].state
		if not before_4.door_states[0].open and after_4.player_position == before_4.player_position and after_4.echo_positions[0].position == level_4.plates[0].position and after_4.door_states[0].open and next_4.player_position == level_4.doors[0].position:
			timing_trace = true
		before_4 = after_4
	_expect(timing_trace, "Level 4 shortest witness proves closed-snapshot/open-result then open-snapshot entry")
	var no_echo_4_data: Dictionary = level_4.duplicate(true)
	no_echo_4_data.echoes = []
	no_echo_4_data.metadata.allow_zero_echo_tutorial = true
	var no_echo_4 := loader.validate_dict(no_echo_4_data)
	var no_echo_4_result := Solver.new().solve(no_echo_4.level, limits_4) if no_echo_4.ok else {"status": "INVALID_LEVEL"}
	_expect(no_echo_4.ok and no_echo_4_result.status == "UNSOLVABLE_WITHIN_COMPLETE_FINITE_STATE" and no_echo_4_result.visited_states == 5, "Level 4 no-Echo complete search proves cooperation and no bypass")
	var limits_5 := {"depth_limit": 32, "state_limit": 500000, "time_limit_ms": 20000, "solution_count_cap": 1000000}
	var solved_5 := Solver.new().solve(level_5, limits_5)
	var replay_5 := simulation.replay(level_5, solved_5.get("solution", []))
	_expect(solved_5.status == "SOLVED" and solved_5.shortest_turn_count == 12 and solved_5.shortest_solution_count == 1 and solved_5.shortest_solution_count_status == "EXACT" and solved_5.visited_states == 1260 and solved_5.maximum_frontier == 225, "Level 5 exact solver metrics")
	_expect(replay_5.ok and replay_5.state.completed and replay_5.transitions.size() == solved_5.shortest_turn_count, "Level 5 witness replays to completion")
	var and_trace := false
	for index in replay_5.transitions.size() - 1:
		var after_5: Dictionary = replay_5.transitions[index].state
		var next_5: Dictionary = replay_5.transitions[index + 1].state
		var distinct_plate_occupancy: bool = (after_5.player_position == level_5.plates[0].position and after_5.echo_positions[0].position == level_5.plates[1].position) or (after_5.player_position == level_5.plates[1].position and after_5.echo_positions[0].position == level_5.plates[0].position)
		if distinct_plate_occupancy and replay_5.transitions[index].pressed_plate_ids == level_5.plates.map(func(plate): return plate.id) and after_5.door_states[0].open and next_5.player_position == level_5.doors[0].position:
			and_trace = true
	_expect(and_trace, "Level 5 witness proves simultaneous two-actor AND occupancy and open-snapshot entry")
	var no_echo_5_data: Dictionary = level_5.duplicate(true)
	no_echo_5_data.echoes = []
	no_echo_5_data.metadata.allow_zero_echo_tutorial = true
	var no_echo_5 := loader.validate_dict(no_echo_5_data)
	var no_echo_5_result := Solver.new().solve(no_echo_5.level, limits_5) if no_echo_5.ok else {"status": "INVALID_LEVEL"}
	_expect(no_echo_5.ok and no_echo_5_result.status == "UNSOLVABLE_WITHIN_COMPLETE_FINITE_STATE" and no_echo_5_result.visited_states == 8, "Level 5 no-Echo complete search proves cooperation and no bypass")
	for plate_id in ["plate_echo", "plate_you"]:
		var relocated_data: Dictionary = level_5.duplicate(true)
		for plate in relocated_data.plates:
			if plate.id == plate_id:
				plate.position = [6, 1]
		var relocated := loader.validate_dict(relocated_data)
		var relocated_result := Solver.new().solve(relocated.level, limits_5) if relocated.ok else {"status": "INVALID_LEVEL"}
		_expect(relocated.ok and relocated_result.status == "UNSOLVABLE_WITHIN_COMPLETE_FINITE_STATE" and relocated_result.visited_states == 1000, "Level 5 relocated %s dependency is complete unsolved" % plate_id)
		var single_data: Dictionary = level_5.duplicate(true)
		single_data.doors[0].all_plate_ids = [plate_id]
		var single := loader.validate_dict(single_data)
		var single_result := Solver.new().solve(single.level, limits_5) if single.ok else {"status": "INVALID_LEVEL"}
		_expect(single.ok and single_result.status == "SOLVED" and single_result.shortest_turn_count == 12, "Level 5 single-%s control demonstrates why the formal AND set matters" % plate_id)
	for checked_level in [level_4, level_5]:
		var echo_on_exit := simulation.construct_initial_state(checked_level)
		echo_on_exit.echo_positions[0].position = checked_level.exit.position.duplicate()
		var echo_only := simulation.transition(checked_level, echo_on_exit, "WAIT")
		_expect(echo_only.ok and not echo_only.state.completed, checked_level.level_id + " Echo on EXIT cannot complete")
		_expect(simulation.restart(checked_level).state == simulation.construct_initial_state(checked_level), checked_level.level_id + " restart is exact")
	print("TASK_0009AR_LEVEL_4_RESULT=" + JSON.stringify(solved_4))
	print("TASK_0009AR_LEVEL_5_RESULT=" + JSON.stringify(solved_5))


func _test_task_0012_level() -> void:
	var path := "res://data/levels/staggered_doors.json"
	var loaded := loader.load_file(path)
	_expect(loaded.ok, "Task 0012 Level 6 loads through unchanged LevelLoader")
	_expect(FileAccess.get_sha256(path) == "3f14c19b50775e36dd5b52664798381cf1292b0a30b377641c03435f45696bc8", "Task 0012 formal Level 6 hash is exact")
	if not loaded.ok:
		return
	var level: Dictionary = loaded.level
	_expect(level.level_id == "staggered_doors" and level.title == "Staggered Doors" and not level.metadata.allow_zero_echo_tutorial, "Task 0012 formal identity and official-level policy are exact")
	_expect(level.terrain_rows.size() == 7 and level.terrain_rows[0].length() == 9, "Task 0012 Level 6 fits the 9 by 7 footprint")
	_expect(level.echoes.size() == 1 and level.echoes[0].delay == 3 and level.echoes[0].spawn == level.player_spawn, "Task 0012 Level 6 has one shared-spawn delay-3 ECHO")
	_expect(level.plates.map(func(plate): return plate.id) == ["plate_early", "plate_late"], "Task 0012 Level 6 has exactly two stable Plates")
	_expect(level.doors.map(func(door): return door.id) == ["door_early", "door_late"], "Task 0012 Level 6 has exactly two stable Doors")
	_expect(level.doors[0].all_plate_ids == ["plate_early"] and level.doors[1].all_plate_ids == ["plate_late"], "Task 0012 Door dependency sets are distinct and cover both Plates")
	var limits := {"depth_limit": 64, "state_limit": 500000, "time_limit_ms": 30000, "solution_count_cap": 1000000}
	var solved := Solver.new().solve(level, limits)
	_expect(solved.status == "SOLVED", "Task 0012 shared BFS solves Level 6")
	_expect(solved.shortest_turn_count == 15 and solved.shortest_solution_count == 4 and solved.shortest_solution_count_status == "EXACT", "Task 0012 Level 6 exact L star and N star meet hard bands")
	_expect(solved.visited_states == 6772 and solved.maximum_frontier == 1179, "Task 0012 Level 6 exact search burden meets hard bands")
	_expect(solved.limits == limits, "Task 0012 solver records all exact limits")
	_expect(not solved.solution.has("WAIT"), "Task 0012 selected shortest witness contains no literal WAIT")
	var replay := simulation.replay(level, solved.solution)
	_expect(replay.ok and replay.state.completed and replay.transitions.size() == 15, "Task 0012 witness replays through shared Simulation to completion")
	_expect(simulation.restart(level).state == simulation.construct_initial_state(level), "Task 0012 restart exactly reconstructs Level 6")
	_expect(replay.transitions[4].state.door_states[0].open and replay.transitions[4].state.echo_positions[0].position == [2, 4] and replay.transitions[5].state.player_position == [4, 4] and not replay.transitions[5].state.door_states[0].open, "Task 0012 early ECHO window opens then closes around YOU after entry")
	_expect(replay.transitions[6].state.door_states[1].open and replay.transitions[6].state.echo_positions[0].position == [3, 5] and replay.transitions[7].state.player_position == [6, 4], "Task 0012 late ECHO window opens later and permits next-turn entry")
	_expect(not replay.transitions[7].state.door_states[1].open and not replay.transitions[14].state.door_states[1].open, "Task 0012 late window closes around YOU after entry and is not permanent")
	var no_echo_data: Dictionary = level.duplicate(true)
	no_echo_data.echoes = []
	no_echo_data.metadata.allow_zero_echo_tutorial = true
	var no_echo := loader.validate_dict(no_echo_data)
	var no_echo_result := Solver.new().solve(no_echo.level, limits) if no_echo.ok else {"status": "INVALID_LEVEL"}
	_expect(no_echo.ok and no_echo_result.status == "UNSOLVABLE_WITHIN_COMPLETE_FINITE_STATE" and no_echo_result.visited_states == 6 and no_echo_result.maximum_frontier == 2, "Task 0012 no-ECHO complete finite state is unsolved")
	var isolated_results := {}
	for plate_id in ["plate_early", "plate_late"]:
		var isolated_data: Dictionary = level.duplicate(true)
		for plate in isolated_data.plates:
			if plate.id == plate_id:
				plate.position = [7, 2]
		var isolated := loader.validate_dict(isolated_data)
		isolated_results[plate_id] = Solver.new().solve(isolated.level, limits) if isolated.ok else {"status": "INVALID_LEVEL"}
	_expect(isolated_results.plate_early.status == "UNSOLVABLE_WITHIN_COMPLETE_FINITE_STATE" and isolated_results.plate_early.visited_states == 750 and isolated_results.plate_early.maximum_frontier == 325, "Task 0012 plate_early isolation is complete unsolved")
	_expect(isolated_results.plate_late.status == "UNSOLVABLE_WITHIN_COMPLETE_FINITE_STATE" and isolated_results.plate_late.visited_states == 3911 and isolated_results.plate_late.maximum_frontier == 875, "Task 0012 plate_late isolation is complete unsolved")
	var removed_results := {}
	for door_id in ["door_early", "door_late"]:
		var removed_data: Dictionary = level.duplicate(true)
		removed_data.doors = removed_data.doors.filter(func(door): return door.id != door_id)
		var removed := loader.validate_dict(removed_data)
		removed_results[door_id] = Solver.new().solve(removed.level, limits) if removed.ok else {"status": "INVALID_LEVEL"}
	_expect(removed_results.door_early.status == "SOLVED" and removed_results.door_early.shortest_turn_count == 13 and removed_results.door_early.shortest_solution_count == 1 and removed_results.door_early.shortest_solution_count_status == "EXACT" and removed_results.door_early.visited_states == 2936 and removed_results.door_early.maximum_frontier == 847, "Task 0012 removing door_early changes exact structure")
	_expect(removed_results.door_late.status == "SOLVED" and removed_results.door_late.shortest_turn_count == 15 and removed_results.door_late.shortest_solution_count == 48 and removed_results.door_late.shortest_solution_count_status == "EXACT" and removed_results.door_late.visited_states == 6865 and removed_results.door_late.maximum_frontier == 1309, "Task 0012 removing door_late changes exact multiplicity")
	var replacement_results := {}
	for replacement in [["door_early", "plate_late"], ["door_late", "plate_early"]]:
		var replacement_data: Dictionary = level.duplicate(true)
		for door in replacement_data.doors:
			if door.id == replacement[0]:
				door.all_plate_ids = [replacement[1]]
		var validated := loader.validate_dict(replacement_data)
		replacement_results[replacement[0]] = Solver.new().solve(validated.level, limits) if validated.ok else {"status": "INVALID_LEVEL"}
	_expect(replacement_results.door_early.shortest_turn_count == 15 and replacement_results.door_early.shortest_solution_count == 11 and replacement_results.door_early.shortest_solution_count_status == "EXACT" and replacement_results.door_early.visited_states == 6554 and replacement_results.door_early.maximum_frontier == 1121, "Task 0012 replacing door_early dependency changes exact structure")
	_expect(replacement_results.door_late.shortest_turn_count == 15 and replacement_results.door_late.shortest_solution_count == 14 and replacement_results.door_late.shortest_solution_count_status == "EXACT" and replacement_results.door_late.visited_states == 6743 and replacement_results.door_late.maximum_frontier == 1367, "Task 0012 replacing door_late dependency changes exact structure")
	var echo_on_exit := simulation.construct_initial_state(level)
	echo_on_exit.echo_positions[0].position = level.exit.position.duplicate()
	var echo_only := simulation.transition(level, echo_on_exit, "WAIT")
	_expect(echo_only.ok and not echo_only.state.completed, "Task 0012 ECHO on EXIT cannot complete")
	var blocked_turns := []
	var before := simulation.construct_initial_state(level)
	for index in replay.transitions.size():
		if solved.solution[index] != "WAIT" and replay.transitions[index].state.player_position == before.player_position:
			blocked_turns.append(index + 1)
		before = replay.transitions[index].state
	_expect(blocked_turns.is_empty(), "Task 0012 witness contains no blocked-move padding")
	_expect(replay.state.player_position == level.exit.position, "Task 0012 only YOU reaches the formal EXIT")
	print("TASK_0012_LEVEL_6_RESULT=" + JSON.stringify(solved))


func _test_task_0015_level() -> void:
	var path := "res://data/levels/two_echo_convergence.json"
	var loaded := loader.load_file(path)
	_expect(loaded.ok, "Task 0015 Level 7 loads through unchanged LevelLoader")
	if not loaded.ok:
		return
	var level: Dictionary = loaded.level
	_expect(level.level_id == "two_echo_convergence" and level.title == "Two Echo Convergence" and level.terrain_rows.size() == 7 and level.terrain_rows[0].length() == 9, "Task 0015 exact formal identity and footprint")
	_expect(level.echoes.map(func(echo): return [echo.id, echo.delay]) == [["echo_late", 4], ["echo_near", 2]] and level.echoes.all(func(echo): return echo.spawn == level.player_spawn), "Task 0015 exact shared-spawn E4/E2 roles")
	_expect(level.plates.map(func(plate): return plate.id) == ["plate_a", "plate_b"] and level.doors.size() == 1 and level.doors[0].all_plate_ids == ["plate_a", "plate_b"] and not level.doors[0].initial_open, "Task 0015 exact A+B Door structure")
	var limits := {"depth_limit": 64, "state_limit": 500000, "time_limit_ms": 30000, "solution_count_cap": 1000000}
	var solved := Solver.new().solve(level, limits)
	_expect(solved.status == "SOLVED" and solved.shortest_turn_count == 19 and solved.shortest_solution_count == 6 and solved.shortest_solution_count_status == "EXACT", "Task 0015 exact L star and N star satisfy hard bands")
	_expect(solved.visited_states == 61975 and solved.maximum_frontier == 21449 and solved.limits == limits, "Task 0015 exact visited/frontier burden and limits")
	_expect(not solved.solution.has("WAIT"), "Task 0015 selected shortest witness contains no literal WAIT")
	var replay := simulation.replay(level, solved.solution)
	_expect(replay.ok and replay.state.completed and replay.state.player_position == level.exit.position and replay.transitions.size() == 19, "Task 0015 witness replays to player-only EXIT completion")
	_expect(replay.transitions[16].pressed_plate_ids == ["plate_a", "plate_b"] and replay.transitions[16].state.echo_positions.map(func(echo): return echo.position).has([6, 3]) and replay.transitions[16].state.echo_positions.map(func(echo): return echo.position).has([7, 5]), "Task 0015 required two-ECHO convergence result is exact")
	_expect(replay.transitions[16].state.door_states[0].open and replay.transitions[17].state.player_position == level.doors[0].position and not replay.transitions[17].state.door_states[0].open, "Task 0015 following input crosses the open start-turn Door snapshot")
	_expect(simulation.restart(level).state == simulation.construct_initial_state(level), "Task 0015 restart exactly reconstructs Level 7")
	print("TASK_0015_LEVEL_7_RESULT=" + JSON.stringify(solved))


func _test_tracked_catalog() -> void:
	var result := CatalogLoader.new().load_file("res://data/catalog/level_catalog_v1.json")
	_expect(result.ok and result.catalog.entries.size() == 7, "tracked seven-entry catalog validates and normalizes")
	if result.ok and result.catalog.entries.size() == 7:
		var entries: Array = result.catalog.entries
		_expect(entries.map(func(entry): return entry.level_id) == ["tutorial_reach_exit", "tutorial_echo_bridge", "vertical_slice_delay_3", "door_one_turn_late", "two_keys_one_door", "staggered_doors", "two_echo_convergence"], "tracked catalog has the required seven-level sequence")
		_expect(entries[0].classification == "tutorial" and entries[0].hud_mode == "INTRO_MINIMAL" and entries[0].unlock_prerequisites.is_empty() and not entries[0].final_level, "Tutorial 0 catalog facts are exact")
		_expect(entries[1].classification == "tutorial" and entries[1].hud_mode == "GUIDED_ECHO" and entries[1].unlock_prerequisites == ["tutorial_reach_exit"] and not entries[1].final_level, "Tutorial 1 catalog facts are exact")
		_expect(entries[2].classification == "standard" and entries[2].hud_mode == "STANDARD_COMPACT" and entries[2].unlock_prerequisites == ["tutorial_echo_bridge"] and not entries[2].final_level, "vertical-slice catalog facts remain exact and are no longer final")
		_expect(entries[3].classification == "standard" and entries[3].hud_mode == "STANDARD_COMPACT" and entries[3].unlock_prerequisites == ["vertical_slice_delay_3"] and not entries[3].final_level and entries[3].display_title_key == "level.door_one_turn_late.title", "Level 4 catalog facts are exact")
		_expect(entries[4].classification == "standard" and entries[4].hud_mode == "STANDARD_COMPACT" and entries[4].unlock_prerequisites == ["door_one_turn_late"] and not entries[4].final_level and entries[4].display_title_key == "level.two_keys_one_door.title", "Level 5 catalog facts are exact and no longer final")
		_expect(entries[5].classification == "standard" and entries[5].hud_mode == "STANDARD_COMPACT" and entries[5].unlock_prerequisites == ["two_keys_one_door"] and not entries[5].final_level and entries[5].display_title_key == "level.staggered_doors.title", "Level 6 catalog facts are exact and no longer final")
		_expect(entries[6].classification == "standard" and entries[6].hud_mode == "STANDARD_COMPACT" and entries[6].unlock_prerequisites == ["staggered_doors"] and entries[6].final_level and entries[6].display_title_key == "level.two_echo_convergence.title", "Level 7 catalog facts are exact and solely final")
		_expect(entries.all(func(entry): return not entry.has("best_turn_threshold") and entry.formal_level.level_id == entry.level_id), "catalog omits thresholds and every formal ID matches")


func _test_catalog_failures() -> void:
	var catalog_loader = CatalogLoader.new()
	var file := FileAccess.open("res://data/catalog/level_catalog_v1.json", FileAccess.READ)
	var base: Dictionary = JSON.parse_string(file.get_as_text())
	_expect_catalog_code(catalog_loader.load_file("res://tests/app/invalid_catalog_json.json"), "CATALOG_JSON_PARSE_ERROR", "catalog JSON parse failure")
	var value := base.duplicate(true); value["unknown"] = true
	_expect_catalog_code(catalog_loader.validate_dict(value), "CATALOG_UNKNOWN_FIELD", "unknown catalog top-level field")
	value = base.duplicate(true); value.entries[0]["unknown"] = true
	_expect_catalog_code(catalog_loader.validate_dict(value), "CATALOG_UNKNOWN_FIELD", "unknown catalog entry field")
	value = base.duplicate(true); value.catalog_version = 2
	_expect_catalog_code(catalog_loader.validate_dict(value), "CATALOG_UNSUPPORTED_VERSION", "unsupported catalog version")
	value = base.duplicate(true); value.erase("entries")
	_expect_catalog_code(catalog_loader.validate_dict(value), "CATALOG_SHAPE_ERROR", "missing catalog field")
	value = base.duplicate(true); value.entries[0].sequence = "1"
	_expect_catalog_code(catalog_loader.validate_dict(value), "CATALOG_SHAPE_ERROR", "wrong catalog field type")
	value = base.duplicate(true); value.entries[0].level_id = "Invalid-ID"
	_expect_catalog_code(catalog_loader.validate_dict(value), "CATALOG_INVALID_FORMAT", "invalid catalog level ID")
	value = base.duplicate(true); value.entries[0].display_title_key = "bad key"
	_expect_catalog_code(catalog_loader.validate_dict(value), "CATALOG_INVALID_FORMAT", "invalid title key")
	value = base.duplicate(true); value.entries[0].level_path = "user://escape.json"
	_expect_catalog_code(catalog_loader.validate_dict(value), "CATALOG_INVALID_FORMAT", "invalid formal level path")
	value = base.duplicate(true); value.entries.append(value.entries[0].duplicate(true)); value.entries[1].sequence = 2; value.entries[1].final_level = false
	_expect_catalog_code(catalog_loader.validate_dict(value), "CATALOG_DUPLICATE_LEVEL_ID", "duplicate catalog level ID")
	value = base.duplicate(true); value.entries.append(value.entries[0].duplicate(true)); value.entries[1].level_id = "other"; value.entries[1].final_level = false
	_expect_catalog_code(catalog_loader.validate_dict(value), "CATALOG_DUPLICATE_SEQUENCE", "duplicate catalog sequence")
	value = base.duplicate(true); value.entries[0].sequence = 2
	_expect_catalog_code(catalog_loader.validate_dict(value), "CATALOG_NONCONTIGUOUS_SEQUENCE", "non-contiguous catalog sequence")
	value = base.duplicate(true); value.entries[0].classification = "boss"
	_expect_catalog_code(catalog_loader.validate_dict(value), "CATALOG_UNKNOWN_CLASSIFICATION", "unknown classification")
	value = base.duplicate(true); value.entries[0].hud_mode = "LOUD"
	_expect_catalog_code(catalog_loader.validate_dict(value), "CATALOG_UNKNOWN_HUD_MODE", "unknown HUD mode")
	value = base.duplicate(true); value.entries[0].unlock_prerequisites = ["other", "other"]
	_expect_catalog_code(catalog_loader.validate_dict(value), "CATALOG_DUPLICATE_PREREQUISITE", "duplicate catalog prerequisite")
	value = base.duplicate(true); value.entries[0].unlock_prerequisites = [value.entries[0].level_id]
	_expect_catalog_code(catalog_loader.validate_dict(value), "CATALOG_SELF_PREREQUISITE", "self prerequisite")
	value = base.duplicate(true); value.entries[0].unlock_prerequisites = ["missing"]
	_expect_catalog_code(catalog_loader.validate_dict(value), "CATALOG_UNKNOWN_PREREQUISITE", "unknown prerequisite")
	value = _cycle_catalog(base)
	var cycle_result := catalog_loader.validate_dict(value)
	_expect_catalog_code(cycle_result, "CATALOG_PREREQUISITE_CYCLE", "catalog prerequisite cycle")
	_expect_catalog_code(cycle_result, "CATALOG_UNREACHABLE_ENTRY", "catalog entry unreachable from roots")
	value = base.duplicate(true); value.entries[0].level_path = "res://data/levels/missing.json"
	_expect_catalog_code(catalog_loader.validate_dict(value), "CATALOG_LEVEL_FILE_MISSING", "missing formal level file")
	value = base.duplicate(true); value.entries[0].level_path = "res://tests/app/invalid_formal_level.json"
	_expect_catalog_code(catalog_loader.validate_dict(value, true), "CATALOG_FORMAL_LEVEL_INVALID", "formal level rejected by LevelLoader")
	value = base.duplicate(true); value.entries[0].level_path = "res://docs/level_design/examples/level_v1_minimal_valid.json"
	_expect_catalog_code(catalog_loader.validate_dict(value, true), "CATALOG_LEVEL_ID_MISMATCH", "catalog and formal level ID mismatch")
	value = base.duplicate(true)
	for entry in value.entries:
		entry.final_level = false
	_expect_catalog_code(catalog_loader.validate_dict(value), "CATALOG_FINAL_COUNT_INVALID", "zero final catalog entries")
	value = base.duplicate(true); value.entries[0].final_level = true
	_expect_catalog_code(catalog_loader.validate_dict(value), "CATALOG_FINAL_COUNT_INVALID", "multiple final catalog entries")


func _cycle_catalog(base: Dictionary) -> Dictionary:
	var value: Dictionary = base.duplicate(true)
	var first: Dictionary = value.entries[0].duplicate(true)
	first.level_id = "cycle_a"
	first.sequence = 1
	first.unlock_prerequisites = ["cycle_b"]
	first.final_level = true
	var second: Dictionary = first.duplicate(true)
	second.level_id = "cycle_b"
	second.sequence = 2
	second.unlock_prerequisites = ["cycle_a"]
	second.final_level = false
	value.entries = [first, second]
	return value


func _test_memory_progress() -> void:
	var user_files_before := Array(DirAccess.get_files_at("user://"))
	var catalog := {"entries": [
		{"level_id": "root_a", "unlock_prerequisites": []},
		{"level_id": "root_b", "unlock_prerequisites": []},
		{"level_id": "branch", "unlock_prerequisites": ["root_a"]},
		{"level_id": "join", "unlock_prerequisites": ["root_a", "root_b"]},
	]}
	var progress = ProgressStore.new(catalog)
	_expect(progress.is_unlocked("root_a") and not progress.is_unlocked("branch"), "progress unlocks roots only at initialization")
	_expect(not progress.record_completion("branch", 1), "progress rejects completion for a locked entry")
	_expect(progress.record_completion("root_a", 12) and progress.is_unlocked("branch") and not progress.is_unlocked("join"), "completion deterministically unlocks satisfied dependencies")
	_expect(progress.record_completion("root_a", 9) and progress.snapshot().best_turns.root_a == 9, "completion is idempotent and retains lower best turns")
	_expect(not progress.record_completion("missing", 1) and not progress.record_completion("root_b", 0), "progress rejects unknown IDs and invalid turns")
	progress.reset_test_profile()
	_expect(progress.snapshot().completed_level_ids.is_empty() and progress.is_unlocked("root_a") and not progress.is_unlocked("branch"), "progress reset restores deterministic memory-only state")
	_expect(Array(DirAccess.get_files_at("user://")) == user_files_before, "memory progress performs no filesystem writes")


func _test_tracked_progress_chain_and_reset() -> void:
	var loaded := CatalogLoader.new().load_file("res://data/catalog/level_catalog_v1.json")
	if not loaded.ok:
		return
	var progress = ProgressStore.new(loaded.catalog)
	_expect(progress.snapshot().unlocked_level_ids == ["tutorial_reach_exit"], "tracked progress initially unlocks only Tutorial 0")
	_expect(progress.record_completion("tutorial_reach_exit", 3) and progress.snapshot().unlocked_level_ids == ["tutorial_echo_bridge", "tutorial_reach_exit"], "tracked progress unlocks only Tutorial 1 after Tutorial 0")
	_expect(progress.record_completion("tutorial_echo_bridge", 9) and progress.snapshot().unlocked_level_ids == ["tutorial_echo_bridge", "tutorial_reach_exit", "vertical_slice_delay_3"], "tracked progress unlocks the vertical slice after Tutorial 1")
	_expect(progress.record_completion("vertical_slice_delay_3", 9) and progress.snapshot().unlocked_level_ids == ["door_one_turn_late", "tutorial_echo_bridge", "tutorial_reach_exit", "vertical_slice_delay_3"], "tracked progress unlocks only Level 4 after the vertical slice")
	_expect(not progress.is_unlocked("two_keys_one_door"), "Level 5 remains locked before Level 4 completion")
	_expect(progress.record_completion("door_one_turn_late", 8) and progress.snapshot().unlocked_level_ids == ["door_one_turn_late", "tutorial_echo_bridge", "tutorial_reach_exit", "two_keys_one_door", "vertical_slice_delay_3"], "tracked progress unlocks only Level 5 after Level 4")
	_expect(not progress.is_unlocked("staggered_doors"), "Level 6 remains locked before Level 5 completion")
	_expect(progress.record_completion("two_keys_one_door", 12) and progress.snapshot().unlocked_level_ids == ["door_one_turn_late", "staggered_doors", "tutorial_echo_bridge", "tutorial_reach_exit", "two_keys_one_door", "vertical_slice_delay_3"], "tracked progress unlocks only Level 6 after Level 5")
	_expect(not progress.is_unlocked("two_echo_convergence"), "Level 7 remains locked before Level 6 completion")
	_expect(progress.record_completion("staggered_doors", 15) and progress.snapshot().unlocked_level_ids.has("two_echo_convergence"), "tracked progress unlocks only Level 7 after Level 6")
	progress.reset_test_profile()
	_expect(progress.snapshot() == {"completed_level_ids": [], "best_turns": {}, "unlocked_level_ids": ["tutorial_reach_exit"]}, "tracked progress reset restores the exact initial unlock snapshot")


func _test_direct_level_parser() -> void:
	_expect(RouteRequest.parse_user_args([]).status == "NO_DIRECT_LEVEL", "direct-level parser accepts empty user arguments")
	var valid := RouteRequest.parse_user_args(["--level-id=vertical_slice_delay_3"])
	_expect(valid.ok and valid.level_id == "vertical_slice_delay_3", "direct-level parser extracts a catalog ID")
	for new_id in ["door_one_turn_late", "two_keys_one_door", "staggered_doors", "two_echo_convergence"]:
		var new_valid := RouteRequest.parse_user_args(["--level-id=" + new_id])
		_expect(new_valid.ok and new_valid.level_id == new_id, "direct-level parser accepts new catalog ID: " + new_id)
	_expect(not RouteRequest.parse_user_args(["--level-id=res://data/levels/x.json"]).ok, "direct-level parser rejects filesystem paths")
	_expect(not RouteRequest.parse_user_args(["--level-id=a", "--level-id=b"]).ok, "direct-level parser rejects duplicate requests")


func _test_loader() -> void:
	var minimal := loader.load_file("res://docs/level_design/examples/level_v1_minimal_valid.json")
	_expect(minimal.ok, "accepted minimal example loads")
	var vertical := loader.load_file("res://data/levels/vertical_slice_delay_3.json")
	_expect(vertical.ok, "vertical slice loads")
	_expect_code(loader.load_file("res://tests/does_not_exist.json"), "JSON_PARSE_ERROR", "unreadable JSON fails safely")
	if not minimal.ok:
		return
	var base: Dictionary = minimal.level
	var value := base.duplicate(true)
	value["surprise"] = true
	_expect_code(loader.validate_dict(value), "SCHEMA_SHAPE_ERROR", "unknown top-level field")
	value = base.duplicate(true); value.schema_version = 2
	_expect_code(loader.validate_dict(value), "UNSUPPORTED_SCHEMA_VERSION", "unsupported version")
	value = base.duplicate(true); value.terrain_rows[1] = "#..#"
	_expect_code(loader.validate_dict(value), "RAGGED_TERRAIN", "ragged terrain")
	value = base.duplicate(true); value.player_spawn = [63, 63]
	_expect_code(loader.validate_dict(value), "OUT_OF_BOUNDS", "out of bounds")
	value = base.duplicate(true); value.player_spawn = [0, 0]
	_expect_code(loader.validate_dict(value), "NOT_FLOOR", "non-floor placement")
	value = base.duplicate(true); value.echoes.append(value.echoes[0].duplicate(true))
	_expect_code(loader.validate_dict(value), "DUPLICATE_ID", "duplicate ID")
	value = base.duplicate(true); value.exit.position = value.plates[0].position.duplicate()
	_expect_code(loader.validate_dict(value), "STATIC_POSITION_OVERLAP", "static overlap")
	value = base.duplicate(true); value.player_spawn = value.doors[0].position.duplicate()
	_expect_code(loader.validate_dict(value), "ACTOR_ON_FORBIDDEN_STATIC", "spawn on door")
	value = base.duplicate(true); value.player_spawn = value.exit.position.duplicate()
	_expect_code(loader.validate_dict(value), "ACTOR_ON_FORBIDDEN_STATIC", "spawn on exit")
	value = base.duplicate(true); value.doors[0].all_plate_ids = ["missing_plate"]
	_expect_code(loader.validate_dict(value), "UNKNOWN_PLATE_REFERENCE", "unknown plate reference")
	value = base.duplicate(true); value.doors[0].all_plate_ids = ["plate_entry", "plate_entry"]
	_expect_code(loader.validate_dict(value), "DUPLICATE_PLATE_REFERENCE", "duplicate plate reference")
	value = base.duplicate(true); value.doors[0].initial_open = true
	_expect_code(loader.validate_dict(value), "INITIAL_DOOR_STATE_MISMATCH", "initial door mismatch")
	value = base.duplicate(true); value.echoes = []; value.metadata.allow_zero_echo_tutorial = false
	_expect_code(loader.validate_dict(value), "ECHO_REQUIRED", "zero echo policy")
	value = base.duplicate(true); value.echoes[0]["unknown"] = 1
	_expect_code(loader.validate_dict(value), "SCHEMA_SHAPE_ERROR", "unknown entity field")


func _test_vectors() -> void:
	var file := FileAccess.open("res://docs/level_design/reference/turn_transition_vectors_v1.json", FileAccess.READ)
	var parsed = JSON.parse_string(file.get_as_text())
	var fixtures := {}
	for fixture in parsed.fixtures:
		fixtures[fixture.id] = fixture
	_expect(parsed.vectors.size() == 9, "exactly nine normative vectors")
	for vector in parsed.vectors:
		var level: Dictionary = fixtures[vector.fixture_id].duplicate(true)
		level.echoes.sort_custom(func(a, b): return a.id < b.id)
		level.doors.sort_custom(func(a, b): return a.id < b.id)
		var result: Dictionary
		if vector.operation == "RESTART":
			result = simulation.restart(level)
		else:
			result = simulation.transition(level, vector.input_state, vector.player_input)
		_expect(result.ok, vector.id + " executes")
		if not result.ok:
			continue
		_expect(result.actor_actions == vector.expected.actor_actions, vector.id + " actor actions")
		_expect(result.state.player_position == vector.expected.player_position, vector.id + " player position")
		_expect(result.state.echo_positions == vector.expected.echo_positions, vector.id + " echo positions")
		_expect(result.pressed_plate_ids == vector.expected.pressed_plate_ids, vector.id + " pressed plates")
		_expect(result.state.door_states == vector.expected.door_states, vector.id + " door states")
		_expect(result.state.history == vector.expected.history, vector.id + " history")
		_expect(result.state.turn_index == vector.expected.turn_index, vector.id + " turn index")
		_expect(result.state.completed == vector.expected.completed, vector.id + " completion")
		_expect(result.canonical_key == vector.expected.canonical_key, vector.id + " canonical key")
		if vector.has("precondition_assertions"):
			_expect(simulation.canonical_key(vector.input_state) == vector.precondition_assertions.input_canonical_key, vector.id + " input key")
			_expect(simulation.canonical_key(vector.precondition_assertions.comparison_state) == vector.precondition_assertions.comparison_canonical_key, vector.id + " comparison key")
			_expect(simulation.canonical_key(vector.input_state) != simulation.canonical_key(vector.precondition_assertions.comparison_state), vector.id + " history identity")


func _test_determinism_and_errors() -> void:
	var loaded := loader.load_file("res://data/levels/vertical_slice_delay_3.json")
	if not loaded.ok:
		return
	var level: Dictionary = loaded.level
	var actions := ["RIGHT", "RIGHT", "UP", "WAIT", "WAIT", "RIGHT", "RIGHT", "RIGHT", "RIGHT"]
	var first := simulation.replay(level, actions)
	var second := simulation.replay(level, actions)
	_expect(first.ok and second.ok and first.canonical_keys == second.canonical_keys, "deterministic canonical trace")
	var initial := simulation.construct_initial_state(level)
	var blocked := simulation.transition(level, initial, "LEFT")
	_expect(blocked.ok and blocked.state.history[-1] == "LEFT", "blocked cardinal input remains in history")
	var restarted := simulation.restart(level)
	_expect(restarted.state == initial, "restart reconstructs exact initial state")
	var invalid := simulation.transition(level, initial, "up")
	_expect(not invalid.ok and invalid.status == "INVALID_ACTION" and invalid.state == initial, "invalid action has no mutation")
	var completed: Dictionary = first.state
	_expect(completed.completed, "known replay completes")
	var terminal := simulation.transition(level, completed, "WAIT")
	_expect(not terminal.ok and terminal.status == "TERMINAL_STATE" and terminal.state == completed, "completed state is terminal without mutation")
	var malformed: Dictionary = initial.duplicate(true)
	malformed.door_states = ["bad"]
	var invalid_state := simulation.transition(level, malformed, "WAIT")
	_expect(not invalid_state.ok and invalid_state.status == "INVALID_STATE" and invalid_state.state == malformed, "malformed supplied state fails without mutation")


func _test_solver() -> void:
	var loaded := loader.load_file("res://data/levels/vertical_slice_delay_3.json")
	if not loaded.ok:
		return
	var limits := {"depth_limit": 64, "state_limit": 100000, "time_limit_ms": 10000, "solution_count_cap": 1000000}
	var result := Solver.new().solve(loaded.level, limits)
	_expect(result.status == "SOLVED", "vertical slice solver status")
	_expect(result.status == "SOLVED" and result.shortest_turn_count == 9 and result.shortest_solution_count == 31 and result.shortest_solution_count_status == "EXACT" and result.visited_states == 1318 and result.maximum_frontier == 393, "vertical slice accepted metrics remain exact")
	if result.status != "SOLVED":
		return
	var replay := simulation.replay(loaded.level, result.solution)
	_expect(replay.ok and replay.state.completed, "shortest solution replays to completion")
	_expect(result.solution.size() == result.shortest_turn_count, "replay length equals L star")
	_expect(result.shortest_solution_count_status == "EXACT" and result.shortest_solution_count > 0, "shortest count is exact")
	var capped_limits: Dictionary = limits.duplicate(true)
	capped_limits.solution_count_cap = 1
	var capped := Solver.new().solve(loaded.level, capped_limits)
	_expect(capped.status == "SOLVED" and capped.shortest_solution_count == 1 and capped.shortest_solution_count_status == "CAPPED", "solver count cap is reported as capped")
	var cooperation := false
	for index in result.solution.size():
		if index == 0:
			continue
		var before: Dictionary = replay.transitions[index - 1].state
		var after: Dictionary = replay.transitions[index].state
		if before.door_states[0].open and before.player_position != loaded.level.plates[0].position and before.echo_positions[0].position == loaded.level.plates[0].position and after.player_position == loaded.level.doors[0].position:
			cooperation = true
	_expect(cooperation, "solution enters door from echo-only start-of-turn plate occupancy")
	var isolated_data: Dictionary = loaded.level.duplicate(true)
	isolated_data.echoes[0].spawn = [6, 2]
	var isolated := loader.validate_dict(isolated_data)
	_expect(isolated.ok, "isolated-echo mechanic variant is schema valid")
	if isolated.ok:
		var isolated_result := Solver.new().solve(isolated.level, limits)
		_expect(isolated_result.status == "UNSOLVABLE_WITHIN_COMPLETE_FINITE_STATE", "isolated echo variant exhausts unsolved")
		_expect(isolated_result.visited_states == 1006, "vertical slice isolated-Echo accepted visited-state metric remains exact")
		result["mechanic_variant_status"] = isolated_result.status
		result["mechanic_variant_visited_states"] = isolated_result.visited_states
	print("SOLVER_RESULT=" + JSON.stringify(result))


func _test_timeline_model_contract() -> void:
	var model_builder = TimelineModel.new()
	var zero_loaded := loader.load_file("res://data/levels/tutorial_reach_exit.json")
	var zero_state := simulation.construct_initial_state(zero_loaded.level)
	var zero_model: Dictionary = model_builder.build(zero_loaded.level, zero_state, simulation)
	_expect(not zero_model.visible and zero_model.slots.is_empty() and zero_model.echo_pointers.is_empty(), "zero-Echo state produces no timeline")
	var tutorial_loaded := loader.load_file("res://data/levels/tutorial_echo_bridge.json")
	var level_before: Dictionary = tutorial_loaded.level.duplicate(true)
	var state := simulation.construct_initial_state(tutorial_loaded.level)
	var state_before: Dictionary = state.duplicate(true)
	var model: Dictionary = model_builder.build(tutorial_loaded.level, state, simulation)
	_expect(model.visible and model.max_delay == 3 and model.slots.size() == 3 and model.slots.map(func(slot): return slot.action) == ["WAIT", "WAIT", "WAIT"], "Tutorial 1 timeline contains three oldest-to-newest slots")
	_expect(model.echo_pointers.size() == 1 and model.echo_pointers[0].history_index == 0 and model.echo_pointers[0].slot_number == 1 and model.echo_pointers[0].action == "WAIT", "delay-max Echo points to the oldest slot and next action")
	_expect(tutorial_loaded.level == level_before and state == state_before, "timeline construction does not mutate level or state")
	var blocked := simulation.transition(tutorial_loaded.level, state, "LEFT")
	var blocked_model: Dictionary = model_builder.build(tutorial_loaded.level, blocked.state, simulation)
	_expect(blocked.ok and blocked.state.player_position == state.player_position and blocked_model.slots[2].action == "LEFT", "blocked cardinal input remains its original action in the timeline")
	var synthetic_level: Dictionary = tutorial_loaded.level.duplicate(true)
	synthetic_level.echoes = [
		{"id": "echo_delay_2", "delay": 2, "spawn": [1, 1]},
		{"id": "echo_delay_4", "delay": 4, "spawn": [1, 1]},
	]
	var synthetic_state: Dictionary = state.duplicate(true)
	synthetic_state.history = ["UP", "RIGHT", "DOWN", "LEFT"]
	var synthetic_model: Dictionary = model_builder.build(synthetic_level, synthetic_state, simulation)
	_expect(synthetic_model.echo_pointers[0].history_index == 2 and synthetic_model.echo_pointers[0].action == "DOWN" and synthetic_model.echo_pointers[1].history_index == 0 and synthetic_model.echo_pointers[1].action == "UP", "synthetic multi-delay pointers use distinct accepted history indices and actions")
	_expect(model_builder.compact_text(model).contains("oldest") and model_builder.expanded_text(model).contains("pointer") and model_builder.expanded_text(model).contains("Blocked moves"), "compact and expanded timeline explanations agree on order and pointers")
	_expect(simulation.echo_history_index_for_state(tutorial_loaded.level, state, "echo_delay_3") == 0 and simulation.echo_action_for_state(tutorial_loaded.level, state, "echo_delay_3") == "WAIT", "shared history-index query and action lookup agree")


func _test_scene_smoke() -> void:
	var packed = load("res://scenes/vertical_slice/vertical_slice.tscn")
	_expect(packed is PackedScene, "main scene resource loads")
	if not packed is PackedScene:
		return
	var scene = packed.instantiate()
	root.add_child(scene)
	await process_frame
	_expect(scene.is_runtime_ready(), "main scene instantiates and connects logic/HUD")
	_expect(scene.has_method("get_hud_snapshot"), "main scene exposes a testable player-facing HUD snapshot")
	if scene.has_method("get_hud_snapshot"):
		var hud_snapshot: Dictionary = scene.get_hud_snapshot()
		var hud_text := JSON.stringify(hud_snapshot)
		_expect(hud_text.contains("YOU") and hud_text.contains("ECHO") and hud_text.contains("PLATE") and hud_text.contains("DOOR") and hud_text.contains("EXIT"), "normal HUD explicitly identifies every puzzle entity")
		var objective: String = hud_snapshot.get("objective", "")
		_expect(objective.contains("GOAL") and objective.contains("Move YOU") and objective.contains("not ECHO") and objective.contains("EXIT"), "standard HUD entry objective preserves player-only completion")
		_expect(hud_snapshot.echo_next.is_empty() and not hud_snapshot.history.contains("History") and hud_snapshot.timeline_model.echo_pointers[0].action == "WAIT", "standard HUD uses the compact timeline without duplicate History or Echo-next prose")
		for ignored in 3:
			_send_scene_action(scene, "move_right")
		var progressed: Dictionary = scene.get_hud_snapshot()
		_expect(progressed.timeline_model.echo_pointers[0].action == "RIGHT" and progressed.objective.contains("H: Help"), "timeline pointer follows accepted history and standard objective collapses")
		var key_before_help: String = progressed.canonical_key
		var turn_before_help: int = progressed.turn_index
		_send_help_key(scene)
		var expanded: Dictionary = scene.get_hud_snapshot()
		_expect(expanded.help_expanded and expanded.timeline.contains("pointer") and expanded.canonical_key == key_before_help and expanded.turn_index == turn_before_help, "expanded standard help restores explanation without advancing the world")
		_send_help_key(scene)
		_send_scene_action(scene, "restart_level")
		var restarted_hud: Dictionary = scene.get_hud_snapshot()
		_expect(restarted_hud.timeline_model.echo_pointers[0].action == "WAIT" and restarted_hud.disclosure.objective_collapsed, "restart restores logical timeline while retaining session disclosure")
		for action in ["move_right", "move_right", "move_up", "move_up", "move_up", "move_right", "move_right", "move_right", "move_right"]:
			_send_scene_action(scene, action)
		var completion_status: String = scene.get_hud_snapshot().get("status", "")
		_expect(completion_status.contains("COMPLETE") and completion_status.contains("YOU reached EXIT") and completion_status.contains("Press R to restart"), "completion HUD names the player-only success and restart action")
	scene.queue_free()
	await process_frame


func _test_tutorial_zero_gameplay_tracer() -> void:
	var packed = load("res://scenes/vertical_slice/vertical_slice.tscn")
	var scene = packed.instantiate()
	var configured: bool = scene.configure_route_payload({"level_id": "tutorial_reach_exit", "level_path": "res://data/levels/tutorial_reach_exit.json", "hud_mode": "INTRO_MINIMAL", "classification": "tutorial", "development_direct": true, "final_level": false})
	_expect(configured, "reusable gameplay accepts a validated Tutorial 0 payload before tree entry")
	root.add_child(scene)
	await process_frame
	_expect(scene.is_runtime_ready() and scene.state.echo_positions.is_empty() and scene.state.door_states.is_empty(), "Tutorial 0 reusable gameplay becomes ready with zero Echoes and zero Doors")
	var hud: Dictionary = scene.get_hud_snapshot()
	var visible_text := "%s %s %s %s %s %s" % [hud.status, hud.objective, hud.legend, hud.timeline, hud.echo_next, hud.history]
	_expect(hud.objective.contains("YOU") and hud.objective.contains("EXIT") and not visible_text.contains("ECHO") and not visible_text.contains("PLATE") and not visible_text.contains("DOOR") and not visible_text.contains("Echo next") and not visible_text.contains("History") and not visible_text.contains("Wait"), "Tutorial 0 HUD exposes only its relevant movement and EXIT teaching content")
	_expect(not hud.timeline_model.visible and hud.history.contains("Arrows/WASD") and hud.history.contains("Restart"), "Tutorial 0 initially shows controls and no timeline")
	_send_scene_action(scene, "move_up")
	var progressed: Dictionary = scene.get_hud_snapshot()
	_expect(progressed.disclosure.controls_collapsed and not progressed.history.contains("Arrows/WASD"), "Tutorial 0 first legal action collapses full controls")
	var key_before_help: String = progressed.canonical_key
	_send_help_key(scene)
	var helped: Dictionary = scene.get_hud_snapshot()
	_expect(helped.help_expanded and helped.history.contains("Arrows/WASD") and helped.objective.contains("Only YOU") and helped.canonical_key == key_before_help, "Tutorial 0 help restores objective and controls without a world turn")
	_send_help_key(scene)
	_send_scene_action(scene, "restart_level")
	_expect(scene.state == simulation.construct_initial_state(scene.level) and scene.get_hud_snapshot().disclosure.controls_collapsed, "Tutorial 0 restart is exact and retains session disclosure")
	for action in ["move_up", "move_right", "move_right"]:
		_send_scene_action(scene, action)
	_expect(scene.get_hud_snapshot().completion.contains("YOU reached EXIT"), "Tutorial 0 completion remains prominent and player-specific")
	scene.queue_free()
	await process_frame


func _test_tutorial_one_gameplay_tracer() -> void:
	var packed = load("res://scenes/vertical_slice/vertical_slice.tscn")
	var scene = packed.instantiate()
	var configured: bool = scene.configure_route_payload({"level_id": "tutorial_echo_bridge", "level_path": "res://data/levels/tutorial_echo_bridge.json", "hud_mode": "GUIDED_ECHO", "classification": "tutorial", "development_direct": true, "final_level": false})
	_expect(configured, "reusable gameplay accepts a validated Tutorial 1 payload before tree entry")
	root.add_child(scene)
	await process_frame
	var hud: Dictionary = scene.get_hud_snapshot()
	var visible_text := JSON.stringify(hud)
	_expect(scene.is_runtime_ready() and scene.state.echo_positions.size() == 1 and scene.state.door_states.size() == 1, "Tutorial 1 reusable gameplay becomes ready with one Echo and one Door")
	_expect(visible_text.contains("YOU") and visible_text.contains("ECHO") and visible_text.contains("PLATE") and visible_text.contains("DOOR") and visible_text.contains("EXIT") and visible_text.contains("Echo delay: 3") and hud.echo_next.is_empty() and hud.timeline_model.echo_pointers[0].action == "WAIT", "Tutorial 1 initially exposes roles, delay, causality, and compact next-action timeline")
	for action in ["move_right", "move_right", "move_up"]:
		_send_scene_action(scene, action)
	_expect(not scene.get_hud_snapshot().disclosure.legend_collapsed, "Tutorial 1 legend remains full before the first visible Echo replay")
	_send_scene_action(scene, "move_down")
	var replayed: Dictionary = scene.get_hud_snapshot()
	_expect(replayed.disclosure.legend_collapsed and replayed.legend.begins_with("KEY"), "first visible non-WAIT Echo replay collapses the full legend")
	_send_scene_action(scene, "move_left")
	var plate_state: Dictionary = scene.get_hud_snapshot()
	_expect(plate_state.disclosure.causality_collapsed and plate_state.objective.contains("ECHO holds PLATE") and plate_state.objective.contains("YOU reaches EXIT"), "Echo-held Plate door change collapses causality copy to one line")
	var key_before_help: String = plate_state.canonical_key
	var turn_before_help: int = plate_state.turn_index
	_send_help_key(scene)
	var helped: Dictionary = scene.get_hud_snapshot()
	_expect(helped.help_expanded and helped.legend.contains("ENTITY KEY") and helped.timeline.contains("Blocked moves") and helped.canonical_key == key_before_help and helped.turn_index == turn_before_help, "Tutorial 1 expanded help restores legend and timeline explanation without advancing")
	_send_help_key(scene)
	_send_scene_action(scene, "restart_level")
	var restarted: Dictionary = scene.get_hud_snapshot()
	_expect(scene.state == simulation.construct_initial_state(scene.level) and restarted.disclosure.legend_collapsed and restarted.disclosure.causality_collapsed, "Tutorial 1 restart is exact and keeps earned disclosure flags")
	scene.queue_free()
	await process_frame


func _test_task_0011_presentation_recovery() -> void:
	var packed = load("res://scenes/vertical_slice/vertical_slice.tscn")
	var guided = packed.instantiate()
	guided.configure_route_payload({"level_id": "tutorial_echo_bridge", "level_path": "res://data/levels/tutorial_echo_bridge.json", "hud_mode": "GUIDED_ECHO", "classification": "tutorial", "development_direct": true, "final_level": false})
	root.add_child(guided)
	await process_frame
	var guided_snapshot: Dictionary = guided.get_presentation_snapshot()
	_expect(guided_snapshot.cell_pitch == 60 and guided_snapshot.board_zone == Rect2(24, 84, 540, 420) and guided_snapshot.board_zone.encloses(guided_snapshot.board_rect), "Task 0011 guided board uses accepted 60 px geometry")
	_expect(guided_snapshot.timeline_visible and guided_snapshot.surfaces.timeline.visible, "Task 0011 guided Timeline remains visible")
	_expect(guided_snapshot.surfaces.objective.font_size >= 18 and guided_snapshot.surfaces.status.font_size >= 22 and guided_snapshot.surfaces.legend.font_size >= 16 and guided_snapshot.surfaces.help_body.font_size >= 18, "Task 0011 minimum font sizes are measurable")
	var guided_before: Dictionary = guided.state.duplicate(true)
	var guided_key: String = guided.get_hud_snapshot().canonical_key
	_send_help_key(guided)
	_send_scene_action(guided, "move_right")
	_send_scene_action(guided, "wait_turn")
	_send_scene_action(guided, "restart_level")
	_expect(guided.state == guided_before and guided.get_hud_snapshot().canonical_key == guided_key, "Task 0011 modal Help blocks movement WAIT and restart without state mutation")
	_send_scene_action(guided, "ui_cancel")
	_expect(not guided.get_hud_snapshot().help_expanded, "Task 0011 Esc closes Help before route exit")
	_send_scene_action(guided, "move_right")
	_expect(guided.state.turn_index == guided_before.turn_index + 1, "Task 0011 input returns after Help close")
	guided.queue_free()
	await process_frame

	var standard = packed.instantiate()
	standard.configure_route_payload({"level_id": "vertical_slice_delay_3", "level_path": "res://data/levels/vertical_slice_delay_3.json", "hud_mode": "STANDARD_COMPACT", "classification": "standard", "development_direct": true, "final_level": false})
	root.add_child(standard)
	await process_frame
	var standard_snapshot: Dictionary = standard.get_presentation_snapshot()
	_expect(not standard_snapshot.timeline_visible and not standard_snapshot.surfaces.timeline.visible, "Task 0011 simple standard Timeline is contextually hidden")
	_expect(standard.timeline_visible_for({"echoes": [{"id": "a", "delay": 3}, {"id": "b", "delay": 3}]}, "STANDARD_COMPACT", false), "Task 0011 multiple Echoes trigger Timeline")
	_expect(standard.timeline_visible_for({"echoes": [{"id": "a", "delay": 2}, {"id": "b", "delay": 3}]}, "STANDARD_COMPACT", false), "Task 0011 distinct delays trigger Timeline")
	_expect(standard.timeline_visible_for({"echoes": [{"id": "a", "delay": 4}]}, "STANDARD_COMPACT", false), "Task 0011 delay four triggers Timeline")
	standard.queue_free()
	await process_frame

	var timing = packed.instantiate()
	timing.configure_route_payload({"level_id": "door_one_turn_late", "level_path": "res://data/levels/door_one_turn_late.json", "hud_mode": "STANDARD_COMPACT", "classification": "standard", "development_direct": true, "final_level": false})
	root.add_child(timing)
	await process_frame
	for action in ["move_right", "move_right", "move_up", "move_up", "move_up"]:
		_send_scene_action(timing, action)
	var timing_snapshot: Dictionary = timing.get_presentation_snapshot()
	_expect(timing_snapshot.blocked_door.visible and timing_snapshot.blocked_door.visual_state == "X_STOP_NOTCH", "Task 0011 Level 4 critical trace shows blocked-Door feedback")
	_expect(timing_snapshot.echo_trails.size() == 1 and timing_snapshot.echo_trails[0].echo_id == "echo_delay_2", "Task 0011 Level 4 critical trace shows accepted Echo replay")
	_expect(timing_snapshot.plates[0].visual_state == "FILLED_PRESSED" and timing_snapshot.doors[0].visual_state == "HOLLOW_OPEN" and timing_snapshot.doors[0].dependency_pips[0].active, "Task 0011 Level 4 critical trace shows Plate dependency and open aperture")
	_expect(timing_snapshot.teaching_badge.visible and timing_snapshot.teaching_badge.text == "OPEN · NEXT INPUT", "Task 0011 Level 4 first open commit shows bounded badge")
	_send_scene_action(timing, "move_right")
	var entry_snapshot: Dictionary = timing.get_presentation_snapshot()
	_expect(timing.state.player_position == [4, 3] and not entry_snapshot.teaching_badge.visible and entry_snapshot.doors[0].occupied_by.has("YOU") and entry_snapshot.doors[0].actor_identity_visible, "Task 0011 next input enters from open snapshot and preserves actor identity through closure")
	timing.queue_free()
	await process_frame

	var and_level = packed.instantiate()
	and_level.configure_route_payload({"level_id": "two_keys_one_door", "level_path": "res://data/levels/two_keys_one_door.json", "hud_mode": "STANDARD_COMPACT", "classification": "standard", "development_direct": true, "final_level": false})
	root.add_child(and_level)
	await process_frame
	for action in ["move_right", "move_right", "move_right", "move_right", "move_up", "move_up", "move_right"]:
		_send_scene_action(and_level, action)
	var and_snapshot: Dictionary = and_level.get_presentation_snapshot()
	_expect(and_snapshot.doors[0].dependency_pips.map(func(pip): return pip.plate_id) == ["plate_echo", "plate_you"] and and_snapshot.doors[0].dependency_pips.all(func(pip): return pip.active), "Task 0011 Level 5 shows two stable active AND pips")
	_send_scene_action(and_level, "restart_level")
	for action in ["move_right", "move_right", "move_right", "move_right", "move_up", "move_up", "move_right", "move_right", "move_up", "move_up", "move_left", "move_left"]:
		_send_scene_action(and_level, action)
	var replay := simulation.replay(and_level.level, ["RIGHT", "RIGHT", "RIGHT", "RIGHT", "UP", "UP", "RIGHT", "RIGHT", "UP", "UP", "LEFT", "LEFT"])
	_expect(replay.ok and and_level.state == replay.state and and_level.state.completed, "Task 0011 Approach A rapid input preserves exact action order count and result")
	and_level.queue_free()
	await process_frame

	var reduced = packed.instantiate()
	reduced.configure_route_payload({"level_id": "door_one_turn_late", "level_path": "res://data/levels/door_one_turn_late.json", "hud_mode": "STANDARD_COMPACT", "classification": "standard", "development_direct": true, "final_level": false})
	root.add_child(reduced)
	await process_frame
	reduced.set_reduced_motion_for_test(true)
	for action in ["move_right", "move_right", "move_up", "move_up", "move_up"]:
		_send_scene_action(reduced, action)
	var reduced_snapshot: Dictionary = reduced.get_presentation_snapshot()
	_expect(reduced_snapshot.reduced_motion and reduced_snapshot.echo_trails[0].visual_state == "STATIC_SEGMENTS" and reduced_snapshot.doors[0].visual_state == "HOLLOW_OPEN" and reduced_snapshot.teaching_badge.visible, "Task 0011 reduced motion preserves static semantic feedback")
	var level_before: Dictionary = reduced.level.duplicate(true)
	var state_before: Dictionary = reduced.state.duplicate(true)
	reduced.get_presentation_snapshot()
	_expect(reduced.level == level_before and reduced.state == state_before, "Task 0011 presentation snapshots do not mutate level or state")
	reduced.queue_free()
	await process_frame


func _test_gameplay_configuration_failure() -> void:
	var packed = load("res://scenes/vertical_slice/vertical_slice.tscn")
	var scene = packed.instantiate()
	var configured: bool = scene.configure_route_payload({"level_id": "tutorial_echo_bridge", "level_path": "res://data/levels/tutorial_reach_exit.json", "hud_mode": "GUIDED_ECHO", "classification": "tutorial", "development_direct": true, "final_level": false})
	_expect(configured, "reusable gameplay accepts a structurally valid pre-tree payload for parity checking")
	root.add_child(scene)
	await process_frame
	_expect(not scene.is_runtime_ready() and scene.load_error == "LEVEL_ID_MISMATCH" and scene.level.is_empty() and scene.state.is_empty(), "formal ID mismatch fails without partial Gameplay state")
	scene.queue_free()
	await process_frame


func _test_app_shell_tracer() -> void:
	var packed = load("res://scenes/app/app_root.tscn")
	_expect(packed is PackedScene, "app root scene resource loads")
	if not packed is PackedScene:
		return
	var app = packed.instantiate()
	root.add_child(app)
	await process_frame
	_expect(app.get_current_route() == "MAIN_MENU" and app.get_active_screen_count() == 1, "valid catalog boots to one Main Menu screen")
	app.navigate("LEVEL_SELECT")
	await process_frame
	_expect(app.get_current_route() == "LEVEL_SELECT" and app.get_active_screen_count() == 1, "Main Menu intent routes to one Level Select screen")
	var select_snapshot: Dictionary = app.get_active_screen().get_screen_snapshot()
	_expect(select_snapshot.entries.size() == 7 and select_snapshot.entries[0].level_id == "tutorial_reach_exit" and select_snapshot.entries[0].unlocked and select_snapshot.entries.slice(1).all(func(entry): return not entry.unlocked), "Level Select initially unlocks only Tutorial 0 in seven-entry sorted catalog order")
	app.select_level("vertical_slice_delay_3")
	await process_frame
	_expect(app.get_current_route() == "SAFE_ERROR" and app.get_active_screen().get_screen_snapshot().error_code == "APP_LEVEL_LOCKED", "locked vertical slice reaches Safe Error without Gameplay state")
	app.navigate("LEVEL_SELECT")
	await process_frame
	app.select_level("tutorial_reach_exit")
	await process_frame
	var gameplay = app.get_active_screen()
	_expect(app.get_current_route() == "GAMEPLAY" and gameplay.is_runtime_ready() and gameplay.get_route_payload().hud_mode == "INTRO_MINIMAL", "Tutorial 0 catalog selection routes through reusable Gameplay")
	for action in ["UP", "RIGHT", "RIGHT"]:
		_send_simulation_action(gameplay, action)
	await process_frame
	var progress_snapshot: Dictionary = app.get_progress_snapshot()
	_expect(app.get_current_route() == "LEVEL_SELECT" and progress_snapshot.completed_level_ids == ["tutorial_reach_exit"] and progress_snapshot.best_turns.tutorial_reach_exit == 3 and progress_snapshot.unlocked_level_ids == ["tutorial_echo_bridge", "tutorial_reach_exit"], "Tutorial 0 completion unlocks only Tutorial 1 and records three turns")
	app.select_level("tutorial_echo_bridge")
	await process_frame
	gameplay = app.get_active_screen()
	_expect(app.get_current_route() == "GAMEPLAY" and gameplay.is_runtime_ready() and gameplay.get_route_payload().hud_mode == "GUIDED_ECHO", "Tutorial 1 catalog selection routes through the same reusable Gameplay implementation")
	for action in ["RIGHT", "RIGHT", "UP", "DOWN", "LEFT", "DOWN", "DOWN", "RIGHT", "RIGHT"]:
		_send_simulation_action(gameplay, action)
	await process_frame
	progress_snapshot = app.get_progress_snapshot()
	_expect(app.get_current_route() == "LEVEL_SELECT" and progress_snapshot.completed_level_ids == ["tutorial_echo_bridge", "tutorial_reach_exit"] and progress_snapshot.best_turns.tutorial_echo_bridge == 9 and progress_snapshot.unlocked_level_ids == ["tutorial_echo_bridge", "tutorial_reach_exit", "vertical_slice_delay_3"], "Tutorial 1 completion unlocks the vertical slice and records nine turns")
	app.select_level("vertical_slice_delay_3")
	await process_frame
	gameplay = app.get_active_screen()
	_expect(app.get_current_route() == "GAMEPLAY" and gameplay.is_runtime_ready() and gameplay.get_route_payload().hud_mode == "STANDARD_COMPACT", "unlocked vertical slice routes through the same reusable Gameplay implementation")
	for action in ["RIGHT", "RIGHT", "UP", "UP", "UP", "RIGHT", "RIGHT", "RIGHT", "RIGHT"]:
		_send_simulation_action(gameplay, action)
	await process_frame
	progress_snapshot = app.get_progress_snapshot()
	_expect(app.get_current_route() == "LEVEL_SELECT" and progress_snapshot.completed_level_ids == ["tutorial_echo_bridge", "tutorial_reach_exit", "vertical_slice_delay_3"] and progress_snapshot.unlocked_level_ids == ["door_one_turn_late", "tutorial_echo_bridge", "tutorial_reach_exit", "vertical_slice_delay_3"], "vertical slice completion unlocks only Level 4")
	app.select_level("door_one_turn_late")
	await process_frame
	gameplay = app.get_active_screen()
	_expect(app.get_current_route() == "GAMEPLAY" and gameplay.is_runtime_ready() and gameplay.get_route_payload().level_id == "door_one_turn_late" and gameplay.get_route_payload().hud_mode == "STANDARD_COMPACT", "Level 4 routes through the same reusable Gameplay implementation")
	for action in ["RIGHT", "RIGHT", "UP", "UP", "RIGHT", "RIGHT", "RIGHT", "UP", "UP"]:
		_send_simulation_action(gameplay, action)
	await process_frame
	progress_snapshot = app.get_progress_snapshot()
	_expect(app.get_current_route() == "LEVEL_SELECT" and progress_snapshot.completed_level_ids == ["door_one_turn_late", "tutorial_echo_bridge", "tutorial_reach_exit", "vertical_slice_delay_3"] and progress_snapshot.unlocked_level_ids == ["door_one_turn_late", "tutorial_echo_bridge", "tutorial_reach_exit", "two_keys_one_door", "vertical_slice_delay_3"], "Level 4 completion unlocks only Level 5")
	app.select_level("two_keys_one_door")
	await process_frame
	gameplay = app.get_active_screen()
	_expect(app.get_current_route() == "GAMEPLAY" and gameplay.is_runtime_ready() and gameplay.get_route_payload().level_id == "two_keys_one_door" and not gameplay.get_route_payload().final_level and gameplay.get_route_payload().hud_mode == "STANDARD_COMPACT", "Level 5 routes through the same reusable Gameplay implementation and is no longer final")
	for action in ["RIGHT", "RIGHT", "RIGHT", "RIGHT", "UP", "UP", "RIGHT", "RIGHT", "UP", "UP", "LEFT", "LEFT"]:
		_send_simulation_action(gameplay, action)
	await process_frame
	progress_snapshot = app.get_progress_snapshot()
	_expect(app.get_current_route() == "LEVEL_SELECT" and progress_snapshot.completed_level_ids == ["door_one_turn_late", "tutorial_echo_bridge", "tutorial_reach_exit", "two_keys_one_door", "vertical_slice_delay_3"] and progress_snapshot.best_turns.two_keys_one_door == 12 and progress_snapshot.unlocked_level_ids.has("staggered_doors"), "Level 5 completion unlocks Level 6 through normal AppRoot flow")
	app.select_level("staggered_doors")
	await process_frame
	gameplay = app.get_active_screen()
	_expect(app.get_current_route() == "GAMEPLAY" and gameplay.is_runtime_ready() and gameplay.get_route_payload().level_id == "staggered_doors" and not gameplay.get_route_payload().final_level and gameplay.get_route_payload().hud_mode == "STANDARD_COMPACT", "Level 6 routes through reusable Gameplay and is no longer final")
	for action in ["UP", "RIGHT", "RIGHT", "DOWN", "UP", "RIGHT", "RIGHT", "RIGHT", "RIGHT", "UP", "UP", "UP", "LEFT", "LEFT", "LEFT"]:
		_send_simulation_action(gameplay, action)
	await process_frame
	progress_snapshot = app.get_progress_snapshot()
	_expect(app.get_current_route() == "LEVEL_SELECT" and progress_snapshot.completed_level_ids == ["door_one_turn_late", "staggered_doors", "tutorial_echo_bridge", "tutorial_reach_exit", "two_keys_one_door", "vertical_slice_delay_3"] and progress_snapshot.best_turns.staggered_doors == 15 and progress_snapshot.unlocked_level_ids.has("two_echo_convergence"), "normal AppRoot flow completes Level 6 and unlocks exactly Level 7")
	app.select_level("two_echo_convergence")
	await process_frame
	gameplay = app.get_active_screen()
	_expect(app.get_current_route() == "GAMEPLAY" and gameplay.is_runtime_ready() and gameplay.get_route_payload().level_id == "two_echo_convergence" and gameplay.get_route_payload().final_level and gameplay.get_route_payload().hud_mode == "STANDARD_COMPACT", "Level 7 routes through reusable Gameplay as sole catalog final")
	for action in ["RIGHT", "RIGHT", "RIGHT", "RIGHT", "RIGHT", "RIGHT", "UP", "UP", "UP", "LEFT", "RIGHT", "DOWN", "DOWN", "UP", "DOWN", "UP", "UP", "UP", "UP"]:
		_send_simulation_action(gameplay, action)
	await process_frame
	progress_snapshot = app.get_progress_snapshot()
	_expect(app.get_current_route() == "LEVEL_SELECT" and progress_snapshot.completed_level_ids.has("two_echo_convergence") and progress_snapshot.best_turns.two_echo_convergence == 19, "normal AppRoot flow completes and records all seven levels without adding a final-flow surface")
	app.navigate("UNKNOWN_ROUTE")
	await process_frame
	_expect(app.get_current_route() == "SAFE_ERROR" and app.get_active_screen().get_screen_snapshot().error_code == "APP_UNKNOWN_ROUTE" and app.get_active_screen_count() == 1, "unknown route reaches one Safe Error screen")
	app.select_level("unknown_level")
	await process_frame
	_expect(app.get_current_route() == "SAFE_ERROR" and app.get_active_screen().get_screen_snapshot().error_code == "APP_UNKNOWN_LEVEL_ID", "unknown level ID reaches Safe Error")
	app.queue_free()
	await process_frame

	var invalid_app = packed.instantiate()
	invalid_app.catalog_path = "res://tests/app/invalid_catalog_json.json"
	root.add_child(invalid_app)
	await process_frame
	_expect(invalid_app.get_current_route() == "SAFE_ERROR" and invalid_app.get_catalog_snapshot().is_empty() and invalid_app.get_active_screen_count() == 1, "invalid catalog boots only Safe Error with no partial app state")
	invalid_app.queue_free()
	await process_frame

	var direct_app = packed.instantiate()
	root.add_child(direct_app)
	await process_frame
	for direct_id in ["tutorial_reach_exit", "tutorial_echo_bridge", "vertical_slice_delay_3", "door_one_turn_late", "two_keys_one_door", "staggered_doors", "two_echo_convergence"]:
		direct_app.boot_with_user_args(["--level-id=" + direct_id])
		await process_frame
		_expect(direct_app.get_current_route() == "GAMEPLAY" and direct_app.get_active_screen().get_route_payload().development_direct and direct_app.get_active_screen().get_route_payload().level_id == direct_id and direct_app.get_active_screen_count() == 1, "validated development level ID boots directly to one reusable Gameplay: " + direct_id)
	direct_app.boot_with_user_args(["--level-id=unknown_level"])
	await process_frame
	_expect(direct_app.get_current_route() == "SAFE_ERROR" and direct_app.get_active_screen().get_screen_snapshot().error_code == "APP_UNKNOWN_LEVEL_ID", "unknown development level ID reaches Safe Error")
	direct_app.queue_free()
	await process_frame


func _test_task_0011r_window_fill() -> void:
	_expect(ProjectSettings.get_setting("display/window/size/viewport_width") == 960 and ProjectSettings.get_setting("display/window/size/viewport_height") == 540, "Task 0011R keeps the exact 960x540 logical reference")
	_expect(ProjectSettings.get_setting("display/window/stretch/mode") == "canvas_items" and ProjectSettings.get_setting("display/window/stretch/aspect") == "keep", "Task 0011R uses built-in uniform keep-aspect canvas scaling")
	var exact: Dictionary = WindowPresentation.content_transform(Vector2i(1280, 720))
	var wide: Dictionary = WindowPresentation.content_transform(Vector2i(1440, 720))
	var tall: Dictionary = WindowPresentation.content_transform(Vector2i(1280, 800))
	_expect(exact.content_rect == Rect2(0, 0, 1280, 720) and is_equal_approx(exact.scale, 4.0 / 3.0), "Task 0011R exact 16:9 client fills with zero offset")
	_expect(wide.content_rect == Rect2(80, 0, 1280, 720) and wide.bars.left == wide.bars.right and wide.bars.top == 0.0 and wide.bars.bottom == 0.0, "Task 0011R wide client uses symmetric pillarboxing")
	_expect(tall.content_rect == Rect2(0, 40, 1280, 720) and tall.bars.top == tall.bars.bottom and tall.bars.left == 0.0 and tall.bars.right == 0.0, "Task 0011R tall client uses symmetric letterboxing")
	_expect(WindowPresentation.content_transform(Vector2i(1280, 800)) == tall, "Task 0011R resize transform is deterministic and idempotent")

	var packed = load("res://scenes/app/app_root.tscn")
	var app = packed.instantiate()
	root.add_child(app)
	await process_frame
	_expect(RenderingServer.get_default_clear_color() == WindowPresentation.BAR_COLOR, "Task 0011R exposed bars use the intentional dark project background")
	var menu_policy: Dictionary = app.get_window_presentation_snapshot(Vector2i(1440, 720))
	_expect(menu_policy.logical_size == Vector2(960, 540) and menu_policy.content_rect == wide.content_rect and app.get_active_screen().get_parent() == app.route_host, "Task 0011R Main Menu uses the shared full-client host policy")
	app.navigate("LEVEL_SELECT")
	await process_frame
	_expect(app.get_window_presentation_snapshot(Vector2i(1440, 720)).content_rect == menu_policy.content_rect and app.get_active_screen().get_parent() == app.route_host, "Task 0011R Level Select retains the shared host policy")
	app.boot_with_user_args(["--level-id=two_keys_one_door"])
	await process_frame
	var gameplay = app.get_active_screen()
	_send_scene_action(gameplay, "move_right")
	_send_help_key(gameplay)
	var before_state: Dictionary = gameplay.state.duplicate(true)
	var before_key: String = gameplay.get_hud_snapshot().canonical_key
	DisplayServer.window_set_size(Vector2i(1280, 800))
	await process_frame
	await process_frame
	_expect(gameplay.state == before_state and gameplay.get_hud_snapshot().canonical_key == before_key, "Task 0011R resize does not transition or mutate canonical gameplay")
	_expect(gameplay.get_hud_snapshot().help_expanded and gameplay.get_parent() == app.route_host, "Task 0011R Help remains open inside the shared Gameplay host after resize")
	var presentation: Dictionary = gameplay.get_presentation_snapshot()
	_expect(presentation.viewport == Rect2(0, 0, 960, 540) and presentation.surfaces.help.rect == Rect2(96, 54, 768, 432), "Task 0011R accepted logical board HUD and Help geometry remains unchanged")
	app.navigate("UNKNOWN_ROUTE")
	await process_frame
	_expect(app.get_window_presentation_snapshot(Vector2i(1280, 800)).content_rect == tall.content_rect and app.get_active_screen().get_parent() == app.route_host, "Task 0011R Safe Error retains the shared centered host policy")
	DisplayServer.window_set_size(Vector2i(960, 540))
	app.queue_free()
	await process_frame


func _send_scene_action(scene: Node, action: String) -> void:
	var event := InputEventAction.new()
	event.action = action
	event.pressed = true
	scene._unhandled_input(event)


func _send_help_key(scene: Node) -> void:
	var event := InputEventKey.new()
	event.keycode = KEY_H
	event.pressed = true
	scene._unhandled_input(event)


func _send_simulation_action(scene: Node, action: String) -> void:
	var input_actions := {"UP": "move_up", "RIGHT": "move_right", "DOWN": "move_down", "LEFT": "move_left", "WAIT": "wait_turn"}
	_send_scene_action(scene, input_actions[action])


func _expect_code(result: Dictionary, code: String, label: String) -> void:
	var codes: Array = []
	for error in result.errors:
		codes.append(error.code)
	_expect(not result.ok and result.status == "INVALID_LEVEL" and codes.has(code), label + " returns " + code)


func _expect_catalog_code(result: Dictionary, code: String, label: String) -> void:
	var codes: Array = []
	for error in result.errors:
		codes.append(error.code)
	_expect(not result.ok and result.status == "INVALID_CATALOG" and result.catalog.is_empty() and codes.has(code), label + " returns " + code + " without a partial catalog")


func _expect(condition: bool, label: String) -> void:
	assertions += 1
	if not condition:
		failures += 1
		printerr("TEST_FAIL: " + label)

extends SceneTree

const LevelLoader = preload("res://scripts/simulation/level_loader.gd")
const Simulation = preload("res://scripts/simulation/simulation.gd")
const Solver = preload("res://scripts/solver/bfs_solver.gd")

var failures := 0
var loader := LevelLoader.new()
var simulation := Simulation.new()


func _init() -> void:
	call_deferred("_run")


func _run() -> void:
	_test_door_one_turn_late()
	_test_two_keys_one_door_contract()
	if failures > 0:
		printerr("TASK_0009AR_FOCUSED_FAIL failures=%d" % failures)
		quit(1)
	else:
		print("TASK_0009AR_FOCUSED_PASS")
		quit(0)


func _test_door_one_turn_late() -> void:
	var loaded := loader.load_file("res://data/levels/door_one_turn_late.json")
	_require(loaded.ok, "Level 4 loads through the unchanged LevelLoader")
	if not loaded.ok:
		return
	var level: Dictionary = loaded.level
	_require(level.level_id == "door_one_turn_late", "Level 4 formal ID")
	_require(level.echoes.size() == 1 and level.echoes[0].delay == 2, "Level 4 has exactly one delay-2 Echo")
	_require(level.plates.size() == 1 and level.doors.size() == 1 and level.doors[0].all_plate_ids == [level.plates[0].id], "Level 4 has one Plate and one dependent Door")
	var limits := {"depth_limit": 24, "state_limit": 100000, "time_limit_ms": 10000, "solution_count_cap": 1000000}
	var solved := Solver.new().solve(level, limits)
	_require(solved.status == "SOLVED" and solved.shortest_turn_count >= 7 and solved.shortest_turn_count <= 12, "Level 4 solver result is inside the authorized band")
	if solved.status != "SOLVED":
		return
	var replay := simulation.replay(level, solved.solution)
	_require(replay.ok and replay.state.completed and replay.transitions.size() == solved.shortest_turn_count, "Level 4 solver witness replays to completion")
	var timing_trace: Dictionary = {}
	var before := simulation.construct_initial_state(level)
	for index in replay.transitions.size() - 1:
		var after: Dictionary = replay.transitions[index].state
		var next_after: Dictionary = replay.transitions[index + 1].state
		if not before.door_states[0].open and before.player_position != level.doors[0].position and after.player_position == before.player_position and after.echo_positions[0].position == level.plates[0].position and after.door_states[0].open and next_after.player_position == level.doors[0].position:
			timing_trace = {
				"closed_snapshot_action_index": index,
				"closed_snapshot_start": before,
				"closed_snapshot_action": solved.solution[index],
				"open_result": after,
				"open_snapshot_entry_action": solved.solution[index + 1],
				"entry_result": next_after,
			}
			break
		before = after
	_require(not timing_trace.is_empty(), "Level 4 has the exact closed-snapshot/open-result then open-snapshot/entry trace")
	var no_echo_data: Dictionary = level.duplicate(true)
	no_echo_data.echoes = []
	no_echo_data.metadata.allow_zero_echo_tutorial = true
	var no_echo := loader.validate_dict(no_echo_data)
	var no_echo_solved := Solver.new().solve(no_echo.level, limits) if no_echo.ok else {"status": "INVALID_LEVEL"}
	_require(no_echo.ok and no_echo_solved.status == "UNSOLVABLE_WITHIN_COMPLETE_FINITE_STATE", "Level 4 no-Echo state space is complete unsolved with no Door bypass")
	var echo_on_exit := simulation.construct_initial_state(level)
	echo_on_exit.echo_positions[0].position = level.exit.position.duplicate()
	var echo_only := simulation.transition(level, echo_on_exit, "WAIT")
	_require(echo_only.ok and not echo_only.state.completed, "Level 4 Echo on EXIT cannot complete")
	_require(simulation.restart(level).state == simulation.construct_initial_state(level), "Level 4 restart is exact")
	print("DOOR_ONE_TURN_LATE_VALIDATION=" + JSON.stringify({
		"loader_status": loaded.status,
		"solver": solved,
		"replay_status": replay.status,
		"completed_state": replay.state,
		"timing_trace": timing_trace,
		"no_echo_variant": no_echo_solved,
		"player_bypass": "NONE_WITHOUT_ECHO_COMPLETE_STATE_SPACE",
		"echo_on_exit_completed": echo_only.state.completed,
		"restart_exact": simulation.restart(level).state == simulation.construct_initial_state(level),
	}))


func _test_two_keys_one_door_contract() -> void:
	var loaded := loader.load_file("res://data/levels/two_keys_one_door.json")
	_require(loaded.ok, "Level 5 loads through the unchanged LevelLoader")
	if not loaded.ok:
		return
	var level: Dictionary = loaded.level
	_require(level.level_id == "two_keys_one_door", "Level 5 formal ID")
	_require(level.echoes.size() == 1 and level.echoes[0].delay == 3, "Level 5 has exactly one delay-3 Echo")
	_require(level.plates.size() == 2 and level.plates[0].id != level.plates[1].id, "Level 5 has two distinct Plates")
	_require(level.doors.size() == 1 and level.doors[0].all_plate_ids == level.plates.map(func(plate): return plate.id), "Level 5 Door is an AND dependency on both normalized Plate IDs")
	var limits := {"depth_limit": 32, "state_limit": 500000, "time_limit_ms": 20000, "solution_count_cap": 1000000}
	var solved := Solver.new().solve(level, limits)
	_require(solved.status == "SOLVED" and solved.shortest_turn_count >= 11 and solved.shortest_turn_count <= 18, "Level 5 solver result is inside the authorized band")
	if solved.status != "SOLVED":
		return
	var replay := simulation.replay(level, solved.solution)
	_require(replay.ok and replay.state.completed and replay.transitions.size() == solved.shortest_turn_count, "Level 5 solver witness replays to completion")
	var and_trace: Dictionary = {}
	var before := simulation.construct_initial_state(level)
	for index in replay.transitions.size() - 1:
		var after: Dictionary = replay.transitions[index].state
		var next_after: Dictionary = replay.transitions[index + 1].state
		var actors_on_distinct_plates: bool = (
			after.player_position == level.plates[0].position and after.echo_positions[0].position == level.plates[1].position
		) or (
			after.player_position == level.plates[1].position and after.echo_positions[0].position == level.plates[0].position
		)
		if actors_on_distinct_plates and after.door_states[0].open and next_after.player_position == level.doors[0].position:
			and_trace = {
				"simultaneous_action_index": index,
				"simultaneous_result": after,
				"pressed_plate_ids": replay.transitions[index].pressed_plate_ids,
				"open_snapshot_entry_action": solved.solution[index + 1],
				"entry_result": next_after,
			}
			break
		before = after
	_require(not and_trace.is_empty() and and_trace.pressed_plate_ids == level.plates.map(func(plate): return plate.id), "Level 5 witness presses both Plates with separate actors and then enters from an open snapshot")
	var no_echo_data: Dictionary = level.duplicate(true)
	no_echo_data.echoes = []
	no_echo_data.metadata.allow_zero_echo_tutorial = true
	var no_echo := loader.validate_dict(no_echo_data)
	var no_echo_solved := Solver.new().solve(no_echo.level, limits) if no_echo.ok else {"status": "INVALID_LEVEL"}
	_require(no_echo.ok and no_echo_solved.status == "UNSOLVABLE_WITHIN_COMPLETE_FINITE_STATE", "Level 5 no-Echo state space is complete unsolved with no Door bypass")
	var relocation_results := {}
	for plate_id in ["plate_echo", "plate_you"]:
		var relocated_data: Dictionary = level.duplicate(true)
		for plate in relocated_data.plates:
			if plate.id == plate_id:
				plate.position = [6, 1]
		var relocated := loader.validate_dict(relocated_data)
		var relocated_solved := Solver.new().solve(relocated.level, limits) if relocated.ok else {"status": "INVALID_LEVEL"}
		relocation_results[plate_id] = relocated_solved
		_require(relocated.ok and relocated_solved.status == "UNSOLVABLE_WITHIN_COMPLETE_FINITE_STATE", "Level 5 relocation beyond the Door makes %s dependency complete unsolved" % plate_id)
	var single_dependency_results := {}
	for plate_id in ["plate_echo", "plate_you"]:
		var single_data: Dictionary = level.duplicate(true)
		single_data.doors[0].all_plate_ids = [plate_id]
		var single := loader.validate_dict(single_data)
		var single_solved := Solver.new().solve(single.level, limits) if single.ok else {"status": "INVALID_LEVEL"}
		single_dependency_results[plate_id] = single_solved
		_require(single.ok and single_solved.status == "SOLVED", "Level 5 single-%s Door variant demonstrates the AND dependency matters" % plate_id)
	var echo_on_exit := simulation.construct_initial_state(level)
	echo_on_exit.echo_positions[0].position = level.exit.position.duplicate()
	var echo_only := simulation.transition(level, echo_on_exit, "WAIT")
	_require(echo_only.ok and not echo_only.state.completed, "Level 5 Echo on EXIT cannot complete")
	_require(simulation.restart(level).state == simulation.construct_initial_state(level), "Level 5 restart is exact")
	print("TWO_KEYS_ONE_DOOR_VALIDATION=" + JSON.stringify({
		"loader_status": loaded.status,
		"solver": solved,
		"replay_status": replay.status,
		"completed_state": replay.state,
		"and_trace": and_trace,
		"no_echo_variant": no_echo_solved,
		"relocated_plate_variants": relocation_results,
		"single_dependency_variants": single_dependency_results,
		"player_bypass": "NONE_WITHOUT_ECHO_COMPLETE_STATE_SPACE",
		"overlap_audit": "OPEN_AND_STATE_REQUIRES_TWO_DISTINCT_PLATE_POSITIONS",
		"echo_on_exit_completed": echo_only.state.completed,
		"restart_exact": simulation.restart(level).state == simulation.construct_initial_state(level),
	}))


func _require(condition: bool, label: String) -> void:
	if not condition:
		failures += 1
		printerr("TASK_0009AR_FAIL: " + label)

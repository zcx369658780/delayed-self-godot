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
	_validate_tutorial_zero()
	_validate_tutorial_one()
	if failures > 0:
		printerr("TASK_0007_TUTORIAL_VALIDATION_FAIL failures=%d" % failures)
		quit(1)
	else:
		print("TASK_0007_TUTORIAL_VALIDATION_PASS")
		quit(0)


func _validate_tutorial_zero() -> void:
	var loaded := loader.load_file("res://data/levels/tutorial_reach_exit.json")
	_require(loaded.ok, "Tutorial 0 loader")
	if not loaded.ok:
		return
	var limits := {"depth_limit": 12, "state_limit": 10000, "time_limit_ms": 10000, "solution_count_cap": 1000000}
	var solved := Solver.new().solve(loaded.level, limits)
	var replay := simulation.replay(loaded.level, solved.get("solution", []))
	var initial := simulation.construct_initial_state(loaded.level)
	var restart := simulation.restart(loaded.level)
	_require(solved.status == "SOLVED" and replay.ok and replay.state.completed, "Tutorial 0 solve/replay")
	_require(restart.ok and restart.state == initial, "Tutorial 0 restart")
	print("TUTORIAL_0_VALIDATION=" + JSON.stringify({
		"loader_status": loaded.status,
		"solver": solved,
		"replay_status": replay.status,
		"completed_state": replay.state,
		"restart_exact": restart.state == initial,
		"cardinalities": {"echoes": loaded.level.echoes.size(), "plates": loaded.level.plates.size(), "doors": loaded.level.doors.size()},
	}))


func _validate_tutorial_one() -> void:
	var loaded := loader.load_file("res://data/levels/tutorial_echo_bridge.json")
	_require(loaded.ok, "Tutorial 1 loader")
	if not loaded.ok:
		return
	var level: Dictionary = loaded.level
	var limits := {"depth_limit": 64, "state_limit": 100000, "time_limit_ms": 10000, "solution_count_cap": 1000000}
	var solved := Solver.new().solve(level, limits)
	var replay := simulation.replay(level, solved.get("solution", []))
	_require(solved.status == "SOLVED" and replay.ok and replay.state.completed, "Tutorial 1 solve/replay")
	var cooperation_trace: Dictionary = {}
	var before := simulation.construct_initial_state(level)
	for index in replay.transitions.size():
		var transition: Dictionary = replay.transitions[index]
		var after: Dictionary = transition.state
		if before.door_states[0].open and before.echo_positions[0].position == level.plates[0].position and before.player_position != level.plates[0].position and after.player_position == level.doors[0].position:
			cooperation_trace = {"action_index": index, "start_state": before, "action": solved.solution[index], "result_state": after}
		before = after
	_require(not cooperation_trace.is_empty(), "Tutorial 1 Echo-only Plate Door entry trace")
	var no_echo_data: Dictionary = level.duplicate(true)
	no_echo_data.echoes = []
	no_echo_data.metadata.allow_zero_echo_tutorial = true
	var no_echo := loader.validate_dict(no_echo_data)
	var no_echo_solved := Solver.new().solve(no_echo.level, limits) if no_echo.ok else {"status": "INVALID_LEVEL"}
	_require(no_echo.ok and no_echo_solved.status == "UNSOLVABLE_WITHIN_COMPLETE_FINITE_STATE", "Tutorial 1 no-Echo complete finite-state necessity")
	var echo_on_exit := simulation.construct_initial_state(level)
	echo_on_exit.echo_positions[0].position = level.exit.position.duplicate()
	var echo_only := simulation.transition(level, echo_on_exit, "WAIT")
	_require(echo_only.ok and not echo_only.state.completed, "Tutorial 1 Echo-only EXIT cannot complete")
	var restart := simulation.restart(level)
	_require(restart.ok and restart.state == simulation.construct_initial_state(level), "Tutorial 1 restart")
	print("TUTORIAL_1_VALIDATION=" + JSON.stringify({
		"loader_status": loaded.status,
		"solver": solved,
		"replay_status": replay.status,
		"completed_state": replay.state,
		"restart_exact": restart.state == simulation.construct_initial_state(level),
		"cooperation_trace": cooperation_trace,
		"no_echo_variant": no_echo_solved,
		"player_bypass": "NONE_WITHOUT_ECHO_COMPLETE_STATE_SPACE",
		"echo_on_exit_completed": echo_only.state.completed,
	}))


func _require(condition: bool, label: String) -> void:
	if not condition:
		failures += 1
		printerr("VALIDATION_FAIL: " + label)

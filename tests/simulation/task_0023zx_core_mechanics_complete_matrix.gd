extends SceneTree

const Loader = preload("res://scripts/simulation/level_loader.gd")
const Simulation = preload("res://scripts/simulation/simulation.gd")
const Solver = preload("res://scripts/solver/bfs_solver.gd")

var failures := 0
var loader := Loader.new()
var simulation := Simulation.new()

func _init() -> void:
	_run()

func _run() -> void:
	_test_v1_vectors()
	_test_formal_levels()
	_test_v2_fixtures()
	if failures > 0:
		printerr("TASK_0023ZX_COMPLETE_MATRIX_FAIL failures=%d" % failures)
		quit(1)
	else:
		print("TASK_0023ZX_COMPLETE_MATRIX_PASS")
		quit(0)

func _test_v1_vectors() -> void:
	var parsed = JSON.parse_string(FileAccess.open("res://docs/level_design/reference/turn_transition_vectors_v1.json", FileAccess.READ).get_as_text())
	var fixtures := {}
	for fixture in parsed.fixtures: fixtures[fixture.id] = fixture
	for vector in parsed.vectors:
		var level: Dictionary = fixtures[vector.fixture_id].duplicate(true)
		level.echoes.sort_custom(func(a, b): return a.id < b.id)
		level.doors.sort_custom(func(a, b): return a.id < b.id)
		var result = simulation.restart(level) if vector.operation == "RESTART" else simulation.transition(level, vector.input_state, vector.player_input)
		_require(result.ok and result.canonical_key == vector.expected.canonical_key, "v1 vector " + vector.id)

func _test_formal_levels() -> void:
	var paths := ["tutorial_reach_exit", "tutorial_echo_bridge", "vertical_slice_delay_3", "door_one_turn_late", "two_keys_one_door", "staggered_doors", "echo_spacing_bridge", "two_echo_convergence"]
	for id in paths:
		var loaded := loader.load_file("res://data/levels/%s.json" % id)
		_require(loaded.ok, id + " loader")
		if not loaded.ok: continue
		var initial := simulation.construct_initial_state(loaded.level)
		_require(simulation.restart(loaded.level).state == initial, id + " restart")
		var result := Solver.new().solve(loaded.level, {"depth_limit":64,"state_limit":500000,"time_limit_ms":30000,"solution_count_cap":1000000})
		_require(result.status == "SOLVED" and result.shortest_solution_count_status in ["EXACT", "CAPPED"], id + " solver")
		if result.status == "SOLVED":
			var replay := simulation.replay(loaded.level, result.solution)
			_require(replay.ok and replay.state.completed, id + " replay")

func _test_v2_fixtures() -> void:
	for id in ["crate_echo", "key_lock", "sensor_barrier", "latch_defer", "integration"]:
		var loaded := loader.load_file("res://tests/simulation/fixtures/task_0023zx_%s.json" % id)
		_require(loaded.ok and simulation.restart(loaded.level).state == simulation.construct_initial_state(loaded.level), "v2 " + id)

func _require(condition: bool, label: String) -> void:
	if not condition:
		failures += 1
		printerr("TASK_0023ZX_COMPLETE_ASSERT_FAIL " + label)

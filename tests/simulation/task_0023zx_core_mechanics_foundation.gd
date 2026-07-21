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
	var fixtures := ["crate_echo", "key_lock", "sensor_barrier", "latch_defer", "integration"]
	for name in fixtures:
		var loaded := loader.load_file("res://tests/simulation/fixtures/task_0023zx_%s.json" % name)
		_require(loaded.ok, name + " loader")
		if loaded.ok:
			var initial := simulation.construct_initial_state(loaded.level)
			_require(simulation.restart(loaded.level).state == initial, name + " restart")
			_require(not simulation.canonical_key(initial).is_empty(), name + " canonical")
	_test_crate()
	_test_key_lock()
	_test_sensor_latch()
	_test_malformed()
	if failures > 0:
		printerr("TASK_0023ZX_FAIL failures=%d" % failures)
		quit(1)
	else:
		print("TASK_0023ZX_PASS")
		quit(0)

func _level(name: String) -> Dictionary:
	return loader.load_file("res://tests/simulation/fixtures/task_0023zx_%s.json" % name).level

func _test_crate() -> void:
	var level := _level("crate_echo")
	var state := simulation.construct_initial_state(level)
	var pushed := simulation.transition(level, state, "RIGHT")
	_require(pushed.ok and pushed.state.player_position == [2, 1] and pushed.state.crate_positions[0].position == [3, 1], "YOU pushes one crate")
	var invalid := simulation.transition(level, pushed.state, "RIGHT")
	_require(invalid.ok and invalid.state.crate_positions[0].position == [4, 1], "second valid push")
	var changed: Dictionary = pushed.state.duplicate(true); changed.crate_positions[0].position = [4, 1]
	_require(simulation.canonical_key(pushed.state) != simulation.canonical_key(changed), "crate canonical distinction")

func _test_key_lock() -> void:
	var level := _level("key_lock")
	var state := simulation.construct_initial_state(level)
	var key := simulation.transition(level, state, "RIGHT")
	_require(key.ok and key.state.remaining_key_ids.is_empty() and key.state.held_keys == ["main"], "YOU collects key")
	var lock := simulation.transition(level, key.state, "RIGHT")
	_require(lock.ok and lock.state.player_position == [3, 1] and lock.state.held_keys.is_empty() and lock.state.removed_lock_ids == ["lock_a"], "same turn lock consumption")

func _test_sensor_latch() -> void:
	var sensor_level := _level("sensor_barrier")
	var sensor := simulation.transition(sensor_level, simulation.construct_initial_state(sensor_level), "RIGHT")
	_require(sensor.ok and sensor.pressed_sensor_ids == ["sensor_a"] and sensor.state.barrier_states[0].open, "YOU_ONLY sensor opens next turn")
	var latch_level := _level("latch_defer")
	var latch := simulation.transition(latch_level, simulation.construct_initial_state(latch_level), "RIGHT")
	_require(latch.ok and latch.state.latch_states[0].activated and latch.state.barrier_states[0].open, "occupied barrier defers latch closure")
	var changed: Dictionary = latch.state.duplicate(true); changed.latch_states[0].activated = false
	_require(simulation.canonical_key(latch.state) != simulation.canonical_key(changed), "latch canonical distinction")

func _test_malformed() -> void:
	var source := _level("key_lock").duplicate(true)
	source.schema_version = 2
	source.keys[0].unknown = true
	var invalid := loader.validate_dict(source)
	_require(not invalid.ok and invalid.status == "INVALID_LEVEL", "unknown v2 field fails atomically")

func _require(condition: bool, label: String) -> void:
	if not condition:
		failures += 1
		printerr("TASK_0023ZX_ASSERT_FAIL " + label)

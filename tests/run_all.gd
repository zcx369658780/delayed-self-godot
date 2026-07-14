extends SceneTree

const LevelLoader = preload("res://scripts/simulation/level_loader.gd")
const Simulation = preload("res://scripts/simulation/simulation.gd")
const Solver = preload("res://scripts/solver/bfs_solver.gd")

var failures := 0
var assertions := 0
var loader := LevelLoader.new()
var simulation := Simulation.new()


func _init() -> void:
	call_deferred("_run")


func _run() -> void:
	_test_loader()
	_test_vectors()
	_test_determinism_and_errors()
	_test_solver()
	await _test_scene_smoke()
	if failures > 0:
		printerr("TASK_0003_TESTS_FAIL failures=%d assertions=%d" % [failures, assertions])
		quit(1)
	else:
		print("TASK_0003_TESTS_PASS assertions=%d vectors=9" % assertions)
		quit(0)


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
		result["mechanic_variant_status"] = isolated_result.status
		result["mechanic_variant_visited_states"] = isolated_result.visited_states
	print("SOLVER_RESULT=" + JSON.stringify(result))


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
		_expect(objective.contains("GOAL") and objective.contains("Move YOU") and objective.contains("EXIT") and objective.contains("ECHO") and objective.contains("cannot finish") and objective.contains("hold the PLATE") and objective.contains("YOU can cross the DOOR"), "normal HUD explains the player-only goal and intended echo causality")
		_expect(hud_snapshot.get("echo_next", "") == "Echo next: WAIT", "initial HUD explicitly identifies the next echo action")
		for ignored in 3:
			_send_scene_action(scene, "move_right")
		_expect(scene.get_hud_snapshot().get("echo_next", "") == "Echo next: RIGHT", "next echo action follows the oldest relevant history entry")
		_send_scene_action(scene, "restart_level")
		var restarted_hud: Dictionary = scene.get_hud_snapshot()
		_expect(restarted_hud.get("echo_next", "") == "Echo next: WAIT" and restarted_hud.get("objective", "") == objective, "restart restores the initial next action and normal objective")
		for action in ["move_right", "move_right", "move_up", "move_up", "move_up", "move_right", "move_right", "move_right", "move_right"]:
			_send_scene_action(scene, action)
		var completion_status: String = scene.get_hud_snapshot().get("status", "")
		_expect(completion_status.contains("COMPLETE") and completion_status.contains("YOU reached EXIT") and completion_status.contains("Press R to restart"), "completion HUD names the player-only success and restart action")
	scene.queue_free()
	await process_frame


func _send_scene_action(scene: Node, action: String) -> void:
	var event := InputEventAction.new()
	event.action = action
	event.pressed = true
	scene._unhandled_input(event)


func _expect_code(result: Dictionary, code: String, label: String) -> void:
	var codes: Array = []
	for error in result.errors:
		codes.append(error.code)
	_expect(not result.ok and result.status == "INVALID_LEVEL" and codes.has(code), label + " returns " + code)


func _expect(condition: bool, label: String) -> void:
	assertions += 1
	if not condition:
		failures += 1
		printerr("TEST_FAIL: " + label)

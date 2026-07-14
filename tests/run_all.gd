extends SceneTree

const LevelLoader = preload("res://scripts/simulation/level_loader.gd")
const Simulation = preload("res://scripts/simulation/simulation.gd")
const Solver = preload("res://scripts/solver/bfs_solver.gd")
const CatalogLoader = preload("res://scripts/app/catalog_loader.gd")
const ProgressStore = preload("res://scripts/app/memory_progress.gd")
const RouteRequest = preload("res://scripts/app/route_request.gd")

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
	_test_tracked_catalog()
	_test_catalog_failures()
	_test_memory_progress()
	_test_tracked_progress_chain_and_reset()
	_test_direct_level_parser()
	_test_loader()
	_test_vectors()
	_test_determinism_and_errors()
	_test_solver()
	await _test_scene_smoke()
	await _test_tutorial_zero_gameplay_tracer()
	await _test_tutorial_one_gameplay_tracer()
	await _test_gameplay_configuration_failure()
	await _test_app_shell_tracer()
	if failures > 0:
		printerr("TASK_0003_TESTS_FAIL failures=%d assertions=%d" % [failures, assertions])
		quit(1)
	else:
		print("TASK_0003_TESTS_PASS assertions=%d vectors=9" % assertions)
		print("TASK_0006_APP_SHELL_TESTS_PASS")
		print("TASK_0007_TUTORIAL_LEVELS_TESTS_PASS")
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
		result["no_echo_variant_status"] = no_echo_result.status
		result["no_echo_variant_visited_states"] = no_echo_result.visited_states
	var echo_on_exit := simulation.construct_initial_state(level)
	echo_on_exit.echo_positions[0].position = level.exit.position.duplicate()
	var echo_only_result := simulation.transition(level, echo_on_exit, "WAIT")
	_expect(echo_only_result.ok and not echo_only_result.state.completed, "Tutorial 1 Echo on EXIT cannot complete for the player")
	_expect(simulation.restart(level).state == simulation.construct_initial_state(level), "Tutorial 1 restart exactly reconstructs its initial state")
	print("TUTORIAL_1_SOLVER_RESULT=" + JSON.stringify(result))


func _test_tracked_catalog() -> void:
	var result := CatalogLoader.new().load_file("res://data/catalog/level_catalog_v1.json")
	_expect(result.ok and result.catalog.entries.size() == 3, "tracked three-entry catalog validates and normalizes")
	if result.ok and result.catalog.entries.size() == 3:
		var entries: Array = result.catalog.entries
		_expect(entries.map(func(entry): return entry.level_id) == ["tutorial_reach_exit", "tutorial_echo_bridge", "vertical_slice_delay_3"], "tracked catalog has the required Tutorial 0, Tutorial 1, vertical-slice sequence")
		_expect(entries[0].classification == "tutorial" and entries[0].hud_mode == "INTRO_MINIMAL" and entries[0].unlock_prerequisites.is_empty() and not entries[0].final_level, "Tutorial 0 catalog facts are exact")
		_expect(entries[1].classification == "tutorial" and entries[1].hud_mode == "GUIDED_ECHO" and entries[1].unlock_prerequisites == ["tutorial_reach_exit"] and not entries[1].final_level, "Tutorial 1 catalog facts are exact")
		_expect(entries[2].classification == "standard" and entries[2].hud_mode == "STANDARD_COMPACT" and entries[2].unlock_prerequisites == ["tutorial_echo_bridge"] and entries[2].final_level, "vertical-slice catalog facts remain exact and solely final")
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
	progress.reset_test_profile()
	_expect(progress.snapshot() == {"completed_level_ids": [], "best_turns": {}, "unlocked_level_ids": ["tutorial_reach_exit"]}, "tracked progress reset restores the exact initial unlock snapshot")


func _test_direct_level_parser() -> void:
	_expect(RouteRequest.parse_user_args([]).status == "NO_DIRECT_LEVEL", "direct-level parser accepts empty user arguments")
	var valid := RouteRequest.parse_user_args(["--level-id=vertical_slice_delay_3"])
	_expect(valid.ok and valid.level_id == "vertical_slice_delay_3", "direct-level parser extracts a catalog ID")
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


func _test_tutorial_zero_gameplay_tracer() -> void:
	var packed = load("res://scenes/vertical_slice/vertical_slice.tscn")
	var scene = packed.instantiate()
	var configured: bool = scene.configure_route_payload({"level_id": "tutorial_reach_exit", "level_path": "res://data/levels/tutorial_reach_exit.json", "hud_mode": "INTRO_MINIMAL", "classification": "tutorial", "development_direct": true, "final_level": false})
	_expect(configured, "reusable gameplay accepts a validated Tutorial 0 payload before tree entry")
	root.add_child(scene)
	await process_frame
	_expect(scene.is_runtime_ready() and scene.state.echo_positions.is_empty() and scene.state.door_states.is_empty(), "Tutorial 0 reusable gameplay becomes ready with zero Echoes and zero Doors")
	var hud: Dictionary = scene.get_hud_snapshot()
	var visible_text := "%s %s %s %s %s" % [hud.status, hud.objective, hud.legend, hud.echo_next, hud.history]
	_expect(hud.objective.contains("YOU") and hud.objective.contains("EXIT") and not visible_text.contains("ECHO") and not visible_text.contains("PLATE") and not visible_text.contains("DOOR") and not visible_text.contains("Echo next") and not visible_text.contains("History") and not visible_text.contains("Wait"), "Tutorial 0 HUD exposes only its relevant movement and EXIT teaching content")
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
	_expect(visible_text.contains("YOU") and visible_text.contains("ECHO") and visible_text.contains("PLATE") and visible_text.contains("DOOR") and visible_text.contains("EXIT") and visible_text.contains("Echo delay: 3") and hud.echo_next == "Echo next: WAIT" and hud.history.contains("History"), "Tutorial 1 GUIDED_ECHO HUD exposes roles, delay, history, and next action")
	scene.queue_free()
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
	_expect(select_snapshot.entries.size() == 3 and select_snapshot.entries[0].level_id == "tutorial_reach_exit" and select_snapshot.entries[0].unlocked and not select_snapshot.entries[1].unlocked and not select_snapshot.entries[2].unlocked, "Level Select initially unlocks only Tutorial 0 in sorted catalog order")
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
	for direct_id in ["tutorial_reach_exit", "tutorial_echo_bridge", "vertical_slice_delay_3"]:
		direct_app.boot_with_user_args(["--level-id=" + direct_id])
		await process_frame
		_expect(direct_app.get_current_route() == "GAMEPLAY" and direct_app.get_active_screen().get_route_payload().development_direct and direct_app.get_active_screen().get_route_payload().level_id == direct_id and direct_app.get_active_screen_count() == 1, "validated development level ID boots directly to one reusable Gameplay: " + direct_id)
	direct_app.boot_with_user_args(["--level-id=unknown_level"])
	await process_frame
	_expect(direct_app.get_current_route() == "SAFE_ERROR" and direct_app.get_active_screen().get_screen_snapshot().error_code == "APP_UNKNOWN_LEVEL_ID", "unknown development level ID reaches Safe Error")
	direct_app.queue_free()
	await process_frame


func _send_scene_action(scene: Node, action: String) -> void:
	var event := InputEventAction.new()
	event.action = action
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

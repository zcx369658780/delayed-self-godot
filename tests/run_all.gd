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
	_test_tracked_catalog()
	_test_catalog_failures()
	_test_memory_progress()
	_test_direct_level_parser()
	_test_loader()
	_test_vectors()
	_test_determinism_and_errors()
	_test_solver()
	await _test_scene_smoke()
	await _test_app_shell_tracer()
	if failures > 0:
		printerr("TASK_0003_TESTS_FAIL failures=%d assertions=%d" % [failures, assertions])
		quit(1)
	else:
		print("TASK_0003_TESTS_PASS assertions=%d vectors=9" % assertions)
		print("TASK_0006_APP_SHELL_TESTS_PASS")
		quit(0)


func _test_tracked_catalog() -> void:
	var result := CatalogLoader.new().load_file("res://data/catalog/level_catalog_v1.json")
	_expect(result.ok and result.catalog.entries.size() == 1 and result.catalog.entries[0].level_id == "vertical_slice_delay_3", "tracked catalog validates and normalizes")


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
	value = base.duplicate(true); value.entries[0].unlock_prerequisites = ["vertical_slice_delay_3"]
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
	value = base.duplicate(true); value.entries[0].final_level = false
	_expect_catalog_code(catalog_loader.validate_dict(value), "CATALOG_FINAL_COUNT_INVALID", "zero final catalog entries")
	value = base.duplicate(true); value.entries.append(value.entries[0].duplicate(true)); value.entries[1].level_id = "other"; value.entries[1].sequence = 2
	_expect_catalog_code(catalog_loader.validate_dict(value), "CATALOG_FINAL_COUNT_INVALID", "multiple final catalog entries")


func _cycle_catalog(base: Dictionary) -> Dictionary:
	var value: Dictionary = base.duplicate(true)
	value.entries[0].level_id = "cycle_a"
	value.entries[0].unlock_prerequisites = ["cycle_b"]
	value.entries[0].final_level = true
	var second: Dictionary = value.entries[0].duplicate(true)
	second.level_id = "cycle_b"
	second.sequence = 2
	second.unlock_prerequisites = ["cycle_a"]
	second.final_level = false
	value.entries.append(second)
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
	_expect(select_snapshot.entries.size() == 1 and select_snapshot.entries[0].level_id == "vertical_slice_delay_3" and select_snapshot.entries[0].unlocked, "Level Select exposes the sorted unlocked tracked catalog entry")
	app.select_level("vertical_slice_delay_3")
	await process_frame
	var gameplay = app.get_active_screen()
	_expect(app.get_current_route() == "GAMEPLAY" and gameplay.is_runtime_ready(), "validated catalog selection routes to ready Gameplay")
	var payload: Dictionary = gameplay.get_route_payload()
	_expect(payload.level_id == "vertical_slice_delay_3" and payload.level_path == "res://data/levels/vertical_slice_delay_3.json" and payload.hud_mode == "STANDARD_COMPACT", "Gameplay receives the expected normalized route payload")
	for action in ["move_right", "move_right", "move_up", "move_up", "move_up", "move_right", "move_right", "move_right", "move_right"]:
		_send_scene_action(gameplay, action)
	await process_frame
	var progress_snapshot: Dictionary = app.get_progress_snapshot()
	_expect(app.get_current_route() == "LEVEL_SELECT" and progress_snapshot.completed_level_ids == ["vertical_slice_delay_3"] and progress_snapshot.best_turns.vertical_slice_delay_3 == 9, "Gameplay completion updates memory progress and returns to Level Select")
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
	direct_app.boot_with_user_args(["--level-id=vertical_slice_delay_3"])
	await process_frame
	_expect(direct_app.get_current_route() == "GAMEPLAY" and direct_app.get_active_screen().get_route_payload().development_direct, "validated development level ID boots directly to Gameplay")
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

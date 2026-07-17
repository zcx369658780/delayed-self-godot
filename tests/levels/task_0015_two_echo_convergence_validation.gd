extends SceneTree

const LevelLoader = preload("res://scripts/simulation/level_loader.gd")
const Simulation = preload("res://scripts/simulation/simulation.gd")
const Solver = preload("res://scripts/solver/bfs_solver.gd")
const CatalogLoader = preload("res://scripts/app/catalog_loader.gd")
const ProgressStore = preload("res://scripts/app/memory_progress.gd")
const RouteRequest = preload("res://scripts/app/route_request.gd")
const GameplayScene = preload("res://scenes/vertical_slice/vertical_slice.tscn")

const ACTIONS := ["UP", "RIGHT", "DOWN", "LEFT", "WAIT"]
const LIMITS := {"depth_limit": 64, "state_limit": 500000, "time_limit_ms": 30000, "solution_count_cap": 1000000}
const EXPECTED_WITNESS := ["RIGHT", "RIGHT", "RIGHT", "RIGHT", "RIGHT", "RIGHT", "UP", "UP", "UP", "LEFT", "RIGHT", "DOWN", "DOWN", "UP", "DOWN", "UP", "UP", "UP", "UP"]

var failures := 0


func _init() -> void:
	call_deferred("_run")


func _run() -> void:
	var path := "res://data/levels/two_echo_convergence.json"
	var loaded := LevelLoader.new().load_file(path)
	_require(loaded.ok, "Level 7 strict formal JSON loads")
	if not loaded.ok:
		_finish()
		return
	var level: Dictionary = loaded.level
	_test_formal_contract(level)
	var solved := Solver.new().solve(level, LIMITS)
	_require(solved.status == "SOLVED", "Level 7 shared BFS returns SOLVED")
	_require(solved.get("shortest_turn_count") == 19 and solved.get("shortest_solution_count") == 6 and solved.get("shortest_solution_count_status") == "EXACT", "Level 7 exact L star and N star satisfy hard bands")
	_require(solved.get("visited_states") == 61975 and solved.get("maximum_frontier") == 21449 and solved.get("limits") == LIMITS, "Level 7 exact search burden and limits satisfy hard bands")
	_require(solved.get("solution") == EXPECTED_WITNESS and not solved.get("solution", []).has("WAIT"), "selected shortest witness is stable and contains no literal WAIT")
	if solved.status == "SOLVED":
		var replay := Simulation.new().replay(level, solved.solution)
		_require(replay.ok and replay.state.completed and replay.transitions.size() == 19, "shortest witness replays exactly to YOU completion")
		_test_convergence_trace(level, solved, replay)
		_test_all_shortest(level, solved)
		_test_decisions_and_recovery(level, solved, replay)
		await _test_runtime_and_presentation(level, solved)
	_test_controls(level, solved)
	_test_catalog_progression()
	print("TASK_0015_CANDIDATE_RESULT=" + JSON.stringify(solved))
	_finish()


func _finish() -> void:
	if failures > 0:
		printerr("TASK_0015_FOCUSED_FAIL failures=%d" % failures)
		quit(1)
	else:
		print("TASK_0015_LEVEL_7_TWO_ECHO_CONVERGENCE_TESTS_PASS")
		quit(0)


func _require(condition: bool, label: String) -> void:
	if not condition:
		failures += 1
		printerr("TASK_0015_FAIL: " + label)


func _test_formal_contract(level: Dictionary) -> void:
	_require(level.schema_version == 1 and level.level_id == "two_echo_convergence" and level.title == "Two Echo Convergence", "formal identity is exact")
	_require(level.terrain_rows.size() == 7 and level.terrain_rows.all(func(row): return row.length() == 9), "formal board is exactly 9 by 7")
	_require(level.player_spawn == [1, 5] and level.echoes.size() == 2 and level.echoes.all(func(echo): return echo.spawn == level.player_spawn), "YOU and both ECHOs share the declared spawn")
	_require(level.echoes.map(func(echo): return [echo.id, echo.delay]) == [["echo_late", 4], ["echo_near", 2]], "ECHO IDs and delay roles are exact after normalization")
	_require(level.plates.map(func(plate): return plate.id) == ["plate_a", "plate_b"], "formal level has exactly Plate A and Plate B")
	_require(level.doors.size() == 1 and level.doors[0].id == "door_convergence" and level.doors[0].all_plate_ids == ["plate_a", "plate_b"] and not level.doors[0].initial_open, "formal Door is the initially closed A+B AND articulation")
	_require(not level.metadata.allow_zero_echo_tutorial and level.validation.recommended_search_depth == 64, "formal metadata does not reopen zero-ECHO or WAIT teaching")
	_require(not _terrain_reaches_exit_without(level, level.doors[0].position), "Door terrain cell is an articulation on every YOU-to-EXIT route")


func _test_convergence_trace(level: Dictionary, solved: Dictionary, replay: Dictionary) -> void:
	var result_state: Dictionary = replay.transitions[16].state
	var crossing_start: Dictionary = result_state
	var crossing_result: Dictionary = replay.transitions[17].state
	var late: Dictionary = result_state.echo_positions.filter(func(echo): return echo.id == "echo_late")[0]
	var near: Dictionary = result_state.echo_positions.filter(func(echo): return echo.id == "echo_near")[0]
	_require(replay.transitions[16].actor_actions.echoes == [{"id": "echo_late", "action": "DOWN"}, {"id": "echo_near", "action": "DOWN"}], "critical ECHOs read the same history at exact delay-4 and delay-2 offsets")
	_require(late.position == [7, 5] and near.position == [6, 3] and replay.transitions[16].pressed_plate_ids == ["plate_a", "plate_b"], "critical result maps E4 to Plate B and E2 to Plate A simultaneously")
	_require(result_state.door_states[0].open and crossing_start.player_position == [7, 3], "A+B committed result opens Door with YOU on the approach")
	_require(solved.solution[17] == "UP" and crossing_result.player_position == level.doors[0].position, "following input starts open and moves YOU into Door")
	_require(not crossing_result.door_states[0].open and replay.state.completed, "Door may close around YOU before the later player-only EXIT completion")
	var two_echo_windows := 0
	for transition in replay.transitions:
		var echo_positions: Array = transition.state.echo_positions.map(func(echo): return echo.position)
		if transition.state.door_states[0].open and echo_positions.has([6, 3]) and echo_positions.has([7, 5]):
			two_echo_windows += 1
	_require(two_echo_windows == 1, "required simultaneous two-ECHO convergence window is exactly one result turn")
	print("TASK_0015_CRITICAL_TRACE=" + JSON.stringify(_critical_trace(level, solved, replay)))


func _test_all_shortest(level: Dictionary, solved: Dictionary) -> void:
	var simulation := Simulation.new()
	var initial := simulation.construct_initial_state(level)
	var initial_key := simulation.canonical_key(initial) + "|0"
	var queue := [initial_key]
	var states := {initial_key: initial}
	var depths := {initial_key: 0}
	var counts := {initial_key: 1}
	var event_masks := {initial_key: 0}
	var head := 0
	var goals := {0: 0, 1: 0}
	while head < queue.size():
		var key: String = queue[head]
		head += 1
		var depth: int = depths[key]
		if depth >= solved.shortest_turn_count:
			continue
		for action in ACTIONS:
			var transitioned := simulation.transition(level, states[key], action)
			if not transitioned.ok:
				continue
			var mask: int = event_masks[key]
			var echo_positions: Array = states[key].echo_positions.map(func(echo): return echo.position)
			if states[key].door_states[0].open and states[key].player_position != level.doors[0].position and transitioned.state.player_position == level.doors[0].position and echo_positions.has([6, 3]) and echo_positions.has([7, 5]):
				mask = 1
			var next_depth := depth + 1
			var next_key := simulation.canonical_key(transitioned.state) + "|" + str(mask)
			if not depths.has(next_key):
				depths[next_key] = next_depth
				states[next_key] = transitioned.state
				event_masks[next_key] = mask
				counts[next_key] = counts[key]
				queue.append(next_key)
			elif depths[next_key] == next_depth:
				counts[next_key] += counts[key]
			if transitioned.state.completed and next_depth == solved.shortest_turn_count:
				goals[mask] += counts[key]
	_require(goals[1] == solved.shortest_solution_count and goals[0] == 0, "all six exact shortest solutions use the two-ECHO A+B open-snapshot crossing")
	print("TASK_0015_ALL_SHORTEST_EVENT_COUNTS=" + JSON.stringify(goals))


func _test_decisions_and_recovery(level: Dictionary, solved: Dictionary, replay: Dictionary) -> void:
	var specs := [
		{"turn": 4, "alternative": "UP", "kind": "first_loop_branch", "penalty": 2},
		{"turn": 7, "alternative": "LEFT", "kind": "convergence_lane_approach", "penalty": 2},
		{"turn": 10, "alternative": "DOWN", "kind": "plate_role_crossover", "penalty": 5},
		{"turn": 11, "alternative": "LEFT", "kind": "recovery_loop_commitment", "penalty": 2},
		{"turn": 15, "alternative": "LEFT", "kind": "window_timing", "penalty": 3},
		{"turn": 16, "alternative": "LEFT", "kind": "door_approach_commitment", "penalty": 2},
	]
	var records := []
	for spec in specs:
		var action_index: int = spec.turn - 1
		var before: Dictionary = Simulation.new().construct_initial_state(level) if action_index == 0 else replay.transitions[action_index - 1].state
		var chosen := Simulation.new().transition(level, before, solved.solution[action_index])
		var alternative := Simulation.new().transition(level, before, spec.alternative)
		var search := _shortest_from_state(level, alternative.state, 48, 500000)
		var total: int = spec.turn + int(search.get("remaining_turns", 1000000))
		var penalty: int = total - solved.shortest_turn_count
		_require(chosen.ok and alternative.ok and Simulation.new().canonical_key(chosen.state) != Simulation.new().canonical_key(alternative.state), "decision turn %d has a distinct legal canonical successor" % spec.turn)
		_require(search.status == "SOLVED" and penalty == spec.penalty, "decision turn %d has the audited recoverable penalty" % spec.turn)
		records.append({"turn": spec.turn, "kind": spec.kind, "chosen": solved.solution[action_index], "alternative": spec.alternative, "minimum_penalty": penalty, "recoverable": search.status == "SOLVED"})
	_require(records.size() >= 4 and records.filter(func(item): return item.minimum_penalty >= 2 and item.minimum_penalty <= 6).size() >= 3, "audit records at least four meaningful decisions and three bounded recoveries")
	var blocked_inputs := []
	var before := Simulation.new().construct_initial_state(level)
	for index in replay.transitions.size():
		if solved.solution[index] != "WAIT" and replay.transitions[index].state.player_position == before.player_position:
			blocked_inputs.append({"turn": index + 1, "action": solved.solution[index], "position": before.player_position})
		before = replay.transitions[index].state
	_require(blocked_inputs == [{"turn": 9, "action": "UP", "position": [7, 3]}], "witness has one visible closed-Door probe and no repeated blocked-input macro")
	print("TASK_0015_DECISION_RECOVERY_AUDIT=" + JSON.stringify({"decisions": records, "blocked_inputs": blocked_inputs}))


func _shortest_from_state(level: Dictionary, start_state: Dictionary, depth_limit: int, state_limit: int) -> Dictionary:
	var simulation := Simulation.new()
	var start_key := simulation.canonical_key(start_state)
	var queue := [start_key]
	var states := {start_key: start_state}
	var depths := {start_key: 0}
	var head := 0
	while head < queue.size():
		var key: String = queue[head]
		head += 1
		var depth: int = depths[key]
		if depth >= depth_limit:
			continue
		for action in ACTIONS:
			var transitioned := simulation.transition(level, states[key], action)
			if not transitioned.ok:
				continue
			var next_depth := depth + 1
			if transitioned.state.completed:
				return {"status": "SOLVED", "remaining_turns": next_depth, "visited_states": states.size()}
			var next_key := simulation.canonical_key(transitioned.state)
			if states.has(next_key):
				continue
			if states.size() >= state_limit:
				return {"status": "STATE_LIMIT", "visited_states": states.size()}
			states[next_key] = transitioned.state
			depths[next_key] = next_depth
			queue.append(next_key)
	return {"status": "UNSOLVABLE_WITHIN_COMPLETE_FINITE_STATE", "visited_states": states.size()}


func _test_controls(level: Dictionary, solved: Dictionary) -> void:
	var controls := _controls(level)
	for key in ["only_echo_near", "only_echo_late", "no_echo", "relocate_plate_a", "relocate_plate_b", "equal_2", "equal_4"]:
		_require(controls[key].status == "UNSOLVABLE_WITHIN_COMPLETE_FINITE_STATE", key + " exhausts the complete finite state space unsolved")
	_require(controls.only_echo_near.visited_states == 750 and controls.only_echo_late.visited_states == 18750 and controls.no_echo.visited_states == 30, "individual/no-ECHO complete state counts are exact")
	_require(controls.relocate_plate_a.visited_states == 18750 and controls.relocate_plate_b.visited_states == 18750, "both fair Plate relocations are complete unsolved")
	_require(controls.equal_2.visited_states == 750 and controls.equal_4.visited_states == 18750, "2/2 and 4/4 controls destroy the two-offset role exactly")
	_require(controls.dependency_plate_a.status == "SOLVED" and controls.dependency_plate_a.shortest_turn_count == 11 and controls.dependency_plate_a.shortest_solution_count == 70, "A-only dependency materially simplifies exact structure")
	_require(controls.dependency_plate_b.status == "SOLVED" and controls.dependency_plate_b.shortest_turn_count == 10 and controls.dependency_plate_b.shortest_solution_count == 1, "B-only dependency materially simplifies exact structure")
	_require(controls.remove_door.status == "SOLVED" and controls.remove_door.shortest_turn_count == 10 and controls.remove_door.shortest_solution_count == 30, "Door removal materially simplifies exact structure")
	var initial := Simulation.new().construct_initial_state(level)
	var overlap: Dictionary = initial.duplicate(true)
	overlap.echo_positions[0].position = [6, 3]
	overlap.echo_positions[1].position = [6, 3]
	_require(Simulation.new().pressed_plate_ids(level, overlap) == ["plate_a"] and not overlap.door_states[0].open, "ECHO overlap cannot substitute one actor for two distinct Plate cells")
	var echo_exit: Dictionary = initial.duplicate(true)
	echo_exit.echo_positions[0].position = level.exit.position.duplicate()
	var echo_only := Simulation.new().transition(level, echo_exit, "RIGHT")
	_require(echo_only.ok and not echo_only.state.completed, "ECHO on EXIT remains non-terminal")
	_require(Simulation.new().restart(level).state == initial, "restart reconstructs the exact Level 7 initial state")
	print("TASK_0015_CONTROL_MATRIX=" + JSON.stringify(controls))


func _controls(level: Dictionary) -> Dictionary:
	var results := {}
	for keep_id in ["echo_near", "echo_late", ""]:
		var data: Dictionary = level.duplicate(true)
		data.echoes = data.echoes.filter(func(echo): return echo.id == keep_id)
		data.metadata.allow_zero_echo_tutorial = data.echoes.is_empty()
		var checked := LevelLoader.new().validate_dict(data)
		results["only_" + keep_id if keep_id != "" else "no_echo"] = Solver.new().solve(checked.level, LIMITS) if checked.ok else checked
	for plate_id in ["plate_a", "plate_b"]:
		var data: Dictionary = level.duplicate(true)
		for plate in data.plates:
			if plate.id == plate_id:
				plate.position = [1, 1]
		var checked := LevelLoader.new().validate_dict(data)
		results["relocate_" + plate_id] = Solver.new().solve(checked.level, LIMITS) if checked.ok else checked
	for dependency in [["plate_a"], ["plate_b"]]:
		var data: Dictionary = level.duplicate(true)
		data.doors[0].all_plate_ids = dependency
		var checked := LevelLoader.new().validate_dict(data)
		results["dependency_" + dependency[0]] = Solver.new().solve(checked.level, LIMITS) if checked.ok else checked
	for delay in [2, 4]:
		var data: Dictionary = level.duplicate(true)
		for echo in data.echoes:
			echo.delay = delay
		var checked := LevelLoader.new().validate_dict(data)
		results["equal_%d" % delay] = Solver.new().solve(checked.level, LIMITS) if checked.ok else checked
	var removed: Dictionary = level.duplicate(true)
	removed.doors = []
	var checked := LevelLoader.new().validate_dict(removed)
	results.remove_door = Solver.new().solve(checked.level, LIMITS) if checked.ok else checked
	return results


func _test_catalog_progression() -> void:
	var loaded := CatalogLoader.new().load_file("res://data/catalog/level_catalog_v1.json")
	_require(loaded.ok and loaded.catalog.entries.size() == 7, "tracked catalog validates with exactly seven entries")
	if not loaded.ok:
		return
	var entries: Array = loaded.catalog.entries
	_require(entries[5].level_id == "staggered_doors" and not entries[5].final_level and entries[6].level_id == "two_echo_convergence" and entries[6].final_level, "Level 7 is the sole final catalog entry")
	_require(entries[6].unlock_prerequisites == ["staggered_doors"] and entries[6].hud_mode == "STANDARD_COMPACT" and not entries[6].has("best_turn_threshold"), "Level 7 route and progression facts are exact")
	var progress = ProgressStore.new(loaded.catalog)
	for item in [["tutorial_reach_exit", 3], ["tutorial_echo_bridge", 9], ["vertical_slice_delay_3", 9], ["door_one_turn_late", 9], ["two_keys_one_door", 12]]:
		progress.record_completion(item[0], item[1])
	_require(progress.is_unlocked("staggered_doors") and not progress.is_unlocked("two_echo_convergence"), "Level 7 remains locked before Level 6 completion")
	progress.record_completion("staggered_doors", 15)
	_require(progress.is_unlocked("two_echo_convergence"), "Level 6 completion unlocks exactly Level 7")
	progress.reset_test_profile()
	_require(progress.snapshot().unlocked_level_ids == ["tutorial_reach_exit"], "seven-level reset restores only Tutorial 0 unlocked")
	var direct := RouteRequest.parse_user_args(["--level-id=two_echo_convergence"])
	_require(direct.ok and direct.level_id == "two_echo_convergence", "generic direct-level parser accepts Level 7")


func _test_runtime_and_presentation(level: Dictionary, solved: Dictionary) -> void:
	var scene = GameplayScene.instantiate()
	_require(scene.configure_route_payload({"level_id": "two_echo_convergence", "level_path": "res://data/levels/two_echo_convergence.json", "hud_mode": "STANDARD_COMPACT", "classification": "standard", "development_direct": true, "final_level": true}), "Level 7 configures reusable Gameplay")
	root.add_child(scene)
	await process_frame
	_require(scene.is_runtime_ready() and scene.level == level, "reusable Gameplay loads the exact formal Level 7")
	var initial_snapshot: Dictionary = scene.get_presentation_snapshot()
	_require(initial_snapshot.viewport == Rect2(0, 0, 960, 540) and initial_snapshot.plates.map(func(item): return [item.label, item.shape]) == [["A", "TRIANGLE"], ["B", "CIRCLE"]], "A/B labels and shapes are snapshot-readable at 960 by 540")
	_require(initial_snapshot.doors[0].dependency_expression == "A + B" and initial_snapshot.doors[0].dependency_pips.map(func(item): return [item.label, item.shape, item.active]) == [["A", "TRIANGLE", false], ["B", "CIRCLE", false]], "Door snapshot expresses independently inactive A+B tokens")
	_require(initial_snapshot.echoes.map(func(item): return [item.badge, item.outline_style]) == [["E4", "DOUBLE_DASHED"], ["E2", "SOLID"]], "E2/E4 badges and distinct outlines are stable")
	var overlap_state: Dictionary = scene.state.duplicate(true)
	overlap_state.echo_positions[0].position = [1, 5]
	overlap_state.echo_positions[1].position = [1, 5]
	scene.state = overlap_state
	var overlap_snapshot: Dictionary = scene.get_presentation_snapshot()
	_require(overlap_snapshot.echoes.all(func(item): return item.overlap_count == 2 and item.overlap_readable), "overlap snapshot retains both E2/E4 identities")
	scene.state = Simulation.new().construct_initial_state(level)
	for action in solved.solution:
		_send_simulation_action(scene, action)
	_require(scene.state.completed and scene.state.player_position == level.exit.position, "Gameplay replay preserves exact input order and completes Level 7")
	_send_scene_action(scene, "restart_level")
	_require(scene.state == Simulation.new().construct_initial_state(level), "Gameplay restart reconstructs exact Level 7 state")
	var before_help: Dictionary = scene.state.duplicate(true)
	_send_help_key(scene)
	_require(scene.get_hud_snapshot().help_expanded and scene.state == before_help, "inherited Help remains modal and zero-turn")
	_require(scene.get_timeline_snapshot().visible and scene.get_presentation_snapshot().timeline_visible, "inherited Timeline remains optional and unchanged for distinct delays")
	scene.queue_free()
	await process_frame


func _send_scene_action(scene: Node, action: String) -> void:
	var event := InputEventAction.new()
	event.action = action
	event.pressed = true
	scene._unhandled_input(event)


func _send_simulation_action(scene: Node, action: String) -> void:
	var input_actions := {"UP": "move_up", "RIGHT": "move_right", "DOWN": "move_down", "LEFT": "move_left", "WAIT": "wait_turn"}
	_send_scene_action(scene, input_actions[action])


func _send_help_key(scene: Node) -> void:
	var event := InputEventKey.new()
	event.keycode = KEY_H
	event.pressed = true
	scene._unhandled_input(event)


func _terrain_reaches_exit_without(level: Dictionary, blocked: Array) -> bool:
	var queue := [level.player_spawn]
	var seen := {_position_key(level.player_spawn): true, _position_key(blocked): true}
	var head := 0
	while head < queue.size():
		var position: Array = queue[head]
		head += 1
		if position == level.exit.position:
			return true
		for delta in [[0, -1], [1, 0], [0, 1], [-1, 0]]:
			var next := [position[0] + delta[0], position[1] + delta[1]]
			var key := _position_key(next)
			if seen.has(key) or next[0] < 0 or next[1] < 0 or next[1] >= level.terrain_rows.size() or next[0] >= level.terrain_rows[0].length() or level.terrain_rows[next[1]][next[0]] != ".":
				continue
			seen[key] = true
			queue.append(next)
	return false


func _position_key(position: Array) -> String:
	return "%d,%d" % [position[0], position[1]]


func _critical_trace(level: Dictionary, solved: Dictionary, replay: Dictionary) -> Array:
	var result := []
	for index in replay.transitions.size():
		var transition: Dictionary = replay.transitions[index]
		if transition.state.door_states[0].open or (index > 0 and replay.transitions[index - 1].state.door_states[0].open):
			result.append({"turn": index + 1, "action": solved.solution[index], "actor_actions": transition.actor_actions, "pressed": transition.pressed_plate_ids, "state": transition.state})
	return result

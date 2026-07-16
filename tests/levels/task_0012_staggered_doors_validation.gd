extends SceneTree

const LevelLoader = preload("res://scripts/simulation/level_loader.gd")
const Simulation = preload("res://scripts/simulation/simulation.gd")
const Solver = preload("res://scripts/solver/bfs_solver.gd")
const CatalogLoader = preload("res://scripts/app/catalog_loader.gd")
const ProgressStore = preload("res://scripts/app/memory_progress.gd")
const RouteRequest = preload("res://scripts/app/route_request.gd")
const GameplayScene = preload("res://scenes/vertical_slice/vertical_slice.tscn")
const ACTIONS := ["UP", "RIGHT", "DOWN", "LEFT", "WAIT"]

var failures := 0


func _init() -> void:
	call_deferred("_run")


func _run() -> void:
	var loaded := LevelLoader.new().load_file("res://data/levels/staggered_doors.json")
	_require(loaded.ok, "Level 6 loads through the accepted public LevelLoader")
	if loaded.ok:
		var level: Dictionary = loaded.level
		_require(level.level_id == "staggered_doors" and level.title == "Staggered Doors", "Level 6 formal identity is exact")
		_require(level.terrain_rows.size() == 7 and level.terrain_rows[0].length() == 9, "Level 6 stays inside the 9 by 7 footprint")
		_require(level.echoes.size() == 1 and level.echoes[0].delay == 3 and level.echoes[0].spawn == level.player_spawn, "Level 6 has one shared-spawn delay-3 ECHO")
		_require(level.plates.map(func(plate): return plate.id) == ["plate_early", "plate_late"], "Level 6 has exactly two stable Plates")
		_require(level.doors.map(func(door): return door.id) == ["door_early", "door_late"], "Level 6 has exactly two stable Doors")
		_require(level.doors[0].all_plate_ids == ["plate_early"] and level.doors[1].all_plate_ids == ["plate_late"], "Level 6 Door dependency sets are distinct and cover both Plates")
		var limits := {"depth_limit": 64, "state_limit": 500000, "time_limit_ms": 30000, "solution_count_cap": 1000000}
		var solved := Solver.new().solve(level, limits)
		_require(solved.status == "SOLVED", "Level 6 shared BFS returns SOLVED")
		_require(solved.status == "SOLVED" and solved.shortest_turn_count >= 15 and solved.shortest_turn_count <= 21, "Level 6 L star is inside the hard band")
		_require(solved.status == "SOLVED" and solved.shortest_solution_count >= 1 and solved.shortest_solution_count <= 12 and solved.shortest_solution_count_status == "EXACT", "Level 6 N star is exact and inside the hard band")
		_require(solved.status == "SOLVED" and solved.visited_states >= 2000 and solved.visited_states <= 40000, "Level 6 visited states are inside the hard band")
		if solved.status == "SOLVED":
			var replay := Simulation.new().replay(level, solved.solution)
			_require(replay.ok and replay.state.completed, "Level 6 shortest witness replays through shared Simulation")
			_require(not solved.solution.has("WAIT"), "Level 6 shortest witness does not reopen literal WAIT research")
			_test_door_windows(level, solved, replay)
			_test_shortest_solution_door_events(level, solved)
			_test_meaningful_decisions(level, solved, replay)
			_test_exit_restart_and_blocked_history(level, solved, replay)
			await _test_runtime_smoke(level, solved)
		_test_necessity_controls(level, limits)
		print("TASK_0012_CANDIDATE_RESULT=" + JSON.stringify(solved))
	_test_catalog_progression()
	if failures > 0:
		printerr("TASK_0012_FOCUSED_FAIL failures=%d" % failures)
		quit(1)
	else:
		print("TASK_0012_FOCUSED_PASS")
		quit(0)


func _require(condition: bool, label: String) -> void:
	if not condition:
		failures += 1
		printerr("TASK_0012_FAIL: " + label)


func _test_necessity_controls(level: Dictionary, limits: Dictionary) -> void:
	var controls := {}
	var no_echo_data: Dictionary = level.duplicate(true)
	no_echo_data.echoes = []
	no_echo_data.metadata.allow_zero_echo_tutorial = true
	var no_echo := LevelLoader.new().validate_dict(no_echo_data)
	var no_echo_result := Solver.new().solve(no_echo.level, limits) if no_echo.ok else {"status": "INVALID_LEVEL"}
	controls["no_echo"] = no_echo_result
	_require(no_echo.ok and no_echo_result.status == "UNSOLVABLE_WITHIN_COMPLETE_FINITE_STATE", "Level 6 no-ECHO control exhausts the complete finite state space unsolved")
	for plate_id in ["plate_early", "plate_late"]:
		var isolated_data: Dictionary = level.duplicate(true)
		for plate in isolated_data.plates:
			if plate.id == plate_id:
				plate.position = [7, 2]
		var isolated := LevelLoader.new().validate_dict(isolated_data)
		var isolated_result := Solver.new().solve(isolated.level, limits) if isolated.ok else {"status": "INVALID_LEVEL"}
		controls["isolate_" + plate_id] = isolated_result
		_require(isolated.ok and isolated_result.status == "UNSOLVABLE_WITHIN_COMPLETE_FINITE_STATE", "Level 6 isolated %s control exhausts complete unsolved" % plate_id)
	for door_id in ["door_early", "door_late"]:
		var removed_data: Dictionary = level.duplicate(true)
		removed_data.doors = removed_data.doors.filter(func(door): return door.id != door_id)
		var removed := LevelLoader.new().validate_dict(removed_data)
		var removed_result := Solver.new().solve(removed.level, limits) if removed.ok else {"status": "INVALID_LEVEL"}
		controls["remove_" + door_id] = removed_result
		var removal_changed: bool = removed_result.status != "SOLVED" or removed_result.shortest_turn_count != 15 or removed_result.shortest_solution_count != 4 or removed_result.visited_states != 6772
		_require(removed.ok and removal_changed, "removing %s materially changes the exact solution metrics" % door_id)
	var dependency_replacements := {"door_early": "plate_late", "door_late": "plate_early"}
	for door_id in dependency_replacements:
		var replacement_data: Dictionary = level.duplicate(true)
		for door in replacement_data.doors:
			if door.id == door_id:
				door.all_plate_ids = [dependency_replacements[door_id]]
		var replacement := LevelLoader.new().validate_dict(replacement_data)
		var replacement_result := Solver.new().solve(replacement.level, limits) if replacement.ok else {"status": "INVALID_LEVEL"}
		controls["replace_dependency_" + door_id] = replacement_result
		var structure_changed: bool = replacement_result.status != "SOLVED" or replacement_result.shortest_turn_count != 15 or replacement_result.shortest_solution_count != 4
		_require(replacement.ok and structure_changed, "replacing %s dependency materially changes the exact solution structure" % door_id)
	print("TASK_0012_NECESSITY_CONTROLS=" + JSON.stringify(controls))


func _test_door_windows(level: Dictionary, solved: Dictionary, replay: Dictionary) -> void:
	var traces := {}
	for door in level.doors:
		var door_index: int = level.doors.find(door)
		var plate_id: String = door.all_plate_ids[0]
		var plate = level.plates.filter(func(item): return item.id == plate_id)[0]
		var trace := {}
		for action_index in replay.transitions.size():
			var start_state: Dictionary = Simulation.new().construct_initial_state(level) if action_index == 0 else replay.transitions[action_index - 1].state
			var result: Dictionary = replay.transitions[action_index]
			if start_state.door_states[door_index].open and start_state.player_position != door.position and result.state.player_position == door.position:
				var dependency_index: int = action_index - 1
				var before_dependency: Dictionary = Simulation.new().construct_initial_state(level) if dependency_index == 0 else replay.transitions[dependency_index - 1].state
				var dependency_result: Dictionary = replay.transitions[dependency_index]
				var first_closed_later_index := -1
				for later_index in range(action_index, replay.transitions.size()):
					if not replay.transitions[later_index].state.door_states[door_index].open:
						first_closed_later_index = later_index
						break
				trace = {
					"door_id": door.id,
					"dependency_before": before_dependency,
					"dependency_action": solved.solution[dependency_index],
					"open_result": dependency_result.state,
					"pressed_plate_ids": dependency_result.pressed_plate_ids,
					"entry_start": start_state,
					"entry_action": solved.solution[action_index],
					"entry_result": result.state,
					"closed_after_entry": not result.state.door_states[door_index].open,
					"first_closed_later_action_index": first_closed_later_index,
				}
				_require(not before_dependency.door_states[door_index].open and dependency_result.state.door_states[door_index].open, "%s has a closed-before/open-result dependency transition" % door.id)
				_require(dependency_result.pressed_plate_ids.has(plate_id) and dependency_result.state.echo_positions[0].position == plate.position and dependency_result.state.player_position != plate.position, "%s opens from the intended ECHO-only Plate occupancy" % door.id)
				_require(first_closed_later_index >= action_index, "%s closes around or behind YOU later in the shortest witness" % door.id)
				break
		traces[door.id] = trace
		_require(not trace.is_empty(), "%s shortest witness enters from its open start-turn snapshot" % door.id)
	_require(traces.door_early.open_result.echo_positions[0].position != traces.door_late.open_result.echo_positions[0].position, "the two useful Door windows use different ECHO/Plate arrangements")
	print("TASK_0012_DOOR_WINDOW_TRACES=" + JSON.stringify(traces))


func _test_shortest_solution_door_events(level: Dictionary, solved: Dictionary) -> void:
	for door in level.doors:
		_require(not _terrain_reaches_exit_without(level, door.position), "%s is a terrain articulation on every YOU-to-EXIT route" % door.id)
	var initial := Simulation.new().construct_initial_state(level)
	var initial_key := Simulation.new().canonical_key(initial) + "|0"
	var queue := [initial_key]
	var states := {initial_key: initial}
	var masks := {initial_key: 0}
	var depths := {initial_key: 0}
	var counts := {initial_key: 1}
	var head := 0
	var goal_counts := {0: 0, 1: 0, 2: 0, 3: 0}
	while head < queue.size():
		var key: String = queue[head]
		head += 1
		var depth: int = depths[key]
		if depth >= solved.shortest_turn_count:
			continue
		for action in ACTIONS:
			var transitioned := Simulation.new().transition(level, states[key], action)
			if not transitioned.ok:
				continue
			var next_mask: int = masks[key]
			for door_index in level.doors.size():
				if states[key].door_states[door_index].open and states[key].player_position != level.doors[door_index].position and transitioned.state.player_position == level.doors[door_index].position:
					next_mask |= 1 << door_index
			var next_depth: int = depth + 1
			var next_key := Simulation.new().canonical_key(transitioned.state) + "|" + str(next_mask)
			if not depths.has(next_key):
				depths[next_key] = next_depth
				states[next_key] = transitioned.state
				masks[next_key] = next_mask
				counts[next_key] = counts[key]
				queue.append(next_key)
			elif depths[next_key] == next_depth:
				counts[next_key] += counts[key]
			if transitioned.state.completed and next_depth == solved.shortest_turn_count:
				goal_counts[next_mask] += counts[key]
	_require(goal_counts[3] == solved.shortest_solution_count and goal_counts[0] == 0 and goal_counts[1] == 0 and goal_counts[2] == 0, "all exact shortest solutions cross both Doors under open start-turn snapshots")
	print("TASK_0012_SHORTEST_DOOR_EVENT_COUNTS=" + JSON.stringify(goal_counts))


func _terrain_reaches_exit_without(level: Dictionary, blocked_position: Array) -> bool:
	var start_key := _position_key(level.player_spawn)
	var blocked_key := _position_key(blocked_position)
	var exit_key := _position_key(level.exit.position)
	var queue := [level.player_spawn]
	var seen := {start_key: true, blocked_key: true}
	var head := 0
	while head < queue.size():
		var position: Array = queue[head]
		head += 1
		if _position_key(position) == exit_key:
			return true
		for delta in [[0, -1], [1, 0], [0, 1], [-1, 0]]:
			var next := [position[0] + delta[0], position[1] + delta[1]]
			var next_key := _position_key(next)
			if seen.has(next_key) or next[1] < 0 or next[1] >= level.terrain_rows.size() or next[0] < 0 or next[0] >= level.terrain_rows[0].length() or level.terrain_rows[next[1]][next[0]] != ".":
				continue
			seen[next_key] = true
			queue.append(next)
	return false


func _position_key(position: Array) -> String:
	return "%d,%d" % [position[0], position[1]]


func _test_meaningful_decisions(level: Dictionary, solved: Dictionary, replay: Dictionary) -> void:
	var specifications := [
		{"action_index": 2, "alternative": "LEFT", "kind": "route_setup"},
		{"action_index": 8, "alternative": "LEFT", "kind": "door_exit_commitment"},
		{"action_index": 11, "alternative": "DOWN", "kind": "upper_route_commitment"},
	]
	var decisions := []
	for specification in specifications:
		var action_index: int = specification.action_index
		var state_before: Dictionary = Simulation.new().construct_initial_state(level) if action_index == 0 else replay.transitions[action_index - 1].state
		var chosen := Simulation.new().transition(level, state_before, solved.solution[action_index])
		var alternative := Simulation.new().transition(level, state_before, specification.alternative)
		var alternative_search := _shortest_from_state(level, alternative.state, 64, 500000)
		var alternative_total: int = action_index + 1 + int(alternative_search.get("remaining_turns", 1000000))
		var penalty: int = alternative_total - int(solved.shortest_turn_count) if alternative_search.status == "SOLVED" else -1
		_require(chosen.ok and alternative.ok and Simulation.new().canonical_key(chosen.state) != Simulation.new().canonical_key(alternative.state), "decision %d alternative creates a distinct canonical successor" % (action_index + 1))
		_require(alternative_search.status != "SOLVED" or alternative_total > solved.shortest_turn_count, "decision %d alternative misses the shortest route or window" % (action_index + 1))
		decisions.append({
			"turn": action_index + 1,
			"kind": specification.kind,
			"chosen": solved.solution[action_index],
			"alternative": specification.alternative,
			"alternative_search": alternative_search,
			"minimum_total_turns": alternative_total if alternative_search.status == "SOLVED" else null,
			"minimum_penalty": penalty if alternative_search.status == "SOLVED" else null,
			"recoverable": alternative_search.status == "SOLVED",
		})
	_require(decisions.size() == 3 and decisions.all(func(item): return item.kind != "blocked_repeat"), "Level 6 records three non-repeated meaningful route decisions")
	print("TASK_0012_MEANINGFUL_DECISIONS=" + JSON.stringify(decisions))


func _shortest_from_state(level: Dictionary, start_state: Dictionary, depth_limit: int, state_limit: int) -> Dictionary:
	if start_state.completed:
		return {"status": "SOLVED", "remaining_turns": 0, "visited_states": 1}
	var start_key := Simulation.new().canonical_key(start_state)
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
			var transitioned := Simulation.new().transition(level, states[key], action)
			if not transitioned.ok:
				continue
			var next_depth: int = depth + 1
			if transitioned.state.completed:
				return {"status": "SOLVED", "remaining_turns": next_depth, "visited_states": states.size()}
			var next_key := Simulation.new().canonical_key(transitioned.state)
			if states.has(next_key):
				continue
			if states.size() >= state_limit:
				return {"status": "STATE_LIMIT", "visited_states": states.size()}
			states[next_key] = transitioned.state
			depths[next_key] = next_depth
			queue.append(next_key)
	return {"status": "UNSOLVABLE_WITHIN_COMPLETE_FINITE_STATE", "visited_states": states.size()}


func _test_exit_restart_and_blocked_history(level: Dictionary, solved: Dictionary, replay: Dictionary) -> void:
	var initial := Simulation.new().construct_initial_state(level)
	_require(Simulation.new().restart(level).state == initial, "Level 6 restart reconstructs the exact initial state")
	var echo_on_exit: Dictionary = initial.duplicate(true)
	echo_on_exit.echo_positions[0].position = level.exit.position.duplicate()
	var echo_only := Simulation.new().transition(level, echo_on_exit, "WAIT")
	_require(echo_only.ok and not echo_only.state.completed, "Level 6 ECHO on EXIT cannot complete")
	var blocked_player_turns := []
	var state_before := initial
	for index in replay.transitions.size():
		var state_after: Dictionary = replay.transitions[index].state
		if solved.solution[index] != "WAIT" and state_after.player_position == state_before.player_position:
			blocked_player_turns.append(index + 1)
		state_before = state_after
	_require(blocked_player_turns.is_empty(), "the witness contains no repeated blocked-move padding")
	_require(replay.state.completed and replay.state.player_position == level.exit.position, "only YOU completes at the formal EXIT")
	print("TASK_0012_EXIT_RESTART_SHORTCUT_AUDIT=" + JSON.stringify({"blocked_player_turns": blocked_player_turns, "echo_on_exit_completed": echo_only.state.completed, "restart_exact": Simulation.new().restart(level).state == initial}))


func _test_catalog_progression() -> void:
	var loaded := CatalogLoader.new().load_file("res://data/catalog/level_catalog_v1.json")
	_require(loaded.ok and loaded.catalog.entries.size() == 6, "tracked catalog validates with exactly six entries")
	if not loaded.ok or loaded.catalog.entries.size() != 6:
		return
	var entries: Array = loaded.catalog.entries
	_require(entries.map(func(entry): return entry.level_id) == ["tutorial_reach_exit", "tutorial_echo_bridge", "vertical_slice_delay_3", "door_one_turn_late", "two_keys_one_door", "staggered_doors"], "catalog sequence appends only Level 6")
	_require(not entries[4].final_level and entries[5].final_level and entries.filter(func(entry): return entry.final_level).size() == 1, "Level 6 is the sole final catalog entry")
	_require(entries[5].unlock_prerequisites == ["two_keys_one_door"] and entries[5].hud_mode == "STANDARD_COMPACT" and entries[5].classification == "standard", "Level 6 catalog route facts are exact")
	var progress = ProgressStore.new(loaded.catalog)
	_require(progress.snapshot().unlocked_level_ids == ["tutorial_reach_exit"], "six-level progress initially unlocks only Tutorial 0")
	for item in [["tutorial_reach_exit", 3], ["tutorial_echo_bridge", 9], ["vertical_slice_delay_3", 9], ["door_one_turn_late", 9]]:
		_require(progress.record_completion(item[0], item[1]), "accepted progression records " + item[0])
	_require(progress.is_unlocked("two_keys_one_door") and not progress.is_unlocked("staggered_doors"), "Level 6 remains locked before Level 5 completion")
	_require(progress.record_completion("two_keys_one_door", 12) and progress.is_unlocked("staggered_doors"), "Level 5 completion unlocks exactly Level 6")
	progress.reset_test_profile()
	_require(progress.snapshot() == {"completed_level_ids": [], "best_turns": {}, "unlocked_level_ids": ["tutorial_reach_exit"]}, "six-level reset restores exact initial progress")
	var direct := RouteRequest.parse_user_args(["--level-id=staggered_doors"])
	_require(direct.ok and direct.level_id == "staggered_doors", "generic direct-level parser accepts Level 6 ID")


func _test_runtime_smoke(level: Dictionary, solved: Dictionary) -> void:
	var scene = GameplayScene.instantiate()
	var configured: bool = scene.configure_route_payload({
		"level_id": "staggered_doors",
		"level_path": "res://data/levels/staggered_doors.json",
		"hud_mode": "STANDARD_COMPACT",
		"classification": "standard",
		"development_direct": true,
		"final_level": true,
	})
	_require(configured, "Level 6 configures the reusable Gameplay public route")
	root.add_child(scene)
	await process_frame
	_require(scene.is_runtime_ready() and scene.level.level_id == "staggered_doors", "Level 6 reusable Gameplay becomes runtime ready with matching ID")
	var initial_presentation: Dictionary = scene.get_presentation_snapshot()
	_require(initial_presentation.board_rect.size == Vector2(540, 420) and initial_presentation.board_zone.encloses(initial_presentation.board_rect), "Level 6 9 by 7 board fits the accepted presentation zone")
	_require(initial_presentation.plates.size() == 2 and initial_presentation.doors.size() == 2 and initial_presentation.doors[0].dependency_pips == [{"plate_id": "plate_early", "active": false}] and initial_presentation.doors[1].dependency_pips == [{"plate_id": "plate_late", "active": false}], "Level 6 primitive cues expose both distinct Plate dependencies")
	var state_before_help: Dictionary = scene.state.duplicate(true)
	_send_help(scene)
	_send_runtime_action(scene, "RIGHT")
	_require(scene.get_hud_snapshot().help_expanded and scene.state == state_before_help, "Level 6 Help remains modal and zero-turn")
	_send_help(scene)
	for action_index in solved.solution.size():
		_send_runtime_action(scene, solved.solution[action_index])
		if action_index == 4:
			var early: Dictionary = scene.get_presentation_snapshot()
			_require(early.doors[0].open and early.doors[0].dependency_pips[0].active and early.plates[0].pressed, "Level 6 first critical window is inspectable through primitive Plate/Door cues")
		if action_index == 6:
			var late: Dictionary = scene.get_presentation_snapshot()
			_require(not late.doors[0].open and late.doors[1].open and late.doors[1].dependency_pips[0].active and late.plates[1].pressed, "Level 6 second critical window is visually distinct and inspectable")
	_require(scene.state.completed and scene.state.player_position == level.exit.position and scene.state.turn_index == solved.shortest_turn_count + 1, "Level 6 Gameplay replays the solver witness to exact completion")
	_send_runtime_action(scene, "restart_level")
	_require(scene.state == Simulation.new().construct_initial_state(level), "Level 6 Gameplay restart reconstructs the exact initial state")
	scene.queue_free()
	await process_frame


func _send_runtime_action(scene: Node, action: String) -> void:
	var input_actions := {"UP": "move_up", "RIGHT": "move_right", "DOWN": "move_down", "LEFT": "move_left", "WAIT": "wait_turn"}
	var event := InputEventAction.new()
	event.action = input_actions.get(action, action)
	event.pressed = true
	scene._unhandled_input(event)


func _send_help(scene: Node) -> void:
	var event := InputEventKey.new()
	event.keycode = KEY_H
	event.pressed = true
	scene._unhandled_input(event)

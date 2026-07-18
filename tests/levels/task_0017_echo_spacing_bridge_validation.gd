extends RefCounted

const LevelLoader = preload("res://scripts/simulation/level_loader.gd")
const Simulation = preload("res://scripts/simulation/simulation.gd")
const Solver = preload("res://scripts/solver/bfs_solver.gd")
const CatalogLoader = preload("res://scripts/app/catalog_loader.gd")
const ProgressStore = preload("res://scripts/app/memory_progress.gd")
const RouteRequest = preload("res://scripts/app/route_request.gd")
const GameplayScene = preload("res://scenes/vertical_slice/vertical_slice.tscn")

const ACTIONS := ["UP", "RIGHT", "DOWN", "LEFT", "WAIT"]
const LIMITS := {"depth_limit": 64, "state_limit": 500000, "time_limit_ms": 30000, "solution_count_cap": 1000000}
const WITNESS := ["RIGHT", "RIGHT", "RIGHT", "UP", "UP", "UP", "LEFT", "RIGHT", "DOWN", "DOWN", "UP", "LEFT", "RIGHT", "UP", "UP", "UP"]
const PRIOR_HASHES := {
	"res://data/levels/tutorial_reach_exit.json": "38e466bb5922f1987a99d79c7527a4a8eab8e6cfdbe76fd8159f80b0a40cf2c4",
	"res://data/levels/tutorial_echo_bridge.json": "681d99057c4e6034a490644d75960ff23d8f43bd1b91850f48179b79fc04a3cf",
	"res://data/levels/vertical_slice_delay_3.json": "8751da5051fbebaaa5ae7c895d9be9f086e8d8f2e87876a80c379dc06262f1d8",
	"res://data/levels/door_one_turn_late.json": "1775cf89ae4a94f65a76dac2b791a31395443de88205d0ed1b6233331dbda577",
	"res://data/levels/two_keys_one_door.json": "f4c6791dfc84d17fb450721e654091a2baeb522e55d660a5d73878cd977651cd",
	"res://data/levels/staggered_doors.json": "3f14c19b50775e36dd5b52664798381cf1292b0a30b377641c03435f45696bc8",
	"res://data/levels/two_echo_convergence.json": "772410d3b8bb807e35472ee2a7d07b703de66e1e0e92ffb4d1ff8433a345d5fd",
}

var assertions := 0
var failures := 0
var level: Dictionary
var solved: Dictionary


func run(tree: SceneTree) -> Dictionary:
	var loaded := LevelLoader.new().load_file("res://data/levels/echo_spacing_bridge.json")
	_expect(loaded.ok, "Task 0017 formal bridge loads through the frozen LevelLoader")
	if not loaded.ok:
		return {"assertions": assertions, "failures": failures}
	level = loaded.level
	_test_formal_contract()
	solved = Solver.new().solve(level, LIMITS)
	_test_solver_and_witness()
	_test_all_shortest()
	_test_controls()
	_test_geometry_and_identity()
	_test_decisions_and_recovery()
	_test_catalog_and_progression()
	_test_preservation()
	await _test_gameplay_feedback(tree)
	return {"assertions": assertions, "failures": failures}


func _test_formal_contract() -> void:
	_expect(level.schema_version == 1 and level.level_id == "echo_spacing_bridge" and level.title == "Diverging Echoes", "Task 0017 identity is exact")
	_expect(level.terrain_rows.size() == 7 and level.terrain_rows.all(func(row): return row.length() == 8), "Task 0017 board is exactly 8 by 7")
	_expect(level.player_spawn == [3, 5] and level.echoes.size() == 2 and level.echoes.all(func(echo): return echo.spawn == level.player_spawn), "YOU and two ECHOs share the spawn")
	_expect(level.echoes.map(func(echo): return [echo.id, echo.delay]) == [["echo_late", 4], ["echo_near", 2]], "Task 0017 exact E4 and E2 identities survive normalization")
	_expect(level.plates.map(func(plate): return [plate.id, plate.position]) == [["plate_a", [5, 3]], ["plate_b", [6, 5]]], "Task 0017 has exactly distinct Plates A and B")
	_expect(level.doors.size() == 1 and level.doors[0].position == [6, 2] and not level.doors[0].initial_open and level.doors[0].all_plate_ids == ["plate_a", "plate_b"], "Task 0017 has one initially closed A+B Door")
	_expect(level.exit.position == [6, 1] and not level.has("best_turn_threshold") and level.validation.recommended_search_depth == 64, "Task 0017 has one player-only EXIT and no route threshold")


func _test_solver_and_witness() -> void:
	_expect(solved.status == "SOLVED" and solved.shortest_turn_count == 16, "Task 0017 exact L star is 16")
	_expect(solved.shortest_solution_count == 12 and solved.shortest_solution_count_status == "EXACT", "Task 0017 exact N star is 12")
	_expect(solved.visited_states == 19059 and solved.maximum_frontier == 3734 and solved.limits == LIMITS, "Task 0017 exact search burden and limits reproduce")
	_expect(solved.solution == WITNESS and not WITNESS.has("WAIT"), "Task 0017 stable witness contains no literal WAIT")
	var replay := Simulation.new().replay(level, WITNESS)
	_expect(replay.ok and replay.state.completed and replay.transitions.size() == 16, "Task 0017 witness replays to YOU completion")
	_expect(replay.transitions[8].actor_actions.echoes == [{"id": "echo_late", "action": "UP"}, {"id": "echo_near", "action": "LEFT"}], "Task 0017 witness replays the critical delayed actions")
	_expect(replay.transitions[8].state.echo_positions.map(func(echo): return echo.position) == [[6, 3], [6, 2]], "Task 0017 critical transition leaves E4 moved and E2 blocked")
	_expect(replay.transitions[13].pressed_plate_ids == ["plate_a", "plate_b"] and replay.transitions[13].state.door_states[0].open, "Task 0017 E2-A and E4-B result opens A+B")
	_expect(_echo_position(replay.transitions[13].state, "echo_near") == [5, 3] and _echo_position(replay.transitions[13].state, "echo_late") == [6, 5] and replay.transitions[13].state.player_position == [6, 3], "Task 0017 exact committed three-role result is present")
	_expect(replay.transitions[14].state.player_position == [6, 2] and not replay.transitions[14].state.door_states[0].open and replay.transitions[15].state.completed, "Task 0017 following open snapshot enters Door before YOU reaches EXIT")
	_expect(Simulation.new().restart(level).state == Simulation.new().construct_initial_state(level), "Task 0017 restart exactly reconstructs initial state")


func _test_all_shortest() -> void:
	var simulation := Simulation.new()
	var initial := simulation.construct_initial_state(level)
	var start_key := simulation.canonical_key(initial) + "|0"
	var queue := [start_key]
	var states := {start_key: initial}
	var depths := {start_key: 0}
	var masks := {start_key: 0}
	var counts := {start_key: 1}
	var goals := {}
	var head := 0
	while head < queue.size():
		var key: String = queue[head]
		head += 1
		var state: Dictionary = states[key]
		var depth: int = depths[key]
		if depth >= solved.shortest_turn_count:
			continue
		for action in ACTIONS:
			var transitioned := simulation.transition(level, state, action)
			if not transitioned.ok:
				continue
			var mask: int = masks[key]
			if _is_blocked_moved_spacing_change(state, transitioned):
				mask |= 1
			if _required_role(transitioned.state) and (mask & 1) != 0:
				mask |= 2
			if _required_role(state) and state.door_states[0].open and transitioned.state.player_position == level.doors[0].position:
				mask |= 4
			if _reversed_role(transitioned.state):
				mask |= 8
			var next_depth := depth + 1
			var next_key := simulation.canonical_key(transitioned.state) + "|" + str(mask)
			if not depths.has(next_key):
				depths[next_key] = next_depth
				states[next_key] = transitioned.state
				masks[next_key] = mask
				counts[next_key] = counts[key]
				queue.append(next_key)
			elif depths[next_key] == next_depth:
				counts[next_key] += counts[key]
			if transitioned.state.completed and next_depth == solved.shortest_turn_count:
				goals[mask] = int(goals.get(mask, 0)) + int(counts[key])
	_expect(goals.get(7, 0) == 12 and goals.values().reduce(func(total, count): return total + count, 0) == 12, "all 12 shortest solutions include divergence, required roles, and next-input crossing")
	_expect(goals.keys().all(func(mask): return (int(mask) & 8) == 0), "no shortest solution reverses E2 and E4 Plate roles")
	print("TASK_0017_ALL_SHORTEST_MASKS=" + JSON.stringify(goals))


func _test_controls() -> void:
	var results := {}
	for keep_id in ["echo_near", "echo_late", ""]:
		var data: Dictionary = level.duplicate(true)
		data.echoes = data.echoes.filter(func(echo): return echo.id == keep_id)
		data.metadata.allow_zero_echo_tutorial = data.echoes.is_empty()
		results["only_" + keep_id if keep_id != "" else "no_echo"] = _solve(data)
	for delay in [2, 4]:
		var data: Dictionary = level.duplicate(true)
		for echo in data.echoes:
			echo.delay = delay
		results["equal_%d" % delay] = _solve(data)
	for plate_id in ["plate_a", "plate_b"]:
		var data: Dictionary = level.duplicate(true)
		for plate in data.plates:
			if plate.id == plate_id:
				plate.position = [5, 4]
		results["relocate_" + plate_id] = _solve(data)
	for dependency in [["plate_a"], ["plate_b"]]:
		var data: Dictionary = level.duplicate(true)
		data.doors[0].all_plate_ids = dependency
		results["dependency_" + dependency[0]] = _solve(data)
	var removed: Dictionary = level.duplicate(true)
	removed.doors = []
	results.remove_door = _solve(removed)
	var blocker: Dictionary = level.duplicate(true)
	blocker.terrain_rows[2] = "#####..#"
	blocker.terrain_rows[4] = "######.#"
	results.relocate_blocker = _solve(blocker)
	_expect(results.no_echo.status == "UNSOLVABLE_WITHIN_COMPLETE_FINITE_STATE" and results.no_echo.visited_states == 8, "no-ECHO control completely exhausts unsolved")
	_expect(results.only_echo_near.status == "UNSOLVABLE_WITHIN_COMPLETE_FINITE_STATE" and results.only_echo_near.visited_states == 200, "E2-only control completely exhausts unsolved")
	_expect(results.only_echo_late.status == "UNSOLVABLE_WITHIN_COMPLETE_FINITE_STATE" and results.only_echo_late.visited_states == 5000, "E4-only control completely exhausts unsolved")
	_expect(results.equal_2.status == "UNSOLVABLE_WITHIN_COMPLETE_FINITE_STATE" and results.equal_4.status == "UNSOLVABLE_WITHIN_COMPLETE_FINITE_STATE", "equal-delay controls destroy the two-offset lesson")
	_expect(results.relocate_plate_a.shortest_turn_count == 9 and results.relocate_plate_b.shortest_turn_count == 9, "separate Plate relocations materially simplify the room")
	_expect(results.dependency_plate_a.shortest_turn_count == 8 and results.dependency_plate_b.shortest_turn_count == 7, "single-dependency controls materially simplify the room")
	_expect(results.remove_door.shortest_turn_count == 7 and results.relocate_blocker.shortest_solution_count == 5, "Door removal and blocker relocation materially change the authored structure")
	print("TASK_0017_CONTROL_MATRIX=" + JSON.stringify(results))


func _test_geometry_and_identity() -> void:
	_expect(_terrain_distance([5, 3], [6, 2]) == 2 and _terrain_distance([6, 5], [6, 2]) == 3, "both Plates are more than one traversable move from Door")
	_expect(not _terrain_reaches_exit_without([6, 2]), "Door cell articulates every YOU-to-EXIT terrain route")
	var initial := Simulation.new().construct_initial_state(level)
	var overlap: Dictionary = initial.duplicate(true)
	overlap.echo_positions[0].position = [5, 3]
	overlap.echo_positions[1].position = [5, 3]
	_expect(Simulation.new().pressed_plate_ids(level, overlap) == ["plate_a"] and not overlap.door_states[0].open, "actor overlap cannot satisfy A+B on distinct cells")
	var echo_exit: Dictionary = initial.duplicate(true)
	echo_exit.echo_positions[0].position = level.exit.position.duplicate()
	_expect(not Simulation.new().transition(level, echo_exit, "WAIT").state.completed, "ECHO on EXIT does not complete")
	var you_exit: Dictionary = initial.duplicate(true)
	you_exit.player_position = level.doors[0].position.duplicate()
	you_exit.echo_positions[0].position = [6, 5]
	you_exit.echo_positions[1].position = [5, 3]
	you_exit.door_states[0].open = true
	var completed := Simulation.new().transition(level, you_exit, "UP")
	_expect(completed.ok and completed.state.completed and completed.state.player_position == level.exit.position, "YOU on EXIT completes exactly")


func _test_decisions_and_recovery() -> void:
	var replay := Simulation.new().replay(level, WITNESS)
	var specs := [
		{"turn": 5, "alternative": "RIGHT", "minimum_penalty": 3},
		{"turn": 10, "alternative": "RIGHT", "minimum_penalty": 1},
		{"turn": 14, "alternative": "DOWN", "minimum_penalty": 4},
	]
	for spec in specs:
		var index: int = spec.turn - 1
		var before: Dictionary = Simulation.new().construct_initial_state(level) if index == 0 else replay.transitions[index - 1].state
		var alternative := Simulation.new().transition(level, before, spec.alternative)
		var search := _shortest_from_state(alternative.state, 40)
		var penalty: int = spec.turn + int(search.get("remaining_turns", 999)) - solved.shortest_turn_count
		_expect(alternative.ok and search.status == "SOLVED" and penalty == spec.minimum_penalty, "meaningful decision turn %d has exact recoverable penalty" % spec.turn)
	_expect(specs.size() == 3, "Task 0017 audits exactly three bounded meaningful decisions")


func _test_catalog_and_progression() -> void:
	var loaded := CatalogLoader.new().load_file("res://data/catalog/level_catalog_v1.json")
	_expect(loaded.ok and loaded.catalog.entries.size() == 8, "Task 0017 tracked catalog validates with eight entries")
	if not loaded.ok:
		return
	var entries: Array = loaded.catalog.entries
	_expect(entries.map(func(entry): return int(entry.sequence)) == [1, 2, 3, 4, 5, 6, 7, 8], "Task 0017 catalog sequences are contiguous")
	_expect(entries[6].level_id == "echo_spacing_bridge" and entries[6].unlock_prerequisites == ["staggered_doors"] and not entries[6].final_level, "bridge is non-final sequence 7 after Level 6")
	_expect(entries[7].level_id == "two_echo_convergence" and entries[7].unlock_prerequisites == ["echo_spacing_bridge"] and entries[7].final_level, "byte-identical convergence level shifts to sole-final sequence 8")
	_expect(entries.filter(func(entry): return entry.final_level).size() == 1 and not entries.any(func(entry): return entry.level_id == "signal_convergence"), "catalog has one final and no future finale entry")
	var progress = ProgressStore.new(loaded.catalog)
	for item in [["tutorial_reach_exit", 3], ["tutorial_echo_bridge", 9], ["vertical_slice_delay_3", 9], ["door_one_turn_late", 9], ["two_keys_one_door", 12]]:
		progress.record_completion(item[0], item[1])
	_expect(progress.is_unlocked("staggered_doors") and not progress.is_unlocked("echo_spacing_bridge"), "bridge remains locked before Level 6 completion")
	progress.record_completion("staggered_doors", 15)
	_expect(progress.is_unlocked("echo_spacing_bridge") and not progress.is_unlocked("two_echo_convergence"), "Level 6 unlocks exactly the bridge")
	progress.record_completion("echo_spacing_bridge", 16)
	_expect(progress.is_unlocked("two_echo_convergence"), "bridge completion unlocks shifted Level 7")
	progress.reset_test_profile()
	_expect(progress.snapshot().unlocked_level_ids == ["tutorial_reach_exit"], "eight-level reset unlocks only Tutorial 0")
	var direct := RouteRequest.parse_user_args(["--level-id=echo_spacing_bridge"])
	_expect(direct.ok and direct.level_id == "echo_spacing_bridge", "generic direct-level parser accepts bridge")


func _test_preservation() -> void:
	for path in PRIOR_HASHES:
		_expect(FileAccess.get_sha256(path) == PRIOR_HASHES[path], "prior formal hash remains byte-exact: " + path)
	print("TASK_0017_FORMAL_SHA256=" + FileAccess.get_sha256("res://data/levels/echo_spacing_bridge.json"))


func _test_gameplay_feedback(tree: SceneTree) -> void:
	var scene = GameplayScene.instantiate()
	_expect(scene.configure_route_payload({"level_id": "echo_spacing_bridge", "level_path": "res://data/levels/echo_spacing_bridge.json", "hud_mode": "STANDARD_COMPACT", "classification": "standard", "development_direct": true, "final_level": false}), "bridge configures through reusable Gameplay")
	tree.root.add_child(scene)
	await tree.process_frame
	var initial: Dictionary = scene.get_presentation_snapshot()
	_expect(scene.is_runtime_ready() and initial.viewport == Rect2(0, 0, 960, 540), "bridge renders in accepted 960 by 540 Gameplay")
	_expect(initial.plates.map(func(item): return [item.label, item.shape]) == [["A", "TRIANGLE"], ["B", "CIRCLE"]] and initial.doors[0].dependency_expression == "A + B", "existing labels, shapes, and Door pips expose dependencies")
	_expect(initial.echoes.map(func(item): return [item.badge, item.outline_style]) == [["E4", "DOUBLE_DASHED"], ["E2", "SOLID"]], "existing E2 and E4 identity cues remain distinct")
	for index in 5:
		_send_action(scene, WITNESS[index])
	var stable: Dictionary = scene.get_presentation_snapshot().echo_divergence
	_expect(not stable.visible and stable.pair.before_manhattan == stable.pair.after_manhattan, "stable-spacing control does not falsely cue")
	for index in range(5, 9):
		_send_action(scene, WITNESS[index])
	var changed: Dictionary = scene.get_presentation_snapshot().echo_divergence
	_expect(changed.visible and changed.detail == "E2 BLOCKED · E4 MOVED" and changed.pair.before_manhattan == 2 and changed.pair.after_manhattan == 1, "required BLOCKED/MOVED divergence is truthfully visible")
	for index in range(9, WITNESS.size()):
		_send_action(scene, WITNESS[index])
	_expect(scene.state.completed and scene.state.player_position == level.exit.position, "reusable Gameplay completes exact bridge witness")
	scene.queue_free()
	await tree.process_frame


func _solve(data: Dictionary) -> Dictionary:
	var checked := LevelLoader.new().validate_dict(data)
	return Solver.new().solve(checked.level, LIMITS) if checked.ok else checked


func _echo_position(state: Dictionary, id: String) -> Array:
	return state.echo_positions.filter(func(echo): return echo.id == id)[0].position


func _required_role(state: Dictionary) -> bool:
	return _echo_position(state, "echo_near") == [5, 3] and _echo_position(state, "echo_late") == [6, 5] and state.player_position == [6, 3] and state.door_states[0].open


func _reversed_role(state: Dictionary) -> bool:
	return _echo_position(state, "echo_near") == [6, 5] and _echo_position(state, "echo_late") == [5, 3]


func _is_blocked_moved_spacing_change(before: Dictionary, transitioned: Dictionary) -> bool:
	var outcomes := {}
	for actor in transitioned.actor_actions.echoes:
		var from: Array = _echo_position(before, actor.id)
		var to: Array = _echo_position(transitioned.state, actor.id)
		outcomes[actor.id] = "WAITED" if actor.action == "WAIT" else ("BLOCKED" if from == to else "MOVED")
	if not outcomes.values().has("BLOCKED") or not outcomes.values().has("MOVED"):
		return false
	var before_vector := _relative_vector(before)
	var after_vector := _relative_vector(transitioned.state)
	return before_vector != after_vector or absi(before_vector[0]) + absi(before_vector[1]) != absi(after_vector[0]) + absi(after_vector[1])


func _relative_vector(state: Dictionary) -> Array:
	var near := _echo_position(state, "echo_near")
	var late := _echo_position(state, "echo_late")
	return [near[0] - late[0], near[1] - late[1]]


func _terrain_distance(start: Array, target: Array) -> int:
	var queue := [start]
	var distances := {str(start): 0}
	var head := 0
	while head < queue.size():
		var cell: Array = queue[head]
		head += 1
		if cell == target:
			return distances[str(cell)]
		for delta in [[0, -1], [1, 0], [0, 1], [-1, 0]]:
			var next := [cell[0] + delta[0], cell[1] + delta[1]]
			if _floor(next) and not distances.has(str(next)):
				distances[str(next)] = distances[str(cell)] + 1
				queue.append(next)
	return -1


func _terrain_reaches_exit_without(blocked: Array) -> bool:
	var queue := [level.player_spawn]
	var seen := {str(level.player_spawn): true}
	var head := 0
	while head < queue.size():
		var cell: Array = queue[head]
		head += 1
		if cell == level.exit.position:
			return true
		for delta in [[0, -1], [1, 0], [0, 1], [-1, 0]]:
			var next := [cell[0] + delta[0], cell[1] + delta[1]]
			if next != blocked and _floor(next) and not seen.has(str(next)):
				seen[str(next)] = true
				queue.append(next)
	return false


func _floor(cell: Array) -> bool:
	return cell[1] >= 0 and cell[1] < level.terrain_rows.size() and cell[0] >= 0 and cell[0] < level.terrain_rows[cell[1]].length() and level.terrain_rows[cell[1]][cell[0]] == "."


func _shortest_from_state(start_state: Dictionary, depth_limit: int) -> Dictionary:
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
			states[next_key] = transitioned.state
			depths[next_key] = next_depth
			queue.append(next_key)
	return {"status": "UNSOLVABLE_WITHIN_COMPLETE_FINITE_STATE", "visited_states": states.size()}


func _send_action(scene: Node, action: String) -> void:
	var event := InputEventAction.new()
	event.action = {"UP": "move_up", "RIGHT": "move_right", "DOWN": "move_down", "LEFT": "move_left", "WAIT": "wait_turn"}[action]
	event.pressed = true
	scene._unhandled_input(event)


func _expect(condition: bool, label: String) -> void:
	assertions += 1
	if not condition:
		failures += 1
		printerr("TEST_FAIL: " + label)

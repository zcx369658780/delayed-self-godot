class_name DelayedSelfBfsSolver
extends RefCounted

const Simulation = preload("res://scripts/simulation/simulation.gd")
const ACTIONS := ["UP", "RIGHT", "DOWN", "LEFT", "WAIT"]


func solve(level: Dictionary, limits: Dictionary = {}) -> Dictionary:
	var depth_limit: int = limits.get("depth_limit", 64)
	var state_limit: int = limits.get("state_limit", 100000)
	var time_limit_ms: int = limits.get("time_limit_ms", 5000)
	var solution_count_cap: int = limits.get("solution_count_cap", 1000000)
	var configured := {"depth_limit": depth_limit, "state_limit": state_limit, "time_limit_ms": time_limit_ms, "solution_count_cap": solution_count_cap}
	var simulation := Simulation.new()
	var initial := simulation.construct_initial_state(level)
	var initial_key := simulation.canonical_key(initial)
	var queue: Array = [initial_key]
	var states := {initial_key: initial}
	var depths := {initial_key: 0}
	var counts := {initial_key: 1}
	var predecessors := {initial_key: null}
	var head := 0
	var maximum_frontier := 1
	var goal_depth := -1
	var goal_keys: Array = []
	var count_capped := false
	var depth_cutoff := false
	var started := Time.get_ticks_msec()
	while head < queue.size():
		if Time.get_ticks_msec() - started >= time_limit_ms:
			return _limited("TIME_LIMIT", configured, states.size(), maximum_frontier)
		var key: String = queue[head]
		head += 1
		var depth: int = depths[key]
		if goal_depth >= 0 and depth >= goal_depth:
			continue
		if depth >= depth_limit:
			depth_cutoff = true
			continue
		for action in ACTIONS:
			var transitioned := simulation.transition(level, states[key], action)
			if not transitioned.ok:
				continue
			var next_state: Dictionary = transitioned.state
			var next_key := simulation.canonical_key(next_state)
			var next_depth := depth + 1
			var incoming_count: int = counts[key]
			if not depths.has(next_key):
				if states.size() >= state_limit:
					return _limited("STATE_LIMIT", configured, states.size(), maximum_frontier)
				depths[next_key] = next_depth
				counts[next_key] = mini(incoming_count, solution_count_cap)
				count_capped = count_capped or incoming_count >= solution_count_cap
				states[next_key] = next_state
				predecessors[next_key] = {"previous": key, "action": action}
				queue.append(next_key)
				maximum_frontier = maxi(maximum_frontier, queue.size() - head)
			elif depths[next_key] == next_depth:
				var total: int = counts[next_key] + incoming_count
				if total >= solution_count_cap:
					count_capped = count_capped or total > solution_count_cap
				counts[next_key] = mini(total, solution_count_cap)
			if next_state.completed:
				if goal_depth < 0:
					goal_depth = next_depth
				if next_depth == goal_depth and not goal_keys.has(next_key):
					goal_keys.append(next_key)
	if goal_depth >= 0:
		goal_keys.sort()
		var total_solutions := 0
		for goal_key in goal_keys:
			var added: int = counts[goal_key]
			if total_solutions + added > solution_count_cap:
				count_capped = true
			total_solutions = mini(solution_count_cap, total_solutions + added)
		var replay_key: String = goal_keys[0]
		var solution: Array = []
		while predecessors[replay_key] != null:
			solution.push_front(predecessors[replay_key].action)
			replay_key = predecessors[replay_key].previous
		return {"status": "SOLVED", "shortest_turn_count": goal_depth, "solution": solution, "shortest_solution_count": total_solutions, "shortest_solution_count_status": "CAPPED" if count_capped else "EXACT", "visited_states": states.size(), "maximum_frontier": maximum_frontier, "limits": configured}
	return {"status": "DEPTH_LIMIT" if depth_cutoff else "UNSOLVABLE_WITHIN_COMPLETE_FINITE_STATE", "visited_states": states.size(), "maximum_frontier": maximum_frontier, "limits": configured}


func _limited(status: String, configured: Dictionary, visited: int, frontier: int) -> Dictionary:
	return {"status": status, "visited_states": visited, "maximum_frontier": frontier, "limits": configured}

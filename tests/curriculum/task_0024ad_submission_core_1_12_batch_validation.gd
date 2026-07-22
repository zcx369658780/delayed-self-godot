extends SceneTree

const LevelLoader = preload("res://scripts/simulation/level_loader.gd")
const Simulation = preload("res://scripts/simulation/simulation.gd")
const Solver = preload("res://scripts/solver/bfs_solver.gd")
const CatalogLoader = preload("res://scripts/app/catalog_loader.gd")

const ENTRIES := [
	{"sequence": 1, "id": "tutorial_reach_exit", "sha256": "38e466bb5922f1987a99d79c7527a4a8eab8e6cfdbe76fd8159f80b0a40cf2c4", "classification": "FORMAL_CATALOGED", "l": 3, "n": 3, "limits": {"depth_limit": 16, "state_limit": 10000, "time_limit_ms": 5000, "solution_count_cap": 1000000}},
	{"sequence": 2, "id": "tutorial_echo_bridge", "sha256": "681d99057c4e6034a490644d75960ff23d8f43bd1b91850f48179b79fc04a3cf", "classification": "FORMAL_CATALOGED", "l": 9, "n": 12, "limits": {"depth_limit": 32, "state_limit": 100000, "time_limit_ms": 10000, "solution_count_cap": 1000000}},
	{"sequence": 3, "id": "vertical_slice_delay_3", "sha256": "8751da5051fbebaaa5ae7c895d9be9f086e8d8f2e87876a80c379dc06262f1d8", "classification": "FORMAL_CATALOGED", "l": 9, "n": 31, "limits": {"depth_limit": 32, "state_limit": 100000, "time_limit_ms": 10000, "solution_count_cap": 1000000}},
	{"sequence": 4, "id": "door_one_turn_late", "sha256": "1775cf89ae4a94f65a76dac2b791a31395443de88205d0ed1b6233331dbda577", "classification": "FORMAL_CATALOGED", "l": 9, "n": 7, "limits": {"depth_limit": 32, "state_limit": 100000, "time_limit_ms": 10000, "solution_count_cap": 1000000}},
	{"sequence": 5, "id": "two_keys_one_door", "sha256": "f4c6791dfc84d17fb450721e654091a2baeb522e55d660a5d73878cd977651cd", "classification": "FORMAL_CATALOGED", "l": 12, "n": 1, "limits": {"depth_limit": 40, "state_limit": 100000, "time_limit_ms": 10000, "solution_count_cap": 1000000}},
	{"sequence": 6, "id": "staggered_doors", "sha256": "3f14c19b50775e36dd5b52664798381cf1292b0a30b377641c03435f45696bc8", "classification": "FORMAL_CATALOGED", "l": 15, "n": 4, "limits": {"depth_limit": 48, "state_limit": 250000, "time_limit_ms": 20000, "solution_count_cap": 1000000}},
	{"sequence": 7, "id": "echo_spacing_bridge", "sha256": "805cdc05ea9b3805189ba7be4938cb7ede4e7056b9ae9a7e911df96a801d58ee", "classification": "FORMAL_CATALOGED", "l": 16, "n": 12, "limits": {"depth_limit": 56, "state_limit": 300000, "time_limit_ms": 25000, "solution_count_cap": 1000000}},
	{"sequence": 8, "id": "two_echo_convergence", "sha256": "772410d3b8bb807e35472ee2a7d07b703de66e1e0e92ffb4d1ff8433a345d5fd", "classification": "FORMAL_CATALOGED_CURRENT_FINALE", "l": 19, "n": 6, "limits": {"depth_limit": 64, "state_limit": 300000, "time_limit_ms": 30000, "solution_count_cap": 1000000}},
	{"sequence": 9, "id": "crate_shadow_timing", "sha256": "1910f4dc07b1ee508ddbc529b0f0d02db5ca8a3a16a7a277ed236b4efbbe50d1", "classification": "ACCEPTED_UNCATALOGUED_CANDIDATE", "l": 14, "n": 6, "limits": {"depth_limit": 48, "state_limit": 250000, "time_limit_ms": 20000, "solution_count_cap": 1000000}},
	{"sequence": 10, "id": "key_route_commitment", "sha256": "2c44c8cdeeeb6f502f5c5d9dda87883dd762515348ee3c4b6d71d34fde276a2a", "classification": "ACCEPTED_UNCATALOGUED_CANDIDATE", "l": 19, "n": 8, "limits": {"depth_limit": 56, "state_limit": 400000, "time_limit_ms": 25000, "solution_count_cap": 1000000}},
	{"sequence": 11, "id": "identity_shift_bridge", "sha256": "8856d3c64978cef7cff7f1680a7ae2f412c9b0cab058d598cbe3aee0225052e0", "classification": "ACCEPTED_UNCATALOGUED_FALLBACK_CANDIDATE", "l": 18, "n": 1, "limits": {"depth_limit": 64, "state_limit": 750000, "time_limit_ms": 35000, "solution_count_cap": 1000000}},
	{"sequence": 12, "id": "lasting_echo_latch", "sha256": "a1d7dcd30832cfdcfe93ead34884fa5a21fd19ef3cafa481860688640bd5ea5f", "classification": "ACCEPTED_UNCATALOGUED_FINALE_CANDIDATE_ONLY", "l": 21, "n": 6, "limits": {"depth_limit": 80, "state_limit": 1000000, "time_limit_ms": 45000, "solution_count_cap": 1000000}},
]

var loader := LevelLoader.new()
var simulation := Simulation.new()
var solver := Solver.new()
var failures := 0
var rows: Array = []


func _init() -> void:
	_run()
	if failures > 0:
		printerr("TASK_0024AD_SUBMISSION_CORE_1_12_BATCH_FAIL failures=%d" % failures)
		quit(1)
		return
	_emit_records()
	print("TASK_0024AD_SUBMISSION_CORE_1_12_BATCH_PASS")
	quit(0)


func _run() -> void:
	_test_catalog()
	var seen := {}
	for entry in ENTRIES:
		var path := "res://data/levels/%s.json" % entry.id
		_require(FileAccess.file_exists(path), "exists_%02d" % entry.sequence)
		_require(FileAccess.get_sha256(path) == entry.sha256, "sha256_%02d" % entry.sequence)
		var loaded: Dictionary = loader.load_file(path)
		_require(loaded.ok, "load_%02d" % entry.sequence)
		if not loaded.ok:
			continue
		var level: Dictionary = loaded.level
		_require(level.level_id == entry.id and not seen.has(level.level_id), "identity_%02d" % entry.sequence)
		seen[level.level_id] = true
		_require(not str(level.title).is_empty(), "title_%02d" % entry.sequence)
		_require(level.terrain_rows.size() > 0 and level.terrain_rows[0].length() > 0, "dimensions_%02d" % entry.sequence)
		if entry.sequence >= 9:
			var raw := _raw_json(path)
			_require(not raw.has("sequence") and not raw.has("unlock") and not raw.has("unlock_prerequisites") and not raw.has("final_level") and not raw.has("profile"), "candidate_no_product_state_%02d" % entry.sequence)
		var started := Time.get_ticks_msec()
		var solved: Dictionary = solver.solve(level, entry.limits)
		var elapsed_ms := Time.get_ticks_msec() - started
		_require(solved.status == "SOLVED", "solved_%02d" % entry.sequence)
		if solved.status != "SOLVED":
			continue
		_require(solved.shortest_solution_count_status == "EXACT", "exact_n_%02d" % entry.sequence)
		_require(solved.shortest_turn_count == entry.l and solved.shortest_solution_count == entry.n, "accepted_metrics_%02d" % entry.sequence)
		var replay_a: Dictionary = simulation.replay(level, solved.solution)
		var replay_b: Dictionary = simulation.replay(level, solved.solution)
		_require(replay_a.ok and replay_a.state.completed and replay_b.ok and replay_b.state.completed, "replay_complete_%02d" % entry.sequence)
		_require(replay_a.state == replay_b.state and replay_a.canonical_keys == replay_b.canonical_keys, "deterministic_replay_%02d" % entry.sequence)
		var restart: Dictionary = simulation.restart(level)
		_require(restart.ok and restart.state == simulation.construct_initial_state(level), "restart_%02d" % entry.sequence)
		_require(_echo_exit_nonterminal(level), "you_only_exit_%02d" % entry.sequence)
		var witness := _witness_counts(level, solved.solution)
		rows.append({
			"sequence": entry.sequence, "level_id": entry.id, "title": level.title, "schema_version": level.schema_version,
			"classification": entry.classification, "sha256": entry.sha256, "width": level.terrain_rows[0].length(), "height": level.terrain_rows.size(),
			"families": _family_counts(level), "solver": {"status": solved.status, "l": solved.shortest_turn_count, "n": solved.shortest_solution_count, "n_status": solved.shortest_solution_count_status, "visited": solved.visited_states, "frontier": solved.maximum_frontier, "elapsed_ms": elapsed_ms, "limits": solved.limits},
			"witness": {"actions": solved.solution, "waits": witness.waits, "blocked_you": witness.blocked_you, "max_repeated_blocked": witness.max_repeated_blocked},
			"replay": {"completed": replay_a.state.completed, "deterministic": replay_a.state == replay_b.state and replay_a.canonical_keys == replay_b.canonical_keys, "canonical_trace_length": replay_a.canonical_keys.size()}, "restart_exact": restart.ok and restart.state == simulation.construct_initial_state(level), "you_only_exit": true,
		})
	_require(rows.size() == 12 and seen.size() == 12, "twelve_unique_rows")


func _test_catalog() -> void:
	var loaded: Dictionary = CatalogLoader.new().load_file("res://data/catalog/level_catalog_v1.json")
	_require(loaded.ok, "catalog_load")
	if not loaded.ok:
		return
	var entries: Array = loaded.catalog.entries
	_require(entries.size() == 8, "catalog_eight")
	var final_count := 0
	for index in entries.size():
		_require(entries[index].sequence == index + 1 and entries[index].level_id == ENTRIES[index].id, "catalog_order_%02d" % (index + 1))
		if entries[index].final_level:
			final_count += 1
			_require(entries[index].level_id == "two_echo_convergence", "catalog_final_id")
	for index in range(8, 12):
		_require(not entries.any(func(value): return value.level_id == ENTRIES[index].id), "candidate_absent_%02d" % (index + 1))
	_require(final_count == 1, "sole_formal_finale")


func _raw_json(path: String) -> Dictionary:
	var file := FileAccess.open(path, FileAccess.READ)
	var parsed = JSON.parse_string(file.get_as_text()) if file != null else null
	return parsed if parsed is Dictionary else {}


func _echo_exit_nonterminal(level: Dictionary) -> bool:
	if level.echoes.is_empty():
		return true
	var state: Dictionary = simulation.construct_initial_state(level)
	state.echo_positions[0].position = level.exit.position.duplicate()
	state.completed = false
	var result: Dictionary = simulation.transition(level, state, "WAIT")
	return result.ok and not result.state.completed


func _witness_counts(level: Dictionary, actions: Array) -> Dictionary:
	var state: Dictionary = simulation.construct_initial_state(level)
	var waits := 0
	var blocked := 0
	var repeated := 0
	var maximum := 0
	var previous := ""
	for action_value in actions:
		var action: String = action_value
		var before: Array = state.player_position.duplicate()
		var result: Dictionary = simulation.transition(level, state, action)
		if not result.ok:
			continue
		state = result.state
		if action == "WAIT":
			waits += 1
		var is_blocked: bool = action != "WAIT" and before == state.player_position
		if is_blocked:
			blocked += 1
			repeated = repeated + 1 if previous == action else 1
			previous = action
			maximum = maxi(maximum, repeated)
		else:
			repeated = 0
			previous = ""
	return {"waits": waits, "blocked_you": blocked, "max_repeated_blocked": maximum}


func _family_counts(level: Dictionary) -> Dictionary:
	return {"echoes": level.get("echoes", []).size(), "plates": level.get("plates", []).size(), "doors": level.get("doors", []).size(), "crates": level.get("crates", []).size(), "keys": level.get("keys", []).size(), "locks": level.get("locks", []).size(), "barrier_groups": level.get("barrier_groups", []).size(), "sensors": level.get("sensors", []).size(), "latches": level.get("latches", []).size()}


func _emit_records() -> void:
	for row in rows:
		_emit("TASK_0024AD_MANIFEST_JSON", {"sequence": row.sequence, "level_id": row.level_id, "title": row.title, "schema_version": row.schema_version, "classification": row.classification, "sha256": row.sha256, "width": row.width, "height": row.height, "families": row.families})
		_emit("TASK_0024AD_METRICS_JSON", {"sequence": row.sequence, "level_id": row.level_id, "solver": row.solver, "witness": row.witness})
		_emit("TASK_0024AD_REPLAY_JSON", {"sequence": row.sequence, "level_id": row.level_id, "replay": row.replay, "restart_exact": row.restart_exact, "you_only_exit": row.you_only_exit})
	_emit("TASK_0024AD_CATALOG_JSON", {"entry_count": 8, "ordered_ids": ENTRIES.slice(0, 8).map(func(value): return value.id), "candidate_ids_absent": ENTRIES.slice(8, 12).map(func(value): return value.id), "sole_finale": "two_echo_convergence"})
	_emit("TASK_0024AD_BATCH_JSON", {"status": "PASS", "level_count": rows.size(), "solved_count": rows.filter(func(value): return value.solver.status == "SOLVED").size(), "exact_count": rows.filter(func(value): return value.solver.n_status == "EXACT").size(), "cataloged_count": 8, "candidate_count": 4})


func _emit(prefix: String, payload: Dictionary) -> void:
	print(prefix + " " + JSON.stringify(payload))


func _require(condition: bool, label: String) -> void:
	if not condition:
		failures += 1
		printerr("TASK_0024AD_SUBMISSION_CORE_1_12_BATCH_FAIL " + label)

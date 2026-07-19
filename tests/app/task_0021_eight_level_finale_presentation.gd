extends RefCounted

const AppRootScene = preload("res://scenes/app/app_root.tscn")
const GameplayScene = preload("res://scenes/vertical_slice/vertical_slice.tscn")
const CatalogLoader = preload("res://scripts/app/catalog_loader.gd")

const CATALOG_PATH := "res://data/catalog/level_catalog_v1.json"
const CATALOG_HASH := "a2bfa892f77370ac4d7e93ba5b6ce5970f0d7ba75160e1b2d00c4384f3da4e51"
const FORMAL_HASHES := {
	"res://data/levels/tutorial_reach_exit.json": "38e466bb5922f1987a99d79c7527a4a8eab8e6cfdbe76fd8159f80b0a40cf2c4",
	"res://data/levels/tutorial_echo_bridge.json": "681d99057c4e6034a490644d75960ff23d8f43bd1b91850f48179b79fc04a3cf",
	"res://data/levels/vertical_slice_delay_3.json": "8751da5051fbebaaa5ae7c895d9be9f086e8d8f2e87876a80c379dc06262f1d8",
	"res://data/levels/door_one_turn_late.json": "1775cf89ae4a94f65a76dac2b791a31395443de88205d0ed1b6233331dbda577",
	"res://data/levels/two_keys_one_door.json": "f4c6791dfc84d17fb450721e654091a2baeb522e55d660a5d73878cd977651cd",
	"res://data/levels/staggered_doors.json": "3f14c19b50775e36dd5b52664798381cf1292b0a30b377641c03435f45696bc8",
	"res://data/levels/echo_spacing_bridge.json": "805cdc05ea9b3805189ba7be4938cb7ede4e7056b9ae9a7e911df96a801d58ee",
	"res://data/levels/two_echo_convergence.json": "772410d3b8bb807e35472ee2a7d07b703de66e1e0e92ffb4d1ff8433a345d5fd",
}
const FINAL_WITNESS := ["RIGHT", "RIGHT", "RIGHT", "RIGHT", "RIGHT", "RIGHT", "UP", "UP", "UP", "LEFT", "RIGHT", "DOWN", "DOWN", "UP", "DOWN", "UP", "UP", "UP", "UP"]
const FINAL_COPY := "THE SIGNAL ARRIVED LATE.\nIT WAS HEARD.\n\nEnter / Space: Level Select\nR: Replay"

var assertions := 0
var failures := 0


func run(tree: SceneTree) -> Dictionary:
	_test_catalog_hashes_and_trigger_source()
	await _test_non_final_completion_and_product_baselines(tree)
	await _test_normal_unlocked_final_record_once_replay_and_escape(tree)
	await _test_acknowledgement_input_guards(tree)
	await _test_development_direct_final_branch(tree)
	return {"assertions": assertions, "failures": failures}


func _test_catalog_hashes_and_trigger_source() -> void:
	var catalog := CatalogLoader.new().load_file(CATALOG_PATH)
	_expect(catalog.ok and catalog.catalog.entries.size() == 8, "Task 0021 retains the exact eight-entry validated catalog")
	if catalog.ok:
		var non_final: Dictionary = catalog.catalog.entries[0]
		var final: Dictionary = catalog.catalog.entries[7]
		_expect(not non_final.final_level and final.final_level and final.sequence == 8, "catalog-derived route facts distinguish a non-final control and sole sequence-8 final")
	_expect(FileAccess.get_sha256(CATALOG_PATH) == CATALOG_HASH, "Task 0021 catalog hash remains exact")
	_expect(FORMAL_HASHES.keys().all(func(path): return FileAccess.get_sha256(path) == FORMAL_HASHES[path]), "all eight formal level hashes remain exact")
	var app_source := FileAccess.get_file_as_string("res://scripts/app/app_root.gd")
	var gameplay_source := FileAccess.get_file_as_string("res://scripts/gameplay/vertical_slice.gd")
	_expect(not app_source.contains("two_echo_convergence") and not gameplay_source.contains("two_echo_convergence"), "new implementation path contains no hard-coded final level identity")
	_expect(app_source.contains("payload.get(\"final_level\", false)") and gameplay_source.contains("route_payload.get(\"final_level\", false)"), "AppRoot and Gameplay use only the validated route final_level fact")


func _test_non_final_completion_and_product_baselines(tree: SceneTree) -> void:
	var app = await _spawn_app(tree)
	app.select_level("tutorial_reach_exit")
	await tree.process_frame
	var gameplay = app.get_active_screen()
	_expect(app.get_current_route() == "GAMEPLAY" and not gameplay.get_route_payload().final_level, "non-final catalog selection carries final_level=false")
	for action in ["UP", "RIGHT", "RIGHT"]:
		_send_simulation_action(gameplay, action)
	await tree.process_frame
	var progress: Dictionary = app.get_progress_snapshot()
	_expect(app.get_current_route() == "LEVEL_SELECT" and progress.completed_level_ids == ["tutorial_reach_exit"] and progress.best_turns.tutorial_reach_exit == 3, "non-final completion records once and automatically returns to Level Select")
	print("TASK_0021_NON_FINAL_ROUTE_TRACE=" + JSON.stringify({"route": app.get_current_route(), "completed_level_ids": progress.completed_level_ids, "best_turns": progress.best_turns, "unlocked_level_ids": progress.unlocked_level_ids}))
	var level_select: Dictionary = app.get_active_screen().get_screen_snapshot()
	_expect(level_select.entries.size() == 8 and level_select.entries[1].unlocked and level_select.scroll.horizontal_maximum == 0, "Level Select progression and bounded scrolling remain intact")
	_expect(app.get_window_presentation_snapshot(Vector2i(1280, 800)).content_rect == Rect2(0, 40, 1280, 720), "accepted resize/window presentation remains intact")
	app.navigate("UNKNOWN_0021_ROUTE")
	await tree.process_frame
	_expect(app.get_current_route() == "SAFE_ERROR" and app.get_active_screen().get_screen_snapshot().error_code == "APP_UNKNOWN_ROUTE", "Safe Error routing remains intact")
	app._progress.reset_test_profile()
	_expect(app.get_progress_snapshot().completed_level_ids.is_empty() and app.get_progress_snapshot().unlocked_level_ids == ["tutorial_reach_exit"], "reset test profile remains deterministic")
	app.queue_free()
	await tree.process_frame


func _test_normal_unlocked_final_record_once_replay_and_escape(tree: SceneTree) -> void:
	var app = await _spawn_app(tree)
	var catalog: Dictionary = app.get_catalog_snapshot()
	var accepted_turns := [3, 9, 9, 9, 12, 15, 16]
	for index in 7:
		_expect(app._progress.record_completion(catalog.entries[index].level_id, accepted_turns[index]), "normal final setup records prerequisite " + catalog.entries[index].level_id)
	app.select_level(catalog.entries[7].level_id)
	await tree.process_frame
	var gameplay = app.get_active_screen()
	var payload: Dictionary = gameplay.get_route_payload()
	var initial_state: Dictionary = gameplay.state.duplicate(true)
	_expect(app.get_current_route() == "GAMEPLAY" and payload.final_level and payload.level_id == catalog.entries[7].level_id, "normal unlocked final route carries the catalog-derived final fact")
	_expect(gameplay.get_final_acknowledgement_state().is_empty() and gameplay.get_hud_snapshot().completion.is_empty(), "final acknowledgment is absent before ordinary completion")
	var initial_timeline: Dictionary = gameplay.get_timeline_snapshot()
	var before_help_state: Dictionary = gameplay.state.duplicate(true)
	gameplay.toggle_help()
	_expect(gameplay.get_hud_snapshot().help_expanded and gameplay.state == before_help_state and gameplay.get_timeline_snapshot() == initial_timeline, "Help and Timeline remain unchanged and zero-turn before final acknowledgment")
	gameplay.toggle_help()

	_replay_witness(gameplay)
	await tree.process_frame
	var completed_state: Dictionary = gameplay.state.duplicate(true)
	var completed_key: String = gameplay.get_hud_snapshot().canonical_key
	var progress: Dictionary = app.get_progress_snapshot()
	var hud: Dictionary = gameplay.get_hud_snapshot()
	_expect(app.get_current_route() == "GAMEPLAY" and progress.completed_level_ids.has(payload.level_id) and progress.best_turns[payload.level_id] == 19, "normal unlocked final completion records once and remains in Gameplay")
	print("TASK_0021_FINAL_ROUTE_PROGRESS_TRACE=" + JSON.stringify({"route": app.get_current_route(), "payload_final_level": payload.final_level, "completed_level_ids": progress.completed_level_ids, "best_turns": progress.best_turns, "acknowledgement_state": hud.final_acknowledgement_state, "canonical_key": completed_key, "state": completed_state}))
	_expect(hud.final_acknowledgement_state == "FINAL_ACKNOWLEDGEMENT_VISIBLE" and hud.completion == FINAL_COPY, "final completion shows the exact deterministic acknowledgment copy and state")
	_expect(not hud.help_expanded and not gameplay.get_presentation_snapshot().timeline_visible, "final acknowledgment hides Help and Timeline")
	gameplay.set_reduced_motion_for_test(true)
	var final_presentation: Dictionary = gameplay.get_presentation_snapshot()
	_expect(final_presentation.reduced_motion and final_presentation.surfaces.completion.visible and final_presentation.surfaces.completion.rect == Rect2(84, 170, 480, 200) and final_presentation.surfaces.completion.font_size == 22, "static final acknowledgment surface stays bounded and readable at 960x540 with reduced motion")
	_send_help_key(gameplay)
	_send_simulation_action(gameplay, "LEFT")
	_expect(gameplay.state == completed_state and gameplay.get_hud_snapshot().canonical_key == completed_key and not gameplay.get_hud_snapshot().help_expanded, "H and movement cannot mutate or open interaction during acknowledgment")
	app._on_gameplay_completed(payload.level_id, 1, gameplay)
	_expect(app.get_progress_snapshot().best_turns[payload.level_id] == 19 and app.get_current_route() == "GAMEPLAY", "repeated completion callback cannot double-record or double-route")

	_send_scene_action(gameplay, "restart_level")
	_expect(gameplay.state == initial_state and gameplay.get_final_acknowledgement_state().is_empty(), "R restores the exact initial state and clears final acknowledgment")
	_replay_witness(gameplay)
	await tree.process_frame
	_expect(gameplay.get_final_acknowledgement_state() == "FINAL_ACKNOWLEDGEMENT_VISIBLE" and app.get_progress_snapshot().best_turns[payload.level_id] == 19, "recompletion after replay reopens acknowledgment without a second progress record")
	app._on_gameplay_completed(payload.level_id, 1, gameplay)
	_expect(app.get_progress_snapshot().best_turns[payload.level_id] == 19, "same-session replay remains guarded against a lower fake duplicate result")
	_send_scene_action(gameplay, "ui_cancel")
	await tree.process_frame
	_expect(app.get_current_route() == "LEVEL_SELECT" and app.get_active_screen_count() == 1, "Esc returns once through the existing Level Select route")
	app.queue_free()
	await tree.process_frame


func _test_acknowledgement_input_guards(tree: SceneTree) -> void:
	await _assert_acknowledgement_action_once(tree, "ui_accept", "Enter/ui_accept")
	await _assert_acknowledgement_action_once(tree, "wait_turn", "Space/wait_turn")
	await _assert_acknowledgement_action_once(tree, "ui_cancel", "Esc/ui_cancel")


func _assert_acknowledgement_action_once(tree: SceneTree, action: String, label: String) -> void:
	var gameplay = await _spawn_direct_gameplay(tree)
	_replay_witness(gameplay)
	var completed_state: Dictionary = gameplay.state.duplicate(true)
	var completed_key: String = gameplay.get_hud_snapshot().canonical_key
	var returns := [0]
	gameplay.request_back.connect(func(): returns[0] += 1)
	_expect(gameplay.get_final_acknowledgement_state() == "FINAL_ACKNOWLEDGEMENT_VISIBLE", label + " control starts from visible final acknowledgment")
	_send_scene_action(gameplay, action)
	_send_scene_action(gameplay, action)
	print("TASK_0021_RETURN_TRACE=" + JSON.stringify({"action": action, "returns": returns[0], "state_equal": gameplay.state == completed_state, "key_equal": gameplay.get_hud_snapshot().canonical_key == completed_key, "requested": gameplay.get_hud_snapshot().acknowledgement_return_requested}))
	_expect(returns[0] == 1 and gameplay.state == completed_state and gameplay.get_hud_snapshot().canonical_key == completed_key, label + " requests Level Select once without entering Simulation")
	gameplay.queue_free()
	await tree.process_frame


func _test_development_direct_final_branch(tree: SceneTree) -> void:
	var app = await _spawn_app(tree)
	var catalog: Dictionary = app.get_catalog_snapshot()
	var final_entry: Dictionary = catalog.entries.filter(func(entry): return entry.final_level)[0]
	app.boot_with_user_args(["--level-id=" + final_entry.level_id])
	await tree.process_frame
	var gameplay = app.get_active_screen()
	_expect(app.get_current_route() == "GAMEPLAY" and gameplay.get_route_payload().development_direct and gameplay.get_route_payload().final_level, "development-direct final route retains the catalog-derived final fact")
	_replay_witness(gameplay)
	await tree.process_frame
	_expect(app.get_current_route() == "GAMEPLAY" and gameplay.get_final_acknowledgement_state() == "FINAL_ACKNOWLEDGEMENT_VISIBLE", "development-direct final completion uses the presentation branch without hard-coded identity")
	_expect(app.get_progress_snapshot().completed_level_ids.is_empty(), "locked development-direct completion does not weaken the progress contract")
	print("TASK_0021_DIRECT_FINAL_TRACE=" + JSON.stringify({"route": app.get_current_route(), "payload": gameplay.get_route_payload(), "acknowledgement_state": gameplay.get_final_acknowledgement_state(), "progress": app.get_progress_snapshot()}))
	app._on_gameplay_completed(final_entry.level_id, 1, gameplay)
	_expect(app.get_progress_snapshot().completed_level_ids.is_empty() and app.get_current_route() == "GAMEPLAY", "repeated direct completion cannot record or route")
	app.queue_free()
	await tree.process_frame


func _spawn_app(tree: SceneTree):
	var app = AppRootScene.instantiate()
	tree.root.add_child(app)
	await tree.process_frame
	return app


func _spawn_direct_gameplay(tree: SceneTree):
	var catalog := CatalogLoader.new().load_file(CATALOG_PATH)
	var final_entry: Dictionary = catalog.catalog.entries.filter(func(entry): return entry.final_level)[0]
	var gameplay = GameplayScene.instantiate()
	gameplay.configure_route_payload({
		"level_id": final_entry.level_id,
		"level_path": final_entry.level_path,
		"hud_mode": final_entry.hud_mode,
		"classification": final_entry.classification,
		"development_direct": true,
		"final_level": final_entry.final_level,
	})
	tree.root.add_child(gameplay)
	await tree.process_frame
	return gameplay


func _replay_witness(gameplay: Node) -> void:
	for action in FINAL_WITNESS:
		_send_simulation_action(gameplay, action)


func _send_scene_action(scene: Node, action: String) -> void:
	var event := InputEventAction.new()
	event.action = action
	event.pressed = true
	scene._unhandled_input(event)


func _send_help_key(scene: Node) -> void:
	var event := InputEventKey.new()
	event.keycode = KEY_H
	event.pressed = true
	scene._unhandled_input(event)


func _send_simulation_action(scene: Node, action: String) -> void:
	var input_actions := {"UP": "move_up", "RIGHT": "move_right", "DOWN": "move_down", "LEFT": "move_left", "WAIT": "wait_turn"}
	_send_scene_action(scene, input_actions[action])


func _expect(condition: bool, label: String) -> void:
	assertions += 1
	if not condition:
		failures += 1
		printerr("TEST_FAIL: " + label)

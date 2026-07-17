extends RefCounted

const AppRootScene = preload("res://scenes/app/app_root.tscn")
const GameplayScene = preload("res://scenes/vertical_slice/vertical_slice.tscn")
const WITNESS := ["RIGHT", "RIGHT", "RIGHT", "RIGHT", "RIGHT", "RIGHT", "UP", "UP", "UP", "LEFT", "RIGHT", "DOWN", "DOWN", "UP", "DOWN", "UP", "UP", "UP", "UP"]

var assertions := 0
var failures := 0


func run(tree: SceneTree) -> Dictionary:
	await _test_zero_and_single_echo_controls(tree)
	await _test_transition_derived_feedback(tree)
	await _test_direct_and_app_routes(tree)
	return {"assertions": assertions, "failures": failures}


func _test_zero_and_single_echo_controls(tree: SceneTree) -> void:
	var zero = await _spawn_gameplay(tree, "tutorial_reach_exit", "res://data/levels/tutorial_reach_exit.json", "INTRO_MINIMAL", false)
	var zero_snapshot: Dictionary = zero.get_presentation_snapshot()
	_expect(zero_snapshot.has("echo_divergence") and not zero_snapshot.echo_divergence.visible and zero_snapshot.echo_divergence.actors.is_empty(), "zero-ECHO presentation keeps divergence feedback hidden")
	zero.queue_free()
	await tree.process_frame

	var single = await _spawn_gameplay(tree, "tutorial_echo_bridge", "res://data/levels/tutorial_echo_bridge.json", "GUIDED_ECHO", false)
	var single_initial: Dictionary = single.get_presentation_snapshot()
	_expect(single_initial.has("echo_divergence") and not single_initial.echo_divergence.visible and single_initial.echo_divergence.actors.is_empty(), "single-ECHO initial presentation exposes deterministic hidden divergence feedback")
	for action in ["RIGHT", "RIGHT", "UP", "DOWN"]:
		_send_action(single, action)
	var single_after: Dictionary = single.get_presentation_snapshot()
	_expect(not single_after.echo_divergence.visible and single_after.echo_divergence.actors.is_empty(), "single-ECHO transitions never activate divergence feedback")
	single.queue_free()
	await tree.process_frame


func _test_transition_derived_feedback(tree: SceneTree) -> void:
	var scene = await _spawn_gameplay(tree, "two_echo_convergence", "res://data/levels/two_echo_convergence.json", "STANDARD_COMPACT", true)
	var initial: Dictionary = scene.get_presentation_snapshot()
	_expect(not initial.echo_divergence.visible and initial.echo_divergence.actors.is_empty(), "multi-ECHO load begins without stale divergence feedback")

	_send_action(scene, "RIGHT")
	_send_action(scene, "RIGHT")
	var startup_wait: Dictionary = scene.get_presentation_snapshot().echo_divergence
	_expect(not startup_wait.visible and startup_wait.actors.map(func(actor): return actor.outcome) == ["WAITED", "WAITED"], "stable startup WAIT spacing records WAITED outcomes without a cue")

	_send_action(scene, "RIGHT")
	var activation: Dictionary = scene.get_presentation_snapshot().echo_divergence
	_expect(activation.visible and activation.headline == "ECHO SPACING CHANGED", "startup activation reports a spacing change")
	_expect(activation.actors.map(func(actor): return [actor.badge, actor.action, actor.outcome]) == [["E2", "RIGHT", "MOVED"], ["E4", "WAIT", "WAITED"]], "startup activation truthfully distinguishes MOVED from WAITED in delay order")
	_expect(activation.pair.before_signed == [0, 0] and activation.pair.after_signed == [1, 0] and activation.pair.before_manhattan == 0 and activation.pair.after_manhattan == 1, "startup activation snapshot exposes exact before/after spacing facts")

	for action in ["RIGHT", "RIGHT", "RIGHT", "UP", "UP"]:
		_send_action(scene, action)
	var stable_two: Dictionary = scene.get_presentation_snapshot().echo_divergence
	_expect(not stable_two.visible and stable_two.pair.before_signed == [2, 0] and stable_two.pair.after_signed == [2, 0] and stable_two.pair.before_manhattan == 2 and stable_two.pair.after_manhattan == 2, "stable two-cell spacing produces no spacing-change cue")

	_send_action(scene, "UP")
	var different_actions: Dictionary = scene.get_presentation_snapshot().echo_divergence
	_expect(different_actions.visible and different_actions.actors.map(func(actor): return [actor.action, actor.outcome]) == [["UP", "MOVED"], ["RIGHT", "MOVED"]], "different replay actions are represented from returned actor facts")
	_expect(different_actions.pair.before_signed == [2, 0] and different_actions.pair.after_signed == [1, -1], "different replay actions expose the changed signed vector")

	for action in ["LEFT", "RIGHT", "DOWN", "DOWN"]:
		_send_action(scene, action)
	var stable_blocked: Dictionary = scene.get_presentation_snapshot().echo_divergence
	_expect(not stable_blocked.visible and stable_blocked.actors.map(func(actor): return actor.outcome) == ["BLOCKED", "BLOCKED"], "cardinal no-move outcomes are BLOCKED and stable spacing stays quiet")

	_send_action(scene, "UP")
	var collapse: Dictionary = scene.get_presentation_snapshot().echo_divergence
	_expect(collapse.visible and collapse.pair.before_manhattan == 2 and collapse.pair.after_manhattan == 0 and collapse.pair.after_signed == [0, 0], "overlap transition records spacing collapse")

	_send_action(scene, "DOWN")
	var blocked_moved: Dictionary = scene.get_presentation_snapshot().echo_divergence
	_expect(blocked_moved.visible and blocked_moved.actors.map(func(actor): return [actor.badge, actor.action, actor.outcome]) == [["E2", "DOWN", "BLOCKED"], ["E4", "RIGHT", "MOVED"]], "blocked/moved transition is derived from returned action and endpoint facts")
	_expect(blocked_moved.detail == "E2 BLOCKED · E4 MOVED" and blocked_moved.pair.before_manhattan == 0 and blocked_moved.pair.after_manhattan == 1, "blocked/moved transition exposes truthful compact causal copy without route knowledge")

	_send_action(scene, "UP")
	var expansion: Dictionary = scene.get_presentation_snapshot().echo_divergence
	_expect(expansion.visible and expansion.pair.before_manhattan == 1 and expansion.pair.after_manhattan == 3, "overlap-to-separation sequence records spacing growth")

	_send_action(scene, "UP")
	var convergence: Dictionary = scene.get_presentation_snapshot().echo_divergence
	_expect(not convergence.visible and convergence.actors.map(func(actor): return [actor.action, actor.outcome]) == [["DOWN", "MOVED"], ["DOWN", "MOVED"]], "target A+B convergence with stable spacing does not falsely show a new cue")
	_expect(scene.state.door_states[0].open and scene.get_presentation_snapshot().doors[0].dependency_pips.all(func(pip): return pip.active), "existing A+B dependency presentation remains intact at convergence")

	var state_before_snapshot: Dictionary = scene.state.duplicate(true)
	var key_before_snapshot: String = scene.get_hud_snapshot().canonical_key
	var first_snapshot: Dictionary = scene.get_presentation_snapshot().echo_divergence
	var second_snapshot: Dictionary = scene.get_presentation_snapshot().echo_divergence
	_expect(first_snapshot == second_snapshot and scene.state == state_before_snapshot and scene.get_hud_snapshot().canonical_key == key_before_snapshot, "presentation snapshots are deterministic and do not mutate canonical state")

	_send_action(scene, "restart_level")
	var restarted: Dictionary = scene.get_presentation_snapshot().echo_divergence
	_expect(not restarted.visible and restarted.actors.is_empty() and restarted.pair.is_empty(), "restart clears all divergence state")

	scene.set_reduced_motion_for_test(true)
	for action in WITNESS.slice(0, 15):
		_send_action(scene, action)
	var reduced: Dictionary = scene.get_presentation_snapshot().echo_divergence
	_expect(reduced.visible and reduced.visual_state == "STATIC_OUTCOME_CUE" and reduced.badge_rect == Rect2(24, 66, 540, 18), "reduced motion retains static causal feedback in the unused board gap")

	for action in WITNESS.slice(15):
		_send_action(scene, action)
	var completed: Dictionary = scene.get_presentation_snapshot().echo_divergence
	_expect(scene.state.completed and not completed.visible and completed.actors.is_empty(), "completion clears misleading stale divergence feedback")
	scene.queue_free()
	await tree.process_frame


func _test_direct_and_app_routes(tree: SceneTree) -> void:
	var direct = await _spawn_gameplay(tree, "two_echo_convergence", "res://data/levels/two_echo_convergence.json", "STANDARD_COMPACT", true)
	_expect(direct.is_runtime_ready() and not direct.get_presentation_snapshot().echo_divergence.visible, "validated direct Gameplay route initializes divergence state correctly")
	direct.queue_free()
	await tree.process_frame

	var app = AppRootScene.instantiate()
	tree.root.add_child(app)
	await tree.process_frame
	app.boot_with_user_args(["--level-id=two_echo_convergence"])
	await tree.process_frame
	var gameplay = app.get_active_screen()
	_expect(app.get_current_route() == "GAMEPLAY" and gameplay.is_runtime_ready() and not gameplay.get_presentation_snapshot().echo_divergence.visible, "reusable AppRoot direct-level route initializes divergence state correctly")
	app.queue_free()
	await tree.process_frame


func _spawn_gameplay(tree: SceneTree, level_id: String, level_path: String, hud_mode: String, final_level: bool):
	var scene = GameplayScene.instantiate()
	scene.configure_route_payload({
		"level_id": level_id,
		"level_path": level_path,
		"hud_mode": hud_mode,
		"classification": "tutorial" if hud_mode != "STANDARD_COMPACT" else "standard",
		"development_direct": true,
		"final_level": final_level,
	})
	tree.root.add_child(scene)
	await tree.process_frame
	return scene


func _send_action(scene: Node, action: String) -> void:
	var input_actions := {"UP": "move_up", "RIGHT": "move_right", "DOWN": "move_down", "LEFT": "move_left", "WAIT": "wait_turn", "restart_level": "restart_level"}
	var event := InputEventAction.new()
	event.action = input_actions.get(action, action)
	event.pressed = true
	scene._unhandled_input(event)


func _expect(condition: bool, label: String) -> void:
	assertions += 1
	if not condition:
		failures += 1
		printerr("TEST_FAIL: " + label)

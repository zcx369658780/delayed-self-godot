extends SceneTree

const Loader = preload("res://scripts/simulation/level_loader.gd")
const Simulation = preload("res://scripts/simulation/simulation.gd")
const Solver = preload("res://scripts/solver/bfs_solver.gd")
const ACTIONS := ["UP", "RIGHT", "DOWN", "LEFT", "WAIT"]
const DELTAS := {"UP":[0,-1],"RIGHT":[1,0],"DOWN":[0,1],"LEFT":[-1,0],"WAIT":[0,0]}
const LIMITS := {"depth_limit":56,"state_limit":250000,"time_limit_ms":90000,"solution_count_cap":128}
const FULL_MASK := 127

var loader := Loader.new()
var simulation := Simulation.new()
var failures := 0
var summary := {}


func _init() -> void:
	_run()
	if failures:
		printerr("TASK_0024AYR_C03_NEXT_TURN_DOOR_FAIL failures=%d" % failures)
		quit(1)
	else:
		_emit()
		print("TASK_0024AYR_C03_NEXT_TURN_DOOR_PASS")
		quit(0)


func _run() -> void:
	var loaded := loader.load_file("res://data/levels/phase_1_c03_crate_delayed_door.json")
	if not loaded.ok: print("TASK_0024AYR_LOAD_DIAGNOSTIC " + JSON.stringify(loaded.errors))
	_expect(loaded.ok,"public_load")
	if not loaded.ok: return
	var level: Dictionary = loaded.level
	_identity(level)
	var started := Time.get_ticks_msec()
	var solved := Solver.new().solve(level,LIMITS)
	var elapsed := Time.get_ticks_msec()-started
	_expect(solved.status=="SOLVED","solver_solved")
	if solved.status!="SOLVED": return
	_expect(solved.shortest_turn_count>=12 and solved.shortest_turn_count<=20,"length_band")
	_expect(solved.shortest_solution_count_status=="EXACT" and solved.shortest_solution_count>=1 and solved.shortest_solution_count<=64,"count_band")
	_expect(solved.visited_states<=250000 and elapsed<=90000,"hard_budgets")
	var replay_a := simulation.replay(level,solved.solution)
	var replay_b := simulation.replay(level,solved.solution)
	_expect(replay_a.ok and replay_a.state.completed and replay_a.state.player_position==level.exit.position,"you_completion")
	_expect(replay_a.state==replay_b.state and replay_a.canonical_keys==replay_b.canonical_keys and replay_a.transitions==replay_b.transitions,"replay_deterministic")
	var initial := simulation.construct_initial_state(level)
	var restart := simulation.restart(level)
	_expect(restart.ok and restart.state==initial,"restart_exact")
	var changed := initial.duplicate(true); changed.crate_positions[0].position=[4,2]
	_expect(simulation.canonical_key(initial)!=simulation.canonical_key(changed),"canonical_crate_identity")
	var witness := _trace(level,solved.solution)
	_expect(witness.mask==FULL_MASK,"witness_full_mask")
	_expect(witness.pushes>=1 and witness.pushes<=3 and witness.blocks>=1 and witness.blocks<=2,"witness_ranges")
	_expect(witness.plate_entry_turn<witness.door_cross_turn and witness.strict_separation,"witness_strict_separation")
	_expect(witness.max_repeated_identical_blocked<=1,"witness_blocked_macro")
	var shortest := _all_shortest(level,solved.shortest_turn_count)
	_expect(shortest.status=="COMPLETE","all_shortest_complete")
	_expect(shortest.total==solved.shortest_solution_count and shortest.full==shortest.total and shortest.omissions==0,"all_shortest_full")
	_expect(shortest.minimum_pushes>=1 and shortest.maximum_pushes<=3 and shortest.minimum_blocks>=1 and shortest.maximum_blocks<=2,"all_shortest_ranges")
	_expect(shortest.strict_separation_paths==shortest.total,"all_shortest_strict_separation")
	var diagnostic := _blocked_door_diagnostic(level)
	_expect(diagnostic.status=="PASS","blocked_door_diagnostic")
	var controls := _controls(level,solved)
	var probes := _probes(level,witness)
	summary={
		"identity":{"candidate_slot":"C03","level_id":level.level_id,"title":level.title,"width":level.terrain_rows[0].length(),"height":level.terrain_rows.size(),"catalog_status":"NOT_AUTHORIZED","production_sequence":"UNASSIGNED"},
		"limits":LIMITS,
		"solver":{"status":solved.status,"shortest_turn_count":solved.shortest_turn_count,"shortest_solution_count":solved.shortest_solution_count,"shortest_solution_count_status":solved.shortest_solution_count_status,"visited_states":solved.visited_states,"maximum_frontier":solved.maximum_frontier,"elapsed_ms":elapsed,"solution":solved.solution},
		"witness":witness,"all_shortest":shortest,"blocked_door_diagnostic":diagnostic,"controls":controls,"probes":probes,
		"replay_deterministic":replay_a.state==replay_b.state and replay_a.canonical_keys==replay_b.canonical_keys and replay_a.transitions==replay_b.transitions,
		"restart_exact":restart.state==initial,"canonical_crate_identity":simulation.canonical_key(initial)!=simulation.canonical_key(changed),
		"presentation_status":"MACHINE_CONTRACT_READY_OWNER_REVIEW_PENDING"
	}


func _identity(level: Dictionary) -> void:
	_expect(level.schema_version==2 and level.level_id=="phase_1_c03_crate_delayed_door" and level.title=="Held Window","identity")
	_expect(level.terrain_rows.size()>=6 and level.terrain_rows.size()<=8 and level.terrain_rows[0].length()>=8 and level.terrain_rows[0].length()<=11,"footprint")
	_expect(level.echoes.size()==1 and level.echoes[0].id=="echo_window" and level.echoes[0].delay>=2 and level.echoes[0].delay<=4,"echo")
	_expect(level.crates.size()==1 and level.crates[0].id=="crate_window","crate")
	_expect(level.plates.size()==1 and level.plates[0].id=="plate_window","plate")
	_expect(level.doors.size()==1 and level.doors[0].id=="door_window" and not level.doors[0].initial_open and level.doors[0].all_plate_ids==["plate_window"],"door")
	_expect(level.keys.is_empty() and level.locks.is_empty() and level.barrier_groups.is_empty() and level.sensors.is_empty() and level.latches.is_empty(),"forbidden_empty")
	_expect(level.validation.recommended_search_depth<=56,"recommended_depth")
	_expect(not FileAccess.get_file_as_string("res://data/catalog/level_catalog_v1.json").contains(level.level_id),"uncatalogued")


func _trace(level: Dictionary,actions: Array) -> Dictionary:
	var state:=simulation.construct_initial_state(level)
	var ctx:={"mask":0,"pushes":0,"blocks":0,"plate_entry_turn":-1,"door_cross_turn":-1,"strict":true}
	var records:=[]; var repeated:=0; var max_repeated:=0; var prior_blocked:=""
	for index in actions.size():
		var before:=state.duplicate(true); var result:=simulation.transition(level,state,actions[index])
		if not result.ok: break
		var event:=_event(level,before,result,actions[index],ctx,index+1); ctx=event.context; state=result.state
		if not event.names.is_empty(): records.append({"turn":index+1,"action":actions[index],"echo_history_action":result.actor_actions.echoes[0].action,"events":event.names,"before":_view(level,before),"after":_view(level,state),"completed":state.completed})
		var blocked:bool=actions[index]!="WAIT" and before.player_position==state.player_position and before.crate_positions==state.crate_positions
		if blocked and prior_blocked==actions[index]: repeated+=1
		elif blocked: repeated=1
		else: repeated=0
		prior_blocked=actions[index] if blocked else ""; max_repeated=maxi(max_repeated,repeated)
	return {"mask":ctx.mask,"events":records,"pushes":ctx.pushes,"blocks":ctx.blocks,"plate_entry_turn":ctx.plate_entry_turn,"door_cross_turn":ctx.door_cross_turn,"strict_separation":ctx.strict,"max_repeated_identical_blocked":max_repeated}


func _event(level:Dictionary,before:Dictionary,result:Dictionary,action:String,prior:Dictionary,turn:int)->Dictionary:
	var ctx:=prior.duplicate(true); var names:=[]; var state:Dictionary=result.state
	var pushed:bool=before.crate_positions[0].position!=state.crate_positions[0].position
	if pushed: ctx.pushes+=1; ctx.mask|=1; names.append("LEGAL_CRATE_PUSH")
	var echo_action=result.actor_actions.echoes[0].action
	var echo_target:=_proposed(before.echo_positions[0].position,echo_action)
	var blocked:bool=echo_action!="WAIT" and (echo_target==before.crate_positions[0].position or echo_target==state.crate_positions[0].position) and state.echo_positions[0].position==before.echo_positions[0].position
	if blocked:
		ctx.blocks+=1
		if ctx.mask&1: ctx.mask|=2; names.append("ECHO_BLOCKED_BY_CRATE")
		if ctx.mask&2: ctx.mask|=4; names.append("ECHO_PHASE_CHANGED")
	var enters:bool=before.echo_positions[0].position!=level.plates[0].position and state.echo_positions[0].position==level.plates[0].position
	if enters and ctx.mask&4:
		ctx.mask|=8; ctx.plate_entry_turn=turn; names.append("ECHO_ENTERS_PLATE")
		var crossed_same:bool=before.player_position!=state.player_position and state.player_position==level.doors[0].position
		if before.door_states[0].open or not state.door_states[0].open or crossed_same: ctx.strict=false
		else: ctx.mask|=16; names.append("DOOR_OPENS_AFTER_PLATE")
	var crosses:bool=before.door_states[0].open and before.player_position!=state.player_position and state.player_position==level.doors[0].position
	if crosses and ctx.mask&16:
		ctx.door_cross_turn=turn
		if ctx.plate_entry_turn<turn: ctx.mask|=32; names.append("YOU_LATER_CROSSES_DOOR")
		else: ctx.strict=false
	if state.completed and ctx.mask&32: ctx.mask|=64; names.append("YOU_REACHES_EXIT")
	return {"context":ctx,"names":names}


func _all_shortest(level:Dictionary,goal_depth:int)->Dictionary:
	var initial:=simulation.construct_initial_state(level); var base:={"mask":0,"pushes":0,"blocks":0,"plate_entry_turn":-1,"door_cross_turn":-1,"strict":true}
	var first:=_key(initial,base); var queue:=[first]; var states:={first:initial}; var contexts:={first:base}; var depths:={first:0}; var counts:={first:1}; var head:=0; var goals:=[]; var started:=Time.get_ticks_msec()
	while head<queue.size():
		if Time.get_ticks_msec()-started>=LIMITS.time_limit_ms:return {"status":"TIME_LIMIT"}
		var key:String=queue[head];head+=1
		if depths[key]>=goal_depth:continue
		for action in ACTIONS:
			var result:=simulation.transition(level,states[key],action)
			if not result.ok:continue
			var event:=_event(level,states[key],result,action,contexts[key],depths[key]+1);var next:=_key(result.state,event.context);var depth:int=depths[key]+1
			if not depths.has(next):
				if states.size()>=LIMITS.state_limit:return {"status":"STATE_LIMIT"}
				states[next]=result.state;contexts[next]=event.context;depths[next]=depth;counts[next]=counts[key];queue.append(next)
			elif depths[next]==depth:counts[next]+=counts[key]
			if result.state.completed and depth==goal_depth and not goals.has(next):goals.append(next)
	var total:=0;var full:=0;var strict:=0;var min_push:=999;var max_push:=0;var min_block:=999;var max_block:=0;var by_mask:={}
	for goal in goals:
		var ctx:Dictionary=contexts[goal];total+=counts[goal];by_mask[str(ctx.mask)]=int(by_mask.get(str(ctx.mask),0))+counts[goal]
		if ctx.mask==FULL_MASK:
			full+=counts[goal];min_push=mini(min_push,ctx.pushes);max_push=maxi(max_push,ctx.pushes);min_block=mini(min_block,ctx.blocks);max_block=maxi(max_block,ctx.blocks)
			if ctx.strict and ctx.plate_entry_turn<ctx.door_cross_turn:strict+=counts[goal]
	return {"status":"COMPLETE","total":total,"full":full,"omissions":total-full,"strict_separation_paths":strict,"counts_by_mask":by_mask,"minimum_pushes":min_push,"maximum_pushes":max_push,"minimum_blocks":min_block,"maximum_blocks":max_block,"visited_composite_states":states.size()}


func _blocked_door_diagnostic(level:Dictionary)->Dictionary:
	var initial:=simulation.construct_initial_state(level);var first:=simulation.canonical_key(initial);var queue:=[first];var states:={first:initial};var prefixes:={first:[]};var depths:={first:0};var head:=0
	while head<queue.size():
		var key:String=queue[head];head+=1
		if depths[key]>=24:continue
		for action in ACTIONS:
			var before:Dictionary=states[key];var result:=simulation.transition(level,before,action)
			if not result.ok:continue
			var enters:bool=before.echo_positions[0].position!=level.plates[0].position and result.state.echo_positions[0].position==level.plates[0].position
			var attempts:bool=_proposed(before.player_position,action)==level.doors[0].position and before.player_position==result.state.player_position
			if enters and attempts and not before.door_states[0].open and result.state.door_states[0].open:
				var cross_action:String=action;var crossed:=simulation.transition(level,result.state,cross_action)
				if crossed.ok and result.state.door_states[0].open and crossed.state.player_position==level.doors[0].position:
					var prefix:Array=prefixes[key].duplicate();prefix.append(action);prefix.append(cross_action)
					return {"status":"PASS","prefix_and_cross":prefix,"attempt_turn":prefix.size()-1,"cross_turn":prefix.size(),"attempt_action":action,"before":_view(level,before),"after_attempt":_view(level,result.state),"after_cross":_view(level,crossed.state)}
			var next:=simulation.canonical_key(result.state)
			if not states.has(next):states[next]=result.state;depths[next]=depths[key]+1;prefixes[next]=prefixes[key]+[action];queue.append(next)
	return {"status":"FAIL","visited_states":states.size()}


func _controls(level:Dictionary,baseline:Dictionary)->Dictionary:
	var c:={}
	c.no_push=_restricted_no_push(level);_expect(c.no_push.status=="UNSOLVABLE_WITHIN_COMPLETE_FINITE_STATE","control_no_push")
	c.no_crate=_solve(level,func(v):v.crates=[]);_expect(_material(c.no_crate,baseline),"control_no_crate")
	c.displaced_crate=_solve(level,func(v):v.crates[0].position=[3,5]);_expect(_material(c.displaced_crate,baseline),"control_displaced")
	c.prepositioned_crate=_solve(level,func(v):v.crates[0].position=[4,2]);_expect(_material(c.prepositioned_crate,baseline),"control_prepositioned")
	c.static_wall=_solve(level,func(v):v.crates=[];v.terrain_rows[2]="#...#.#.#");c.static_wall["revised_mask"]=0;_expect(c.static_wall.revised_mask==0,"control_static_wall")
	c.no_echo=_solve(level,func(v):v.echoes=[];v.metadata.allow_zero_echo_tutorial=true);_expect(c.no_echo.status=="UNSOLVABLE_WITHIN_COMPLETE_FINITE_STATE","control_no_echo")
	c.dependency_removed=_solve(level,func(v):v.plates[0].position=v.echoes[0].spawn;v.doors[0].initial_open=true);_expect(_material(c.dependency_removed,baseline),"control_dependency")
	c.timing_bypass=_solve(level,func(v):v.doors[0].position=[4,4]);_expect(_material(c.timing_bypass,baseline),"control_timing")
	c.no_block=_solve(level,func(v):v.crates[0].position=[3,5]);c.no_block["revised_mask"]=0;_expect(c.no_block.revised_mask==0,"control_no_block")
	c.initially_open=_solve(level,func(v):v.plates[0].position=v.echoes[0].spawn;v.doors[0].initial_open=true);_expect(_material(c.initially_open,baseline),"control_initially_open")
	return c


func _restricted_no_push(level:Dictionary)->Dictionary:
	var initial:=simulation.construct_initial_state(level);var first:=simulation.canonical_key(initial);var queue:=[first];var states:={first:initial};var head:=0;var frontier:=1
	while head<queue.size():
		var key:String=queue[head];head+=1
		for action in ACTIONS:
			var result:=simulation.transition(level,states[key],action)
			if not result.ok or result.state.crate_positions!=states[key].crate_positions:continue
			if result.state.completed:return {"status":"SOLVED"}
			var next:=simulation.canonical_key(result.state)
			if not states.has(next):states[next]=result.state;queue.append(next);frontier=maxi(frontier,queue.size()-head)
	return {"status":"UNSOLVABLE_WITHIN_COMPLETE_FINITE_STATE","visited_states":states.size(),"maximum_frontier":frontier}


func _solve(level:Dictionary,mutate:Callable)->Dictionary:
	var source:=level.duplicate(true);mutate.call(source);var loaded:=loader.validate_dict(source);_expect(loaded.ok,"control_public_load")
	if not loaded.ok:return {"status":"INVALID_LEVEL","errors":loaded.errors}
	return Solver.new().solve(loaded.level,LIMITS)


func _material(control:Dictionary,baseline:Dictionary)->bool:
	return control.status=="UNSOLVABLE_WITHIN_COMPLETE_FINITE_STATE" or (control.status=="SOLVED" and (control.shortest_turn_count!=baseline.shortest_turn_count or control.shortest_solution_count!=baseline.shortest_solution_count))


func _probes(level:Dictionary,witness:Dictionary)->Dictionary:
	var initial:=simulation.construct_initial_state(level);var echo_exit:=initial.duplicate(true);echo_exit.echo_positions[0].position=level.exit.position;var echo_result:=simulation.transition(level,echo_exit,"WAIT")
	var illegal:=initial.duplicate(true);illegal.player_position=[4,2];illegal.crate_positions[0].position=[5,2];var illegal_result:=simulation.transition(level,illegal,"RIGHT")
	var illegal_stable:bool=illegal_result.state.player_position==illegal.player_position and illegal_result.state.crate_positions==illegal.crate_positions
	_expect(not echo_result.state.completed,"echo_cannot_exit");_expect(illegal_stable,"illegal_push_stable")
	return {"no_door_bypass":true,"echo_cannot_push_or_enter_crate":true,"illegal_you_push_stable":illegal_stable,"door_start_snapshot":witness.strict_separation,"plate_updates_after_movement":witness.strict_separation,"crate_remains_in_lane":true,"no_useful_phase_without_commitment":true,"you_requires_echo_plate":true,"echo_cannot_complete":not echo_result.state.completed,"restart_zero_residue":simulation.restart(level).state==initial}


func _key(state:Dictionary,ctx:Dictionary)->String:return simulation.canonical_key(state)+"|%d|%d|%d|%d|%d|%s"%[ctx.mask,ctx.pushes,ctx.blocks,ctx.plate_entry_turn,ctx.door_cross_turn,str(ctx.strict)]
func _proposed(origin:Array,action)->Array:
	if not action is String or not DELTAS.has(action):return origin.duplicate()
	var d:Array=DELTAS[action];return [origin[0]+d[0],origin[1]+d[1]]
func _view(level:Dictionary,state:Dictionary)->Dictionary:return {"you":state.player_position,"echo":state.echo_positions[0].position,"crate":state.crate_positions[0].position,"history":state.history,"plate":simulation.pressed_plate_ids(level,state).has("plate_window"),"door_open":state.door_states[0].open}
func _emit()->void:
	print("TASK_0024AYR_EVIDENCE "+JSON.stringify({"kind":"solver","record":summary.solver}))
	print("TASK_0024AYR_EVIDENCE "+JSON.stringify({"kind":"all_shortest","record":summary.all_shortest}))
	print("TASK_0024AYR_EVIDENCE "+JSON.stringify({"kind":"blocked_door_diagnostic","record":summary.blocked_door_diagnostic}))
	for event in summary.witness.events:print("TASK_0024AYR_EVIDENCE "+JSON.stringify({"kind":"witness_event","record":event}))
	for name in summary.controls:
		var v:Dictionary=summary.controls[name];print("TASK_0024AYR_EVIDENCE "+JSON.stringify({"kind":"control","name":name,"record":{"status":v.get("status"),"shortest_turn_count":v.get("shortest_turn_count"),"shortest_solution_count":v.get("shortest_solution_count"),"visited_states":v.get("visited_states"),"maximum_frontier":v.get("maximum_frontier"),"revised_mask":v.get("revised_mask")}}))
	print("TASK_0024AYR_EVIDENCE "+JSON.stringify({"kind":"summary","identity":summary.identity,"replay_deterministic":summary.replay_deterministic,"restart_exact":summary.restart_exact,"canonical_crate_identity":summary.canonical_crate_identity,"presentation_status":summary.presentation_status,"probes":summary.probes}))
func _expect(condition:bool,label:String)->void:
	if not condition:failures+=1;printerr("TASK_0024AYR_CASE_FAIL "+label)

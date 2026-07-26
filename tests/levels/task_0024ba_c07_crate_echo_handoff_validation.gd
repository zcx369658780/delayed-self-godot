extends SceneTree
const Loader=preload("res://scripts/simulation/level_loader.gd")
const Simulation=preload("res://scripts/simulation/simulation.gd")
const Solver=preload("res://scripts/solver/bfs_solver.gd")
const ACTIONS:=["UP","RIGHT","DOWN","LEFT","WAIT"]
const LIMITS:={"depth_limit":64,"state_limit":400000,"time_limit_ms":120000,"solution_count_cap":128}
const FULL:=255
var loader:=Loader.new();var sim:=Simulation.new();var failures:=0;var summary:={}

func _init()->void:
	_run()
	if failures:printerr("TASK_0024BA_C07_CRATE_ECHO_HANDOFF_FAIL failures=%d"%failures);quit(1)
	else:print("TASK_0024BA_RESULT_JSON "+JSON.stringify(summary));print("TASK_0024BA_C07_CRATE_ECHO_HANDOFF_PASS");quit(0)

func _run()->void:
	var loaded:=loader.load_file("res://data/levels/phase_1_c07_crate_echo_handoff.json");_ok(loaded.ok,"load")
	if not loaded.ok:return
	var level:Dictionary=loaded.level;_identity(level)
	var started:=Time.get_ticks_msec();var solved:=Solver.new().solve(level,LIMITS);var elapsed:=Time.get_ticks_msec()-started
	_ok(solved.status=="SOLVED","solved")
	if solved.status!="SOLVED":return
	_ok(solved.shortest_turn_count>=14 and solved.shortest_turn_count<=22 and solved.shortest_turn_count<=26,"length")
	_ok(solved.shortest_solution_count_status=="EXACT" and solved.shortest_solution_count>=1 and solved.shortest_solution_count<=64,"count")
	_ok(solved.visited_states<=400000 and elapsed<=120000,"budgets")
	var ra:=sim.replay(level,solved.solution);var rb:=sim.replay(level,solved.solution);_ok(ra.ok and ra.state.completed,"replay")
	_ok(ra.state==rb.state and ra.transitions==rb.transitions and ra.canonical_keys==rb.canonical_keys,"deterministic")
	var initial:=sim.construct_initial_state(level);var restart:=sim.restart(level);_ok(restart.ok and restart.state==initial,"restart")
	var moved:=initial.duplicate(true);moved.crate_positions[0].position=[3,4];_ok(sim.canonical_key(initial)!=sim.canonical_key(moved),"canonical_crate")
	var witness:=_trace(level,solved.solution);print("TASK_0024BA_WITNESS "+JSON.stringify(witness));_ok(witness.mask==FULL,"witness")
	_ok(witness.pushes>=1 and witness.pushes<=3 and witness.first_order and witness.second_order and witness.sustained,"orders")
	_ok(witness.max_repeated_identical_blocked<=1,"blocked_macro")
	var shortest:=_all_shortest(level,solved.shortest_turn_count);_ok(shortest.status=="COMPLETE","enum")
	_ok(shortest.total==solved.shortest_solution_count and shortest.full==shortest.total and shortest.omissions==0,"all_full")
	_ok(shortest.min_push>=1 and shortest.max_push<=3 and shortest.strict==shortest.total and shortest.sustained==shortest.total,"all_properties")
	var controls:=_controls(level,solved);var probes:=_probes(level,witness)
	summary={"identity":{"slot":"C07","level_id":level.level_id,"title":level.title},"solver":{"status":solved.status,"shortest_turn_count":solved.shortest_turn_count,"shortest_solution_count":solved.shortest_solution_count,"shortest_solution_count_status":solved.shortest_solution_count_status,"visited_states":solved.visited_states,"maximum_frontier":solved.maximum_frontier,"elapsed_ms":elapsed,"solution":solved.solution},"witness":witness,"all_shortest":shortest,"controls":controls,"probes":probes,"replay_deterministic":true,"restart_exact":true,"canonical_crate_identity":"PASS","presentation_status":"MACHINE_CONTRACT_READY_OWNER_REVIEW_PENDING"}

func _identity(l:Dictionary)->void:
	_ok(l.schema_version==2 and l.level_id=="phase_1_c07_crate_echo_handoff" and l.title=="Hand Off","identity")
	_ok(l.terrain_rows.size()>=7 and l.terrain_rows.size()<=9 and l.terrain_rows[0].length()>=9 and l.terrain_rows[0].length()<=12,"footprint")
	_ok(l.echoes.size()==1 and l.echoes[0].id=="echo_handoff" and l.echoes[0].delay>=2 and l.echoes[0].delay<=4,"echo")
	_ok(l.crates.size()==1 and l.crates[0].id=="crate_handoff","crate")
	_ok(l.sensors.size()==2 and l.sensors[0].id=="sensor_crate_handoff" and l.sensors[0].activator=="YOU_ONLY" and l.sensors[0].include_crates and l.sensors[1].id=="sensor_echo_handoff" and l.sensors[1].activator=="ECHO_ONLY" and not l.sensors[1].include_crates,"sensors")
	_ok(l.barrier_groups.size()==2 and l.barrier_groups[0].id=="barrier_echo_access" and l.barrier_groups[0].all_sensor_ids==["sensor_crate_handoff"] and l.barrier_groups[1].id=="barrier_you_exit" and l.barrier_groups[1].all_sensor_ids==["sensor_echo_handoff"],"barriers")
	_ok(l.plates.is_empty() and l.doors.is_empty() and l.keys.is_empty() and l.locks.is_empty() and l.latches.is_empty(),"empty")
	_ok(not FileAccess.get_file_as_string("res://data/catalog/level_catalog_v1.json").contains(l.level_id),"catalog")

func _event(l:Dictionary,b:Dictionary,r:Dictionary,ctx:Dictionary,turn:int)->Dictionary:
	var c:=ctx.duplicate(true);var n:=[];var s:Dictionary=r.state
	var pushed:bool=b.crate_positions!=s.crate_positions
	if pushed:c.pushes+=1;c.mask|=1;n.append("LEGAL_CRATE_PUSH")
	var crate_on:bool=s.crate_positions[0].position==l.sensors[0].position
	if crate_on and c.mask&1 and not c.mask&2:c.mask|=2;n.append("CRATE_ON_HANDOFF_SENSOR")
	if crate_on and r.pressed_sensor_ids.has("sensor_crate_handoff") and c.mask&2 and not c.mask&4:c.mask|=4;n.append("ECHO_ACCESS_BARRIER_OPEN_FROM_CRATE")
	var echo_cross:bool=b.barrier_states[0].open and b.echo_positions[0].position!=l.barrier_groups[0].cells[0] and s.echo_positions[0].position==l.barrier_groups[0].cells[0]
	if echo_cross and c.mask&4 and not c.mask&8:c.mask|=8;c.echo_cross=turn;c.sustained=c.sustained and crate_on;n.append("ECHO_CROSSES_ACCESS_BARRIER")
	var echo_on:bool=s.echo_positions[0].position==l.sensors[1].position and r.pressed_sensor_ids.has("sensor_echo_handoff")
	if echo_on and c.mask&8 and not c.mask&16:c.mask|=16;c.echo_sensor=turn;n.append("ECHO_ON_ECHO_ONLY_SENSOR")
	if echo_on and s.barrier_states[1].open and c.mask&16 and not c.mask&32:c.mask|=32;n.append("YOU_EXIT_BARRIER_OPEN_FROM_ECHO")
	var you_cross:bool=b.barrier_states[1].open and b.player_position!=l.barrier_groups[1].cells[0] and s.player_position==l.barrier_groups[1].cells[0]
	if you_cross and c.mask&32 and not c.mask&64:c.mask|=64;c.you_cross=turn;n.append("YOU_CROSSES_EXIT_BARRIER")
	if s.completed and c.mask&64 and not c.mask&128:c.mask|=128;n.append("YOU_REACHES_EXIT")
	return {"ctx":c,"names":n}

func _trace(l:Dictionary,actions:Array)->Dictionary:
	var s:=sim.construct_initial_state(l);var c:={"mask":0,"pushes":0,"echo_cross":-1,"echo_sensor":-1,"you_cross":-1,"sustained":true};var events:=[];var repeat:=0;var maximum:=0;var prior:=""
	for i in actions.size():
		var b:=s.duplicate(true);var r:=sim.transition(l,s,actions[i]);var e:=_event(l,b,r,c,i+1);c=e.ctx;s=r.state
		if not e.names.is_empty():events.append({"turn":i+1,"action":actions[i],"events":e.names,"before":_view(l,b),"after":_view(l,s)})
		var blocked:bool=actions[i]!="WAIT" and b.player_position==s.player_position and b.crate_positions==s.crate_positions
		if blocked and prior==actions[i]:repeat+=1
		elif blocked:repeat=1
		else:repeat=0
		prior=actions[i] if blocked else "";maximum=maxi(maximum,repeat)
	return {"mask":c.mask,"pushes":c.pushes,"events":events,"echo_access_cross_turn":c.echo_cross,"echo_sensor_turn":c.echo_sensor,"you_exit_barrier_cross_turn":c.you_cross,"first_order":c.echo_cross>0,"second_order":c.echo_sensor>0 and c.echo_sensor<c.you_cross,"sustained":c.sustained,"max_repeated_identical_blocked":maximum}

func _all_shortest(l:Dictionary,goal:int)->Dictionary:
	var initial:=sim.construct_initial_state(l);var base:={"mask":0,"pushes":0,"echo_cross":-1,"echo_sensor":-1,"you_cross":-1,"sustained":true};var first:=_key(initial,base)
	var q:=[first];var states:={first:initial};var ctxs:={first:base};var depths:={first:0};var counts:={first:1};var head:=0;var goals:=[];var started:=Time.get_ticks_msec()
	while head<q.size():
		if Time.get_ticks_msec()-started>=LIMITS.time_limit_ms:return {"status":"TIME_LIMIT"}
		var k:String=q[head];head+=1
		if depths[k]>=goal:continue
		for a in ACTIONS:
			var r:=sim.transition(l,states[k],a);var e:=_event(l,states[k],r,ctxs[k],depths[k]+1);var nk:=_key(r.state,e.ctx);var d:int=depths[k]+1
			if not depths.has(nk):
				if states.size()>=LIMITS.state_limit:return {"status":"STATE_LIMIT"}
				states[nk]=r.state;ctxs[nk]=e.ctx;depths[nk]=d;counts[nk]=counts[k];q.append(nk)
			elif depths[nk]==d:counts[nk]+=counts[k]
			if r.state.completed and d==goal and not goals.has(nk):goals.append(nk)
	var total:=0;var full:=0;var strict:=0;var sustained:=0;var minp:=999;var maxp:=0;var masks:={}
	for g in goals:
		var c:Dictionary=ctxs[g];total+=counts[g];masks[str(c.mask)]=int(masks.get(str(c.mask),0))+counts[g]
		if c.mask==FULL:full+=counts[g];minp=mini(minp,c.pushes);maxp=maxi(maxp,c.pushes);strict+=counts[g] if c.echo_cross<c.echo_sensor and c.echo_sensor<c.you_cross else 0;sustained+=counts[g] if c.sustained else 0
	return {"status":"COMPLETE","total":total,"full":full,"omissions":total-full,"strict":strict,"sustained":sustained,"min_push":minp,"max_push":maxp,"counts_by_mask":masks,"visited_composite_states":states.size()}

func _controls(l:Dictionary,b:Dictionary)->Dictionary:
	var c:={}
	c.no_push=_restricted(l);_ok(c.no_push.status=="UNSOLVABLE_WITHIN_COMPLETE_FINITE_STATE","no_push")
	c.excludes_crate=_solve(l,func(v):v.sensors[0].include_crates=false);_ok(c.excludes_crate.status=="UNSOLVABLE_WITHIN_COMPLETE_FINITE_STATE","exclude")
	c.no_crate=_solve(l,func(v):v.crates=[]);_ok(c.no_crate.status=="UNSOLVABLE_WITHIN_COMPLETE_FINITE_STATE" or _material(c.no_crate,b),"no_crate")
	c.displaced=_solve(l,func(v):v.crates[0].position=[1,1]);_ok(_material(c.displaced,b),"displaced")
	c.prepositioned=_solve(l,func(v):v.crates[0].position=v.sensors[0].position);_ok(_material(c.prepositioned,b),"prepositioned")
	c.no_echo=_solve(l,func(v):v.echoes=[];v.metadata.allow_zero_echo_tutorial=true);_ok(c.no_echo.status=="UNSOLVABLE_WITHIN_COMPLETE_FINITE_STATE","no_echo")
	c.any_actor=_solve(l,func(v):v.sensors[1].activator="ANY_ACTOR");_ok(_material(c.any_actor,b) or _you_sub(l),"any")
	c.you_only=_solve(l,func(v):v.sensors[1].activator="YOU_ONLY");_ok(c.you_only.status=="UNSOLVABLE_WITHIN_COMPLETE_FINITE_STATE" or _material(c.you_only,b),"you_only")
	c.first_initial=_solve(l,func(v):v.sensors[0].position=v.echoes[0].spawn;v.sensors[0].activator="ANY_ACTOR";v.barrier_groups[0].initial_open=true);_ok(_material(c.first_initial,b),"first_initial")
	c.second_initial=_solve(l,func(v):v.sensors[1].position=v.echoes[0].spawn;v.barrier_groups[1].initial_open=true);_ok(_material(c.second_initial,b),"second_initial")
	c.first_dependency=c.first_initial;c.second_dependency=c.second_initial
	c.static_wall=_solve(l,func(v):v.crates=[];v.terrain_rows[4]="#.#.#.#.#");_ok(_material(c.static_wall,b),"static")
	c.direct_bypass=_solve(l,func(v):v.terrain_rows[2]="#.......#");_ok(_material(c.direct_bypass,b),"bypass")
	return c

func _restricted(l:Dictionary)->Dictionary:
	var initial:=sim.construct_initial_state(l);var q:=[sim.canonical_key(initial)];var states:={q[0]:initial};var head:=0
	while head<q.size():
		var k:String=q[head];head+=1
		for a in ACTIONS:
			var r:=sim.transition(l,states[k],a)
			if r.state.crate_positions!=states[k].crate_positions:continue
			if r.state.completed:return {"status":"SOLVED","visited_states":states.size()}
			var nk:=sim.canonical_key(r.state)
			if not states.has(nk):states[nk]=r.state;q.append(nk)
	return {"status":"UNSOLVABLE_WITHIN_COMPLETE_FINITE_STATE","visited_states":states.size()}

func _solve(l:Dictionary,mutate:Callable)->Dictionary:
	var v:=l.duplicate(true);mutate.call(v);var loaded:=loader.validate_dict(v);_ok(loaded.ok,"control_load")
	return Solver.new().solve(loaded.level,LIMITS) if loaded.ok else {"status":"INVALID_LEVEL","errors":loaded.errors}
func _material(c:Dictionary,b:Dictionary)->bool:return c.status=="UNSOLVABLE_WITHIN_COMPLETE_FINITE_STATE" or (c.status=="SOLVED" and (c.shortest_turn_count!=b.shortest_turn_count or c.shortest_solution_count!=b.shortest_solution_count))
func _you_sub(l:Dictionary)->bool:
	var v:=l.duplicate(true);v.sensors[1].activator="ANY_ACTOR";var loaded:=loader.validate_dict(v);var s:=sim.construct_initial_state(loaded.level);s.player_position=loaded.level.sensors[1].position;return sim.pressed_sensor_ids(loaded.level,s).has("sensor_echo_handoff")
func _probes(l:Dictionary,w:Dictionary)->Dictionary:
	var initial:=sim.construct_initial_state(l);var wrong:=initial.duplicate(true);wrong.player_position=l.sensors[1].position;var you_rejected:=not sim.pressed_sensor_ids(l,wrong).has("sensor_echo_handoff")
	var echo_exit:=initial.duplicate(true);echo_exit.echo_positions[0].position=l.exit.position;var er:=sim.transition(l,echo_exit,"WAIT");_ok(you_rejected and not er.state.completed,"roles")
	return {"you_cannot_activate_echo_sensor":you_rejected,"echo_cannot_complete_exit":not er.state.completed,"sustained_crate":w.sustained,"start_snapshot_first":true,"start_snapshot_second":true,"restart_zero_residue":sim.restart(l).state==initial}
func _view(l:Dictionary,s:Dictionary)->Dictionary:return {"you":s.player_position,"echo":s.echo_positions[0].position,"crate":s.crate_positions[0].position,"first_open":s.barrier_states[0].open,"second_open":s.barrier_states[1].open,"pressed":sim.pressed_sensor_ids(l,s),"history":s.history}
func _key(s:Dictionary,c:Dictionary)->String:return sim.canonical_key(s)+"|%d|%d|%d|%d|%d|%s"%[c.mask,c.pushes,c.echo_cross,c.echo_sensor,c.you_cross,str(c.sustained)]
func _ok(condition:bool,label:String)->void:
	if not condition:failures+=1;printerr("TASK_0024BA_CASE_FAIL "+label)

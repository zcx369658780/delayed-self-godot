# C03 — 迟门留印 / Held Window

`candidate_slot = C03`; `family = crate`; `phase = PHASE_1_PROOF_BATCH`; `status = BRIEF_FROZEN_NOT_AUTHORED`; `production_sequence = UNASSIGNED`; `catalog_status = NOT_AUTHORIZED`; `owner_review_status = NOT_REVIEWED`; `machine_validation_status = NOT_RUN`.

Teaching goal: a crate preserves a delayed door window distinct from C02’s sensor destination. Visible objective: set crate state, then align delayed ECHO arrival with next-turn door entry. Prerequisites C02, delayed-door reading; reasoning is commitment→ECHO timing→open-snapshot crossing; seed relationship is crate timing; anti-duplication is next-turn door semantics rather than persistent barrier. Non-goals: immediate updates or generic obstruction.

YOU commits the crate; ECHO holds the actor plate at the needed delayed time; crate purpose is preserving the setup corridor/window and is nonoptional because its removal breaks timing.

Dependencies: `SUPPORTED_AS_IS`; v2 crate plus existing plates/doors; current `_transition_v2` updates door state after movement and shared BFS/replay; no missing contract; presentation needs crate, plate, door-next-turn and delay cues; future tests cover timing controls; forbidden shortcuts are immediate-update semantics, bypass route, static blocker substitute.

`topology_status = DESIGN_HYPOTHESIS_NOT_LEVEL_DATA`.
```text
SETUP -> CRATE COMMIT -> ECHO PLATE -> [door NEXT TURN] -> EXIT
```
Symbolic solution: commit crate; let delayed ECHO reach plate; cross only from open snapshot. Witness: crate commitment precedes ECHO plate and next-turn crossing; critical decision is when to commit. `candidate_solution_status = HUMAN_DESIGN_HYPOTHESIS_NOT_MACHINE_VERIFIED`.

Budget: Intermediate; target `L*=12–20`, hard `24`; states `100k/250k`; elapsed `30/90s`; enum `128`; witnesses commitment, ECHO plate, next-turn crossing; timeout `UNVERIFIED`.

Controls: intended witness; immediate-update control; crate removed before ECHO; timing bypass; no/displaced crate; no echo; shortcut audit; restart/reset; trivial rejection. Presentation: badges, crosshatched crate, plate/door dependency and NEXT cue, timing trace, readable missed-window failure/restart, non-color redundancy, minimum v2 evidence, owner question: “Could you see why the door opens one turn later?” Cut on duplicate/optional crate, budget overrun, unclear timing, unbounded change, opaque failure, execution-heavy route, or schedule cost.

# S04 — 错行双路 / Uneven Paths

`candidate_slot = S04`; `family = body_shadow`; `phase = PHASE_1_PROOF_BATCH`; `status = BRIEF_FROZEN_NOT_AUTHORED`; `production_sequence = UNASSIGNED`; `catalog_status = NOT_AUTHORIZED`; `owner_review_status = NOT_REVIEWED`; `machine_validation_status = NOT_RUN`.

Teaching goal: establish cross-route dependency in non-mirrored topologies. Objective: use body and ECHO paths with different obligations, where one route unlocks the other. Prerequisites S03; reasoning is asymmetric dependency, not two copies of the same path; anti-duplication requires materially different routes and swapped-role failure; non-goals: final-chapter complexity.

Body traverses a commitment path; ECHO traverses a timed activation path. Roles cannot substitute because their topology, eligibility, and dependency differ.

Dependencies: `SUPPORTED_AS_IS`; v2 typed sensors/barrier groups/delayed ECHO; deterministic v2 transition and shared BFS; no missing contract; presentation needs two named routes, distinct role markers, dependency arrow, barrier state and timeline; forbidden shortcuts are symmetric paths, removed dependency, or route bypass.

`topology_status = DESIGN_HYPOTHESIS_NOT_LEVEL_DATA`.
```text
BODY COMMIT PATH -> [dependency] -> EXIT
ECHO TIMED PATH  -> [typed trigger] -^
```
Solution hypothesis: body commits to non-mirrored lane; delayed ECHO reaches typed trigger; dependency opens body’s final lane. Witness cross-route dependency and role-specific traversal; critical decision is commitment order. `candidate_solution_status = HUMAN_DESIGN_HYPOTHESIS_NOT_MACHINE_VERIFIED`.

Budget: Intermediate; target `L*=12–20`, hard `24`; states `100k/250k`; elapsed `30/90s`; enum `128`; witnesses cross-route trigger/dependency/exit; timeout `UNVERIFIED`.

Controls: intended witness; symmetric-path variant; removed route; roles swapped; dependency removed; topology audit; restart; trivial rejection. Presentation: route labels and shapes, actor badges, dependency/barrier cue, delay cue, readable wrong-route failure/restart, color-independent redundancy, v2 evidence, owner question: “Could you tell why the two routes were different and connected?” Cut on duplicate, optional dependency, budget overrun, unclear topology, unbounded change, opaque failure, execution-heavy route, schedule cost.

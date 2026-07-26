# S03 — 回声感应 / Echo Signal

`candidate_slot = S03`; `family = body_shadow`; `phase = PHASE_1_PROOF_BATCH`; `status = BRIEF_FROZEN_NOT_AUTHORED`; `production_sequence = UNASSIGNED`; `catalog_status = NOT_AUTHORIZED`; `owner_review_status = NOT_REVIEWED`; `machine_validation_status = NOT_RUN`.

Teaching goal: prove an `ECHO_ONLY` sensor is necessary while YOU has an independent route responsibility. Objective: route delayed ECHO to the marked sensor, then use the body’s prepared route. Prerequisites S01 and typed cue literacy; reasoning is sensor eligibility plus coordination; anti-duplication is no ANY/YOU equivalent; non-goals: crate eligibility or latches.

Body prepares/crosses its route; ECHO activates `ECHO_ONLY` sensor. Roles are non-substitutable because switching eligibility, removing ECHO, or removing body route must fail the intended claim.

Dependencies: `SUPPORTED_AS_IS`; v2 sensor `ECHO_ONLY`, `include_crates=false`, barrier group; current sensor/barrier transition and BFS; no missing contract; presentation needs ECHO-only silhouette, barrier state, distinct body route and delay cue; forbidden shortcuts are ANY/YOU sensor, alternate body bypass, or sensor-free barrier.

`topology_status = DESIGN_HYPOTHESIS_NOT_LEVEL_DATA`.
```text
BODY PREP -> EXIT LANE
ECHO DELAY -> [ECHO-ONLY SENSOR] => BODY LANE OPENS
```
Solution hypothesis: body enters preparation lane; delayed ECHO activates sensor; opened barrier enables body exit. Witness ECHO-only activation before body crossing; critical timing is ECHO arrival. `candidate_solution_status = HUMAN_DESIGN_HYPOTHESIS_NOT_MACHINE_VERIFIED`.

Budget: Intermediate; target `L*=12–20`, hard `24`; states `100k/250k`; elapsed `30/90s`; enum `128`; witnesses typed sensor/barrier/body exit; timeout `UNVERIFIED`.

Controls: intended witness; sensor ANY_ACTOR; sensor YOU_ONLY; echo disabled; body route removed; topology audit; restart; trivial rejection. Presentation: badges, sensor text/silhouette, barrier link, delay cue, readable inactive-sensor failure/restart, color-independent redundancy, v2 evidence, owner question: “Was it clear that only the ECHO could activate this?” Cut on duplicate, optional sensor, budget overrun, unclear eligibility, unbounded change, opaque failure, execution-heavy route, schedule cost.

# S03 — 回声感应 / Echo Signal

`candidate_slot = S03`; `family = body_shadow`; `phase = PHASE_1_PROOF_BATCH`; `status = MACHINE_VALIDATED_FOR_GPT_REVIEW`; `production_sequence = UNASSIGNED`; `catalog_status = NOT_AUTHORIZED`; `owner_review_status = NOT_REVIEWED`; `machine_validation_status = PASS_FOR_GPT_REVIEW`.

Teaching goal: prove an `ECHO_ONLY` sensor is necessary while YOU has an independent route responsibility. Objective: route delayed ECHO to the marked sensor, then use the body’s prepared route. Prerequisites S01 and typed cue literacy; reasoning is sensor eligibility plus coordination; anti-duplication is no ANY/YOU equivalent; non-goals: crate eligibility or latches.

Body prepares/crosses its route; ECHO activates `ECHO_ONLY` sensor. Roles are non-substitutable because switching eligibility, removing ECHO, or removing body route must fail the intended claim.

Dependencies: `SUPPORTED_AS_IS`; v2 sensor `ECHO_ONLY`, `include_crates=false`, barrier group; current sensor/barrier transition and BFS; no missing contract; presentation needs ECHO-only silhouette, barrier state, distinct body route and delay cue; forbidden shortcuts are ANY/YOU sensor, alternate body bypass, or sensor-free barrier.

`topology_status = AUTHORED_UNCATALOGUED_LEVEL_DATA`.
```text
BODY PREP -> EXIT LANE
ECHO DELAY -> [ECHO-ONLY SENSOR] => BODY LANE OPENS
```
Machine result: body commits on turn 2; delayed ECHO activates the sensor and opens the barrier on turn 6; YOU crosses from an open start snapshot on turn 7 and reaches EXIT on turn 13. Shared BFS: `L*=13`, exact `N*=11`; all shortest `11/11`, omissions zero. `candidate_solution_status = MACHINE_VALIDATED_FOR_GPT_REVIEW`.

Budget: Intermediate; target `L*=12–20`, hard `24`; states `100k/250k`; elapsed `30/90s`; enum `128`; witnesses typed sensor/barrier/body exit; timeout `UNVERIFIED`.

Controls passed: no ECHO, `YOU_ONLY`, body-route removed and ECHO-route removed are complete-unsolved; `ANY_ACTOR`, dependency removal, initially open, direct body bypass and symmetric path prove substitution or material change. Retained manifest `e41c771e-0df0-4ac5-a7d6-545b2175cc3b` passed once and is permanently no-rerun. Presentation remains `MACHINE_CONTRACT_READY_OWNER_REVIEW_PENDING`; owner question: “Was it clear that only the ECHO could activate this?”

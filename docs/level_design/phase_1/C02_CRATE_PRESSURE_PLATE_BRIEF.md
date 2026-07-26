# C02 — 压印回路 / Pressure Imprint

`candidate_slot = C02`; `family = crate`; `phase = PHASE_1_PROOF_BATCH`; `status = MACHINE_VALIDATED_FOR_GPT_REVIEW`; `production_sequence = UNASSIGNED`; `catalog_status = NOT_AUTHORIZED`; `owner_review_status = NOT_REVIEWED`; `machine_validation_status = PASS_FOR_GPT_REVIEW`; `presentation_status = MACHINE_CONTRACT_READY_OWNER_REVIEW_PENDING`.

Task 0024AW authored the uncatalogued level and retained `L*=14`, exact `N*=1`, all-shortest `1/1` with zero omissions and one consequential push. No-push, excludes-crate, no-crate, displaced-crate and no-ECHO controls are complete-unsolved. Manifest `92ba1407-b34c-4de8-aa81-c4da4978bdaa` is consumed; GPT acceptance remains pending.

## Intent and roles

Teaching goal: distinguish a crate-eligible destination from an actor plate. Visible objective: push the crate onto the stamped sensor, then use the route consequence created for the delayed ECHO. Prerequisites: C01-style push, delayed ECHO, readable barrier. New reasoning is crate-as-sustained occupancy, not obstacle clearing; seed relationship is the sequence-9 correction; anti-duplication is a crate-enabled sensor, not a door held by an actor. Non-goals: freeform physics or generic Sokoban.

YOU positions the crate; ECHO later uses the opened route. `crate_specific_purpose = crate occupies crate-eligible sensor`; the crate is not optional because removing/displacing it closes the only route consequence.

Dependencies: `support_classification = SUPPORTED_AS_IS`; level data uses v2 crates/sensor (`include_crates=true`)/barrier; schema, simulation and solver use existing v2 paths; presentation needs crate stamp, sensor eligibility stamp, barrier state and delay cue; future tests require all listed controls; forbidden shortcuts are actor-substitutable sensor, static-wall replacement, or alternate route.

Topology: `topology_status = AUTHORED_MACHINE_VALIDATED_OWNER_REVIEW_PENDING`.
```text
START -> PUSH BAY -> [crate sensor] => ECHO ROUTE -> EXIT GATE
```
Symbolic solution: position crate; replayed ECHO reaches the now-open route; YOU crosses after the visible state change. Witness: crate-on-sensor before route crossing; critical commitment: irreversible push direction. `candidate_solution_status = MACHINE_VERIFIED_FOR_GPT_REVIEW`.

Budget: Intro; target `L*=10–16`, hard `20`; states soft/hard `50k/150k`; elapsed soft/hard `15/60s`; enumeration cap `128`; witnesses crate-sensor, ECHO route, YOU exit; timeout `UNVERIFIED`.

Controls: intended witness; plate excludes crate; crate not moved; echo disabled; displaced/no crate; topology shortcut audit; restart/reset; trivial-solution rejection. Presentation: identity badges, crate crosshatch, crate-eligible sensor glyph, barrier open/closed mark, delay timeline cue, blocked-route failure and restart readable, shape/text redundancy independent of color, minimum v2 entity rendering, owner question: “Was the crate’s destination and consequence clear?” Cut if duplicate reasoning, optional crate, hard-budget overrun, unclear purpose, unbounded change, opaque failure, execution-heavy route, or schedule cost exceeds proof value.

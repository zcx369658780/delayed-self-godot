# Five-level difficulty recovery and Levels 6–8 plan

- Status: Levels 6–7 are GPT accepted at `INTERNAL_PLAYABLE`; Task 0015V owner Level 7 evidence is non-promotion; Level 8 remains `CONCEPT / UNVERIFIED_DESIGN_TARGET`.
- Frozen authority: [`simulation_v1`](../game_design/GAMEPLAY_SIMULATION_CONTRACT_CURRENT.md), `level_v1`, and seven accepted formal levels.
- Human evidence: Task 0013B Level 6 P0=0/P1=0/P2=3/P3=1; Task 0015V Level 7 `GAVE_UP`, P0=0/P1=0/P2=4/P3=4.
- Review constraint: the owner is the only available playtester. Do not seek or require a third party unless the owner explicitly reverses this decision. Fresh/independent evidence is unavailable and not claimed; the gap is a disclosed residual limitation, not an ordinary internal-development blocker.
- Rule: a solver witness proves machine reachability, not difficulty, clarity, necessity, or fun.

## Recovery objective

Keep Levels 1–5 as a short onboarding spine while making Levels 6–8 demand prediction, synchronization, and recovery-aware planning. Do not inflate difficulty through hidden rules, larger empty maps, unreadable state, or an unaccepted Gate.

## Difficulty framework

### Machine and structural dimensions

| Dimension | Record | Interpretation / guardrail |
|---|---|---|
| `L*` | shortest valid action length | planning horizon only; blocked actions and WAIT both count |
| `N*` | exact or capped shortest-solution count | low count may indicate precision or merely funnelled geometry; always retain count status |
| Search burden | visited states, max frontier, configured depth/state/time/count limits | measures solver work under fixed limits, not player experience |
| Actors | Echo count, each delay, number of distinct delays, delay span | approximates simultaneous temporal obligations |
| Dependency structure | Plate/Door count, each reference set, longest dependency depth | distinguishes chained and AND reasoning from route length |
| Synchronization windows | number and width of turn intervals in which required occupancy aligns | narrow windows raise precision and error cost |
| Meaningful branches | decision points whose alternatives lead to materially different future states | exclude cosmetic loops and equivalent moves |
| Wrong-action recovery | minimum extra turns or restart likelihood after a plausible mistake | separates forgiving planning from brittle execution |
| Trial-and-error bypass | whether repeated motion can solve without stating the intended rule | must be tested with traces and human explanation |
| Mental state | history slots, future replay actions, Door states, actor roles that must be tracked | predicts working-memory demand |
| Observability | whether each future-relevant state is visible through board/HUD feedback | low observability is a UX defect, not legitimate difficulty |

### Human dimensions for later reviews

- unassisted/assisted completion status;
- first-attempt completion when genuinely fresh;
- elapsed time, visible turns, restarts, Help/Timeline use only when directly supplied;
- ability to explain the intended temporal/door rule before reveal;
- confusion location and severity P0–P3;
- perceived difficulty, confidence, frustration, and willingness to continue;
- whether the solution came from planning, trial-and-error, or an unintended shortcut.

No single metric is sufficient. `L*=20` can be a long corridor; `N*=1` can be a forced route; a large frontier can remain visually obvious; and a short level can be difficult if one hidden timing state dominates. Acceptance therefore requires machine validity, mechanic-necessity evidence, observable state, and human comprehension.

## Accepted five-level diagnosis

| Level | Accepted machine evidence | Intended lesson | Owner observation | Recovery disposition |
|---|---|---|---|---|
| 1 `tutorial_reach_exit` | `L*=3`, `N*=3 EXACT`, visited 6, frontier 2 | YOU, movement, EXIT, restart | completed unassisted; sequence overall too easy | keep unchanged as a deliberately short tutorial |
| 2 `tutorial_echo_bridge` | `L*=9`, `N*=12 EXACT`, visited 1,975, frontier 509; no-Echo complete unsolved, 10 states | delayed ECHO holds Plate for YOU | completed unassisted; Timeline/Help not needed | keep unchanged as guided tutorial; any later owner review remains not fresh/independent |
| 3 `vertical_slice_delay_3` | `L*=9`, `N*=31 EXACT`, visited 1,318, frontier 393; Echo-isolated complete unsolved, 1,006 states | independent delay-3 cooperation | completed unassisted; no meaningful rise | retain as short onboarding application; `PROPOSAL_ONLY`: reposition earlier in pacing rather than alter formal data |
| 4 `door_one_turn_late` | `L*=9`, `N*=7 EXACT`, visited 291, frontier 116; no-Echo complete unsolved, 5 states | open result applies to next submitted turn | completed unassisted; timing visually hard to observe | preserve formal level; repair presentation first; do not rebalance geometry until post-feedback review |
| 5 `two_keys_one_door` | `L*=12`, `N*=1 EXACT`, visited 1,260, frontier 225; no-Echo and Plate-relocation variants complete unsolved | two distinct Plates open one AND Door | completed unassisted; AND causality clear; still too easy | keep as a short checkpoint; `PROPOSAL_ONLY`: let Level 6, not a rewrite, deliver the first substantial rise |

All accepted hashes, witnesses, metrics, and status-ladder positions remain unchanged. None of the dispositions promotes a level to fresh-player or candidate acceptance.

## Target curve

| Segment | Role | Target human experience |
|---|---|---|
| Levels 1–2 | tutorials | 0.5–3 minutes each; learn vocabulary without route guidance |
| Levels 3–5 | onboarding checks | 1–4 minutes each; one clear reasoning step; forgiving recovery |
| Level 6 | first core challenge | owner observed approximately 1 minute and two restarts; plan two causally distinct Door windows |
| Level 7 | temporal planning challenge | 5–10 minutes; use multi-delay Timeline to predict alignment |
| Level 8 | compact finale candidate | 7–15 minutes; combine accepted rules and explain the whole chain |

Times are review targets, not promises or inferred owner data. Under the owner-only constraint, compare future supplied owner timings cautiously and repair observability before simplifying logic when delay is caused by unclear state.

## Level 6 implementation — `staggered_doors`

- Status: `GPT_ACCEPTED_INTERNAL_PLAYABLE`; authenticated-owner review recorded, not fresh-player reviewed or candidate accepted.
- Role: first meaningful rise; one delay-3 Echo creates two separate opening windows for two Doors.
- Implemented structure: one shared-spawn ECHO `d=3`; two necessary Plates; two unavoidable Doors with distinct one-Plate reference sets; one player-only EXIT; 9×7 folded route with no terrain bypass.
- Mental model: record a route whose replay presses Plate A and later Plate B while YOU chooses the correct traversal windows. Door state remains combinational and next-turn.
- Geometry difference: two connected chambers with a return lane, not another single straight corridor.

Target and exact results:

| Metric | Target |
|---|---:|
| `L*` | target 15–21; actual 15 |
| `N*` | target 1–12 exact; actual 4 `EXACT` |
| Visited states | target 2,000–40,000; actual 6,772 |
| Max frontier | actual 1,179 |
| Meaningful branches | 3 measured; recoverable penalties +2, +7, +2 |
| Human | Task 0013B owner result: approximately 1 minute, 2 restarts; not fresh/independent |

Completed machine proof package:

1. strict load, solve, replay, exact restart, canonical metric record;
2. no-Echo complete-state search is unsolved;
3. neutralize or relocate each Plate/Door dependency separately and prove the teaching chain no longer completes as intended;
4. prove no terrain route bypasses either Door;
5. trace two distinct closed-start/open-result/open-next-turn entries;
6. show that a one-Door or shared-Plate simplification materially changes the reasoning.

Strict load, solve, replay, exact restart, all-shortest Door event enumeration, no-ECHO complete-unsolved, both Plate-isolation complete-unsolved, Door removal, dependency replacement, EXIT, articulation/bypass, three meaningful decisions, reusable Gameplay, progression, and primitive capture checks passed. Solver limits were depth 64, states 500,000, 30 seconds, count cap 1,000,000. Formal SHA-256 is `3f14c19b50775e36dd5b52664798381cf1292b0a30b377641c03435f45696bc8`.

Task 0013B owner evidence records unassisted completion at visible Turn 16 in approximately 1 minute with two restarts. The owner understood delay-3 replay and both separate Door events, judged the level harder than Level 5, recommended preserving it, and supported a more complex Level 7. The owner also reported that same-colored switches/Doors made order harder to remember, Timeline was unintuitive and unhelpful, and text Help was hard to understand. These are P2 planning inputs, not implementation authority. The review is not fresh or independent and does not establish population difficulty or fun.

## Level 7 selected implementation target — `two_echo_convergence`

- Status: `PLANNING_SELECTED_PENDING_GPT_REVIEW`; no formal level or validation exists.
- Display title: `Two Echo Convergence / 双影汇流`.
- Role: introduce two distinct replay offsets through one readable simultaneous convergence, while preserving Level 8's mixed two-stage synthesis.
- Frozen structure: shared-spawn ECHOs `d=2` and `d=4`; exactly two Plates A/B; exactly one A+B combinational Door; one player-only EXIT; exactly 9×7 figure-eight/recovery topology.
- Mental model: one history feeds two replays at different offsets; place the two ECHOs on A and B together, observe the committed open result, then cross from the next open snapshot.
- Meaningful burden: at least four non-padding decisions and at least three audited recoverable alternatives; WAIT is not a teaching goal.

Frozen prospective bands:

| Metric | Target |
|---|---:|
| `L*` | 17–25 |
| `N*` | 1–8 `EXACT` |
| Visited states | 8,000–150,000 |
| Max frontier | 1,000–25,000 |
| Synchronization | at least one required window of 1–2 turns |
| Owner review | `OWNER_REVIEW_TARGET_NOT_FRESH_NOT_INDEPENDENT`: 3–8 minutes and 1–5 restarts, target only |

Mandatory proof includes strict load/catalog, solve/replay/restart/hash, individual ECHO isolation, no-ECHO/player-only controls, both Plate isolation and dependency simplifications, equal-delay 2/2 and 4/4 controls, Plate relocation, Door removal/articulation, overlap, ECHO-on-EXIT, open-snapshot crossing, actor-role traces, meaningful-decision penalties, prior hashes/metrics, progression, presentation, and aggregate regression. Limit outcomes remain unverified; complete-unsolved requires finite-state exhaustion.

Product decisions are `TIMELINE_REMOVED_FROM_LEVEL_7_TEACHING_GOAL` and `HELP_CONTEXTUAL_OPTIONAL`. Level 7 must be solvable through board-state reasoning without reverse-counting. Dependency legibility requires A/B labels plus different shapes and E2/E4 badges plus different outlines; color is supplementary. Overlap must preserve both ECHO identities, grayscale readability, screenshots, motion, and 960×540 legibility.

Full target freeze and rejected alternatives: [`LEVEL_7_TWO_ECHO_CONVERGENCE_PLAN_CURRENT.md`](LEVEL_7_TWO_ECHO_CONVERGENCE_PLAN_CURRENT.md).

## Level 8 concept — `signal_convergence`

- Status: `CONCEPT / PROPOSAL_ONLY`; finale candidate, not a final-catalog claim.
- Role: combine accepted mechanics without Gate, switch, latch, hazard, anchor, or new goal semantics.
- Proposed structure: two ECHOS `d=2` and `d=4`; three Plates; two combinational Doors, one single dependency and one two-Plate AND dependency; one player-only EXIT.
- Mental model: establish an early Door window, use the resulting route to align the two delayed actors, then cross an AND Door on the next input.
- Geometry difference: a compact three-zone loop that reuses sightlines so every dependency remains visible; no oversized maze.

Target bands:

| Metric | Target |
|---|---:|
| `L*` | 21–30 |
| `N*` | 1–6; exact preferred |
| Visited states | 20,000–300,000 |
| Max frontier | 2,000–50,000 |
| Dependency depth | two visible stages |
| Human | 7–15 minutes; 1–5 restarts; intended chain explained after completion |

Mandatory proof package:

1. Level 6 and 7 proof families combined, with every actor, Plate, and Door individually audited;
2. stage traces prove each Door uses the start-of-turn snapshot;
3. a controlled variant breaks the first stage and another breaks the AND stage;
4. a shortcut audit checks that early actions cannot accidentally solve both stages;
5. Human review distinguishes satisfying synthesis from repetitive replay;
6. narrative text and presentation do not reveal a route.

Timeline/Help test: the default HUD emphasizes only the replay slot relevant to the next visible dependency; Help explains all pointers. If reviewers must constantly open Help because the main state is not observable, repair presentation. Stop if the concept needs an unaccepted Gate, exceeds the fixed schema, only adds path length, or cannot remain readable in the selected board zone.

## Rebalance policy for Levels 3–5

Any rebalance remains `PROPOSAL_ONLY` until separately authorized planning and owner evidence justify it; fresh/independent review is unavailable under the durable owner constraint.

1. Prefer sequencing and new follow-up challenges over editing accepted formal files.
2. Repair Level 4 feedback before changing its geometry; otherwise difficulty and observability are confounded.
3. Preserve Level 5's clear AND demonstration as a success checkpoint.
4. Do not use an unattainable third-party-review count as a trigger. Any Level 3–5 formal edit requires a separately authorized owner-evidence and design-adjudication task.
5. Any edit returns that level to schema, solver, replay, necessity, runtime, and human gates and requires explicit task authority.

## Content-production acceptance gate

A future level advances only through:

```text
CONCEPT
→ SCHEMA_VALID
→ SOLVER_VALIDATED
→ REPLAY_VALIDATED
→ NECESSITY_AND_SHORTCUT_VALIDATED
→ INTERNAL_PLAYABLE
→ FRESH_PLAYER_REVIEWED
→ CANDIDATE_ACCEPTED
```

Quantitative gate:

- record `L*`, `N*` plus exact/capped status, visited/frontier, all limits, one replayed witness, restart equality, formal SHA-256, and catalog cross-reference;
- record the concept's target-band result without rewriting the band after seeing the answer;
- run all actor/dependency/bypass variants and label limits honestly;
- reject “unsolvable” when only a resource limit was reached;
- compare every accepted level metric/hash after any runtime or schema change.

Human gate:

- `FRESH_PLAYER_REVIEWED` remains unavailable under the owner-only constraint and must not be claimed; do not seek or require a third party unless the owner reverses the decision;
- use explicitly classified authenticated-owner evidence for internal planning while disclosing the missing independent evidence at later candidate or release adjudication;
- no movement sequence, next move, witness, or operational hint during the attempt;
- record exposure status, assistance, direct comprehension answers, P0–P3, and only supplied timing/restart/rating data;
- any P0/P1 returns the level to repair; repeated P2 difficulty/observability findings return it to concept or presentation iteration.

A level cannot be accepted because a witness exists, because `L*` is large, because `N*=1`, or because the owner can complete it. Candidate acceptance requires the complete evidence chain and GPT adjudication.

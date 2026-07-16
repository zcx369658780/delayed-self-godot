# Five-level difficulty recovery and Levels 6–8 plan

- Status: Level 6 is `GPT_ACCEPTED_INTERNAL_PLAYABLE`; uncreated Levels 7–8 remain `CONCEPT / UNVERIFIED_DESIGN_TARGET`.
- Frozen authority: [`simulation_v1`](../game_design/GAMEPLAY_SIMULATION_CONTRACT_CURRENT.md), `level_v1`, and the six accepted formal levels.
- Human evidence: authenticated owner sequence review, `NOT_FRESH_NOT_BLIND_OWNER_SEQUENCE_REVIEW`.
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
| 2 `tutorial_echo_bridge` | `L*=9`, `N*=12 EXACT`, visited 1,975, frontier 509; no-Echo complete unsolved, 10 states | delayed ECHO holds Plate for YOU | completed unassisted; Timeline/Help not needed | keep unchanged as guided tutorial; later fresh review decides copy reduction |
| 3 `vertical_slice_delay_3` | `L*=9`, `N*=31 EXACT`, visited 1,318, frontier 393; Echo-isolated complete unsolved, 1,006 states | independent delay-3 cooperation | completed unassisted; no meaningful rise | retain as short onboarding application; `PROPOSAL_ONLY`: reposition earlier in pacing rather than alter formal data |
| 4 `door_one_turn_late` | `L*=9`, `N*=7 EXACT`, visited 291, frontier 116; no-Echo complete unsolved, 5 states | open result applies to next submitted turn | completed unassisted; timing visually hard to observe | preserve formal level; repair presentation first; do not rebalance geometry until post-feedback review |
| 5 `two_keys_one_door` | `L*=12`, `N*=1 EXACT`, visited 1,260, frontier 225; no-Echo and Plate-relocation variants complete unsolved | two distinct Plates open one AND Door | completed unassisted; AND causality clear; still too easy | keep as a short checkpoint; `PROPOSAL_ONLY`: let Level 6, not a rewrite, deliver the first substantial rise |

All accepted hashes, witnesses, metrics, and status-ladder positions remain unchanged. None of the dispositions promotes a level to fresh-player or candidate acceptance.

## Target curve

| Segment | Role | Target human experience |
|---|---|---|
| Levels 1–2 | tutorials | 0.5–3 minutes each; learn vocabulary without route guidance |
| Levels 3–5 | onboarding checks | 1–4 minutes each; one clear reasoning step; forgiving recovery |
| Level 6 | first core challenge | 3–7 minutes; plan two causally distinct Door windows |
| Level 7 | temporal planning challenge | 5–10 minutes; use multi-delay Timeline to predict alignment |
| Level 8 | compact finale candidate | 7–15 minutes; combine accepted rules and explain the whole chain |

Times are review targets, not promises or inferred owner data. If fresh players materially exceed them because state is unclear, repair observability before simplifying logic.

## Level 6 implementation — `staggered_doors`

- Status: `GPT_ACCEPTED_INTERNAL_PLAYABLE`; not fresh-player reviewed or candidate accepted.
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
| Human | 3–7 minutes, 0–3 restarts in later fresh review |

Completed machine proof package:

1. strict load, solve, replay, exact restart, canonical metric record;
2. no-Echo complete-state search is unsolved;
3. neutralize or relocate each Plate/Door dependency separately and prove the teaching chain no longer completes as intended;
4. prove no terrain route bypasses either Door;
5. trace two distinct closed-start/open-result/open-next-turn entries;
6. show that a one-Door or shared-Plate simplification materially changes the reasoning.

Strict load, solve, replay, exact restart, all-shortest Door event enumeration, no-ECHO complete-unsolved, both Plate-isolation complete-unsolved, Door removal, dependency replacement, EXIT, articulation/bypass, three meaningful decisions, reusable Gameplay, progression, and primitive capture checks passed. Solver limits were depth 64, states 500,000, 30 seconds, count cap 1,000,000. Formal SHA-256 is `3f14c19b50775e36dd5b52664798381cf1292b0a30b377641c03435f45696bc8`.

Timeline/Help remains contextual and Help remains modal/zero-turn. Later fresh review must establish whether it supports prediction; no human difficulty or fun claim is made from machine evidence.

## Level 7 concept — `two_echo_convergence`

- Status: `CONCEPT / PROPOSAL_ONLY`.
- Role: make the compact Timeline operationally relevant.
- Proposed structure: two ECHOs with delays 2 and 4; two distinct Plates; one combinational AND Door; one player-only EXIT.
- Mental model: one input history feeds two replays at different offsets; align both ECHOs on separate Plates, then traverse from an already-open snapshot.
- Geometry difference: two approach loops with distinct path lengths converging on one visible AND gate.

Target bands:

| Metric | Target |
|---|---:|
| `L*` | 17–25 |
| `N*` | 1–8, exact if resource limits permit |
| Visited states | 8,000–150,000 |
| Max frontier | 1,000–25,000 |
| Synchronization | at least one required window of 1–2 turns |
| Human | 5–10 minutes, prediction demonstrated before completion |

Mandatory proof package:

1. both Echoes individually necessary through remove/isolate controls;
2. each Plate dependency necessary; actor overlap cannot press both positions;
3. equalizing the delays or relocating a Plate changes or destroys the intended synchronization proof;
4. one solver witness replay plus a trace mapping each relevant history slot to each Echo;
5. no route or single-actor bypass; ECHO on EXIT remains non-terminal;
6. bounded no-Timeline human comparison only if ethically practical; no route hints.

Timeline/Help test: Timeline is visible from entry, points to both next replay slots, and can be expanded through Help. A reviewer must correctly predict both next ECHO actions at least once. If the level can be solved reliably without reading either delay, it fails its teaching role even when solvable. Stop if search exceeds 500,000 states/20 seconds without a justified limit increase, visual overlap makes actors ambiguous, or working-memory demand comes mainly from unreadable UI.

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

Any rebalance remains `PROPOSAL_ONLY` until Levels 6–8 and a fresh sequence review exist.

1. Prefer sequencing and new follow-up challenges over editing accepted formal files.
2. Repair Level 4 feedback before changing its geometry; otherwise difficulty and observability are confounded.
3. Preserve Level 5's clear AND demonstration as a success checkpoint.
4. Consider a Level 3–5 formal edit only if two fresh reviewers independently report repetition after presentation recovery.
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

- at least one qualifying fresh reviewer before `FRESH_PLAYER_REVIEWED` and an independent complete-flow review before `CANDIDATE_ACCEPTED`;
- no movement sequence, next move, witness, or operational hint during the attempt;
- record exposure status, assistance, direct comprehension answers, P0–P3, and only supplied timing/restart/rating data;
- any P0/P1 returns the level to repair; repeated P2 difficulty/observability findings return it to concept or presentation iteration.

A level cannot be accepted because a witness exists, because `L*` is large, because `N*=1`, or because the owner can complete it. Candidate acceptance requires the complete evidence chain and GPT adjudication.

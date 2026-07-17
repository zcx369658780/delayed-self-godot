# Level 7 false-unsolvable repair plan (CURRENT)

- Status: `PLANNING_READY_FOR_GPT_REVIEW`
- Task: `tasks/0015D_level_7_false_unsolvable_diagnostic_and_repair_planning.md`
- Problem classification: `BLOCKING_P2_FALSE_UNSOLVABLE_MENTAL_MODEL_AND_RECOVERY_FAILURE`
- Accepted implementation: `27a678da47d1ba34ed012f8840b8c80c775e8be1`
- Formal Level 7 SHA-256: `772410d3b8bb807e35472ee2a7d07b703de66e1e0e92ffb4d1ff8433a345d5fd`
- Selected primary bundle: `TRANSITION_DERIVED_ECHO_DIVERGENCE_FEEDBACK`
- Optional fallback: `GEOMETRY_ONLY_EARLY_DIVERGENCE_REAUTHORING`

## 1. Accepted baseline and contradiction

Level 7 `two_echo_convergence` remains accepted at `INTERNAL_PLAYABLE`. Its frozen machine result is `L*=19`, `N*=6 EXACT`, visited 61,975, maximum frontier 21,449. All six shortest solutions use E2 on A, E4 on B, and an open-snapshot Door crossing. No-ECHO, single-ECHO, equal-delay, relocation, Plate-isolation, and bypass controls remain accepted.

Task 0015V nevertheless ended `GAVE_UP`. The authenticated owner understood the delay-2/delay-4 identities, E2-on-A/E4-on-B roles, A+B Door condition, and actor/dependency cues, but concluded that the two ECHOs' physical separation was fixed by the two-turn delay difference. Help and a later high-level explanation did not repair that belief. This is a discoverability and recovery failure, not contradictory machine evidence.

The correct causal principle is:

> E2 and E4 read different slots of the same history. Because those slots can contain different actions, and because each actor starts from its own prior position and may be blocked by terrain, their relative spacing can change.

The accepted witness contains no turn where both ECHOs replay the same non-WAIT action and settle differently. The repair must therefore explain state-transition outcomes broadly; it must not falsely reduce the lesson to “same input, different result.”

## 2. Deterministic causal diagnosis

Coordinate convention: `Δ=(E2.x-E4.x, E2.y-E4.y)` and `M=|Δx|+|Δy|`. `A`, `B`, and `A+B` in the state column are committed Plate occupancy; Door state is the committed result after settlement. `blk` means the requested move was blocked.

| T | Submitted | YOU before→after | E2 slot; before→after | E4 slot; before→after | Δ/M before→after | Committed state | Convergence phase |
|---:|---|---|---|---|---|---|---|
| 1 | R | (1,5)→(2,5) | WAIT; (1,5)→(1,5) | WAIT; (1,5)→(1,5) | (0,0)/0→(0,0)/0 | none; Door closed | seed history |
| 2 | R | (2,5)→(3,5) | WAIT; (1,5)→(1,5) | WAIT; (1,5)→(1,5) | (0,0)/0→(0,0)/0 | none; closed | seed history |
| 3 | R | (3,5)→(4,5) | R; (1,5)→(2,5) | WAIT; (1,5)→(1,5) | (0,0)/0→(1,0)/1 | none; closed | first physical spacing change |
| 4 | R | (4,5)→(5,5) | R; (2,5)→(3,5) | WAIT; (1,5)→(1,5) | (1,0)/1→(2,0)/2 | none; closed | apparent fixed separation begins |
| 5 | R | (5,5)→(6,5) | R; (3,5)→(4,5) | R; (1,5)→(2,5) | (2,0)/2→(2,0)/2 | none; closed | apparent invariant preserved |
| 6 | R | (6,5)→(7,5) | R; (4,5)→(5,5) | R; (2,5)→(3,5) | (2,0)/2→(2,0)/2 | B; closed | apparent invariant preserved |
| 7 | U | (7,5)→(7,4) | R; (5,5)→(6,5) | R; (3,5)→(4,5) | (2,0)/2→(2,0)/2 | none; closed | route turn begins |
| 8 | U | (7,4)→(7,3) | R; (6,5)→(7,5) | R; (4,5)→(5,5) | (2,0)/2→(2,0)/2 | B; closed | route history accumulates |
| 9 | U (YOU blk) | (7,3)→(7,3) | U; (7,5)→(7,4) | R; (5,5)→(6,5) | (2,0)/2→(1,-1)/2 | none; closed | earliest post-startup contradiction of fixed vector |
| 10 | L | (7,3)→(6,3) | U; (7,4)→(7,3) | R; (6,5)→(7,5) | (1,-1)/2→(0,-2)/2 | A+B; Door open | first visible but not final opening |
| 11 | R | (6,3)→(7,3) | U; (7,3)→(7,2) | U; (7,5)→(7,4) | (0,-2)/2→(0,-2)/2 | none; closed | repositions histories |
| 12 | D | (7,3)→(7,4) | L; (7,2)→(6,2) | U; (7,4)→(7,3) | (0,-2)/2→(-1,-1)/2 | none; closed | actors enter different branches |
| 13 | D | (7,4)→(7,5) | R blk; (6,2)→(6,2) | U blk; (7,3)→(7,3) | (-1,-1)/2→(-1,-1)/2 | B; closed | both blocked; phase stored |
| 14 | U | (7,5)→(7,4) | D; (6,2)→(6,3) | L; (7,3)→(6,3) | (-1,-1)/2→(0,0)/0 | A; closed | ECHOs overlap; spacing collapses |
| 15 | D | (7,4)→(7,5) | D blk; (6,3)→(6,3) | R; (6,3)→(7,3) | (0,0)/0→(-1,0)/1 | A+B; Door open | terrain makes E2 stay while E4 moves |
| 16 | U | (7,5)→(7,4) | U; (6,3)→(6,2) | D; (7,3)→(7,4) | (-1,0)/1→(-1,-2)/3 | none; closed | distinct slots expand spacing to target offset |
| 17 | U | (7,4)→(7,3) | D; (6,2)→(6,3) | D; (7,4)→(7,5) | (-1,-2)/3→(-1,-2)/3 | A+B; Door open | required E2-on-A/E4-on-B window |
| 18 | U | (7,3)→(7,2) | U; (6,3)→(6,2) | U; (7,5)→(7,4) | (-1,-2)/3→(-1,-2)/3 | none; closed | YOU crosses from open start snapshot |
| 19 | U | (7,2)→(7,1) | U blk; (6,2)→(6,2) | D; (7,4)→(7,5) | (-1,-2)/3→(-1,-3)/4 | B; closed; complete | EXIT reached |

There are three different “earliest” facts that must not be conflated:

1. Turn 3 is the earliest physical spacing change, caused by E2 becoming active while E4 still replays WAIT.
2. Turn 9 is the earliest change after the apparently stable two-cell separation has formed. E2 replays `UP`, E4 replays `RIGHT`, so the signed vector changes from `(2,0)` to `(1,-1)`.
3. Turn 15 is the clearest terrain-derived divergence: E2's `DOWN` is blocked while E4's `RIGHT` moves, changing spacing from overlap `(0,0)` to `(-1,0)`. Turn 16 then expands it to `(-1,-2)`, enabling both ECHOs to replay `DOWN` onto A and B at turn 17.

## 3. Counterfactual mental model

The simplest owner-style model is:

```text
Once E2 and E4 are active, E2 position = E4 position + a fixed two-step route offset.
Therefore their distance and direction cannot be changed by player routing.
```

This model appears correct during turns 5–8: both ECHOs move right and preserve `Δ=(2,0)`. It first predicts the wrong signed state at turn 9, where the actual result is `(1,-1)`, not `(2,0)`. It fails decisively at turns 14–16, where the actual Manhattan spacing changes `2→0→1→3`.

The belief is understandable. The opening six RIGHT inputs create a long unobstructed sample in which both ECHOs visibly follow the same lane at the same separation. Current UI identifies actors and dependencies but does not mark spacing change, blocked/moved outcome pairs, or the fact that a useful phase has been created. A player who restarts before turns 14–16 never sees the strongest counterexample.

## 4. Failed-prefix and recovery analysis

| Pattern | Exact bounded prefix/state | Diagnostic result | What current presentation exposes | Missing recovery information |
|---|---|---|---|---|
| Straight-lane confirmation | `R×6`; YOU (7,5), E2 (5,5), E4 (3,5), `Δ=(2,0)` | still solvable; minimum known recovery 13 actions; BFS visited 40,639 | stable two-cell spacing, B occupancy, distinct E2/E4 identities | no indication that future turns can change spacing; restarting here reinforces the false invariant |
| Owner screenshot reconstruction | `R×6,U,U,L,U`; YOU (6,2), E2 (7,3), E4 (7,5), history `[U,U,L,U]`, `Δ=(0,-2)` | exact screenshot state found after 14,375 search visits; still solvable; minimum known recovery 17 actions, recovery BFS visited 42,514 | A/B and actors remain legible; no completion contradiction | no “phase remains recoverable” cue; no explanation that different history slots and blocking can rebuild the target offset |
| Early restart before strong divergence | any restart before overlap/block sequence at turns 14–16 | no formal defect; discards the state transition that disproves the belief | opening lane repeatedly demonstrates stable spacing | no discovered-concept or transition cue survives long enough to invite continued experimentation |

The recovery costs are diagnostic results for those exact states, not runtime hints and not proposed UI values. The primary repair must not run a solver, expose remaining distance, or hardcode either recovery route.

## 5. Candidate comparison

Scores are planning judgments with uncertainty, not human evidence. Weighted total uses the task's 25/20/15/15/10/10/5 percent criteria in order.

| Candidate | False-model correction | Temporal reasoning | Low implementation risk | Recovery clarity | Non-spoiler | Reusable | 960×540 fit | Weighted /5 | Disposition |
|---|---:|---:|---:|---:|---:|---:|---:|---:|---|
| A geometry-only early divergence | 4 | 4 | 3 | 3 | 4 | 3 | 3 | 3.55 | optional fallback only; formal re-authoring has high revalidation cost |
| B state-derived divergence feedback | 5 | 5 | 5 | 4 | 4 | 5 | 3 | 4.65 | **selected primary** |
| C recoverability/progress feedback | 3 | 4 | 4 | 5 | 2 | 2 | 3 | 3.45 | reject; credible feedback risks solver-like or route-specific claims |
| D contextual Help text | 4 | 5 | 5 | 3 | 5 | 4 | 4 | 4.30 | not primary; text/high-level explanation already failed |
| D small causal diagram | 5 | 5 | 4 | 4 | 5 | 4 | 3 | 4.50 | reserve as later supplement, not in primary bundle |
| E structural simplifications | 2 | 2 | 1 | 2 | 1 | 2 | 2 | 1.75 | reject as immediate repair |

Uncertainty is highest for whether a compact transition cue remains readable during rapid owner input and whether it will be noticed without becoming noisy. That uncertainty is testable with focused captures and the owner-only retest.

## 6. Owner proposal dispositions

| Proposal | Disposition | Reason |
|---|---|---|
| Change E4 delay to 5 | not selected | formal redesign; may merely make Plate spacing look fixed and weaken the two-offset lesson |
| Change Plate spacing | fallback-design input only | formal geometry change requires complete revalidation and may trivialize convergence |
| Persistent/one-shot Door | rejected for this repair | expands schema/runtime/Gate semantics and removes the open-snapshot lesson |
| Exact operation Help | rejected as default | route hardcoding and spoiler; does not teach a reusable causal model |
| Longer route | rejected | adds duration without directly correcting the false invariant |
| Push boxes | deferred new-mechanic scope | requires simulation, solver, schema, UI, level, and validation work; belongs to a separately authorized future gate |
| Supplementary color | retain as supplement | useful identity reinforcement, but the owner already read A/B and E2/E4 correctly; color alone cannot expose spacing change |
| Animation | small non-route causal diagram may be reconsidered | only acceptable if state-derived, bounded, grayscale-readable, and not an exact walkthrough |

## 7. Selected primary repair bundle

Exactly one primary bundle is selected:

```text
TRANSITION_DERIVED_ECHO_DIVERGENCE_FEEDBACK
```

Preserve formal Level 7, all rules, delays, geometry, catalog, metrics, and hashes. In a later authorized task, add one short reusable board/HUD transition cue when E2/E4 relative spacing changes. The cue is derived only from the before/after presentation record already available to Gameplay:

- identify each ECHO by the existing E2/E4 badge and outline;
- show each outcome as `MOVED` or `BLOCKED`, with a short endpoint/trail treatment;
- when signed or Manhattan spacing changes, pulse a concise non-route label such as `ECHO SPACING CHANGED`;
- for the clearest blocked/moved transition, allow a compact form such as `E2 BLOCKED · E4 MOVED → SPACING CHANGED`;
- never claim both ECHOs received the same action unless their actual history slots match;
- do not show target coordinates, required separation, remaining moves, Plate assignment, exact timing, solver state, or next action;
- keep Timeline outside the teaching dependency and do not change default Help.

This bundle teaches the causal principle at the moment of evidence. It is reusable for later multi-ECHO content and does not require formal-data, simulation, solver, schema, or catalog changes.

## 8. Optional fallback

One fallback is allowed:

```text
GEOMETRY_ONLY_EARLY_DIVERGENCE_REAUTHORING
```

Use it only if the primary bundle passes machine/capture tests but the owner still maintains the fixed-spacing impossibility model. A separate task must author diagnostic-only variants first and select geometry that shows an early visible route/block divergence while retaining E2 delay 2, E4 delay 4, A+B, an unavoidable Door, player-only EXIT, two-offset necessity, and material difficulty over Level 6.

Any fallback formal edit invalidates the current Level 7 hash and requires the full Task 0015 proof family: strict load, solve, exact `N*`, replay, restart equality, all controls, articulation/bypass, overlap, meaningful decisions, recovery, progression, capture, aggregate regression, and new SHA-256/metrics. Limit results must never be called unsolved.

## 9. Later implementation authorization surface

The primary bundle may authorize only:

- `scripts/gameplay/vertical_slice.gd`;
- a focused Gameplay transition test under `tests/gameplay/`;
- a focused 960×540 capture harness under `tests/gameplay/`;
- `tests/run_all.gd` only to register the focused test marker/assertions;
- one implementation report and the necessary current Markdown subset.

The primary bundle must not change:

- `data/levels/two_echo_convergence.json` or any formal level;
- catalog, schema, simulation, solver, scene, `project.godot`, Timeline model/index/layout, Help architecture/copy, assets, fonts, audio, imports, save data, build, export, release, or Level 8.

If the desired feedback cannot be implemented inside the listed surface without presentation code duplicating puzzle logic, stop and return to GPT planning.

## 10. Later acceptance criteria

### Machine and controls

1. Record all seven pre-repair formal SHA-256 values and accepted metrics.
2. Level 7 SHA-256 remains `772410d3b8bb807e35472ee2a7d07b703de66e1e0e92ffb4d1ff8433a345d5fd`; `L*=19`, `N*=6 EXACT`, visited 61,975, frontier 21,449 remain exact.
3. Aggregate regression passes with all existing nine markers plus one focused repair marker; no pre-existing assertion/vector count is lost.
4. Focused tests cover no-change, ordinary spacing change, overlap→separation, moved/blocked, restart reset, direct launch, and completion; presentation reads committed transitions and never changes canonical state.
5. No runtime solver, solution table, route hardcoding, target-spacing check, or exact movement walkthrough exists.

### 960×540 and grayscale presentation

1. Existing A/B shapes, E2/E4 badges/outlines, dependency paths, Door cues, status, and board remain legible and non-overlapping.
2. The cue remains readable at 960×540 and in grayscale without relying on color.
3. At least two non-color identity cues remain for each dependency/actor pair.
4. The cue does not obscure YOU, ECHOs, Plates, Door, EXIT, goal, or completion feedback.
5. Captures include stable-spacing, signed-vector change, overlap, blocked/moved separation, target A+B window, and no-cue control states.

### Owner-only retest

Classification remains:

```text
AUTHENTICATED_OWNER_NOT_FRESH_NOT_INDEPENDENT_LEVEL_7_RETEST
```

The owner receives no movement sequence or solver witness during the unassisted attempt. Record duration/restarts/Help/Timeline only as supplied. Promotion requires P0=0/P1=0 and:

- the owner explains that ECHO spacing can change because different history slots and terrain/blocking produce different settlements;
- the owner completes unassisted, **or**, if incomplete, no longer judges the level mathematically impossible and can describe a credible experiment/recovery strategy;
- the blocking P2 is closed or materially reduced before Level 8.

No third party may be sought or required.

## 11. Rollback, stop conditions, and non-claims

Rollback the presentation-only files if the cue changes canonical state, duplicates simulation rules, introduces route-specific logic, obscures existing cues, misreports replay actions/outcomes, or regresses 960×540/grayscale captures.

Stop and return to GPT if:

- the primary bundle needs scene, schema, simulation, solver, formal-level, catalog, Timeline, or Help changes;
- state-derived feedback cannot be made correct without route knowledge;
- aggregate, hash, metric, restart, progression, or capture evidence differs;
- owner evidence still supports the fixed-spacing impossibility model after the primary repair;
- any credible next step requires the fallback formal redesign or new mechanics.

This plan is not product implementation, GPT acceptance, candidate acceptance, balance/fun proof, fresh/independent evidence, Level 8 authority, or release authority.

## 12. Next gate

GPT review may authorize one bounded implementation of the selected primary bundle. Level 8 remains blocked until that implementation passes machine validation and the owner-only retest closes or materially reduces the blocking P2.

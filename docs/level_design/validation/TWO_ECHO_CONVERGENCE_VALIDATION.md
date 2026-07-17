# Two Echo Convergence validation

- Level: `two_echo_convergence / Two Echo Convergence / 双影汇流`
- Contract: `level_v1` + `simulation_v1`
- Status: `INTERNAL_PLAYABLE / PENDING GPT REVIEW`
- Formal SHA-256: `772410d3b8bb807e35472ee2a7d07b703de66e1e0e92ffb4d1ff8433a345d5fd`
- Authoring iterations: 8 bounded candidates

## Formal facts and exact solve

The tracked formal file is exactly 9×7. YOU, `echo_near` (delay 2), and `echo_late` (delay 4) share spawn `[1,5]`. `plate_a=[6,3]`, `plate_b=[7,5]`, and initially closed `door_convergence=[7,2]` depends on the exact AND-set `[plate_a, plate_b]`. The player-only EXIT is `[7,1]`; removing the Door cell disconnects YOU from EXIT.

Limits were depth 64, states 500,000, time 30,000 ms, and solution-count cap 1,000,000. The accepted shared BFS result is:

| Measure | Required | Exact result |
|---|---:|---:|
| `L*` | 17–25 | 19 |
| `N*` | 1–8, `EXACT` | 6, `EXACT` |
| visited states | 8,000–150,000 | 61,975 |
| maximum frontier | 1,000–25,000 | 21,449 |
| required convergence window | 1–2 turns | 1 result turn |

Selected shortest witness:

```text
RIGHT RIGHT RIGHT RIGHT RIGHT RIGHT UP UP UP LEFT RIGHT DOWN DOWN UP DOWN UP UP UP UP
```

It contains no literal WAIT. Turn 9 is one visible attempt into the closed Door; it is not repeated, is part of the accepted blocked-action contract, and is not counted as a meaningful decision or recovery. There is no repeated collision macro.

## Convergence and open-snapshot proof

Across the critical result/crossing sequence:

| Input turn | YOU result | E4 result | E2 result | Pressed | Door result | Meaning |
|---:|---|---|---|---|---|---|
| 16 | `[7,4]` | `[7,4]` | `[6,2]` | none | closed | approach/recovery |
| 17 | `[7,3]` | `[7,5]` (`plate_b`) | `[6,3]` (`plate_a`) | A+B | open | required two-ECHO convergence result |
| 18 | `[7,2]` | `[7,4]` | `[6,2]` | none | closed | input began from the open snapshot and entered Door |
| 19 | `[7,1]` | `[7,3]` | `[6,3]` | A | closed | YOU alone completes at EXIT |

At turn 17, E4 reads history slot `DOWN` at offset 4 and E2 reads history slot `DOWN` at offset 2. Their prior positions differ, so the same replayed action settles them on distinct Plates. The committed A+B result opens the Door for exactly the following start-turn snapshot. Closure after entry does not invalidate the occupant.

An augmented exact breadth-first enumeration counted all six shortest solutions. Event counts were `{required_two_echo_crossing: 6, bypass: 0}`. Every shortest solution enters from an open snapshot while E2 occupies A and E4 occupies B. Legal ECHO overlap activates at most one Plate cell and cannot substitute for two roles.

Three of the six shortest solutions contain an optional WAIT-equivalent timing choice; three, including the selected witness, do not. WAIT is therefore not necessary, is not a teaching goal, is not counted as a decision, and strict WAIT research remains deferred.

## Complete control matrix

All controls use the same limits. `UNSOLVABLE_WITHIN_COMPLETE_FINITE_STATE` means queue exhaustion without depth/state/time/count limitation.

| Control | Exact result | Interpretation |
|---|---|---|
| only `echo_near` | complete unsolved; visited 750, frontier 140 | E4 is necessary |
| only `echo_late` | complete unsolved; visited 18,750, frontier 3,500 | E2 is necessary |
| no ECHO | complete unsolved; visited 30, frontier 5 | player-only bypass absent |
| relocate A to `[1,1]` | complete unsolved; visited 18,750, frontier 3,500 | A placement/role necessary; terrain remains connected |
| relocate B to `[1,1]` | complete unsolved; visited 18,750, frontier 3,500 | B placement/role necessary; terrain remains connected |
| A-only dependency | `L=11`, `N=70 EXACT`, visited 16,875, frontier 3,500 | materially simpler and loses two-ECHO role |
| B-only dependency | `L=10`, `N=1 EXACT`, visited 14,375, frontier 3,500 | materially simpler and loses two-ECHO role |
| delays 2/2 | complete unsolved; visited 750, frontier 140 | equal actors overlap and cannot fill A+B |
| delays 4/4 | complete unsolved; visited 18,750, frontier 3,500 | equal actors overlap and cannot fill A+B |
| remove Door | `L=10`, `N=30 EXACT`, visited 14,375, frontier 3,500 | removes the temporal obligation |

The Door is a terrain articulation. ECHO-on-EXIT is non-terminal, YOU-on-EXIT completes, restart reconstructs the exact initial state, and solver witness replay equals reusable Gameplay replay. No side route, single-ECHO route, overlap, movement cycle, or persistent opening bypasses the required event.

## Meaningful decisions and recovery

Exact/bounded searches from distinct alternative successors recorded six decisions and six recoveries:

| Turn | Decision | Alternative | Minimum penalty |
|---:|---|---|---:|
| 4 | lower-loop route setup | `UP` | +2 |
| 7 | convergence-lane approach | `LEFT` | +2 |
| 10 | Plate-role crossover | `DOWN` | +5 |
| 11 | recovery-loop commitment | `LEFT` | +2 |
| 15 | window timing | `LEFT` | +3 |
| 16 | Door-approach commitment | `LEFT` | +2 |

Each alternative has a distinct canonical successor and remains solvable. These choices change route, history phase, Plate role, recovery, or Door commitment; none is a WAIT, input alias, forced corridor continuation, or repeated collision.

## Presentation, runtime, and preservation

Reusable Gameplay derives the cues from a multi-ECHO AND dependency rather than `level_id`: Plate A has an A/triangle identity, Plate B has B/circle, Door shows `A+B` plus independently filled pips, E2 uses a solid outline, and E4 uses a double dashed outline. Both badges/outlines remain present during overlap. Snapshot tests and eight 960×540 native Compatibility-renderer captures passed; the grayscale frame retains labels, shapes, outline, and fill distinctions.

Seven-entry catalog load, ordered unlock, Level 7 direct route, reusable Gameplay completion, Help zero-turn behavior, optional inherited Timeline behavior, restart, return, reset, and Task 0011R window-fill regression passed. Aggregate result: `367 assertions / 9 vectors`, all nine markers exactly once. The six earlier formal hashes and accepted metrics are unchanged.

## Non-claims

This validation establishes machine validity, exact search facts, controls, runtime replay, primitive cue visibility, and internal playability only. It does not establish human difficulty, fun, balance, fresh/independent comprehension, owner acceptance, candidate acceptance, final art/audio/narrative, complete flow, export, release, or submission readiness.

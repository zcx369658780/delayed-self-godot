# Level 8 finale and difficulty-bridge plan (CURRENT)

## Task 0017C implementation result

The accepted bridge target is formally implemented as exact reconstruction `echo_spacing_bridge / Diverging Echoes / 错位回声`: 8×7, shared-spawn E2/E4 delays 2/4, two Plates, one A+B Door, one player-only EXIT, `L*=16`, `N*=12 EXACT`, visited 19,059, frontier 3,734. All shortest paths satisfy the frozen divergence and crossing obligations; complete no-ECHO and single-ECHO controls are unsolved. The eight-entry catalog places it at sequence 7 and shifts byte-identical `two_echo_convergence` to sequence 8. `signal_convergence` remains unimplemented and unauthorized.

- Status: `BRIDGE_IMPLEMENTED_READY_FOR_GPT_REVIEW`
- Task: `0016R`
- Parent adjudication: `TASK_0016_PLAN_REQUEST_CHANGES_SCHEMA_V1_NECESSITY_CONTRADICTION`
- Sequence decision: `INSERT_BRIDGE_BEFORE_CURRENT_LEVEL_7`
- Selected bridge grammar: `SIMPLIFIED_TWO_PLATE_AND_TUTORIAL`
- Implemented formal target: `echo_spacing_bridge / Diverging Echoes / 错位回声`
- Future finale: `signal_convergence`, preserved as a later sequence-9 concept
- Scope: planning and documentation only

## 1. Accepted baseline and correction boundary

### Accepted content

Level 6 `staggered_doors` remains GPT accepted at `INTERNAL_PLAYABLE`: one delay-3 ECHO, two Plates, two distinct single-dependency Doors, `L*=15`, `N*=4 EXACT`, 6,772 visited states, and maximum frontier 1,179.

Current Level 7 `two_echo_convergence` remains GPT accepted at `INTERNAL_PLAYABLE`: shared-spawn E2/E4, two Plates, one A+B Door, 9×7, `L*=19`, `N*=6 EXACT`, 61,975 visited states, maximum frontier 21,449, and SHA-256:

```text
772410d3b8bb807e35472ee2a7d07b703de66e1e0e92ffb4d1ff8433a345d5fd
```

All seven formal level files, their hashes, metrics, validations, and current catalog remain immutable. Task 0015R transition-derived spacing feedback remains accepted. Task 0015RV remains assisted authenticated-owner evidence, not fresh, independent, or route-discovery evidence.

### Contradiction withdrawn

Task 0016 incorrectly froze:

```text
one Plate + one Door + both ECHOs individually necessary
```

Under `simulation_v1`, actors resolve independently, never block one another, may overlap, and any actor can press the sole Plate. The only Door needs only one Plate holder for its useful crossing. If E2 holds the Plate in a successful sequence, removing E4 preserves that holding event and the crossing; the symmetric argument applies to E4. A second ECHO can be observationally useful but is not mechanically necessary.

The one-Plate/one-Door target and its earlier necessity claim are withdrawn. This revision does not challenge the GPT adjudication.

### Frozen authority

The revised plan stays inside accepted `simulation_v1`, `level_v1`, catalog v1, and reusable Gameplay. It uses only rectangular walls/floor, shared YOU history, fixed-delay ECHOs, blocked-action recording, combinational `all_plate_ids` Doors, legal overlap, player-only EXIT, and open-result/next-input Door entry.

No formal level, catalog edit, coordinates, witness, measured solver result, runtime change, presentation change, or implementation is authorized here.

## 2. Mechanical-feasibility lemmas

Each candidate is evaluated against these obligations:

1. identify a transition or Door window that requires E2;
2. identify a different causal occupancy role that requires E4;
3. prevent YOU from substituting for either role;
4. prevent legal overlap from collapsing the roles;
5. show why removing E2 while preserving all other actors destroys completion;
6. show why removing E4 while preserving all other actors destroys completion;
7. use no presentation state, hidden rule, or new mechanic.

### Candidate A — simplified two-Plate AND tutorial

Grammar:

```text
two shared-spawn ECHOs d=2/d=4
two distinct Plates A/B
one Door depending on A+B
one player-only EXIT
```

Credible necessity lemma:

- An early, visible blocker fork causes E2 to settle into the phase/route that reaches Plate A while E4 settles into the different phase/route that reaches Plate B.
- The required committed result has E2 on A, E4 on B, and YOU already in the Door-approach lane. The following input enters the Door from the open snapshot.
- Each Plate is at least two traversable moves from the Door cell, and the topology has no alternate Plate-to-Door shortcut. If YOU substitutes on either Plate, leaving it creates only one open start snapshot; YOU cannot reach and enter the Door within that one move, so the Door closes before entry.
- One remaining ECHO cannot occupy two distinct Plate cells. Legal overlap presses at most one of them.
- Removing E2 leaves E4 plus YOU. They can occupy A+B, or position YOU for the Door, but cannot do all three at the required result/crossing sequence. Completion is destroyed.
- Removing E4 yields the symmetric two-actor insufficiency and destroys completion.
- Delay/terrain phase assigns the intended shortest-solution roles E2→A and E4→B; complete single-ECHO searches, all-shortest traces, and YOU-substitution controls must later prove the authored geometry.

This was the contract-level feasibility argument; Task 0017C now supplies the separate machine proof for the implemented layout.

Differentiation:

- from Level 6: one simultaneous A+B result after one early blocker experiment, not two sequential single-dependency Door stages;
- from current Level 7: maximum 8×7, early obvious divergence, one primary experiment, 2–3 decisions, direct recovery, and no long phase-management loop;
- from the finale: one Door and one dependency stage only; no mixed single/AND chain or multi-zone synthesis.

Risk: it repeats current Level 7's entity grammar. That repetition is deliberate curriculum scaffolding only if later evidence proves substantially lower search burden, earlier causal visibility, fewer decisions, and simpler recovery.

### Candidate B — dual single-dependency windows

Grammar:

```text
two shared-spawn ECHOs d=2/d=4
two distinct Plates A/B
two Doors with dependencies A and B respectively
one player-only EXIT
```

Credible necessity lemma:

- E2 must create the first open-result/next-input window through Door A.
- E4 must create a later, spatially separated window through Door B after YOU has crossed the first articulation.
- YOU cannot hold the relevant Plate and reach its Door within the single useful snapshot; the other ECHO is phase/route-separated from that Plate.
- Overlap cannot substitute because A and B are different cells and the windows occur in different progression components.
- Removing E2 blocks the first stage; removing E4 permits the first stage but blocks the second.

This grammar is mechanically plausible, subject to complete single-ECHO and route-bypass controls. It is not selected because two staged single-dependency Doors closely repeat Level 6, adds recovery and relationship-display burden, and consumes part of the future finale's multi-stage identity.

### Candidate C — one-Plate multi-window structure

Disposition:

```text
REJECTED_CONTRACT_INFEASIBLE
```

A single Plate opens every Door that references it at the same committed result. Schema v1 has no actor-specific Plate rule, consumed window, latch, one-shot state, or persistent stage memory. A proposed “E2 early press, E4 late press” schedule would depend entirely on unproven layout/timing and would not statically distinguish which ECHO owns the Plate obligation. The remaining ECHO or YOU may reuse the same Plate, and all referencing Doors open together.

Without coordinates, an exact witness, and complete finite-state controls—which this planning task forbids—the grammar supplies no rigorous reason both single-ECHO variants must be unsolved. Repeated route length or optional later crossings are not necessity. Candidate C is therefore rejected before scoring.

### Mandatory rejected baseline — observational second ECHO

```text
REJECTED_SINGLE_ECHO_SOLUTION_SURVIVES
```

If one ECHO opens the only necessary Door and the second exists only to display spacing, removing the observational ECHO preserves the holder, Plate state, Door result, and YOU completion sequence. This fails dual-ECHO necessity and does not force the intended lesson.

## 3. Weighted decision

Viable candidates are scored from 1 to 5. Scores are planning judgments, not measured evidence.

| Criterion | Weight | A — simplified A+B tutorial | B — dual single windows |
|---|---:|---:|---:|
| Mechanical feasibility / dual-ECHO necessity | 25% | 5.0 | 4.0 |
| Curriculum continuity | 20% | 5.0 | 4.0 |
| Differentiation from current Level 7 | 15% | 3.5 | 4.0 |
| Future finale preservation | 15% | 4.5 | 3.5 |
| Observability and recovery | 10% | 4.5 | 3.5 |
| Proof/control feasibility | 10% | 5.0 | 3.5 |
| Catalog/presentation risk | 5% | 4.5 | 3.0 |
| **Weighted total** | **100%** | **4.63 / 5** | **3.78 / 5** |

Candidate C and the observational baseline receive no weighted score because they are contract-infeasible.

Unique selection:

```text
SIMPLIFIED_TWO_PLATE_AND_TUTORIAL
```

The sequence direction remains:

```text
INSERT_BRIDGE_BEFORE_CURRENT_LEVEL_7
```

## 4. Sequence and catalog migration

### Current catalog

1. `tutorial_reach_exit`
2. `tutorial_echo_bridge`
3. `vertical_slice_delay_3`
4. `door_one_turn_late`
5. `two_keys_one_door`
6. `staggered_doors`
7. `two_echo_convergence` — sole `final_level=true`

### Proposed bridge implementation state

1–6 remain unchanged.

7. `echo_spacing_bridge` — prerequisite `staggered_doors`
8. byte-identical `two_echo_convergence` — prerequisite changes to `echo_spacing_bridge`; remains sole `final_level=true`

Only a later authorized implementation may add the bridge and change catalog sequence/prerequisite metadata. It may not alter the accepted `two_echo_convergence` formal JSON.

### Proposed future finale state

9. `signal_convergence` — prerequisite `two_echo_convergence`; becomes sole `final_level=true`

At that separate future gate, `two_echo_convergence` changes to `final_level=false`. No finale file or catalog entry exists under this plan.

### Rollback

If the bridge cannot satisfy its exact proof gates, remove only its later formal file/catalog entry and restore `two_echo_convergence` to sequence 7, prerequisite `staggered_doors`, and sole-final status. No accepted formal level requires rollback.

## 5. Revised exact next formal target

```text
level_id: echo_spacing_bridge
title: Diverging Echoes / 错位回声
role: mandatory sequence-7 dual-ECHO spacing curriculum bridge
grammar: SIMPLIFIED_TWO_PLATE_AND_TUTORIAL
```

### Frozen entity and dependency structure

- exactly one YOU;
- exactly two shared-spawn ECHOs with delays 2 and 4;
- exactly two distinct Plates, provisionally A and B;
- exactly one initially closed Door;
- the Door dependency set is exactly `[A, B]`;
- exactly one player-only EXIT;
- board envelope at most 8×7;
- topology: compact asymmetric early-divergence fork, two separated terminal Plate pockets, a YOU staging/approach lane, and one unavoidable Door articulation;
- each Plate has traversable distance at least two from the Door cell, with no one-turn Plate-to-Door shortcut;
- one dependency stage and no second Door.

Coordinates, exact walls, route, witness, and JSON remain deliberately unfrozen.

### Exact causal obligations

E2 obligation:

> After the early blocker-derived spacing change, delay-2 E2 must occupy Plate A in the required A+B result while YOU is staged at the Door; removing E2 leaves too few independent bodies to hold both separated Plates and still have YOU enter the Door.

E4 obligation:

> The same divergence must place delay-4 E4 on the distinct Plate B in that required result; removing E4 creates the symmetric two-body insufficiency and eliminates every valid A+B crossing.

YOU cannot substitute because leaving a Plate provides only one open start snapshot and the Door is more than one traversable move away. Overlap cannot substitute because two distinct Plate cells must be occupied simultaneously.

### Spacing-change teaching event

- every shortest solution must contain an early post-activation transition where one ECHO is `BLOCKED` and the other `MOVED`;
- the event must occur before the final A+B setup and visibly change signed or Manhattan spacing;
- board geometry and committed transition feedback must make cause and result observable;
- the event may not be a repeated collision macro, a literal WAIT lesson, or an optional spectacle unrelated to completion.

### Meaningful decisions and recovery hypotheses

1. choose when to enter the blocker fork so E2/E4 settle differently;
2. preserve or correct the two resulting phases toward their separated Plate pockets;
3. commit YOU to the Door approach before the A+B result.

Require 2–3 audited meaningful decisions, at least two of which are not repeated collision, forced corridor continuation, or literal WAIT. Require at least two recoverable alternatives with bounded penalties or a short visible return to setup. Restart must not be the only comprehensible recovery.

### Anti-padding and shortcut conditions

- no literal WAIT requirement or WAIT teaching target;
- no long corridor, repeated collision, or route length as primary difficulty;
- no player-only, no-ECHO, E2-only, or E4-only solution;
- no YOU-on-one-Plate substitution crossing;
- no overlap satisfying A+B;
- no side route around the Door articulation;
- no shortest solution without the blocker-derived spacing event;
- no full current-Level-7 phase/recovery grammar;
- no second Door, third Plate, or mixed dependency stage.

## 6. Revised prospective quantitative bands

These are targets, not observed metrics:

| Measure | Revised bridge target |
|---|---:|
| `L*` | 13–16 |
| `N*` | 2–32, status must be `EXACT` |
| Visited states | 3,000–25,000 |
| Maximum frontier | 500–5,000 |
| Meaningful decisions | 2–3 |
| Recoverable alternatives | at least 2 |
| Dependency stages | exactly 1 |
| Spacing event | every shortest solution contains early `BLOCKED/MOVED` divergence |
| A+B window | required simultaneous E2/E4 result; useful window 1–2 turns |
| Door timing | open-result/next-input entry required |
| Owner-only target | 2–5 minutes, 1–3 restarts; target only, not fresh or independent |

The bridge must remain materially below current Level 7's `L*=19`, 61,975 visited states, frontier 21,449, six audited decisions, and longer phase-management loop. `N*` alone is not a difficulty ordering. A resource limit is never exact or complete-unsolved.

## 7. Mandatory future proof and control package

A later implementation task must provide:

1. strict schema load, catalog validation, sequence/prerequisite/final assertions, direct launch, normal unlock, and completion progression;
2. formal SHA-256, solve, witness replay, exact restart, `L*`, `N* EXACT`, visited states, maximum frontier, and all configured limits;
3. complete finite-state no-ECHO, E2-only, and E4-only controls, all unsolved without resource limits;
4. a YOU-substitution control/audit proving YOU cannot hold A or B and reach the Door during the one open snapshot;
5. all-shortest traces proving E2→A, E4→B, simultaneous A+B, and open-result/next-input crossing;
6. all-shortest traces proving the required early `BLOCKED/MOVED` spacing change;
7. isolate/relocate A and B separately; remove Door; replace A+B with A-only and B-only; record exact outcomes;
8. delay equalization at 2/2 and 4/4 plus a relevant blocker/Plate relocation control;
9. Door articulation and terrain route-bypass audits;
10. legal overlap and ECHO-on-EXIT controls; only YOU completes;
11. 2–3 meaningful-decision penalties and at least two recoverable alternatives;
12. exact preservation of all prior seven formal hashes/metrics, including byte-identical `two_echo_convergence`;
13. reusable Gameplay/AppRoot/direct-level/capture/960×540/grayscale/reduced-motion checks and aggregate regression;
14. comparison against current Level 7 showing lower measured search burden, fewer decisions, and simpler recovery;
15. no limit result labeled `EXACT` or complete-unsolved.

Stop if either single-ECHO control solves, YOU can substitute, all-shortest role mapping is not distinct, the spacing event is optional, or the measured burden approaches/exceeds current Level 7 without a clear curriculum advantage.

## 8. Future finale preservation

`signal_convergence` remains a future sequence-9 concept:

- two ECHOs, provisionally delays 2 and 4;
- three Plates;
- two visible Door stages;
- one single-Plate dependency;
- one two-Plate AND dependency;
- multi-zone dependency depth and recovery;
- one player-only EXIT.

The bridge uses A+B but only one Door, one dependency result, one early causal experiment, and a compact topology. The finale uniquely retains mixed single/AND dependencies, two sequential Door stages, three Plates, and multi-zone synthesis. The bridge may not acquire those features during authoring.

## 9. Presentation, Help, Timeline, and review policy

Selected relationship policy:

```text
LABEL_SHAPE_PIP_PRIMARY_NO_NEW_LINES
```

- board state and transition feedback are primary;
- Timeline is optional and never required;
- Help is contextual, zero-turn, and non-route;
- exact moves, walkthroughs, branch choices, or synchronization counts are rejected;
- A/B labels, distinct shapes, and Door pips are primary;
- color is supplementary, never sole;
- E2/E4 badges/outlines remain primary actor identities;
- no new always-on dotted relationship lines;
- any later path/cue change requires separate implementation and testing.

Future review classification:

```text
AUTHENTICATED_OWNER_NOT_FRESH_NOT_INDEPENDENT_BRIDGE_SEQUENCE_REVIEW
```

No third party may be sought or required. Ask:

1. What caused E2 and E4 spacing to change?
2. Which actor was blocked and which moved?
3. Why were both ECHOs needed for the A+B result?
4. Why could YOU not replace one ECHO on a Plate and still cross?
5. Could the concept be repeated after restart without recalling exact moves?
6. Were mistakes recoverable and was the cause visible?
7. Was difficulty caused by reasoning rather than clutter, Help, Timeline, or route length?
8. Did bridge then current Level 7 produce a smoother increase?
9. Did current Level 7 remain a larger synthesis rather than feel duplicated?

Record time, restarts, turns, Help/Timeline use, and assistance only when directly supplied.

## 10. Risks, stop conditions, rollback, and non-claims

### Principal risks

- the simplified A+B grammar may still feel too similar to current Level 7;
- compact geometry may permit YOU substitution or a reversed/unintended actor role;
- exact search may exceed bridge bands;
- the early divergence may be optional or visually lost;
- two Plate relationships may create clutter despite the no-new-lines policy;
- owner-only evidence cannot establish population difficulty.

### Stop conditions

Stop if the target requires a new mechanic, schema/runtime/solver change, actor-specific Plate rule, collision, persistent Door, Gate, push box, required Timeline, route-revealing Help, literal WAIT, accepted-level edit, non-exact necessity result, or multiple target ambiguity.

Return to planning if no compact layout proves both single-ECHO controls complete-unsolved while remaining materially below current Level 7. Do not fall back to the withdrawn one-Plate contract or the observational second ECHO.

### Current non-claims

Task 0017C proves the bridge exists, loads, solves, and meets the frozen machine bands. It does not claim fun/balance acceptance, GPT acceptance, owner acceptance, fresh or independent evidence, `signal_convergence` implementation, candidate readiness, export, release, or submission readiness.

## 11. Next gate

Task 0017C implementation and catalog migration are ready for GPT adjudication. The future finale remains closed.

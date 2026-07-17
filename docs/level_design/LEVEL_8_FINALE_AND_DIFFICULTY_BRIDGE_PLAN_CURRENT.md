# Level 8 finale and difficulty-bridge plan (CURRENT)

- Status: `PLANNING_READY_FOR_GPT_REVIEW`
- Task: `0016`
- Decision: `INSERT_BRIDGE_BEFORE_CURRENT_LEVEL_7`
- Exact next formal target: `echo_spacing_bridge / Diverging Echoes / 错位回声`
- Future finale: `signal_convergence`, preserved as a later sequence-9 concept
- Scope: planning and documentation only

## 1. Accepted baseline and evidence boundary

### Level 6

`staggered_doors` is GPT accepted at `INTERNAL_PLAYABLE`. It uses one delay-3 ECHO, two necessary Plates, and two unavoidable single-Plate Doors whose useful windows occur at different times. Machine evidence is `L*=15`, `N*=4 EXACT`, 6,772 visited states, and maximum frontier 1,179. The owner completed it unassisted at visible Turn 16 in approximately one minute with two restarts.

### Current Level 7

`two_echo_convergence` is GPT accepted at `INTERNAL_PLAYABLE`. It uses shared-spawn E2/E4, two Plates, and one A+B Door on a 9×7 board. Machine evidence is `L*=19`, `N*=6 EXACT`, 61,975 visited states, maximum frontier 21,449, and SHA-256:

```text
772410d3b8bb807e35472ee2a7d07b703de66e1e0e92ffb4d1ff8433a345d5fd
```

The formal file, ID, content, hash, and metrics remain frozen. Task 0015RV is assisted authenticated-owner evidence because the exact witness had already been exposed. It closes the fixed-spacing false-unsolvable blocker only for owner evidence; it is not fresh, independent, or route-discovery evidence.

Residual P2 inputs are:

1. the Level 6-to-7 difficulty discontinuity and missing intermediate teaching;
2. Help did not teach the spacing-manipulation causal model;
3. Timeline remained abstract and unused;
4. ECHO prediction and dependency dotted paths can overlap and create clutter.

The owner is the only available playtester. No third party may be sought or required.

### Frozen contracts

The plan stays within accepted `simulation_v1`, `level_v1`, catalog v1, and reusable Gameplay. It uses only rectangular floor/walls, accepted fixed-delay ECHOs reading one YOU history, accepted blocked-action history, Plates, combinational `all_plate_ids` Doors, legal overlap, player-only EXIT, and committed open-result/next-input Door behavior.

This plan does not authorize a formal level, catalog edit, coordinates, witness, solver run, source change, presentation implementation, or measured playability claim.

## 2. Candidate comparison

### Method

Each candidate is scored from 1 to 5. Weighted totals are planning judgments, not measured evidence.

| Criterion | Weight |
|---|---:|
| Curriculum continuity | 20% |
| Mechanical differentiation | 15% |
| Finale preservation | 15% |
| Observability | 15% |
| Proof feasibility | 15% |
| Production/presentation risk | 10% |
| Catalog/progression risk | 10% |

### Candidates

| Criterion | A — direct `signal_convergence` finale | B — linear bridge before current Level 7 | C — optional branching practice |
|---|---:|---:|---:|
| Curriculum continuity | 2.0 | 5.0 | 4.0 |
| Mechanical differentiation | 4.0 | 4.5 | 4.0 |
| Finale preservation | 3.0 | 5.0 | 4.0 |
| Observability | 3.0 | 4.5 | 4.0 |
| Proof feasibility | 3.5 | 4.5 | 4.0 |
| Production/presentation risk | 3.5 | 4.5 | 3.5 |
| Catalog/progression risk | 4.0 | 3.5 | 2.0 |
| **Weighted total** | **3.25 / 5** | **4.55 / 5** | **3.73 / 5** |

#### Candidate A — direct finale

Proceed directly to `signal_convergence`: two ECHOs, three Plates, and two visible Door stages. This preserves catalog simplicity and creates a differentiated synthesis room, but it escalates immediately after the owner found current Level 7's spacing model difficult to discover. Board feedback reduces false-invariant risk but does not itself supply the missing curriculum step. Direct escalation would therefore worsen the unresolved ramp unless the finale were simplified enough to consume its finale role.

#### Candidate B — linear bridge before current Level 7

Insert one mandatory schema-v1 room that isolates a single spacing-change cause before requiring two-ECHO A+B convergence. The room teaches one bounded causal step with one Plate and one Door, remains materially simpler than current Level 7, and preserves `signal_convergence` as a larger later synthesis. It requires a bounded sequence/prerequisite migration but no accepted formal-level edit.

#### Candidate C — optional branching practice

Add a practice level after Level 6 while retaining current Level 7 as a selectable challenge path. This offers player choice, but catalog v1 currently represents a strict ordered progression. Optional branching would create unclear unlock/final semantics and UX/test burden, and players who most need the lesson could skip it. Making the practice mandatory collapses this candidate into Candidate B.

### Decision and uncertainty

Selected:

```text
INSERT_BRIDGE_BEFORE_CURRENT_LEVEL_7
```

Candidate B has the strongest planning fit because it teaches the missing causal unit before synthesis while preserving accepted Level 7 and the future finale. The scores do not prove that a valid bridge layout exists or that the owner will experience the intended difficulty curve. A later implementation task must stop if exact machine evidence or owner evidence contradicts the plan.

## 3. Sequence and catalog migration

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
8. `two_echo_convergence` — prerequisite changes from `staggered_doors` to `echo_spacing_bridge`; remains the sole `final_level=true`

Only catalog sequence/prerequisite/final relationships may change in the later bridge implementation task. The accepted `two_echo_convergence` formal JSON remains byte-identical.

### Proposed future finale state

1–8 remain as above.

9. `signal_convergence` — prerequisite `two_echo_convergence`; becomes the sole `final_level=true`

At that later gate only, `two_echo_convergence` changes to `final_level=false`. No finale entry or formal file exists under this plan.

### Rollback

If the bridge cannot meet its proof/teaching requirements, remove only its later catalog entry and formal file, restore `two_echo_convergence` to sequence 7 with prerequisite `staggered_doors`, and restore it as the sole final. The accepted Level 7 formal file requires no rollback because it must never change.

## 4. Exact next formal implementation target

```text
level_id: echo_spacing_bridge
title: Diverging Echoes / 错位回声
role: mandatory sequence-7 curriculum bridge
```

### Frozen structural target

- one YOU;
- exactly two ECHOs, delays 2 and 4, sharing one spawn and the same YOU history;
- exactly one Plate;
- exactly one initially closed combinational Door;
- the Door dependency set is exactly the single Plate ID;
- exactly one player-only EXIT;
- board envelope at most 9×7, preferably 8×7;
- compact asymmetric fork-and-rejoin topology;
- one visible blocker pocket and one unavoidable Door articulation;
- no simultaneous A+B convergence and no second dependency stage.

Coordinates, walls, route, exact witness, and JSON are deliberately not frozen.

### Intended mental model

Cause one ECHO to be `BLOCKED` while the other `MOVED`, observe their relative spacing change, then exploit the resulting phase so an ECHO later holds the single Plate while YOU crosses the Door from the next open snapshot.

Both ECHOs must be individually necessary. If this cannot be proven within schema v1 and the quantitative bands below, stop rather than weakening the target into a one-ECHO or decorative-two-ECHO room.

### Meaningful-decision hypotheses

1. when to enter the blocker lane so different replay slots meet different terrain;
2. which delayed phase should later occupy the Plate;
3. when to commit to the Door crossing from an open start snapshot.

At least two decisions must not reduce to repeated wall collision, a long corridor, or literal waiting. The implementation may discover different defensible decision points, but it must audit at least three.

### Recovery expectations

- at least three recoverable non-optimal alternatives with bounded penalties or clear return routes;
- wrong timing should normally expose the cause in board state and transition outcomes rather than silently create a long dead run;
- restart remains exact, but restart must not be the only intelligible recovery;
- no exact walkthrough, Timeline reverse-counting, or prior Level 7 route knowledge may be required.

### Anti-padding, shortcuts, and observability

- no literal WAIT requirement or WAIT teaching target;
- no repeated-collision padding or long-corridor difficulty;
- no bypass around the Door articulation;
- no player-only, no-ECHO, or single-ECHO solution;
- no solution that ignores the post-activation spacing-change event;
- no line web needed to identify relationships;
- transition feedback may confirm `MOVED/BLOCKED/WAITED`, but geometry and actor state must carry the causal lesson;
- if the only workable room reproduces current Level 7's full A+B grammar, stop because the bridge has failed its differentiated role.

## 5. Prospective quantitative bands

These are implementation targets, not observed metrics:

| Measure | Prospective bridge target |
|---|---:|
| `L*` | 13–17 |
| `N*` | 2–24, status must be `EXACT` |
| Visited states | 2,000–30,000 |
| Maximum frontier | 300–6,000 |
| Meaningful decisions | 3–4 |
| Recoverable alternatives | at least 3 |
| Dependency stages | exactly 1 |
| Required spacing event | every shortest solution contains a post-activation spacing change; prefer `BLOCKED/MOVED` |
| Door timing | at least one open-result/next-input crossing |
| Owner-only target | 2–6 minutes, 1–4 restarts; target only, not fresh or independent |

The bridge must remain below current Level 7's reasoning burden. Resource-limit exhaustion is neither exact counting nor proof that a controlled variant is complete-unsolved.

## 6. Future finale role

`signal_convergence` is preserved as a future sequence-9 concept:

- two ECHOs, provisionally delays 2 and 4;
- three Plates;
- two visible Door stages;
- one Door with a single-Plate dependency;
- one Door with a two-Plate AND dependency;
- one player-only EXIT;
- compact multi-stage synthesis using only accepted mechanics.

The bridge reserves this two-stage/three-Plate synthesis for the finale. It must not introduce a second Door, three Plates, or the finale's mixed single/AND dependency grammar. Finale metrics and layout remain unmeasured and will require a separate planning/implementation gate after the bridge and shifted current Level 7 are accepted.

## 7. Mandatory future machine-proof package

A later bridge implementation task must provide:

1. strict schema load and catalog validation, exact sequence/prerequisite/final assertions, direct launch, normal unlock, and completion progression;
2. solve, witness replay, restart identity, formal SHA-256, `L*`, `N* EXACT`, visited states, maximum frontier, and declared finite search limits;
3. all-shortest or decisively bounded event traces proving every shortest solution contains the required post-activation spacing change and an open-result/next-input Door crossing;
4. no-ECHO, E2-only, and E4-only controlled variants, each exhausted over its complete finite state space and unsolved;
5. individual E2 and E4 necessity audits tied to the intended causal chain, not merely entity presence;
6. Plate removal/relocation/isolation and Door dependency simplification controls;
7. Door removal and route-articulation/bypass audits proving the Door lies on every YOU-to-EXIT route;
8. delay equalization controls at 2/2 and 4/4 plus a relevant spawn/terrain relocation control;
9. legal-overlap and ECHO-on-EXIT controls confirming only YOU satisfies the goal;
10. meaningful-decision penalties and at least three recoverable alternatives, excluding repeated collision, corridor padding, and literal WAIT;
11. exact preservation of the prior seven formal JSON hashes and recorded metrics, including byte-identical `two_echo_convergence`;
12. reusable Gameplay, AppRoot routing, direct-level launch, capture, 960×540 legibility, grayscale/reduced-motion where applicable, and aggregate regression;
13. no resource-limited result labeled `EXACT` or complete-unsolved.

If either ECHO necessity, the mandatory spacing event, or Door articulation cannot be proven, return `BLOCKED_NO_SCHEMA_V1_SEQUENCE_SOLUTION` rather than broadening mechanics or weakening the curriculum role.

## 8. Presentation, Help, Timeline, and path policy

Selected dependency-path policy:

```text
LABEL_SHAPE_PIP_PRIMARY_NO_NEW_LINES
```

Product rules:

- board state and transition feedback are primary;
- Timeline is optional status and never a required teaching dependency;
- Help is contextual, optional, zero-turn, and non-route;
- exact operation sequences, walkthroughs, branch choices, and synchronization counts are rejected for Help;
- supplementary color is allowed but is never the sole cue;
- labels, distinct shapes, and pips remain the primary Plate/Door relationship language;
- E2/E4 identity remains badge/outline based;
- no new always-on dotted relationship lines are added;
- existing prediction/dependency lines must not be allowed to scale into a cluttered web;
- any future line removal, contextualization, or cue change is a separately implemented and tested presentation change.

The bridge must remain understandable from the board and transition result even if Timeline is ignored and Help is never opened.

## 9. Owner-only review plan

The future classification is:

```text
AUTHENTICATED_OWNER_NOT_FRESH_NOT_INDEPENDENT_BRIDGE_SEQUENCE_REVIEW
```

Do not seek or require a third party. Prior project exposure must be disclosed. The review should ask:

1. Before any route is discussed, what caused the two ECHOs' relative spacing to change?
2. Which ECHO was blocked, which moved, and what board feature caused the difference?
3. Could the owner apply the idea after a restart or in the shifted current Level 7 without recalling an exact movement sequence?
4. When a timing choice failed, was the cause visible and was a recovery path understandable?
5. Did the bridge add reasoning, or was difficulty mainly visual clutter, Help wording, Timeline interpretation, or route length?
6. Did Help or Timeline become necessary? If used, did either reveal a route rather than explain context?
7. After bridge then current Level 7, did the Level 6-to-7 discontinuity materially decrease?
8. Did current Level 7 feel like a synthesis of the learned idea rather than repetitive replay?
9. For the later finale, did the two-stage chain feel like satisfying synthesis rather than more of the same?

Completion time, restarts, turns, Help/Timeline use, and assistance must be recorded only from supplied evidence, never inferred.

## 10. Risks, stop conditions, rollback, and non-claims

### Principal risks

- an 8×7 or 9×7 layout may fail to require both ECHOs without reproducing A+B convergence;
- exact controls may reveal a one-ECHO or Door bypass;
- low search size may indicate triviality, while a high frontier may exceed the bridge role;
- the board may communicate the mechanic only after assistance;
- catalog migration may regress unlock/final behavior;
- existing dotted cues may still create presentation friction even without new lines.

### Stop conditions

Stop if the target requires a new mechanic, schema/runtime/solver change, persistent Door, push box, Gate, exact Help route, required Timeline, literal WAIT, non-exact necessity result, accepted Level 7 file edit, or a vague/multiple sequence decision.

### Non-claims

This plan does not claim that:

- `echo_spacing_bridge` exists, loads, solves, is unique, is fun, or meets any metric;
- its candidate scores are empirical;
- owner evidence is fresh or independent;
- the current Level 7 formal file or catalog has changed;
- `signal_convergence` is implemented or accepted;
- Level 8/bridge implementation, production art/audio, Help redesign, Timeline redesign, push boxes, export, release, or submission is authorized.

## 11. Next gate

After GPT accepts this plan, the next gate is one bounded implementation task for `echo_spacing_bridge`, including the catalog migration and complete proof package above. It is not authorization to implement `signal_convergence`.

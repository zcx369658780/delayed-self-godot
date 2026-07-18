# Task 0017RC bridge contextual Help repair report

- Status: `BRIDGE_CONTEXTUAL_HELP_REPAIR_READY_FOR_GPT_REVIEW`
- Task: `tasks/0017RC_bridge_contextual_help_only_repair.md`
- Start/synchronized baseline: `d0b6ebbb1e46b640d9a46a341b29c8a58512734e`
- Root/branch/origin: `D:\Delayed_Self` / `main` / `git@github.com:zcx369658780/delayed-self-godot.git`
- Toolchain: Godot `4.7.stable.steam.5b4e0cb0f`
- Accepted bridge SHA-256: `805cdc05ea9b3805189ba7be4938cb7ede4e7056b9ae9a7e911df96a801d58ee`
- External evidence: `D:\Delayed_Self_Evidence\0017RC_bridge_contextual_help_repair\`

## Outcome

The accepted `echo_spacing_bridge` formal file remains byte-identical. Reusable Gameplay now adds one manual, zero-turn contextual Help section only when validated level facts identify the bridge curriculum shape. No geometry, formal metadata, catalog, schema, Simulation, solver, AppRoot, Level Select, Timeline model, scene, project setting, asset, persistence, export, or release surface changed.

The final section is:

```text
SPACING · Closed DOOR/wall BLOCKS one ECHO while another MOVES, changing spacing.
EXPERIMENT · Compare MOVED/BLOCKED; try another route or loop.
A+B · Two ECHOS hold separate Plates; YOU stays free to cross. Only YOU completes.
```

At 960×540 the contextual Help body uses 16 px, equal to the existing Help-close hint and above the current 14 px persistent-HUD minimum. Non-target Help remains 18 px. The final bridge body measures 283 px high inside the unchanged 320 px body area.

## Trigger contract and controls

`bridge_contextual_help_applicable(level_facts)` returns true only when all four data-derived conditions hold:

1. `metadata.intended_mechanics` contains `echo_spacing_change`;
2. at least two ECHOs are declared;
3. exactly two distinct Plate IDs occupy distinct cells;
4. at least one Door depends on both Plate IDs.

It does not inspect level ID, title, coordinates, turn, actor positions, history, witness progress, solver state, completion proximity, or route state.

| Control | Result |
|---|---|
| formal `echo_spacing_bridge` | true |
| byte-identical `two_echo_convergence` | false |
| zero-ECHO tutorial | false |
| single-ECHO tutorial | false |
| multi-ECHO without `echo_spacing_change` | false |
| one-Plate variant | false |
| duplicate Plate-cell variant | false |
| Door without both Plate dependencies | false |

## No-route and static-copy audit

The copy states only a reusable cause, a visible comparison experiment, the two-ECHO/separate-Plate role constraint, free-YOU crossing, and player-only completion. It contains no key sequence, cardinal route, coordinate, turn count, target spacing, required distance, next action, exact E2/A–E4/B mapping, branch/corridor recommendation, screenshot route, witness, solver output, remaining moves, recovery distance, or solvable/dead/correct/incorrect state label.

The same contextual substring is returned before play and after the real `E2 BLOCKED · E4 MOVED` transition. It does not open automatically, pulse, persist after closing, or vary with progress. `two_echo_convergence`, zero-ECHO, and single-ECHO captures contain no bridge section.

## Zero-turn and state proof

Focused tests snapshot and compare the full runtime state before and after Help open/close:

- turn index;
- canonical state key;
- player and ECHO positions;
- Door states;
- history;
- completion;
- disclosure;
- Timeline snapshot.

All remain exact. Existing `H`/toggle close behavior is retained. Task 0015R divergence feedback remains truthful and the contextual copy remains static after its real bridge event.

## Validation history

The first focused attempt failed two assertions because the test audited pre-existing Help/Timeline text as though it were new contextual copy. That harness error was corrected by isolating the final contextual section; no product relaxation followed.

The first native capture attempt stopped after the closed frame because the capture failure path did not quit. The retained second and third attempts identified actual 18 px vertical overflow: the original copy measured 432 px and the compact three-line copy measured 403 px inside 320 px. The harness was corrected to terminate on audit failure. The final bridge-only 16 px treatment measured 283 px and passed. These failed attempts are retained rather than overwritten.

Final focused result:

```text
TASK_0017RC_FOCUSED_PASS assertions=28
exit 0
stderr empty
```

Final aggregate:

```text
TASK_0003_TESTS_PASS assertions=578 vectors=9
TASK_0006_APP_SHELL_TESTS_PASS
TASK_0007_TUTORIAL_LEVELS_TESTS_PASS
TASK_0008_PROGRESSIVE_HUD_TESTS_PASS
TASK_0009AR_LEVELS_4_5_TESTS_PASS
TASK_0011_PRESENTATION_RECOVERY_TESTS_PASS
TASK_0011R_WINDOW_FILL_TESTS_PASS
TASK_0012_LEVEL_6_STAGGERED_DOORS_TESTS_PASS
TASK_0015_LEVEL_7_TWO_ECHO_CONVERGENCE_TESTS_PASS
TASK_0015R_ECHO_DIVERGENCE_FEEDBACK_TESTS_PASS
TASK_0017P_LEVEL_SELECT_SCROLLABILITY_TESTS_PASS
TASK_0017_ECHO_SPACING_BRIDGE_TESTS_PASS
TASK_0017RC_BRIDGE_CONTEXTUAL_HELP_REPAIR_TESTS_PASS
```

All thirteen markers appear exactly once. The process exits 0; stderr is exactly the intentional `LEVEL_ID_MISMATCH`. There is no failed assertion, parser/script/runtime error, or crash.

## Native capture review

The Compatibility harness reports:

```text
TASK_0017RC_VIEWPORT_CAPTURES_PASS captures=9
```

All nine images are exactly 960×540 and game-window-only:

1. bridge Help closed;
2. bridge Help open with the full contextual section;
3. bridge Help after a real `BLOCKED/MOVED` event;
4. `two_echo_convergence` Help without the section;
5. zero-ECHO Help without the section;
6. single-ECHO Help without the section;
7. grayscale bridge Help;
8. reduced-motion bridge decision Help;
9. Level Select bottom with sequence 8 reachable.

Manual review confirms no Help clipping or overflow, no route or exact assignment disclosure, readable grayscale/reduced-motion text, unchanged non-target Help, and sequence-8 reachability. With Help closed, A/B, E2/E4, Door, EXIT, goal, controls, and completion grammar remain present and readable.

## Formal and catalog preservation

The bridge remains:

```text
SHA-256 = 805cdc05ea9b3805189ba7be4938cb7ede4e7056b9ae9a7e911df96a801d58ee
L* = 16
N* = 12 EXACT
visited_states = 19059
maximum_frontier = 3734
```

The other seven formal SHA-256 values and accepted solver metrics remain exact. The catalog remains byte-identical at `a2bfa892f77370ac4d7e93ba5b6ce5970f0d7ba75160e1b2d00c4384f3da4e51`, with eight entries and `two_echo_convergence` as sequence 8 and sole final.

## Changed paths

Product/test paths:

- `scripts/gameplay/vertical_slice.gd`
- `tests/gameplay/task_0017rc_bridge_contextual_help_repair.gd`
- `tests/gameplay/capture_task_0017rc.gd`
- `tests/run_all.gd`

Documentation:

- this report;
- current startup, active-task, development-plan, document-index, handoff, project-memory, bridge-repair-plan, and presentation-direction documents.

No generated `.gd.uid` or `project.godot` cleanup was required. All Godot processes were closed before Git closeout.

## External evidence, rollback, and non-claims

Commands, failed and passing outputs, trigger/copy audits, size diagnostics, all captures, hashes, cleanup audit, and SHA-256 inventory are indexed by:

```text
D:\Delayed_Self_Evidence\0017RC_bridge_contextual_help_repair\EVIDENCE_INDEX.md
```

Rollback is one presentation topic: remove the predicate/contextual section and its bridge-only font override, remove the Task 0017RC focused/capture harnesses and aggregate registration, and restore the current documentation. Formal data requires no rollback.

This result does not close the curriculum P2, establish owner acceptance, fresh or independent evidence, human difficulty/fun acceptance, finale authority, candidate readiness, export, release, or submission readiness. One separately authorized owner-only repair retest remains required after GPT review.

```text
BRIDGE_CONTEXTUAL_HELP_REPAIR_READY_FOR_GPT_REVIEW
```

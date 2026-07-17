# Task 0015R Level 7 ECHO divergence feedback repair report

- Task: `tasks/0015R_level_7_transition_derived_divergence_feedback_repair.md`
- Start checkpoint: `HEAD == origin/main == 6a30403d6f7f456c1e2c7a580a886344da66569f`
- Branch/root: `main` / `D:\Delayed_Self`
- Origin: `https://github.com/zcx369658780/delayed-self-godot.git`
- Toolchain: Godot `4.7.stable.steam.5b4e0cb0f`, Compatibility renderer
- Selected bundle: `TRANSITION_DERIVED_ECHO_DIVERGENCE_FEEDBACK`
- Commit: the single commit containing this report, with required message `fix: expose Delayed Self echo spacing changes`
- Terminal verdict: `LEVEL_7_DIVERGENCE_FEEDBACK_REPAIR_READY_FOR_GPT_REVIEW`

## 1. Causal problem and repair boundary

The formal Level 7 was already machine-valid, but the opening lane reinforced an owner belief that E2/E4 physical spacing was fixed. Existing presentation showed actor identity and dependencies without exposing the later transition facts that invalidate that model.

This repair keeps every puzzle authority frozen. It adds one reusable presentation record and draw treatment that says when relative spacing changed and reports each ECHO's actual returned outcome. It does not reveal a route, desired distance, coordinates, Plate assignment, remaining moves, next action, witness, or solver state.

No formal level, catalog, schema, Simulation, solver, scene, project setting, Timeline, Help, asset, persistence, build, export, release, or Level 8 surface changed.

## 2. Returned transition facts consumed

Reusable Gameplay already calls:

```gdscript
_update_visual_feedback(before, result, action)
```

Task 0015R consumes only:

- `before.echo_positions`;
- `result.state.echo_positions`;
- `result.state.completed`;
- `result.actor_actions.echoes`, including stable ECHO ID and actual replay action;
- existing ECHO definitions for delay badge and outline identity.

The presentation does not call Simulation again, inspect terrain, reconstruct collision legality, inspect Door/Plate rules, or compare against a Level 7 target state. A cardinal action with unchanged position is `BLOCKED`; a cardinal action with changed position is `MOVED`; `WAIT` is always `WAITED`.

## 3. Feedback state and contract

`visual_feedback.echo_divergence` and `get_presentation_snapshot()` now expose:

- `visible`, `headline`, `detail`, and `visual_state`;
- actor records ordered by delay then ID;
- stable ID, badge, replay action, before/after position, outcome, outline style, and marker rectangle;
- ordered pair IDs;
- signed relative vector before/after;
- Manhattan spacing before/after;
- whether spacing changed;
- the fixed presentation-only badge rectangle.

Applicability and trigger:

1. zero/single-ECHO levels return the hidden empty state;
2. multi-ECHO transitions record actor outcomes and pair facts;
3. only a signed-vector or Manhattan-spacing change shows `ECHO SPACING CHANGED`;
4. stable spacing keeps the cue hidden even when ECHOs move or converge on A+B;
5. the accepted blocked/moved state truthfully shows `E2 BLOCKED · E4 MOVED`;
6. every new submitted turn resets the prior cue before deriving the new transition;
7. restart, load, direct-route initialization, and completion clear all divergence state.

There is no branch on `configured_level_id == "two_echo_convergence"`, no formal coordinate, and no turn-number check.

## 4. Presentation, reduced motion, and grayscale

The compact cue uses the existing 20-pixel gap between the goal strip and board:

```text
Rect2(24, 66, 540, 18)
```

It is outside the board and does not intersect visible HUD surfaces. Text is static and factual. Hollow endpoint rings are drawn before actors, so ECHO bodies and existing badges/outlines remain on top. Shape grammar remains non-color-dependent:

- `MOVED`: endpoint ring plus arrow notch;
- `BLOCKED`: endpoint ring plus X;
- `WAITED`: endpoint ring plus pause bars;
- E2: solid ring;
- E4: dashed ring.

Reduced-motion mode records `STATIC_OUTCOME_CUE` and retains the same text/outcome shapes. The grayscale decision capture preserves `ECHO SPACING CHANGED`, `E2 BLOCKED · E4 MOVED`, solid/dashed ECHO identity, MOVED/BLOCKED symbols, A/B, A+B, Door, EXIT, and YOU.

## 5. TDD and focused validation

The tracer RED failed exactly because the presentation snapshot had no `echo_divergence` field:

```text
TEST_FAIL: single-ECHO initial presentation exposes deterministic hidden divergence feedback
TASK_0003_TESTS_FAIL failures=1 assertions=368
```

The minimal hidden default state produced GREEN at 368 assertions. The complete transition test then ran RED against missing outcome/spacing fields. After the bounded implementation, the focused suite passed inside the aggregate:

```text
TASK_0015R_ECHO_DIVERGENCE_FEEDBACK_TESTS_PASS
```

Final aggregate count is 391 assertions / 9 vectors, so Task 0015R adds 24 focused assertions without removing any accepted assertion.

Focused coverage includes:

1. zero/single-ECHO no-cue behavior;
2. stable vector and Manhattan no-trigger;
3. E2 MOVED / E4 WAITED startup activation;
4. different replay actions and signed-vector change;
5. overlap collapse;
6. overlap-to-separation growth;
7. cardinal BLOCKED versus MOVED;
8. WAITED distinct from BLOCKED;
9. truthful blocked/moved compact copy;
10. stable A+B convergence no-trigger;
11. restart clear;
12. direct Gameplay and AppRoot direct-level initialization;
13. completion clear;
14. deterministic actor/pair presentation snapshots;
15. no canonical state/key mutation by snapshot feedback.

## 6. Native capture and overlap audit

The native Compatibility capture harness exited 0 with:

```text
TASK_0015R_VIEWPORT_CAPTURES_PASS snapshots=10
```

| Capture | Expected result |
|---|---|
| `01_no_cue_control.png` | initial hidden state |
| `02_stable_two_cell_spacing.png` | stable `(2,0)` spacing, no cue |
| `03_signed_vector_change.png` | different replay actions, cue visible |
| `04_overlap_spacing_collapse.png` | Manhattan spacing collapses to zero |
| `05_e2_blocked_e4_moved.png` | truthful blocked/moved causal line |
| `06_subsequent_spacing_expansion.png` | spacing grows from 1 to 3 |
| `07_a_plus_b_stable_convergence.png` | A+B remains legible; no false new cue |
| `08_restart_cleared.png` | no stale feedback |
| `09_reduced_motion_blocked_moved.png` | full static causal meaning |
| `10_grayscale_decision_frame.png` | non-color identity and outcome proof |

Every capture is exactly 960×540 and game-window-only. Snapshot rectangle checks prove the cue badge stays outside the board and avoids every actually visible HUD surface. Manual inspection of stable, overlap, blocked/moved, reduced-motion, and grayscale frames confirmed that the cue does not obscure YOU, ECHOs, Plates, Door, EXIT, dependencies, goal, controls, or completion. Endpoint rings are semantic actor-connected outlines drawn beneath the actors, not opaque overlays.

The first capture audit stopped after three frames because the harness treated child labels of the closed Help card as visible. Those artifacts were retained. The corrected harness checks the parent Help state, exits immediately on audit failure, and wrote the successful pass into a new subdirectory without overwriting the first evidence.

## 7. Formal preservation

| Formal level | SHA-256 before and after |
|---|---|
| `tutorial_reach_exit` | `38e466bb5922f1987a99d79c7527a4a8eab8e6cfdbe76fd8159f80b0a40cf2c4` |
| `tutorial_echo_bridge` | `681d99057c4e6034a490644d75960ff23d8f43bd1b91850f48179b79fc04a3cf` |
| `vertical_slice_delay_3` | `8751da5051fbebaaa5ae7c895d9be9f086e8d8f2e87876a80c379dc06262f1d8` |
| `door_one_turn_late` | `1775cf89ae4a94f65a76dac2b791a31395443de88205d0ed1b6233331dbda577` |
| `two_keys_one_door` | `f4c6791dfc84d17fb450721e654091a2baeb522e55d660a5d73878cd977651cd` |
| `staggered_doors` | `3f14c19b50775e36dd5b52664798381cf1292b0a30b377641c03435f45696bc8` |
| `two_echo_convergence` | `772410d3b8bb807e35472ee2a7d07b703de66e1e0e92ffb4d1ff8433a345d5fd` |

Level 7 remained exact:

```text
L* = 19
N* = 6 EXACT
visited_states = 61975
maximum_frontier = 21449
```

## 8. Complete aggregate

The final fresh native process exited 0. Stdout contained every marker exactly once:

```text
TASK_0003_TESTS_PASS assertions=391 vectors=9
TASK_0006_APP_SHELL_TESTS_PASS
TASK_0007_TUTORIAL_LEVELS_TESTS_PASS
TASK_0008_PROGRESSIVE_HUD_TESTS_PASS
TASK_0009AR_LEVELS_4_5_TESTS_PASS
TASK_0011_PRESENTATION_RECOVERY_TESTS_PASS
TASK_0011R_WINDOW_FILL_TESTS_PASS
TASK_0012_LEVEL_6_STAGGERED_DOORS_TESTS_PASS
TASK_0015_LEVEL_7_TWO_ECHO_CONVERGENCE_TESTS_PASS
TASK_0015R_ECHO_DIVERGENCE_FEEDBACK_TESTS_PASS
```

Stderr is exactly the accepted intentional negative-path line:

```text
LEVEL_ID_MISMATCH
```

There were no failed assertions, parser/script/runtime errors, or crashes.

## 9. Exact repository paths

Product/test paths:

- `scripts/gameplay/vertical_slice.gd`
- `tests/gameplay/task_0015r_echo_divergence_feedback.gd`
- `tests/gameplay/capture_task_0015r.gd`
- `tests/run_all.gd`

Documentation:

- `docs/reports/0015R_LEVEL_7_ECHO_DIVERGENCE_FEEDBACK_REPAIR_REPORT.md`
- `docs/CODEX_ACTIVE_TASK_CURRENT.md`
- `docs/CODEX_STARTUP_SNAPSHOT_CURRENT.md`
- `docs/DEVELOPMENT_PLAN_CURRENT.md`
- `docs/DOC_INDEX_CURRENT.md`
- `docs/HANDOFF_MASTER_CURRENT.md`
- `docs/project_memory.md`
- `docs/level_design/INITIAL_LEVEL_ROADMAP_AND_VALIDATION_MATRIX_CURRENT.md`
- `docs/level_design/FIVE_LEVEL_DIFFICULTY_RECOVERY_AND_LEVELS_6_8_PLAN.md`
- `docs/level_design/LEVEL_7_FALSE_UNSOLVABLE_REPAIR_PLAN_CURRENT.md`
- `docs/ux/PRESENTATION_VIEWPORT_AND_HUD_DIRECTION_CURRENT.md`

## 10. External evidence

Root:

```text
D:\Delayed_Self_Evidence\0015R_echo_divergence_feedback_repair\
```

The root contains separated RED/GREEN/final aggregate stdout/stderr, native capture logs, ten successful game-window PNGs, presentation snapshots, retained first-attempt evidence, and `EVIDENCE_INDEX.md` with timestamps, sizes, and SHA-256. No external file enters Git.

## 11. Rollback and protected surfaces

Rollback is one presentation topic: remove the `echo_divergence` state/drawing from reusable Gameplay, remove the two Task 0015R harnesses and aggregate registration, and restore the current documents. Do not compensate by changing formal levels, Simulation, solver, schema, catalog, scene, Timeline, or Help.

Stop and roll back if later review finds a false trigger, outcome misclassification, route-specific inference, unreadable grayscale/reduced-motion state, or material overlap. Formal hashes and metrics are the immutable rollback comparison.

## 12. Non-claims and next recommendation

This repair is machine- and capture-validated, but it does not close the owner blocking P2 by itself. It is not owner acceptance, fresh/independent evidence, candidate/balance/fun proof, final presentation, Level 8 authorization, or release readiness.

Recommendation: GPT review this bounded implementation. If accepted, authorize one:

```text
AUTHENTICATED_OWNER_NOT_FRESH_NOT_INDEPENDENT_LEVEL_7_RETEST
```

Level 8 remains blocked until that retest closes or materially reduces the false-unsolvable P2.

```text
LEVEL_7_DIVERGENCE_FEEDBACK_REPAIR_READY_FOR_GPT_REVIEW
```

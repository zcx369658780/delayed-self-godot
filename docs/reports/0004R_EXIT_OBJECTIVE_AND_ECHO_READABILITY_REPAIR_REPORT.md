# Task 0004R exit, objective, role-causality, and echo-readability repair report

- Verdict: `PASS_FOR_GPT_REVIEW`
- Task: `tasks/0004R_fix_exit_objective_and_echo_readability.md`
- Branch: `main`
- Start HEAD / start `origin/main`: `601e3ccd902c2dbb7a4b45e2f69b2d4df96151c2`
- Final HEAD / final `origin/main`: `SELF` — the single commit containing this report; resolve from `main` after the authorized push
- Accepted runtime base: `14180dc3e110607d4abdee5f8bf314a58f62fb39`
- Godot: `4.7.stable.steam.5b4e0cb0f`, Compatibility renderer

## Changed files and responsibilities

- `scripts/gameplay/vertical_slice.gd`: explicit objective/legend/next-action HUD, Y/E actor markers, persistent diamond EXIT, completion overlay, and testable read-only HUD snapshot.
- `scenes/vertical_slice/vertical_slice.tscn`: objective, entity legend, Echo Next, and completion label hierarchy within 960×540.
- `scripts/simulation/simulation.gd`: one pure `echo_action_for_state` query; the existing transition and HUD both use it, so history indexing is not duplicated.
- `tests/run_all.gd`: focused public HUD, next-action/history, restart, completion, and scene assertions.
- `docs/reviews/0004_FIRST_PLAYER_UX_AND_VISUAL_READABILITY_REVIEW.md`: materialized direct user evidence with unavailable answers/ratings marked `NOT_PROVIDED`.
- `docs/reports/0004R_EXIT_OBJECTIVE_AND_ECHO_READABILITY_REPAIR_REPORT.md`: implementation, validation, evidence, boundaries, and next-gate record.
- `docs/CODEX_STARTUP_SNAPSHOT_CURRENT.md`: current Task 0004R gate and required Task 0004V follow-up.
- `docs/CODEX_ACTIVE_TASK_CURRENT.md`: completed-pending-review task state, authorization, and remaining uncertainty.
- `docs/DOC_INDEX_CURRENT.md`: Task 0003 acceptance, Task 0004 evidence/review, and Task 0004R report links.
- `docs/DEVELOPMENT_PLAN_CURRENT.md`: Task 0004 evidence, 0004R repair, and 0004V retest milestone sequence.
- `docs/HANDOFF_MASTER_CURRENT.md`: continuation boundary through GPT review and explicit Task 0004V.
- `docs/project_memory.md`: durable accepted-gate, evidence-finding, repair-boundary, and retest decisions.

No level, schema, fixture, loader, BFS solver, project setting, input mapping, renderer, viewport, plugin, dependency, asset, export, save, build, or protected release surface changed.

## Finding-to-repair mapping

| Finding | Repair |
|---|---|
| P1-1 victory condition undiscoverable | Persistent three-line goal states that YOU enters EXIT, ECHO cannot finish, and ECHO holds PLATE so YOU crosses DOOR; completion names `YOU reached EXIT`. |
| P1-2 EXIT/ECHO confusion and occlusion | EXIT is a blue diamond/target frame with persistent outer overlay and `EXIT` label redrawn after actors; Y/E letters preserve occupant identity. |
| P1-3 causal roles inverted | Objective and entity legend explicitly name YOU, ECHO, PLATE, DOOR, and EXIT and state their intended roles without a movement sequence. |
| P2-1 no explicit next echo action | Separate purple `Echo next: <ACTION>` display derives from the same pure history-index query used by transition; full oldest-to-newest history remains visible. |
| P2-2 incomplete subgoal copy | Normal objective includes the terminal and player-only goal; completion adds a prominent centered overlay and restart instruction. |

## Automated validation

Baseline before edits:

- exit code 0;
- `TASK_0003_TESTS_PASS assertions=128 vectors=9`;
- solver `SOLVED`, `L*=9`, `N*=31 (EXACT)`, 1,318 visited, maximum frontier 393;
- echo-isolated variant `UNSOLVABLE_WITHIN_COMPLETE_FINITE_STATE`, 1,006 visited.

Final after edits:

- exit code 0;
- `TASK_0003_TESTS_PASS assertions=135 vectors=9`;
- all 9/9 normative vectors and exact canonical keys remain passing;
- solver and mechanic-necessity summaries are unchanged;
- focused assertions cover five entity meanings, player-only objective, role causality, explicit initial/changed next echo action, restart reset, completion copy, and scene instantiation.

TDD evidence recorded the expected RED then GREEN sequence for HUD snapshot, entity legend, objective causality, explicit next action, and completion feedback.

## Visual evidence

External directory: `D:\Delayed_Self_Evidence\0004R_ux_repair\`; screenshots/logs are not staged.

| Accepted file | Purpose | SHA-256 |
|---|---|---|
| `accepted_initial.png` | Initial 960×540 objective, legend, next action, history, and controls | `85b69265db794f1ac04cca626222c76d9b19dbb99763319dcd430fe7728eb6b6` |
| `accepted_echo_exit.png` | ECHO occupying EXIT while diamond frame and label remain visible | `cb94ec5535bb25340d314a6b90960472324a1c36d339936d63928d7be75a1c84` |
| `accepted_completed.png` | YOU on EXIT with prominent completion/restart feedback | `68cbc4e211504f839de7602de21777d07bbb3df2c6aa99af9836023735444788` |
| `accepted_conformance_tests.log` | Final 135-assertion/9-vector regression | `6fb13af135c293a5c2b089a7540ed321ecb28ca7c4efa4b652c16558465e7d1c` |
| `accepted_window_launch.log` | Bounded 60-frame main-scene launch, exit 0 | `d5c82f78c6da81ed798f1d4f68f1544f2e0a809b9ee4d496878833e12d9b29aa` |
| `evidence_index.txt` | Commands, timestamps, privacy boundary, hashes, and visual inspection | `85bb34dfe3938ffe79daab00a0ceeb0bd393d34f905fffdffacd61daf298aeae` |

The screenshots were generated from the Godot root viewport only at 960×540. No desktop, browser, notification, credential, or unrelated window was captured. Visual inspection confirmed no text clipping in accepted states, persistent EXIT identity under ECHO occupancy, and non-overlapping completion feedback.

## Boundaries and next gate

This implementation closes the specified presentation defects in code and automated/visual evidence. It does not establish that a first player now understands them. It does not claim final art, accessibility compliance, independent visual acceptance, performance, export, release, or submission readiness.

Required next gate: `Task 0004V — targeted first-player victory-condition and entity-readability retest`.

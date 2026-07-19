# Task 0021 — Implement the eight-level final acknowledgment and bounded return flow

- Status: `READY`
- Gate: `FINALE PRESENTATION IMPLEMENTATION / HEADLESS MACHINE REGRESSION`
- Repository/root/branch: `zcx369658780/delayed-self-godot` / `D:\Delayed_Self` / `main`
- Accepted plan: `docs/production/EIGHT_LEVEL_FINALE_CLOSURE_AND_PRODUCTION_PLAN_CURRENT.md`
- GPT acceptance: `docs/reports/0020_GPT_EIGHT_LEVEL_FINALE_CLOSURE_PLAN_ACCEPTANCE.md`
- Acceptance commit: `f3896820fef72a80f05494530fa8fa63d6eac45b`
- Selected direction: `B — FINAL_COMPLETION_OVERLAY_PLUS_BOUNDED_RETURN_STATE`
- Formal scope: exactly eight levels; sequence 8 remains sole final

## 1. Objective

Implement one bounded finale-presentation seam for the existing catalog-marked final level.

Ordinary Simulation completion remains unchanged. Non-final levels must continue to record completion and automatically return to Level Select. The final level must record completion exactly once, remain on the existing Gameplay screen in a deterministic acknowledgment state, and expose clear return/replay controls.

This task ends at implementation plus focused/aggregate headless validation and GPT review. Native capture acceptance is a separate Gate 2. It does not conduct owner review, persistence/menu/localization work, build/export, RC, release, or festival packaging.

## 2. Startup gate

Before any write or Godot run, verify:

- root exactly `D:\Delayed_Self`;
- branch `main` and expected SSH origin;
- clean tracked and untracked worktree;
- `HEAD == origin/main` and contains `f3896820fef72a80f05494530fa8fa63d6eac45b`;
- accepted Godot `4.7.stable.steam.5b4e0cb0f` or exact documented equivalent;
- no residual Godot process.

If clean local `main` is behind, use only `git fetch origin` and `git merge --ff-only origin/main`. Stop on divergence, conflict, unexpected files, wrong root/remote, or materially different toolchain.

Read in order:

1. `AGENTS.md`;
2. current startup and active-task documents;
3. this task;
4. Task 0020 plan/report and GPT acceptance;
5. Task 0019B scope adjudication;
6. current AppRoot, Gameplay, memory progress, route, catalog, Level Select, Help, Timeline, presentation, test, and generated-file safety contracts;
7. all eight formal level files, catalog, focused tests, and aggregate registration.

Before editing, print a concise implementation/test/rollback plan. Intermediate progress updates are not terminal results; continue until a terminal verdict below unless an explicit blocker is reached.

## 3. Frozen authorities and forbidden scope

Treat as immutable:

- all eight formal level JSON files, hashes, and accepted metrics;
- the eight-entry catalog, ordering, prerequisites, and sequence-8 sole-final flag;
- `simulation_v1`, `level_v1`, solver, canonical state, history, restart, completion condition, and player-only EXIT;
- accepted bridge contextual Help and divergence feedback;
- Timeline behavior and optional status;
- Level Select scrolling/focus and Safe Error behavior;
- sequence 9/B007/candidate A/B/C closure.

Do not modify:

```text
project.godot
schemas/
scripts/simulation/
scripts/solver/
data/catalog/
data/levels/
scripts/app/memory_progress.gd
scripts/app/catalog_loader.gd
scripts/app/route_request.gd
scripts/app/level_select.gd
scenes/
```

Do not add a new scene, ending subsystem, cutscene, branching narrative, save field, persistent ending flag, account/network feature, asset/audio dependency, animation-only meaning, catalog field, level metadata, hard-coded `two_echo_convergence` check, localization exception, credits flow, build/export setting, or new gameplay action.

If the selected direction requires a scene edit, new focus architecture, persistence coupling, catalog/schema change, or hard-coded final identity, stop with `BLOCKED_FINALE_PRESENTATION_ARCHITECTURE`.

## 4. Authorized product paths

Modify only as necessary:

```text
scripts/app/app_root.gd
scripts/gameplay/vertical_slice.gd
tests/app/task_0021_eight_level_finale_presentation.gd
tests/run_all.gd
docs/reports/0021_EIGHT_LEVEL_FINALE_PRESENTATION_IMPLEMENTATION_REPORT.md
```

Minimum CURRENT planning/index/handoff/project-memory Markdown may also be updated. Do not modify any other product, test, scene, task, prior report, asset, persistence, build, export, release, or submission path.

## 5. Stable trigger and completion-recording contract

Use only:

```text
validated route_payload.final_level == true
AND ordinary Simulation completion transitioned false -> true
```

`final_level` must remain catalog-derived through AppRoot's validated entry payload. Do not inspect level ID, title, sequence number, path text, coordinates, actor state beyond ordinary completion, witness progress, best-turn count, or new metadata to identify the finale.

AppRoot must guard completion handling per active Gameplay instance/session so that:

1. the progress interface receives at most one successful completion-recording attempt for that active Gameplay session;
2. repeated completion signals or replay/recompletion cannot double-record or double-route;
3. a newly routed Gameplay instance resets the guard;
4. non-final completion records once and preserves current automatic Level Select return;
5. final completion records once and does not immediately replace Gameplay.

Do not modify the progress adapter contract in this task.

## 6. Deterministic final acknowledgment state

Implement one bounded presentation state, represented by a clear internal fact such as:

```text
FINAL_ACKNOWLEDGEMENT_VISIBLE
```

It may be derived from `state.completed`, `hosted_by_app`, and validated `route_payload.final_level`; it must not mutate the canonical Simulation state.

When visible:

- keep the completed board and existing Gameplay screen;
- hide or disable Help and Timeline interaction;
- block movement/WAIT from entering Simulation;
- show the final acknowledgment through the existing completion label/surface;
- make the return/replay actions explicit;
- retain deterministic grayscale/reduced-motion/static meaning without requiring animation or audio.

Use this provisional copy unless a smaller wording is necessary for the existing surface:

```text
THE SIGNAL ARRIVED LATE.
IT WAS HEARD.

Enter / Space: Level Select
R: Replay
```

Exact requirements:

- `Enter`/`ui_accept` and `Space`/the existing WAIT input acknowledge and request return to Level Select;
- `Esc` remains a return path;
- `R` restarts/replays the same final level and clears the visible acknowledgment because the ordinary initial state is restored;
- acknowledgment/return emission is guarded so repeated input cannot emit multiple route requests;
- `H`, movement, and other gameplay input do nothing while the acknowledgment is visible;
- no new action mapping or project setting is added.

The copy is provisional implementation text, not localized or final production copy.

## 7. AppRoot routing behavior

Preserve existing route architecture.

For non-final completion:

```text
record once -> navigate LEVEL_SELECT
```

For final completion:

```text
record once -> remain ROUTE_GAMEPLAY -> show acknowledgment
```

The acknowledgment return must use the existing routed Level Select path, preferably the existing `request_back` seam or an equally bounded existing-screen signal. Do not add a new application route.

Development-direct launch must still receive the catalog-derived `final_level` fact. A direct route may lack prerequisite-complete progress; tests must distinguish presentation correctness from normal unlocked-flow completion recording and must not weaken the progress contract.

## 8. Focused test requirements

Create one focused test file and cover at minimum:

1. the eight-entry catalog and all formal hashes remain exact;
2. route payload carries catalog-derived `final_level` for sequence 8 and false for a non-final control;
3. no hard-coded final level identity exists in the new implementation path;
4. non-final completion records and automatically returns to Level Select exactly as before;
5. normal unlocked final completion records once and remains in Gameplay;
6. final acknowledgment is absent before completion and visible after completion;
7. final text includes the acknowledgment plus explicit return/replay controls;
8. canonical completed state/key, positions, Door states, history, completion, and turn remain unchanged while the acknowledgment is visible;
9. `H`, movement, and WAIT-as-gameplay do not mutate state during acknowledgment;
10. `Enter`/`Space` acknowledgment requests Level Select once;
11. `Esc` returns once;
12. `R` restores the exact initial state and permits replay without a second progress record for the same active Gameplay session;
13. repeated completion callback/input cannot double-record or double-route;
14. direct-development final route uses the final presentation branch without hard-coded identity;
15. Help predicate/copy and Timeline behavior remain unchanged outside the final acknowledgment;
16. Safe Error, reset test profile, Level Select scroll/focus, resize/window presentation, and existing completion routes remain passing.

Add exactly one stable marker:

```text
TASK_0021_EIGHT_LEVEL_FINALE_PRESENTATION_TESTS_PASS
```

## 9. Aggregate regression

Update `tests/run_all.gd` minimally.

Final aggregate must:

- exit 0;
- report assertions strictly greater than 578;
- report vectors exactly 9;
- include all prior thirteen stable markers exactly once;
- include the new Task 0021 marker exactly once;
- preserve all eight formal hashes/metrics and the catalog hash;
- emit only the intentional `LEVEL_ID_MISMATCH` on stderr;
- contain no parser, script, runtime, assertion, route, or cleanup error.

Gate 1 does not require native screenshot capture. Do not create or claim Gate-2 capture acceptance in this task.

## 10. Evidence and report

Use external evidence root:

```text
D:\Delayed_Self_Evidence\0021_eight_level_finale_presentation\
```

Record commands, focused/aggregate stdout/stderr, exits, hash inventory, route/progress snapshots, state/input audit, cleanup audit, and an evidence index. Do not stage external evidence.

Create:

```text
docs/reports/0021_EIGHT_LEVEL_FINALE_PRESENTATION_IMPLEMENTATION_REPORT.md
```

The report must record changed paths, exact acknowledgment copy/state, final/non-final routing evidence, record-once evidence, replay/return behavior, focused/aggregate results, hashes, cleanup, rollback, and non-claims.

## 11. Cleanup, Git, and rollback

After Godot runs, close every Godot process.

Narrow generated cleanup is authorized only when `project.godot` is the sole unintended unstaged tracked change and every untracked path is a regular repository-local `.gd.uid`. Restore only literal worktree `project.godot` and delete only the frozen Git-enumerated UID paths one by one. Stop on any differing set. Never use broad clean/restore, reset, stash, rebase, amend, or force-push.

Require one implementation commit:

```text
feat: add Delayed Self final acknowledgment flow
```

Stage explicit authorized paths only. Push normally and require a clean worktree, `HEAD == origin/main`, divergence `0/0`, and no residual Godot process.

Rollback is the single finale-presentation topic: AppRoot completion branching, Gameplay acknowledgment/input behavior, Task 0021 test/registration, implementation report, and minimum current docs. Formal data/catalog require no rollback.

## 12. Stop conditions

Stop and return to GPT if:

- a new scene/focus subsystem is required;
- final identity must be hard-coded;
- progress cannot be recorded once without changing its contract;
- canonical state or Simulation completion must change;
- non-final automatic return regresses;
- acknowledgment input can double-route or trap the app;
- Help/Timeline/persistence/catalog/formal data must change;
- aggregate/hash/marker requirements cannot pass within the authorized paths.

## 13. Terminal verdict

Return exactly one:

```text
EIGHT_LEVEL_FINALE_PRESENTATION_READY_FOR_GPT_REVIEW
BLOCKED_FINALE_PRESENTATION_ARCHITECTURE
BLOCKED_FINALE_PRESENTATION_REGRESSION
```

Include commit SHA when produced, changed paths, exact copy/state, final/non-final route evidence, record-once/replay/return behavior, focused and aggregate results, evidence root, cleanup, and final Git state.

This task does not establish native capture acceptance, owner acceptance, complete-flow/production readiness, persistence/settings/menu/localization readiness, build/export readiness, RC acceptance, release, upload, or festival submission readiness.

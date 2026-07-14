# Task 0004R — Exit, objective, role-causality, and echo-readability repair

- Status: `READY`
- Gate: `UX REPAIR / FIRST-PLAYER P1 CLOSURE`
- Repository: `zcx369658780/delayed-self-godot`
- Expected branch: `main`
- Expected local root: `D:\Delayed_Self`
- Issued by: GPT Project Sources advisor
- Date: 2026-07-14
- Accepted runtime base: `14180dc3e110607d4abdee5f8bf314a58f62fb39`
- Task 0003 acceptance: `docs/reports/0003_GPT_FINAL_ACCEPTANCE.md`
- First-player evidence: `docs/reviews/0004_GPT_FIRST_PLAYER_EVIDENCE_ADJUDICATION.md`
- Required follow-up after implementation: user retest; this task cannot self-accept first-player comprehension

## 1. Objective

Repair the current vertical-slice presentation so a first player can understand, without solver disclosure, that:

1. the white/cyan actor is `YOU` and is the only actor that can complete the level;
2. the purple actor is the delayed `ECHO` and repeats recorded actions three turns later;
3. the yellow pressure plate must be held by the echo so `YOU` can cross the door;
4. the blue exit is a distinct destination rather than another actor;
5. the next echo action can be identified directly from the HUD;
6. reaching the exit with `YOU` produces unmistakable completion feedback.

This is a presentation/UX repair. Preserve the accepted simulation, schema, level topology, shortest-path result, and echo-necessity semantics.

## 2. Mandatory startup gate

Before any write:

```powershell
Get-Location
git branch --show-current
git rev-parse HEAD
git rev-parse origin/main
git remote -v
git status --short --untracked-files=all
git log -10 --oneline --decorate
```

Required conditions:

- root is exactly `D:\Delayed_Self`;
- branch is `main`;
- origin is the expected repository;
- local `HEAD` and `origin/main` contain this task, the Task 0003 acceptance, and the Task 0004 evidence adjudication;
- tracked worktree is clean;
- the accepted Godot `4.7.stable` standard executable is available.

If local is behind and clean, use only:

```powershell
git fetch origin
git merge --ff-only origin/main
```

Stop on divergence, conflict, remote mismatch, unexpected tracked changes, unsafe root, missing task/evidence, or materially different Godot/toolchain.

## 3. Required reads

Read in this order:

1. `AGENTS.md`
2. `docs/CODEX_STARTUP_SNAPSHOT_CURRENT.md`
3. `docs/CODEX_ACTIVE_TASK_CURRENT.md`
4. this task
5. `docs/reviews/0004_GPT_FIRST_PLAYER_EVIDENCE_ADJUDICATION.md`
6. `docs/reports/0003_GPT_FINAL_ACCEPTANCE.md`
7. `docs/reports/0003_MINIMAL_GODOT_VERTICAL_SLICE_AND_CONTRACT_CONFORMANCE_REPORT.md`
8. `docs/game_design/GAMEPLAY_SIMULATION_CONTRACT_CURRENT.md`
9. `docs/level_design/LEVEL_SCHEMA_V1_CURRENT.md`
10. `docs/level_design/REFERENCE_TRANSITION_VECTORS_V1.md`
11. `docs/game_design/DELAYED_SELF_GAME_DESIGN_DOCUMENT_CURRENT.md`
12. `scripts/gameplay/vertical_slice.gd`
13. `scenes/vertical_slice/vertical_slice.tscn`
14. `tests/run_all.gd`
15. `docs/project_rules/PROJECT_RULE_EVIDENCE_AND_INDEPENDENT_REVIEW_CURRENT.md`
16. current plan/handoff/memory documents.

Before editing, print a concise summary of the four findings, implementation boundary, protected semantics, allowed paths, test/evidence plan, commit/push authorization, and stop conditions.

## 4. Evidence to address

Treat the following as direct user evidence, not optional suggestions:

- At `Turn: 77`, the player had not discovered the victory condition.
- The user correctly identified the white/cyan actor as the controlled player and the purple actor as the echo.
- The user understood that the plate opens the door.
- The user believed the current player should hold the plate so the echo could pass.
- The purple echo occupied and visually obscured the circular blue exit marker.
- The user concluded that the gameplay concept is viable, but the current victory condition was not found.

Required severity closure:

- P1-1 victory condition undiscoverable;
- P1-2 exit/echo visual confusion and occlusion;
- P1-3 intended causal roles inverted;
- P2-1 no explicit next echo action;
- P2-2 subgoal copy omits terminal/player-only goal.

## 5. Protected semantics and non-goals

Do not change:

- `simulation_v1` transition semantics;
- action set/order;
- delay/history indexing;
- simultaneous movement;
- plate/door timing;
- player-only exit completion;
- level schema or reference fixtures;
- the formal vertical-slice level topology or entity coordinates;
- solver behavior or expected `L*=9`, `N*=31 (EXACT)`;
- echo-necessity result;
- renderer, viewport, platform commitment, or input mapping.

Do not add:

- hints revealing a movement sequence or solver route;
- undo;
- new mechanics or levels;
- menus, settings, saves, audio, animations requiring assets, third-party assets, plugins, packages, exports, builds, Web work, releases, or submission operations.

## 6. Required UX changes

### 6.1 Distinct persistent exit

Replace the exit's actor-like circular appearance with a clearly different non-actor silhouette. Requirements:

- use code-drawn geometry or built-in UI only;
- prefer a diamond, portal tile, target frame, or other non-circular destination shape;
- include a persistent visible `EXIT` cue or label;
- the cue must remain identifiable when the player or echo occupies the exit cell;
- do not rely on color alone;
- preserve enough actor visibility to tell which actor occupies the exit.

The current draw order, where the echo can cover the exit, must be corrected through draw order, an outer persistent marker, an overlay label, or an equivalent robust design.

### 6.2 Explicit actor/entity legend

Provide a compact visible legend or directly labeled HUD that identifies at minimum:

- `YOU` — white/cyan;
- `ECHO` — purple;
- `PLATE` — yellow/amber;
- `DOOR` — closed/open state;
- `EXIT` — the new distinct marker.

Use both shape/text and color. The legend must fit the 960×540 viewport without obscuring the puzzle.

### 6.3 Explicit objective and role causality

Replace the insufficient instruction with concise text equivalent in meaning to:

```text
GOAL: Move YOU (white) onto EXIT.
The ECHO (purple) cannot finish.
Use the ECHO to hold the PLATE so YOU can cross the DOOR.
```

Wording may be polished, but all three facts must remain explicit. Do not reveal the nine-turn route or specific movement order.

### 6.4 Explicit next echo action

Show the action the delay-3 echo will perform on the next submitted turn, for example:

```text
Echo next: DOWN
```

Requirements:

- derive it from the accepted current-state/history semantics;
- do not create a second transition implementation;
- retain the full oldest-to-newest history queue;
- visually distinguish the next action from the remaining queue;
- for this single-echo vertical slice, a narrow presentation helper is acceptable, but document its relation to the accepted contract and test it.

### 6.5 Clear completion state

When `state.completed=true`, present prominent feedback equivalent to:

```text
COMPLETE — YOU reached EXIT
Press R to restart
```

The completion message must not be confused with ordinary status text.

### 6.6 Optional bounded clarity improvements

Allowed only when they directly support the findings:

- improved spacing/hierarchy;
- a small title/subtitle adjustment;
- a concise first-screen explanation;
- actor markers such as `YOU`/`ECHO` letters or directional notches;
- outlining or patterns to improve non-color identification.

Do not broaden into final art direction or a general UI redesign.

## 7. Architecture constraints

- Logical state must still commit before presentation updates.
- Scene/UI code may read state and call pure presentation helpers, but cannot change transition outcomes.
- Do not duplicate movement, door, completion, or replay logic.
- A new helper in the simulation layer is allowed only if it is pure, contract-derived, and needed to avoid duplicated history indexing; any such helper requires focused tests and must not alter canonical states or transition outputs.
- Prefer presentation-only changes in `scripts/gameplay/vertical_slice.gd` and the scene.

## 8. Automated validation

### 8.1 Full regression

Run the accepted Task 0003 suite and require:

```text
TASK_0003_TESTS_PASS
```

All prior assertions and all 9/9 normative vectors must remain passing. The vertical-slice solver result must remain:

- `SOLVED`;
- `L*=9`;
- `N*=31 (EXACT)`;
- echo-isolated controlled variant exhausted unsolved.

### 8.2 Focused UI/HUD tests

Add bounded repository-only assertions that verify, without pixel-perfect screenshot comparison:

- normal HUD includes explicit `YOU`, `ECHO`, `EXIT`, `PLATE`, and `DOOR` meaning;
- objective states that `YOU` reaches the exit and the echo cannot finish;
- current HUD exposes an explicit next echo action;
- next echo action changes consistently when history changes;
- completion HUD includes both `COMPLETE` and `YOU reached EXIT` or exact approved equivalent;
- restart returns the normal objective and initial next-action display;
- the main scene still instantiates and processes frames without error.

A small testable HUD snapshot/helper is acceptable if it does not become a second gameplay authority.

### 8.3 Visual evidence

This task authorizes creation/use of exactly:

```text
D:\Delayed_Self_Evidence\0004R_ux_repair\
```

Check for safe non-conflicting use before writing. Do not delete or overwrite unrelated evidence.

Capture or generate, with game-window-only privacy boundaries:

1. initial state screenshot;
2. a state with the echo occupying the exit, proving the exit remains visible/distinct;
3. a completed state screenshot, proving completion feedback;
4. bounded test and launch logs;
5. an evidence index with commit, commands, timestamps, filenames, and hashes where useful.

Do not stage screenshots or raw logs.

If safe automated game-window capture is unavailable, record the limitation and provide a bounded manual capture protocol; do not capture the entire desktop without explicit user approval.

## 9. Authorized repository changes

May modify:

- `scripts/gameplay/vertical_slice.gd`;
- `scenes/vertical_slice/vertical_slice.tscn`;
- `tests/run_all.gd`;
- `scripts/simulation/simulation.gd` only for one pure presentation-query helper when clearly justified;
- current docs needed to move the gate;
- `docs/reviews/0004_FIRST_PLAYER_UX_AND_VISUAL_READABILITY_REVIEW.md` to materialize the direct evidence without inventing unanswered ratings;
- `docs/reports/0004R_EXIT_OBJECTIVE_AND_ECHO_READABILITY_REPAIR_REPORT.md`.

The formal review document must mark unavailable fixed-question answers/ratings as `NOT_PROVIDED`, not guess them, and link to the GPT evidence adjudication.

Do not modify:

- `data/levels/vertical_slice_delay_3.json`;
- `schemas/`;
- accepted contracts or transition fixtures;
- loader or BFS solver unless a proven regression requires a separate stop/report;
- project rules, GDD, licenses, export files, or protected release surfaces.

## 10. Required report

The Task 0004R report must include:

- verdict;
- task path;
- start/final HEAD and origin;
- exact changed files;
- mapping from P1/P2 finding to repair;
- tests run and results;
- exact assertion/vector/solver summaries;
- visual evidence index/path;
- source/runtime surfaces not changed;
- no-release/non-export claims;
- unresolved visual or first-player uncertainty;
- recommended next gate: `Task 0004V` user retest.

## 11. Validation and Git discipline

Before staging:

```powershell
git status --short --untracked-files=all
git diff --check
git diff --stat
```

Review for:

- no semantic change to accepted simulation/level;
- no solver-route disclosure in normal HUD;
- all required entity/objective facts visible;
- no external assets, generated imports, builds, exports, screenshots, or logs staged;
- no secrets or unrelated personal data;
- links resolve;
- current docs do not claim first-player UX has passed before retest.

Stage only authorized paths explicitly. Never use broad staging.

Then run:

```powershell
git diff --cached --check
git diff --cached --stat
git diff --cached --name-only
```

## 12. Commit and push authorization

This task authorizes one focused implementation/documentation commit on `main` and one normal push after all gates pass.

Required commit message:

```text
fix: clarify Delayed Self exit and echo objective
```

Immediately before push:

```powershell
git fetch origin
git rev-parse HEAD
git rev-parse origin/main
git status --short --untracked-files=all
```

If remote moved after task start, stop. Do not merge, rebase, amend, force-push, overwrite, or create a second commit without new authorization.

## 13. Stop conditions

Stop with `BLOCKED` if:

- startup/root/Git/toolchain gate fails;
- accepted regression suite fails before changes;
- a required repair appears to require changing simulation/schema/level semantics;
- exit visibility cannot be repaired without unsupported assets or broad redesign;
- source becomes unexpectedly dirty;
- evidence path conflicts;
- remote drifts before push.

Do not weaken expected tests or fixtures to obtain a pass.

## 14. Terminal verdicts

Use exactly one:

- `PASS_FOR_GPT_REVIEW`
- `PASS_WITH_OBSERVATIONS_FOR_GPT_REVIEW`
- `BLOCKED`

A passing implementation does not mean the first-player UX is accepted. The required next gate is a real user retest:

```text
Task 0004V — targeted first-player victory-condition and entity-readability retest
```

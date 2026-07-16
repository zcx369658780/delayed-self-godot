# Task 0012 — Difficult Level 6 `staggered_doors`

- Status: `READY`
- Gate: `IMPLEMENTATION + FORMAL VALIDATION / DIFFICULT CONTENT`
- Repository: `zcx369658780/delayed-self-godot`
- Expected branch: `main`
- Expected local root: `D:\Delayed_Self`
- Issued by: GPT Project Sources advisor
- Date: 2026-07-16
- Prior accepted gate: `TASK_0011RV_STANDALONE_WINDOW_RETEST_ACCEPTED`
- Prior owner-evidence commit: `493c2c28df31d7dcfe1e311c0af5f2fce61f99ea`
- Prior acceptance artifact: `docs/reports/0011RV_GPT_FINAL_ACCEPTANCE.md`
- Accepted planning sources:
  - `docs/level_design/INITIAL_LEVEL_ROADMAP_AND_VALIDATION_MATRIX_CURRENT.md`
  - `docs/level_design/FIVE_LEVEL_DIFFICULTY_RECOVERY_AND_LEVELS_6_8_PLAN.md`
  - `docs/reports/0010_PRESENTATION_DIFFICULTY_AND_PRODUCTION_DIRECTION_PLANNING_REPORT.md`

## 1. Objective

Implement and formally validate the sixth catalog level:

```text
staggered_doors / Staggered Doors / 错开的门
```

This is the first deliberately harder content gate after the five-level onboarding sequence. It must increase planning depth materially without introducing any new mechanic or changing `simulation_v1`, `level_v1`, the reusable Gameplay path, AppRoot, or the accepted primitive presentation.

The intended puzzle is:

- one current player;
- one delay-3 ECHO;
- two Plates;
- two Doors with distinct dependency sets;
- one recorded route creates two useful but temporally different Door windows;
- YOU must decide when and how to traverse both Doors;
- both ECHO cooperation and both dependencies are necessary;
- the puzzle cannot collapse into a long corridor, repeated movement macro, blind trial-and-error sequence, or another tutorial-level room.

The task ends at `INTERNAL_PLAYABLE` with exact machine evidence and bounded runtime smoke. It does not include owner or fresh-player acceptance.

## 2. Mandatory startup gate

Before any write:

```powershell
Get-Location
git branch --show-current
git rev-parse HEAD
git rev-parse origin/main
git remote -v
git status --short --untracked-files=all
git log -32 --oneline --decorate
godot --version
Get-Command godot | Format-List Source,Version,CommandType
```

Required:

- absolute root is `D:\Delayed_Self`;
- branch is `main`;
- origin is the expected repository;
- local `HEAD` and `origin/main` contain this task and `docs/reports/0011RV_GPT_FINAL_ACCEPTANCE.md`;
- worktree is fully clean, including untracked files;
- Godot is the accepted `4.7.stable.steam.5b4e0cb0f` toolchain or the exact equivalent documented in the current environment record.

If clean local `main` is behind, use only:

```powershell
git fetch origin
git merge --ff-only origin/main
```

Stop on divergence, conflict, unexpected files, wrong root/remote, inability to fast-forward, or a materially different toolchain.

## 3. Required reads

Read in order:

1. `AGENTS.md`;
2. `docs/CODEX_STARTUP_SNAPSHOT_CURRENT.md`;
3. `docs/CODEX_ACTIVE_TASK_CURRENT.md`;
4. this task;
5. `docs/reports/0011RV_GPT_FINAL_ACCEPTANCE.md`;
6. `docs/reports/0011RV_OWNER_WINDOW_FILL_RETEST_REPORT.md`;
7. `docs/level_design/INITIAL_LEVEL_ROADMAP_AND_VALIDATION_MATRIX_CURRENT.md`;
8. `docs/level_design/FIVE_LEVEL_DIFFICULTY_RECOVERY_AND_LEVELS_6_8_PLAN.md`;
9. `docs/reports/0010_PRESENTATION_DIFFICULTY_AND_PRODUCTION_DIRECTION_PLANNING_REPORT.md`;
10. `docs/game_design/GAMEPLAY_SIMULATION_CONTRACT_CURRENT.md`;
11. `docs/level_design/LEVEL_SCHEMA_V1_CURRENT.md`;
12. `schemas/level_v1.schema.json`;
13. all five tracked formal levels and the catalog;
14. current solver, loader, aggregate tests, Level 4/5 validation tests, Gameplay presentation tests, and capture harnesses;
15. current evidence, Godot-safety, privacy, puzzle-validation, and independent-review rules;
16. current startup/index/plan/handoff/project-memory documents.

Before editing, print a concise implementation plan containing:

- selected candidate geometry strategy;
- exact Door dependency sets;
- intended two-window trace;
- target metric bands and solver limits;
- mechanic-necessity controls;
- bypass and meaningful-decision audits;
- catalog/progression changes;
- runtime/capture plan;
- exact authorized files selected;
- rollback and stop conditions.

## 4. Frozen authorities

Treat as immutable:

- Godot 4.7 stable, GDScript, Compatibility renderer, Windows primary target;
- the 960×540 logical presentation and accepted window scaling policy;
- `simulation_v1` action order `UP, RIGHT, DOWN, LEFT, WAIT`;
- delay/history semantics, including blocked legal moves consuming a turn and entering history;
- same start-turn Door snapshot, simultaneous settlement, legal actor overlap, post-movement Plate evaluation, combinational AND Doors, next-turn effect, and player-only EXIT;
- exact restart, replay, canonical key, and bounded deterministic BFS semantics;
- strict UTF-8 `level_v1` and catalog-v1 validation;
- all five existing formal level files, hashes, metrics, controls, routes, and human findings;
- the five-level order and memory-only progress behavior, except the exact authorized append of Level 6;
- Task 0011 presentation behavior and Task 0011R standalone window behavior;
- WAIT as `DEFERRED_VALIDATION_RESEARCH`;
- latched/one-shot Gate as `DRAFT_NOT_ACCEPTED`;
- route divergence, hazards, boxes, anchors, teleports, combat, interaction, latches, and new goals as out of scope.

Do not modify:

- `project.godot`;
- `scripts/simulation/`;
- `scripts/solver/`;
- `scripts/app/`;
- `scripts/gameplay/`;
- `scenes/`;
- `schemas/`;
- any of the five existing files under `data/levels/`;
- normative fixtures or accepted contracts;
- assets, fonts, imports, audio, music, SFX, plugins, or dependencies;
- persistence, settings, export, build, release, account, or repository settings;
- GDD or project rules.

If the level cannot be implemented without any frozen runtime, schema, scene, or project-setting change, stop with:

```text
BLOCKED_LEVEL_6_REQUIRES_RUNTIME_OR_SCHEMA_CHANGE
```

## 5. Formal Level 6 contract

Create exactly:

```text
data/levels/staggered_doors.json
```

Required formal facts:

- `schema_version = 1`;
- `level_id = "staggered_doors"`;
- title is `Staggered Doors`;
- exactly one ECHO;
- ECHO delay exactly `3`;
- ECHO spawn equals the player spawn unless a documented candidate proof shows that a distinct spawn is necessary and still represents the delayed-self model; shared spawn is strongly preferred;
- exactly two Plates with stable distinct IDs;
- exactly two Doors with stable distinct IDs and distinct positions;
- each Door references a non-empty Plate set;
- the two Door reference sets are not identical;
- the union of Door dependencies includes both Plates;
- both Plates are required by the final puzzle, not decorative;
- both Doors lie on the necessary player route to EXIT;
- only YOU can complete at EXIT;
- no unknown fields;
- no `best_turn_threshold` or unaccepted mechanic metadata;
- geometry fits the accepted 9-column by 7-row maximum presentation footprint;
- all critical entities and dependency relationships remain visually separable in the current primitive renderer.

Dependency-line geometry must avoid needless crossing or long overlapping paths. Do not repair presentation code in this task; re-author the room geometry if primitive relationship lines become materially ambiguous.

## 6. Catalog and progression

Update only:

```text
data/catalog/level_catalog_v1.json
```

Required catalog result:

- exactly six entries, sequence 1–6;
- entries 1–5 retain their IDs, paths, order, classification, HUD modes, and prerequisites;
- Level 5 `two_keys_one_door.final_level` changes from `true` to `false`;
- append Level 6:

```json
{
  "level_id": "staggered_doors",
  "level_path": "res://data/levels/staggered_doors.json",
  "sequence": 6,
  "display_title_key": "level.staggered_doors.title",
  "classification": "standard",
  "unlock_prerequisites": ["two_keys_one_door"],
  "hud_mode": "STANDARD_COMPACT",
  "final_level": true
}
```

- no `best_turn_threshold`;
- exactly one final entry;
- Level 6 is locked initially and unlocks only after accepted completion of Level 5;
- reset restores only Tutorial 0 unlocked;
- direct-level parsing accepts `staggered_doors` through the existing generic path without parser changes;
- Safe Error behavior remains unchanged.

## 7. Difficulty acceptance targets

The final tracked candidate must satisfy all hard target bands:

```text
15 <= L* <= 21
1 <= N* <= 12
N* status = EXACT
2000 <= visited_states <= 40000
```

Also record:

- maximum frontier;
- exact depth, state, time, and solution-count limits;
- solver elapsed time if exposed;
- final action witness;
- formal file SHA-256;
- resource and traversable-cell summary.

These values are validation evidence only. Do not write a best-turn threshold into catalog or level data.

Use bounds high enough to establish exactness. A timeout, state limit, depth limit, or count cap is never called solved-exact or unsolvable.

If a candidate falls outside any hard band, re-author it rather than weakening the task. If no qualifying candidate is found after a bounded, documented authoring pass, stop cleanly with:

```text
BLOCKED_LEVEL_6_DIFFICULTY_TARGET_NOT_ESTABLISHED
```

Do not commit an out-of-band level merely to preserve sequence count.

## 8. Required two-window proof

A solver-produced shortest witness must replay through the shared Simulation and demonstrate two distinct useful Door-entry windows.

For each Door, record a critical trace containing:

1. state before the dependency is satisfied;
2. actor positions and history that create the relevant Plate occupancy;
3. result state in which that Door becomes open;
4. the following start-turn snapshot used by YOU to enter or cross that Door;
5. whether the Door later closes around or behind an occupant;
6. the exact actor/Plate relationship responsible for the window.

The two windows must be mechanically distinct:

- they must not be the same Door state duplicated in prose;
- they must not arise from identical dependency sets;
- they must not reduce to one permanent combined opening traversed without a second timing decision;
- each Door must be entered or crossed by YOU in every accepted shortest solution;
- the relevant Plate arrangements or useful time intervals must differ;
- both windows must be observable using the accepted Plate/Door/ECHO feedback.

A shortest witness alone is insufficient; the tests and report must explain why both windows matter.

## 9. Mechanic-necessity and bypass controls

Run and record all applicable controls with complete finite-state conclusions where required.

### 9.1 ECHO necessity

Construct a schema-valid no-ECHO control using the existing tutorial-zero exception only for validation. It must be:

```text
UNSOLVABLE_WITHIN_COMPLETE_FINITE_STATE
```

Record visited states and limits. This proves no player-only bypass.

### 9.2 Plate necessity

For each Plate separately, construct a controlled variant that makes that Plate unavailable without introducing a new mechanic or accidental alternate route. Each variant must either:

- exhaust the complete finite state space as unsolvable; or
- fail one of the exact required Door-window events while being otherwise carefully explained.

Complete-unsolved evidence is strongly preferred. Record why the relocation/isolation is a valid necessity control.

### 9.3 Door necessity

For each Door separately, use a controlled removal or neutralization analysis to show that the formal Door is not decorative. Record the resulting exact solution status and metric change. At minimum, the formal shortest witnesses must all cross both Door positions under their open start-turn snapshots.

### 9.4 Dependency-set necessity

Audit each Door reference set. Demonstrate that replacing or weakening a dependency changes the solution structure, shortest metric, or required event. Do not overclaim a control that merely produces a different but equivalent route.

### 9.5 EXIT and restart

- ECHO on EXIT never completes;
- YOU completion remains exact;
- restart reconstructs the initial state exactly;
- solver witness replay equals runtime state after the same action sequence.

### 9.6 Shortcut audit

Explicitly test and report:

- no terrain route bypasses either Door;
- legal overlap does not trivialize either dependency;
- repeated blocked moves do not create a one-pattern timing exploit that removes the second decision;
- no single Plate or single actor can hold the entire solution open indefinitely;
- neither Door can be ignored on an optimal route;
- the room is not solvable by following the wall or repeating one movement cycle without reading state.

## 10. Meaningful-decision audit

The final level must contain at least three documented meaningful decisions along a shortest witness.

A meaningful decision is a witness turn where:

- at least one alternative legal action produces a distinct canonical successor;
- the alternative is not merely an input alias;
- the alternative causes a measurable consequence such as a longer exact completion, a missed Door window, a different recoverable branch, or complete failure;
- the distinction can be explained through observable positions, history, Plate state, or Door state.

Requirements:

- identify at least three such turns;
- at least two must involve genuine route or timing choices, not only repeated blocked cardinal actions;
- they must not all be consecutive copies of the same local choice;
- compare the chosen prefix with at least one alternative replay or bounded search for each decision;
- document whether the mistake is recoverable and its minimum known penalty when established.

This audit prevents a high `L*` created only by corridor length or repeated macros from being accepted as difficulty.

If the candidate meets solver bands but cannot establish three meaningful decisions, it is not accepted and must be re-authored.

## 11. WAIT boundary

Level 6 is not a WAIT-teaching gate.

Preferred result:

- the selected shortest witness contains no literal `WAIT`;
- no strict WAIT-relevance claim is made.

If a final shortest witness uses literal `WAIT`, do not claim it is necessary unless the strict Task 0009A comparison is separately established against a no-WAIT search that still allows blocked cardinal turns. Without that proof, re-author the candidate or stop with:

```text
BLOCKED_LEVEL_6_REOPENS_WAIT_RESEARCH
```

Blocked cardinal moves remain legal history-bearing actions under the accepted contract.

## 12. Runtime, presentation, and progression smoke

Use the existing reusable Gameplay path only.

Required runtime checks:

- six-entry catalog loads through AppRoot;
- initial Level Select shows only Tutorial 0 unlocked;
- accepted completion chain unlocks Levels 2–6 in order;
- Level 6 remains locked before Level 5 completion;
- Level 5 completion unlocks exactly Level 6;
- selecting Level 6 loads `staggered_doors` with matching formal ID and `STANDARD_COMPACT`;
- Level 6 solver witness replays through the Gameplay scene to completion;
- completion/return behavior remains normal;
- reset restores the exact initial unlock state;
- Help remains modal and zero-turn;
- resize/window behavior remains accepted;
- current primitive Plate/Door/ECHO cues make both critical windows inspectable;
- dependency lines do not become a material blocker in this room geometry;
- no dropped, duplicated, reordered, or synthetic input is introduced.

Do not modify Timeline/Help visibility logic, Door feedback code, scene layout, or window settings to accommodate the level.

## 13. Tests

Add focused tests under the minimum necessary subset of:

```text
tests/levels/
tests/gameplay/
tests/app/
```

Update:

```text
tests/run_all.gd
```

The focused suite must cover at minimum:

1. strict LevelLoader acceptance and exact formal cardinalities;
2. six-entry catalog validation and exact progression facts;
3. solver `SOLVED`, hard target bands, and exact `N*`;
4. solver witness replay and exact restart;
5. both critical Door-window traces;
6. all shortest accepted solutions cross both Doors, when exact enumeration permits direct verification;
7. no-ECHO complete-unsolved control;
8. both Plate-necessity controls;
9. Door/dependency control results;
10. player-only EXIT;
11. shortcut/bypass audit;
12. three meaningful-decision evidence records;
13. no unproven WAIT claim;
14. reusable Gameplay runtime smoke;
15. Level 5 to Level 6 unlock and reset behavior;
16. all five prior hashes and metrics unchanged;
17. accepted Task 0011/0011R presentation and window invariants unchanged.

Add the stable marker:

```text
TASK_0012_LEVEL_6_STAGGERED_DOORS_TESTS_PASS
```

Final aggregate output must contain all prior markers plus the new marker:

```text
TASK_0003_TESTS_PASS assertions=<at least 340> vectors=9
TASK_0006_APP_SHELL_TESTS_PASS
TASK_0007_TUTORIAL_LEVELS_TESTS_PASS
TASK_0008_PROGRESSIVE_HUD_TESTS_PASS
TASK_0009AR_LEVELS_4_5_TESTS_PASS
TASK_0011_PRESENTATION_RECOVERY_TESTS_PASS
TASK_0011R_WINDOW_FILL_TESTS_PASS
TASK_0012_LEVEL_6_STAGGERED_DOORS_TESTS_PASS
```

Any failed assertion, missing marker, parser/script error, crash, nonzero exit, altered prior hash/metric, or incomplete solver status fails the task.

Expected negative-path stderr remains non-authoritative by itself; native exit code, failed assertions, and final markers are authoritative.

## 14. External evidence

Authorized external root:

```text
D:\Delayed_Self_Evidence\0012_staggered_doors\
```

Record:

- candidate/iteration ledger without retaining unnecessary rejected repository files;
- exact solver command and limits;
- final stdout/stderr and native exit code;
- final level SHA-256;
- `L*`, `N*`, exactness, visited, frontier, and elapsed time;
- shortest witness and replay trace;
- both Door-window traces;
- mechanic-necessity control results;
- meaningful-decision audit;
- shortcut/bypass audit;
- six-level progression trace;
- game-window-only captures of:
  - Level Select with Level 6 locked;
  - Level Select after Level 5 unlocks Level 6;
  - initial Level 6;
  - first critical Door window;
  - second critical Door window;
  - Level 6 completion;
- evidence index with timestamps, sizes, commands, and SHA-256 hashes.

Use a standalone native game window or the accepted bounded capture harness. Do not use a Godot editor embedded preview as product-window evidence. Do not capture the full desktop automatically.

Do not stage external evidence, logs, screenshots, `.godot/`, generated `.gd.uid`, imports, or temporary candidates.

If Godot rewrites `project.godot` or generates unexpected files, stop before cleanup unless an existing accepted rule explicitly authorizes exact handling. Do not silently repeat the Task 0011RVE incident cleanup authorization in this implementation task.

## 15. Report

Create:

```text
docs/reports/0012_LEVEL_6_STAGGERED_DOORS_REPORT.md
```

Include:

- task and live Git facts;
- candidate-authoring summary and rejected-candidate count;
- final formal level facts and dependency sets;
- geometry and primitive-clarity rationale;
- solver limits and exact metrics;
- shortest witness;
- both Door-window traces;
- all control variants and complete/incomplete status boundaries;
- three meaningful-decision audit;
- WAIT boundary;
- bypass and trial-and-error audit;
- catalog/progression behavior;
- runtime/presentation smoke;
- prior five hashes/metrics and new Level 6 hash;
- complete aggregate markers and assertion/vector counts;
- external evidence index;
- changed paths and protected surfaces;
- rollback procedure;
- non-claims;
- recommendation for GPT review and later owner sequence review.

Do not call Level 6 fresh-player reviewed, candidate accepted, final difficulty, fun, balanced, asset-complete, or release-ready.

## 16. Authorized repository surface

May modify only the minimum necessary subset of:

- `data/levels/staggered_doors.json` — new formal level;
- `data/catalog/level_catalog_v1.json` — exact append/final-flag change;
- `tests/run_all.gd`;
- focused tests under `tests/levels/`, `tests/gameplay/`, or `tests/app/`;
- focused capture harness under `tests/gameplay/` or `tests/app/`;
- `docs/reports/0012_LEVEL_6_STAGGERED_DOORS_REPORT.md`;
- `docs/level_design/INITIAL_LEVEL_ROADMAP_AND_VALIDATION_MATRIX_CURRENT.md`, only to replace Level 6 proposal facts with exact implementation evidence after validation;
- `docs/level_design/FIVE_LEVEL_DIFFICULTY_RECOVERY_AND_LEVELS_6_8_PLAN.md`, only for exact Level 6 status/metrics after validation;
- narrowly necessary current startup/task/index/plan/handoff/project-memory Markdown documents.

Do not broaden silently. Before editing, list exact selected files. Before staging, verify no generated UID, import, cache, screenshot, log, or temporary file is present.

## 17. Git discipline

Before staging:

```powershell
git status --short --untracked-files=all
git diff --check
git diff --stat
```

Audit:

- only explicitly selected authorized paths changed;
- all five existing formal level files are byte-identical;
- no runtime/schema/project/scene changes;
- catalog change is limited to Level 5 final flag and Level 6 append;
- no generated `.gd.uid`, `.godot`, screenshot, log, evidence, temporary candidate, asset, or import file is staged;
- all aggregate markers pass;
- report does not overclaim human acceptance.

Stage explicit files only. Do not use `git add .`, `git add -A`, broad globs, or broad pathspecs.

Commit exactly once:

```text
feat: add Delayed Self staggered doors level
```

Then:

```powershell
git fetch origin
```

Require no remote drift from the task publication point. Push normally to `origin/main`.

Forbidden:

- rebase;
- amend;
- force-push;
- reset;
- merge commit;
- broad restore or checkout;
- broad staging;
- modifying prior acceptance artifacts;
- committing external evidence.

## 18. Terminal verdicts

After one successful implementation/documentation commit and normal push:

```text
PASS_FOR_GPT_REVIEW
```

Include:

- commit SHA;
- final `L*`, exact `N*`, visited, frontier, and solver limits;
- shortest witness;
- two Door-window proof summary;
- control-variant summary;
- meaningful-decision count;
- final assertions/vectors and all eight markers;
- new level SHA-256;
- report path;
- confirmation that `HEAD == origin/main` and worktree is clean.

If no candidate meets the hard difficulty bands:

```text
BLOCKED_LEVEL_6_DIFFICULTY_TARGET_NOT_ESTABLISHED
```

If runtime/schema changes are required:

```text
BLOCKED_LEVEL_6_REQUIRES_RUNTIME_OR_SCHEMA_CHANGE
```

If WAIT research is reopened without strict proof:

```text
BLOCKED_LEVEL_6_REOPENS_WAIT_RESEARCH
```

If unexpected generated or unrelated files appear and safe handling is not already authorized:

```text
BLOCKED_UNEXPECTED_WORKTREE_CHANGE
```

Do not substitute a weaker level, weaken metrics, or proceed to Level 7.
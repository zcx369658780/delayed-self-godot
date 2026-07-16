# Task 0011R — Physical-window fill, scaling, and centering repair

- Status: `READY`
- Gate: `IMPLEMENTATION / FOCUSED PRESENTATION REPAIR`
- Repository: `zcx369658780/delayed-self-godot`
- Expected branch: `main`
- Expected local root: `D:\Delayed_Self`
- Issued by: GPT Project Sources advisor
- Date: 2026-07-16
- Prior accepted gate: `TASK_0011V_OWNER_PRESENTATION_REVIEW_ACCEPTED_WITH_FOCUSED_REPAIR_REQUIRED`
- Accepted presentation implementation: `c26d8be1c97dbe057f633b55ea7689f35272c577`
- Accepted owner-review evidence: `39d0882e90771c1c54ebdb6477f560e81168fa9e`
- Prior acceptance artifact: `docs/reports/0011V_GPT_FINAL_ACCEPTANCE.md`

## 1. Objective

Repair the mismatch between the accepted `960×540` logical presentation and a larger physical game-window client area.

The accepted owner screenshot shows the logical canvas rendered at its native `960×540` size in the upper-left corner of a larger window, leaving an L-shaped unused gray region on the right and bottom. Task 0011 improved the composition inside the logical canvas but did not make that canvas scale and center correctly in the physical window.

This task must:

1. diagnose the actual root cause using project settings, main/root scene structure, runtime window/client dimensions, and bounded captures;
2. keep `960×540` as the logical reference presentation;
3. scale the complete logical presentation uniformly to use the maximum available physical client area;
4. center the scaled presentation;
5. preserve the logical aspect ratio and avoid distortion;
6. permit only unavoidable, symmetric letterboxing or pillarboxing when the client aspect ratio differs from 16:9;
7. eliminate the current top-left native-size canvas plus right/bottom unused L-shaped region;
8. use an intentional dark bar/background when aspect bars are unavoidable, never the default gray clear area;
9. preserve the accepted board/HUD layout, input mapping, simulation semantics, routes, unlock progression, and all five levels;
10. stop before licensed assets, audio, narrative, Level 6, Gate, save, export, or release work.

This task is a focused window/presentation integration repair. It does not authorize responsive HUD reflow, a `1280×720` logical migration, new art, new gameplay, or level edits.

## 2. Success criteria

Task 0011R succeeds only when:

1. the root cause is stated explicitly in the implementation report and supported by before/after runtime evidence;
2. the logical presentation remains exactly `960×540` for layout and test coordinates;
3. at an exact 16:9 physical client size larger than 960×540, the logical presentation fills the client area without unused right/bottom space;
4. at a non-16:9 physical client size, the presentation uses the largest uniform scale that fits and is centered, with symmetric bars on only the necessary axis;
5. no content is stretched non-uniformly, clipped, or anchored to the upper-left physical corner;
6. Main Menu, Level Select, Gameplay, Help, completion overlays, and Safe Error all follow the same physical-window scaling/centering policy;
7. mouse-independent keyboard controls and focus behavior remain correct after resize/maximize;
8. resizing or maximizing the window does not drop, duplicate, reorder, or synthesize puzzle input;
9. window-size handling does not call `Simulation.transition`, alter state, reset progress, reload a level unexpectedly, or change a canonical key;
10. the accepted `60 px` logical board pitch, logical HUD zones, modal Help, contextual Timeline, Door/Plate/ECHO feedback, and reduced-motion substitute remain unchanged in logical coordinates;
11. all six prior markers remain passing and one new Task 0011R marker passes;
12. all five formal hashes, metrics, routes, unlock results, and simulation authorities remain unchanged;
13. external captures demonstrate correct behavior at the required window-size matrix;
14. no claim of final responsive layout, final art, asset clearance, or human acceptance is introduced.

## 3. Mandatory startup gate

Before any write:

```powershell
Get-Location
git branch --show-current
git rev-parse HEAD
git rev-parse origin/main
git remote -v
git status --short --untracked-files=all
git log -26 --oneline --decorate
godot --version
```

Required conditions:

- absolute root is `D:\Delayed_Self`;
- branch is `main`;
- origin is the expected repository;
- local `HEAD` and `origin/main` contain this task and `docs/reports/0011V_GPT_FINAL_ACCEPTANCE.md`;
- tracked worktree is clean;
- Godot resolves to the accepted `4.7.stable` toolchain.

If local is behind and clean, use only:

```powershell
git fetch origin
git merge --ff-only origin/main
```

Stop on divergence, conflict, remote mismatch, unexpected tracked changes, unsafe root, missing governance artifacts, inability to fast-forward, or materially different toolchain.

## 4. Required reads and diagnosis

Read in this order:

1. `AGENTS.md`;
2. `docs/CODEX_STARTUP_SNAPSHOT_CURRENT.md`;
3. `docs/CODEX_ACTIVE_TASK_CURRENT.md`;
4. this task;
5. `docs/reports/0011V_GPT_FINAL_ACCEPTANCE.md`;
6. `docs/reviews/0011V_OWNER_PRESENTATION_AND_LEVEL4_RETEST.md`;
7. `docs/reports/0011V_OWNER_PRESENTATION_REVIEW_REPORT.md`;
8. `docs/reports/0011_GPT_FINAL_ACCEPTANCE.md`;
9. `docs/reports/0011_PRIMITIVE_PRESENTATION_AND_DOOR_FEEDBACK_RECOVERY_REPORT.md`;
10. `docs/ux/PRESENTATION_VIEWPORT_AND_HUD_DIRECTION_CURRENT.md`;
11. `project.godot`;
12. the configured main scene and exact AppRoot/root presentation scene/script;
13. the shared Gameplay scene/script;
14. Main Menu, Level Select, Safe Error, and route-hosting scenes/scripts for anchoring inspection only;
15. current presentation tests and capture harnesses;
16. current startup/index/plan/handoff/project-memory documents;
17. Godot-safety, evidence, independent-review, and puzzle-validation rules.

Before editing, print a concise diagnosis summary containing:

- configured logical size, physical startup size, content-scale/stretch mode, aspect policy, and resize policy;
- the exact root node/control/viewport hierarchy responsible for rendering the logical presentation;
- measured runtime outer-window and client-area sizes;
- the measured logical-content rectangle inside the client before repair;
- why the current content remains `960×540` at the upper-left rather than scaling/centering;
- the minimum proposed setting/root-layout change;
- why changing only the clear/background color would be an invalid fake fix;
- expected behavior at exact and non-exact 16:9 client sizes;
- tests, captures, rollback, commit policy, and stop conditions.

Do not edit until the root cause is stated. If the root cause cannot be identified with confidence, stop with:

```text
BLOCKED_WINDOW_FILL_ROOT_CAUSE_UNRESOLVED
```

## 5. Frozen authorities

Treat as immutable:

- Godot 4.7 stable, GDScript, Compatibility renderer, Windows target;
- the `960×540` logical presentation coordinate system;
- `simulation_v1`, `level_v1`, catalog-v1, action order, history/delay semantics, simultaneous movement, Door/Plate timing, player-only EXIT, restart, replay, canonical keys, and solver statuses;
- all five formal level files and accepted metrics/hashes;
- the five-entry catalog, route IDs, final flag, and memory-only progression;
- Task 0011's logical `60 px` board pitch, board/HUD composition, Help/Timeline behavior, and primitive feedback vocabulary;
- WAIT as `DEFERRED_VALIDATION_RESEARCH`;
- latched/one-shot Gate as `DRAFT_NOT_ACCEPTED`;
- licensed assets/audio/narrative and Levels 6–8 as separately gated work.

Do not modify:

- `scripts/simulation/`;
- `scripts/solver/`;
- `schemas/`;
- `data/levels/`;
- `data/catalog/`;
- normative fixtures/contracts;
- GDD or project rules;
- catalog loader or memory-progress semantics;
- assets, fonts, imports, audio, music, SFX, plugins, or dependencies;
- persistence, export, build, release, account, or repository settings unrelated to the exact window/content-scale repair.

Do not use this task to remove dependency lines, replace primitives, add Level 6, or migrate to a responsive HUD.

## 6. Authorized implementation surface

May modify only the minimum necessary subset of:

- `project.godot`, limited to exact `display/window/*`, content-scale/stretch, initial/minimum-size, and resize keys justified by the diagnosis;
- the configured main/AppRoot/root presentation scene and its associated script, only for full-client anchoring, scaling host, centering, and intentional bar/background behavior;
- `scenes/vertical_slice/vertical_slice.tscn` and `scripts/gameplay/vertical_slice.gd` only if a child root is proven to prevent the complete accepted Gameplay composition from following the host transform;
- focused window/presentation helpers under `scripts/app/`, `scripts/ui/`, or `scripts/gameplay/` when required;
- `tests/run_all.gd`;
- focused tests under `tests/app/`, `tests/ui/`, or `tests/gameplay/`;
- focused capture harnesses under `tests/app/` or `tests/gameplay/`;
- `docs/reports/0011R_PHYSICAL_WINDOW_FILL_REPAIR_REPORT.md`;
- narrowly necessary current startup/task/index/plan/handoff/project-memory documents.

Before editing, list the exact files selected from this allowance. Do not broaden silently.

If the repair requires a logical viewport migration, responsive HUD reflow, level/catalog field, state change, or unrelated project setting, stop with:

```text
BLOCKED_WINDOW_FILL_REQUIRES_BROADER_MIGRATION
```

## 7. Required physical-window behavior

### 7.1 Reference transform

Use the actual physical **client area**, not outer-window dimensions including title bar and borders.

For client size `(W,H)` and logical size `(960,540)`, the resulting presentation must be equivalent to:

```text
scale = min(W / 960, H / 540)
content_width = 960 * scale
content_height = 540 * scale
offset_x = (W - content_width) / 2
offset_y = (H - content_height) / 2
```

The implementation may rely on Godot's correct built-in content scaling rather than manually applying this formula, but focused tests/evidence must demonstrate equivalent results within bounded rounding tolerance.

### 7.2 Exact 16:9 client

At larger exact-16:9 client sizes:

- content fills the complete client area;
- `offset_x≈0` and `offset_y≈0`;
- no gray right/bottom region exists;
- all routes and overlays fill consistently.

### 7.3 Non-16:9 client

At non-16:9 client sizes:

- scale remains uniform;
- content is centered;
- bars appear only on the necessary axis;
- opposite bars are symmetric within rounding tolerance;
- bars use an intentional project background consistent with the accepted dark presentation;
- no L-shaped lower-right remainder or top-left anchoring remains.

### 7.4 Resize and maximize

When resized or maximized:

- scaling and centering update without reloading the route;
- current gameplay state, turn, history, Door state, disclosure state, Help visibility, and progress remain unchanged;
- keyboard input remains mapped to the logical game, with no additional transition caused by the resize event;
- Help and completion overlays remain centered in logical composition space.

## 8. Required tests

Repository-only tests must cover at minimum:

1. logical reference size remains `960×540`;
2. exact-16:9 client transform fills the client and centers at zero offset;
3. wider client produces symmetric pillarboxing, not a right-only strip;
4. taller/narrower client produces symmetric letterboxing, not a bottom-only strip;
5. resize transformation is deterministic and idempotent;
6. route changes do not create a different scale policy;
7. Main Menu, Level Select, Gameplay, Help, completion, and Safe Error use the same full-client host;
8. resize/maximize does not call a puzzle transition or change canonical key/turn/history;
9. accepted logical board/HUD rectangles remain unchanged in 960×540 coordinates;
10. no physical-client gray clear region is exposed outside the intentional bar/background host;
11. all five levels remain reachable and completable through the existing route tests;
12. all accepted metrics, hashes, and controlled-unsolved results remain unchanged.

Add the stable marker:

```text
TASK_0011R_WINDOW_FILL_TESTS_PASS
```

Final required markers:

```text
TASK_0003_TESTS_PASS assertions=<at least 301> vectors=9
TASK_0006_APP_SHELL_TESTS_PASS
TASK_0007_TUTORIAL_LEVELS_TESTS_PASS
TASK_0008_PROGRESSIVE_HUD_TESTS_PASS
TASK_0009AR_LEVELS_4_5_TESTS_PASS
TASK_0011_PRESENTATION_RECOVERY_TESTS_PASS
TASK_0011R_WINDOW_FILL_TESTS_PASS
```

Any failure exits non-zero.

## 9. Runtime evidence

Authorized external root:

```text
D:\Delayed_Self_Evidence\0011R_window_fill_repair\
```

Capture the game window only. Do not capture the full desktop automatically.

Required before/after or final evidence:

- current defect reproduction with measured client/content rectangles;
- Main Menu and Level Select at 960×540 client;
- Gameplay Level 5 at an exact larger 16:9 client, preferably 1280×720 or 1600×900;
- Gameplay Level 5 at one non-16:9 client size showing centered symmetric bars;
- Help modal at a larger client size;
- Level 4 open-result state at a larger client size;
- maximize or runtime resize evidence showing unchanged logical state;
- evidence index with commands, timestamps, client sizes, measured content rectangles, files, and hashes.

The exact test sizes may be adapted to Windows decoration constraints, but report actual **client** dimensions and do not confuse them with screenshot/outer-window dimensions.

Do not stage screenshots, raw logs, `.godot/`, imports, or external evidence.

## 10. Report

Create:

```text
docs/reports/0011R_PHYSICAL_WINDOW_FILL_REPAIR_REPORT.md
```

Include:

- task and Git facts;
- exact root-cause diagnosis;
- before/after client and content rectangles;
- exact changed settings/files and why each was necessary;
- scaling/centering implementation approach;
- exact and non-16:9 behavior;
- route/overlay consistency;
- resize-state invariants;
- baseline/final markers, hashes, and metrics;
- external evidence index;
- rollback procedure;
- protected surfaces and non-claims;
- recommendation for owner retest.

Do not claim that the owner has approved the repair.

## 11. Git discipline

Before staging:

```powershell
git status --short --untracked-files=all
git diff --check
git diff --stat
```

Audit:

- only the explicitly selected authorized paths changed;
- no puzzle/content/catalog/progress change;
- no logical `1280×720` migration;
- no fake background-only fix;
- no asset/audio/narrative/Level 6/Gate work;
- no external evidence staged;
- no secret/private data;
- links resolve.

Stage explicit paths only. Never use broad staging.

Then:

```powershell
git diff --cached --check
git diff --cached --stat
git diff --cached --name-only
```

This task authorizes exactly one implementation/documentation commit:

```text
fix: scale and center Delayed Self window content
```

Immediately before push:

```powershell
git fetch origin
git rev-parse HEAD
git rev-parse origin/main
git status --short --untracked-files=all
```

Stop on remote drift. Do not merge, rebase, amend, force-push, or create a second implementation commit.

## 12. Terminal verdicts

Use exactly one:

- `PASS_FOR_GPT_REVIEW`;
- `BLOCKED_WINDOW_FILL_ROOT_CAUSE_UNRESOLVED`;
- `BLOCKED_WINDOW_FILL_REQUIRES_BROADER_MIGRATION`;
- `BLOCKED_BASELINE_REGRESSION`;
- `BLOCKED`.

No terminal verdict is final GPT acceptance or owner approval.

## 13. Next gate

After GPT accepts Task 0011R, require a short authenticated-owner window-fill retest. If the physical-window P2 is resolved with no P0/P1, the next content-development task must be the planned difficult Level 6 `staggered_doors` rather than another tutorial-level puzzle.

Level 6 remains separately gated and must target:

- one delay-3 Echo;
- two Plates and two mechanically distinct combinational Door windows;
- `L*=15–21` without rewriting the band after solving;
- at least three meaningful decision points;
- dependency necessity, no-Echo, bypass, two timing traces, replay/restart, and human evidence;
- rejection if it is solvable by one repeated pattern or mere trial-and-error.
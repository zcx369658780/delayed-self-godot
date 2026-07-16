# Task 0011RV — Short owner window-fill retest

- Status: `READY`
- Gate: `HUMAN EVIDENCE / OWNER WINDOW-FILL RETEST`
- Repository: `zcx369658780/delayed-self-godot`
- Expected branch: `main`
- Expected local root: `D:\Delayed_Self`
- Issued by: GPT Project Sources advisor
- Date: 2026-07-16
- Prior accepted gate: `TASK_0011R_PHYSICAL_WINDOW_FILL_REPAIR_ACCEPTED_PENDING_OWNER_RETEST`
- Accepted implementation commit: `a07c4be075aaa5c57e9d48869392f29dadaaa1d5`
- Prior acceptance artifact: `docs/reports/0011R_GPT_FINAL_ACCEPTANCE.md`

## 1. Objective

Run a short documentation-only owner retest of the accepted physical-window fill, scaling, and centering repair.

Record the review exactly as:

```text
NOT_FRESH_NOT_BLIND_OWNER_WINDOW_FILL_RETEST
```

The retest is limited to confirming that the owner's physical game window now presents the accepted `960×540` logical canvas correctly. It does not repeat the five-level difficulty or tutorial review.

Verify:

1. normal AppRoot startup uses the expected client area;
2. maximizing or enlarging an exact-16:9 window scales the complete game presentation to fill the client;
3. a non-16:9 size centers the presentation with symmetric intentional black bars only on the necessary axis;
4. no native-size canvas remains anchored in the upper-left;
5. no right/bottom L-shaped gray remainder remains;
6. Main Menu, Level Select, one normal Gameplay screen, and modal Help all follow the same policy;
7. resize/maximize does not reset the route, level, turn, history, Help state, or input behavior;
8. no dropped, duplicated, reordered, or synthetic puzzle input occurs;
9. whether the remaining physical-window utilization concern is closed for the owner;
10. whether any P0/P1 or material P2 blocks the planned difficult Level 6.

## 2. Claims and next-gate boundary

A positive retest may support GPT authorization of Level 6 `staggered_doors` when:

- P0=0 and P1=0;
- the upper-left native-size/L-shaped remainder defect is no longer visible;
- exact-16:9 enlargement fills correctly;
- non-16:9 bars are centered and acceptable;
- resize does not disturb state or input;
- all accepted regression markers, metrics, and hashes remain unchanged;
- no implementation or test path changes during this task.

A positive result does not establish final responsive layout, final art, asset/font clearance, accessibility, localization, fresh-player review, candidate acceptance, save, export, release, or submission readiness.

## 3. Implementation freeze

This task is documentation-only. Do not modify:

- `project.godot`;
- `scripts/`;
- `scenes/`;
- `data/levels/`;
- `data/catalog/`;
- `schemas/`;
- `tests/`;
- assets, fonts, imports, audio, music, or SFX;
- AppRoot, routing, catalog, progress, save, export, build, release, or repository settings;
- accepted contracts, fixtures, GDD, or project rules.

Any implementation defect must be recorded and returned for a separately authorized repair task.

## 4. Mandatory startup gate

Before any repository write:

```powershell
Get-Location
git branch --show-current
git rev-parse HEAD
git rev-parse origin/main
git remote -v
git status --short --untracked-files=all
git log -24 --oneline --decorate
godot --version
```

Required:

- root `D:\Delayed_Self`;
- branch `main`;
- expected origin;
- clean tracked worktree;
- local `HEAD` and `origin/main` contain this task and `docs/reports/0011R_GPT_FINAL_ACCEPTANCE.md`;
- Godot `4.7.stable`.

If local is behind and clean, use only:

```powershell
git fetch origin
git merge --ff-only origin/main
```

Stop on divergence, conflict, unexpected tracked changes, wrong remote/root, inability to fast-forward, or materially different toolchain.

## 5. Required reads

Read:

1. `AGENTS.md`;
2. current startup and active-task documents;
3. this task;
4. `docs/reports/0011R_GPT_FINAL_ACCEPTANCE.md`;
5. `docs/reports/0011R_PHYSICAL_WINDOW_FILL_REPAIR_REPORT.md`;
6. `docs/reviews/0011V_OWNER_PRESENTATION_AND_LEVEL4_RETEST.md`;
7. current evidence, privacy, Godot-safety, and independent-review rules.

Before launch, summarize:

- owner-review status and non-claims;
- documentation-only boundary;
- seven required markers;
- exact short launch/resize protocol;
- privacy rules;
- P0/P1/P2 classification;
- commit and stop rules.

## 6. Regression preflight

Run and require:

```text
TASK_0003_TESTS_PASS assertions=314 vectors=9
TASK_0006_APP_SHELL_TESTS_PASS
TASK_0007_TUTORIAL_LEVELS_TESTS_PASS
TASK_0008_PROGRESSIVE_HUD_TESTS_PASS
TASK_0009AR_LEVELS_4_5_TESTS_PASS
TASK_0011_PRESENTATION_RECOVERY_TESTS_PASS
TASK_0011R_WINDOW_FILL_TESTS_PASS
```

Require all five formal hashes, accepted level metrics, routes, unlock results, and simulation semantics unchanged.

Stop with:

```text
BLOCKED_BASELINE_REGRESSION
```

on any failure. Do not edit implementation or tests.

## 7. Short owner protocol

### 7.1 Launch

1. restart the Godot process;
2. launch normal AppRoot;
3. inspect Main Menu at the initial/default window size;
4. maximize or resize to a visibly larger exact or near-16:9 client;
5. open Level Select;
6. enter Tutorial 0 through the normal route;
7. open and close `H` Help;
8. while Gameplay or Help is visible, resize once to a wider or taller non-16:9 window and then return to a normal large 16:9 size;
9. submit at least one normal movement input after resize.

Tell the owner only:

```text
Please check the normal startup, maximize the game window, open Level Select, enter Tutorial 0, open and close H Help, then resize the window once to a non-16:9 shape. Confirm whether the game fills and centers correctly, whether any right/bottom L-shaped gray region remains, and whether resize affects state or input.
```

No movement route or puzzle guidance is needed or permitted.

### 7.2 Direct questions

Record direct answers:

1. At the larger 16:9 size, does the game content fill the client area?
2. Is the former right/bottom L-shaped gray remainder gone?
3. Is any logical content still anchored to the upper-left?
4. At a wide or tall size, are any bars symmetric and intentionally dark?
5. Do Main Menu, Level Select, Gameplay, and Help scale consistently?
6. Did resizing reset or change the route, level, turn, history, or Help state?
7. Did any input drop, duplicate, reorder, or trigger merely from resizing?
8. Does the physical-window utilization issue now feel resolved?
9. Is there any remaining material window-fill or centering problem?
10. May the project proceed to the planned harder Level 6?

Missing details are `NOT_PROVIDED`, never inferred.

## 8. Evidence and privacy

Authorized external root:

```text
D:\Delayed_Self_Evidence\0011RV_owner_window_fill_retest\
```

Allowed:

- bounded regression/launch logs;
- plain-text owner answers;
- deliberately approved game-window-only screenshots;
- evidence index with timestamps, sizes, and hashes.

Forbidden:

- automatic full-desktop capture;
- browser, notifications, email, credentials, or unrelated windows;
- raw keyboard monitoring outside the game;
- unnecessary personal information;
- committing external screenshots/logs or `.godot` data.

## 9. Finding classification

- `P0`: crash, launch/input failure, corrupted state, broken route/unlock, or regression;
- `P1`: content still cannot be used because scaling, centering, clipping, Help, or input is materially broken;
- `P2`: visible asymmetric remainder, significant wasted client area, inconsistent route scaling, unacceptable bars, or resize friction that does not block use;
- `P3`: preference or polish.

Gate outcomes:

- P0/P1: recommend Task 0011RR and block Level 6;
- no P0/P1 but material P2 remains: recommend focused follow-up and block Level 6 unless GPT explicitly accepts the risk;
- no P0/P1 and no material window-fill P2: recommend GPT acceptance and Level 6 `staggered_doors` authorization.

## 10. Authorized writes

Create only:

```text
docs/reviews/0011RV_OWNER_WINDOW_FILL_RETEST.md
docs/reports/0011RV_OWNER_WINDOW_FILL_RETEST_REPORT.md
```

Update only narrowly necessary current startup/task/index/plan/handoff/project-memory Markdown files.

The review must record:

- reviewer `authenticated_project_owner`;
- status `NOT_FRESH_NOT_BLIND_OWNER_WINDOW_FILL_RETEST`;
- exact implementation commit;
- regression markers and metrics;
- direct answers;
- P0–P3 counts;
- evidence index;
- non-claims;
- next-gate recommendation.

Do not modify any prior artifact.

## 11. Git discipline

Before staging:

```powershell
git status --short --untracked-files=all
git diff --check
git diff --stat
```

Audit authorized Markdown paths only. Stage explicit files only.

Use one documentation-only commit:

```text
docs: record Delayed Self owner window fill retest
```

Fetch and stop on remote drift. No amend, rebase, merge, force-push, broad staging, or second commit.

## 12. Terminal verdicts

Use exactly one:

- `READY_FOR_OWNER_WINDOW_FILL_RETEST`;
- `OWNER_WINDOW_FILL_RETEST_RECORDED_FOR_GPT_REVIEW`;
- `BLOCKED_BASELINE_REGRESSION`;
- `BLOCKED_OWNER_WINDOW_FILL_P0_P1`;
- `BLOCKED_OWNER_WINDOW_FILL_P2`;
- `BLOCKED`.

No terminal verdict is final GPT acceptance.

## 13. Next gate

A successful owner retest with no P0/P1 and no material remaining window-fill P2 recommends the next content gate:

```text
Level 6 — staggered_doors
```

It must be materially harder than Levels 1–5, target `L*=15–21`, contain two mechanically distinct Door windows, include at least three meaningful decision points, and fail if it is merely a long corridor, repeated pattern, or trial-and-error puzzle.
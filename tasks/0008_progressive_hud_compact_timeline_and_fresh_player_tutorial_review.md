# Task 0008 — Progressive HUD and owner-targeted Tutorial 0–1 retest

- Status: `PHASE_A_ACCEPTED_PHASE_B_READY`
- Gate: `HUMAN EVIDENCE / OWNER TARGETED TUTORIAL VERIFICATION`
- Repository: `zcx369658780/delayed-self-godot`
- Expected branch: `main`
- Expected local root: `D:\Delayed_Self`
- Issued by: GPT Project Sources advisor
- Revised date: 2026-07-15
- Accepted Phase A implementation: `3f35078b5d7e71db871140ca440c38069ea5d057`
- Phase A acceptance: `docs/reports/0008A_GPT_PHASE_A_ACCEPTANCE.md`
- Gate amendment: `docs/reports/0008B_GPT_OWNER_RETEST_GATE_AMENDMENT.md`
- Prior accepted gate: `TASK_0007_REUSABLE_GAMEPLAY_AND_TUTORIAL_LEVELS_ACCEPTED`

## 1. Revised objective

Phase A is complete and accepted. This execution performs a documentation-only, owner-targeted retest of the accepted progressive HUD across Tutorial 0 and Tutorial 1.

The authenticated project owner may serve as the reviewer because no qualifying fresh player is currently available. The review status must be recorded exactly as:

```text
NOT_FRESH_NOT_BLIND_OWNER_RETEST
```

This retest evaluates whether the accepted implementation is usable by the owner and whether any blocking runtime, tutorial-flow, HUD, timeline, help, completion, or information-density issue remains. It does not evaluate true first-time discoverability and cannot produce a `FRESH_PLAYER_REVIEWED` claim.

The retest must determine:

1. whether the normal AppRoot flow exposes Tutorial 0 first and unlocks Tutorial 1 correctly;
2. whether Tutorial 0 is uncluttered and its progressive control disclosure remains understandable;
3. whether Tutorial 1 clearly presents YOU, ECHO, delay 3, PLATE, DOOR, EXIT, and player-only completion;
4. whether the compact timeline and next-Echo pointer are readable and useful;
5. whether collapsed help can be restored without advancing a turn;
6. whether completion, restart, and return-to-selection behavior are correct;
7. whether the owner can complete both tutorials without receiving a movement sequence during this retest;
8. whether any P0/P1 issue remains before Task 0009 content production;
9. which P2/P3 observations should be carried into later fresh-player and complete-flow review.

## 2. Claims and gate boundary

A positive owner retest may support GPT authorization of Task 0009 when:

- both tutorials are completed without movement guidance during this retest;
- P0=0 and P1=0;
- the accepted automated regression remains unchanged;
- no implementation path changes during Phase B.

A positive owner retest does **not** establish:

- fresh-player or blind comprehension;
- independent review;
- closure of the information-density P2 for new players;
- `FRESH_PLAYER_REVIEWED` or `CANDIDATE_ACCEPTED` status;
- final tutorial, HUD, localization, accessibility, complete-flow, export, release, or submission readiness.

At least one qualifying fresh-player or independent review remains mandatory after the first four-level continuous sequence exists or, at the latest, before candidate acceptance.

## 3. Implementation freeze

This phase is documentation-only. Do not modify:

- `scripts/`;
- `scenes/`;
- `data/levels/`;
- `data/catalog/`;
- `schemas/`;
- `tests/`;
- `project.godot`;
- accepted contracts, fixtures, GDD, or project rules;
- save/player-data, export, build, release, account, or repository-setting surfaces.

Do not create a second implementation commit. If a P0/P1 requires source changes, record it and stop for a separately authorized repair task.

## 4. Mandatory startup gate

Before any repository write:

```powershell
Get-Location
git branch --show-current
git rev-parse HEAD
git rev-parse origin/main
git remote -v
git status --short --untracked-files=all
git log -16 --oneline --decorate
godot --version
```

Required conditions:

- absolute root is `D:\Delayed_Self`;
- branch is `main`;
- origin is the expected repository;
- local `HEAD` and `origin/main` contain the accepted Phase A commit, its GPT acceptance, this revised task, and the gate-amendment report;
- tracked worktree is clean;
- Godot resolves to accepted standard `4.7.stable`.

If local is behind and clean, use only:

```powershell
git fetch origin
git merge --ff-only origin/main
```

Stop on divergence, conflict, remote mismatch, unexpected tracked changes, unsafe root, missing governance artifacts, inability to fast-forward, or materially different toolchain.

## 5. Required reads

Read in this order:

1. `AGENTS.md`
2. `docs/CODEX_STARTUP_SNAPSHOT_CURRENT.md`
3. `docs/CODEX_ACTIVE_TASK_CURRENT.md`
4. this revised task
5. `docs/reports/0008B_GPT_OWNER_RETEST_GATE_AMENDMENT.md`
6. `docs/reports/0008A_GPT_PHASE_A_ACCEPTANCE.md`
7. `docs/reports/0008_PROGRESSIVE_HUD_AND_COMPACT_TIMELINE_IMPLEMENTATION_REPORT.md`
8. `docs/reports/0007_GPT_FINAL_ACCEPTANCE.md`
9. Tutorial 0 and Tutorial 1 validation records
10. `docs/game_design/TUTORIAL_AND_HUD_PROGRESSION_PLAN_CURRENT.md`
11. `docs/reports/0004V_GPT_FINAL_ACCEPTANCE.md`
12. current plan/index/handoff/project-memory documents
13. evidence/independent-review and Godot-safety project rules.

Before running anything, print a concise summary of:

- owner-review status and non-claims;
- source freeze;
- preflight markers;
- normal-flow launch protocol;
- Tutorial 0–1 questions;
- evidence/privacy rules;
- documentation-only commit policy;
- P0/P1 stop conditions;
- rescheduled fresh-player gate.

## 6. Preflight regression

Run the accepted repository-only suite and require all markers:

```text
TASK_0003_TESTS_PASS assertions=239 vectors=9
TASK_0006_APP_SHELL_TESTS_PASS
TASK_0007_TUTORIAL_LEVELS_TESTS_PASS
TASK_0008_PROGRESSIVE_HUD_TESTS_PASS
```

Record and require unchanged metrics:

- Tutorial 0: `L*=3`, `N*=3 (EXACT)`, 6 visited, frontier 2;
- Tutorial 1: `L*=9`, `N*=12 (EXACT)`, 1,975 visited, frontier 509;
- Tutorial 1 controlled no-Echo variant: complete unsolved, 10 visited;
- vertical slice: `L*=9`, `N*=31 (EXACT)`, 1,318 visited;
- vertical-slice Echo-isolated variant: complete unsolved, 1,006 visited.

If any marker or accepted metric fails, stop with:

```text
BLOCKED_BASELINE_REGRESSION
```

Do not edit implementation or tests in this phase.

## 7. External evidence and privacy

This phase authorizes creation/use of exactly:

```text
D:\Delayed_Self_Evidence\0008_owner_tutorial_retest\
```

First verify that any existing path is a safe directory with no conflicting unrelated evidence. Do not delete, move, rename, or overwrite unrelated files.

Allowed evidence:

- bounded preflight and launch logs;
- plain-text direct-answer and attempt record;
- deliberately supplied or approved game-window-only screenshots;
- evidence index with timestamps, filenames, and hashes.

Forbidden:

- automatic full-desktop capture;
- browser, email, notifications, credentials, unrelated windows/files;
- raw keyboard monitoring outside the game;
- staging screenshots, raw logs, or external evidence.

## 8. Owner retest protocol

### 8.1 Launch

1. restart the Godot process so in-memory progress resets;
2. launch the normal AppRoot flow, not a direct-level argument;
3. use Main Menu and Level Select normally;
4. begin Tutorial 0 from the initially unlocked state;
5. continue to Tutorial 1 only after Tutorial 0 completion unlocks it.

Codex may tell the owner only:

```text
Please replay Tutorial 0 and Tutorial 1 through the normal menu flow. Use only the controls and help shown in the game. Complete both levels without asking for a movement sequence. Say when you finish, give up, encounter a bug, or want a hint.
```

Codex must not provide a route, directional sequence, next move, or operational hint before each attempt ends. Existing owner knowledge must be acknowledged in the review, not disguised.

Any movement guidance during an attempt changes that attempt to `COMPLETED_ASSISTED`.

### 8.2 Tutorial 0 record

Record only directly observed or owner-reported facts:

- status: `COMPLETED_UNASSISTED`, `COMPLETED_ASSISTED`, `GAVE_UP`, `BLOCKED_BY_BUG`, or `INTERRUPTED`;
- final visible turn count;
- approximate elapsed time and restart count when supplied;
- whether Tutorial 1 unlocked after completion;
- whether YOU, EXIT, objective, movement, restart, completion, and Help were visible/usable;
- whether controls collapsed at a sensible time;
- whether `H` restored useful information without advancing a turn;
- clipping, clutter, or unresponsive-looking behavior;
- optional approved screenshot.

Ask after Tutorial 0:

1. Was Tutorial 0 visually simple enough, or did anything unnecessary remain?
2. Did the controls collapse too early, too late, or appropriately?
3. Was `H` Help discoverable and useful?
4. Was completion and unlock of Tutorial 1 clear?
5. What single change would most improve Tutorial 0?

### 8.3 Tutorial 1 record

Record:

- attempt and assistance status;
- final visible turn count;
- elapsed time/restarts when supplied;
- whether YOU/ECHO roles and player-only EXIT remained clear;
- whether delay 3 and the three timeline slots were understandable;
- whether the owner could use the pointer to identify one next Echo action;
- whether Echo-on-Plate and Door timing were understandable;
- whether legend/causality copy collapsed at appropriate events;
- whether expanded Help restored full information without changing the turn;
- information density, text size, clipping, and completion clarity;
- optional approved screenshot.

Ask after Tutorial 1:

1. Did the compact timeline make Echo's next action easier to read than the old History/Echo-next layout?
2. Which slot controlled the next Echo action, and was the pointer visually clear?
3. Did any legend or objective collapse before it was safe to remove?
4. Was the Plate/Door timing understandable during play?
5. Which information helped most, and which felt redundant?
6. Was `H` Help sufficient when information had collapsed?
7. Would you continue to the third level?
8. What single change would most improve Tutorial 1?

### 8.4 Ratings

Request optional 1–5 ratings for:

- entity distinction;
- objective clarity;
- control clarity;
- timeline/next-action usefulness;
- Plate/Door causality;
- information density;
- completion/unlock clarity;
- willingness to continue.

Missing answers, time, restarts, or ratings must be recorded as `NOT_PROVIDED`, never inferred.

## 9. Finding classification and gate logic

Classify conservatively:

- `P0`: crash, launch/input failure, corrupted state, impossible completion due to defect, regression, or broken unlock flow;
- `P1`: owner cannot identify victory/actors/timeline meaning/required progress, cannot restore needed help, or cannot complete without route guidance because of a material UX defect;
- `P2`: material friction, clutter, timing feedback, disclosure, help, or readability problem that does not block completion/core understanding;
- `P3`: polish, wording, preference, or future suggestion.

Separate:

- direct owner statements;
- observed runtime facts;
- Codex interpretation;
- unresolved uncertainty caused by the reviewer not being fresh.

Gate outcomes:

- any P0/P1: recommend `Task 0008R` and do not recommend Task 0009;
- no P0/P1 and both tutorials completed unassisted: recommend GPT acceptance of the owner-targeted verification and authorization of Task 0009;
- no P0/P1 but assisted/incomplete: recommend a narrower owner retest or focused copy/timeline review;
- all outcomes carry a later mandatory fresh/independent review before candidate acceptance.

## 10. Authorized repository writes

Create only:

```text
docs/reviews/0008_OWNER_TARGETED_TUTORIAL_0_1_RETEST.md
docs/reports/0008_OWNER_TARGETED_TUTORIAL_RETEST_REPORT.md
```

Update only as needed:

- `docs/CODEX_STARTUP_SNAPSHOT_CURRENT.md`;
- `docs/CODEX_ACTIVE_TASK_CURRENT.md`;
- `docs/DOC_INDEX_CURRENT.md`;
- `docs/DEVELOPMENT_PLAN_CURRENT.md`;
- `docs/HANDOFF_MASTER_CURRENT.md`;
- `docs/project_memory.md`.

The review document must contain:

- reviewer: `authenticated_project_owner`;
- status: `NOT_FRESH_NOT_BLIND_OWNER_RETEST`;
- exact Phase A implementation commit;
- environment and launch command;
- preflight markers and metrics;
- both attempt records;
- answers and ratings;
- P0–P3 findings;
- evidence index;
- explicit non-claims;
- later fresh-review requirement;
- recommended next gate.

The execution report must contain:

- terminal verdict;
- start/final Git facts;
- created/updated paths;
- finding counts;
- no-source-change confirmation;
- external evidence path;
- next-gate recommendation.

Do not modify any prior report or implementation artifact.

## 11. Validation and Git discipline

Before staging:

```powershell
git status --short --untracked-files=all
git diff --check
git diff --stat
```

Audit:

- only authorized Markdown paths changed;
- owner feedback is faithful and missing data is `NOT_PROVIDED`;
- no claim of fresh, blind, or independent review;
- no implementation or external evidence staged;
- no secrets or unnecessary personal data;
- links resolve;
- Task 0009 is only recommended, not self-authorized.

Stage explicit paths only. Never use broad staging.

Then run:

```powershell
git diff --cached --check
git diff --cached --stat
git diff --cached --name-only
```

This revised Phase B authorizes one documentation-only commit:

```text
docs: record Delayed Self owner tutorial retest
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

- `OWNER_TUTORIAL_RETEST_RECORDED_FOR_GPT_REVIEW`
- `READY_FOR_OWNER_TUTORIAL_RETEST`
- `BLOCKED_BASELINE_REGRESSION`
- `BLOCKED_OWNER_RETEST_P0_P1`
- `BLOCKED`

No terminal verdict is final GPT acceptance.

## 13. Next gate

- no P0/P1 plus both tutorials completed unassisted: recommend `Task 0009 — remaining schema-v1 candidate levels and validation matrix`;
- P0/P1: recommend `Task 0008R` focused repair;
- assisted/incomplete: recommend a narrower repeat retest;
- regardless of Task 0009 authorization, retain a mandatory fresh-player/independent review after the first four-level sequence or before candidate acceptance.

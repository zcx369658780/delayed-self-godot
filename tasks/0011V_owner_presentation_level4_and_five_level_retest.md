# Task 0011V — Owner presentation, Level 4 feedback, and five-level sequence retest

- Status: `READY`
- Gate: `HUMAN EVIDENCE / OWNER PRESENTATION RETEST`
- Repository: `zcx369658780/delayed-self-godot`
- Expected branch: `main`
- Expected local root: `D:\Delayed_Self`
- Issued by: GPT Project Sources advisor
- Date: 2026-07-16
- Prior accepted gate: `TASK_0011_PRIMITIVE_PRESENTATION_AND_DOOR_FEEDBACK_ACCEPTED_PENDING_OWNER_REVIEW`
- Accepted implementation commit: `c26d8be1c97dbe057f633b55ea7689f35272c577`
- Prior acceptance artifact: `docs/reports/0011_GPT_FINAL_ACCEPTANCE.md`

## 1. Objective

Run a documentation-only authenticated-owner review of the accepted primitive presentation recovery.

The review status must be recorded exactly as:

```text
NOT_FRESH_NOT_BLIND_OWNER_PRESENTATION_REVIEW
```

The owner has prior exposure to all five levels, their rules, and earlier UI versions. This review can evaluate whether the accepted presentation changes improved usability, but it cannot establish first-player discoverability, independent comprehension, or candidate acceptance.

The review must determine:

1. whether the five-level normal menu/unlock/return flow remains usable;
2. whether the effective board area now feels materially larger;
3. whether any board cell, actor, Door, Plate, EXIT, objective, status, Timeline, or controls overlap or clip;
4. whether the right rail is readable without dominating the board;
5. whether modal `H` Help is discoverable, readable, and useful without advancing a turn;
6. whether contextual Timeline behavior is appropriate across the five current levels;
7. whether Level 4 now makes the accepted closed-start/open-result/open-next-input rule observable;
8. whether Level 5's two-Plate AND relation remains clear through pips and dependency paths;
9. whether blocked Door, Echo replay, Plate press/release, Door open/close, and completion feedback are understandable using shape/text without audio;
10. whether any P0/P1 or material P2 blocks the first licensed visual/font slice;
11. which presentation findings must be carried into later asset, audio, difficulty, accessibility, and fresh-player gates.

## 2. Claims and gate boundary

A positive owner review may support GPT authorization of M3.2 provenance setup and one licensed visual/font slice when:

- all five levels remain reachable and completable through normal progression;
- Level 4 and Level 5 are completed without movement guidance during this review;
- P0=0 and P1=0;
- the owner reports that board size/readability is materially improved or at least no longer a blocking concern;
- Level 4's timing feedback is understandable enough to identify when the Door becomes usable;
- all accepted automated markers, hashes, and metrics remain unchanged;
- no implementation or test path changes during this task.

A positive review does **not** establish:

- fresh-player, blind, first-player, or independent comprehension;
- `FRESH_PLAYER_REVIEWED` or `CANDIDATE_ACCEPTED` for any level;
- final visual style, animation, audio, accessibility, localization, narrative, or complete-flow quality;
- license clearance or authority to import any researched asset;
- acceptance of a latched/one-shot Gate;
- permission to create Level 6;
- save, export, release, or submission readiness.

A qualifying fresh/independent human review remains mandatory before candidate acceptance.

## 3. Implementation freeze

This task is documentation-only.

Do not modify:

- `scripts/`;
- `scenes/`;
- `data/levels/`;
- `data/catalog/`;
- `schemas/`;
- `tests/`;
- `project.godot`;
- assets, fonts, imports, music, audio, or SFX;
- AppRoot, catalog loading, progress, Main Menu, Level Select, or Safe Error;
- accepted contracts, fixtures, GDD, or project rules;
- save/settings, export, build, release, account, or repository-setting surfaces.

Do not create an implementation commit. If a P0/P1 or blocking presentation defect requires source changes, record it faithfully and stop for a separately authorized repair task.

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

Required conditions:

- absolute root is `D:\Delayed_Self`;
- branch is `main`;
- origin is the expected repository;
- local `HEAD` and `origin/main` contain this task and `docs/reports/0011_GPT_FINAL_ACCEPTANCE.md`;
- tracked worktree is clean;
- Godot resolves to the accepted `4.7.stable` toolchain.

If local is behind and clean, use only:

```powershell
git fetch origin
git merge --ff-only origin/main
```

Stop on divergence, conflict, remote mismatch, unexpected tracked changes, unsafe root, missing governance artifacts, inability to fast-forward, or materially different toolchain.

## 5. Required reads

Read in this order:

1. `AGENTS.md`;
2. `docs/CODEX_STARTUP_SNAPSHOT_CURRENT.md`;
3. `docs/CODEX_ACTIVE_TASK_CURRENT.md`;
4. this task;
5. `docs/reports/0011_GPT_FINAL_ACCEPTANCE.md`;
6. `docs/reports/0011_PRIMITIVE_PRESENTATION_AND_DOOR_FEEDBACK_RECOVERY_REPORT.md`;
7. `docs/ux/PRESENTATION_VIEWPORT_AND_HUD_DIRECTION_CURRENT.md`;
8. `docs/ux/DOOR_PLATE_AND_ECHO_FEEDBACK_STORYBOARD.md`;
9. `docs/reports/0009AV_GPT_FINAL_ACCEPTANCE.md`;
10. `docs/reviews/0009AV_OWNER_FIVE_LEVEL_SEQUENCE_REVIEW.md`;
11. Level 4 and Level 5 validation records;
12. current five-entry catalog contract and catalog;
13. current startup/index/plan/handoff/project-memory documents;
14. evidence, independent-review, puzzle-validation, and Godot-safety rules.

Before running anything, print a concise summary of:

- owner-review status and non-claims;
- implementation/content/test freeze;
- accepted Task 0011 presentation changes;
- preflight markers and level metrics;
- normal-flow launch protocol;
- Level 4 timing-review protocol;
- Level 5 AND-review protocol;
- board/HUD/Help/Timeline questions;
- evidence/privacy rules;
- documentation-only commit policy;
- P0/P1 and blocking-P2 stop conditions;
- later fresh/independent review requirement.

## 6. Preflight regression

Run the accepted repository-only suite and require all markers:

```text
TASK_0003_TESTS_PASS assertions=301 vectors=9
TASK_0006_APP_SHELL_TESTS_PASS
TASK_0007_TUTORIAL_LEVELS_TESTS_PASS
TASK_0008_PROGRESSIVE_HUD_TESTS_PASS
TASK_0009AR_LEVELS_4_5_TESTS_PASS
TASK_0011_PRESENTATION_RECOVERY_TESTS_PASS
```

Record and require unchanged accepted metrics:

- Tutorial 0: `L*=3`, `N*=3 (EXACT)`, 6 visited, frontier 2;
- Tutorial 1: `L*=9`, `N*=12 (EXACT)`, 1,975 visited, frontier 509;
- Tutorial 1 no-Echo control: complete unsolved, 10 visited;
- Level 3: `L*=9`, `N*=31 (EXACT)`, 1,318 visited, frontier 393;
- Level 3 Echo-isolated control: complete unsolved, 1,006 visited;
- Level 4: `L*=9`, `N*=7 (EXACT)`, 291 visited, frontier 116;
- Level 4 no-Echo control: complete unsolved, 5 visited;
- Level 5: `L*=12`, `N*=1 (EXACT)`, 1,260 visited, frontier 225;
- Level 5 no-Echo control: complete unsolved, 8 visited.

Require all five formal SHA-256 values to match the accepted Task 0011 report.

If any marker, metric, hash, route, or unlock result fails, stop with:

```text
BLOCKED_BASELINE_REGRESSION
```

Do not edit implementation or tests.

## 7. External evidence and privacy

This task authorizes creation/use of exactly:

```text
D:\Delayed_Self_Evidence\0011V_owner_presentation_review\
```

First verify that any existing path is a safe directory with no conflicting unrelated evidence. Do not delete, move, rename, or overwrite unrelated files.

Allowed evidence:

- bounded preflight and launch logs;
- plain-text owner observations and direct answers;
- deliberately supplied or approved game-window-only screenshots;
- evidence index with timestamps, filenames, sizes, and hashes.

Forbidden:

- automatic full-desktop capture;
- browser, email, notifications, credentials, or unrelated windows/files;
- raw keyboard monitoring outside the game;
- unnecessary owner identity or personal information;
- staging screenshots, raw logs, `.godot` content, or external evidence.

## 8. Owner review protocol

### 8.1 Launch and assistance boundary

1. restart the Godot process so in-memory progress resets;
2. launch the normal AppRoot flow, not a direct-level argument;
3. use Main Menu and Level Select normally;
4. begin from Tutorial 0 and progress through Level 5;
5. do not expose solver witnesses, shortest-path data, validation traces, or route instructions before each attempt ends.

Tell the owner only:

```text
Please replay the current five-level sequence through the normal menu flow. Use only the information, Help, and Timeline shown in the game. Complete each level without asking for a movement sequence. Pay particular attention to board size, overlap, the Help modal, the Timeline, Level 4's Door timing feedback, and Level 5's two-Plate feedback. Say when you complete a level, give up, encounter a bug, or want a hint.
```

Codex must not provide a movement sequence, next move, route, or operational hint during an active attempt. Existing owner knowledge must be acknowledged, not disguised.

Any movement guidance changes the relevant attempt to `COMPLETED_ASSISTED`.

### 8.2 Per-level record

For each level, record only directly observed or owner-reported facts:

- status: `COMPLETED_UNASSISTED`, `COMPLETED_ASSISTED`, `GAVE_UP`, `BLOCKED_BY_BUG`, or `INTERRUPTED`;
- final visible turn count when supplied;
- approximate elapsed time and restart count when supplied;
- whether the next level unlocked correctly;
- whether completion and return to Level Select were clear;
- whether board cells or HUD surfaces overlapped or clipped;
- whether Help was opened and whether it advanced the visible turn;
- whether Timeline was visible, hidden, or used;
- optional approved game-window screenshot.

Missing measurements are `NOT_PROVIDED`, never inferred.

### 8.3 Presentation questions after the sequence

Ask:

1. Does the board now feel materially larger than before?
2. Does the game area feel appropriately sized relative to the window and right rail?
3. Did any controls, objective text, Timeline, Help affordance, or status text cover the board?
4. Was the right rail readable, too dense, too empty, or appropriately compact?
5. Was the `H` Help modal easy to discover, open, read, and close?
6. Did opening or closing Help appear to advance a turn or change the puzzle?
7. Was hiding the Timeline in simple standard levels preferable, or did information feel missing?
8. In Tutorial 1, was the always-visible guided Timeline understandable?
9. Did actor, Plate, Door, EXIT, and completion shapes remain distinct without relying on color?
10. Did movement or presentation feel delayed, dropped, duplicated, or unresponsive?

### 8.4 Level 4 timing questions

After Level 4 ends, ask:

1. When did the Door become usable: during the Plate-press transition, or on the next submitted input?
2. Did the `OPEN · NEXT INPUT` badge make that boundary clear?
3. Was the blocked-Door X/stop feedback understandable?
4. Did the Plate-to-Door dependency path or pulse help connect cause and effect?
5. Was the Door opening visible long enough to notice without making input feel slow?
6. Was the Door closing around or behind YOU understandable and non-threatening?
7. Did any feedback reveal a route rather than explain state?
8. Is Level 4 now pedagogically clearer than the prior version?

### 8.5 Level 5 AND questions

After Level 5 ends, ask:

1. Was it clear that both Plate dependency pips had to be active?
2. Could you visually connect each Plate to the Door?
3. Was the open AND state readable without prose-heavy explanation?
4. Did actor overlap, paths, pips, or effects become visually cluttered?
5. Did the presentation strengthen the already-understood two-actor causality?

### 8.6 Priority decision

Ask the owner to choose the next priority from these bounded options:

- `A`: proceed to provenance setup and one licensed visual/font slice;
- `B`: perform a focused primitive presentation repair first;
- `C`: pause presentation work and prioritize another accepted roadmap gate.

Record the choice and reasoning exactly. Do not convert it into implementation authority without GPT adjudication.

Optional 1–5 ratings may be requested for:

- board size;
- board/HUD balance;
- right-rail readability;
- Help usefulness;
- Timeline appropriateness;
- Level 4 timing clarity;
- Level 5 AND clarity;
- input responsiveness;
- overall presentation improvement;
- willingness to continue.

Missing ratings are `NOT_PROVIDED`.

## 9. Finding classification and gate logic

Classify conservatively:

- `P0`: crash, launch/input failure, corrupted state, impossible completion, broken unlock/return flow, or regression;
- `P1`: owner cannot identify actors/victory/required rule, cannot complete Level 4 or 5 without route guidance because of presentation, Help changes puzzle state, input is dropped/reordered, or important board content is unusable;
- `P2`: material board-size, overlap, clutter, timing, Help, Timeline, feedback, readability, or responsiveness friction that does not block completion/core comprehension;
- `P3`: polish, wording, preference, or future production suggestion.

Separate:

- direct owner statements;
- observed runtime facts;
- Codex interpretation;
- uncertainty caused by the reviewer not being fresh.

Gate outcomes:

- any P0/P1: recommend `Task 0011R`; do not recommend asset acquisition;
- no P0/P1 but board size or Level 4 clarity remains a material unresolved P2 and owner chooses `B`: recommend a focused Task 0011R presentation repair;
- no P0/P1, implementation is materially improved, and owner chooses `A`: recommend GPT acceptance of the owner review and M3.2 provenance plus one licensed visual/font slice;
- no P0/P1 and owner chooses `C`: record the alternative priority for GPT adjudication;
- all outcomes retain later mandatory fresh/independent review before candidate acceptance.

## 10. Authorized repository writes

Create only:

```text
docs/reviews/0011V_OWNER_PRESENTATION_AND_LEVEL4_RETEST.md
docs/reports/0011V_OWNER_PRESENTATION_REVIEW_REPORT.md
```

Update only as needed:

- `docs/CODEX_STARTUP_SNAPSHOT_CURRENT.md`;
- `docs/CODEX_ACTIVE_TASK_CURRENT.md`;
- `docs/DOC_INDEX_CURRENT.md`;
- `docs/DEVELOPMENT_PLAN_CURRENT.md`;
- `docs/HANDOFF_MASTER_CURRENT.md`;
- `docs/project_memory.md`.

The review document must include:

- reviewer: `authenticated_project_owner`;
- status: `NOT_FRESH_NOT_BLIND_OWNER_PRESENTATION_REVIEW`;
- exact accepted implementation commit;
- environment and launch command;
- preflight markers, hashes, and metrics;
- five attempt records;
- direct answers and optional ratings;
- owner priority choice;
- P0–P3 findings;
- evidence index;
- explicit non-claims;
- later fresh-review requirement;
- recommended next gate.

The execution report must include:

- terminal verdict;
- start/final Git facts;
- created/updated paths;
- attempt and finding counts;
- owner priority choice;
- no-source/scene/content/test-change confirmation;
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
- feedback is faithful and missing data is `NOT_PROVIDED`;
- no claim of fresh, blind, independent, final-art, license-cleared, or candidate review;
- no implementation, content, test, setting, asset, or external evidence is staged;
- no secrets or unnecessary personal data;
- links resolve;
- the next implementation task is only recommended, not self-authorized.

Stage explicit paths only. Never use broad staging.

Then run:

```powershell
git diff --cached --check
git diff --cached --stat
git diff --cached --name-only
```

This task authorizes one documentation-only commit:

```text
docs: record Delayed Self owner presentation review
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

- `OWNER_PRESENTATION_REVIEW_RECORDED_FOR_GPT_REVIEW`;
- `READY_FOR_OWNER_PRESENTATION_REVIEW`;
- `BLOCKED_BASELINE_REGRESSION`;
- `BLOCKED_OWNER_PRESENTATION_P0_P1`;
- `BLOCKED`.

No terminal verdict is final GPT acceptance.

## 13. Next gate

- positive review with owner priority `A`: recommend M3.2 provenance setup and one licensed visual/font slice;
- material unresolved presentation finding or owner priority `B`: recommend focused Task 0011R;
- owner priority `C`: recommend GPT choose the named alternative roadmap gate;
- a qualifying fresh/independent human review remains mandatory before candidate acceptance.
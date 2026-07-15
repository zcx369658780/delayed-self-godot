# Task 0009AV — Owner five-level sequence and HUD readability review

- Status: `READY`
- Gate: `HUMAN EVIDENCE / OWNER FIVE-LEVEL SEQUENCE REVIEW`
- Repository: `zcx369658780/delayed-self-godot`
- Expected branch: `main`
- Expected local root: `D:\Delayed_Self`
- Issued by: GPT Project Sources advisor
- Date: 2026-07-15
- Prior accepted gate: `TASK_0009AR_DOOR_TIMING_AND_AND_DOOR_LEVELS_ACCEPTED`
- Accepted implementation commit: `9516c44688d5416c154167e8be002a60de7ce327`
- Prior acceptance artifact: `docs/reports/0009AR_GPT_FINAL_ACCEPTANCE.md`

## 1. Objective

Run a documentation-only, authenticated-owner review of the complete current five-level sequence through the normal AppRoot/catalog flow.

The review status must be recorded exactly as:

```text
NOT_FRESH_NOT_BLIND_OWNER_SEQUENCE_REVIEW
```

The owner has prior exposure to the project, tutorials, simulation rules, and earlier vertical-slice play. Therefore this review cannot establish first-time discoverability, fresh-player comprehension, or independent acceptance.

The review must determine:

1. whether the normal menu, unlock, completion, and return-to-selection flow works across all five implemented levels;
2. whether difficulty and conceptual progression from Tutorial 0 through Level 5 feels coherent;
3. whether Level 4 communicates that the Door becomes usable on the following turn;
4. whether Level 5 communicates that YOU and ECHO must occupy two Plates simultaneously to open the AND Door;
5. whether the compact timeline remains understandable and useful as puzzles become less trivial;
6. whether `H` Help becomes more valuable in Levels 4–5 or remains redundant;
7. whether right-side HUD text crowding at 960×540 becomes materially worse in Levels 4–5;
8. whether any P0/P1 blocks the next bounded content batch;
9. which P2/P3 findings must be carried into later layout, accessibility, fresh-player, and complete-flow gates.

## 2. Claims and gate boundary

A positive owner sequence review may support GPT authorization of a later Task 0009B content/planning gate when:

- all five levels are reachable through normal progression;
- Levels 4 and 5 are completed without movement guidance during this review;
- P0=0 and P1=0;
- all accepted automated markers and level metrics remain unchanged;
- no implementation or test file changes during this task.

A positive review does **not** establish:

- fresh-player, blind, first-player, or independent comprehension;
- `FRESH_PLAYER_REVIEWED` or `CANDIDATE_ACCEPTED` for any level;
- closure of Help-utility or HUD-crowding P2 findings for new players;
- final difficulty balance, tutorial quality, HUD layout, viewport choice, accessibility, localization, complete flow, export, release, or submission readiness.

At least one qualifying fresh-player or independent review remains mandatory before candidate acceptance.

## 3. Implementation freeze

This task is documentation-only. Do not modify:

- `scripts/`;
- `scenes/`;
- `data/levels/`;
- `data/catalog/`;
- `schemas/`;
- `tests/`;
- `project.godot`;
- accepted contracts, fixtures, GDD, or project rules;
- save/player-data, export, build, release, account, or repository-setting surfaces.

Do not create an implementation commit. If a P0/P1 requires source or content changes, record the issue and stop for a separately authorized repair task.

## 4. Mandatory startup gate

Before any repository write:

```powershell
Get-Location
git branch --show-current
git rev-parse HEAD
git rev-parse origin/main
git remote -v
git status --short --untracked-files=all
git log -20 --oneline --decorate
godot --version
```

Required conditions:

- absolute root is `D:\Delayed_Self`;
- branch is `main`;
- origin is the expected repository;
- local `HEAD` and `origin/main` contain this task and `docs/reports/0009AR_GPT_FINAL_ACCEPTANCE.md`;
- tracked worktree is clean;
- Godot resolves to the accepted standard `4.7.stable` toolchain.

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
5. `docs/reports/0009AR_GPT_FINAL_ACCEPTANCE.md`;
6. `docs/reports/0009AR_DOOR_TIMING_AND_AND_DOOR_CONTENT_REPORT.md`;
7. `docs/level_design/validation/DOOR_ONE_TURN_LATE_VALIDATION.md`;
8. `docs/level_design/validation/TWO_KEYS_ONE_DOOR_VALIDATION.md`;
9. `docs/reports/0008_GPT_FINAL_ACCEPTANCE.md`;
10. `docs/reviews/0008_OWNER_TARGETED_TUTORIAL_0_1_RETEST.md`;
11. `docs/game_design/TUTORIAL_AND_HUD_PROGRESSION_PLAN_CURRENT.md`;
12. `docs/level_design/INITIAL_LEVEL_ROADMAP_AND_VALIDATION_MATRIX_CURRENT.md`;
13. current catalog contract and tracked five-entry catalog;
14. current startup/index/plan/handoff/project-memory documents;
15. evidence/independent-review, puzzle-validation, and Godot-safety project rules.

Before running anything, print a concise summary of:

- owner-review status and non-claims;
- source/content/test freeze;
- five accepted levels and metrics;
- normal-flow launch protocol;
- review questions for each section;
- evidence/privacy rules;
- documentation-only commit policy;
- P0/P1 stop conditions;
- later fresh/independent review requirement.

## 6. Preflight regression

Run the accepted repository-only suite and require all markers:

```text
TASK_0003_TESTS_PASS assertions=280 vectors=9
TASK_0006_APP_SHELL_TESTS_PASS
TASK_0007_TUTORIAL_LEVELS_TESTS_PASS
TASK_0008_PROGRESSIVE_HUD_TESTS_PASS
TASK_0009AR_LEVELS_4_5_TESTS_PASS
```

Record and require unchanged metrics:

- Tutorial 0: `L*=3`, `N*=3 (EXACT)`, 6 visited, frontier 2;
- Tutorial 1: `L*=9`, `N*=12 (EXACT)`, 1,975 visited, frontier 509;
- Tutorial 1 no-Echo controlled variant: complete unsolved, 10 visited;
- vertical slice: `L*=9`, `N*=31 (EXACT)`, 1,318 visited;
- vertical-slice Echo-isolated variant: complete unsolved, 1,006 visited;
- Level 4: `L*=9`, `N*=7 (EXACT)`, 291 visited, frontier 116;
- Level 4 no-Echo controlled variant: complete unsolved, 5 visited;
- Level 5: `L*=12`, `N*=1 (EXACT)`, 1,260 visited, frontier 225;
- Level 5 no-Echo controlled variant: complete unsolved, 8 visited.

If any marker or accepted metric fails, stop with:

```text
BLOCKED_BASELINE_REGRESSION
```

Do not edit implementation or tests.

## 7. External evidence and privacy

This task authorizes creation/use of exactly:

```text
D:\Delayed_Self_Evidence\0009AV_owner_five_level_review\
```

First verify that any existing path is a safe directory with no conflicting unrelated evidence. Do not delete, move, rename, or overwrite unrelated files.

Allowed evidence:

- bounded preflight and launch logs;
- plain-text owner observations and direct answers;
- deliberately supplied or approved game-window-only screenshots;
- evidence index with timestamps, filenames, and hashes.

Forbidden:

- automatic full-desktop capture;
- browser, email, notifications, credentials, unrelated windows/files;
- raw keyboard monitoring outside the game;
- staging screenshots, raw logs, or external evidence.

## 8. Owner sequence-review protocol

### 8.1 Launch and assistance boundary

1. restart the Godot process so in-memory progress resets;
2. launch normal AppRoot flow, not a development direct-level argument;
3. use Main Menu and Level Select normally;
4. begin from Tutorial 0 and progress through Level 5;
5. do not expose solver witnesses, `L*`, `N*`, validation traces, or route instructions before each level attempt ends.

Tell the owner only:

```text
Please replay the complete five-level sequence through the normal menu flow. Use only the controls, timeline, and Help shown in the game. Complete each level without asking for a movement sequence. Say when you complete a level, give up, encounter a bug, or want a hint. After Levels 4 and 5, explain what rule you think the level was testing.
```

Codex must not provide a movement sequence, next move, route, or operational hint during an active attempt. Existing owner knowledge must be acknowledged, not disguised.

Any movement guidance changes the relevant attempt to `COMPLETED_ASSISTED`.

### 8.2 Per-level attempt record

For each of the five levels, record only directly observed or owner-reported facts:

- status: `COMPLETED_UNASSISTED`, `COMPLETED_ASSISTED`, `GAVE_UP`, `BLOCKED_BY_BUG`, or `INTERRUPTED`;
- final visible turn count;
- approximate elapsed time and restart count when supplied;
- whether the next level unlocked correctly;
- whether completion and return-to-selection were clear;
- whether Help or expanded timeline was used;
- clipping, crowding, text-size, or unresponsive-looking behavior;
- optional approved screenshot.

Missing measurements must be `NOT_PROVIDED`, never inferred.

### 8.3 Sequence-level questions

After the five-level run, ask:

1. Did the difficulty rise appropriately from Tutorial 0 to Level 5, or were any jumps too small or too large?
2. At what level did the compact timeline first become genuinely useful?
3. Did `H` Help become useful in Levels 4–5, remain redundant, or add clutter?
4. Did right-side HUD crowding become worse in Levels 4–5? Which text was least useful?
5. Was Level 4’s intended rule understandable as “the Door opens for the following turn,” or did it feel arbitrary?
6. In Level 5, was it clear that YOU and ECHO had to occupy two different Plates at the same time?
7. Did either Level 4 or Level 5 feel solvable by trial and error without understanding its rule?
8. Was the five-level sequence too short, appropriately sized, or already repetitive?
9. Would you continue to additional levels?
10. What single change should be prioritized before adding more content?

Request optional 1–5 ratings for:

- overall difficulty progression;
- entity distinction;
- objective clarity;
- timeline usefulness;
- Door-timing clarity;
- AND-Plate causality;
- Help usefulness;
- information density/readability;
- completion/unlock clarity;
- willingness to continue.

Missing answers or ratings are `NOT_PROVIDED`.

## 9. Finding classification and gate logic

Classify conservatively:

- `P0`: crash, launch/input failure, corrupted state, impossible completion due to defect, broken unlock flow, regression;
- `P1`: owner cannot identify victory/actors/required rule, cannot complete Level 4 or 5 without route guidance due to a material UX defect, or cannot restore needed information;
- `P2`: material friction, difficulty spike, clutter, weak timing feedback, timeline/help/readability problem that does not block core comprehension or completion;
- `P3`: polish, wording, preference, or future suggestion.

Separate:

- direct owner statements;
- observed runtime facts;
- Codex interpretation;
- unresolved uncertainty caused by the reviewer not being fresh.

Gate outcomes:

- any P0/P1: recommend a focused repair task and do not recommend further content production;
- no P0/P1 and all five levels completed unassisted: recommend GPT acceptance of the owner sequence review and a next bounded Task 0009B gate;
- no P0/P1 but assisted/incomplete: recommend a narrower repeat or focused rule/copy/layout review;
- all outcomes retain the later mandatory fresh/independent review before candidate acceptance.

## 10. Authorized repository writes

Create only:

```text
docs/reviews/0009AV_OWNER_FIVE_LEVEL_SEQUENCE_REVIEW.md
docs/reports/0009AV_OWNER_FIVE_LEVEL_SEQUENCE_REVIEW_REPORT.md
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
- status: `NOT_FRESH_NOT_BLIND_OWNER_SEQUENCE_REVIEW`;
- exact accepted implementation commit;
- environment and launch command;
- preflight markers and metrics;
- five attempt records;
- direct answers and optional ratings;
- P0–P3 findings;
- evidence index;
- explicit non-claims;
- later fresh-review requirement;
- recommended next gate.

The execution report must contain:

- terminal verdict;
- start/final Git facts;
- created/updated paths;
- attempt and finding counts;
- no-source/content/test-change confirmation;
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
- no claim of fresh, blind, independent, or candidate review;
- no implementation, content, test, or external evidence staged;
- no secrets or unnecessary personal data;
- links resolve;
- the next content task is only recommended, not self-authorized.

Stage explicit paths only. Never use broad staging.

Then run:

```powershell
git diff --cached --check
git diff --cached --stat
git diff --cached --name-only
```

This task authorizes one documentation-only commit:

```text
docs: record Delayed Self five-level owner sequence review
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

- `OWNER_FIVE_LEVEL_SEQUENCE_REVIEW_RECORDED_FOR_GPT_REVIEW`;
- `READY_FOR_OWNER_FIVE_LEVEL_SEQUENCE_REVIEW`;
- `BLOCKED_BASELINE_REGRESSION`;
- `BLOCKED_OWNER_SEQUENCE_P0_P1`;
- `BLOCKED`.

No terminal verdict is final GPT acceptance.

## 13. Next gate

- no P0/P1 plus all five levels completed unassisted: recommend a bounded `Task 0009B` for the remaining candidate-content plan or next small content batch;
- P0/P1: recommend a focused repair task;
- assisted/incomplete without P0/P1: recommend a narrower repeat/review;
- a qualifying fresh/independent human review remains mandatory before candidate acceptance.
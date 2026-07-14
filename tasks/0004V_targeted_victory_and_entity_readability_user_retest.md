# Task 0004V — Targeted victory-condition and entity-readability user retest

- Status: `READY`
- Gate: `MANUAL EVIDENCE / TARGETED REPAIR VERIFICATION`
- Repository: `zcx369658780/delayed-self-godot`
- Expected branch: `main`
- Expected local root: `D:\Delayed_Self`
- Issued by: GPT Project Sources advisor
- Date: 2026-07-14
- Repaired implementation commit: `caeff311fda77b0261a7d78672afb9244ff23549`
- Repair acceptance: `docs/reports/0004R_GPT_FINAL_ACCEPTANCE.md`
- Original user evidence: `docs/reviews/0004_GPT_FIRST_PLAYER_EVIDENCE_ADJUDICATION.md`

## 1. Objective

Conduct and record a targeted human retest of the accepted Task 0004R presentation repair. The authenticated user must verify the repaired screen in actual play and attempt to complete the puzzle without being given a movement sequence.

This is not a new blind first-player test: the user already learned the intended player/echo roles during the prior adjudication. The task therefore evaluates whether the repair is visible, accurate, usable, and sufficient for the user to complete the current puzzle—not whether a completely fresh player would independently infer the mechanic.

The retest must determine:

1. whether `YOU`, `ECHO`, `PLATE`, `DOOR`, and `EXIT` are now unmistakably identified;
2. whether the objective clearly states that only `YOU` completes the level;
3. whether the user understands the intended role causality: ECHO holds PLATE, YOU crosses DOOR;
4. whether the EXIT remains visible when ECHO occupies the same cell;
5. whether `Echo next: <ACTION>` and the history queue are understandable and useful;
6. whether the user can complete the puzzle without a disclosed movement route;
7. whether completion feedback is visible and unambiguous;
8. whether any P0/P1 issue remains before system-skeleton/tutorial-level planning.

## 2. Mandatory startup gate

Before any repository write:

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

- absolute root is `D:\Delayed_Self`;
- branch is `main`;
- origin is the expected repository;
- local `HEAD` and `origin/main` contain this task and `docs/reports/0004R_GPT_FINAL_ACCEPTANCE.md`;
- tracked worktree is clean;
- the accepted standard Godot `4.7.stable` executable is available.

If local is behind and clean, use only:

```powershell
git fetch origin
git merge --ff-only origin/main
```

Stop on divergence, conflict, remote mismatch, unexpected tracked changes, unsafe root, missing task/acceptance, or materially different Godot/toolchain.

## 3. Required reads

Read in this order:

1. `AGENTS.md`
2. `docs/CODEX_STARTUP_SNAPSHOT_CURRENT.md`
3. `docs/CODEX_ACTIVE_TASK_CURRENT.md`
4. this task
5. `docs/reports/0004R_GPT_FINAL_ACCEPTANCE.md`
6. `docs/reports/0004R_EXIT_OBJECTIVE_AND_ECHO_READABILITY_REPAIR_REPORT.md`
7. `docs/reviews/0004_GPT_FIRST_PLAYER_EVIDENCE_ADJUDICATION.md`
8. `docs/reviews/0004_FIRST_PLAYER_UX_AND_VISUAL_READABILITY_REVIEW.md`
9. `docs/reports/0003_GPT_FINAL_ACCEPTANCE.md`
10. `docs/game_design/GAMEPLAY_SIMULATION_CONTRACT_CURRENT.md`
11. `docs/level_design/LEVEL_SCHEMA_V1_CURRENT.md`
12. `docs/project_rules/PROJECT_RULE_EVIDENCE_AND_INDEPENDENT_REVIEW_CURRENT.md`
13. current plan, handoff, and project-memory documents.

Before running anything, print a concise summary of the targeted-retake boundary, source freeze, allowed evidence, launch protocol, user questions, privacy rules, commit policy, and stop conditions.

## 4. Human-review boundary

The authenticated user is the repair-verification reviewer.

Codex may:

- run the accepted automated regression;
- launch the repaired game;
- ask the user to restart from the initial state;
- ask the targeted questions below;
- record the user's direct answers, completion status, turn count, and screenshots;
- classify remaining issues conservatively.

Codex must not:

- claim this is a blind first-player review;
- provide the nine-turn shortest sequence or any movement sequence before the attempt ends;
- tell the user where to move next;
- answer subjective questions for the user;
- convert the repair report or automated tests into user feedback;
- modify source, scene, level, project settings, controls, copy, layout, tests, or visuals in this task.

If the user asks for a movement hint, classify the attempt as `ASSISTED` and preserve observations before assistance. Assistance after classification is allowed, but the result cannot be called an unassisted completion.

## 5. External evidence directory

This task authorizes creation/use of exactly:

```text
D:\Delayed_Self_Evidence\0004V_user_retest\
```

First confirm that any existing path is a safe directory with no conflicting unrelated evidence. Do not delete, move, rename, or overwrite unrelated files.

Allowed evidence:

- bounded regression and launch logs;
- plain-text attempt/answer record;
- game-window-only screenshots deliberately supplied or approved by the user;
- concise evidence index with timestamps and hashes.

Privacy rules:

- do not capture the entire desktop automatically;
- do not capture browser, email, notifications, credentials, unrelated windows, or personal files;
- do not record raw keyboard activity outside the game;
- do not stage screenshots, raw logs, or external evidence.

## 6. Preflight regression

Before the retest, run the accepted repository-only Godot suite and require:

```text
TASK_0003_TESTS_PASS assertions=135 vectors=9
```

Also record and require the unchanged solver/mechanic summaries:

- `SOLVED`;
- `L*=9`;
- `N*=31 (EXACT)`;
- 1,318 visited states for the accepted level;
- echo-isolated variant `UNSOLVABLE_WITHIN_COMPLETE_FINITE_STATE` with 1,006 visited states.

If the regression or required summary fails, stop with `BLOCKED_REGRESSION_BEFORE_RETEST`. Do not edit code or fixtures in this task.

## 7. Retest protocol

### 7.1 Launch and clean restart

Launch the existing repaired main scene in a normal window without source changes. Ask the user to press `R` once before beginning so the retest starts from the exact initial state.

Tell the user only:

```text
Please replay the repaired vertical slice from the initial state. Read the on-screen objective and legend, use the history and Echo next display as needed, and try to complete the level without asking for a movement sequence. Say when you complete it, give up, encounter a bug, or want a hint.
```

Do not mention `L*=9`, `N*=31`, or the solver route before the attempt ends.

### 7.2 Attempt record

Record only what is directly observable or reported:

- status: `COMPLETED_UNASSISTED`, `COMPLETED_ASSISTED`, `GAVE_UP`, `BLOCKED_BY_BUG`, or `INTERRUPTED`;
- approximate elapsed time if the user can supply it;
- final turn count visible in the game;
- restart count if known;
- whether a hint was requested;
- any point where the UI or game appeared misleading/unresponsive;
- whether the completion overlay appeared;
- screenshots deliberately supplied/approved by the user.

Do not infer missing measurements.

## 8. Targeted questions

After the attempt, ask and record the user's answers faithfully:

1. What does `Y`/white-cyan represent, and what does `E`/purple represent?
2. What is the exact victory condition shown on screen?
3. Which actor must hold the plate, and which actor must cross the door?
4. When ECHO stands on EXIT, can you still identify the EXIT tile and the occupying actor separately?
5. Does `Echo next: <ACTION>` correctly help you predict the next echo move? Give one moment when it helped or confused you.
6. Is the oldest-to-newest history queue still useful alongside `Echo next`, or is it redundant/confusing?
7. Did you complete the puzzle without a movement hint? What was the final turn count?
8. Was the completion message clearly visible and did it make clear that YOU reached EXIT?
9. Is any text clipped, overcrowded, too small, or difficult to associate with the board?
10. What remaining single change would most improve this screen?

Ask for 1–5 ratings:

- entity distinction (`YOU/ECHO/EXIT`);
- objective clarity;
- role-causality clarity;
- next-echo-action usefulness;
- completion feedback;
- willingness to play another level.

Missing answers or ratings must be recorded as `NOT_PROVIDED`, never invented.

## 9. Finding classification and gate logic

Classify findings:

- `P0`: crash, launch/input failure, impossible completion due to defect, state corruption, or regression;
- `P1`: user still cannot identify victory condition, roles, exit, or required progress without a movement solution;
- `P2`: material readability/friction issue that does not block completion or core understanding;
- `P3`: polish or preference.

Separate:

- direct user statements;
- observed runtime facts;
- Codex interpretation;
- unresolved uncertainty.

Gate outcomes:

- any P0/P1 → recommend a separate `Task 0004R2` repair;
- no P0/P1 and completed unassisted → recommend GPT acceptance of the targeted repair verification and `Task 0005` system-skeleton/tutorial-level planning;
- no P0/P1 but assisted/incomplete → recommend a narrower repeat retest or tutorial-copy review;
- positive same-user retest does not eliminate the later need for at least one fresh-player/independent review before final tutorial/content acceptance.

## 10. Authorized repository writes

Only after the user completes or ends the retest, create:

- `docs/reviews/0004V_TARGETED_VICTORY_AND_ENTITY_READABILITY_USER_RETEST.md`
- `docs/reports/0004V_TARGETED_USER_RETEST_REPORT.md`

Update only as needed:

- `docs/CODEX_STARTUP_SNAPSHOT_CURRENT.md`
- `docs/CODEX_ACTIVE_TASK_CURRENT.md`
- `docs/DOC_INDEX_CURRENT.md`
- `docs/DEVELOPMENT_PLAN_CURRENT.md`
- `docs/HANDOFF_MASTER_CURRENT.md`
- `docs/project_memory.md`

The review must contain:

- reviewer role and explicit `NOT_BLIND_FIRST_PLAYER` status;
- repaired commit reviewed;
- environment and launch command;
- preflight result;
- attempt status and supplied measurements;
- answers to all ten questions;
- six ratings;
- P0/P1/P2/P3 findings;
- optional screenshot/evidence index;
- explicit non-claims;
- recommended next gate.

The execution report must contain:

- terminal verdict;
- task/start/final Git facts;
- preflight result;
- whether the user completed the retest;
- finding counts;
- created/updated paths;
- evidence-directory use;
- confirmation that no source/runtime file changed;
- recommended next gate.

If the user is not available or does not finish the retest, do not fabricate a review and do not commit. Return `READY_FOR_TARGETED_USER_RETEST`.

## 11. Forbidden repository changes

Do not modify:

- `project.godot`;
- any file under `scripts/`, `scenes/`, `data/`, `schemas/`, or `tests/`;
- simulation contracts, level schema, fixtures, GDD, or project rules;
- prior task, review, report, or acceptance artifacts;
- licenses, export presets, builds, saves, plugins, dependencies, or release files.

No hint system, undo, animation, audio, new level, menu, settings, save, export, Web, asset import, or implementation fix is authorized.

## 12. Validation and Git discipline

Before staging:

```powershell
git status --short --untracked-files=all
git diff --check
git diff --stat
```

Review for:

- only authorized Markdown paths changed;
- no source/runtime modification;
- direct user evidence accurately recorded;
- no invented timings, counts, ratings, or quotations;
- same-user retest clearly distinguished from fresh-player review;
- no solver route exposed in the pre-attempt record;
- no screenshots/raw logs staged;
- no personal/private data;
- current links resolve;
- no export/release/readiness overclaim.

Stage authorized Markdown paths explicitly; never use broad staging.

Then run:

```powershell
git diff --cached --check
git diff --cached --stat
git diff --cached --name-only
```

## 13. Commit and push authorization

After a recorded retest and successful validation, this task authorizes one documentation-only commit on `main` and one normal push.

Required commit message:

```text
docs: record Delayed Self targeted UX retest
```

Immediately before push:

```powershell
git fetch origin
git rev-parse HEAD
git rev-parse origin/main
git status --short --untracked-files=all
```

If the remote moved after task start, stop. Do not merge, rebase, amend, force-push, overwrite, or create a second commit without new authorization.

## 14. Terminal verdicts

Use exactly one:

- `TARGETED_USER_RETEST_RECORDED_FOR_GPT_REVIEW`
- `READY_FOR_TARGETED_USER_RETEST`
- `BLOCKED_REGRESSION_BEFORE_RETEST`
- `BLOCKED`

Do not use `PASS_FOR_GPT_REVIEW`; this task records human evidence rather than self-accepting UX.

## 15. Next gate recommendations

Recommend exactly one:

- `Task 0004R2` — remaining P0/P1 repair;
- a narrower repeat retest/tutorial-copy review if no P0/P1 but completion evidence is insufficient;
- `Task 0005` — system-skeleton and tutorial-level planning when no P0/P1 remains and GPT accepts an unassisted targeted completion.

Export and public release remain separate later gates.

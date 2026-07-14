# Task 0004 — First-player UX and visual-readability review

- Status: `READY`
- Gate: `MANUAL EVIDENCE / FIRST-PLAYER REVIEW`
- Repository: `zcx369658780/delayed-self-godot`
- Expected branch: `main`
- Expected local root: `D:\Delayed_Self`
- Issued by: GPT Project Sources advisor
- Date: 2026-07-14
- Prior accepted gate: `TASK_0003_MINIMAL_VERTICAL_SLICE_ACCEPTED_WITH_OBSERVATIONS`
- Prior accepted implementation commit: `14180dc3e110607d4abdee5f8bf314a58f62fb39`
- Prior acceptance artifact: `docs/reports/0003_GPT_FINAL_ACCEPTANCE.md`

## 1. Objective

Conduct and record the first genuine user playthrough of the accepted vertical slice, focusing on whether a player can understand and use the delayed-echo mechanic from the current screen, controls, and feedback.

This task is an evidence and documentation gate, not an implementation task. Codex must facilitate and record the user's experience but must not impersonate a first-time player, answer the review questions for the user, reveal the solver route before the first attempt, or modify the game to pre-empt feedback.

The review must determine:

1. whether the player distinguishes the current player from the delayed echo;
2. whether the player understands that current inputs are replayed three turns later;
3. whether the history queue and next echo action are legible enough to plan;
4. whether pressure-plate and next-turn door timing are understandable;
5. whether controls, restart, completion, and objective feedback are discoverable;
6. whether the puzzle can be completed without solver disclosure;
7. which issues require a focused UX repair task before more levels are produced.

## 2. Mandatory startup gate

Before any repository write:

```powershell
Get-Location
git branch --show-current
git rev-parse HEAD
git rev-parse origin/main
git remote -v
git status --short --untracked-files=all
git log -8 --oneline --decorate
```

Required conditions:

- absolute root is `D:\Delayed_Self`;
- branch is `main`;
- origin is the expected repository;
- local `HEAD` and `origin/main` contain this task and `docs/reports/0003_GPT_FINAL_ACCEPTANCE.md`;
- tracked worktree is clean;
- the accepted Godot 4.7 stable executable is available.

If local is behind and clean, use only:

```powershell
git fetch origin
git merge --ff-only origin/main
```

Stop on divergence, conflict, remote mismatch, unexpected tracked changes, unsafe root, missing acceptance/task, or a materially different Godot/toolchain.

## 3. Required reads

Read in this order:

1. `AGENTS.md`
2. `docs/CODEX_STARTUP_SNAPSHOT_CURRENT.md`
3. `docs/CODEX_ACTIVE_TASK_CURRENT.md`
4. this task file
5. `docs/reports/0003_GPT_FINAL_ACCEPTANCE.md`
6. `docs/reports/0003_MINIMAL_GODOT_VERTICAL_SLICE_AND_CONTRACT_CONFORMANCE_REPORT.md`
7. `docs/game_design/GAMEPLAY_SIMULATION_CONTRACT_CURRENT.md`
8. `docs/level_design/LEVEL_SCHEMA_V1_CURRENT.md`
9. `docs/game_design/DELAYED_SELF_GAME_DESIGN_DOCUMENT_CURRENT.md`
10. `docs/project_rules/PROJECT_RULE_EVIDENCE_AND_INDEPENDENT_REVIEW_CURRENT.md`
11. `docs/HANDOFF_MASTER_CURRENT.md`
12. `docs/project_memory.md`

Before running anything, print a concise summary of objective, human-review boundary, allowed writes, forbidden source changes, test/launch plan, privacy rules, evidence path, commit policy, and stop conditions.

## 4. Human-review boundary

The authenticated user is the first-player reviewer for this gate.

Codex already knows the contract and solver result and therefore cannot serve as a blind first player. Codex may:

- run preflight tests;
- launch the existing game;
- give only the controls already visible in the slice when necessary;
- ask the fixed questions below after the attempt;
- record the user's answers accurately;
- classify findings by severity;
- compare the observations with the accepted UX goals.

Codex must not:

- disclose the nine-turn solver route before the first attempt ends;
- tell the user where or when to move to solve the puzzle;
- answer subjective questions on the user's behalf;
- convert assumptions into user feedback;
- claim independent review;
- modify source, scene, level, project settings, controls, layout, copy, or visuals in this task.

If the user requests a hint or solution during the first attempt, record the attempt as `ASSISTED` and preserve what happened before assistance. Assistance is allowed after that classification, but the result must not be presented as unaided comprehension.

## 5. External evidence directory

This task authorizes creation and use of exactly:

```text
D:\Delayed_Self_Evidence\0004_first_player_review\
```

First verify that any existing path is a directory and contains no conflicting unrelated evidence. Do not delete, move, rename, or overwrite existing unrelated files.

Allowed external evidence:

- bounded test and launch logs;
- a plain-text playtest observation record;
- user-supplied screenshots of the game window only;
- a concise evidence index with filenames, timestamps, and hashes where useful.

Privacy rules:

- do not automatically capture the whole desktop;
- do not capture browser, email, credentials, notifications, unrelated windows, or personal files;
- screenshots are optional and must be deliberately supplied or approved by the user;
- do not commit screenshots, raw logs, or external evidence to Git;
- do not copy unrelated local files into evidence.

## 6. Preflight regression

Before the manual attempt, run the accepted Task 0003 headless suite using the installed Godot executable and require:

```text
TASK_0003_TESTS_PASS
```

Record the command, exit code, pass marker, assertion count, vector count, and solver summary in the external evidence log. If the suite fails, stop with `BLOCKED_REGRESSION_BEFORE_PLAYTEST`; do not conduct the UX review on an unaccepted runtime state.

Do not modify fixtures or code to make the test pass.

## 7. First-attempt protocol

### 7.1 Launch

Launch the existing main scene in a normal window with no source changes. Do not open the editor if direct project execution is sufficient.

Tell the user only:

```text
Please play the current vertical slice from its initial state. Use the controls shown in the game. Try to reach the exit without asking for the solution. Say when you finish, give up, encounter a bug, or want a hint.
```

Do not mention `L*=9`, `N*=31`, the solver route, the echo-isolated result, or the exact intended movement sequence before the attempt ends.

### 7.2 Attempt record

Record, to the extent safely observable or reported by the user:

- attempt status: `COMPLETED_UNASSISTED`, `COMPLETED_ASSISTED`, `GAVE_UP`, `BLOCKED_BY_BUG`, or `INTERRUPTED`;
- approximate elapsed time;
- final turn count shown by the game;
- restart count;
- whether a hint/solution was requested and when;
- first point of confusion;
- any runtime error or unexpected behavior;
- whether completion and restart feedback worked.

Do not install monitoring software or record keyboard input outside the game's own visible behavior.

## 8. Fixed post-attempt questions

After the first attempt ends, ask the user these questions without rewriting them into leading questions. Record the answers faithfully; brief clarification questions are allowed.

1. Before the echo first moved, what did you think the translucent/alternate character represented?
2. When did you realize that your moves would be repeated three turns later?
3. Could you tell which action the echo would perform next? Which part of the screen helped or failed to help?
4. Did you understand why the pressure plate changed the door, and that the new door state affected entry on the following turn?
5. Could you clearly distinguish the player, echo, wall, floor, plate, closed/open door, and exit without guessing?
6. Were the controls, wait action, restart action, objective, turn number, delay, and history queue readable and understandable?
7. Did you complete the puzzle without assistance? What caused the most wasted turns or restarts?
8. At any point did the game appear unresponsive even though it was following a blocked movement or delayed rule?
9. What single visual or textual cue would have helped most?
10. Was the core idea interesting enough that you would try another level? Why or why not?

Also ask the user to rate from 1 to 5:

- player/echo distinction;
- history/next-action readability;
- plate/door causality;
- objective clarity;
- control clarity;
- desire to play another level.

## 9. Finding classification

Classify findings conservatively:

- `P0`: crash, cannot launch, cannot complete due to runtime defect, input unavailable, state corruption, or contract regression;
- `P1`: a first player cannot understand the central delayed-echo mechanic, cannot distinguish required entities, or cannot identify how to progress without solver disclosure;
- `P2`: material friction, misleading feedback, weak hierarchy, poor legibility, missing cue, or unnecessary confusion that does not fully block comprehension;
- `P3`: polish, preference, wording, spacing, animation, or aesthetic suggestion.

Separate:

- directly reported user evidence;
- observed runtime facts;
- Codex interpretation;
- unresolved uncertainty.

Do not reinterpret negative feedback as a pass merely because the puzzle is solver-valid.

## 10. Authorized repository writes

Only after the user playtest has been completed and recorded, create:

- `docs/reviews/0004_FIRST_PLAYER_UX_AND_VISUAL_READABILITY_REVIEW.md`
- `docs/reports/0004_FIRST_PLAYER_UX_AND_VISUAL_READABILITY_REPORT.md`

Update only as needed:

- `docs/CODEX_STARTUP_SNAPSHOT_CURRENT.md`
- `docs/CODEX_ACTIVE_TASK_CURRENT.md`
- `docs/DOC_INDEX_CURRENT.md`
- `docs/HANDOFF_MASTER_CURRENT.md`
- `docs/project_memory.md`

The review document must contain:

- reviewer role: authenticated user, not Codex;
- build/source commit reviewed;
- environment and launch command;
- attempt classification and measurements;
- answers to all fixed questions;
- six numeric ratings;
- P0/P1/P2/P3 findings;
- screenshot/evidence index, if any;
- explicit non-claims;
- recommended repair scope.

The execution report must contain:

- task verdict;
- startup and regression results;
- paths created/updated;
- evidence-directory use;
- confirmation that no source/runtime file changed;
- whether the user completed the playtest;
- finding counts by severity;
- recommended next gate.

If the user is not available to complete the playtest, do not fabricate results and do not create a final review. Return `READY_FOR_USER_PLAYTEST` with no commit. A later execution of the same task may continue after a clean sync.

## 11. Forbidden repository changes

Do not modify:

- `project.godot`;
- any file under `scripts/`, `scenes/`, `data/`, `schemas/`, or `tests/`;
- the accepted simulation contract, level schema, vectors, or GDD;
- `AGENTS.md` or split project rules;
- third-party asset/license documents;
- export presets, builds, saves, plugins, or dependencies.

No menu, settings, audio, animation, new level, hint system, undo, export, Web work, asset import, or presentation fix is authorized in this task.

## 12. Validation

Before staging:

```powershell
git status --short --untracked-files=all
git diff --check
git diff --stat
```

Review for:

- exactly the authorized Markdown paths;
- faithful user quotations/paraphrases with no invented feedback;
- no private or unrelated personal information;
- clear separation of evidence and interpretation;
- no solver solution disclosed as part of the first-attempt record unless assistance occurred;
- no source/runtime changes;
- no screenshots or raw logs staged;
- current links resolve;
- no release/readiness overclaim.

Stage authorized Markdown files explicitly. Never use broad staging.

Then run:

```powershell
git diff --cached --check
git diff --cached --stat
git diff --cached --name-only
```

## 13. Commit and push authorization

After a completed user playtest and successful validation, this task authorizes one documentation-only commit on `main` and one normal push to `origin/main`.

Required commit message:

```text
docs: record Delayed Self first-player review
```

Immediately before push:

```powershell
git fetch origin
git rev-parse HEAD
git rev-parse origin/main
git status --short --untracked-files=all
```

If remote moved after the task began, stop. Do not merge, rebase, amend, force-push, overwrite, or create a second commit without a new instruction.

## 14. Terminal verdicts

Use exactly one:

- `USER_PLAYTEST_RECORDED_FOR_GPT_REVIEW`
- `READY_FOR_USER_PLAYTEST`
- `BLOCKED_REGRESSION_BEFORE_PLAYTEST`
- `BLOCKED`

Do not use `PASS_FOR_GPT_REVIEW`; this task records evidence rather than self-accepting player experience.

## 15. Next gate recommendation

After a recorded playtest, recommend exactly one:

- `Task 0004R` — focused UX/readability repair for any P0/P1 or selected P2 findings;
- `Task 0004V` — targeted independent visual review if the user review is positive but visual uncertainty remains;
- `Task 0005` — system-skeleton and tutorial-level planning only if there are no unresolved P0/P1 findings and GPT accepts the evidence.

Export remains a separate later gate and is not authorized by a positive playtest.

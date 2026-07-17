# Task 0015V — Authenticated-owner Level 7 comparison review

- Status: `READY`
- Gate: `HUMAN EVIDENCE / AUTHENTICATED OWNER LEVEL 7 REVIEW`
- Repository: `zcx369658780/delayed-self-godot`
- Expected branch: `main`
- Expected local root: `D:\Delayed_Self`
- Issued by: GPT Project Sources advisor
- Date: 2026-07-17
- Prior accepted gate: `TASK_0015_TWO_ECHO_CONVERGENCE_ACCEPTED_INTERNAL_PLAYABLE`
- Accepted implementation: `27a678da47d1ba34ed012f8840b8c80c775e8be1`
- Acceptance artifact: `docs/reports/0015_GPT_FINAL_ACCEPTANCE.md`
- Formal Level 7: `two_echo_convergence`
- Formal SHA-256: `772410d3b8bb807e35472ee2a7d07b703de66e1e0e92ffb4d1ff8433a345d5fd`

## 1. Objective

Conduct one authenticated-owner comparison review of Level 6 and Level 7, with Level 7 as the primary evidence target.

The review classification must be exactly:

```text
AUTHENTICATED_OWNER_NOT_FRESH_NOT_INDEPENDENT_LEVEL_7_REVIEW
```

The owner has prior exposure to the project, design discussions, implementation facts, and earlier levels. Do not disguise that exposure. This task evaluates owner product judgment and the current Level 7 experience; it does not recreate a fresh, blind, first-player, or independent session.

This task must determine:

1. whether accepted Level 7 runs and completes through the reusable Gameplay path;
2. whether Level 7 is clearly harder than Level 6 for reasons of two-delay reasoning rather than hidden state, corridor length, or UI confusion;
3. whether the owner distinguishes E2 and E4 and understands that both replay the same history at different offsets;
4. whether Plate A, Plate B, and the A+B Door relationship are readable without relying only on color;
5. whether the required two-ECHO convergence and following open-snapshot Door crossing are understandable during play;
6. whether E2/E4 identities remain readable during overlap;
7. whether the inherited status surface, Timeline, or Help clarifies, distracts, or misleads;
8. whether failures and recovery are understandable;
9. whether any P0/P1 requires repair before Level 8 planning;
10. whether the evidence supports preserving Level 7 and entering a bounded Level 8 planning gate.

This task is a human-evidence and documentation gate. It does not authorize Level 7 repair, Level 8, Timeline/Help redesign, assets, audio, narrative, animation, Gate, persistence, export, release, or submission work.

## 2. Durable owner-only boundary

The owner is the only available playtester. Therefore:

- do not seek, require, contact, recruit, or suggest a third-party reviewer;
- do not ask the owner to involve friends, colleagues, students, family, contractors, communities, or volunteers;
- do not label the owner session fresh, blind, first-player, or independent;
- preserve `FRESH_INDEPENDENT_REVIEW_UNAVAILABLE_BY_OWNER_CONSTRAINT` as a disclosed residual limitation;
- no later task may reintroduce third-party recruitment unless the owner explicitly reverses the constraint.

## 3. Claim boundary

A positive owner review may support GPT authorization of:

- preserving Level 7 as accepted internal content;
- a bounded Level 8 planning task;
- a separately bounded Level 7 presentation repair if material findings require one;
- continued internal content production.

It does not establish:

- `FRESH_PLAYER_REVIEWED`;
- `CANDIDATE_ACCEPTED`;
- population-level difficulty, fun, or balance;
- final Timeline or Help disposition;
- complete-flow, export, release, or submission readiness.

## 4. Mandatory startup gate

Before running Godot, using evidence, or launching the review:

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

- root exactly `D:\Delayed_Self`;
- branch `main`;
- expected origin;
- fully clean tracked and untracked worktree;
- local `HEAD == origin/main` and both contain this task and `docs/reports/0015_GPT_FINAL_ACCEPTANCE.md`;
- accepted Godot `4.7.stable.steam.5b4e0cb0f`, or the exact accepted executable recorded by the environment/current evidence.

If clean local `main` is behind, use only:

```powershell
git fetch origin
git merge --ff-only origin/main
```

Stop on divergence, conflict, unexpected files, wrong root/remote, inability to fast-forward, missing acceptance artifacts, or materially different toolchain.

## 5. Required reads

Read in order:

1. `AGENTS.md`;
2. `docs/CODEX_STARTUP_SNAPSHOT_CURRENT.md`;
3. `docs/CODEX_ACTIVE_TASK_CURRENT.md`;
4. this task;
5. `docs/reports/0015_GPT_FINAL_ACCEPTANCE.md`;
6. `docs/reports/0015_LEVEL_7_TWO_ECHO_CONVERGENCE_IMPLEMENTATION_REPORT.md`;
7. `docs/level_design/validation/TWO_ECHO_CONVERGENCE_VALIDATION.md`;
8. `docs/reviews/0013B_OWNER_TARGETED_LEVEL_6_REVIEW.md`;
9. `docs/reports/0013B_GPT_FINAL_ACCEPTANCE.md`;
10. `docs/level_design/LEVEL_7_TWO_ECHO_CONVERGENCE_PLAN_CURRENT.md`;
11. current catalog and accepted Level 6/7 formal files;
12. current evidence/privacy, Godot-safety, puzzle-validation, and owner-only review rules;
13. current index, plan, handoff, roadmap, and project memory.

Do not reveal solver witness, exact convergence turns, route, control matrix, or movement sequence to the owner before the Level 7 attempt ends. The owner may know project facts already, but Codex must not actively coach the attempt.

Before execution, print a concise operator summary covering:

- owner-review classification and non-claims;
- healthy accepted implementation baseline;
- Level 6-to-Level 7 comparison purpose;
- no-hint boundary;
- E2/E4, A/B, A+B, overlap, status, Timeline, and Help questions;
- source/content/test freeze;
- evidence/privacy boundary;
- documentation-only commit policy;
- P0/P1 stop rules and terminal verdicts.

## 6. Implementation and content freeze

Do not modify, regenerate, reimport, stage, commit, or otherwise alter:

- `project.godot`;
- `scripts/`;
- `scenes/`;
- `data/levels/`;
- `data/catalog/`;
- `schemas/`;
- `tests/`;
- fixtures;
- assets, fonts, audio, shaders, imports, plugins, or dependencies;
- gameplay, solver, simulation, UI, presentation, progression, or catalog behavior;
- Timeline model/layout/indexing;
- Help architecture/copy;
- save/player-data behavior;
- export, build, release, account, repository-setting, or submission surfaces;
- prior task, report, validation, acceptance, contract, GDD, or project-rule artifacts.

Do not fix a problem during the review. Record it and return it for a separately authorized task.

Do not delete or reset repository files, `.godot`, caches, prior evidence, settings, or user data. Do not use `git clean`, reset, broad restore, rebase, amend, or force-push.

## 7. Baseline verification

The accepted Task 0015 evidence may be reused rather than rerunning the aggregate suite only if all are verified:

- the indexed evidence exists under the accepted external root;
- command, executable, native exit, stdout/stderr hashes, nine markers, metrics, and six prior hashes are present and internally consistent;
- the implementation commit is exactly `27a678da47d1ba34ed012f8840b8c80c775e8be1`;
- subsequent commits contain only GPT acceptance and this task;
- no executable/formal/test path changed after implementation.

If any reuse requirement is missing or ambiguous, run the accepted aggregate suite once in a fresh native process with stdout/stderr separated and native exit preserved:

```powershell
godot --headless --path D:\Delayed_Self --script res://tests/run_all.gd
```

Use the exact accepted executable path when the `godot` alias is unavailable.

Require:

- native exit `0`;
- `TASK_0003_TESTS_PASS assertions=367 vectors=9`;
- all nine canonical markers exactly once, including `TASK_0015_LEVEL_7_TWO_ECHO_CONVERGENCE_TESTS_PASS`;
- Level 7 `L*=19`, `N*=6 EXACT`, visited `61975`, frontier `21449`;
- Level 7 SHA-256 unchanged;
- all six prior formal hashes and accepted metrics unchanged;
- stderr limited to the accepted intentional `LEVEL_ID_MISMATCH` negative path.

If baseline fails, do not launch the review. Stop with:

```text
BLOCKED_BASELINE_REGRESSION
```

## 8. External evidence and privacy

Authorized external root:

```text
D:\Delayed_Self_Evidence\0015V_owner_level_7_review\
```

First verify that the path is safe and does not contain unrelated evidence that would be overwritten. Never delete, move, rename, or replace unrelated files.

Allowed evidence:

- bounded baseline/reuse summary;
- exact launch commands and executable identity;
- plain-text owner observations and direct answers;
- per-level attempt records;
- owner-supplied timing, turn, restart, Timeline, and Help facts;
- deliberately approved game-window-only screenshots;
- evidence index with timestamps, sizes, and SHA-256 values.

Forbidden:

- automatic full-desktop capture;
- face or voice recording;
- browser, email, notifications, credentials, accounts, or unrelated windows/files;
- raw keyboard logging or hidden telemetry;
- personal identity details;
- staging screenshots, raw logs, recordings, or the external evidence directory.

Missing facts must be `NOT_PROVIDED`, never estimated or inferred.

## 9. Owner comparison protocol

### 9.1 Launch order

Use separate fresh native game processes:

1. launch Level 6 `staggered_doors` through the accepted direct-level route for a short comparison replay;
2. close only that project game process after the attempt;
3. launch Level 7 `two_echo_convergence` through the accepted direct-level route;
4. let the owner control the keyboard directly;
5. do not show source, console, reports, metrics, maps, validation traces, or evidence notes on the game screen.

Do not delete progress or user data. Direct-level review is authorized to avoid replaying the full onboarding sequence; it does not replace progression tests already accepted by Task 0015.

### 9.2 Assistance boundary

Before play, tell the owner only:

```text
Please replay Level 6 briefly, then play Level 7 without movement, route, timing, or puzzle hints. Use only the controls, board cues, Timeline, and Help available inside the game. Say when you complete a level, give up, encounter a bug, or choose to stop. After Level 7 I will ask how you interpreted E2, E4, A, B, and the Door.
```

Codex must not provide during an active Level 7 attempt:

- a movement sequence or next move;
- route or branch advice;
- exact timing count;
- which ECHO should occupy which Plate;
- when the convergence occurs;
- confirmation that a proposed move is correct or incorrect;
- solver witness, metrics, map, control result, or validation trace;
- a gesture, cursor point, key press, or verbal cue indicating the solution.

Technical help is limited to restoring window focus, confirming that the game is running, or reading a control already visible in the game. It must not alter puzzle state or interpretation.

If the owner requests an operational hint, first ask whether they want to end the unassisted attempt. Any hint after that point makes the remainder `COMPLETED_ASSISTED` and cannot support an unassisted owner result.

Do not silently restart or correct an owner action.

### 9.3 Attempt records

For both Level 6 and Level 7, record only directly observed or owner-reported facts:

- status: `COMPLETED_UNASSISTED`, `COMPLETED_ASSISTED`, `GAVE_UP`, `BLOCKED_BY_BUG`, or `INTERRUPTED`;
- final visible turn;
- approximate elapsed time and restart count when supplied or measured with consent;
- operational assistance;
- Help use;
- Timeline use;
- direct short comment;
- runtime defect, clipping, crowding, unreadable state, or unresponsive-looking behavior;
- optional approved game-window-only screenshot.

For Level 6, keep questions brief:

1. Was anything materially different from your prior Level 6 review?
2. What should Level 7 improve on or make harder?

Do not reveal Level 7’s intended solution before its attempt.

### 9.4 Level 7 post-attempt questions

Immediately after the Level 7 attempt ends and before any witness reveal, ask:

1. Was Level 7 clearly harder than Level 6? Was the increase caused by reasoning or by unclear state?
2. What did E2 and E4 do differently with the same earlier inputs?
3. At the useful moment, which ECHO did you believe was on Plate A and which was on Plate B?
4. Did you predict the A+B convergence, infer it after observation, find it through trial and error, or reach it accidentally?
5. Why was the Door passable on the crossing input?
6. Were the A/B labels and triangle/circle shapes readable and correctly matched to the Door pips?
7. Could you distinguish E2 and E4 when they overlapped?
8. Did the status panel clearly communicate that two different delays existed, or did any singular delay text mislead you?
9. Did Timeline help, add clutter, or remain unused? Did you need reverse-counting?
10. Did Help add useful context without revealing the route, remain unnecessary, or confuse you?
11. Were failed attempts understandable and recoverable?
12. Did any part of the difficulty come mainly from a blocked move, corridor length, hidden state, or visual crowding?
13. Should Level 7 be preserved, simplified, repaired, or replaced?
14. Is the project ready to plan Level 8, or should presentation/content production be prioritized first?
15. What single change should be prioritized next?

Optional 1–5 ratings:

- Level 7 difficulty relative to Level 6;
- E2/E4 distinction;
- A/B dependency clarity;
- convergence readability;
- Door open-snapshot clarity;
- overlap readability;
- Timeline usefulness;
- Help usefulness;
- information density/readability;
- failure recovery clarity;
- satisfaction on completion;
- willingness to continue.

Missing answers or ratings are `NOT_PROVIDED`.

Do not reveal the exact solver witness after the questionnaire. A high-level explanation may be deferred until evidence is safely recorded but is not required.

## 10. Interpretation and findings

Separate:

- direct owner statements;
- directly observed runtime facts;
- operator interpretation;
- unresolved uncertainty.

Do not rewrite the owner’s words to match the intended design.

Classify conservatively:

- `P0`: crash, launch/input failure, corrupted state, impossible progression caused by defect, or confirmed baseline regression;
- `P1`: material defect prevents completion or understanding of the E2/E4 + A/B relationship; visible Door state contradicts behavior; one ECHO cannot be distinguished from the other; required information cannot be recovered; or an unintended bypass defeats the teaching role;
- `P2`: substantial friction, trial-and-error dominance, weak dependency/actor observability, misleading status text, overlap crowding, large difficulty overshoot, Timeline/Help/readability problem, or owner give-up not caused by a blocking defect;
- `P3`: wording, polish, preference, or future production suggestion.

One owner’s dislike is not automatically P1. One owner completion is not population evidence.

Gate outcomes:

1. Level 7 completed unassisted, owner explains two delays and A+B convergence, and P0=0/P1=0:
   - record evidence;
   - recommend GPT acceptance of owner Level 7 evidence;
   - recommend either bounded Level 8 planning or a separately bounded production/presentation task based on direct owner priority.
2. Review completed but comprehension/promotion criteria not met, with P0=0/P1=0:
   - record evidence;
   - recommend a bounded presentation/difficulty analysis or owner-only repeat;
   - do not claim owner acceptance.
3. Any P0/P1:
   - record evidence;
   - recommend a separately authorized diagnostic/repair task;
   - do not edit implementation or content.

## 11. Authorized repository writes

After an actual review attempt, create only:

```text
docs/reviews/0015V_OWNER_TARGETED_LEVEL_7_REVIEW.md
docs/reports/0015V_OWNER_TARGETED_LEVEL_7_REVIEW_REPORT.md
```

Update only the necessary subset of:

```text
docs/CODEX_ACTIVE_TASK_CURRENT.md
docs/CODEX_STARTUP_SNAPSHOT_CURRENT.md
docs/DOC_INDEX_CURRENT.md
docs/DEVELOPMENT_PLAN_CURRENT.md
docs/HANDOFF_MASTER_CURRENT.md
docs/project_memory.md
docs/level_design/INITIAL_LEVEL_ROADMAP_AND_VALIDATION_MATRIX_CURRENT.md
docs/level_design/FIVE_LEVEL_DIFFICULTY_RECOVERY_AND_LEVELS_6_8_PLAN.md
docs/level_design/LEVEL_7_TWO_ECHO_CONVERGENCE_PLAN_CURRENT.md
docs/ux/PRESENTATION_VIEWPORT_AND_HUD_DIRECTION_CURRENT.md
```

The review document must include:

- reviewer and exact classification;
- owner-only/fresh-independent boundary;
- accepted implementation and formal SHA-256;
- baseline reuse/rerun facts;
- environment and launch commands;
- assistance boundary and whether preserved;
- Level 6 and Level 7 attempt records;
- complete pre-reveal Level 7 answers;
- optional ratings exactly as supplied;
- direct statements separated from interpretation;
- P0/P1/P2/P3 findings;
- Level 7 disposition and next-priority recommendation;
- explicit non-claims;
- external evidence index.

The execution report must include:

- terminal verdict;
- start/final Git facts;
- created/updated paths;
- external evidence root;
- baseline disposition;
- attempt summary;
- Level 7 completion, assistance, and comprehension summary;
- finding counts;
- recommended next gate;
- confirmation that implementation/content/tests/formal data did not change.

Do not modify prior tasks, reports, reviews, validations, acceptances, project rules, contracts, GDD, source, content, tests, schemas, fixtures, assets, imports, audio, plugins, dependencies, or project settings.

## 12. Validation and Git discipline

Before staging:

```powershell
git status --short --untracked-files=all
git diff --check
git diff --stat
```

Audit:

- only authorized Markdown paths changed;
- owner classification and prior exposure are explicit;
- no assisted attempt is mislabeled unassisted;
- direct answers are faithful and missing data is `NOT_PROVIDED`;
- no route, witness, screenshot, raw log, external evidence, secret, or unnecessary personal data is committed;
- no implementation, level, catalog, test, schema, fixture, asset, import, or user-data file is staged;
- all current documents agree on the result and next gate;
- no Level 8, candidate, production, export, release, or submission authorization is implied;
- all links resolve.

Stage explicit paths only. Never use `git add .` or `git add -A`.

Then run:

```powershell
git diff --cached --check
git diff --cached --stat
git diff --cached --name-only
```

This task authorizes one documentation-only commit after an actual review:

```text
docs: record Delayed Self owner Level 7 review
```

Immediately before push:

```powershell
git fetch origin
git rev-parse HEAD
git rev-parse origin/main
git status --short --untracked-files=all
```

Stop on remote drift. Do not merge, rebase, amend, force-push, reset, broad restore, `git clean`, or create an implementation commit.

After push, require clean worktree and `HEAD == origin/main`.

## 13. Terminal verdicts

Use exactly one:

```text
OWNER_LEVEL_7_REVIEW_RECORDED_FOR_GPT_REVIEW
```

Use after an actual review was faithfully recorded, committed, and pushed, regardless of disposition, provided no P0/P1 requires the blocked verdict below.

```text
BLOCKED_BASELINE_REGRESSION
```

Use when the accepted baseline, markers, metrics, or hashes fail. Do not launch the review.

```text
BLOCKED_OWNER_LEVEL_7_P0_P1
```

Use after faithfully recording, committing, and pushing an actual review that identifies any P0/P1 requiring separate repair or diagnosis.

```text
BLOCKED
```

Use only for another explicit safety, Git, privacy, evidence, environment, or scope blocker.

No terminal verdict is final GPT acceptance.

## 14. Next gate

- positive owner review: GPT adjudicates owner Level 7 evidence, then chooses bounded Level 8 planning or a separately bounded production/presentation gate based on the owner’s direct priority;
- non-promotion without P0/P1: GPT selects a focused Level 7 evidence/presentation task or owner-only repeat;
- P0/P1: GPT issues a bounded diagnostic or repair;
- no third party may be sought or required;
- Level 8, assets/fonts/audio/narrative, Timeline/Help redesign, Gate, persistence, export, release, and submission remain unauthorized until separately tasked.

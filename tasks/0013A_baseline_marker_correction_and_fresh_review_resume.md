# Task 0013A — Baseline marker correction and fresh-review continuation

- Status: `READY`
- Gate: `BLOCKER ADJUDICATION / HUMAN EVIDENCE CONTINUATION`
- Repository: `zcx369658780/delayed-self-godot`
- Expected branch: `main`
- Expected local root: `D:\Delayed_Self`
- Issued by: GPT Project Sources advisor
- Date: 2026-07-17
- Parent task: `tasks/0013_fresh_independent_level_6_sequence_review.md`
- Parent task publication: `b4d31fe8b02f380dda7bb1baa46737a11adc2b60`
- Blocker adjudication: `docs/reports/0013_GPT_BASELINE_BLOCKER_ADJUDICATION.md`
- Adjudication commit: `ae99a78d0fd2427807b5778c340dfc8accba2666`
- Prior accepted gate: `TASK_0012_STAGGERED_DOORS_ACCEPTED_INTERNAL_PLAYABLE`
- Accepted implementation: `1e43e9baa82a578fdb14f556e4895d42863513d9`

## 1. Objective

Correct the single aggregate-marker transcription error in Task 0013, verify that the previously stopped baseline is healthy, and continue the already-defined fresh independent Level 6 sequence-review gate without changing implementation, formal content, tests, or the human-review standard.

The reported stop is GPT-adjudicated as:

```text
FALSE_BLOCKER_TASK_MARKER_TRANSCRIPTION_ERROR
```

The parent task incorrectly required:

```text
TASK_0012_STAGGERED_DOORS_TESTS_PASS
```

The canonical executable marker in `tests/run_all.gd` is:

```text
TASK_0012_LEVEL_6_STAGGERED_DOORS_TESTS_PASS
```

This task supersedes only that incorrect marker spelling and the resulting false blocker. Every other scope, qualification, no-hint, privacy, evidence, interpretation, write, Git, non-claim, and human-review requirement in Task 0013 remains mandatory.

## 2. Authorized continuation

This task authorizes Codex to:

1. safely fast-forward clean local `main` to include this task and the adjudication report;
2. verify and reuse the already captured healthy baseline evidence when all reuse requirements below are met;
3. otherwise rerun the accepted aggregate suite once with the corrected marker set;
4. proceed to the reviewer-qualification gate;
5. if a qualifying fresh reviewer is present, conduct and record the complete Level 1–6 sequence review defined here and in Task 0013;
6. if no qualifying reviewer is present, stop ready for the later human session without repository writes.

This task does not authorize implementation, content, test, balance, presentation, Level 7, asset, audio, narrative, Gate, persistence, export, release, submission, account, repository-setting, or user-data changes.

## 3. Mandatory startup gate

Before running Godot, using external evidence, or launching a reviewer:

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
- accepted Godot `4.7.stable.steam.5b4e0cb0f`, unless the current environment record documents an accepted equivalent;
- local and remote contain this task, the adjudication report, Task 0013, Task 0012 acceptance, and Task 0012S synchronization.

If clean local `main` is behind, use only:

```powershell
git fetch origin
git merge --ff-only origin/main
```

Stop on divergence, conflict, unexpected files, wrong root or remote, inability to fast-forward, missing governance artifacts, or materially different toolchain.

## 4. Required reads

Read in order:

1. `AGENTS.md`;
2. `docs/CODEX_STARTUP_SNAPSHOT_CURRENT.md`;
3. `docs/CODEX_ACTIVE_TASK_CURRENT.md`;
4. this task;
5. `docs/reports/0013_GPT_BASELINE_BLOCKER_ADJUDICATION.md`;
6. `tasks/0013_fresh_independent_level_6_sequence_review.md`;
7. `docs/reports/0012_GPT_FINAL_ACCEPTANCE.md`;
8. `docs/reports/0012_LEVEL_6_STAGGERED_DOORS_REPORT.md`;
9. `docs/reports/0012S_PROJECT_SOURCE_SYNC_REPORT.md`;
10. `tests/run_all.gd`, limited to the aggregate success/failure and marker-emission path;
11. the current six-level planning/validation documents and catalog contract;
12. evidence/privacy, independent-review, puzzle-validation, Git, and Godot-safety rules.

Before continuation, print a concise summary of:

- false-blocker adjudication;
- exact corrected marker;
- evidence-reuse decision and basis;
- reviewer qualification requirements;
- no-hint and privacy boundaries;
- source/content/test freeze;
- authorized write and commit policy;
- terminal verdicts.

Do not display repository documents, logs, metrics, maps, task text, or validation evidence to a fresh reviewer.

## 5. Implementation, content, and data freeze

Do not modify, regenerate, reimport, stage, commit, or otherwise alter:

- `project.godot`;
- `scripts/`, `scenes/`, `data/levels/`, `data/catalog/`, `schemas/`, `tests/`, or fixtures;
- gameplay, solver, simulation, UI, presentation, progression, catalog, or save behavior;
- assets, fonts, audio, shaders, imports, plugins, or dependencies;
- accepted tasks, reports, validations, contracts, reviews, or acceptance artifacts;
- export, build, release, account, repository settings, submission, or user data.

Do not amend Task 0013 or the Task 0012 acceptance artifact. This task and the adjudication report preserve the correction trail.

Do not delete or reset `.godot`, caches, settings, evidence, or user data. Never use `git clean`, reset, broad restore, rebase, amend, or force-push.

## 6. Corrected baseline gate

### 6.1 Evidence-reuse path

The existing authorized evidence root is:

```text
D:\Delayed_Self_Evidence\0013_fresh_level_6_sequence_review\
```

Reuse the prior stopped baseline instead of rerunning only if all of the following can be verified:

1. evidence files are readable and clearly belong to the stopped Task 0013 run;
2. the recorded command is the accepted aggregate command:

```powershell
godot --headless --path D:\Delayed_Self --script res://tests/run_all.gd
```

3. the recorded executable identity is the accepted Godot toolchain;
4. the native exit code is `0`;
5. all eight corrected markers below occur exactly once;
6. no `TASK_0003_TESTS_FAIL`, unhandled parser/script/runtime error, crash, or exception occurs;
7. stderr contains no causal failure and any `LEVEL_ID_MISMATCH` is confined to the intentional negative path;
8. Level 6 metrics and all six formal hashes match the accepted facts;
9. the baseline was captured at parent publication `b4d31fe8b02f380dda7bb1baa46737a11adc2b60`;
10. `git diff --name-only b4d31fe8b02f380dda7bb1baa46737a11adc2b60..HEAD` contains only this GPT adjudication report and this corrective task, with no executable, formal-data, project-setting, catalog, schema, fixture, or test change.

If every condition holds, classify:

```text
BASELINE_HEALTHY_REUSED_EVIDENCE
```

Do not rerun merely because the current `HEAD` adds these two documentation files.

### 6.2 Rerun path

If prior evidence is missing, ambiguous, altered, or cannot prove every reuse condition, run the accepted aggregate suite once in a fresh native process, preserving stdout, stderr, and native exit code separately.

The corrected required markers are exactly:

```text
TASK_0003_TESTS_PASS assertions=349 vectors=9
TASK_0006_APP_SHELL_TESTS_PASS
TASK_0007_TUTORIAL_LEVELS_TESTS_PASS
TASK_0008_PROGRESSIVE_HUD_TESTS_PASS
TASK_0009AR_LEVELS_4_5_TESTS_PASS
TASK_0011_PRESENTATION_RECOVERY_TESTS_PASS
TASK_0011R_WINDOW_FILL_TESTS_PASS
TASK_0012_LEVEL_6_STAGGERED_DOORS_TESTS_PASS
```

Require:

```text
level_id = staggered_doors
L* = 15
N* = 4
N* status = EXACT
visited_states = 6772
maximum_frontier = 1179
formal_sha256 = 3f14c19b50775e36dd5b52664798381cf1292b0a30b377641c03435f45696bc8
```

Also require all five prior formal hashes and accepted metrics unchanged.

Do not infer failure from stderr presence alone. The intentional `LEVEL_ID_MISMATCH` may appear during a passing run.

If the corrected baseline genuinely fails, stop without human review or repository write using:

```text
BLOCKED_CORRECTED_BASELINE_REGRESSION
```

Do not edit implementation or tests.

## 7. Reviewer qualification

A qualifying reviewer must, before launch:

1. not be the authenticated project owner;
2. not be a contributor, Codex operator, implementation reviewer, project advisor, or prior tester;
3. never have played a Delayed Self build;
4. never have watched a playthrough, capture, stream, or demonstration;
5. never have read project sources, tasks, validation reports, solver witnesses, maps, walkthroughs, or movement sequences;
6. not have been told the solution, intended route, two-Door timing chain, metrics, or an operational hint;
7. consent to bounded non-identifying notes;
8. control the game directly.

Record direct answers to the five qualification questions in Task 0013. Use a non-identifying label such as `fresh_reviewer_01`; do not record legal name, contacts, employer, account identifiers, face, voice, or unrelated personal information.

The owner cannot substitute for this gate.

If no qualifying reviewer is currently available, launch no owner replay, make no repository review write, and stop with:

```text
READY_FOR_FRESH_LEVEL_6_SEQUENCE_REVIEW
```

If the proposed reviewer fails qualification and no replacement is present, stop with:

```text
BLOCKED_REVIEWER_NOT_QUALIFYING
```

## 8. External evidence and privacy

Use only:

```text
D:\Delayed_Self_Evidence\0013_fresh_level_6_sequence_review\
```

Preserve existing baseline evidence. Do not overwrite unrelated or prior files; add bounded, clearly named continuation files when a review occurs.

Allowed:

- bounded baseline summaries and logs;
- executable/command identity;
- qualification answers;
- direct reviewer answers and observations;
- six per-level records;
- reviewer-supplied or consented timing, turn, restart, Help, and Timeline facts;
- approved game-window-only screenshots;
- evidence index with timestamps, sizes, and SHA-256.

Forbidden:

- full-desktop capture;
- face or voice recording;
- browser, email, notification, credential, account, or unrelated-window capture;
- background keyboard logging, hidden telemetry, or identity details;
- committing screenshots, recordings, raw long logs, or external evidence.

Missing measurements or answers are `NOT_PROVIDED`, never inferred.

## 9. Fresh six-level review protocol

After a healthy corrected baseline and qualification:

1. close only existing Godot game processes for this project;
2. launch a fresh normal AppRoot process;
3. use Main Menu and Level Select, not a direct-level or debug route;
4. let the reviewer play Levels 1–6 in catalog unlock order;
5. let the reviewer control the keyboard;
6. do not expose source, task text, console, metrics, maps, validation traces, or evidence notes;
7. do not delete or alter persistent user data to force progression.

Tell the reviewer only the exact neutral instruction in Task 0013 section 9.2.

During an active qualifying attempt, Codex, the owner, and observers must not provide:

- a movement sequence or next move;
- route, destination, timing, Plate/Door, or replay guidance;
- gestures, cursor points, key presses, facial/verbal cues, or correctness confirmation;
- solver witness, shortest path, metric, map, or validation trace.

Technical help is limited to restoring focus, confirming the process is running, or reading a control already visible in-game. Any operational hint ends the qualifying unassisted attempt and makes the remainder assisted.

Record the six per-level attempt facts required by Task 0013. Keep Levels 1–5 questioning to the two neutral questions in Task 0013. For Level 6, use all thirteen pre-reveal questions and the optional ratings exactly as written in Task 0013. Do not reveal the intended two-window rule before those answers are complete.

The approximately 3–7 minute and 0–3 restart values are hidden review targets, not hard pass/fail rules. At approximately 15 minutes, use only the neutral continue/stop/assistance question from Task 0013.

## 10. Interpretation and severity

Separate:

- direct reviewer statements;
- directly observed runtime facts;
- operator interpretation;
- unresolved uncertainty.

Do not rewrite answers to match design intent.

Recommend GPT consideration of `FRESH_PLAYER_REVIEWED` only if qualification is credible, normal Levels 1–6 progression succeeds, Level 6 is completed unassisted, P0=0/P1=0, the pre-reveal explanation demonstrates delayed ECHO replay and two separate timing obligations, and completion is not attributable only to an unintended shortcut or accident.

Use the exact Task 0013 P0–P3 definitions. Any P0/P1 is recorded, not repaired, and returns:

```text
BLOCKED_FRESH_LEVEL_6_SEQUENCE_P0_P1
```

after the authorized documentation commit and push.

A valid non-promotion review with no P0/P1 must still be recorded faithfully and returned for GPT review.

## 11. Authorized repository writes after an actual review

Create only:

```text
docs/reviews/0013_FRESH_INDEPENDENT_LEVEL_6_SEQUENCE_REVIEW.md
docs/reports/0013_FRESH_INDEPENDENT_LEVEL_6_SEQUENCE_REVIEW_REPORT.md
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
```

The review and execution reports must contain every field required by Task 0013, including corrected marker evidence, qualification, six attempts, Level 6 pre-reveal answers, findings, promotion matrix, non-claims, external evidence index, Git facts, and next-gate recommendation.

Do not modify this task, the parent task, the adjudication report, or any prior artifact.

## 12. Validation and Git discipline

Before staging:

```powershell
git status --short --untracked-files=all
git diff --check
git diff --stat
```

Require only authorized Markdown changes, faithful qualification/answers, no inflated review status, no personal data or route disclosure, no external evidence staged, and no implication that Level 7 or candidate/release work is authorized.

Stage explicit paths only. Never use broad staging.

```powershell
git diff --cached --check
git diff --cached --stat
git diff --cached --name-only
```

After an actual review, authorize exactly one documentation-only commit:

```text
docs: record Delayed Self fresh Level 6 sequence review
```

Before push, fetch and stop on remote drift. Do not merge, rebase, amend, force-push, reset, broad-restore, or clean. Push normally to `origin/main`, then require a clean worktree and `HEAD == origin/main`.

No commit is authorized when no review occurs.

## 13. Terminal verdicts

Return exactly one:

```text
FRESH_LEVEL_6_SEQUENCE_REVIEW_RECORDED_FOR_GPT_REVIEW
```

Use after an actual review is recorded, committed, and pushed with no P0/P1 blocked outcome.

```text
READY_FOR_FRESH_LEVEL_6_SEQUENCE_REVIEW
```

Use after the corrected baseline is healthy but no qualifying reviewer is available. Make no repository review write.

```text
BLOCKED_REVIEWER_NOT_QUALIFYING
```

Use when the proposed reviewer fails qualification and no replacement is present. Make no repository review write.

```text
BLOCKED_CORRECTED_BASELINE_REGRESSION
```

Use only for a genuine failure under the corrected marker set.

```text
BLOCKED_FRESH_LEVEL_6_SEQUENCE_P0_P1
```

Use after an actual review is faithfully recorded and pushed with a P0/P1 requiring separate work.

```text
BLOCKED
```

Use only for another explicit Git, safety, privacy, evidence, environment, or scope blocker.

No terminal verdict is final GPT acceptance.

## 14. Next gate

- qualifying positive review: GPT adjudicates `FRESH_PLAYER_REVIEWED` and separately selects another review, Level 7 planning, or a repair;
- non-promotion without P0/P1: GPT selects another fresh reviewer or bounded UX/evidence work;
- P0/P1: GPT issues a separate diagnostic or repair;
- reviewer unavailable: resume this task later with a qualifying reviewer;
- Level 7, candidate acceptance, assets/fonts/audio/narrative, Gate, persistence, export, release, and submission remain unauthorized.

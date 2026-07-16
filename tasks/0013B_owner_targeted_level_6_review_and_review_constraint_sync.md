# Task 0013B — Owner-targeted Level 6 review and review-constraint synchronization

- Status: `READY`
- Gate: `HUMAN EVIDENCE / AUTHENTICATED OWNER LEVEL 6 REVIEW`
- Repository: `zcx369658780/delayed-self-godot`
- Expected branch: `main`
- Expected local root: `D:\Delayed_Self`
- Issued by: GPT Project Sources advisor
- Date: 2026-07-17
- Publication baseline: `b7b3379fdf322c0b66abe867918f9bfe2fd7cdd7`
- Owner-only path adjudication: `docs/reports/0013A_GPT_OWNER_ONLY_REVIEW_PATH_ADJUDICATION.md`
- Adjudication commit: `b7b3379fdf322c0b66abe867918f9bfe2fd7cdd7`
- Corrected baseline task: `tasks/0013A_baseline_marker_correction_and_fresh_review_resume.md`
- Corrected baseline checkpoint: `2997dd040983c952a1617ea112a39b509831951c`
- Prior accepted gate: `TASK_0012_STAGGERED_DOORS_ACCEPTED_INTERNAL_PLAYABLE`
- Accepted implementation: `1e43e9baa82a578fdb14f556e4895d42863513d9`
- Formal Level 6: `staggered_doors`
- Formal Level 6 SHA-256: `3f14c19b50775e36dd5b52664798381cf1292b0a30b377641c03435f45696bc8`

## 1. Objective

Conduct one authenticated-owner targeted review of Level 6, preferably immediately after a Level 5 comparison run, and record the result without seeking, requiring, contacting, or recruiting any third-party reviewer.

The review classification must be exactly:

```text
AUTHENTICATED_OWNER_NOT_FRESH_NOT_INDEPENDENT_LEVEL_6_REVIEW
```

The project owner has prior exposure to the project, earlier levels, design discussions, rules, reports, and development decisions. Do not disguise that exposure. This task evaluates owner experience and product judgment; it does not attempt to recreate a fresh, blind, independent, or first-player session.

This task must determine:

1. whether current Level 6 runs and completes in the accepted build;
2. whether the owner experiences a meaningful difficulty rise from Level 5;
3. whether the two distinct Door-opening opportunities are observable and understandable during play;
4. whether ECHO replay, Plate causality, Door state, Timeline, Help, and HUD support planning;
5. whether difficulty comes from reasoning rather than only execution length, unclear state, or blind trial-and-error;
6. whether recovery and restart remain acceptable;
7. whether any P0/P1 requires repair before Level 7;
8. whether the evidence supports a bounded Level 7 planning task, a Level 6 repair, or another owner-only design iteration;
9. whether the durable no-third-party-search constraint is synchronized into current project documents.

## 2. Owner directive and durable constraint

The owner has explicitly directed that only the owner is available to playtest and that the project must not continue trying to find a third party.

Therefore:

- do not ask the owner to recruit anyone;
- do not search online or through contacts for a reviewer;
- do not suggest friends, colleagues, students, family, contractors, communities, or volunteers;
- do not block ordinary internal development solely because independent review is unavailable;
- do not label owner evidence as `FRESH_PLAYER_REVIEWED`, blind, first-player, or independent;
- preserve the unavailable evidence as a disclosed residual limitation;
- no later task may reintroduce third-party recruitment unless the owner explicitly reverses this instruction.

The fresh-independent path is recorded as:

```text
FRESH_INDEPENDENT_REVIEW_UNAVAILABLE_BY_OWNER_CONSTRAINT
```

It is neither passed nor failed. It is unavailable and not claimed.

## 3. Claim boundary

A positive owner review may support GPT authorization of:

- a bounded Level 7 planning task;
- a bounded Level 7 implementation task after planning acceptance;
- a focused Level 6 presentation or difficulty repair;
- continued internal content production.

It may support owner-facing statements such as:

- Level 6 was completed by the authenticated owner;
- the owner considered it easier, appropriately harder, or excessively harder than Level 5;
- specified UI, feedback, and planning observations were directly reported;
- no observed P0/P1 was present in that owner session.

It cannot establish:

- `FRESH_PLAYER_REVIEWED`;
- independent or blind discoverability;
- population-level difficulty, balance, or fun;
- `CANDIDATE_ACCEPTED` by itself;
- final tutorial acceptance;
- complete-flow acceptance;
- accessibility, localization, controller, save, settings, export, Web, release, or submission readiness;
- authorization for Level 7, assets, audio, narrative, Gate, persistence, export, release, or submission beyond the next separately issued task.

## 4. Mandatory startup gate

Before running Godot, using evidence, or writing repository files:

```powershell
Get-Location
git branch --show-current
git rev-parse HEAD
git rev-parse origin/main
git remote -v
git status --short --untracked-files=all
git log -36 --oneline --decorate
godot --version
Get-Command godot | Format-List Source,Version,CommandType
```

Required:

- absolute root exactly `D:\Delayed_Self`;
- branch `main`;
- expected origin;
- fully clean tracked and untracked worktree;
- local `HEAD == origin/main` and both contain this task and the owner-only adjudication;
- accepted Godot `4.7.stable.steam.5b4e0cb0f`, unless the current environment record documents an accepted equivalent;
- no unexpected commit after this task publication.

If clean local `main` is behind, use only:

```powershell
git fetch origin
git merge --ff-only origin/main
```

Stop on divergence, conflict, wrong root, wrong remote, unexpected files, inability to fast-forward, missing governance artifacts, or a materially different Godot executable/version.

## 5. Required reads

Read in order:

1. `AGENTS.md`;
2. `docs/CODEX_STARTUP_SNAPSHOT_CURRENT.md`;
3. `docs/CODEX_ACTIVE_TASK_CURRENT.md`;
4. this task;
5. `docs/reports/0013A_GPT_OWNER_ONLY_REVIEW_PATH_ADJUDICATION.md`;
6. `tasks/0013A_baseline_marker_correction_and_fresh_review_resume.md` only for the corrected baseline and evidence-reuse facts;
7. `docs/reports/0013_GPT_BASELINE_BLOCKER_ADJUDICATION.md`;
8. `docs/reports/0012_GPT_FINAL_ACCEPTANCE.md`;
9. `docs/reports/0012_LEVEL_6_STAGGERED_DOORS_REPORT.md`;
10. `docs/reviews/0009AV_OWNER_FIVE_LEVEL_SEQUENCE_REVIEW.md`;
11. `docs/reports/0009AV_GPT_FINAL_ACCEPTANCE.md`;
12. `docs/level_design/FIVE_LEVEL_DIFFICULTY_RECOVERY_AND_LEVELS_6_8_PLAN.md`;
13. `docs/level_design/INITIAL_LEVEL_ROADMAP_AND_VALIDATION_MATRIX_CURRENT.md`;
14. current catalog contract and six-entry catalog;
15. current index, development plan, handoff, and project memory;
16. evidence/privacy, puzzle-validation, Git, and Godot-safety rules.

Before execution, print a concise operator summary containing:

- exact owner-review classification;
- explicit no-third-party-search constraint;
- baseline reuse decision;
- Level 5/Level 6 launch plan;
- prior-exposure and non-claim boundary;
- no-hint boundary;
- evidence/privacy boundary;
- source/content/test freeze;
- authorized documentation writes;
- P0/P1 stop rules;
- terminal verdicts.

## 6. Baseline reuse and regression gate

The owner reports that Task 0013A already verified a healthy baseline at checkpoint `2997dd040983c952a1617ea112a39b509831951c` with:

- native exit `0`;
- `TASK_0003_TESTS_PASS assertions=349 vectors=9`;
- all eight canonical markers exactly once;
- canonical Level 6 marker `TASK_0012_LEVEL_6_STAGGERED_DOORS_TESTS_PASS`;
- Level 6 `L*=15`, `N*=4 EXACT`, visited `6772`, frontier `1179`;
- all six formal hashes unchanged;
- stderr containing only the expected `LEVEL_ID_MISMATCH` negative path.

Authorized evidence root already used:

```text
D:\Delayed_Self_Evidence\0013_fresh_level_6_sequence_review\
```

Reuse that baseline without rerunning Godot only when all are true:

1. the evidence index, stdout, stderr, exit summary, executable identity, hashes, and marker list are present and readable;
2. file hashes match the evidence index when an index is available;
3. the command is the accepted aggregate command;
4. the native exit code is independently recorded as `0`;
5. all eight canonical markers are present exactly once;
6. the metrics and six formal hashes match accepted values;
7. the only commits after `2997dd040983c952a1617ea112a39b509831951c` and before this task are documentation/task publications that do not touch executable, content, test, schema, catalog, or formal-level paths;
8. the worktree remains clean.

Record the reuse verdict as:

```text
REUSED_HEALTHY_TASK_0013A_BASELINE
```

If any reuse fact cannot be verified, run the accepted aggregate suite once in a fresh native process, preserving stdout, stderr, and native exit separately:

```powershell
godot --headless --path D:\Delayed_Self --script res://tests/run_all.gd
```

Require exit `0` and exactly:

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

Do not infer failure from the known intentional `LEVEL_ID_MISMATCH` stderr line.

If a genuine regression is present, do not launch the owner review and stop with:

```text
BLOCKED_BASELINE_REGRESSION
```

## 7. Implementation and content freeze

Do not modify, regenerate, reimport, stage, commit, or otherwise alter:

- `project.godot`;
- `scripts/`;
- `scenes/`;
- `data/levels/`;
- `data/catalog/`;
- `schemas/`;
- `tests/`;
- fixtures;
- gameplay, solver, simulation, UI, presentation, progression, or catalog behavior;
- assets, fonts, audio, shaders, imports, plugins, or dependencies;
- save/player-data behavior;
- export, build, release, account, repository-setting, or submission surfaces;
- prior tasks, reports, reviews, validations, acceptances, contracts, or project rules.

Do not fix findings during the review. Record them and return them for GPT adjudication.

Do not delete or reset user data, `.godot`, caches, settings, sessions, evidence, or unrelated processes. Do not use `git clean`, broad restore, reset, rebase, amend, or force-push.

## 8. External evidence and privacy

Use exactly:

```text
D:\Delayed_Self_Evidence\0013B_owner_level_6_targeted_review\
```

Verify that any existing directory is safe and contains no unrelated evidence that would be overwritten. Do not delete, rename, move, or replace unrelated files.

Allowed evidence:

- bounded baseline reuse summary or rerun logs;
- exact launch command and executable identity;
- owner attempt notes and direct answers;
- visible turn count, elapsed time, and restart count when directly supplied or measured with consent;
- Help and Timeline use;
- deliberately approved game-window-only screenshots;
- evidence index with timestamps, filenames, byte sizes, and SHA-256 values.

Forbidden:

- automatic full-desktop capture;
- face or voice recording;
- browser, email, notifications, credentials, accounts, or unrelated windows/files;
- hidden telemetry or background key logging;
- unnecessary personal data;
- staging or committing screenshots, recordings, raw long logs, or the external evidence directory.

Missing measurements must be `NOT_PROVIDED`, never inferred.

## 9. Owner review launch protocol

### 9.1 Comparison path

The preferred efficient comparison is:

1. launch accepted Level 5 `two_keys_one_door` through the repository’s already accepted direct-level routing;
2. let the owner complete or stop the Level 5 comparison attempt;
3. close that project game process normally;
4. launch Level 6 `staggered_doors` through the same accepted direct-level routing;
5. let the owner control the keyboard directly.

Recover the exact accepted direct-level command and argument spelling from the current parser/tests, current reports, or accepted evidence. Print it before launch. Do not invent a new argument, modify the catalog, edit progress, or use a debug teleport.

If the accepted direct-level launch cannot be resolved safely, use normal AppRoot and catalog progression. Do not modify or delete user data to unlock levels. If normal progression would require unsafe data manipulation, stop with a precise blocker rather than altering user state.

A full Level 1–6 replay is allowed if the owner prefers it, but it is not required by this targeted owner review.

### 9.2 Assistance and prior-exposure boundary

Before play, tell the owner:

```text
This is an owner review, not a fresh or independent review. Please play Level 5 for comparison if launched, then play Level 6 using only the game’s visible controls, Timeline, and Help. Codex will not provide a movement sequence, next move, timing count, route, or solver witness. Say when you complete, give up, encounter a bug, want to stop, or want assistance. Any prior project knowledge you already have will be recorded as part of the review limitation.
```

Codex must not provide during an active attempt:

- movement sequences or the next move;
- routes, destinations, or timing counts;
- Plate/Door pairing explanations;
- solver witnesses, metrics, maps, or validation traces;
- confirmation that a contemplated move is correct or incorrect;
- gestures, cursor pointing, or key presses that solve the puzzle.

Technical help is limited to restoring focus, confirming the game is running, or reading a control already visible in the game. Any operational assistance must be recorded exactly.

The owner’s pre-existing knowledge does not invalidate this owner review, but it must remain an explicit limitation.

## 10. Attempt records

### 10.1 Level 5 comparison

Record only supplied or directly observed facts:

- launch path;
- attempt status: `COMPLETED_UNASSISTED`, `COMPLETED_ASSISTED`, `GAVE_UP`, `BLOCKED_BY_BUG`, `INTERRUPTED`, or `NOT_RUN`;
- final visible turn count;
- elapsed time and restart count when supplied or measured with consent;
- Help use;
- compact or expanded Timeline use;
- direct owner comment;
- observed runtime defect or readability issue;
- optional approved screenshot reference.

After Level 5, ask briefly:

1. How difficult did Level 5 feel now?
2. What rule did you rely on to complete it?
3. What information did you need to track?

Do not reveal or discuss Level 6 before its attempt.

### 10.2 Level 6 primary attempt

Record:

- launch path and process freshness;
- attempt status using the same status set;
- final visible turn count;
- elapsed time and restart count when supplied or measured with consent;
- Help use;
- compact or expanded Timeline use;
- whether the owner verbalized a plan before acting, only when spontaneously supplied;
- visible confusion, clipping, crowding, unreadable state, or unresponsive-looking behavior;
- every operational assistance event, if any;
- direct owner comment at attempt end;
- optional approved screenshot reference.

If the owner continues for approximately 15 minutes without completion, ask only whether they want to continue, stop, or request assistance. Do not force a stop and do not give a hint automatically.

## 11. Post-attempt owner questions

Immediately after the Level 6 attempt and before showing any solver witness or movement sequence, ask:

1. Did Level 6 feel easier, appropriately harder, or excessively harder than Level 5?
2. What did you think the ECHO was doing with your earlier inputs?
3. Why did the first Door become passable when it did?
4. Why did the second Door become passable when it did?
5. Did the two Doors feel controlled by the same event or by two separate events?
6. How did you decide when to cross each Door?
7. Did you solve mainly through planning, trial-and-error, memory of project design, or accidental discovery?
8. Which future-relevant state was hardest to see or remember?
9. Did Timeline help predict actions, merely confirm them, or add clutter?
10. Did Help provide useful information, reveal too much, or remain unnecessary?
11. Did either Door feel arbitrary or visually inconsistent with its actual state?
12. Was any failure difficult to understand or recover from?
13. Would you keep Level 6 unchanged, simplify it, make it harder, or change only its presentation?
14. Does Level 6 justify proceeding to a multi-delay Level 7 concept?
15. What single change should be prioritized next?

Optional 1–5 ratings:

- Level 5 difficulty;
- Level 6 difficulty;
- difficulty increase from Level 5 to Level 6;
- ECHO predictability;
- Plate-to-Door causality;
- Door-window readability;
- Timeline usefulness;
- Help usefulness;
- information density/readability;
- frustration;
- satisfaction on completion;
- willingness to continue.

Missing answers or ratings are `NOT_PROVIDED`.

Do not rewrite owner statements to fit the design intent. Separate direct statements from Codex interpretation.

## 12. Finding severity and decision logic

Classify conservatively:

- `P0`: crash, launch/input failure, corrupted state, impossible completion due to defect, or confirmed baseline regression;
- `P1`: material defect prevents completion or understanding; visible Door state contradicts actual behavior; required state cannot be recovered; or an unintended bypass defeats the level’s teaching role;
- `P2`: substantial friction, repeated confusion, trial-and-error dependence, difficulty overshoot/undershoot, weak observability, or Timeline/Help/readability problem that does not block completion;
- `P3`: wording, polish, preference, pacing, or future enhancement.

Decision branches:

1. Level 6 completed, P0=0/P1=0, and owner judges the rise meaningful:
   - recommend GPT acceptance of the owner review;
   - recommend a separately bounded Level 7 planning task;
   - preserve `FRESH_INDEPENDENT_REVIEW_UNAVAILABLE_BY_OWNER_CONSTRAINT`.
2. Level 6 completed, P0=0/P1=0, but too easy or insufficiently distinct:
   - recommend Level 6 difficulty analysis or a revised Level 7 role before implementation.
3. Level 6 completed or attempted with material P2 observability/presentation findings:
   - recommend a bounded presentation repair or design review.
4. Any P0/P1:
   - record the review and recommend a separately bounded diagnostic/repair task;
   - do not edit implementation or content.
5. Owner not ready to play now:
   - make no review commit;
   - stop ready for the owner session without seeking a third party.

## 13. Authorized repository writes

After an actual owner review attempt, create only:

```text
docs/reviews/0013B_OWNER_TARGETED_LEVEL_6_REVIEW.md
docs/reports/0013B_OWNER_TARGETED_LEVEL_6_REVIEW_REPORT.md
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

Do not modify `AGENTS.md`, the project-rule seed, detailed project rules, prior reports/reviews/tasks, source, content, tests, schemas, fixtures, assets, imports, audio, plugins, dependencies, or project settings.

`docs/project_memory.md` and relevant current documents must record durably:

- owner is the only available playtester;
- no future task should seek or require third-party reviewers unless the owner reverses the decision;
- fresh/independent evidence is unavailable and not claimed;
- owner evidence remains classified as not fresh and not independent;
- the absence of third-party evidence is a disclosed residual limitation, not an ordinary internal-development blocker.

The review document must include:

- reviewer: `authenticated_project_owner`;
- classification: `AUTHENTICATED_OWNER_NOT_FRESH_NOT_INDEPENDENT_LEVEL_6_REVIEW`;
- prior-exposure statement;
- no-third-party-search constraint;
- accepted implementation and Level 6 formal SHA-256;
- baseline reuse/rerun evidence;
- launch commands and environment;
- Level 5 and Level 6 attempt records;
- direct answers and optional ratings;
- assistance record;
- P0/P1/P2/P3 findings;
- direct statements separated from interpretation;
- explicit non-claims;
- external evidence index;
- recommendation for the next gate.

The execution report must include:

- terminal verdict;
- start/final Git facts;
- created and updated paths;
- baseline reuse/rerun result;
- Level 5 and Level 6 attempt summary;
- finding counts by severity;
- owner recommendation;
- no-source/content/test-change confirmation;
- no-third-party-search synchronization confirmation;
- external evidence root;
- next-gate recommendation.

## 14. Validation and Git discipline

Before staging:

```powershell
git status --short --untracked-files=all
git diff --check
git diff --stat
```

Audit:

- only authorized Markdown paths changed;
- owner review is not mislabeled fresh, blind, first-player, or independent;
- no unavailable evidence is marked as passed;
- direct owner answers are faithful and missing values are `NOT_PROVIDED`;
- no solver witness, route, unnecessary personal data, screenshot, recording, raw log, or external evidence is committed;
- no implementation, content, test, schema, fixture, asset, import, user-data, or project-rule file changed;
- all current documents agree on the no-third-party-search constraint and next gate;
- no Level 7 implementation, candidate, export, release, or submission authorization is implied;
- all added links resolve.

Stage explicit files only. Never use broad staging.

Then run:

```powershell
git diff --cached --check
git diff --cached --stat
git diff --cached --name-only
```

After an actual review, this task authorizes one documentation-only commit:

```text
docs: record Delayed Self owner Level 6 review
```

Immediately before push:

```powershell
git fetch origin
git rev-parse HEAD
git rev-parse origin/main
git status --short --untracked-files=all
```

Stop on remote drift. Do not merge, rebase, amend, force-push, reset, broadly restore, clean, or create a second commit.

After push, require a clean worktree and `HEAD == origin/main`.

## 15. Terminal verdicts

Use exactly one:

```text
OWNER_LEVEL_6_REVIEW_RECORDED_FOR_GPT_REVIEW
```

Use after an actual review was faithfully recorded, committed, and pushed with no P0/P1.

```text
BLOCKED_OWNER_LEVEL_6_P0_P1
```

Use after an actual review identifying P0/P1 was faithfully recorded, committed, and pushed.

```text
READY_FOR_OWNER_LEVEL_6_REVIEW
```

Use when the baseline is healthy but the owner is not ready to conduct the review now. Make no review write or commit and do not seek another reviewer.

```text
BLOCKED_BASELINE_REGRESSION
```

Use only for a genuine corrected-baseline failure.

```text
BLOCKED
```

Use only for another explicit Git, safety, privacy, evidence, environment, or scope blocker.

No terminal verdict is final GPT acceptance.

## 16. Next gate

- positive owner review with meaningful difficulty rise and no P0/P1: GPT adjudicates the review, then may issue a bounded Level 7 planning task;
- too-easy or unclear Level 6 without P0/P1: GPT issues difficulty/presentation analysis or repair;
- P0/P1: GPT issues a bounded diagnostic/repair task;
- owner not ready: rerun this same owner task later;
- do not create another third-party recruitment or fresh-review task unless the owner explicitly reverses the durable constraint;
- Level 7 implementation, candidate acceptance, assets/fonts/audio/narrative, Gate, persistence, export, release, and submission remain separately authorized gates.

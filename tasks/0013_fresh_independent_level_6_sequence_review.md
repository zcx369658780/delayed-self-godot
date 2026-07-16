# Task 0013 — Fresh independent Level 6 sequence review

- Status: `READY`
- Gate: `HUMAN EVIDENCE / FRESH INDEPENDENT LEVEL 6 SEQUENCE REVIEW`
- Repository: `zcx369658780/delayed-self-godot`
- Expected branch: `main`
- Expected local root: `D:\Delayed_Self`
- Issued by: GPT Project Sources advisor
- Date: 2026-07-17
- Publication baseline: `8ae8ae3501121743fe5b247ff836ef304ed27be0`
- Prior accepted gate: `TASK_0012_STAGGERED_DOORS_ACCEPTED_INTERNAL_PLAYABLE`
- Accepted implementation commit: `1e43e9baa82a578fdb14f556e4895d42863513d9`
- Prior acceptance artifact: `docs/reports/0012_GPT_FINAL_ACCEPTANCE.md`
- Current checkpoint artifact: `docs/reports/0012S_PROJECT_SOURCE_SYNC_REPORT.md`
- Formal Level 6: `staggered_doors`
- Formal Level 6 SHA-256: `3f14c19b50775e36dd5b52664798381cf1292b0a30b377641c03435f45696bc8`

## 1. Objective

Obtain one qualifying fresh and independent human review of the normal six-level sequence, with Level 6 as the primary evidence target.

The reviewer must enter through the normal AppRoot, Main Menu, Level Select, unlock, completion, and return flow. The reviewer must experience Levels 1–6 in catalog order and attempt Level 6 without route guidance, solver output, a next-move hint, an operational explanation, or prior exposure to the project.

This task must determine:

1. whether a genuinely fresh player can understand the existing tutorials and onboarding sequence;
2. whether normal progression reaches and unlocks Level 6 correctly;
3. whether Level 6 produces the intended first meaningful difficulty rise rather than only longer execution;
4. whether the player can reason about two causally distinct Door-opening windows;
5. whether Door state, Plate causality, ECHO replay, Timeline, and Help are observable enough to support planning;
6. whether completion comes primarily from planning, bounded trial-and-error, or accidental discovery;
7. whether any P0/P1 requires a separately authorized repair before Level 7 or candidate-content work;
8. whether the evidence is sufficient for GPT to consider Level 6 for `FRESH_PLAYER_REVIEWED`.

This task is a human-evidence and documentation gate. It does not authorize implementation, content edits, balance changes, Level 7, assets, audio, narrative, Gate, persistence, export, release, or submission work.

## 2. Claim boundary

A positive result may support a later GPT verdict that Level 6 has reached:

```text
FRESH_PLAYER_REVIEWED
```

Only GPT may issue that status after reviewing the committed evidence.

This task does not itself establish:

- `CANDIDATE_ACCEPTED`;
- final balance or fun across multiple players;
- complete-flow acceptance;
- final tutorial acceptance;
- accessibility, localization, controller, save, settings, export, Web, release, or submission readiness;
- Level 7 or Level 8 authorization;
- final content count;
- final art, font, audio, narrative, or license acceptance.

One fresh reviewer is meaningful evidence, not a population estimate. Record uncertainty honestly.

## 3. Reviewer qualification gate

A qualifying reviewer must satisfy all of the following before the game is launched:

1. is not the authenticated project owner;
2. is not a repository contributor, Codex operator, implementation reviewer, project advisor, or prior tester;
3. has never played any Delayed Self build;
4. has not watched a Delayed Self playthrough, capture, stream, or demonstration;
5. has not read project source documents, task files, validation reports, solver witnesses, level maps, walkthroughs, or movement sequences;
6. has not been told the solution, the intended route, the two-Door timing chain, `L*`, `N*`, or any Level 6 operational hint;
7. agrees that only bounded, non-identifying review notes will be recorded;
8. can control the game directly during the attempt.

Use a non-identifying reviewer label such as:

```text
fresh_reviewer_01
```

Do not record the reviewer’s legal name, contact details, workplace, account identifiers, face, voice, or unrelated personal information.

Before launch, record direct answers to:

1. Have you played this game or any earlier build before?
2. Have you seen screenshots, videos, maps, solutions, or someone else playing it?
3. Has anyone explained the ECHO, Plate, Door, Timeline, or Level 6 puzzle to you?
4. Have you read any source, task, test, validation, or design document for this project?
5. Are you involved in developing, reviewing, or advising this project?

All five answers must support qualification. If any answer creates material prior exposure or project involvement, do not describe the review as fresh or independent.

If no qualifying reviewer is present, complete only the safe startup and baseline checks, launch nothing for the owner as a substitute, make no repository write, and stop with:

```text
READY_FOR_FRESH_LEVEL_6_SEQUENCE_REVIEW
```

The owner’s prior project exposure means an owner replay cannot substitute for this gate.

## 4. Mandatory startup gate

Before running Godot or creating evidence:

```powershell
Get-Location
git branch --show-current
git rev-parse HEAD
git rev-parse origin/main
git remote -v
git status --short --untracked-files=all
git log -28 --oneline --decorate
godot --version
Get-Command godot | Format-List Source,Version,CommandType
```

Required:

- absolute root is exactly `D:\Delayed_Self`;
- branch is `main`;
- origin is the expected repository;
- worktree is fully clean, including untracked files;
- local `HEAD == origin/main` and both contain this task;
- the current branch contains the Task 0012 acceptance and Task 0012S synchronization artifacts;
- Godot is the accepted `4.7.stable.steam.5b4e0cb0f` executable, unless the current environment record documents an equivalent accepted executable.

If clean local `main` is behind, use only:

```powershell
git fetch origin
git merge --ff-only origin/main
```

Stop on divergence, conflict, unexpected files, wrong root, wrong remote, inability to fast-forward, missing governance artifacts, or materially different Godot executable/version.

## 5. Required reads

Read in order:

1. `AGENTS.md`;
2. `docs/CODEX_STARTUP_SNAPSHOT_CURRENT.md`;
3. `docs/CODEX_ACTIVE_TASK_CURRENT.md`;
4. this task;
5. `docs/reports/0012_GPT_FINAL_ACCEPTANCE.md`;
6. `docs/reports/0012_LEVEL_6_STAGGERED_DOORS_REPORT.md`;
7. `docs/reports/0012S_PROJECT_SOURCE_SYNC_REPORT.md`;
8. `docs/level_design/FIVE_LEVEL_DIFFICULTY_RECOVERY_AND_LEVELS_6_8_PLAN.md`;
9. `docs/level_design/INITIAL_LEVEL_ROADMAP_AND_VALIDATION_MATRIX_CURRENT.md`;
10. `docs/reviews/0009AV_OWNER_FIVE_LEVEL_SEQUENCE_REVIEW.md` only to preserve known owner-review limitations and avoid repeating its claims;
11. current catalog contract and tracked six-entry catalog;
12. evidence/privacy, independent-review, puzzle-validation, Git, and Godot-safety project rules;
13. current index, development plan, handoff, and project memory.

Do not show any of these documents to the fresh reviewer.

Before execution, print a concise operator summary covering:

- reviewer qualification requirements;
- normal six-level launch path;
- no-hint boundary;
- Level 6 primary questions;
- source/content/test freeze;
- evidence and privacy boundaries;
- baseline markers and accepted Level 6 metrics;
- documentation-only commit policy;
- P0/P1 stop rules;
- terminal verdicts.

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
- save/player-data behavior;
- export, build, release, account, repository-setting, or submission surfaces;
- accepted task, report, validation, contract, or acceptance artifacts.

Do not fix a problem during the review. Record it, preserve evidence, and return it for a separately authorized GPT task.

Do not delete or reset repository files, `.godot`, user data, caches, previous evidence, or settings. Do not use `git clean`, broad restore, reset, rebase, amend, or force-push.

## 7. Baseline regression preflight

Run the accepted aggregate suite in a fresh native process. Preserve the native process exit code and keep stdout/stderr bounded and separate.

Use the accepted command unless the current environment record specifies an equivalent accepted command:

```powershell
godot --headless --path D:\Delayed_Self --script res://tests/run_all.gd
```

Require exit code `0` and all eight markers exactly once:

```text
TASK_0003_TESTS_PASS assertions=349 vectors=9
TASK_0006_APP_SHELL_TESTS_PASS
TASK_0007_TUTORIAL_LEVELS_TESTS_PASS
TASK_0008_PROGRESSIVE_HUD_TESTS_PASS
TASK_0009AR_LEVELS_4_5_TESTS_PASS
TASK_0011_PRESENTATION_RECOVERY_TESTS_PASS
TASK_0011R_WINDOW_FILL_TESTS_PASS
TASK_0012_STAGGERED_DOORS_TESTS_PASS
```

Do not infer failure from stderr presence alone. The known intentional negative-path `LEVEL_ID_MISMATCH` may appear on stderr during a passing suite. The authoritative signals are native exit code, failed assertions or unhandled errors, and marker completeness.

Require accepted Level 6 facts unchanged:

```text
level_id = staggered_doors
L* = 15
N* = 4
N* status = EXACT
visited_states = 6772
maximum_frontier = 1179
formal_sha256 = 3f14c19b50775e36dd5b52664798381cf1292b0a30b377641c03435f45696bc8
```

Also require the prior five formal hashes and accepted metrics unchanged.

If the suite exits nonzero, any marker is absent/duplicated, an unhandled parser/script/runtime error occurs, a formal hash changes, or accepted metrics drift, stop without launching the human review:

```text
BLOCKED_BASELINE_REGRESSION
```

Do not edit implementation or tests.

## 8. External evidence and privacy boundary

This task authorizes creation/use of exactly:

```text
D:\Delayed_Self_Evidence\0013_fresh_level_6_sequence_review\
```

First verify that the path is a safe directory and does not contain unrelated evidence that would be overwritten. Never delete, rename, move, or replace unrelated files.

Allowed external evidence:

- bounded baseline stdout/stderr and native exit summary;
- launch command and executable identity;
- plain-text qualification answers;
- plain-text reviewer observations and direct answers;
- per-level attempt records;
- reviewer-supplied timing, turn, restart, Help, and Timeline facts;
- deliberately approved game-window-only screenshots;
- an evidence index with filenames, timestamps, byte sizes, and SHA-256 values.

Forbidden evidence:

- automatic full-desktop capture;
- face or voice recording;
- browser, email, notifications, credentials, account information, or unrelated windows/files;
- background keyboard logging or raw input capture outside the game;
- hidden telemetry;
- personal identity details;
- staging or committing screenshots, recordings, raw long logs, or the external evidence directory.

The reviewer may decline screenshots or measurements. Missing data must be `NOT_PROVIDED`, never estimated or inferred.

## 9. Fresh sequence-review protocol

### 9.1 Process reset and launch

1. close any existing Godot game process for this project without killing unrelated processes;
2. launch a fresh normal AppRoot process;
3. do not use a direct-level argument, debug teleport, scene override, modified catalog, or pre-unlocked route;
4. begin at Main Menu and enter Level Select normally;
5. start with the first catalog level and progress through Levels 1–6 in the intended unlock order;
6. let the reviewer control the keyboard directly;
7. do not display source, console, validation data, task text, metrics, maps, or evidence notes on the reviewer’s screen.

Do not delete user data to reset progress. If persistent state unexpectedly bypasses the intended sequence and no accepted safe isolated profile is documented, stop and report the blocker rather than deleting or modifying user data.

### 9.2 Exact assistance boundary

Before play, tell the reviewer only:

```text
Please start from the main menu and play the levels in the order the game unlocks them. Use only the controls, text, Timeline, and Help available inside the game. Say when you complete a level, give up, encounter a bug, or choose to stop. I cannot give movement, timing, route, or puzzle hints during the qualifying attempt. After Level 6, I will ask what you think happened and how you planned it.
```

Codex, the owner, and any observer must not provide during an active attempt:

- a movement sequence;
- the next move;
- a route or destination suggestion;
- a timing count;
- a Plate/Door pairing explanation;
- a reminder that reveals which past input will replay;
- a gesture, cursor point, key press, or facial/verbal cue indicating the solution;
- the solver witness, shortest path, metrics, map, or validation trace;
- confirmation that a proposed move is correct or incorrect.

Technical help is limited to restoring window focus, confirming that the game is running, or reading a control already visible in the game. Technical help must not alter puzzle state or interpretation.

If the reviewer asks for a puzzle hint, first ask whether they want to end the qualifying attempt. Any operational hint after that point makes the remainder `ASSISTED` and cannot support `FRESH_PLAYER_REVIEWED`.

Do not silently restart or correct a reviewer action.

### 9.3 Per-level records

For each of Levels 1–6, record only directly observed or reviewer-reported facts:

- catalog position and level ID/title shown by the game;
- attempt status: `COMPLETED_UNASSISTED`, `COMPLETED_ASSISTED`, `GAVE_UP`, `BLOCKED_BY_BUG`, `INTERRUPTED`, or `NOT_REACHED`;
- whether normal completion, unlock, and return-to-selection worked;
- final visible turn count, when directly visible and recorded;
- approximate elapsed time and restart count, only when supplied or directly measured with reviewer consent;
- whether Help was opened;
- whether compact/expanded Timeline was used;
- whether the reviewer verbalized a plan before acting, only when spontaneously supplied;
- visible confusion, clipping, crowding, unreadable state, or unresponsive-looking behavior;
- direct short comment after the level;
- optional approved game-window-only screenshot reference.

For Levels 1–5, keep questioning brief so the sequence is not coached. After each level, ask only:

1. What did you think that level was teaching?
2. Was anything unclear or unnecessarily slow?

Do not tell the reviewer whether the answer is correct before Level 6 ends.

### 9.4 Level 6 attempt

Level 6 is the primary evidence target.

Do not state its intended rule before or during the attempt. Do not reveal that there are exactly two useful Door windows, which Plate controls which Door, or when a Door is traversable.

The planning target in the current design source is approximately 3–7 minutes and 0–3 restarts, but these are review targets, not hard pass/fail thresholds and must not be shown to the reviewer.

If the Level 6 attempt reaches approximately 15 minutes without completion, ask only:

```text
Would you like to continue without a hint, stop the attempt, or end the qualifying attempt and request assistance?
```

Do not impose a forced stop if the reviewer wants to continue unassisted. Record the choice exactly.

Immediately after the unassisted attempt ends, and before any reveal or explanation, ask:

1. What did you think the ECHO was doing with your earlier inputs?
2. Why did the first Door become passable when it did?
3. Why did the second Door become passable when it did?
4. Did you think the two Doors depended on the same event or on two different events?
5. How did you decide when to cross each Door?
6. Did you solve mainly by planning, trial-and-error, or accidental discovery?
7. Which future-relevant state was hardest to see or remember?
8. Did Timeline help you predict an action, merely confirm it, or add clutter?
9. Did Help provide useful information, reveal too much, or remain unnecessary?
10. Did any Door feel arbitrary, delayed without feedback, or visually open/closed at the wrong time?
11. Did the level feel easier, harder, or appropriately harder than Level 5?
12. Would you want to continue to another level after this one?
13. In your own words, what plan would you use if you replayed the level?

Optional 1–5 ratings:

- onboarding clarity across Levels 1–5;
- Level 6 objective clarity;
- ECHO predictability;
- Plate-to-Door causality;
- Door-window readability;
- Timeline usefulness;
- Help usefulness;
- information density/readability;
- Level 6 difficulty;
- frustration;
- satisfaction on completion;
- willingness to continue.

Missing answers and ratings are `NOT_PROVIDED`.

Do not reveal the solver witness or exact movement sequence after the questionnaire. A high-level explanation may be deferred until the review evidence is safely recorded, but it is not required by this task.

## 10. Evidence interpretation

Separate in all notes:

- direct reviewer statements;
- directly observed runtime facts;
- operator interpretation;
- unresolved uncertainty.

Do not rewrite the reviewer’s words to make them match the intended design.

### 10.1 Qualifying positive evidence

Recommend GPT consideration of `FRESH_PLAYER_REVIEWED` only when all are true:

1. reviewer qualification is complete and credible;
2. Levels 1–6 are reached through normal progression;
3. Level 6 is completed without operational assistance;
4. no P0/P1 is present;
5. the reviewer’s pre-reveal explanation demonstrates understanding that earlier inputs are replayed by the ECHO;
6. the explanation distinguishes two causally separate Plate/Door opportunities or otherwise accurately describes two separate timing obligations;
7. the reviewer can explain how they chose both Door crossings without being supplied the route;
8. completion is not credibly attributable only to an unintended shortcut or accidental state;
9. repository baseline and formal Level 6 evidence remain unchanged.

Exact terminology, shortest play, low restart count, Timeline use, or Help use is not required.

### 10.2 Non-promotion outcomes

Do not recommend promotion when:

- reviewer is not fresh or independent;
- any movement/timing/route hint was supplied;
- Level 6 was not reached;
- Level 6 was completed only after assistance;
- the reviewer completed but cannot explain the core delayed causality before reveal;
- a bug, progression failure, unreadable state, or contradiction materially affected the attempt;
- evidence is missing or contradictory enough that qualification cannot be established.

A non-promotion result is still valid evidence and should normally be recorded rather than discarded.

## 11. Finding severity and gate logic

Classify conservatively:

- `P0`: crash, launch/input failure, corrupted state, impossible progression caused by defect, broken completion/unlock flow, or a confirmed baseline regression;
- `P1`: a material defect prevents normal completion or understanding of the core ECHO/Plate/Door relationship; Door state contradicts visible feedback; the reviewer cannot recover necessary information; or Level 6 can only be passed through an unintended bypass that defeats its teaching role;
- `P2`: substantial friction, repeated confusion, weak observability, trial-and-error completion, large difficulty overshoot, Timeline/Help/readability problem, or a reviewer give-up not clearly caused by a blocking defect;
- `P3`: wording, polish, preference, minor pacing, or future enhancement.

One reviewer’s subjective dislike is not automatically P1. One reviewer’s completion is not automatically proof of balance or fun.

Gate outcomes:

1. qualifying, unassisted completion with accurate causal explanation and P0=0/P1=0:
   - record evidence;
   - recommend GPT consideration of `FRESH_PLAYER_REVIEWED` for Level 6;
   - do not authorize Level 7 automatically.
2. review completed but promotion criteria not met, with P0=0/P1=0:
   - record evidence;
   - recommend either another fresh review or a bounded presentation/difficulty analysis;
   - do not label Level 6 fresh-player reviewed.
3. any P0/P1:
   - record the issue and bounded evidence;
   - recommend a separately authorized repair/diagnostic task;
   - do not edit implementation or content.
4. reviewer unavailable:
   - make no repository review commit;
   - stop ready for the later human session.

## 12. Authorized repository writes

After an actual review attempt, create only:

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

Do not modify prior tasks, reports, reviews, validations, acceptances, project rules, contracts, GDD, source, content, tests, schemas, fixtures, assets, imports, audio, plugins, dependencies, or project settings.

The review document must include:

- reviewer label and qualification answers;
- exact review classification;
- accepted implementation commit and formal Level 6 SHA-256;
- environment, executable, and launch path;
- preflight exit code, markers, metrics, and hash confirmation;
- assistance boundary and whether it was preserved;
- six per-level records;
- complete pre-reveal Level 6 answers;
- optional ratings exactly as supplied;
- direct statements separated from interpretation;
- P0/P1/P2/P3 findings;
- promotion-criteria matrix;
- explicit non-claims;
- external evidence index;
- recommended next gate.

Use one exact review classification:

```text
QUALIFYING_FRESH_INDEPENDENT_SEQUENCE_REVIEW
FRESH_BUT_ASSISTED_SEQUENCE_REVIEW
NONQUALIFYING_PRIOR_EXPOSURE_REVIEW
INCOMPLETE_FRESH_SEQUENCE_REVIEW
BLOCKED_BY_RUNTIME_OR_PROGRESSION_DEFECT
```

The execution report must include:

- terminal verdict;
- start/final Git facts;
- created and updated repository paths;
- external evidence root and indexed files;
- qualification outcome;
- six-level attempt summary;
- Level 6 completion/assistance/comprehension summary;
- finding counts by severity;
- promotion recommendation or reason withheld;
- confirmation that implementation/content/tests/formal data did not change;
- next-gate recommendation.

## 13. Validation and Git discipline

Before staging:

```powershell
git status --short --untracked-files=all
git diff --check
git diff --stat
```

Audit:

- only authorized Markdown files changed;
- reviewer qualification is explicit;
- no owner replay is mislabeled as fresh;
- no assisted attempt is mislabeled as unassisted;
- direct answers are faithful and missing data is `NOT_PROVIDED`;
- no solver witness, route, or unnecessary personal data is committed;
- no screenshot, recording, raw long log, external evidence, implementation, content, test, schema, fixture, asset, import, or user-data file is staged;
- all current documents agree on the review result and next gate;
- no Level 7, candidate, export, release, or submission authorization is implied;
- all added links resolve.

Stage explicit files only. Never use `git add .` or `git add -A`.

Then run:

```powershell
git diff --cached --check
git diff --cached --stat
git diff --cached --name-only
```

This task authorizes one documentation-only commit after an actual review:

```text
docs: record Delayed Self fresh Level 6 sequence review
```

Immediately before push:

```powershell
git fetch origin
git rev-parse HEAD
git rev-parse origin/main
git status --short --untracked-files=all
```

Require no remote drift. Push normally to `origin/main`.

Forbidden:

- broad staging;
- merge commit;
- rebase;
- amend;
- force-push;
- reset;
- broad restore;
- `git clean`;
- implementation or content commit;
- a second commit for the same review.

After push, require:

```powershell
git status --short --untracked-files=all
git rev-parse HEAD
git rev-parse origin/main
```

The repository must be clean and `HEAD == origin/main`.

## 14. Terminal verdicts

Use exactly one terminal verdict:

```text
FRESH_LEVEL_6_SEQUENCE_REVIEW_RECORDED_FOR_GPT_REVIEW
```

Use after a review was conducted, recorded, committed, and pushed, regardless of whether promotion is recommended, provided no P0/P1 requires the blocked verdict below.

```text
READY_FOR_FRESH_LEVEL_6_SEQUENCE_REVIEW
```

Use when baseline is healthy but no qualifying reviewer is currently available. Make no repository write or review commit.

```text
BLOCKED_REVIEWER_NOT_QUALIFYING
```

Use when the proposed reviewer fails qualification before play and no qualifying reviewer is available. Make no repository review commit.

```text
BLOCKED_BASELINE_REGRESSION
```

Use when the preflight baseline, markers, metrics, or hashes fail. Do not launch the review.

```text
BLOCKED_FRESH_LEVEL_6_SEQUENCE_P0_P1
```

Use after faithfully recording, committing, and pushing an actual review that identifies any P0/P1 requiring a separate repair or diagnostic task.

```text
BLOCKED
```

Use only for another explicit safety, Git, privacy, evidence, environment, or scope blocker.

No terminal verdict is final GPT acceptance.

## 15. Next gate

- qualifying positive review: GPT adjudicates whether Level 6 reaches `FRESH_PLAYER_REVIEWED`, then separately selects either another review, a bounded Level 7 planning task, or a presentation repair;
- non-promotion without P0/P1: GPT selects another fresh reviewer or a focused evidence/UX task;
- P0/P1: GPT issues a separately bounded diagnostic or repair task;
- reviewer unavailable: rerun this same task later with a qualifying reviewer;
- Level 7, candidate acceptance, assets/fonts/audio/narrative, Gate, persistence, export, release, and submission remain unauthorized until separately tasked.
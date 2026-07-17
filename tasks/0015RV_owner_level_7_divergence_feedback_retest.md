# Task 0015RV — Authenticated-owner Level 7 divergence-feedback retest

- Status: `READY`
- Gate: `HUMAN EVIDENCE / OWNER RETEST / BLOCKING P2 ADJUDICATION`
- Repository: `zcx369658780/delayed-self-godot`
- Expected branch: `main`
- Expected local root: `D:\Delayed_Self`
- Issued by: GPT Project Sources advisor
- Date: 2026-07-17
- Repair implementation: `538ced4c24beca1d7b143e9934fd9f10554b64b4`
- Repair acceptance: `docs/reports/0015R_GPT_FINAL_ACCEPTANCE.md`
- Repair acceptance commit: `5ca90b4d11e463f2010bc801c84a8199db31c990`
- Accepted Level 7 implementation: `27a678da47d1ba34ed012f8840b8c80c775e8be1`
- Formal Level 7 SHA-256: `772410d3b8bb807e35472ee2a7d07b703de66e1e0e92ffb4d1ff8433a345d5fd`
- Open finding: `BLOCKING_P2_FALSE_UNSOLVABLE_MENTAL_MODEL_AND_RECOVERY_FAILURE`
- Owner exposure: `PRIOR_EXACT_WITNESS_EXPOSURE_PRESENT`

## 1. Objective

Conduct one authenticated-owner retest of the repaired Level 7 presentation and determine whether the transition-derived ECHO divergence feedback closes, materially reduces, or fails to reduce the blocking false-unsolvable mental model.

The exact review classification is:

```text
AUTHENTICATED_OWNER_NOT_FRESH_NOT_INDEPENDENT_LEVEL_7_DIVERGENCE_FEEDBACK_RETEST
```

The owner has already seen the exact 19-action witness during Task 0015D. Therefore this task does **not** test blind route discovery, fresh difficulty, first-player comprehension, or unbiased completion.

The primary questions are:

1. does the owner notice the `ECHO SPACING CHANGED` feedback during normal play;
2. does the owner correctly read the actual `MOVED`, `BLOCKED`, or `WAITED` E2/E4 outcomes;
3. does the owner understand that different history slots, prior positions, and terrain/blocking can change relative ECHO spacing;
4. does the owner stop treating the two-ECHO spacing as a fixed invariant;
5. does the cue support a credible experiment or recovery strategy without revealing a route;
6. is the cue readable, truthful, non-obstructive, and not excessively noisy;
7. should the blocking P2 be closed, materially reduced, or left open;
8. whether Level 8 may proceed to planning or the geometry fallback must be considered.

## 2. Durable constraints

The owner is the only available playtester. Do not seek, require, contact, recruit, or suggest any third party.

Carry forward:

```text
FRESH_INDEPENDENT_REVIEW_UNAVAILABLE_BY_OWNER_CONSTRAINT
PRIOR_EXACT_WITNESS_EXPOSURE_PRESENT
```

Do not label this retest fresh, blind, first-player, independent, population-level, or route-discovery evidence.

Do not display, repeat, paste, read aloud, or reconstruct the exact Task 0015/0015D witness before or during the active retest. Do not show solver output, coordinates, target spacing, next actions, Plate assignments, or recovery paths.

Because prior exact exposure already exists, a completed run is useful only as runtime and owner-experience evidence. It cannot prove independent discovery or difficulty.

## 3. Implementation and content freeze

This task is human evidence and documentation only.

Do not modify:

- `project.godot`;
- `scripts/`;
- `scenes/`;
- `data/`;
- `schemas/`;
- `tests/`;
- fixtures;
- Timeline or Help;
- formal levels or catalog;
- assets, fonts, audio, shaders, imports, plugins, or dependencies;
- simulation, solver, gameplay rules, progression, save data, settings, build, export, release, accounts, repository settings, or Level 8 content.

Do not fix or tune anything during the retest. Record findings and return them for GPT adjudication.

## 4. Mandatory startup gate

Before running Godot or creating review evidence:

```powershell
Get-Location
git branch --show-current
git rev-parse HEAD
git rev-parse origin/main
git remote -v
git status --short --untracked-files=all
git log -44 --oneline --decorate
& 'D:\Program Files (x86)\Steam\steamapps\common\Godot Engine\godot.windows.opt.tools.64.exe' --version
Get-Command 'D:\Program Files (x86)\Steam\steamapps\common\Godot Engine\godot.windows.opt.tools.64.exe' | Format-List Source,Version,CommandType
Get-Process | Where-Object { $_.ProcessName -match 'godot' }
```

Required:

- root exactly `D:\Delayed_Self`;
- branch `main`;
- expected origin;
- fully clean tracked and untracked worktree;
- local and remote contain this task, the Task 0015R acceptance, implementation, repair plan, Task 0015V adjudication, and Task 0015 acceptance;
- accepted Godot `4.7.stable.steam.5b4e0cb0f` executable or an accepted equivalent documented in the environment record;
- no existing project game process.

If clean local `main` is behind, use only:

```powershell
git fetch origin
git merge --ff-only origin/main
```

Stop on divergence, conflict, wrong root/remote, unexpected files, inability to fast-forward, or materially different toolchain.

Before the first Godot process, record:

```powershell
git hash-object project.godot
git rev-parse HEAD:project.godot
git ls-files --others --exclude-standard
```

Require the worktree file hash to equal `HEAD:project.godot` and the untracked list to be empty.

## 5. Required reads

Read in order:

1. `AGENTS.md`;
2. current startup and active-task documents;
3. this task;
4. `docs/reports/0015R_GPT_FINAL_ACCEPTANCE.md`;
5. `docs/reports/0015R_LEVEL_7_ECHO_DIVERGENCE_FEEDBACK_REPAIR_REPORT.md`;
6. `docs/level_design/LEVEL_7_FALSE_UNSOLVABLE_REPAIR_PLAN_CURRENT.md`;
7. `docs/reports/0015V_GPT_OWNER_LEVEL_7_REVIEW_ADJUDICATION.md`;
8. `docs/reviews/0015V_OWNER_TARGETED_LEVEL_7_REVIEW.md`;
9. `docs/reports/0015_GPT_FINAL_ACCEPTANCE.md`;
10. current evidence/privacy, owner-review, Git-safety, and Godot-safety rules;
11. current handoff, plan, index, and project memory.

Do not show these documents to the owner during the active retest.

Before launch, print a concise operator summary covering:

- prior exact-witness exposure and its claim limitation;
- no-hint boundary;
- cue-noticing and causal-understanding questions;
- no implementation changes;
- evidence/privacy boundary;
- generated-file cleanup authorization in Section 12;
- finding severity and terminal verdicts.

## 6. Baseline regression gate

Prefer reuse of the accepted Task 0015R aggregate evidence when all are true:

- the Task 0015R implementation commit is unchanged;
- commits since it contain only the Task 0015R GPT acceptance and this task;
- the Task 0015R evidence index, report, exact outputs, seven hashes, and capture results remain readable and internally consistent;
- no source, content, test, formal, or project-setting file changed.

Accepted reusable baseline:

```text
native exit = 0
TASK_0003_TESTS_PASS assertions=391 vectors=9
all ten markers exactly once
stderr = LEVEL_ID_MISMATCH only
Level 7 L*=19
Level 7 N*=6 EXACT
visited_states=61975
maximum_frontier=21449
Level 7 SHA-256=772410d3b8bb807e35472ee2a7d07b703de66e1e0e92ffb4d1ff8433a345d5fd
```

If reuse cannot be fully established, run the aggregate once before the human retest. If it fails, do not launch the review and stop:

```text
BLOCKED_BASELINE_REGRESSION
```

Do not rerun the aggregate merely for duplication when reuse is fully verified.

## 7. External evidence and privacy

Authorized external root:

```text
D:\Delayed_Self_Evidence\0015RV_owner_level_7_divergence_retest\
```

Allowed evidence:

- startup and baseline summary;
- executable identity and launch command;
- direct owner statements and answers;
- attempt timing, turns, restarts, Help/Timeline use only when supplied or directly observed with consent;
- deliberately approved game-window-only screenshots;
- bounded operator observations;
- generated-file cleanup inventory if Section 12 is needed;
- timestamped evidence index with sizes and SHA-256.

Forbidden:

- full desktop capture;
- face or voice recording;
- raw keyboard logging;
- browser, account, notification, email, credential, or unrelated-window capture;
- hidden telemetry;
- personal identity details;
- staging external evidence, screenshots, raw long logs, `.godot`, `.gd.uid`, or generated files.

Missing information is `NOT_PROVIDED`, never estimated.

## 8. Retest launch and instruction

Close any existing project game process without affecting unrelated processes. Launch Level 7 in one fresh native process through the accepted generic direct-level path:

```text
--level-id=two_echo_convergence
```

Use the normal 960×540 product window. Do not use an editor-embedded preview, modified level, debug teleport, alternate catalog, or solver-assisted route.

Before play, tell the owner only:

```text
This retest checks whether the new ECHO outcome and spacing-change feedback explains what is happening. You have previously seen the exact solution, so completion will not be treated as blind discovery. Please play using the current game screen without consulting the old sequence. Say when you notice any spacing-change message, explain what you think it means, and say if any message appears wrong, cluttered, or unhelpful. I will not provide movement, route, timing, or next-action hints during the attempt.
```

The owner may decline or stop at any time.

## 9. Assistance boundary

During the active attempt, do not provide:

- any movement sequence;
- the next move;
- route, branch, destination, or timing advice;
- the old exact witness;
- target separation or coordinates;
- E2/A or E4/B assignment reminders;
- correctness confirmation for proposed moves;
- solver output or recovery paths;
- gestures, cursor points, key presses, or verbal cues indicating a solution.

Technical help is limited to restoring window focus, confirming that the game is running, or reading an already visible control.

If the owner asks for a route or solution, ask whether they want to end the active retest. Any subsequent operational help makes the remainder assisted and cannot support closure through unassisted experience. The owner may still answer causal questions afterward.

## 10. Facts to record

Record separately:

- direct owner statements;
- directly observed runtime facts;
- operator interpretation;
- unresolved uncertainty.

Attempt record:

- status: `COMPLETED_UNASSISTED`, `COMPLETED_ASSISTED`, `GAVE_UP`, `INTERRUPTED`, or `BLOCKED_BY_BUG`;
- final visible turn if directly observed;
- elapsed time and restarts only as supplied or directly measured with consent;
- Help use;
- Timeline use;
- whether the cue appeared;
- whether the owner spontaneously noticed it;
- whether the owner read the actor outcomes correctly;
- whether stable-spacing turns avoided false cues;
- whether the cue obscured or confused other information;
- whether any displayed outcome contradicted the visible transition;
- whether the owner consulted the previous exact sequence; record the answer without treating it as fresh qualification.

## 11. Post-attempt questions

After the active attempt ends and before any new explanation, ask:

1. Did you notice `ECHO SPACING CHANGED` without being prompted? When?
2. What did the E2/E4 `MOVED`, `BLOCKED`, or `WAITED` labels mean to you?
3. Do you now think the distance and direction between E2 and E4 are fixed or changeable? Why?
4. What can make their relative spacing change?
5. Did the feedback show something you could already see, or did it correct your earlier model?
6. Was any outcome label inaccurate or inconsistent with the visible movement?
7. Did the cue appear when spacing looked stable?
8. Was the cue readable without obscuring ECHOs, YOU, Plates, the Door, EXIT, dependencies, or HUD text?
9. Did reduced-motion or static presentation matter to you? If not tested, record `NOT_PROVIDED`.
10. Did Timeline help, clutter, or remain unused?
11. Did Help help, clutter, or remain unused?
12. When stuck, what experiment or recovery strategy would you try now?
13. Do you still consider the tracked Level 7 mathematically impossible?
14. Should this feedback be preserved, revised, or removed?
15. Should the project proceed to Level 8 planning, or does Level 7 still require the geometry fallback?

Do not correct the answers until all questions are recorded.

Optional ratings are `NOT_PROVIDED` unless the owner supplies them.

## 12. Explicit generated-file cleanup authorization

Godot previously rewrote `project.godot` and generated `.gd.uid` files during Task 0015R. This task pre-authorizes a narrow post-review cleanup only when all conditions below hold.

After all Godot processes are closed, inspect:

```powershell
git status --short --untracked-files=all
git diff --name-only
git diff --cached --name-only
git ls-files --others --exclude-standard
Get-Process | Where-Object { $_.ProcessName -match 'godot' }
```

Before documentation edits or staging, cleanup is authorized only if:

- there is no staged path;
- `project.godot` is the only unstaged tracked path;
- every untracked path ends exactly in `.gd.uid`;
- no other tracked or untracked path exists;
- no Godot process remains;
- every `.gd.uid` path is repository-relative, contains no `..`, resolves under `D:\Delayed_Self`, exists as a regular file, is not a reparse point, is not tracked, and is not staged.

Freeze and print the exact untracked list:

```powershell
$AllUntracked = @(git ls-files --others --exclude-standard)
$UidPaths = @($AllUntracked | Where-Object { $_ -like '*.gd.uid' } | Sort-Object -Unique)
$UidPaths
$UidPaths | Set-Content -LiteralPath 'D:\Delayed_Self_Evidence\0015RV_owner_level_7_divergence_retest\uid_paths_frozen.txt' -Encoding utf8
```

Require `$AllUntracked.Count -eq $UidPaths.Count` and every entry to satisfy the checks above.

Restore only the worktree copy of the literal tracked path:

```powershell
git restore --worktree --source=HEAD -- project.godot
```

Verify its worktree blob equals `HEAD:project.godot` and it is not staged.

Delete only the frozen literal UID paths, one at a time:

```powershell
foreach ($RelativePath in $UidPaths) {
    $LiteralPath = Join-Path 'D:\Delayed_Self' $RelativePath
    Write-Host ('REMOVE_LITERAL ' + $RelativePath)
    Remove-Item -LiteralPath $LiteralPath -Force
}
```

Do not use `git clean`, recursive deletion, wildcard deletion, broad restore, reset, checkout, stash, or parent-directory deletion.

After cleanup require no generated or unrelated path remains. If the worktree differs from the exact authorized pollution pattern, stop without cleanup:

```text
BLOCKED_UNEXPECTED_WORKTREE_CHANGE
```

If literal cleanup is incomplete, stop:

```text
BLOCKED_LITERAL_GENERATED_FILE_CLEANUP_INCOMPLETE
```

## 13. Finding severity and adjudication matrix

Classify findings conservatively:

- `P0`: crash, launch/input failure, corruption, baseline regression, impossible progression caused by a confirmed defect;
- `P1`: the new cue materially misreports transition causality, changes canonical state, blocks normal play, or creates a contradiction that prevents correct understanding;
- `P2`: the fixed-spacing belief remains, the cue is not noticed, the cue is accurate but ineffective, readability/noise materially harms recovery, or route understanding remains blocked;
- `P3`: wording, visual polish, preference, or future enhancement.

Use one exact blocking-finding disposition:

```text
BLOCKING_P2_CLOSED_FOR_OWNER_EVIDENCE
BLOCKING_P2_MATERIALLY_REDUCED
BLOCKING_P2_NOT_REDUCED
```

### 13.1 Close for owner evidence

Use `BLOCKING_P2_CLOSED_FOR_OWNER_EVIDENCE` only when:

- P0=0 and P1=0;
- the cue is truthful and readable;
- the owner explicitly rejects the fixed-spacing invariant;
- the owner accurately explains that different history slots, prior positions, and blocking/movement outcomes can change relative spacing;
- the owner can describe a credible experiment or recovery strategy;
- the owner no longer considers the tracked Level 7 mathematically impossible.

Completion is not required because prior exact-witness exposure prevents clean route-discovery evidence.

### 13.2 Material reduction

Use `BLOCKING_P2_MATERIALLY_REDUCED` when:

- P0=0 and P1=0;
- the owner now accepts that spacing can change and no longer insists the level is impossible;
- but the cue required prompting, remains partly unclear/noisy, or the owner cannot yet give a robust causal explanation or recovery strategy.

This may support a small follow-up presentation adjustment before Level 8, depending on GPT adjudication.

### 13.3 Not reduced

Use `BLOCKING_P2_NOT_REDUCED` when any applies:

- the owner continues to treat spacing as fixed;
- the owner still considers the tracked level mathematically impossible;
- the cue is not noticed and does not change the model;
- the cue is misleading or contradicted by the visible transition;
- the cue creates material clutter or prevents correct interpretation;
- evidence is too incomplete or contradictory to support reduction.

This keeps Level 8 blocked and returns the project to the separately authorized geometry fallback decision.

## 14. Authorized repository writes

After an actual retest, create only:

```text
docs/reviews/0015RV_OWNER_LEVEL_7_DIVERGENCE_FEEDBACK_RETEST.md
docs/reports/0015RV_OWNER_LEVEL_7_DIVERGENCE_FEEDBACK_RETEST_REPORT.md
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
docs/level_design/LEVEL_7_FALSE_UNSOLVABLE_REPAIR_PLAN_CURRENT.md
docs/ux/PRESENTATION_VIEWPORT_AND_HUD_DIRECTION_CURRENT.md
```

Do not modify prior tasks, reports, reviews, validations, acceptances, implementation, tests, formal content, project rules, or GDD.

The review must include:

- exact classification and exposure flags;
- baseline disposition;
- assistance boundary;
- complete attempt record;
- direct answers to all post-attempt questions;
- cue-noticing and factual-accuracy observations;
- separation of direct statements, observed facts, interpretation, and uncertainty;
- P0/P1/P2/P3 findings;
- exact blocking-P2 disposition and criteria matrix;
- generated-file cleanup result if used;
- explicit non-claims;
- external evidence index;
- recommended next gate.

The report must include start/final Git facts, created/updated paths, evidence root, attempt summary, finding counts, disposition, cleanup summary, protected surfaces, and next-gate recommendation.

## 15. Git discipline

Before staging:

```powershell
git status --short --untracked-files=all
git diff --check
git diff --stat
```

Require only authorized Markdown paths changed and no generated file remains.

Stage explicit files only. Never use `git add .` or `git add -A`.

Then run:

```powershell
git diff --cached --check
git diff --cached --stat
git diff --cached --name-only
```

Commit exactly once:

```text
docs: record Delayed Self Level 7 divergence retest
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

- implementation/content/test commits;
- broad staging;
- rebase, amend, force-push, reset, stash, merge commit;
- broad restore or cleanup;
- committing screenshots, external evidence, `project.godot`, `.gd.uid`, `.godot`, caches, or logs.

After push require a clean worktree and `HEAD == origin/main`.

## 16. Terminal verdicts

After a completed retest, documentation commit, and push, return exactly one:

```text
OWNER_LEVEL_7_DIVERGENCE_RETEST_CLOSED_FOR_GPT_REVIEW
OWNER_LEVEL_7_DIVERGENCE_RETEST_REDUCED_FOR_GPT_REVIEW
OWNER_LEVEL_7_DIVERGENCE_RETEST_NOT_REDUCED_FOR_GPT_REVIEW
```

Use the terminal matching the exact blocking-P2 disposition.

Other blockers:

```text
BLOCKED_BASELINE_REGRESSION
BLOCKED_UNEXPECTED_WORKTREE_CHANGE
BLOCKED_LITERAL_GENERATED_FILE_CLEANUP_INCOMPLETE
BLOCKED_OWNER_RETEST_P0_P1
BLOCKED
```

No terminal verdict is final GPT acceptance.

## 17. Next gate

- `BLOCKING_P2_CLOSED_FOR_OWNER_EVIDENCE`: GPT may authorize bounded Level 8 planning while preserving the prior-exposure and owner-only evidence limitations;
- `BLOCKING_P2_MATERIALLY_REDUCED`: GPT decides between a small additional presentation adjustment and Level 8 planning with an explicit residual risk;
- `BLOCKING_P2_NOT_REDUCED`: Level 8 remains blocked and GPT may authorize only the geometry-only early-divergence fallback or another bounded diagnostic;
- any P0/P1: separately bounded repair/diagnostic task;
- no third-party review may be introduced unless the owner explicitly reverses the standing constraint.

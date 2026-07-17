# Task 0015R — Transition-derived ECHO divergence feedback repair

- Status: `READY`
- Gate: `PRESENTATION REPAIR + MACHINE/CAPTURE VALIDATION`
- Repository: `zcx369658780/delayed-self-godot`
- Expected branch: `main`
- Expected local root: `D:\Delayed_Self`
- Issued by: GPT Project Sources advisor
- Date: 2026-07-17
- Accepted repair plan: `docs/level_design/LEVEL_7_FALSE_UNSOLVABLE_REPAIR_PLAN_CURRENT.md`
- Plan acceptance: `docs/reports/0015D_GPT_FINAL_ACCEPTANCE.md`
- Plan acceptance commit: `234e0a06dd94d6b83025633ac6243bfe763aad90`
- Accepted Level 7 implementation: `27a678da47d1ba34ed012f8840b8c80c775e8be1`
- Accepted Level 7 SHA-256: `772410d3b8bb807e35472ee2a7d07b703de66e1e0e92ffb4d1ff8433a345d5fd`
- Blocking finding: `BLOCKING_P2_FALSE_UNSOLVABLE_MENTAL_MODEL_AND_RECOVERY_FAILURE`
- Selected bundle: `TRANSITION_DERIVED_ECHO_DIVERGENCE_FEEDBACK`

## 1. Objective

Implement and machine-validate one bounded, reusable, presentation-only repair that makes changing ECHO relative spacing observable at the moment it occurs.

The repair must teach this causal principle without revealing a route:

> Different ECHOs read different history slots. Their requested actions, prior positions, and terrain/blocking outcomes may differ, so their relative spacing can change.

The implementation must use only the already returned transition facts available to reusable Gameplay. It must not run a solver, duplicate collision or movement rules, inspect the Level 7 witness, or hardcode target positions, timing, Plate assignments, or solution steps.

This task ends after implementation, focused validation, captures, full regression, documentation, one commit, and push. It does **not** conduct the authenticated-owner retest. A later task may authorize that retest only after GPT accepts this repair.

## 2. Mandatory startup gate

Before any write or Godot run:

```powershell
Get-Location
git branch --show-current
git rev-parse HEAD
git rev-parse origin/main
git remote -v
git status --short --untracked-files=all
git log -40 --oneline --decorate
& 'D:\Program Files (x86)\Steam\steamapps\common\Godot Engine\godot.windows.opt.tools.64.exe' --version
Get-Command 'D:\Program Files (x86)\Steam\steamapps\common\Godot Engine\godot.windows.opt.tools.64.exe' | Format-List Source,Version,CommandType
```

Required:

- root exactly `D:\Delayed_Self`;
- branch `main`;
- expected origin;
- fully clean tracked and untracked worktree;
- local and remote contain this task, Task 0015D plan/report, Task 0015D GPT acceptance, Task 0015V adjudication, and Task 0015 acceptance;
- accepted Godot `4.7.stable.steam.5b4e0cb0f` executable or an exact equivalent documented in the current environment record.

If clean local `main` is behind, use only:

```powershell
git fetch origin
git merge --ff-only origin/main
```

Stop on divergence, conflict, unexpected files, wrong root/remote, inability to fast-forward, or materially different toolchain.

## 3. Required reads

Read in order:

1. `AGENTS.md`;
2. current startup and active-task documents;
3. this task;
4. `docs/reports/0015D_GPT_FINAL_ACCEPTANCE.md`;
5. `docs/level_design/LEVEL_7_FALSE_UNSOLVABLE_REPAIR_PLAN_CURRENT.md`;
6. `docs/reports/0015D_LEVEL_7_FALSE_UNSOLVABLE_DIAGNOSTIC_REPORT.md`;
7. `docs/reports/0015V_GPT_OWNER_LEVEL_7_REVIEW_ADJUDICATION.md`;
8. `docs/reviews/0015V_OWNER_TARGETED_LEVEL_7_REVIEW.md`;
9. `docs/reports/0015_GPT_FINAL_ACCEPTANCE.md`;
10. `docs/level_design/validation/TWO_ECHO_CONVERGENCE_VALIDATION.md`;
11. `scripts/gameplay/vertical_slice.gd`, especially `visual_feedback`, `_update_visual_feedback`, `_draw_echo_feedback`, presentation snapshots, restart/reset, and reduced-motion behavior;
12. shared Simulation transition result shape and current tests only to understand returned facts, never to duplicate rules;
13. current Task 0015 focused tests/capture harness and aggregate registration;
14. current presentation direction, handoff, development plan, index, and project memory.

Before editing, print a concise implementation summary containing:

- exact returned transition facts that will be consumed;
- feedback state shape;
- exact trigger/no-trigger conditions;
- board/HUD placement strategy;
- reduced-motion and grayscale strategy;
- focused tests and capture states;
- immutable formal hashes/metrics;
- exact selected repository paths;
- stop and rollback conditions.

## 4. Frozen authorities and non-goals

Treat as immutable:

- Godot/toolchain/renderer and 960×540 logical presentation;
- `simulation_v1`, `level_v1`, catalog-v1, solver behavior, action order, history semantics, legal overlap, blocked-action history, Door snapshots, Plate settlement, EXIT, restart, replay, and canonical key;
- every formal level and all seven accepted hashes/metrics;
- Level 7 delays, geometry, Plates, Door, EXIT, witness-independent machine facts, and catalog placement;
- A/B shapes and labels, A+B Door pips, E2/E4 badges/outlines, overlap identities, and accepted dependency cues;
- Timeline model, indexing, layout, visibility rules, and teaching disposition;
- Help architecture and copy;
- WAIT as deferred research;
- owner-only review constraint;
- Level 8 as blocked.

Do not modify:

```text
data/
schemas/
scripts/simulation/
scripts/solver/
scripts/app/
scenes/
project.godot
```

Also do not modify Timeline model/index/layout, Help architecture/copy, formal fixtures, assets, fonts, audio, shaders, imports, plugins, dependencies, save/player data, builds, export, release, accounts, repository settings, or Level 8 documents/content.

Do not:

- change E4 delay to 5;
- move either Plate;
- make the Door persistent, one-shot, latched, or permanently open;
- add an exact operation walkthrough;
- add a solver-backed recovery indicator;
- expose remaining moves, target spacing, next action, Plate assignment, route, witness, or coordinates;
- add push boxes or any new mechanic;
- use color as the sole cue;
- change formal Level 7 to make the presentation repair easier.

## 5. Existing source fact that must be used

Reusable Gameplay already calls:

```gdscript
_update_visual_feedback(before, result, action)
```

and receives:

- `before.echo_positions`;
- `result.state.echo_positions`;
- `result.actor_actions.echoes`, including each ECHO ID and actual replay action;
- existing E2/E4 definitions and badges;
- existing echo-trail presentation.

Use those facts directly. A cardinal action with unchanged before/after position may be labeled `BLOCKED`; a cardinal action with changed position may be labeled `MOVED`; `WAIT` may be labeled `WAITED`. This classification is presentation of returned outcomes, not a new collision calculation.

Do not call Simulation again from presentation to infer what happened. Do not inspect terrain to reconstruct movement legality. Do not derive or compare against a desired Level 7 state.

## 6. Feedback contract

Extend the reusable `visual_feedback` state with one bounded transition-derived structure, for example:

```text
echo_divergence
```

The exact internal field names may differ, but the snapshot must expose enough information for deterministic tests.

### 6.1 Applicability

The feedback may activate only when the current level has at least two ECHOs. Prefer the existing generic multi-ECHO/AND presentation predicate when appropriate. Do not branch on `configured_level_id == "two_echo_convergence"` and do not encode formal Level 7 coordinates or turn numbers.

Single-ECHO and zero-ECHO levels must retain their current appearance and behavior.

### 6.2 Actor outcome records

For each relevant ECHO, record from returned transition facts:

- stable ECHO ID;
- delay badge such as `E2` or `E4`;
- replay action;
- before position;
- after position;
- outcome exactly one of `MOVED`, `BLOCKED`, or `WAITED`;
- existing outline identity.

Do not call a cardinal no-move result `WAITED`. Do not call `WAIT` blocked.

### 6.3 Spacing-change trigger

For a stable pair ordered by delay and then ID, compute from before/after positions only:

- signed relative vector before and after;
- Manhattan spacing before and after.

Set the divergence cue visible only when the signed vector or Manhattan spacing changes. Stable spacing must produce no spacing-change cue.

The user-facing copy must be concise and non-route-specific, such as:

```text
ECHO SPACING CHANGED
```

When one ECHO is blocked and another moves, a compact factual line is allowed, such as:

```text
E2 BLOCKED · E4 MOVED
```

When outcomes differ for another reason, show only the true returned outcomes. Never state that both ECHOs received the same action unless `result.actor_actions.echoes` proves that fact for the transition.

### 6.4 Presentation duration and reset

The cue may remain visible for the current settled turn and clear on the next submitted turn, restart, level load, direct-route reload, completion transition, or existing feedback timeout. It must not become a permanent HUD panel.

Restart must restore the exact initial presentation state and no stale divergence cue.

### 6.5 Visual placement

Use existing drawing/presentation surfaces only; no scene edit is authorized.

The cue should remain visually connected to the ECHOs and their actual endpoints through a bounded combination of:

- existing replay trails;
- short endpoint notches/halos;
- E2/E4 outcome labels near but not over actors;
- one compact `ECHO SPACING CHANGED` badge in unused board/right-rail space.

The exact placement is implementation-selected, but it must not obscure or materially overlap:

- YOU;
- E2/E4 badges or outlines;
- Plates A/B;
- A+B Door/pips;
- EXIT;
- dependency lines;
- goal/status text;
- controls;
- completion feedback.

### 6.6 Reduced motion and grayscale

Reduced-motion mode must retain the full causal meaning with static text, outlines, endpoints, or line segments. No animation, pulse, fade, or color change may be the sole evidence.

Grayscale must preserve:

- E2/E4 identity;
- `MOVED/BLOCKED/WAITED` distinction;
- spacing-change copy;
- A/B and A+B distinctions;
- actor/Plate/Door visibility.

## 7. Required focused tests

Create one focused test under:

```text
tests/gameplay/
```

The test must use reusable Gameplay and returned transition facts. It must not modify formal data or call a runtime solver.

Cover at minimum:

1. zero/single-ECHO levels do not show divergence feedback;
2. multi-ECHO stable signed vector and stable Manhattan spacing produce no spacing-change cue;
3. startup activation where one ECHO moves and another waits is represented accurately if spacing changes;
4. different replay actions that change signed vector are represented accurately;
5. overlap transition records spacing collapse;
6. overlap-to-separation records spacing growth;
7. cardinal `BLOCKED` versus cardinal `MOVED` is derived correctly from returned action and before/after position;
8. `WAITED` is distinct from `BLOCKED`;
9. the accepted blocked/moved transition can display truthful compact causal copy without route knowledge;
10. target A+B convergence with stable spacing does not falsely show a new spacing-change cue;
11. restart clears all divergence state;
12. direct launch and reusable AppRoot route both initialize correctly;
13. completion does not retain misleading stale feedback;
14. presentation snapshots expose deterministic actor outcomes and before/after spacing facts;
15. canonical state and turn results are unchanged by feedback.

Add one stable marker:

```text
TASK_0015R_ECHO_DIVERGENCE_FEEDBACK_TESTS_PASS
```

Register it in `tests/run_all.gd` with the minimum necessary changes. All existing nine markers must remain present exactly once.

## 8. Formal preservation and aggregate regression

Before implementation, record all seven formal hashes. After implementation, require them byte-identical. In particular:

```text
Level 7 SHA-256 = 772410d3b8bb807e35472ee2a7d07b703de66e1e0e92ffb4d1ff8433a345d5fd
L* = 19
N* = 6 EXACT
visited_states = 61975
maximum_frontier = 21449
```

Run the accepted full aggregate in a fresh native process with separated stdout/stderr and native exit capture.

Required:

- exit `0`;
- no failed assertions, parser/script/runtime errors, or crash;
- assertion count not lower than 367;
- vectors remain 9;
- all existing nine markers exactly once;
- new Task 0015R marker exactly once;
- all seven formal hashes and accepted metrics unchanged;
- only the accepted intentional `LEVEL_ID_MISMATCH` may appear on stderr.

## 9. Capture validation

Create one focused native 960×540 capture harness under `tests/gameplay/`. Use a standalone native Compatibility-renderer game window or accepted bounded capture method. Do not capture the full desktop or use the embedded editor preview.

Capture at minimum:

1. stable two-cell spacing with no cue;
2. signed-vector change caused by different replay actions;
3. overlap/spatial collapse;
4. E2 blocked while E4 moves, with truthful outcomes and spacing-change cue;
5. subsequent spacing expansion;
6. A+B convergence state with existing dependency cues still legible;
7. no-cue control state;
8. restart-cleared state;
9. reduced-motion state;
10. grayscale decision frame.

For each capture, record presentation snapshots/rectangles and verify no material overlap with actors, Plates, Door, EXIT, goal, controls, or completion feedback.

## 10. External evidence

Authorized external root:

```text
D:\Delayed_Self_Evidence\0015R_echo_divergence_feedback_repair\
```

It may contain only:

- exact commands and executable identity;
- separated focused/aggregate stdout and stderr;
- native exit codes;
- formal hash and metric comparison;
- focused snapshot JSON/text;
- game-window-only captures;
- grayscale/reduced-motion evidence;
- bounded implementation notes;
- evidence index with timestamps, sizes, and SHA-256.

Do not stage external evidence, screenshots, logs, temporary scripts, `.godot`, generated UID files, imports, or caches.

## 11. Authorized repository surface

May modify only the minimum necessary subset of:

```text
scripts/gameplay/vertical_slice.gd
tests/gameplay/<one focused feedback test>.gd
tests/gameplay/<one focused capture harness>.gd
tests/run_all.gd
docs/reports/0015R_LEVEL_7_ECHO_DIVERGENCE_FEEDBACK_REPAIR_REPORT.md
docs/CODEX_ACTIVE_TASK_CURRENT.md
docs/CODEX_STARTUP_SNAPSHOT_CURRENT.md
docs/DEVELOPMENT_PLAN_CURRENT.md
docs/DOC_INDEX_CURRENT.md
docs/HANDOFF_MASTER_CURRENT.md
docs/project_memory.md
docs/level_design/INITIAL_LEVEL_ROADMAP_AND_VALIDATION_MATRIX_CURRENT.md
docs/level_design/FIVE_LEVEL_DIFFICULTY_RECOVERY_AND_LEVELS_6_8_PLAN.md
docs/level_design/LEVEL_7_FALSE_UNSOLVABLE_REPAIR_PLAN_CURRENT.md
docs/ux/PRESENTATION_VIEWPORT_AND_HUD_DIRECTION_CURRENT.md
```

Do not modify prior tasks, reports, reviews, acceptances, validations, formal content, catalog, schemas, Simulation, solver, scenes, project rules, GDD, assets, or production/release surfaces.

Before editing, print the exact selected file list. Before staging, prove that only selected authorized paths changed.

## 12. Implementation report

Create:

```text
docs/reports/0015R_LEVEL_7_ECHO_DIVERGENCE_FEEDBACK_REPAIR_REPORT.md
```

Include:

- task/start/final Git facts;
- exact files changed;
- causal problem and accepted repair boundary;
- transition facts consumed and confirmation that no puzzle logic was duplicated;
- feedback state and trigger/no-trigger contract;
- truthful outcome classification rules;
- visual/reduced-motion/grayscale disposition;
- focused test results and marker;
- captures and overlap audit;
- seven-hash and metric preservation;
- complete aggregate output and stderr disposition;
- external evidence index;
- rollback procedure;
- protected surfaces and non-claims;
- recommendation for GPT review and later owner-only retest.

Do not claim the blocking P2 is closed before the owner retest.

## 13. Git discipline

Before staging:

```powershell
git status --short --untracked-files=all
git diff --check
git diff --stat
```

Audit:

- only explicitly selected authorized paths changed;
- no formal data, catalog, schema, Simulation, solver, scene, project setting, Timeline, Help, asset, import, user-data, evidence, screenshot, log, cache, or generated file is staged;
- all seven formal hashes are unchanged;
- Level 7 metrics are unchanged;
- all ten aggregate markers pass;
- report avoids owner-acceptance or P2-closure claims.

Stage explicit files only. Never use broad staging.

Then run:

```powershell
git diff --cached --check
git diff --cached --stat
git diff --cached --name-only
```

Commit exactly once:

```text
fix: expose Delayed Self echo spacing changes
```

Immediately before push:

```powershell
git fetch origin
git rev-parse HEAD
git rev-parse origin/main
git status --short --untracked-files=all
```

Stop on remote drift. Do not merge, rebase, amend, force-push, reset, broadly restore, or clean.

Push normally to `origin/main`. After push require a clean worktree and `HEAD == origin/main`.

## 14. Stop conditions

Stop without partial commit if:

- feedback requires a formal level, catalog, schema, Simulation, solver, scene, project setting, Timeline, or Help change;
- correct outcomes cannot be derived solely from returned transition facts;
- implementation duplicates movement/collision/Plate/Door logic;
- any feedback text becomes route-specific, solver-like, or misleading;
- stable spacing incorrectly triggers;
- moved/blocked/waited is misclassified;
- cue obscures existing critical information at 960×540 or grayscale;
- reduced-motion loses causal meaning;
- any formal hash/metric changes;
- any existing marker/regression fails;
- unexpected generated or unrelated files appear and no existing rule safely authorizes handling.

Use the most specific terminal blocker:

```text
BLOCKED_REPAIR_REQUIRES_FORBIDDEN_SURFACE
BLOCKED_TRANSITION_FACTS_INSUFFICIENT
BLOCKED_FEEDBACK_MISREPORTS_CAUSALITY
BLOCKED_PRESENTATION_READABILITY
BLOCKED_BASELINE_OR_FORMAL_REGRESSION
BLOCKED_UNEXPECTED_WORKTREE_CHANGE
```

Do not activate the geometry fallback in this task.

## 15. Terminal verdict and next gate

After successful implementation, validation, one commit, push, and clean final audit, return:

```text
LEVEL_7_DIVERGENCE_FEEDBACK_REPAIR_READY_FOR_GPT_REVIEW
```

Include:

- commit SHA;
- changed paths;
- focused assertion/marker result;
- aggregate assertions/vectors and all ten markers;
- seven-hash and Level 7 metric confirmation;
- key capture states;
- report path;
- external evidence root;
- final Git state.

No terminal verdict is final GPT acceptance.

After GPT accepts the repair, the next gate is a separately authorized:

```text
AUTHENTICATED_OWNER_NOT_FRESH_NOT_INDEPENDENT_LEVEL_7_RETEST
```

Level 8 remains blocked until that retest closes or materially reduces the blocking P2.

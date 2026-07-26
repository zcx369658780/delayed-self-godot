# Task 0024AT — Record owner playthrough feedback and rebaseline the level-expansion curriculum

- Status: `READY`
- Gate: `OWNER FEEDBACK CAPTURE / MECHANIC PORTFOLIO REBASELINE / PHASED LEVEL-EXPANSION ROADMAP`
- Repository/root/branch: `zcx369658780/delayed-self-godot` / `D:\Delayed_Self` / `main`
- Required accepted checkpoint in ancestry: `ddf99678e7c444aa0e1ca05fd32d75d634d02bb4`
- Previous task: `tasks/0024AS_launch_isolated_owner_review_game_session.md`
- Owner session: completed by the user outside Codex
- Owner route: `MACHINE_QUALIFIED_ISOLATED_STAGING_ROUTE`
- Presentation gate: `TASK_0024AL_PROCESS_ISOLATED_WRITE_AHEAD_SCHEMA_V2_MINIMUM_OWNER_REVIEW_PRESENTATION_ACCEPTED`
- DeepSeek project-code routing: `DISABLED`
- Production catalog before this task: exactly sequences 1–8
- Formal production finale before this task: sequence 8 only
- Staging candidates before this task: sequences 9–12
- This task is documentation and planning only.
- No level, code, catalog, Profile, scene, build, or release modification is authorized.

## 1. Owner-supplied facts

Treat the following as authoritative owner feedback supplied after completing the 1–12 staging playthrough:

1. Sequence 9 introduces a pushable crate.
2. Sequence 9 does not currently use a crate-specific trigger or destination mechanic.
3. The crate is currently used mainly as an obstruction that must be pushed out of the way.
4. Sequences 10–12 contain gameplay based on separation between the current body and delayed shadow/echo.
5. The owner considers the body/shadow separation direction more worthy of expansion and promotion.
6. Sequences 7–8 use the earlier “trap/position the shadow” challenge structure.
7. The owner still considers sequences 7–8 the hardest rooms.
8. The owner recommends using the shadow-trapping challenge family as the final challenge.
9. The owner recommends approximately ten push-crate levels.
10. The owner recommends approximately ten body/shadow-separation levels.

Do not invent numerical difficulty, clarity, enjoyment, confusion, or presentation scores not supplied by the owner.

## 2. Objective

Codex must:

1. synchronize the repository safely;
2. record the completed owner session and only the judgments actually supplied;
3. update the owner curriculum worksheet without fabricating missing per-room ratings;
4. create a durable owner-feedback decision report;
5. create a new mechanic-expansion rebaseline;
6. define a ten-slot push-crate candidate track;
7. define a ten-slot body/shadow-separation candidate track;
8. reserve the shadow-trapping family represented by current sequences 7–8 for the final difficulty chapter;
9. distinguish candidate-bank targets, implementation batches, machine validation, owner review, and eventual production admission;
10. create a phased roadmap rather than immediately authoring twenty levels;
11. preserve the current production catalog, finale, Profile, progression, code, scenes, level files and accepted evidence;
12. commit and push only the authorized documentation;
13. return `PASS_FOR_GPT_REVIEW` or `BLOCKED`.

## 3. Product decision to encode

### 3.1 Accepted direction

```text
owner_playthrough_status = COMPLETED_WITH_DIRECTIONAL_FEEDBACK
crate_track_direction = EXPAND_AFTER_MECHANIC_REDESIGN
body_shadow_separation_direction = PRIMARY_EXPANSION_TRACK
shadow_trapping_direction = FINAL_CHALLENGE_TRACK
catalog_admission_status = NOT_AUTHORIZED_BY_THIS_TASK
```

### 3.2 Candidate-bank target

Create a long-list candidate bank with:

```text
crate_track_candidate_target = 10 total rooms
body_shadow_separation_candidate_target = 10 total rooms
```

Count the existing rooms as seeds:

```text
crate seed:
- current sequence 9

body/shadow-separation seeds:
- current sequences 10–12
```

Therefore:

```text
new crate candidates required to reach ten = 9
new body/shadow candidates required to reach ten = 7
```

This is a candidate-bank target, not automatic production admission.

### 3.3 Submission scope protection

Do not declare that all twenty mechanism-track rooms will ship.

Record:

```text
candidate_bank_target = 10 crate-track rooms + 10 body/shadow-track rooms
formal_submission_catalog_size = DEFERRED_UNTIL_BATCH_VALIDATION
all_candidate_admission = NOT_AUTOMATIC
```

A later owner/GPT decision may select the strongest subset or authorize the full portfolio only after implementation, solver validation, presentation review and schedule audit.

### 3.4 Finale direction

Record:

```text
future_final_chapter = SHADOW_TRAPPING_AND_ALIGNMENT
current_sequences_7_8 = RETAIN_AS_FINAL_DIFFICULTY_REFERENCE
formal_finale_migration = NOT_AUTHORIZED_BY_THIS_TASK
```

Do not reorder the current catalog or staging catalog.

## 4. Owner worksheet update rules

Update `docs/playtest/SUBMISSION_CORE_1_12_OWNER_CURRICULUM_REVIEW_CURRENT.md`.

### 4.1 Global status

Set:

```text
owner_playthrough_status = COMPLETED_WITH_DIRECTIONAL_FEEDBACK
owner_session_date = 2026-07-26
```

State that the owner supplied directional, not numerical, feedback.

### 4.2 Sequences 1–6

- completion: `OWNER_REPORTED_COMPLETED`;
- numerical ratings: `NOT_PROVIDED`;
- confusion, shortcut, presentation and free notes: `NOT_PROVIDED`;
- disposition: `NOT_PROVIDED`.

Do not infer acceptance.

### 4.3 Sequences 7–8

Record:

- completion: `OWNER_REPORTED_COMPLETED`;
- hardest rooms in the current 1–12 route;
- recommendation: retain this mechanic family for the final challenge;
- numeric fields: `NOT_PROVIDED`;
- formal per-room disposition: `NOT_PROVIDED`;
- chapter-level recommendation: `FINAL_CHALLENGE_TRACK`.

Do not claim sequence 8 has already been moved or sequence 12 rejected.

### 4.4 Sequence 9

Record:

- completion: `OWNER_REPORTED_COMPLETED`;
- crate exists and can be pushed;
- current purpose is primarily clearing an obstruction;
- no crate-specific trigger/destination interaction was perceived;
- mechanism direction: `REVISE_AND_EXPAND`;
- numeric fields and formal catalog disposition: `NOT_PROVIDED`.

Future recommendations may include crate plates, weighted switches or equivalent crate-specific goals, but must not claim they exist now.

### 4.5 Sequences 10–12

Record:

- completion: `OWNER_REPORTED_COMPLETED`;
- body/shadow separation is the stronger expansion direction;
- mechanism direction: `PRIMARY_EXPANSION_TRACK`;
- numeric fields and formal individual dispositions: `NOT_PROVIDED`.

### 4.6 Cross-room conclusions

Add:

- push-crate design needs a meaningful crate-specific purpose;
- body/shadow separation deserves substantially more content;
- shadow trapping/alignment is the current hardest mechanic family;
- shadow trapping/alignment is recommended for the final challenge;
- owner requests approximately ten rooms in each expansion family.

Set:

```text
overall_owner_direction = REVISE_AND_EXPAND_CURRICULUM
```

Do not convert this into production admission.

## 5. New mechanic-expansion rebaseline

Create `docs/level_design/OWNER_FEEDBACK_MECHANIC_EXPANSION_REBASELINE_CURRENT.md` with four chapters.

### Chapter A — Foundations

Use current sequences 1–6 as the foundation chapter: movement, delayed replay, doors/plates, waits, multiple echoes and dependency chains. Do not redesign them in this task.

### Chapter B — Push-crate track

Target ten candidate rooms total, including current sequence 9 as a seed.

Define ten distinct slots:

1. crate as movable obstruction;
2. crate pressure plate;
3. crate-held delayed door;
4. crate as beam or pulse blocker;
5. crate bridge or anchor;
6. two-crate ordering;
7. crate plus echo cooperation;
8. irreversible crate commitment;
9. crate-state reset or phase transfer, only if representable by the deterministic simulation contract;
10. crate synthesis challenge.

For every slot define teaching purpose, prerequisite, crate-specific interaction, reasoning structure, anti-duplication note, solver representation, presentation requirement and cut condition.

Do not introduce freeform physics. All crate interactions must remain grid-based, deterministic and solver-representable.

### Chapter C — Body/shadow-separation track

Target ten candidate rooms total, including current sequences 10–12 as seeds.

Define ten slots:

1. first explicit body/shadow role separation;
2. body-only route commitment;
3. echo-only sensor route;
4. asymmetric parallel paths;
5. timed reunion;
6. body opens route for echo;
7. echo opens route for body;
8. role reversal across phases;
9. typed sensor and grouped-barrier synthesis;
10. persistent/latching separation synthesis.

Map current sequences 10–12 to the closest seed slots without rewriting their files.

For every slot define body responsibility, echo responsibility, prerequisite, identity cue, failure readability, difficulty intent, solver evidence, presentation requirement and cut condition.

This is the primary expansion track.

### Chapter D — Final shadow-trapping chapter

Use current sequences 7–8 as the reference family.

Define a future final chapter of two to four rooms:

1. reintroduction after the expansion tracks;
2. advanced trap/alignment;
3. optional mixed-mechanic penultimate challenge;
4. final shadow-trapping/alignment room.

Record:

```text
current_sequence_8 = FORMAL_FINALE_UNCHANGED_FOR_NOW
future_finale_direction = SHADOW_TRAPPING_ALIGNMENT
exact_final_level = DEFERRED
```

## 6. Phased implementation roadmap

### Phase 0 — Documentation freeze

Task 0024AT: owner feedback, curriculum rebaseline, candidate slots, batch gates, no implementation.

### Phase 1 — Proof batch

Recommend the next implementation package:

```text
3 new crate candidates
3 new body/shadow candidates
```

Each must use a distinct reasoning structure, have a candidate solution, be solver-valid, include presentation cues, and remain uncataloged.

### Phase 2 — First expansion review

After Phase 1, compare solver metrics and owner playtest, cut duplicate or weak mechanics, and decide whether both tracks continue.

### Phase 3 — Second batch

Only after Phase 2 acceptance:

```text
3 additional crate candidates
2 additional body/shadow candidates
```

### Phase 4 — Portfolio completion

Only after schedule and quality review, complete remaining slots needed to reach ten candidates in each track, design the final shadow-trapping chapter, and select the submission catalog.

### Phase 5 — Catalog admission

Separate high-risk task: choose formal count, order curriculum, select finale, update production catalog/Profile migration, run full regression, and conduct owner acceptance.

Task 0024AT authorizes none of Phases 1–5 execution.

## 7. Quality gates for future levels

Every future candidate must have structured level data, deterministic simulation support, solver-confirmed solvability, shortest solution length, a machine-verified solution, shortest-solution count when tractable, intended-mechanic proof, shortcut audit, restart/reset proof, presentation review, and owner playtest before admission.

For crate rooms require:

```text
crate_specific_purpose != CLEAR_OBSTRUCTION_ONLY
```

except the explicit introductory obstruction room.

For body/shadow rooms require distinct responsibilities for body and echo.

## 8. Scope and schedule decision

The owner's request for roughly ten rooms per expansion family is accepted as a design-bank goal, not yet as a guaranteed shipping count.

Add:

```text
portfolio_scope_checkpoint = AFTER_PHASE_1_OWNER_REVIEW
```

At that checkpoint compare development time, solver/test cost, presentation cost, duplicate-mechanic rate, owner enjoyment and remaining festival schedule.

If scope threatens completion, cut candidate rooms rather than validation, polish, export or license work.

## 9. Required deliverables

Create or update only:

```text
docs/playtest/SUBMISSION_CORE_1_12_OWNER_CURRICULUM_REVIEW_CURRENT.md
docs/reports/0024AT_OWNER_PLAYTHROUGH_AND_MECHANIC_EXPANSION_DECISION_REPORT.md
docs/level_design/OWNER_FEEDBACK_MECHANIC_EXPANSION_REBASELINE_CURRENT.md
docs/level_design/OWNER_FEEDBACK_LEVEL_PORTFOLIO_MATRIX_CURRENT.md
docs/production/EXPANDED_CONTENT_SUBMISSION_ROADMAP_CURRENT.md
docs/game_design/GAMEPLAY_BREADTH_AND_MECHANICS_REBASELINE_CURRENT.md
docs/CODEX_ACTIVE_TASK_CURRENT.md
docs/CODEX_STARTUP_SNAPSHOT_CURRENT.md
docs/DOC_INDEX_CURRENT.md
docs/DEVELOPMENT_PLAN_CURRENT.md
docs/HANDOFF_MASTER_CURRENT.md
docs/project_memory.md
docs/handoffs/DELAYED_SELF_SESSION_HANDOFF_AFTER_TASK_0024AT_OWNER_REVIEW_REBASELINE_2026_07_26.md
```

No other repository path may change.

## 10. Level portfolio matrix

Create `docs/level_design/OWNER_FEEDBACK_LEVEL_PORTFOLIO_MATRIX_CURRENT.md`.

Include current sequences 1–12, crate slots C01–C10, body/shadow slots S01–S10, and final-chapter slots F01–F04.

Columns:

```text
slot
family
existing_or_new
source_sequence
teaching_purpose
primary_mechanic
secondary_mechanic
candidate_status
machine_validation_status
presentation_status
owner_review_status
catalog_status
cut_priority
notes
```

New slots begin as:

```text
candidate_status = PLANNED_NOT_AUTHORED
machine_validation_status = NOT_RUN
presentation_status = NOT_IMPLEMENTED
owner_review_status = NOT_REVIEWED
catalog_status = NOT_AUTHORIZED
```

Do not invent future metrics.

## 11. Owner decision report

Create `docs/reports/0024AT_OWNER_PLAYTHROUGH_AND_MECHANIC_EXPANSION_DECISION_REPORT.md`.

Include owner session date, route used, direct owner observations, supported conclusions, missing details, per-family decision, candidate-bank target, phased implementation decision, final-challenge direction, catalog/finale non-authorization, risks and next recommended task.

Clearly distinguish direct owner statements from GPT planning judgments.

## 12. Protected surfaces

Do not modify:

```text
data/catalog/**
data/levels/**
scripts/**
scenes/**
project.godot
schemas/**
tests/**
docs/reports/0024AL_*
docs/reports/0024AE_*
docs/reports/0024AR_*
docs/playtest/SUBMISSION_CORE_9_12_PLAYTEST_ROUTE_AUDIT_CURRENT.md
localization/**
assets/**
audio/**
build/**
export/**
release/**
submission/**
```

Do not inspect or modify production or test Profile data. Do not launch Godot, run solver/gameplay tests, or invoke DeepSeek.

## 13. Startup gate

Before writing:

1. require root `D:\Delayed_Self` and branch `main`;
2. confirm expected origin;
3. fetch and fast-forward only;
4. require `HEAD == origin/main`, divergence `0/0`;
5. require Task 0024AT and current pointers from `origin/main`;
6. require checkpoint `ddf99678e7c444aa0e1ca05fd32d75d634d02bb4` in ancestry;
7. require no tracked/staged changes;
8. allow only existing untracked `.codex/config.toml` with its accepted SHA-256;
9. require Godot process count zero;
10. stop on remote drift, unexpected worktree state or protected-file drift.

If the owner still has the game open, return `BLOCKED_OWNER_SESSION_STILL_RUNNING`; do not kill it automatically.

## 14. Validation

Run:

```powershell
git status --short --untracked-files=all
git diff --check
git diff --name-only
git diff --stat
```

Validate authorized paths, faithful owner statements, missing scores remaining missing, unchanged production catalog/finale, ten crate slots, ten body/shadow slots, two to four final slots, correct seed counts, consistent roadmap phases and working Markdown links.

Record:

```text
full_gameplay_regression = NOT_RUN_NOT_REQUIRED_DOCUMENTATION_ONLY
```

## 15. Commit and push

After validation:

1. fetch origin and require divergence `0/0`;
2. explicitly stage authorized documentation only;
3. run `git diff --cached --check` and review the staged diff;
4. commit:

```text
docs: record owner review and rebaseline level expansion
```

5. push `main`;
6. verify `HEAD == origin/main`;
7. require no tracked/staged changes, only `.codex/config.toml` untracked, and Godot zero.

Do not amend, rebase, squash or force-push.

## 16. Terminal verdict

Return `PASS_FOR_GPT_REVIEW` only if owner feedback is captured faithfully, missing ratings are not invented, both ten-slot tracks exist, the final shadow-trapping direction is recorded, phased scope gates are explicit, production catalog/finale are unchanged, and commit/push succeeds. Otherwise return `BLOCKED`.

## 17. Required final fields

```text
owner_playthrough_status = COMPLETED_WITH_DIRECTIONAL_FEEDBACK
crate_track_direction = EXPAND_AFTER_MECHANIC_REDESIGN
crate_candidate_target = 10_TOTAL
body_shadow_separation_direction = PRIMARY_EXPANSION_TRACK
body_shadow_candidate_target = 10_TOTAL
shadow_trapping_direction = FINAL_CHALLENGE_TRACK
production_catalog_modified = NO
formal_finale_modified = NO
new_level_files_created = NO
gameplay_code_modified = NO
candidate_bank_admission = NOT_AUTHORIZED
next_implementation_batch = 3_CRATE_PLUS_3_BODY_SHADOW_CANDIDATES
final_task_verdict = PASS_FOR_GPT_REVIEW or BLOCKED
```

## 18. Next task

After GPT review, the recommended successor is a bounded Phase 1 candidate-design and authoring plan for three crate candidates and three body/shadow-separation candidates. It must freeze six individual briefs, solver budgets, presentation requirements, authoring order and separate validation gates before changing level files.

# Task 0017V — Authenticated-owner bridge sequence review

- Status: `READY`
- Gate: `HUMAN EVIDENCE / BRIDGE CURRICULUM AND SEQUENCE REVIEW`
- Repository/root/branch: `zcx369658780/delayed-self-godot` / `D:\Delayed_Self` / `main`
- Accepted bridge implementation: `47e40fa13cccc2725c3110969c64f1e328dee0a8`
- GPT acceptance: `docs/reports/0017_GPT_FINAL_ACCEPTANCE.md`
- GPT acceptance commit: `7bb8eb7621c1ab0e771d901c7f2d6ec02ff949cb`
- Reviewer classification: `AUTHENTICATED_OWNER_NOT_FRESH_NOT_INDEPENDENT_BRIDGE_SEQUENCE_REVIEW`

## 1. Objective

Record one bounded owner review of the new mandatory sequence:

```text
Level 6 staggered_doors
→ Level 7 echo_spacing_bridge
→ Level 8 two_echo_convergence
```

The primary question is not whether machine evidence is valid. It is whether the bridge makes the spacing-change idea understandable and recoverable before the accepted two-ECHO synthesis.

The owner is the only available playtester. Do not seek, require, contact, recruit, or suggest a third party. Fresh and independent evidence is unavailable by owner constraint and must not be claimed.

This task is review-only. It must not modify gameplay, formal levels, catalog, App Shell, tests, Help, Timeline, presentation, progression, assets, or project settings.

## 2. Evidence and exposure boundary

The owner has extensive prior project exposure and has previously seen the exact `two_echo_convergence` witness. Therefore:

- Level 8 completion cannot be treated as blind route-discovery evidence;
- the bridge attempt may still be treated as unassisted only if its exact route or next actions are not disclosed before or during that attempt;
- do not reveal the bridge witness, coordinates, target turn, target spacing, solver path, or next action during the active bridge attempt;
- do not infer timing, restarts, turns, Help use, or Timeline use when the owner does not provide them.

If the owner asks for a solution during the bridge attempt, first ask whether to end the unassisted attempt. Only after explicit agreement may the task record an assisted continuation. Even then, provide at most a high-level causal explanation; do not disclose the exact bridge witness in this task.

## 3. Startup and baseline

Before launching the game:

- verify root `D:\Delayed_Self`, branch `main`, expected origin, clean tracked/untracked worktree, and `HEAD == origin/main` containing the GPT acceptance and this task;
- verify no residual Godot process;
- read `AGENTS.md`, current startup/active-task documents, this task, Task 0017C report/validation, Task 0017 GPT acceptance, Task 0017P acceptance/report, Task 0015RV review, and current sequence/difficulty plan;
- reuse accepted Task 0017C machine evidence unless a contradiction appears;
- do not author a new solver, change a level, or rerun broad validation merely to conduct the review.

A narrow launch smoke is allowed. If a runtime or repository contradiction appears, stop and report it rather than changing product files.

## 4. Review sequence

Use separate native Compatibility-renderer processes where practical.

### 4.1 Level Select and progression

From a reset or controlled review profile, verify and record:

- the eight-entry Level Select remains reachable;
- bridge is locked before Level 6 completion;
- Level 6 completion reveals/unlocks bridge;
- bridge completion reveals/unlocks shifted `two_echo_convergence` at sequence 8;
- Title and Back remain fixed and tail entries remain reachable.

Do not change progression implementation.

### 4.2 Level 6 comparison

Have the owner play or briefly revisit `staggered_doors` without new route assistance. Record only supplied facts:

- completion status;
- approximate elapsed time;
- final visible turn;
- restart count;
- Help/Timeline use;
- what concept Level 6 appears to teach;
- any persistent dependency or dotted-line readability problem.

Prior familiarity must be disclosed.

### 4.3 Bridge attempt

Launch `echo_spacing_bridge` without showing the witness or route.

Record:

- `COMPLETED_UNASSISTED`, `GAVE_UP_UNASSISTED`, or an explicitly assisted status;
- approximate elapsed time, turns, and restarts only as supplied;
- whether the owner noticed a `BLOCKED/MOVED` spacing change without prompting;
- which ECHO was blocked, which moved, and what board feature caused the difference;
- whether the owner understood that the changed phase enables E2 on A and E4 on B;
- whether the owner understood the following-input open-snapshot Door crossing;
- whether stable spacing ever produced a false cue;
- whether any outcome label contradicted visible movement;
- whether Help or Timeline was used or required;
- whether wrong timing exposed a readable cause;
- whether a non-optimal state offered a credible recovery experiment rather than immediate restart;
- visual clutter, overlap, dependency readability, reduced-motion if voluntarily tested, and grayscale only if available without burden.

Before any route discussion, ask the owner to explain the bridge's causal chain in their own words.

### 4.4 Shifted Level 8 comparison

After the bridge attempt is closed, launch or discuss `two_echo_convergence` as sequence 8.

Because its exact witness was previously exposed, classify any route use accordingly. The useful evidence is limited to transfer and comparative judgment:

- does Level 8 now feel like a synthesis of a learned spacing-change idea rather than an unexplained trick;
- can the owner identify where the bridge lesson applies without relying on the exact sequence;
- is the Level 6 → bridge → Level 8 difficulty progression materially smoother;
- is the bridge meaningfully simpler, or merely a duplicate shorter puzzle;
- do Help, Timeline, or dotted paths remain the dominant difficulty source;
- should the bridge be preserved, revised, removed, or repositioned.

Do not claim blind Level 8 completion or unbiased difficulty evidence.

## 5. Required structured questions

Record direct owner answers, preserving meaning and uncertainty:

1. What caused E2 and E4 spacing to change in the bridge?
2. Which ECHO was blocked, which moved, and what blocked it?
3. Why are both ECHOs necessary for A+B while YOU crosses?
4. Why can YOU not replace one ECHO on a Plate and still cross?
5. What does the next-input Door rule mean in this room?
6. When an attempt failed, what visible experiment would you try next?
7. Was the bridge understandable without Timeline?
8. Did Help contribute anything useful without revealing a route?
9. Were `MOVED/BLOCKED/WAITED`, A/B, E2/E4, and A+B readable?
10. Did dotted prediction/dependency lines create material clutter?
11. Compared with Level 6, was the bridge appropriately harder?
12. Compared with shifted Level 8, was the bridge materially simpler?
13. Did the sequence reduce the prior difficulty discontinuity?
14. Preserve, revise, reposition, or remove the bridge?
15. Is bounded finale planning appropriate next, or should presentation/difficulty work come first?

Optional ratings may be collected but are not required.

## 6. Findings and disposition

Classify findings as P0/P1/P2/P3.

P0/P1 examples include crash, inaccessible progression, false outcome labels, stable-spacing false cue, wrong unlock/final behavior, or a confirmed formal/runtime contradiction.

P2 examples include failure to understand the causal chain, bridge duplication, recovery failure, excessive difficulty jump, ineffective Help/Timeline, or material visual clutter that does not make play impossible.

Select exactly one recommendation:

- **A — Bridge accepted for owner internal evidence:** preserve bridge and authorize bounded `signal_convergence` planning;
- **B — Bounded bridge presentation/difficulty repair:** preserve formal intent but repair clarity, recovery, or sequencing before finale planning;
- **C — Bridge design return:** re-author or remove the bridge because it does not teach the intended concept;
- **D — Bridge accepted, production priority first:** preserve bridge but prioritize presentation/Help/Timeline/art or complete-flow work before finale planning.

Owner completion is not mandatory for recommendation A if the owner correctly explains the full causal chain, rejects fixed spacing, identifies a credible recovery experiment, and does not judge the bridge mathematically impossible. Completion without comprehension is not sufficient.

## 7. Repository outputs

Create:

```text
docs/reviews/0017V_OWNER_BRIDGE_SEQUENCE_REVIEW.md
docs/reports/0017V_OWNER_BRIDGE_SEQUENCE_REVIEW_REPORT.md
```

Update only the necessary current Markdown subset:

```text
docs/CODEX_ACTIVE_TASK_CURRENT.md
docs/CODEX_STARTUP_SNAPSHOT_CURRENT.md
docs/DEVELOPMENT_PLAN_CURRENT.md
docs/DOC_INDEX_CURRENT.md
docs/HANDOFF_MASTER_CURRENT.md
docs/project_memory.md
docs/level_design/INITIAL_LEVEL_ROADMAP_AND_VALIDATION_MATRIX_CURRENT.md
docs/level_design/FIVE_LEVEL_DIFFICULTY_RECOVERY_AND_LEVELS_6_8_PLAN.md
docs/level_design/LEVEL_8_FINALE_AND_DIFFICULTY_BRIDGE_PLAN_CURRENT.md
docs/ux/PRESENTATION_VIEWPORT_AND_HUD_DIRECTION_CURRENT.md
```

Do not edit source, product data, catalog, tests, previous reports/reviews/tasks/acceptances, GDD, or release surfaces.

External evidence root:

```text
D:\Delayed_Self_Evidence\0017V_owner_bridge_sequence_review\
```

Only owner-approved game-window screenshots and bounded logs may be stored externally. Do not collect the full desktop, face, voice, raw keyboard log, accounts, notifications, or unrelated windows. Nothing from the external root enters Git.

## 8. Generated-file safety

After all Godot processes close, inspect the complete Git state.

The narrow literal cleanup authorization applies only if:

- `project.godot` is the sole unintended unstaged tracked change and is not staged;
- every untracked item is a regular repository-local `.gd.uid` file;
- no Godot process remains.

Then restore only the worktree copy of literal `project.godot` and delete only the frozen Git-enumerated UID paths one by one with literal-path semantics. Never use `git clean`, wildcard/recursive deletion, reset, stash, broad restore, rebase, amend, or force-push. Stop if the set differs.

## 9. Git discipline and terminal verdict

Stage explicit authorized Markdown files only. Require diff checks to pass. Commit exactly once:

```text
docs: record Delayed Self bridge sequence review
```

Fetch and stop on remote drift before push. Push normally and require a clean tracked/untracked worktree with `HEAD == origin/main`.

Return one terminal verdict according to the selected recommendation:

```text
OWNER_BRIDGE_SEQUENCE_REVIEW_ACCEPTED_FOR_GPT_REVIEW
OWNER_BRIDGE_PRESENTATION_REPAIR_RECOMMENDED_FOR_GPT_REVIEW
OWNER_BRIDGE_DESIGN_RETURN_RECOMMENDED_FOR_GPT_REVIEW
OWNER_BRIDGE_PRODUCTION_PRIORITY_RECOMMENDED_FOR_GPT_REVIEW
```

If no usable owner evidence is recorded, return:

```text
BLOCKED_OWNER_BRIDGE_SEQUENCE_REVIEW_NOT_RECORDED
```

Do not begin `signal_convergence` planning, bridge repair, production work, or release work in this task.
# Task 0017D — Bridge curriculum difficulty and Help repair planning

- Status: `READY`
- Gate: `DIAGNOSIS + REPAIR PLANNING / NO PRODUCT IMPLEMENTATION`
- Repository: `zcx369658780/delayed-self-godot`
- Expected branch/root: `main` / `D:\Delayed_Self`
- Owner review: `docs/reviews/0017V_OWNER_BRIDGE_SEQUENCE_REVIEW.md`
- Owner report: `docs/reports/0017V_OWNER_BRIDGE_SEQUENCE_REVIEW_REPORT.md`
- GPT adjudication: `docs/reports/0017V_GPT_OWNER_BRIDGE_SEQUENCE_ADJUDICATION.md`
- Adjudication commit: `86891c6d929c9848af2ab70837307475ffd143ef`
- Accepted bridge implementation: `47e40fa13cccc2725c3110969c64f1e328dee0a8`
- Bridge formal SHA-256: `805cdc05ea9b3805189ba7be4938cb7ede4e7056b9ae9a7e911df96a801d58ee`
- Current bridge status: `INTERNAL_PLAYABLE / CURRICULUM_NOT_ACCEPTED_PENDING_BOUNDED_REPAIR`

## 1. Objective

Diagnose why the machine-valid `echo_spacing_bridge / Diverging Echoes / 错位回声` failed its owner curriculum role, compare bounded repair directions, and select exactly one primary repair bundle plus at most one fallback.

The task must preserve the accepted causal teaching goal:

> A closed Door or terrain can make one delayed ECHO `BLOCKED` while the other `MOVED`, changing relative spacing; the changed phase later permits E2 on A and E4 on B while YOU remains free to cross the A+B Door from the following open snapshot.

This is planning and diagnostic work only. Do not edit the tracked bridge JSON, catalog, source, tests, scenes, Help, Timeline, presentation code, project settings, or any existing formal level.

## 2. Mandatory startup gate

Before any write or diagnostic run, verify:

- root exactly `D:\Delayed_Self`;
- branch `main`;
- expected origin;
- clean tracked and untracked worktree;
- `HEAD == origin/main` and contains this task plus commit `86891c6d929c9848af2ab70837307475ffd143ef`;
- accepted Godot `4.7.stable.steam.5b4e0cb0f` or exact documented equivalent;
- no residual Godot process.

Read in order:

1. `AGENTS.md`;
2. current startup/active-task documents;
3. this task;
4. Task 0017V review/report and GPT adjudication;
5. Task 0017C implementation report and validation;
6. Task 0017/0017C task contracts;
7. Task 0015D/0015R diagnosis, repair, tests, and owner retest;
8. Level 6 and `two_echo_convergence` validation/review evidence;
9. simulation/schema/catalog/progression contracts;
10. current Gameplay Help/Timeline/presentation implementation and direction documents;
11. external Task 0017V evidence index and approved owner screenshots;
12. current eight-entry catalog and all eight formal levels.

Before analysis, print a concise plan identifying the owner failures to explain, candidate directions, external diagnostic surface, protected files, and stop conditions.

## 3. Frozen facts and claim boundary

Treat as accepted:

- formal bridge `L*=16`, `N*=12 EXACT`, visited 19,059, frontier 3,734;
- all shortest solutions contain required early spacing divergence, E2→A/E4→B, A+B result, and next-input crossing;
- no-ECHO, E2-only, E4-only, and equal-delay controls are complete finite-state unsolved;
- the bridge is mechanically valid and both ECHOs are necessary;
- the owner eventually completed without operator route assistance and correctly explained Door/terrain spacing change, E4 blocked/E2 moved, E2→A/E4→B, and next-input entry;
- the owner initially gave up after more than 20 restarts, later needed about 10 additional restarts, and completed at Turn 37;
- Help and Timeline were used and reported ineffective;
- the owner could not explain why YOU cannot replace one ECHO;
- E2/E4, A/B, A+B, and outcome labels were readable;
- dotted lines were considered unnecessary but did not block play.

Do not reinterpret owner timing/restarts as population evidence. Do not claim fresh, blind, independent, balance, or fun evidence.

## 4. Protected repository surface

Do not modify:

```text
data/
schemas/
scripts/
scenes/
tests/
project.godot
```

Do not modify prior tasks, reports, reviews, acceptances, validations, GDD, assets, imports, persistence, build, export, release, or repository settings.

Allowed repository outputs are documentation only:

```text
docs/level_design/BRIDGE_CURRICULUM_REPAIR_PLAN_CURRENT.md
docs/reports/0017D_BRIDGE_CURRICULUM_DIAGNOSTIC_REPORT.md
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

Use the minimum necessary subset.

## 5. Diagnostic questions

Answer with evidence and uncertainty:

1. Which exact states or phases caused the initial owner loop and restarts?
2. Was the principal failure discovering the early `BLOCKED/MOVED` event, converting that event into E2/E4 role assignment, preserving YOU for Door entry, or recovering after overshooting an ECHO above the Door?
3. Why does the current geometry permit machine-optimal 16 turns but produce a 37-turn owner completion and more than 30 restarts?
4. Which visual facts were already clear and therefore should not be redundantly redesigned?
5. What causal explanation would let a player understand why YOU cannot substitute without revealing a route?
6. Can the current room be made a credible bridge through Help/presentation alone, or does the geometry itself combine too many reasoning steps?
7. Would simplifying geometry preserve a genuine two-ECHO lesson, or merely turn the room into a trivial copy of `two_echo_convergence`?
8. Would inserting another formal level solve the curriculum issue, or only increase content and validation burden?

Reconstruct owner-style failure states from supplied statements/screenshots when possible. Exact state reconstruction is diagnostic evidence, not runtime hint authority.

## 6. External diagnostic authorization

External root:

```text
D:\Delayed_Self_Evidence\0017D_bridge_curriculum_repair_planning\
```

External-only scripts may read tracked levels and the accepted Simulation/Solver to:

- replay the accepted witness;
- enumerate or reconstruct owner-style failed prefixes/states;
- measure shortest recovery from those exact states;
- test diagnostic geometry variants;
- compare candidate metrics and controls;
- inspect presentation snapshots and Help copy.

External scripts and diagnostic JSON must never enter Git or the product catalog. Label all candidate artifacts `DIAGNOSTIC_ONLY_NOT_FORMAL`.

Godot runs are optional and bounded. Do not run the full aggregate unless a specific diagnostic contradiction requires it. Do not edit product files to test a candidate.

## 7. Candidate directions to compare

Compare at least the following five directions. Add at most one materially distinct candidate if necessary.

### A — Current geometry + contextual causal Help

Keep the formal bridge byte-identical. Add a future contextual, zero-turn, non-route Help treatment that may explain:

- test whether a closed Door or wall makes one ECHO stop while the other moves;
- changed spacing is useful, not failure;
- A+B requires two bodies to remain on separate Plates;
- only YOU can finish, so keep YOU free and staged to cross after the Door opens.

It must not disclose an action sequence, branch choice, coordinates, next move, target turn, target spacing, solver distance, or walkthrough.

### B — Current geometry + recovery/presentation affordance

Keep the formal bridge byte-identical and evaluate a bounded state-derived recovery cue or contextualized relationship presentation. It must not run a solver, label dead/alive states without proof, show remaining moves, or make Timeline required.

### C — Simplified geometry, same formal grammar

Re-author only the bridge geometry in a later task while preserving:

- E2/E4 delays 2/4 and shared spawn;
- two distinct Plates;
- one A+B Door;
- player-only EXIT;
- both ECHOs individually necessary;
- early required `BLOCKED/MOVED` spacing change;
- E2→A/E4→B role result;
- open-result/next-input crossing;
- no WAIT requirement;
- schema v1 and no new mechanics.

The design should reduce search/recovery burden, expose the useful blocker phase earlier, and make YOU-staging necessity visible.

### D — Combined minimal geometry + contextual Help

Permit one smaller formal geometry change and one concise non-route causal Help change, with each component justified as necessary. Avoid a broad Help/Timeline redesign.

### E — Additional preliminary level or sequence split

Evaluate inserting another formal lesson before the current bridge, or replacing the current bridge with a simpler lesson and repositioning it. Treat this as a high-cost fallback because it adds catalog, progression, validation, review, and production burden.

## 8. Evaluation criteria

Score candidates 1–5 using explicit weights totaling 100%:

- curriculum continuity from Level 6: 20%;
- correction of the observed owner failure: 20%;
- preservation of mechanical integrity: 15%;
- non-route discoverability and recovery: 15%;
- implementation and revalidation risk: 10%;
- 960×540 / grayscale readability: 10%;
- reuse for shifted Level 8 and future finale: 5%;
- scope and catalog stability: 5%.

State uncertainty. Scores are planning judgments, not human evidence.

Select exactly one primary bundle and at most one fallback. Do not select an ambiguous menu of repairs.

## 9. Prospective repair requirements

If the selected primary changes formal geometry, propose quantitative bands stricter and easier than the current bridge. The plan should normally target approximately:

```text
11 <= L* <= 14
4 <= N* <= 64, EXACT
1000 <= visited_states <= 12000
100 <= maximum_frontier <= 2500
2–3 meaningful decisions
at least 3 recoverable alternatives
```

These are planning targets, not accepted facts. Adjust only with explicit rationale.

Any future formal edit requires:

- new formal SHA-256;
- complete schema/solve/replay/restart proof;
- exact `N*`;
- all-shortest required-event and fixed-role trace;
- no-ECHO/E2-only/E4-only complete-unsolved controls;
- equal-delay, Plate/dependency, Door removal, blocker relocation, overlap, substitution, articulation, and EXIT controls;
- meaningful decisions and recoveries;
- eight-entry catalog/progression and Level Select regression;
- preservation of all seven other formal hashes and metrics;
- 960×540, reduced-motion, grayscale, aggregate, and owner-only retest.

If the selected primary is presentation/Help-only, freeze exact trigger/copy/placement boundaries, prove no route disclosure, retain byte-identical formal hash/metrics, and require focused plus aggregate regression and owner-only retest.

## 10. Help and Timeline policy

Help may explain a reusable causal experiment and role constraint. Acceptable conceptual direction:

```text
One ECHO can be blocked while the other moves, changing their spacing.
A+B needs two actors to stay on separate Plates.
Only YOU can finish, so keep YOU free to cross after the Door opens.
```

This exact copy is not pre-approved; evaluate wording, density, timing, and whether a small causal diagram is preferable.

Reject:

- exact action sequences;
- screenshots of the solution route;
- next-action or target-turn advice;
- coordinates or target spacing;
- solver-backed hints;
- mandatory Timeline reverse-counting;
- converting Help into a full walkthrough.

Timeline remains optional. The task may recommend leaving it unchanged, deemphasizing it, or planning a separately bounded future removal/contextualization. Do not make it a required dependency.

## 11. Dotted-line policy

Because identities and dependencies were readable, dotted-line work is secondary. Evaluate only:

- retaining current lines;
- contextualizing/hiding lines when redundant;
- replacing dependency lines with existing label/shape/pip language;
- retaining ECHO movement feedback without an always-on web.

Any selected line change must preserve non-color-readable A/B, A+B, E2/E4, Door, and outcome information. Do not allow dotted-line preference to dominate the difficulty/Help repair.

## 12. Required outputs

Create:

```text
docs/level_design/BRIDGE_CURRICULUM_REPAIR_PLAN_CURRENT.md
docs/reports/0017D_BRIDGE_CURRICULUM_DIAGNOSTIC_REPORT.md
```

The plan must include:

- accepted baseline and owner evidence boundary;
- failure-state diagnosis;
- candidate comparison and weighted scores;
- exact selected primary and fallback;
- selected formal/presentation/Help boundary;
- prospective metrics and proof package;
- owner-only retest criteria;
- rollback and stop conditions;
- finale-blocking disposition;
- non-claims.

The diagnostic report must include commands, external artifacts/hashes, any failed diagnostic attempts, reconstruction confidence, candidate results, changed documentation paths, Git facts, and terminal verdict.

## 13. Owner-only retest target

Future classification:

```text
AUTHENTICATED_OWNER_NOT_FRESH_NOT_INDEPENDENT_BRIDGE_REPAIR_RETEST
```

Do not seek or require a third party.

Promotion criteria should include:

- P0=0/P1=0;
- the owner does not initially give up under the same false/recovery loop;
- the owner explains `BLOCKED/MOVED` spacing change;
- the owner explains that two ECHOs must remain on A+B while YOU stays free to cross;
- Help, if used, enables a credible experiment without revealing the route;
- Timeline is not required;
- completion or a credible recovery strategy occurs with materially lower burden than Task 0017V;
- bridge→shifted Level 8 feels like teaching→synthesis rather than repetition.

Prior exposure must be disclosed and limits difficulty claims.

## 14. Stop conditions

Stop and return to GPT if:

- no candidate preserves both-ECHO necessity and the teaching contract;
- the only effective Help is an exact walkthrough;
- a repair needs schema, Simulation, solver, new mechanics, persistent Door, push boxes, Gate, or actor-specific Plate ownership;
- a formal variant cannot remain below shifted Level 8 burden;
- presentation-only feedback would need route knowledge or solver state;
- the task cannot choose one primary bundle;
- unexpected repository files appear without an existing narrow cleanup rule.

Use the most specific blocker:

```text
BLOCKED_NO_BOUNDED_BRIDGE_REPAIR_PLAN
BLOCKED_HELP_REQUIRES_ROUTE_DISCLOSURE
BLOCKED_REPAIR_REQUIRES_FORBIDDEN_MECHANIC
BLOCKED_DIAGNOSTIC_EVIDENCE_INSUFFICIENT
BLOCKED_UNEXPECTED_WORKTREE_CHANGE
```

## 15. Git discipline and terminal verdict

Before staging, prove that only authorized Markdown paths changed. Stage explicit files only. Run worktree and cached diff checks.

Commit exactly once:

```text
docs: plan Delayed Self bridge curriculum repair
```

Fetch and stop on remote drift before push. Push normally to `origin/main`. Require clean tracked/untracked worktree and `HEAD == origin/main`.

On success return:

```text
BRIDGE_CURRICULUM_REPAIR_PLAN_READY_FOR_GPT_REVIEW
```

Include commit SHA, selected primary/fallback, diagnostic summary, proposed metric/proof boundary, report/plan paths, external evidence root, and final Git state.

This task does not authorize implementation, owner retest, finale planning, production, export, release, or submission.

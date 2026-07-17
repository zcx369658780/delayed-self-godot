# Task 0016R — Bridge mechanical-necessity plan revision

- Status: `READY`
- Gate: `DESIGN CORRECTION / SCHEMA-V1 MECHANICAL FEASIBILITY`
- Repository: `zcx369658780/delayed-self-godot`
- Expected branch: `main`
- Expected local root: `D:\Delayed_Self`
- Issued by: GPT Project Sources advisor
- Date: 2026-07-18
- Parent planning task: `tasks/0016_level_8_finale_and_difficulty_bridge_planning.md`
- Parent planning commit: `264989088089fcab4d2f2989bafca65a780ffc73`
- GPT adjudication: `docs/reports/0016_GPT_FINALE_SEQUENCE_PLAN_ADJUDICATION.md`
- Adjudication commit: `cdb45f7ed9ef7024a90fad80e8d8d31ef6df9793`
- Adjudication verdict: `TASK_0016_PLAN_REQUEST_CHANGES_SCHEMA_V1_NECESSITY_CONTRADICTION`

## 1. Objective

Revise only the exact mechanical structure of the proposed mandatory spacing bridge so that:

1. both delay-2 and delay-4 ECHOs can be proven individually necessary under accepted `simulation_v1`;
2. the bridge teaches obstacle/route/blocking-induced ECHO spacing change before the accepted `two_echo_convergence` synthesis;
3. the bridge remains materially simpler than current Level 7;
4. existing Levels 1–7 remain byte-identical and the future `signal_convergence` finale role is preserved;
5. the output is one implementation-ready planning target, not a formal level or implementation.

The high-level sequence direction remains provisionally selected:

```text
INSERT_BRIDGE_BEFORE_CURRENT_LEVEL_7
```

The withdrawn exact contract is:

```text
one Plate + one Door + both ECHOs individually necessary
```

Do not restore that combination unless a rigorous `simulation_v1` necessity argument disproves the GPT adjudication. A statement that both ECHOs are visually useful, conceptually present, or helpful for feedback is not mechanical necessity.

## 2. Mandatory startup gate

Before any write:

```powershell
Get-Location
git branch --show-current
git rev-parse HEAD
git rev-parse origin/main
git remote -v
git status --short --untracked-files=all
git log -24 --oneline --decorate
```

Required:

- absolute root `D:\Delayed_Self`;
- branch `main`;
- expected origin;
- clean tracked and untracked worktree;
- local and remote contain this task and the GPT adjudication;
- no divergence, conflict, or unexpected file.

If clean local `main` is behind, use only:

```powershell
git fetch origin
git merge --ff-only origin/main
```

Stop on any unsafe condition.

## 3. Required reads

Read in order:

1. `AGENTS.md`;
2. current startup and active-task documents;
3. this task;
4. `docs/reports/0016_GPT_FINALE_SEQUENCE_PLAN_ADJUDICATION.md`;
5. `docs/level_design/LEVEL_8_FINALE_AND_DIFFICULTY_BRIDGE_PLAN_CURRENT.md`;
6. `docs/reports/0016_LEVEL_8_FINALE_AND_DIFFICULTY_BRIDGE_PLANNING_REPORT.md`;
7. `docs/game_design/GAMEPLAY_SIMULATION_CONTRACT_CURRENT.md`;
8. `docs/level_design/LEVEL_SCHEMA_V1_CURRENT.md` and `schemas/level_v1.schema.json`;
9. current catalog and all seven formal level JSON files;
10. Task 0012 and Task 0015 validations/reports for established necessity-control patterns;
11. Task 0015D plan/report and Task 0015RV review/acceptance for the spacing-change teaching gap;
12. current difficulty, presentation, development, handoff, index, and memory documents.

Before writing, print a concise summary of:

- the contradiction being repaired;
- the accepted sequence direction;
- candidate grammars to compare;
- the mechanical role assigned to E2 and E4 in each candidate;
- how each candidate differs from Levels 6, current 7, and future finale;
- proof feasibility and likely presentation risk;
- exact Markdown paths selected.

## 4. Frozen authorities and non-goals

Treat as immutable:

- `simulation_v1`, `level_v1`, catalog v1, solver semantics, history, blocked-action recording, legal overlap, combinational Doors, next-input Door snapshot, and player-only EXIT;
- Godot/toolchain and current reusable Gameplay behavior;
- all seven formal level JSON files, IDs, hashes, metrics, and accepted validations;
- current `two_echo_convergence` formal file and its exact evidence;
- Task 0015R divergence feedback implementation;
- owner-only review constraint;
- WAIT as deferred research;
- future `signal_convergence` as a later multi-stage finale concept.

Do not modify or authorize:

- formal level JSON or catalog;
- runtime, solver, schema, tests, scenes, `project.godot`, Timeline, Help, presentation code, assets, audio, persistence, export, release, or submission;
- Gate, latch, persistent Door, push box, hazard, new actor, new action, actor collision, actor-specific Plate rules, or any new mechanic;
- exact route, coordinates, witness, movement sequence, or measured solver result;
- Level 8/finale implementation.

Do not run Godot, solver, tests, capture, build, or export. This is a contract-revision and planning task only.

## 5. Required mechanical-feasibility lemma

For every candidate, state the exact causal obligations of E2 and E4 under `simulation_v1`.

A valid necessity lemma must explain:

1. which state transition or Door window requires E2;
2. which different transition or Door window requires E4;
3. why YOU cannot substitute for either role;
4. why legal actor overlap does not collapse the roles;
5. why removing E2 preserves all other actors but destroys completion;
6. why removing E4 preserves all other actors but destroys completion;
7. why the result does not rely on presentation, hidden rules, or a future mechanic.

The following are insufficient:

- “two ECHOs make spacing visible”;
- “both delays appear on screen”;
- “the player is expected to use both”;
- “the level has two ECHOs in its JSON”;
- “the solver will probably show necessity later.”

If a candidate cannot support a credible necessity lemma, reject it before scoring.

## 6. Candidate set

Compare at least the following three candidates. You may add one additional bounded schema-v1 candidate, but must still decide exactly one target.

### Candidate A — Simplified two-Plate AND tutorial

Minimum grammar:

```text
two ECHOs d=2/d=4
two distinct Plates
one A+B combinational Door
one player-only EXIT
```

Required differentiation from current `two_echo_convergence`:

- early and visually obvious blocked/moved divergence;
- smaller/easier topology and lower prospective search burden;
- one primary causal experiment rather than a long phase-management loop;
- fewer meaningful decisions and simpler recovery;
- no need to discover the full current Level 7 route grammar;
- current Level 7 remains the later synthesis/challenge.

Risk: repeats the same entity grammar. The plan must explain why this is deliberate curriculum scaffolding rather than redundant content.

### Candidate B — Dual single-dependency windows

Minimum grammar:

```text
two ECHOs d=2/d=4
two distinct Plates
two Doors with distinct single-Plate dependencies
one player-only EXIT
```

Required:

- E2 and E4 own different necessary windows or stages;
- both single-ECHO controls are plausibly unsolved;
- the room teaches spacing manipulation rather than simply repeating Level 6's staggered Doors;
- it does not consume the future finale's mixed single/AND two-stage synthesis role;
- dependency visibility remains bounded under `LABEL_SHAPE_PIP_PRIMARY_NO_NEW_LINES`.

Reject if it is merely Level 6 plus another actor or a smaller version of the finale.

### Candidate C — One-Plate multi-window structure

Eligible grammar:

```text
two ECHOs d=2/d=4
one Plate
at least two mechanically required Door crossing windows or equivalent schema-v1 obligations
one player-only EXIT
```

This candidate is eligible only if the plan supplies a rigorous contract-level explanation for how both E2-only and E4-only variants can be complete-unsolved. The argument must address the fact that actors are independent, overlap is legal, and one Plate can be occupied by only one necessary holder at any single crossing.

If no such argument exists, reject Candidate C explicitly as infeasible. Do not disguise repeated route length or optional extra crossings as necessity.

### Mandatory rejected baseline — observational second ECHO

Evaluate and reject:

```text
one ECHO mechanically opens the only Door
the second ECHO exists only to display changing spacing
```

Explain why this would allow a single-ECHO solution and fail to force the intended lesson.

## 7. Selection criteria

Score viable candidates on a five-point scale with explicit weights:

- mechanical feasibility / dual-ECHO necessity — 25%;
- curriculum continuity — 20%;
- differentiation from current Level 7 — 15%;
- future finale preservation — 15%;
- observability and recovery — 10%;
- proof/control feasibility — 10%;
- catalog/presentation risk — 5%.

An infeasible candidate receives no weighted score and is marked `REJECTED_CONTRACT_INFEASIBLE`.

Select exactly one target. No ties, hybrid ambiguity, or “A or B depending on implementation” result is allowed.

## 8. Revised target freeze

Create or replace the bridge section in:

```text
docs/level_design/LEVEL_8_FINALE_AND_DIFFICULTY_BRIDGE_PLAN_CURRENT.md
```

The revised exact target must freeze:

- `level_id` and display title;
- sequence role and future order;
- exact counts of ECHOs, Plates, Doors, and EXIT;
- exact delay set;
- dependency grammar;
- maximum board envelope and topology class;
- explicit E2 necessity lemma;
- explicit E4 necessity lemma;
- spacing-change teaching event;
- meaningful-decision and recovery hypotheses;
- anti-padding and shortcut conditions;
- prospective quantitative bands;
- complete future proof/control package;
- presentation/Help/Timeline policy;
- owner-only review questions;
- stop/rollback conditions;
- non-claims.

The target must remain materially below current Level 7's accepted burden:

```text
current Level 7: L*=19, N*=6 EXACT, visited=61975, frontier=21449
```

Prospective bridge bands must be internally consistent with the chosen grammar. Do not keep the earlier ranges automatically if the revised entity structure warrants different bands.

## 9. Sequence and finale preservation

Unless the candidate comparison proves the entire bridge direction should be abandoned, preserve:

```text
existing Levels 1–6
→ revised mandatory bridge
→ byte-identical two_echo_convergence
→ future signal_convergence finale
```

The plan must state exact future catalog migration facts, but no catalog edit occurs here.

`signal_convergence` must retain a materially larger synthesis role. If the selected bridge uses two Doors or A+B, explain precisely what remains unique to the finale, such as three Plates, mixed single/AND stages, multi-zone dependency depth, or another accepted-mechanic synthesis.

## 10. Outputs and authorized files

Create:

```text
docs/reports/0016R_BRIDGE_MECHANICAL_NECESSITY_PLAN_REVISION_REPORT.md
```

Update only the minimum necessary subset of:

```text
docs/level_design/LEVEL_8_FINALE_AND_DIFFICULTY_BRIDGE_PLAN_CURRENT.md
docs/CODEX_ACTIVE_TASK_CURRENT.md
docs/CODEX_STARTUP_SNAPSHOT_CURRENT.md
docs/DEVELOPMENT_PLAN_CURRENT.md
docs/DOC_INDEX_CURRENT.md
docs/HANDOFF_MASTER_CURRENT.md
docs/project_memory.md
docs/level_design/INITIAL_LEVEL_ROADMAP_AND_VALIDATION_MATRIX_CURRENT.md
docs/level_design/FIVE_LEVEL_DIFFICULTY_RECOVERY_AND_LEVELS_6_8_PLAN.md
docs/ux/PRESENTATION_VIEWPORT_AND_HUD_DIRECTION_CURRENT.md
```

Do not modify the Task 0016 report or GPT adjudication. Historical artifacts remain immutable.

## 11. Report requirements

The report must include:

- startup Git facts;
- exact contradiction and accepted GPT reasoning;
- candidate feasibility lemmas;
- rejected infeasible candidates;
- weighted comparison of viable candidates;
- unique selected target;
- revised entity/dependency structure;
- explicit E2 and E4 necessity obligations;
- differentiation from Levels 6/current 7/future finale;
- revised prospective bands;
- future catalog migration;
- proof/control package;
- presentation/Help/Timeline policy;
- changed paths and protected surfaces;
- unresolved risks;
- non-claims and next gate.

## 12. Git discipline

Before staging:

```powershell
git status --short --untracked-files=all
git diff --check
git diff --stat
```

Require only authorized Markdown paths. Stage explicit paths only. Never use broad staging.

Then:

```powershell
git diff --cached --check
git diff --cached --name-only
```

Commit exactly once:

```text
docs: revise Delayed Self bridge necessity plan
```

Fetch and require no remote drift, then push normally to `origin/main`. Final worktree must be clean and `HEAD == origin/main`.

## 13. Terminal verdicts

After one successful documentation commit and push:

```text
BRIDGE_MECHANICAL_NECESSITY_PLAN_READY_FOR_GPT_REVIEW
```

Include:

- commit SHA;
- unique selected candidate;
- exact entity/dependency grammar;
- one-sentence E2 necessity;
- one-sentence E4 necessity;
- revised prospective bands;
- plan/report paths;
- confirmation no product/formal/test files changed;
- final Git state.

If no schema-v1 bridge can make both ECHOs mechanically necessary while staying below current Level 7 and preserving the finale, stop with:

```text
BLOCKED_NO_FEASIBLE_SCHEMA_V1_BRIDGE_GRAMMAR
```

If the only feasible target duplicates current Level 7 so completely that it has no distinct curriculum role, stop with:

```text
BLOCKED_BRIDGE_COLLAPSES_INTO_CURRENT_LEVEL_7
```

No terminal verdict is GPT acceptance or implementation authority.

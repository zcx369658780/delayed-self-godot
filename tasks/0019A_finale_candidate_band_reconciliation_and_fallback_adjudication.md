# Task 0019A — Reconcile finale candidate bands and adjudicate fallback

- Status: `READY`
- Gate: `EXTERNAL CANDIDATE DIAGNOSTIC + PRE-REGISTERED BAND RECONCILIATION`
- Repository/root/branch: `zcx369658780/delayed-self-godot` / `D:\Delayed_Self` / `main`
- Parent blocked task: `tasks/0019_signal_convergence_finale_implementation.md`
- GPT blocker adjudication: `docs/reports/0019_GPT_CANDIDATE_A_SEARCH_BLOCKER_ADJUDICATION.md`
- Expected publication checkpoint: `dfdc8dc0d76a9aa00f07dbaf3764e9ebea124980`

## 1. Objective

Use the existing Task 0019 search ledger to determine whether candidate A failed because the structure is infeasible or because Task 0019's narrowed metric band excluded candidates that still satisfy the earlier Task 0018 pre-registered planning band.

This task is external diagnostics and documentation only. It must not resume Task 0019 product implementation, create `signal_convergence.json`, migrate the catalog, or modify product/test source.

Intermediate progress messages are not terminal results. Continue the same execution flow until one terminal verdict in section 12 is reached, unless an explicit blocker condition applies.

## 2. Startup and synchronization

Before any diagnostic run:

- verify root exactly `D:\Delayed_Self`;
- verify branch `main` and SSH expected origin;
- require a fully clean tracked and untracked worktree;
- fetch and fast-forward only;
- require `HEAD == origin/main` and that HEAD contains this task and `dfdc8dc0d76a9aa00f07dbaf3764e9ebea124980`;
- verify Godot `4.7.stable.steam.5b4e0cb0f` or the exact documented equivalent;
- require no residual Godot process.

Stop on divergence, conflict, unexpected files, wrong root/remote, or materially different toolchain.

## 3. Required reads and external evidence

Read:

1. `AGENTS.md` and current startup/active-task documents;
2. this task and the GPT blocker adjudication;
3. Task 0019, Task 0018 plan/report/GPT acceptance;
4. Task 0017RC/0017RCV accepted Help and owner-boundary documents;
5. simulation, schema, solver, catalog, progression, presentation, testing, capture, and generated-file safety contracts.

Inspect without rewriting:

```text
D:\Delayed_Self_Evidence\0019_signal_convergence_finale\SEARCH_LEDGER.md
```

and every retained Task 0019 canonical candidate definition/result referenced by that ledger.

Use a new external root:

```text
D:\Delayed_Self_Evidence\0019A_finale_band_reconciliation\
```

Do not overwrite prior evidence.

## 4. Two immutable comparison bands

Compare every valid Stage-B result against exactly these two pre-existing bands.

### PLAN_BAND — accepted Task 0018

```text
21 <= L* <= 30
1 <= N* <= 12
N* status = EXACT
20000 <= visited_states <= 300000
2000 <= maximum_frontier <= 50000
```

### NARROW_BAND — Task 0019

```text
22 <= L* <= 28
1 <= N* <= 8
N* status = EXACT
30000 <= visited_states <= 250000
3000 <= maximum_frontier <= 40000
```

Do not invent a third band, candidate-specific exception, weighted acceptance score, or post-hoc threshold.

## 5. Ledger reconciliation

For all 32 Task 0019 Stage-B solver candidates, record:

- candidate ID and canonical definition hash;
- structural family and board dimensions;
- `L*`, `N*`, count status, visited, frontier, solve/limit status;
- pass/fail for each individual PLAN_BAND field;
- pass/fail for each individual NARROW_BAND field;
- exact rejection mask for both bands;
- normalized distance to each nearest violated boundary;
- whether the candidate still satisfies the candidate-A grammar and basic D1/D2 articulation checks.

Produce:

- min, max, median, quartiles, and distinct-value counts for each metric;
- pairwise correlations or a clearly described nonparametric association summary;
- rejection counts by field and field combination;
- a Pareto frontier over lower causal burden, exact solution count, visited, and frontier without treating the frontier as acceptance;
- the eight nearest structurally valid candidate-A results to PLAN_BAND.

Verify any parsed ledger result against the retained raw solver output. If ledger and raw artifacts disagree, stop with `BLOCKED_FINALE_LEDGER_INCONSISTENT`.

## 6. Candidate-A continuation under PLAN_BAND

If one or more structurally valid candidates satisfy every PLAN_BAND field:

1. Do not regenerate candidates and do not use a candidate outside the existing Task 0019 ledger.
2. Rank survivors by causal-stage observability, distance from sequence 8, recovery potential, board compactness, and proof cost. Metrics are already hard-filtered and must not be reweighted into acceptance.
3. Advance at most eight survivors to complete Stage-C controls.
4. Advance at most three Stage-C survivors to complete Stage-D augmented proof.

Use the Task 0019 frozen normal solver limits:

```text
depth_limit = 64
state_limit = 500000
time_limit_ms = 60000
solution_count_cap = 1000000
```

Use the Task 0019 complete augmented ceiling:

```text
augmented_states <= 2000000
wall_time <= 180 seconds
```

A resource-limit result is unverified.

### Stage-C requirements

Require complete-unsolved:

- no ECHO;
- E2 only;
- E4 only;
- equal 2/2;
- equal 4/4.

Also verify exact witness replay/restart, D1/D2 articulations, Plate distances, pairwise-distinct entities, and no terrain bypass.

### Stage-D requirements

Exhaust the augmented finite state space with the Task 0019 event flags and require:

```text
no completion without the stage-1 D1 chain
no useful A+B before stage-1 enabling
no completion with YOU substitution at final A+B
no completion with reverse final E2/E4 role mapping
no completion bypassing either Door articulation
all shortest completions contain the full ordered two-stage chain
```

A candidate that fails any class is rejected.

If exactly one candidate survives all Stage-C/D requirements, select it as `DIAGNOSTIC_SELECTED_NOT_FORMAL`. Preserve its exact JSON externally, record its canonical hash and full proof, but do not write product data.

If multiple candidates survive, select exactly one using the non-metric structural ranking above and record why the others are not selected.

## 7. Fallback-B pilot only when A has no PLAN_BAND survivor

Run this section only if no existing candidate-A result satisfies PLAN_BAND, or every PLAN_BAND candidate fails complete Stage C/D.

Candidate B remains external and non-product. Use the accepted grammar but reverse dependency order: A+B first, single-Plate Door final.

Hard pilot budget:

```text
B structural candidates <= 16
B normal-solver candidates <= 8
B strict-control candidates <= 3
B complete augmented proofs <= 1
```

Use PLAN_BAND, not NARROW_BAND, and the same solver/proof limits.

A B candidate may support fallback activation only if it:

- satisfies PLAN_BAND exactly;
- passes all five strict controls;
- passes complete augmented proof for its ordered B chain;
- is materially differentiated from sequence 8 despite beginning with A+B;
- does not produce an anticlimactic ceremonial single-Plate ending;
- preserves recovery and 960×540 observability plausibility.

Do not write a B formal level or catalog entry.

## 8. Decision policy

Select exactly one disposition:

### A1 — Candidate A survives original plan band

Use when one candidate-A result passes PLAN_BAND, all strict controls, and complete augmented proof.

### B1 — Activate fallback B for a later implementation task

Use only when A has no complete survivor and one B pilot candidate passes every external diagnostic gate.

### C1 — Reassess or omit sequence 9

Use when neither A nor B yields a complete external survivor. Recommend a fresh planning decision between a reduced finale grammar and retaining sequence 8 as the final level. Do not infer which option wins.

Do not broaden PLAN_BAND, expand the pilot budgets, activate interleaved candidate C, add mechanics, or silently accept a partial proof.

## 9. Outputs

Create:

```text
docs/level_design/SIGNAL_CONVERGENCE_CANDIDATE_ADJUDICATION_CURRENT.md
docs/reports/0019A_FINALE_BAND_RECONCILIATION_REPORT.md
```

The candidate adjudication must include:

- both immutable bands;
- complete Stage-B rejection distribution;
- PLAN_BAND survivor list;
- Stage-C/D or fallback-B results;
- exactly one final disposition;
- selected candidate identity only when complete proof exists;
- explicit non-product status;
- next authorized gate and rollback.

Update only the minimum CURRENT planning, index, handoff, and project-memory Markdown files.

## 10. Authorized repository paths

May create or update only Markdown under:

```text
docs/level_design/SIGNAL_CONVERGENCE_CANDIDATE_ADJUDICATION_CURRENT.md
docs/reports/0019A_FINALE_BAND_RECONCILIATION_REPORT.md
docs/CODEX_ACTIVE_TASK_CURRENT.md
docs/CODEX_STARTUP_SNAPSHOT_CURRENT.md
docs/DEVELOPMENT_PLAN_CURRENT.md
docs/DOC_INDEX_CURRENT.md
docs/HANDOFF_MASTER_CURRENT.md
docs/project_memory.md
docs/level_design/SIGNAL_CONVERGENCE_FINALE_PLAN_CURRENT.md
```

Do not modify tasks, prior reports, formal levels, catalog, source, tests, schemas, scenes, project settings, assets, persistence, build, export, release, or submission surfaces.

## 11. Git discipline

Record scripts, commands, inputs, outputs, exits, limits, candidate definitions, hashes, and evidence inventory externally.

Require one documentation-only commit:

```text
docs: reconcile Delayed Self finale candidate bands
```

Stage explicit authorized Markdown files only. Require `git diff --check`, fetch before push, normal push, clean tracked/untracked worktree, `HEAD == origin/main`, and no Godot process.

## 12. Terminal verdict

Return exactly one successful terminal verdict:

```text
FINALE_CANDIDATE_A_PLAN_BAND_SURVIVOR_READY_FOR_GPT_REVIEW
FINALE_FALLBACK_B_ACTIVATION_RECOMMENDED_FOR_GPT_REVIEW
FINALE_SCOPE_REASSESSMENT_REQUIRED_FOR_GPT_REVIEW
```

Or one blocker:

```text
BLOCKED_FINALE_LEDGER_INCONSISTENT
BLOCKED_FINALE_PROOF_LIMIT
BLOCKED_UNEXPECTED_WORKTREE_CHANGE
```

Include commit SHA, both-band distributions, survivor/proof counts, selected disposition, external evidence root, output paths, and final Git state.

This task does not authorize product implementation, owner review, localization, production, build/export, release, or submission.

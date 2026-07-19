# Task 0019B — Complete the fixed-candidate B007 finale proof

- Status: `READY`
- Gate: `FIXED EXTERNAL CANDIDATE / FINAL COMPLETE AUGMENTED PROOF`
- Repository/root/branch: `zcx369658780/delayed-self-godot` / `D:\Delayed_Self` / `main`
- Parent task: `tasks/0019A_finale_candidate_band_reconciliation_and_fallback_adjudication.md`
- GPT adjudication: `docs/reports/0019A_GPT_B007_PROOF_LIMIT_ADJUDICATION.md`
- Expected adjudication checkpoint: `e1846f3afa494a45bd499221727cb718fda399d8`
- Fixed candidate: retained external fallback-B candidate `B007`

## 1. Objective

Complete one final bounded proof attempt for the exact retained `B007` candidate.

`B007` already satisfies the accepted Task 0018 `PLAN_BAND` and all Task 0019A Stage-C controls:

```text
L* = 23
N* = 3 EXACT
visited_states = 77,848
maximum_frontier = 23,861
```

The prior Stage-D run reached 665,338 augmented states and frontier 143,810 at the 180-second wall-time ceiling without exhaustion. This task determines whether `B007` completely satisfies the fallback-B ordered curriculum chain or whether sequence 9 must return to scope reassessment.

This task is external diagnostics and documentation only. It must not implement the level or edit product/test files.

Intermediate progress updates are not terminal results. Continue the same execution flow until one terminal verdict in section 12 is reached unless an explicit consistency blocker occurs.

## 2. Startup and synchronization

Before any diagnostic run:

- verify root exactly `D:\Delayed_Self`;
- verify branch `main` and expected SSH origin;
- require a clean tracked and untracked worktree;
- fetch and fast-forward only;
- require `HEAD == origin/main` and that HEAD contains this task and `e1846f3afa494a45bd499221727cb718fda399d8`;
- verify the accepted Godot toolchain;
- require no residual Godot process.

Stop on divergence, conflict, unexpected files, wrong root/remote, or materially different toolchain.

## 3. Required reads and retained evidence

Read:

1. `AGENTS.md` and current startup/active-task documents;
2. this task and the GPT proof-limit adjudication;
3. Tasks 0018, 0019, and 0019A plus their reports/adjudications;
4. frozen Simulation, schema, solver, catalog, progression, Help, Timeline, presentation, and evidence-safety contracts.

Inspect without overwriting:

```text
D:\Delayed_Self_Evidence\0019_signal_convergence_finale\
D:\Delayed_Self_Evidence\0019A_finale_band_reconciliation\
```

Locate the exact retained canonical definition, hash, normal result, strict-control results, Stage-D script, partial output, and evidence index for `B007`.

Use a new external root:

```text
D:\Delayed_Self_Evidence\0019B_b007_complete_proof\
```

Do not overwrite prior evidence.

## 4. Candidate identity gate

Before proof continuation, verify and record:

- exact canonical candidate definition and SHA-256;
- fallback-B dependency order: A+B stage first, single-Plate stage final;
- board dimensions and all entity/dependency facts;
- normal result exactly `23 / 3 EXACT / 77,848 / 23,861`;
- deterministic witness replay and restart;
- all five Stage-C complete-unsolved controls;
- both Door articulation checks;
- no terrain bypass and pairwise-distinct entities.

The retained raw artifacts and any rerun must agree. Stop with `BLOCKED_B007_CANDIDATE_OR_HARNESS_INCONSISTENT` on any mismatch. Do not repair a mismatch by changing the candidate, thresholds, product, Simulation, or solver.

## 5. Frozen proof ceiling

Run one final complete augmented proof for `B007` only:

```text
augmented_state_limit = 2,000,000
wall_time_limit = 900 seconds
candidate generation/search = forbidden
candidate mutation = forbidden
PLAN_BAND = unchanged
```

The 2,000,000-state ceiling is unchanged from Task 0019A. The wall-time extension is the only authorized resource change.

Prefer the retained reference harness with the extended wall time. A compact external representation is allowed only when necessary, and only after deterministic cross-checks show identical canonical transitions and event classification against the retained harness on a substantial reproducible prefix/sample. Record the cross-check method and result.

A limit result is not complete proof. If either ceiling is reached without exhaustion, select scope reassessment; do not request another expansion.

## 6. Fallback-B ordered chain

Map the retained candidate's IDs to these semantic roles without modifying it:

1. final-convergence Plates `A` and `B` open the first/intermediate A+B Door;
2. following-input crossing of that Door creates route access or phase required for the later single-Plate stage;
3. a delayed ECHO presses single Plate `S`, opening the final single-dependency Door;
4. on the following open start-turn snapshot, YOU enters the final Door;
5. YOU alone reaches EXIT.

Freeze and record the measured stable E2/E4 assignment on A/B and the causally required actor/crossing for each stage. Do not expose a route in product Help because no product change is authorized.

## 7. Complete augmented flags

Augment the canonical state with monotonic flags sufficient to distinguish at least:

- useful E2/E4 A+B result with YOU free;
- reverse E2/E4 A/B role result;
- YOU substitution at the useful A+B result;
- A+B Door open result;
- following-input A+B Door entry/crossing;
- post-crossing enabling state for the single-Plate stage;
- useful single-Plate result before A+B enabling;
- `S` pressed by the required delayed actor;
- final single Door open result;
- following-input final Door entry;
- bypass of either Door articulation;
- completion.

Expand all accepted actions until the augmented reachable state space is exhausted or a frozen ceiling is reached.

## 8. Direct acceptance gates

A complete survivor must prove all of the following:

```text
no completion without the opening A+B chain
no useful final single-Plate result before A+B crossing/enabling
no completion with YOU substitution at the useful A+B result
no completion with reverse final E2/E4 role mapping
no completion bypassing either Door articulation
all shortest completions contain the full ordered B chain
```

The first A+B stage must materially enable the final single-Plate stage. The final single dependency must not be ceremonial or anticlimactic in the mechanical sense: removing/bypassing it must break completion rather than merely shorten a corridor.

If the exhausted space contains any violating completion class, `B007` fails.

## 9. Structural differentiation and recovery audit

If and only if the complete direct gates pass, also record externally:

- why `B007` is materially more than sequence 8 followed by a trivial corridor;
- 4–6 meaningful decisions without distance/collision/WAIT padding;
- at least four plausible recoverable non-optimal alternatives;
- static 960×540/grayscale plausibility for three Plates and two Door dependencies;
- why the final single-Plate stage is a causal payoff rather than an anticlimax.

These audits support later implementation authorization but do not replace complete proof.

## 10. Decision policy

Select exactly one:

### B1 — Complete fallback-B survivor

Use only if the augmented space exhausts below both ceilings and every direct gate passes. Record `B007` as:

```text
DIAGNOSTIC_SELECTED_NOT_FORMAL
```

Recommend explicit fallback-B activation through a later implementation task. Do not write product data.

### C1 — Scope reassessment

Use when:

- complete exhaustion finds any violating completion class; or
- 2,000,000 augmented states or 900 seconds is reached without exhaustion; or
- the candidate passes proof but fails material differentiation/recovery/observability plausibility.

Recommend a fresh planning decision between reducing the sequence-9 grammar and retaining sequence 8 as the final level. Do not infer which option wins.

Do not expand resources again, regenerate candidates, activate candidate C, add mechanics, or implement a partial proof.

## 11. Repository outputs and Git discipline

Create/update documentation only:

```text
docs/level_design/SIGNAL_CONVERGENCE_CANDIDATE_ADJUDICATION_CURRENT.md
docs/reports/0019A_FINALE_BAND_RECONCILIATION_REPORT.md
docs/reports/0019B_B007_COMPLETE_PROOF_REPORT.md
docs/CODEX_ACTIVE_TASK_CURRENT.md
docs/CODEX_STARTUP_SNAPSHOT_CURRENT.md
docs/DEVELOPMENT_PLAN_CURRENT.md
docs/DOC_INDEX_CURRENT.md
docs/HANDOFF_MASTER_CURRENT.md
docs/project_memory.md
docs/level_design/SIGNAL_CONVERGENCE_FINALE_PLAN_CURRENT.md
```

Do not modify tasks, prior reports, formal levels, catalog, source, tests, schemas, scenes, project settings, assets, persistence, build, export, release, or submission surfaces.

Record scripts, commands, candidate hash, raw/compact cross-check, outputs, limits, exits, exhaustion/limit status, event definitions, class counts, and evidence hashes externally.

Require one documentation-only commit:

```text
docs: complete Delayed Self B007 finale proof
```

Push normally and require a clean worktree, `HEAD == origin/main`, divergence `0/0`, and no residual Godot process.

## 12. Terminal verdict

Return exactly one:

```text
B007_FALLBACK_B_COMPLETE_PROOF_READY_FOR_GPT_REVIEW
FINALE_SCOPE_REASSESSMENT_REQUIRED_FOR_GPT_REVIEW
BLOCKED_B007_CANDIDATE_OR_HARNESS_INCONSISTENT
```

Include the commit SHA when a documentation result is produced, exact candidate hash, reproduced metrics/controls, proof exhaustion or limit data, direct-gate class results, selected disposition, output paths, external evidence root, and final Git state.

This task authorizes no formal finale implementation, catalog migration, owner review, production, localization, build/export, release, or submission work.

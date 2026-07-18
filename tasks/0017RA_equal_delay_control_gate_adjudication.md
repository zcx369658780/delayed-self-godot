# Task 0017RA — Adjudicate the bridge equal-delay control gate

- Status: `READY`
- Gate: `DESIGN DIAGNOSTIC / HARD-GATE ADJUDICATION`
- Repository/root/branch: `zcx369658780/delayed-self-godot` / `D:\Delayed_Self` / `main`
- Parent blocked task: `tasks/0017R_bridge_curriculum_geometry_and_help_repair.md`
- GPT blocker adjudication: `docs/reports/0017R_GPT_EQUAL_DELAY_GATE_BLOCKER_ADJUDICATION.md`
- Current accepted bridge SHA-256: `805cdc05ea9b3805189ba7be4938cb7ede4e7056b9ae9a7e911df96a801d58ee`

## 1. Objective

Determine whether the strict requirement that equal-delay 2/2 and 4/4 variants be completely unsolved should remain, or whether it should be replaced by a more direct proof of the bridge curriculum lesson.

This task is diagnostic and planning only. It must not change product data, Gameplay, Help, tests, catalog, Simulation, solver, schema, scenes, or project settings.

## 2. Known dirty-start exception and safe synchronization

The local repository is expected to contain exactly one pre-existing unstaged/untracked report:

```text
docs/reports/0017R_BRIDGE_CURRICULUM_REPAIR_REPORT.md
```

No other staged, unstaged, untracked, conflicted, generated, or unexpected path is allowed.

Before fetch, verify root, branch, SSH origin, local HEAD, origin/main, status, and no Godot process. Fetch origin and require that the remote-only changes since local HEAD are limited to:

```text
docs/reports/0017R_GPT_EQUAL_DELAY_GATE_BLOCKER_ADJUDICATION.md
tasks/0017RA_equal_delay_control_gate_adjudication.md
```

Then use only `git merge --ff-only origin/main`. Stop if the dirty report overlaps, synchronization fails, or any additional local/remote path exists.

Preserve the existing blocker report byte-for-byte and include it in the final documentation-only commit.

## 3. Required reads

Read `AGENTS.md`, current startup/task documents, this task, the GPT blocker adjudication, Task 0017R and its accepted plan, the existing uncommitted blocker report, Task 0017C validation, Task 0017V owner evidence, `simulation_v1`, schema/catalog contracts, and relevant solver/test helpers.

Inspect the external evidence root:

```text
D:\Delayed_Self_Evidence\0017R_bridge_curriculum_repair\
```

Identify the exact near candidate reported as closing terrain cell `[5,4]`. Treat it as `DIAGNOSTIC_ONLY_NOT_FORMAL`.

## 4. Core formal reasoning

First prove from `simulation_v1` and verify in runtime diagnostics:

- shared-spawn ECHOs with equal delay receive the same action each turn;
- starting overlapped and resolving against the same door snapshot, they remain overlapped by induction;
- therefore equal-delay ECHOs cannot occupy two distinct Plate cells simultaneously;
- any equal-delay solution to a two-Plate A+B room must use YOU on at least one Plate at the useful open result.

Do not infer that equal-delay solvability is acceptable merely from this invariant.

## 5. Required near-candidate diagnostics

Using external scripts only, reconstruct the near candidate exactly and reproduce its reported metrics.

Run complete finite-state augmented searches that answer all of the following:

1. **Actual spacing-event necessity** — is there any completed reachable state without a post-activation transition containing one ECHO `BLOCKED`, the other `MOVED`, and a signed or Manhattan spacing change?
2. **Actual intended-chain necessity** — is there any completed reachable state without first reaching E2 on A, E4 on B, A+B open, and YOU free/staged for the following open-snapshot Door entry?
3. **Actual YOU-substitution exclusion** — is there any completed route where YOU occupies either Plate at the useful A+B result instead of remaining free?
4. **Equal-delay 2/2 characterization** — exact solve/count/status/metrics; all shortest role states; whether every completion uses YOU substitution; whether any completion realizes the intended separated-ECHO chain.
5. **Equal-delay 4/4 characterization** — the same evidence.
6. **Material-difference audit** — compare witness structure, role mapping, required spacing event, shortest length/count, and meaningful decisions between the actual near candidate and equal-delay controls.

A resource-limited result is unverified. Complete-negative claims require exhaustion of the augmented finite state space.

## 6. Policy alternatives

Evaluate exactly these policies:

### A — Preserve strict gate

Equal-delay 2/2 and 4/4 must remain complete-unsolved. Future work may authorize a larger but still bounded topology search. The near candidate remains rejected.

### B — Replace proxy with direct curriculum gate

The actual formal candidate must have complete finite-state proof that no completion exists without the required spacing event, intended separated-ECHO A+B role chain, and YOU-free open-snapshot crossing. Equal-delay controls may solve only if complete evidence proves they cannot realize that intended chain and instead require a materially different YOU-substitution solution.

### C — Abandon geometry simplification

Keep the accepted bridge byte-identical and pursue only contextual causal Help, with the curriculum burden explicitly unresolved until owner retest.

Select exactly one policy. Do not create a hybrid or defer the decision.

## 7. Decision standards

Policy B may be selected only if all three actual-candidate augmented necessity searches are complete-negative and both equal-delay variants are fully characterized. Mere all-shortest evidence is insufficient.

Policy A must be selected if the near candidate admits any actual completion without the intended lesson, or if equal-delay solution classes cannot be exhaustively characterized.

Policy C may be selected only if evidence shows geometry simplification conflicts with the lesson more fundamentally than the equal-delay proxy issue.

## 8. Outputs

Create:

```text
docs/level_design/BRIDGE_EQUAL_DELAY_GATE_ADJUDICATION_CURRENT.md
docs/reports/0017RA_EQUAL_DELAY_GATE_DIAGNOSTIC_REPORT.md
```

Commit the existing report:

```text
docs/reports/0017R_BRIDGE_CURRICULUM_REPAIR_REPORT.md
```

Update only the minimum CURRENT navigation, handoff, plan, index, and project-memory Markdown files necessary to point to the decision.

No product, formal level, catalog, source, scene, test, schema, or project-setting path may change.

Use external evidence root:

```text
D:\Delayed_Self_Evidence\0017RA_equal_delay_gate_adjudication\
```

Record scripts, commands, exact candidate definition, outputs, exits, limits, augmented-state definitions, hashes, and an evidence index. Nothing external enters Git.

## 9. Git discipline

Require one documentation-only commit:

```text
docs: adjudicate Delayed Self equal-delay bridge gate
```

Stage explicit authorized Markdown paths only. No Godot-generated file cleanup should be needed because no product Godot process is required beyond optional headless external diagnostics; if an unexpected repository path appears, stop.

Push normally and require a clean worktree with `HEAD == origin/main`.

## 10. Terminal verdict

Return exactly one:

```text
BRIDGE_EQUAL_DELAY_STRICT_GATE_RETAINED_READY_FOR_GPT_REVIEW
BRIDGE_DIRECT_CURRICULUM_GATE_REVISION_READY_FOR_GPT_REVIEW
BRIDGE_HELP_ONLY_POLICY_READY_FOR_GPT_REVIEW
```

Include the commit SHA, selected policy, complete augmented-search results, equal-delay characterization, output paths, external evidence root, and final Git state.

This task does not authorize implementation, owner retest, finale planning, production, export, release, or submission.

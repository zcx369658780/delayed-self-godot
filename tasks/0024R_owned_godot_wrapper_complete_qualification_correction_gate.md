# Task 0024R — Correct and completely qualify the owned Godot headless-test wrapper

- Status: `READY`
- Gate: `HARNESS CORRECTION / COMPLETE WRAPPER QUALIFICATION ONLY / ZERO FINAL MATRIX`
- Repository/root/branch: `zcx369658780/delayed-self-godot` / `D:\Delayed_Self` / `main`
- Required GPT adjudication checkpoint: `e18919da11ebf37829b43ca53503f4f3d1a8bc58`
- Closed predecessor: Task `0024`
- Provisional implementation baseline: `fdaf2b81fc71c60e4b3548422be94953146f25f4`
- Corrected blocked state: `6a81d6ad2002da6e8a0c0abf63d580ba882e3818`
- Recommended Codex model: `GPT-5.6 Sol`, reasoning `High`; `Max` is acceptable but not required

## 1. Objective

Repair and completely qualify `tests/tools/run_owned_godot_headless.ps1` against every lifecycle requirement that Task 0024 left unproven.

This is a harness-only correction gate. It must not run the core-mechanics final matrix, must not claim the schema-v2 foundation is accepted, and must not modify schema, Simulation, solver, formal regressions, UID contents or product data.

A later separately authorized task will run one fresh complete final validation only after GPT accepts this qualification gate.

## 2. Binding retained facts

Retain, but do not elevate beyond their current provisional status:

- 79 continuation inputs were preserved;
- 66 UID sidecars were reviewed as valid unique pairs;
- the narrow Task 0012 eight-level correction was committed;
- focused core-mechanics tests reportedly passed;
- formal catalog and eight formal level JSON hashes remained unchanged;
- Task 0024's final-matrix attempt was consumed and is historical non-acceptance evidence only.

Do not rerun, imitate or represent the Task 0024 final matrix in this gate.

## 3. Startup

Before editing or executing:

1. require root `D:\Delayed_Self`, branch `main`, expected origin and no Git operation in progress;
2. fetch and fast-forward only;
3. require `HEAD == origin/main` and ancestry of `e18919da11ebf37829b43ca53503f4f3d1a8bc58`;
4. require a clean worktree and zero staged paths;
5. inspect the complete pre-existing Godot process set once;
6. require zero Godot processes before qualification; any pre-existing process is external and blocks this task unless it exits naturally before execution;
7. do not close an external process in this task.

No production Profile, ordinary user data, test-profile root, main scene, export or build access is authorized.

## 4. Wrapper correction contract

Correct only `tests/tools/run_owned_godot_headless.ps1` as necessary to satisfy all of the following.

### 4.1 Direct ownership

The wrapper must launch with `System.Diagnostics.ProcessStartInfo`, `FileName`, separate `ArgumentList`, `UseShellExecute=false`, explicit stdout/stderr redirection and no shell-flattened command.

Record the direct process's exact PID, creation/start timestamp, normalized executable identity and exact argument vector in process-local evidence.

### 4.2 Descendant admission

A descendant may enter the owned cleanup set only when all are proven:

1. its full parent chain reaches the recorded direct PID;
2. its start/creation time is not earlier than the owning invocation;
3. its executable identity is consistent with the expected Godot executable or with an explicitly declared qualification helper identity for that exact case;
4. its command-line facts are consistent with the exact project root and qualification/test identity for the owning invocation;
5. no editor, project-manager, interactive main-scene, export/build, other-project or unrelated-helper indicator exists.

Ancestry alone is insufficient. Executable-name equality alone is insufficient.

A descendant that fails any identity check must be classified as unproven, excluded from cleanup, and must never be closed by the wrapper. Qualification helpers used to prove exclusion must self-exit within a bounded interval so the task ends process-clean.

### 4.3 Bounded deterministic ownership records

- Ownership records must be deterministic and bounded.
- Record only direct PID plus descendants discovered from the recorded root.
- Preserve stable fields sufficient to prove ancestry depth and identity classification.
- Close proven descendants deepest-first and the direct process last.
- Never order cleanup merely by PID value.
- Never use process-name-wide, wildcard or unrelated PID cleanup.

### 4.4 Exactly-once cleanup

`finally` must execute exactly once per invocation after pass, nonzero exit, timeout, marker failure, stderr-policy failure or caller-side exception.

The wrapper must emit a bounded cleanup invocation count and prove it equals one. Cleanup may close only the direct owned PID and admitted descendants still alive. It must wait again and prove the owned set empty.

### 4.5 Independent result classifications

Preserve the original native test outcome independently from cleanup outcome. At minimum classify distinctly:

- `PASS`
- `NONZERO_EXIT`
- `TIMEOUT`
- `STDERR_POLICY_FAILURE`
- `MARKER_FAILURE`
- `UNPROVEN_DESCENDANT`
- `CLEANUP_FAILURE`
- wrapper/start failure

Add an explicit bounded stderr policy input. A deliberate exit-0, marker-valid test that writes stderr must independently produce `STDERR_POLICY_FAILURE` when nonempty stderr is forbidden. It must not be misclassified as nonzero exit, timeout or marker failure.

Cleanup failure has precedence for harness safety but must not erase the underlying native/marker/stderr facts.

## 5. Complete qualification suite

Qualification may be rerun while repairing the wrapper. It is not the final core-mechanics validation.

Materialize focused qualification artifacts only under the authorized paths in Section 8. Prove all of the following in fresh wrapper invocations:

1. **normal exit** — exit 0, required marker present, stderr policy passes, zero owned residue;
2. **nonzero exit** — deliberate native exit 7 is preserved as `NONZERO_EXIT`, cleanup exactly once, zero residue;
3. **timeout** — a still-running direct Godot process is closed by exact owned PID, classified `TIMEOUT`, cleanup exactly once, zero residue;
4. **stderr policy** — exit 0 plus valid marker plus deliberate stderr is classified only as `STDERR_POLICY_FAILURE` under forbid-nonempty policy;
5. **marker policy** — exit 0 and stderr policy pass but missing marker is `MARKER_FAILURE`;
6. **owned descendant** — a controlled qualification invocation creates at least one descendant whose ancestry, executable and command identity satisfy the declared case; the wrapper records it deterministically and closes it deepest-first if still alive;
7. **unproven descendant exclusion** — a controlled descendant with proven ancestry but inconsistent executable or command identity is excluded from the owned cleanup set and is not closed by the wrapper; it self-exits within the case bound;
8. **exactly-once cleanup** — every case reports exactly one cleanup entry, including cases that require no closure;
9. **bounded deterministic records** — repeated qualification of the record-producing case yields the same classification/schema/order semantics, excluding naturally varying PID/timestamp values;
10. **static safety** — no process-name-wide termination, wildcard termination, shell-flattened Godot invocation, or unrelated process cleanup path exists;
11. **global isolation** — every qualification ends with zero Godot processes and touches no unrelated process.

The qualification driver must fail closed when any expected classification, ownership record, cleanup count or zero-process invariant differs.

## 6. Explicitly forbidden execution

Do not execute any complete core-mechanics matrix in this task.

Do not invoke or emit the historical final marker `TASK_0023ZX_COMPLETE_MATRIX_PASS` as a new result. Do not run a substitute aggregate that effectively replays that matrix.

Focused lifecycle qualification only is authorized.

## 7. Frozen implementation surfaces

Do not modify:

```text
docs/game_design/GAMEPLAY_SIMULATION_CONTRACT_V2_CURRENT.md
docs/level_design/LEVEL_SCHEMA_V2_CURRENT.md
docs/level_design/reference/turn_transition_vectors_v2.json
schemas/level_v2.schema.json
scripts/simulation/level_loader.gd
scripts/simulation/simulation.gd
scripts/solver/bfs_solver.gd
tests/simulation/**
tests/levels/task_0012_staggered_doors_validation.gd
docs/engineering/GODOT_UID_SIDECAR_BASELINE_CURRENT.md
**/*.uid
data/catalog/**
data/levels/**
scenes/**
scripts/gameplay/**
scripts/app/**
project.godot
schemas/level_v1.schema.json
docs/level_design/reference/turn_transition_vectors_v1.json
tests/run_all.gd
assets/**
```

No Profile, catalog, formal-level, final-flag, Gameplay/UI, localization, asset, font, audio, build, release or submission authority is granted.

## 8. Authorized repository paths

```text
tests/tools/run_owned_godot_headless.ps1
tests/tools/task_0024r_owned_godot_lifecycle_*.ps1
tests/tools/task_0024r_owned_godot_lifecycle_*.json
tests/tools/task_0024r_owned_godot_lifecycle_*.gd
docs/reports/0024R_OWNED_GODOT_WRAPPER_COMPLETE_QUALIFICATION_REPORT.md
docs/CODEX_ACTIVE_TASK_CURRENT.md
docs/CODEX_STARTUP_SNAPSHOT_CURRENT.md
docs/DEVELOPMENT_PLAN_CURRENT.md
docs/DOC_INDEX_CURRENT.md
docs/HANDOFF_MASTER_CURRENT.md
docs/project_memory.md
docs/project_memory/HEADLESS_GODOT_TEST_PROCESS_LIFECYCLE_FAILURE_AND_POLICY_CURRENT.md
```

No other path may change.

## 9. Stop conditions

Stop without running a final matrix on any:

- pre-existing external Godot process;
- inability to prove descendant executable/command consistency;
- wrapper cleanup touching or attempting to touch an unproven process;
- inability to obtain zero Godot processes after bounded owned cleanup;
- unrelated dirty path;
- frozen-path drift;
- Profile/user-data access;
- remote divergence;
- need to change core mechanics or formal product data.

Qualification assertion failures that can be repaired within the authorized wrapper/qualification paths are not terminal blockers; repair and rerun focused qualification until the wrapper either passes or reaches a stop condition above.

## 10. Output

On a complete pass, commit authorized paths only with:

```text
test: completely qualify owned Godot headless lifecycle wrapper
```

Push normally after exact changed-path, frozen-hash, process-isolation, diff and remote-drift audits.

The report must include the qualification case matrix, classifications, cleanup counts, owned/unproven descendant proofs, zero-process facts, static safety checks and explicit confirmation that no final core-mechanics matrix ran.

## 11. Terminal verdict

Return exactly one:

```text
OWNED_GODOT_WRAPPER_COMPLETE_QUALIFICATION_READY_FOR_GPT_REVIEW
BLOCKED_OWNED_GODOT_WRAPPER_QUALIFICATION
PROTECTED_DATA_BOUNDARY_BREACH
```

A pass establishes only the wrapper qualification. It does not accept the provisional schema-v2 foundation and does not authorize or execute the later final matrix.

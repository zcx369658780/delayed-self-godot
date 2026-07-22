# Task 0024S — Correct Windows project-path identity and complete owned-wrapper qualification

- Status: `READY`
- Gate: `HARNESS CORRECTION / WINDOWS PATH IDENTITY + COMPLETE WRAPPER QUALIFICATION / ZERO FINAL MATRIX`
- Repository/root/branch: `zcx369658780/delayed-self-godot` / `D:\Delayed_Self` / `main`
- Required GPT adjudication checkpoint: `5e1aa37c303ebb0185e4e0cc145fcf768de09c5c`
- Closed predecessors: Tasks `0024`, `0024R`
- Provisional foundation implementation: `fdaf2b81fc71c60e4b3548422be94953146f25f4`
- Recommended Codex model: `GPT-5.6 Sol`, reasoning `High`; use `Max` only if available without disrupting the session

## 1. Objective

Preserve the blocked local Task 0024R continuation, correct the wrapper's Windows project-path identity comparison, and complete the full owned Godot wrapper qualification suite.

This is qualification-only. Do not run any core-mechanics final matrix and do not modify schema v2, Simulation, solver, UID sidecars, Task 0012, formal data, Profile or product surfaces.

A later separately authorized task will run one fresh complete core-mechanics validation after GPT accepts this gate.

## 2. Binding blocker facts

The Task 0024R owned-descendant case produced:

- expected top-level classification: `TIMEOUT`;
- actual top-level classification: `UNPROVEN_DESCENDANT`;
- underlying classification: `TIMEOUT`;
- descendant reason: `UNPROVEN_PROJECT_IDENTITY`;
- observed project path form: `D:/Delayed_Self`;
- expected normalized form equivalent to: `d:\delayed_self`.

The wrapper correctly did not close the unproven descendant. It closed only its direct owned PID. The descendant later exited naturally. Current reported Godot process count is zero.

This task corrects path identity only through canonical path comparison; it must not weaken executable, ancestry, start-time, command/test identity or forbidden-mode requirements.

## 3. Preserve the local continuation before synchronization

Before fetch, merge, edit, process action or test execution:

1. require root `D:\Delayed_Self`, branch `main`, expected origin and no Git operation in progress;
2. inventory every staged, modified, deleted and untracked path;
3. require zero staged and deleted paths;
4. require the dirty set to be exactly the current Task 0024R continuation:

```text
tests/tools/run_owned_godot_headless.ps1
tests/tools/task_0024r_owned_godot_lifecycle_missing_marker.gd
tests/tools/task_0024r_owned_godot_lifecycle_nonzero.gd
tests/tools/task_0024r_owned_godot_lifecycle_normal.gd
tests/tools/task_0024r_owned_godot_lifecycle_owned_child.gd
tests/tools/task_0024r_owned_godot_lifecycle_owned_parent.gd
tests/tools/task_0024r_owned_godot_lifecycle_qualification.ps1
tests/tools/task_0024r_owned_godot_lifecycle_stderr.gd
tests/tools/task_0024r_owned_godot_lifecycle_timeout.gd
tests/tools/task_0024r_owned_godot_lifecycle_unproven_helper.ps1
tests/tools/task_0024r_owned_godot_lifecycle_unproven_parent.gd
```

5. record path, tracked state, SHA-256, byte length and line count for all eleven paths;
6. copy them byte-identically to:

```text
D:\Delayed_Self_Evidence\0024S_windows_path_identity_and_wrapper_qualification\continuation_inputs\
```

7. verify all copied identities;
8. stop on any unrelated path or mismatch;
9. after preservation, restore/reconcile only the exact CURRENT/report paths necessary for ff-only synchronization;
10. fetch and fast-forward only; prohibit broad reset, clean and unreviewed stash;
11. require ancestry of `5e1aa37c303ebb0185e4e0cc145fcf768de09c5c` and zero remote divergence before continuing;
12. reapply the preserved eleven-path continuation exactly before edits.

Do not overwrite or delete the new external evidence set.

## 4. Startup process isolation

Inspect the complete pre-existing Godot process set once after repository reconciliation and before qualification.

Require zero Godot processes. Any pre-existing process is external. Do not close any external process in this task. If a pre-existing process exists and does not naturally exit before execution, stop.

## 5. Canonical Windows project-path identity

Correct only the wrapper and focused qualification artifacts as needed.

### 5.1 Parse exact path arguments

Do not determine project identity by raw substring search over the complete command line.

Extract the exact argument value associated with the Godot project-path option. Support only the explicitly accepted Godot forms used by this repository:

```text
--path <value>
--path=<value>
```

Reject missing, duplicated, malformed or ambiguous project-path arguments.

### 5.2 Canonicalize paths

Compare the expected project root and parsed observed project-path argument using canonical Windows path semantics:

1. strip only syntactic argument quoting;
2. normalize `/` and `\` as Windows directory separators;
3. resolve to an absolute path using a bounded filesystem/path API such as `[System.IO.Path]::GetFullPath`;
4. normalize redundant `.` segments;
5. trim trailing directory separators except for a drive root;
6. compare with `StringComparison.OrdinalIgnoreCase`;
7. retain a bounded normalized comparison value in process-local evidence without writing local absolute paths into Git reports.

Do not lowercase or globally rewrite the complete command line. Do not accept substring, prefix or suffix equivalence.

Required equivalence examples:

```text
D:\Delayed_Self
D:/Delayed_Self
d:\delayed_self
D:\Delayed_Self\
```

Required non-equivalence examples:

```text
D:\Delayed_Self_Other
D:\Delayed_Self\subproject
D:\Other\Delayed_Self
D:\Delayed_Self_backup
```

### 5.3 Retain all other identity gates

A descendant may be admitted only when all remain proven:

- full ancestry reaches the direct owned PID;
- creation time is not earlier than invocation start;
- executable identity is consistent with the expected Godot/helper identity;
- canonical project root matches exactly;
- qualification/test script identity matches the owning case;
- no editor, project-manager, interactive main-scene, export/build or other-project indicator exists.

Ancestry alone and executable-name equality alone remain insufficient.

## 6. Qualification continuation

Qualification assertion failures repairable within authorized wrapper/qualification paths are not terminal blockers. Repair and rerun focused qualification until all cases pass or a true stop condition occurs.

Prove all Task 0024R requirements, including:

1. normal exit;
2. deliberate nonzero exit preserving native exit 7;
3. timeout with exact owned cleanup;
4. independent `STDERR_POLICY_FAILURE`;
5. independent `MARKER_FAILURE`;
6. owned descendant admitted through ancestry + executable + canonical path + test identity;
7. unproven descendant excluded and never closed;
8. cleanup count exactly one per invocation;
9. deterministic bounded ownership record semantics;
10. deepest-first descendant cleanup and direct process last;
11. static absence of process-name-wide, wildcard or shell-flattened cleanup/invocation;
12. zero Godot processes after every qualification case.

Add focused path-identity qualification cases for:

- forward-slash versus backslash equivalence;
- case-insensitive equivalence;
- trailing-separator equivalence;
- deceptive prefix/suffix non-equivalence;
- missing/duplicate project-path argument rejection.

An expected unproven-descendant helper must self-exit within the case's bounded interval. The qualification driver must wait for that expected self-exit before beginning the next invocation and prove the global Godot process count is zero.

If a repairable case creates an expected self-exiting unproven helper, its temporary existence is not a pre-existing external-process blocker for that same case. A subsequent case may begin only after it has exited and zero-process isolation is re-established.

## 7. Explicitly forbidden work

Do not:

- run or imitate the core-mechanics final matrix;
- emit `TASK_0023ZX_COMPLETE_MATRIX_PASS` as new evidence;
- modify schema v2, loader, Simulation, solver or core-mechanics fixtures/tests;
- modify Task 0012 or UID files/baseline;
- modify catalog, formal levels, final flags, Profile, Gameplay/UI, project settings, assets, fonts, audio or localization;
- access production Profile content/metadata/siblings, ordinary user data or the test-profile root.

## 8. Authorized paths

```text
tests/tools/run_owned_godot_headless.ps1
tests/tools/task_0024r_owned_godot_lifecycle_*.ps1
tests/tools/task_0024r_owned_godot_lifecycle_*.json
tests/tools/task_0024r_owned_godot_lifecycle_*.gd
tests/tools/task_0024s_windows_path_identity_*.ps1
tests/tools/task_0024s_windows_path_identity_*.json
tests/tools/task_0024s_windows_path_identity_*.gd
docs/reports/0024S_WINDOWS_PATH_IDENTITY_AND_WRAPPER_QUALIFICATION_REPORT.md
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

Stop on:

- unrelated dirty path or preservation mismatch;
- pre-existing external Godot process that does not naturally exit;
- wrapper attempting to close an unproven process;
- inability to restore zero Godot processes after bounded owned cleanup and expected helper self-exit;
- inability to parse or canonicalize path arguments without weakening identity;
- frozen-path drift;
- Profile/user-data access;
- remote divergence;
- need to modify core mechanics or formal product data.

Ordinary qualification assertion failures within authorized paths remain repairable and are not terminal until one of the stop conditions above is reached.

## 10. Output

On a complete pass, commit authorized paths only with:

```text
test: qualify Windows path identity for owned Godot wrapper
```

Push normally after exact changed-path, frozen-hash, process-isolation, diff and remote-drift audits.

The report must include:

- eleven-path continuation preservation proof;
- exact path canonicalization doctrine;
- equivalence/non-equivalence qualification results;
- full wrapper case matrix;
- owned and unproven descendant evidence;
- cleanup count/order facts;
- zero-process facts;
- static safety checks;
- explicit confirmation that no final core-mechanics matrix ran.

## 11. Terminal verdict

Return exactly one:

```text
WINDOWS_PATH_IDENTITY_AND_OWNED_WRAPPER_QUALIFICATION_READY_FOR_GPT_REVIEW
BLOCKED_WINDOWS_PATH_IDENTITY_OR_WRAPPER_QUALIFICATION
PROTECTED_DATA_BOUNDARY_BREACH
```

A pass establishes only wrapper qualification. It does not accept the provisional schema-v2 foundation and does not authorize the later final matrix.

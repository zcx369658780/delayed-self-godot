# Task 0023ZR — Repair isolated-sandbox runner argument binding and retry the production-policy matrix

- Status: `READY`
- Gate: `PROTECTED PLAYER DATA / RUNNER ARGUMENT BINDING REPAIR + ISOLATED MATRIX RETRY`
- Repository/root/branch: `zcx369658780/delayed-self-godot` / `D:\Delayed_Self` / `main`
- GPT prerequisite adjudication: `docs/reports/0023ZQ_GPT_RUNNER_ARGUMENT_BINDING_BLOCKER_ADJUDICATION.md`
- Required checkpoint: `05d10e5d24d110e072587b05f141532b389b0d49`
- Accepted implementation under test: `afe8c6fffdc98992b732fce46f206ad0dc8553a1`
- Real production Profile authority: **none**
- Test-root authority: **none**
- Authorized runtime data: only exact Task 0023ZQ external APPDATA sandboxes defined below

## 1. Objective

Continue the uncommitted Task 0023ZQ harness work without resuming the closed task directly:

1. inherit exactly the five authorized untracked harness artifacts;
2. repair only the outer PowerShell Godot process argument binding so a Godot executable path containing spaces remains one executable filename;
3. prove the repaired launcher in a no-behavior invocation check;
4. rerun the full parser/static/zero-I/O pre-validation and no-guard proof;
5. execute the isolated production-policy matrix twice from separately absent attempt roots;
6. commit the harness only if both attempts pass completely and exact cleanup succeeds.

No product source repair is authorized. A behavior mismatch remains evidence for a later task.

## 2. Startup exception and authority checks

This continuation has one narrow exception to the usual clean-worktree rule.

After one normal fetch/fast-forward, require:

1. absolute root `D:\Delayed_Self`, branch `main`, expected origin and no Git operation in progress;
2. `HEAD == origin/main == 05d10e5d24d110e072587b05f141532b389b0d49` or a strict fast-forward descendant containing that checkpoint;
3. ancestry of `afe8c6fffdc98992b732fce46f206ad0dc8553a1`;
4. zero staged files and zero modified/deleted tracked files;
5. the only untracked repository paths are exactly:

```text
tests/app/task_0023zq_isolated_production_policy_case.gd
tests/app/task_0023zq_isolated_production_policy_parser_smoke.gd
tests/app/task_0023zq_isolated_production_policy_validator.gd
tests/app/task_0023zq_isolated_production_policy_manifest.json
tests/app/task_0023zq_capture_isolated_production_policy.ps1
```

6. no other dirty state;
7. zero residual Godot processes;
8. the external blocked audit exists at the exact authorized evidence path without opening any ordinary player-data location.

Before editing, record SHA-256, byte length and line count for all five untracked files in external evidence. These are continuation inputs, not accepted authorities.

Stop without edits if any authorized untracked file is missing, any extra untracked/staged/tracked change exists, the checkpoint is absent, or a Godot process remains.

## 3. Absolute protected-data boundary

All Task 0023ZQ protected-data rules remain in force.

Never open, read, parse, hash, compare, copy, rename, back up, delete, reset, repair, write, stat, refresh metadata for, or enumerate:

- the ordinary `user://delayed_self_profile.json`;
- its ordinary parent user-data directory or siblings;
- `user://delayed_self_test_profiles/`;
- any historical fixture;
- any ordinary production data location.

Do not record the ordinary user-data absolute path.

All behavior processes must use only process-local environment overrides:

```text
APPDATA=<exact attempt sandbox appdata root>
LOCALAPPDATA=<exact attempt sandbox localappdata root>
DELAYED_SELF_0023ZQ_EXECUTION_GUARD=TASK_0023ZQ_EXECUTE
DELAYED_SELF_0023ZQ_ATTEMPT=<attempt id>
```

Persistent environment mutation, registry edits, `setx`, shell-profile changes, symlinks, junctions, reparse redirects and project custom-user-dir changes are forbidden.

The case harness must attest the sandbox before every Profile/configuration/filesystem operation exactly as specified by Task 0023ZQ. Attestation failure must stop before behavior start.

## 4. Evidence root and retained blocked evidence

Use only:

```text
D:\Delayed_Self_Evidence\0023ZQ_isolated_production_policy_matrix\
```

Preserve byte-identically:

```text
blocked_attempt_1_invocation_audit.json
```

Require these retry-owned roots absent before execution:

```text
attempt_1\
attempt_2\
```

Do not overwrite or relabel the blocked audit as a behavior attempt. Do not enumerate or clean outside the exact evidence root.

## 5. Frozen implementation and authorized repository paths

Product source, scenes, project settings, catalog/formal data, UI/gameplay, historical tests/harnesses and all prior task files remain frozen.

Authorized harness paths are exactly the five inherited Task 0023ZQ files:

```text
tests/app/task_0023zq_isolated_production_policy_case.gd
tests/app/task_0023zq_isolated_production_policy_parser_smoke.gd
tests/app/task_0023zq_isolated_production_policy_validator.gd
tests/app/task_0023zq_isolated_production_policy_manifest.json
tests/app/task_0023zq_capture_isolated_production_policy.ps1
```

Authorized report/current documentation paths:

```text
docs/reports/0023ZR_ISOLATED_PRODUCTION_POLICY_RUNNER_REPAIR_AND_RETRY_REPORT.md
docs/CODEX_ACTIVE_TASK_CURRENT.md
docs/CODEX_STARTUP_SNAPSHOT_CURRENT.md
docs/DEVELOPMENT_PLAN_CURRENT.md
docs/DOC_INDEX_CURRENT.md
docs/HANDOFF_MASTER_CURRENT.md
docs/project_memory.md
docs/production/COMPLETE_FLOW_PRODUCTION_CLOSURE_PLAN_CURRENT.md
```

### 5.1 Narrow repair rule

The only intended executable change is in:

```text
tests/app/task_0023zq_capture_isolated_production_policy.ps1
```

The GDScript case/parser/validator and manifest must remain byte-identical to their startup untracked hashes unless a minimal parser/validator assertion is strictly necessary to prove the launcher repair. Any such secondary edit must be explicitly justified, must not change matrix cases, expected statuses, sandbox semantics, assertion cardinality or protected-data boundaries, and must be listed separately in the report.

No behavior expectation may be weakened.

## 6. Mandatory process-launch repair

Replace any flattened shell-command construction with one bounded process helper based on `System.Diagnostics.ProcessStartInfo`.

The helper must use semantics equivalent to:

```powershell
$psi = [System.Diagnostics.ProcessStartInfo]::new()
$psi.FileName = $GodotPath
$psi.UseShellExecute = $false
$psi.RedirectStandardOutput = $true
$psi.RedirectStandardError = $true
foreach ($argument in $GodotArguments) {
    [void]$psi.ArgumentList.Add([string]$argument)
}
```

Requirements:

1. the exact Godot executable path is assigned only to `FileName`;
2. every Godot argument is added as one separate `ArgumentList` entry;
3. stdout/stderr and native exit code are captured without invoking another shell;
4. environment overrides are added only to the child process environment;
5. the same helper is used for the no-behavior binding check and every behavior case process;
6. a Godot path containing spaces must be exercised;
7. no raw absolute Godot path is printed into repository documentation; external evidence may retain it only if already permitted by local tooling policy;
8. helper failure is fail-closed before attempt creation or sandbox behavior.

Forbidden:

```text
Invoke-Expression
cmd /c
powershell -Command <concatenated command>
Start-Process with a flattened ArgumentList string
& on a concatenated command string
manual quote concatenation around one shell command
persistent environment mutation
```

## 7. No-behavior invocation-binding qualification

Before any attempt root is created, use the repaired helper to launch a zero-I/O Godot target such as the existing 0023ZQ parser smoke.

This qualification must prove:

- the selected Godot executable path contains at least one space;
- the child process starts successfully;
- native exit is 0;
- stderr is empty;
- the exact parser marker appears once;
- no 0023ZQ behavior-start, sandbox-attested or case marker appears;
- `attempt_1` and `attempt_2` remain absent;
- zero Godot processes remain afterward.

Retain a bounded argument-cardinality audit showing each argument as a redacted index/type entry, not a flattened command line.

If this qualification fails, stop without a behavior retry and without a repository commit.

## 8. Requalification before behavior

After the launcher repair and binding qualification, rerun the complete Task 0023ZQ pre-validation matrix in fresh processes:

```text
0023ZQ parser smoke
0023ZQ static validator
0023ZP compile smoke
0023ZP static contract
0023R path policy
0023T codec compile + pure codec
0023V store configuration compile + pure configuration
0023X adapter compile + pure adapter
0023ZC parser + zero-I/O compile contract
0023ZF parser only
```

All 14 required processes/checks must pass with native expected exits, empty stderr, required markers once and zero residual Godot processes.

Then rerun the no-guard case harness proof:

- native exit 2;
- `TASK_0023ZQ_EXECUTION_GUARD_BLOCKED` exactly once;
- sandbox-attested marker zero;
- behavior-start marker zero;
- no attempt root or Profile artifact;
- stderr empty.

The validator must additionally prove that every Godot launch in the runner flows through the repaired `ProcessStartInfo.ArgumentList` helper and that forbidden flattened launch forms are absent.

## 9. Two complete isolated attempts

Only after Sections 7 and 8 pass may the canonical runner execute the matrix.

### Attempt 1

1. require exact `attempt_1` root absent;
2. create only its authorized owned structure;
3. run every manifest stage/case through the repaired helper;
4. require complete sandbox attestation before any Profile/configuration/filesystem operation;
5. require every expected marker/evidence file and no forbidden disclosure;
6. audit to `PASS_COMPLETE_MATRIX`;
7. complete exact owned cleanup of sandbox data while retaining evidence;
8. require zero residual Godot processes.

### Attempt 2

Run only after Attempt 1 is a complete pass and cleanup is exact. Repeat independently from absent `attempt_2`, and require another `PASS_COMPLETE_MATRIX`.

On the first assertion failure, non-native exit, stderr output, missing evidence, forbidden disclosure, sandbox escape, cleanup failure or unexpected file:

- retain bounded evidence;
- stop the current attempt;
- do not run a later attempt;
- do not modify product source or behavior expectations;
- clean only exact owned paths when safe;
- return the blocked retry verdict.

## 10. Post-pass validation

After two complete passes:

1. rerun parser smoke and the reinforced static validator;
2. rerun all 14 named zero-I/O pre-validation processes/checks;
3. verify the 0023ZP product implementation, `project.godot`, main scene, autoload state, historical harnesses, catalog/formal data and all frozen paths match startup hashes;
4. require `attempt_1` and `attempt_2` sandbox data trees cleaned with retained evidence only;
5. require the blocked invocation audit preserved;
6. require zero Godot processes;
7. require only authorized repository changes;
8. run `git diff --check` and staged diff audit before commit.

Do not run Task 0023W, historical fixtures, the 0023ZN matrix, aggregate, `tests/run_all.gd`, project main scene, export or build.

## 11. Stop conditions

Stop without commit on any:

- ordinary player-data or test-root access;
- sandbox attestation occurring after any Profile/filesystem/configuration call;
- non-process-local environment change;
- symlink/junction/reparse escape;
- product/project/historical harness change;
- launcher repair outside the bounded rule;
- behavior or evidence mismatch;
- weakened manifest/case/assertion contract;
- raw content/path/version/error disclosure;
- unauthorized deletion or cleanup;
- residual Godot process;
- remote divergence;
- unexpected dirty path.

A protected-data boundary breach requires immediate stop and no repository commit.

## 12. Repository output

On two complete passing attempts, create:

```text
docs/reports/0023ZR_ISOLATED_PRODUCTION_POLICY_RUNNER_REPAIR_AND_RETRY_REPORT.md
```

The report must include:

- startup hashes for all five inherited untracked files;
- exact runner repair diff and launcher API choice;
- no-behavior binding qualification;
- full 14/14 requalification and guard proof;
- manifest stage/case/assertion cardinalities;
- both attempt classifications and scenario outcomes;
- sandbox attestation and cleanup evidence;
- frozen path results;
- explicit zero-real-data statement;
- all non-claims.

Commit authorized paths only with:

```text
test: repair Delayed Self sandbox runner binding and validate matrix
```

Push normally after remote-drift, staged-path, diff-check, process and cleanup audits.

## 13. Terminal verdict and non-claims

Return exactly one:

```text
ISOLATED_PRODUCTION_POLICY_SANDBOX_MATRIX_RETRY_READY_FOR_GPT_REVIEW
BLOCKED_ISOLATED_PRODUCTION_POLICY_SANDBOX_MATRIX_RETRY
```

A passing result establishes only production-policy behavior inside two process-local external APPDATA sandboxes. It does not authorize or establish access to the existing production Profile, recovery or write against real player data, default activation, aggregate registration, Menu New/Continue/Reset, settings/localization, build/export, RC, release, upload or festival submission readiness.
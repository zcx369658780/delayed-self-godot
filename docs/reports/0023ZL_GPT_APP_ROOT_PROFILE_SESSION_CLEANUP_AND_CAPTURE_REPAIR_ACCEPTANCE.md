# Task 0023ZL GPT AppRoot Profile-session cleanup and capture-repair acceptance

- Reviewed implementation commit: `413727fc804355c00f0900d98e668e8e69b4876b`
- Verdict: `TASK_0023ZL_APP_ROOT_PROFILE_SESSION_CLEANUP_AND_CAPTURE_REPAIR_ACCEPTED`
- Scope accepted: non-self-referential cleanup invariant, portable SHA-256, fail-closed canonical Execute evidence finalization, validator reinforcement, and retargeting to Task 0023ZJ
- Full-matrix execution and configured product persistence: not accepted or authorized by this report

## 1. Accepted controlled continuation

Task 0023ZL correctly treated the inherited five-file worktree changes as post-fetch draft evidence rather than fabricating pre-fetch evidence. The local draft was captured before fast-forward, the intervening remote changes touched no canonical harness artifact, and the draft patch remained byte-identical after fast-forward.

The implementation commit changes only the five canonical harness artifacts, the Task 0023ZL report, and authorized current documentation. No product source, accepted prerequisite test, scene, project setting, formal data, asset, localization, export, release, or submission surface changed.

## 2. Accepted cleanup invariant repair

The behavior source no longer reads its own source text to prove that directory enumeration is absent.

The stable case remains:

```text
cleanup_no_test_root_enumeration
```

Its runtime condition now calls a bounded exact-owned-path helper that requires:

```text
fixture_dir == canonical target base directory
owned path count == 25
owned paths are unique
owned_paths[0] == canonical target
all remaining owned paths use the exact fixture directory
```

The cleanup stage still removes only the exact canonical target and the 24 known store-owned siblings, removes the exact fixture directory non-recursively, and proves final absence. The behavior source contains no test-root or fixture-directory enumeration API and no runtime self-source read.

Static validator checks, rather than self-referential runtime source inspection, are now authoritative for the no-enumeration contract.

## 3. Accepted portable SHA-256 repair

The capture runner no longer depends on `Get-FileHash`.

It implements direct stream-based SHA-256 using:

```text
System.IO.File.OpenRead
System.Security.Cryptography.SHA256.Create
ComputeHash
resource disposal in finally
lowercase 64-character hexadecimal output
```

Both final zero-I/O Qualifications verified the standard SHA-256 value of an empty file:

```text
e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855
```

## 4. Accepted Execute evidence finalization

After a Godot Execute process returns, the runner now finalizes evidence in fail-closed order:

```text
exit code
post-process snapshot
production metadata after
 test-root existence after
fixture exact state after
stage summary
initial classification
worktree patch
portable SHA-256
final classification
inventory written last
17-file presence assertion
```

Post-process capture steps use bounded failure sentinels including:

```text
POST_STATE_UNAVAILABLE
STAGE_SUMMARY_UNAVAILABLE
PATCH_CAPTURE_FAILED
HASH_UNAVAILABLE
```

A capture or hash failure forces final classification to:

```text
DIAGNOSTIC_CAPTURE_INCOMPLETE
```

A protected-state mismatch has higher priority and forces:

```text
PLAYER_DATA_SAFETY_FAULT
```

The final classification and inventory are written in `finally`, after the post-state, patch, and hash attempts. Inventory remains the last canonical file, followed by an exact 17-file presence assertion.

This acceptance is based on source validation and zero-I/O Qualification. Runner Execute was not called in Task 0023ZL.

## 5. Accepted Task 0023ZJ contract

All five canonical harness artifacts consistently target:

```text
future_task = 0023ZJ
fixture_id = task_0023zj_app_root_profile_session
canonical_profile_path = user://delayed_self_test_profiles/task_0023zj_app_root_profile_session/delayed_self_profile.json
execution_guard = --task-0023zj-fixture-execution
```

Behavior protocol markers use the `TASK_0023ZJ_` namespace. Parser, validator, and Qualification markers use the Task 0023ZL namespace. Closed Task 0023ZE and 0023ZH executable contracts are absent.

The deterministic manifest remains:

```text
schema version 1
18 ordered stages
41 unique stable case IDs
6 accepted failure stages
11 Qualification evidence files
17 Execute evidence files
7 forbidden disclosure categories
```

## 6. Accepted validation evidence

```text
Parser: TASK_0023ZL_FULL_MATRIX_PARSER_SMOKE_PASS
Validator: TASK_0023ZL_VALIDATOR_ASSERTIONS=313
Validator terminal: TASK_0023ZL_CLEANUP_CAPTURE_VALIDATOR_PASS
No-guard proof: exit 2
Guard marker count: 1
Behavior-start count: 0
Final zero-I/O Qualifications: 2
Each Qualification inventory: 11/11
Portable SHA-256 proof: pass in both Qualifications
Execute commands: 0
0023ZJ guard-passing commands: 0
Future-fixture commands: 0
Full behavior executions: 0
```

Mandatory frozen regressions passed:

```text
0023R: 123 assertions / 4 positive / 39 negative
0023T: compile marker + 34 assertions
0023V: compile marker + 28 assertions
0023W: compile marker + 68 assertions
0023X: compile marker + 31 assertions
0023ZC: parser marker + 17 assertions
0023ZF: parser marker only
```

Every final process exited with its required code, had empty stderr where required, printed each required marker exactly once, preserved protected state, and left no Godot process.

## 7. Protected data boundary

Production Profile content was not accessed. Its non-content metadata remained:

```text
exists = true
Length = 473
LastWriteTimeUtc = 2026-07-19T08:15:02.2089459Z
```

Test-root existence remained true without enumeration. No Task 0023ZJ fixture check or operation occurred. No configured AppRoot entered the tree.

## 8. Frozen authorities

Later work must preserve:

1. Tasks 0023R–0023W path, codec, store, recovery, rollback, reset, and cleanup contracts.
2. Task 0023X adapter and atomic runtime hydration behavior.
3. Task 0023ZC AppRoot configuration, boot ordering, persistence-before-commit ordering, public progress shape, bounded failure routing, and normal memory-only path.
4. Task 0023ZF diagnostic artifacts and narrow accepted result.
5. The five canonical full-matrix artifacts at implementation commit `413727fc804355c00f0900d98e668e8e69b4876b`.
6. Production Profile metadata protection and the no-test-root-enumeration boundary.
7. The eight-level catalog, formal hashes/metrics, Simulation, solver, schema, canonical state, Gameplay, finale, Help, Timeline, Level Select, and presentation boundaries.

## 9. Next gate authorized separately

A new Task 0023ZJ may execute the accepted canonical harness against exactly:

```text
task_0023zj_app_root_profile_session
```

using only the accepted runner's `Execute` mode.

That execution task must freeze all product and harness source, prove the no-guard exit-2 boundary, requalify the runner, require the exact fixture and all owned siblings absent before each attempt, and obtain two consecutive complete clean-fixture runs without intervening edits.

Every Execute attempt must retain the full canonical 17-file inventory even on nonpass. A passing attempt additionally requires all 18 stage begin/pass pairs in manifest order, `TASK_0023ZJ_ASSERTIONS=41`, exactly one final pass marker, exit 0, empty stderr, an empty valid-hash worktree patch, exact cleanup, unchanged production metadata/test-root existence, and zero residual Godot processes.

Any assertion failure, controlled abort, runtime failure, capture incompleteness, protected-state change, fixture residue, or frozen-source drift must stop without source repair and produce a docs-only classified blocker report.

Production Profile activation/default persistence, aggregate registration, menus/settings/localization, build/export, RC, release, upload, and festival submission remain closed.

## 10. Non-claims

This acceptance does not establish that the full matrix passes, that all configured-session behavior is defect-free, that production persistence is enabled, or that aggregate, build/export, RC, release, upload, or festival submission is ready.

```text
TASK_0023ZL_APP_ROOT_PROFILE_SESSION_CLEANUP_AND_CAPTURE_REPAIR_ACCEPTED
```

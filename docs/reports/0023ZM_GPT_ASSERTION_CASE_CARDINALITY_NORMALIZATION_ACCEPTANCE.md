# Task 0023ZM GPT assertion/case-cardinality normalization acceptance

- Reviewed implementation commit: `d11e52d2fbdd5b9878182730673cca5d570aad87`
- Verdict: `TASK_0023ZM_ASSERTION_CASE_CARDINALITY_NORMALIZATION_ACCEPTED`
- Accepted scope: unique case-ID normalization, manifest schema/cardinality normalization, non-counting runtime count guard, one-to-one validator reinforcement, and inert retargeting to Task 0023ZN
- Full-matrix execution and production persistence: not accepted by this report

## 1. Accepted normalization

Task 0023ZJ established one complete `PASS_CANDIDATE` behavior run with 18 passed stages and 42 successful runtime assertion invocations. Its task-level acceptance failed only because the manifest listed 41 unique case IDs while `single_active_screen_router` labeled two distinct checks.

Task 0023ZM preserves both checks and changes only the fresh-reload case ID to:

```text
fresh_reload_single_active_screen
```

`single_active_screen_router` remains assigned only to the full router-contract assertion. The assertion conditions and bounded labels remain semantically unchanged.

## 2. Accepted manifest and runtime cardinality

The canonical manifest now freezes:

```text
schema_version = 2
stage count = 18
case count = 42
unique case count = 42
expected_assertion_count = 42
failure stages = 6
Qualification evidence files = 11
Execute evidence files = 17
forbidden disclosure categories = 7
```

The behavior defines a typed `EXPECTED_ASSERTION_COUNT: int = 42`. After all 18 stages pass and before the assertion-count/final-success markers, it verifies the runtime count without calling `_expect_case` or incrementing the counter. A mismatch aborts without printing the final pass marker.

A successful future run must print exactly:

```text
TASK_0023ZN_ASSERTIONS=42
TASK_0023ZN_APP_ROOT_PROFILE_SESSION_FULL_MATRIX_PASS
```

## 3. Accepted one-to-one validation

The strengthened validator proves:

1. schema version 2 and the exact manifest shape;
2. 18 ordered stages;
3. 42 unique case IDs and expected assertion count 42;
4. `fresh_reload_single_active_screen` belongs to the fresh-reload screen assertion;
5. `single_active_screen_router` belongs only to the router-contract assertion;
6. every manifest case maps one-to-one to exactly one direct or delegated runtime assertion invocation;
7. the behavior count guard is non-counting and ordered after all stage runners but before final markers;
8. all prior ordering, persistence, failure, recovery, cleanup, disclosure, portable SHA-256, fail-closed evidence-finalization, and frozen-hash contracts remain enforced.

Accepted validator evidence:

```text
TASK_0023ZM_VALIDATOR_ASSERTIONS=328
TASK_0023ZM_CASE_CARDINALITY_VALIDATOR_PASS
exit = 0
stderr = empty
```

## 4. Accepted future Task 0023ZN contract

All five canonical harness artifacts consistently target:

```text
future_task = 0023ZN
fixture_id = task_0023zn_app_root_profile_session
canonical_profile_path = user://delayed_self_test_profiles/task_0023zn_app_root_profile_session/delayed_self_profile.json
execution_guard = --task-0023zn-fixture-execution
```

Behavior protocol markers use `TASK_0023ZN_`. Parser, validator, and Qualification markers use the Task 0023ZM namespace. Closed 0023ZE, 0023ZH, and 0023ZJ executable fixture/guard/protocol contracts are absent.

## 5. Accepted zero-I/O validation

```text
Draft parser: pass
Final fresh-process parser: pass
Parser corrections: 0
Validator: 328 assertions, pass
No-guard proof: exit 2
Guard marker: exactly once
Behavior-start marker: zero
Final zero-I/O Qualifications: two
Each Qualification inventory: 11/11
Portable SHA-256 proof: pass
Runner Execute commands: zero
0023ZN guard-passing commands: zero
Future-fixture commands: zero
Full behavior executions: zero
```

Mandatory pre/post frozen regressions passed for Tasks 0023R, 0023T, 0023V, 0023W, 0023X, 0023ZC, and the Task 0023ZF parser.

## 6. Protected-data boundary

Production Profile content was not accessed. Its non-content metadata remained:

```text
exists = true
Length = 473
LastWriteTimeUtc = 2026-07-19T08:15:02.2089459Z
```

Test-root existence remained unchanged without enumeration. No Task 0023ZN fixture check or operation occurred. No configured AppRoot entered the tree and no Godot process remained.

## 7. Frozen authorities and next gate

Future work must preserve all accepted product, prerequisite, diagnostic, and canonical harness contracts. The five canonical full-matrix artifacts at commit `d11e52d2fbdd5b9878182730673cca5d570aad87` are the accepted Task 0023ZN execution authority.

A separately authorized Task 0023ZN may execute only those artifacts against exactly `task_0023zn_app_root_profile_session`. It must obtain two consecutive complete clean-fixture passes without intervening edits. Every attempt must retain all 17 canonical evidence files, and every passing attempt must show 18 ordered stage begin/pass pairs, 42 assertions, one final success marker, exit 0, empty stderr, exact cleanup, unchanged protected state, an empty valid-hash worktree patch, and zero residual Godot processes.

Any nonpass must stop without source repair or rerun and produce a docs-only classified blocker report.

## 8. Non-claims

This acceptance does not establish two consecutive full-matrix passes, enable production Profile persistence, register aggregate coverage, implement menus/settings/localization, establish build/export/RC readiness, or authorize release, upload, or festival submission.

```text
TASK_0023ZM_ASSERTION_CASE_CARDINALITY_NORMALIZATION_ACCEPTED
```

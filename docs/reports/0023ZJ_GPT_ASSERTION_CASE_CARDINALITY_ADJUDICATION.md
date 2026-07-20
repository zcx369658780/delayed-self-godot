# Task 0023ZJ GPT assertion/case-cardinality adjudication

- Reviewed execution commit: `891617deee826c0341de053bbc6db3e1cd5f85ca`
- Reported verdict: `BLOCKED_APP_ROOT_PROFILE_SESSION_EXECUTION_CLASSIFIED`
- Runner classification: `PASS_CANDIDATE`
- Task classification: `UNCLASSIFIED_NONPASS`
- GPT adjudication: `TASK_0023ZJ_BEHAVIOR_PASS_CANDIDATE_BLOCKED_BY_DUPLICATE_CASE_ID_CARDINALITY_MISMATCH`
- Product-source defect established: no
- Two-attempt full-matrix acceptance established: no

## 1. Accepted Attempt-1 evidence

Task 0023ZJ executed the frozen finalized harness exactly once. The retained evidence establishes:

```text
18 stage-begin markers in manifest order
18 stage-pass markers in manifest order
assert-fail markers = 0
abort markers = 0
final pass marker = 1
runner classification = PASS_CANDIDATE
runner inventory = 17/17
exit = 0
stderr = empty
worktree patch = empty with valid SHA-256
exact fixture cleanup = passed
production metadata/test-root existence = unchanged
Godot process before/after = 0 / 0
frozen hashes = unchanged
```

The behavior process therefore completed every configured-session stage exercised by the harness. Attempt 2 was correctly not run because the task acceptance text required `TASK_0023ZJ_ASSERTIONS=41`, while the behavior emitted `TASK_0023ZJ_ASSERTIONS=42`.

## 2. Deterministic cardinality root cause

The manifest contains 41 unique stable case IDs. However, the behavior source invokes `_expect_case` 42 times because the case ID:

```text
single_active_screen_router
```

is used for two distinct assertions:

1. `fresh_reload` checks that the reloaded AppRoot has exactly one active screen;
2. `router_contract` checks the complete Main Menu → Level Select → Gameplay → Level Select single-screen routing sequence.

These are semantically distinct checks but share one manifest case ID. As a result:

```text
unique manifest case IDs = 41
runtime assertion invocations = 42
```

The execution task incorrectly treated these two cardinalities as necessarily equal and hard-coded 41 as the runtime assertion count.

## 3. GPT finding

The sole Task 0023ZJ acceptance mismatch is sufficiently explained by:

```text
DUPLICATE_CASE_ID_CARDINALITY_MISMATCH
```

This does not establish an AppRoot, Profile store, adapter, MemoryProgress, Gameplay, router, persistence, recovery, rollback, or cleanup defect. On the contrary, Attempt 1 is valid positive evidence that all 18 stages and all 42 assertion invocations passed once.

It is still not a complete acceptance because the task required two consecutive clean-fixture passes and stopped before Attempt 2.

## 4. Required normalization

A new bounded Task 0023ZM may revise only the five canonical harness artifacts and authorized documentation. It must:

1. give the fresh-reload single-screen assertion its own stable case ID, `fresh_reload_single_active_screen`;
2. retain `single_active_screen_router` only for the full router-contract assertion;
3. update the manifest to 42 unique case IDs and record `expected_assertion_count = 42`;
4. make the behavior and validator enforce the manifest assertion count without adding another counted assertion;
5. strengthen the validator so every manifest case ID occurs exactly once in the behavior source;
6. retarget the future execution contract to a fresh Task 0023ZN fixture and guard;
7. prove parser, validator, no-guard exit-2 behavior, portable SHA-256 Qualification, frozen regressions, and zero fixture execution.

No product source change is authorized. Task 0023ZJ and its fixture remain closed and must not be reused.

## 5. Protected boundaries

Production Profile content remains unopened. Default production persistence, aggregate registration, menus/settings/localization, build/export, RC, release, upload, and festival submission remain closed.

```text
TASK_0023ZJ_BEHAVIOR_PASS_CANDIDATE_BLOCKED_BY_DUPLICATE_CASE_ID_CARDINALITY_MISMATCH
```

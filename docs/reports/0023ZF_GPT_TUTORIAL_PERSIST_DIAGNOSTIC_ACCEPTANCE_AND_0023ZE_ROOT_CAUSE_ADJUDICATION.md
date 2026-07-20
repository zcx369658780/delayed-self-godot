# Task 0023ZF GPT diagnostic acceptance and Task 0023ZE root-cause adjudication

- Reviewed diagnostic commit: `039cefff81ea95dc33b84824831ed2e72ac9a37c`
- Diagnostic verdict: `TASK_0023ZF_TUTORIAL_ZERO_PERSIST_DIAGNOSTIC_ACCEPTED`
- Earlier execution result: `BLOCKED_APP_ROOT_PROFILE_SESSION_EXECUTION_CLASSIFIED`
- Root-cause adjudication: `TASK_0023ZE_FAILED_ON_HARNESS_UNLOCKED_ORDER_EXPECTATION_MISMATCH`
- Product-source defect established: no
- Full-matrix success established: no

## 1. Accepted Task 0023ZF diagnostic boundary

Task 0023ZF added only its guarded minimal diagnostic, parser smoke, capture wrapper, report, and authorized current documentation. AppRoot and all accepted 0023R–0023ZD sources remained frozen.

The sole diagnostic execution used a fresh exact task-owned fixture and observed, both immediately and one additional process frame after the accepted three-action Tutorial-0 completion:

```text
route = LEVEL_SELECT
active_screen_count = 1
completed_count = 1
Tutorial 0 completed = true
Tutorial 0 best turns present = true
Tutorial 0 best turns = 3
Tutorial 1 unlocked = true
persist status = COMMITTED_AFTER_PERSISTED
target exists = true
load status = MISSING_CLEAN
boot status = TEST_PROFILE_READY
configured = true
```

The deterministic classification was:

```text
EXPECTED_CONTRACT_OBSERVED
```

Parser, no-guard proof, the single 17-file Execute capture, exact owned cleanup, protected metadata, frozen regressions, and final Git/process state are accepted within this narrow diagnostic scope.

## 2. Why the earlier compound failure is now classifiable

The Task 0023ZE full-matrix attempt reached `tutorial_0_persist`. Its first two assertions in that stage produced no failure marker:

1. route was Level Select, completed IDs equaled the single Tutorial-0 ID, and best turns equaled 3;
2. persist status began with `COMMITTED_AFTER_PERSISTED`.

The third assertion required:

```gdscript
completed == [TUTORIAL_0_ID]
and unlocked == [TUTORIAL_0_ID, TUTORIAL_1_ID]
and active_screen_count == 1
```

The accepted `DelayedSelfMemoryProgress.snapshot()` implementation constructs `unlocked_level_ids` and then calls `sort()` before returning it. The frozen IDs are:

```text
TUTORIAL_0_ID = tutorial_reach_exit
TUTORIAL_1_ID = tutorial_echo_bridge
```

Their deterministic lexical order is:

```text
tutorial_echo_bridge
tutorial_reach_exit
```

Therefore the harness expectation `[TUTORIAL_0_ID, TUTORIAL_1_ID]` is the reverse of the product's frozen sorted snapshot order. Once both levels are unlocked, that exact-array comparison is deterministically false.

Task 0023ZF independently observed screen count 1 and Tutorial-1 membership with all other persistence facts correct. This is consistent with the order mismatch and supplies no evidence of an AppRoot persistence defect.

The same unsorted exact expectation also appears in the full harness fresh-reload check and would fail later even if the first mismatch were bypassed.

## 3. GPT finding

The observed Task 0023ZE assertion failure is sufficiently explained by a test-harness contract defect:

```text
HARNESS_UNLOCKED_ORDER_EXPECTATION_MISMATCH
```

This adjudication does not claim that every later full-matrix stage will pass. It establishes only that the reported Tutorial-0 persisted-progress failure must be repaired in the harness, not in AppRoot, MemoryProgress, the adapter, the store, Gameplay, or formal data.

Do not weaken the semantic requirement. The revised harness must still require exactly the two expected unlocked IDs, but must compare them in the frozen deterministic sorted order or sort a local expected copy before exact comparison.

## 4. Closed scopes

Do not resume Task 0023ZE or reuse its fixture. Task 0023ZF is complete and accepted only as a diagnostic. Its fixture must not be reused.

Tasks 0023Y, 0023Z, 0023ZA, and 0023ZB remain historical closed scopes.

## 5. Required next gate

A new Task 0023ZG may revise only the accepted full-matrix harness artifacts and current documentation. It must:

1. preserve all product and accepted prerequisite source;
2. repair every exact Tutorial-0/Tutorial-1 unlocked-array expectation using deterministic sorted order;
3. add static validator coverage preventing the unsorted literal expectation from returning;
4. retarget the future execution contract from closed Task 0023ZE to a fresh Task 0023ZH fixture and execution guard;
5. update the manifest, runner, behavior markers, and validator consistently;
6. prove parser compilation, static validation, no-guard exit-2 behavior, and zero-I/O capture Qualification;
7. execute no fixture and no full matrix.

Actual full-matrix execution remains a later Task 0023ZH.

## 6. Protected boundaries

Production Profile content remains unopened and protected. Normal unconfigured AppRoot remains memory-only. Production activation/default persistence, aggregate registration, menus/settings/localization, build/export, RC, release, upload, and festival submission remain closed.

```text
TASK_0023ZF_TUTORIAL_ZERO_PERSIST_DIAGNOSTIC_ACCEPTED
TASK_0023ZE_FAILED_ON_HARNESS_UNLOCKED_ORDER_EXPECTATION_MISMATCH
```
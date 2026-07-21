# GPT adjudication — Tasks 0023ZX/0023ZY/0023ZZ headless-test process lifecycle root cause and closure

- Date: 2026-07-22
- Verdict: `TASKS_0023ZX_0023ZY_0023ZZ_CLOSED_ON_TEST_PROCESS_LIFECYCLE_CONTRACT_DEFECT`
- Product-defect conclusion: `NO_CORE_MECHANICS_DEFECT_ESTABLISHED`
- Successor: Task 0024

## Accepted evidence

The owner/Codex closeout evidence establishes:

- all 77 continuation inputs matched the existing external preservation set before the latest continuation;
- the latest continuation began with zero Godot processes;
- 66 `.uid` sidecars passed individual source-pair, uniqueness and validity review;
- the narrow Task 0012 correction passed its focused eight-level catalog/progression/final regression;
- focused 0023ZX mechanics tests passed;
- a later formal-level regression left one Godot process;
- Task 0023ZZ correctly stopped because it forbade a second reconciliation phase;
- no final complete validation, report commit or push occurred.

No evidence shows a change to the formal catalog, eight formal level JSON files, final flag, production Profile, Gameplay/UI, project settings, assets, fonts, audio, localization, build, export, release or submission surfaces.

## Root-cause adjudication

The repeated blocker came from the authorization design, not from failure to close an already-known process before work.

The contracts allowed one pre-test process-reconciliation phase, then allowed tests to start additional Godot processes, required zero residual processes afterward, and simultaneously prohibited cleanup after those later tests. This made successful closeout impossible whenever a test-owned process exited late or leaked.

The contracts also conflated two distinct actions:

- closing an unknown or pre-existing external process, which must remain separately ownership-gated;
- cleaning up the exact process and proven descendants created by the current test runner, which belongs in the runner's mandatory `finally` lifecycle.

Cleanup of a task-owned process after one authorized test execution is not a second test, a retry, or product repair.

## Closure

Tasks 0023ZX, 0023ZY and 0023ZZ are closed as execution authorities and must not be resumed directly. Their preserved work remains unaccepted continuation input.

Accepted historical facts from the chain are limited to:

- continuation preservation evidence;
- reviewed UID candidate evidence;
- focused stale-regression correction evidence;
- focused mechanics-test evidence;
- the identified process-lifecycle contract defect.

The chain does not establish acceptance of schema v2, Simulation, canonical state, restart/replay, BFS, UID baseline or final formal-level regression.

## Binding successor policy

Task 0024 must implement an ownership-aware headless Godot wrapper before relying on further validation. Every invocation must record its direct PID and exact arguments, derive only proven descendants, wait normally, and run exact owned-process cleanup in `finally` regardless of pass/fail/timeout. Unknown or pre-existing Godot processes remain untouched.

Task 0024 may perform one complete final core-mechanics validation after the wrapper and preserved implementation are ready. The validation itself may not be rerun after a substantive failure, but mandatory cleanup of its owned process set must still execute.
# Headless Godot test-process lifecycle failure and durable policy

- Status: `DURABLE PROJECT MEMORY / BINDING FOR FUTURE TEST TASKS`
- Date: 2026-07-22
- Root-cause chain: Tasks `0023ZX`, `0023ZY`, `0023ZZ`
- Product conclusion: no core-mechanics defect was established by these blockers

## 1. What failed

Tasks 0023ZX, 0023ZY and 0023ZZ repeatedly stopped on residual Godot processes even though the underlying authorized work progressed:

- 77 continuation inputs were externally preserved and SHA-256 verified;
- 66 generated `.uid` sidecars were individually reviewed as valid, unique and paired with eligible adjacent sources;
- the stale Task 0012 six-level catalog/progression/final assertions were narrowly corrected and passed focused regression;
- focused schema-v2/core-mechanics tests passed;
- formal catalog and eight formal level JSON files remained frozen.

The final 0023ZZ blocker occurred after startup already proved zero Godot processes. A later formal-level regression launched a Godot process and left one residual process. Therefore the recurring blocker was not a failure to clean pre-existing processes before work; it was a failure to manage the lifecycle of processes created by the task itself.

## 2. Root cause

The task contracts incorrectly combined four rules:

1. allow one process-reconciliation phase before testing;
2. allow later tests to launch fresh Godot processes;
3. require zero residual Godot processes at the end;
4. forbid any later process cleanup as a second remediation phase.

This is structurally contradictory. It treats cleanup of a task-owned test process as if it were a retry or an intervention against an unknown external process.

The production-Profile one-shot safety model was inappropriately reused for ordinary headless test-process lifecycle management. One-shot/no-retry is correct for protected-data behavior attempts, but it must not prohibit deterministic cleanup of processes that the test runner itself created and owns.

## 3. Binding distinction

Future tasks must distinguish:

### External or pre-existing process

A Godot process not created by the current runner is external. It may be inspected only within explicit authorization. It must never be closed unless executable identity, command line, repository root and test identity independently prove ownership. Ambiguous, editor, project-manager, manual or other-project processes remain untouched and block the task where zero-process isolation is required.

### Task-owned process

A process started by the current test runner is owned when the runner records its exact PID, launch timestamp, executable, arguments and repository/test identity. Descendants are owned only when their process ancestry is proven to originate from that recorded PID and their executable/command facts remain consistent with the same test invocation.

Closing a still-running owned process during the runner's `finally` phase is normal resource cleanup. It is not:

- a second test execution;
- a validation retry;
- a repair of product behavior;
- a second external-process reconciliation phase.

## 4. Mandatory future runner contract

Every future headless Godot test invocation must use one ownership-aware wrapper that:

1. starts Godot without a shell-flattened command line;
2. records the direct PID, start time, executable and exact arguments;
3. records owned descendants by proven ancestry rather than process name;
4. waits for normal exit under a bounded timeout and grace period;
5. captures native exit, stdout and stderr before classification;
6. always enters `finally`, whether the test passes, fails, times out or the parent workflow stops;
7. in `finally`, closes only the direct owned PID and proven owned descendants that remain alive;
8. waits again and proves the owned process set is empty;
9. never closes by executable name, wildcard, unbounded enumeration result or unrelated PID;
10. leaves unknown/pre-existing processes untouched;
11. reports lifecycle cleanup failure as a test/harness failure without rerunning the test.

A complete validation may still be authorized exactly once. Its owned-process `finally` cleanup remains mandatory after that one execution and does not consume a second validation attempt.

## 5. Acceptance doctrine

- A test assertion failure plus successful owned-process cleanup is a normal nonpass result, not a governance deadlock.
- An owned-process leak that the wrapper successfully closes is a lifecycle defect to report; it does not justify rerunning the test.
- Failure to close a proven owned process after bounded cleanup is a harness failure and stops the task.
- Presence of an ambiguous external process remains a safety blocker.
- Product, solver and formal-level conclusions must be based on test outputs, not on a separately classified cleanup defect.

## 6. Historical closure

Tasks 0023ZX, 0023ZY and 0023ZZ are closed and must not be resumed directly. Their preserved local work and external evidence are continuation inputs for Task 0024 only. Their process blockers do not establish a schema-v2, Simulation, replay, solver, UID or formal-level defect.

This policy supersedes the earlier pattern of permitting only a pre-test cleanup phase while forbidding cleanup of later task-owned processes.

## 7. Task 0024S Windows identity qualification

Task 0024S qualifies the wrapper's descendant identity and lifecycle policy without running a core-mechanics matrix. Windows command lines are parsed into argv rather than searched as raw text. Project admission accepts one exact `--path value` or `--path=value`, requires a fully-qualified canonical Windows path and uses exact `OrdinalIgnoreCase` equality after separator, redundant-segment and trailing-separator normalization. Exact descendant script identity, executable identity, ancestry, creation time, headless mode and forbidden-mode rejection remain independent gates.

Ten path cases and eight lifecycle cases pass. Cleanup count is one per case, owned descendants close deepest-first with direct last, unproven descendants never enter cleanup and self-exit within the qualification bound, repeated record semantics match, static broad-cleanup checks pass and every case ends with zero Godot processes. This is wrapper qualification only; a complete foundation validation remains separately gated.

## 8. Task 0024T sealed-driver pre-execution blocker

Task 0024T statically validated and sealed a four-case final package, but its exactly-once driver stopped before attempt creation and before the wrapper. The expression `Get-GodotCount -eq 0` was parsed as a command invocation with arguments rather than a comparison; integer zero was then Boolean false at the assertion boundary. Actual Godot counts before and after were zero.

Future static validators for PowerShell harnesses must reject bare command invocations inside comparison-like parenthesized argument expressions and require `(Get-FunctionResult) -eq value` or an assigned scalar followed by an explicit comparison. Under one-shot seal rules, a pre-attempt harness defect still consumes the driver-invocation budget when the contract says the driver itself may be invoked only once.

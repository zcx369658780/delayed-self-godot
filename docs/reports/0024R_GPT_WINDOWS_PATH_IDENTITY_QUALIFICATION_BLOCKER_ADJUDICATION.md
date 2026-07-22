# Task 0024R GPT Windows-path identity qualification blocker adjudication

- Verdict: `TASK_0024R_BLOCKED_ON_WINDOWS_PROJECT_PATH_IDENTITY_NORMALIZATION`
- Date: 2026-07-22
- Repository: `zcx369658780/delayed-self-godot`
- Closed task: `tasks/0024R_owned_godot_wrapper_complete_qualification_correction_gate.md`
- Last remote authority before this adjudication: `ab28069257eb3cc9b2433e466f1119cee932db5d`

## Accepted blocker facts

Task 0024R stopped during the owned-descendant qualification case. The expected top-level result was `TIMEOUT`; the actual result was `UNPROVEN_DESCENDANT` with underlying `TIMEOUT` and reason `UNPROVEN_PROJECT_IDENTITY`.

The descendant command line carried the project path as `D:/Delayed_Self`, while the wrapper compared it against a normalized expected value equivalent to `d:\delayed_self` using string-token matching. Forward-slash versus backslash form caused a false identity mismatch.

The wrapper correctly excluded the unproven descendant from cleanup and did not attempt to close it. It closed only the direct owned PID. The descendant later exited naturally. Current Godot process count is zero.

## Git and local continuation facts

No 0024R execution commit or report was pushed. Remote `main` remains at the 0024R startup authority. The local continuation is dirty only within the 0024R-authorized wrapper and qualification paths:

- one modified wrapper;
- ten untracked qualification artifacts;
- zero staged or deleted paths.

These local files are continuation inputs for the next correction gate and must be externally preserved byte-identically before fetch or reconciliation.

## Adjudication

The stop condition was genuinely reached because bounded owned cleanup could not produce a globally process-clean state immediately and a later diagnostic invocation would have started with a pre-existing process. Codex correctly stopped and did not close the unproven descendant.

No evidence establishes that the ownership model, cleanup boundary, core-mechanics implementation, UID baseline, Task 0012 correction, or formal product data is defective. The established defect is narrower: project identity must compare parsed path arguments by canonical Windows-path equivalence rather than raw or lowercased command-line substring/token equivalence.

## Binding correction doctrine

The next task must:

1. preserve the current eleven local continuation paths before synchronization;
2. parse the descendant command line for the exact project-path argument rather than searching the whole string for a raw token;
3. canonicalize expected and observed project paths using absolute-path resolution, separator normalization, trailing-separator normalization, and case-insensitive Windows path comparison;
4. reject deceptive prefixes/suffixes and unrelated roots;
5. retain independent executable, script/test identity, ancestry, start-time, and forbidden-mode checks;
6. complete all Task 0024R qualification cases without executing any core-mechanics final matrix.

Task 0024R is closed and must not be resumed directly. A fresh qualification-only correction task is required.

## Non-claims

This adjudication accepts no schema-v2 foundation, no final matrix, no formal rooms 9–12, and no catalog/Profile/UI/asset/localization/build/release authority.

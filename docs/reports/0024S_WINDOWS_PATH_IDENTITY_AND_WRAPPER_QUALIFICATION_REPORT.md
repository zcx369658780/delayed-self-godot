# Task 0024S Windows path identity and owned-wrapper qualification report

- Result: `WINDOWS_PATH_IDENTITY_AND_OWNED_WRAPPER_QUALIFICATION_READY_FOR_GPT_REVIEW`
- Gate: harness correction and focused qualification only
- Synchronized baseline: `69183b0e1ff79e689f8b51bdc65fad913e45d9e9`
- Required checkpoint `5e1aa37c303ebb0185e4e0cc145fcf768de09c5c`: ancestor confirmed
- Final focused summary SHA-256: `5A314353A47F4B839159F83B948300D63E48C2DFA63FEDE53ACCDF7F3F76D4EC`
- Core-mechanics final matrix: not run or imitated

## Continuation preservation and synchronization

The 0024S task file was not present at the initial local HEAD. A bootstrap fetch was therefore required to discover and read the new authorization. Before that fetch, root/branch/remote, the exact dirty inventory, zero staged paths, no Git operation and zero Godot processes had been recorded. The fetch updated only the `origin/main` remote-tracking ref and did not modify the index or working tree.

After reading the task and before ff-only merge, editing or test execution, the exact Task 0024R continuation still consisted of one modified wrapper and ten untracked qualification files, with zero staged or deleted paths. All eleven files were then copied byte-identically to the task-owned external evidence root under `0024S_windows_path_identity_and_wrapper_qualification/continuation_inputs/`.

The external manifest records tracked state, SHA-256, byte length and line count for every input. All source/copy identities matched. Manifest SHA-256: `8B847F510455CC875856EDEB401A9FC8E51249BE9BCFE805364015D798739590`.

The repository then fast-forwarded from `ab28069257eb3cc9b2433e466f1119cee932db5d` to `69183b0e1ff79e689f8b51bdc65fad913e45d9e9`. All eleven continuation hashes still matched the preserved manifest after synchronization. No broad reset, clean, restore or stash was used.

## Canonical Windows path identity

The wrapper now parses the Windows process command line into its actual argument vector with `CommandLineToArgvW`. Project identity accepts only one exact Godot project option in either form:

```text
--path <value>
--path=<value>
```

Missing, duplicated, empty and malformed values are rejected. The parser does not infer project identity from a raw command-line substring.

The parsed value is canonicalized by:

1. removing only syntactic argument quoting through Windows argv parsing;
2. treating `/` and `\` as Windows separators;
3. requiring a fully qualified path;
4. applying `System.IO.Path.GetFullPath` to normalize redundant segments;
5. trimming trailing separators except at a drive root;
6. comparing expected and observed canonical paths with `OrdinalIgnoreCase` exact equality.

No prefix, suffix or substring equivalence is accepted. The complete command line is not lowercased or globally rewritten. Bounded canonical comparison facts remain process-local; this report and the committed summary contain no observed machine-local absolute values.

The Godot descendant script identity is also parsed as one exact `--script` argument and compared to the exact declared case identity. Ancestry, creation time, executable identity, headless mode and forbidden editor/export/main-scene indicators remain independent admission gates.

## Path-identity qualification

The qualification driver extracts the canonicalizer and argv-parser functions directly from the wrapper AST, then executes those exact definitions.

| Case | Parse | Equivalent | Result |
|---|---:|---:|---|
| forward slash | valid | yes | pass |
| case-insensitive form | valid | yes | pass |
| trailing separator | valid | yes | pass |
| redundant `.` segment | valid | yes | pass |
| deceptive `_Other` suffix | valid | no | pass |
| nested subproject | valid | no | pass |
| deceptive `_backup` suffix | valid | no | pass |
| unrelated root | valid | no | pass |
| missing `--path` | rejected | no | pass |
| duplicate `--path` | rejected | no | pass |

## Complete focused wrapper qualification

| Case | Top-level classification | Native/underlying fact | Cleanup count | Owned/unproven records | Cleanup depths | Godot after |
|---|---|---|---:|---:|---|---:|
| normal exit | `PASS` | exit 0, marker/stderr pass | 1 | 1 / 0 | 0 | 0 |
| deliberate nonzero | `NONZERO_EXIT` | native exit 7 | 1 | 1 / 0 | 0 | 0 |
| timeout | `TIMEOUT` | direct PID timed out | 1 | 1 / 0 | 0 | 0 |
| stderr forbidden | `STDERR_POLICY_FAILURE` | exit 0 and marker valid | 1 | 1 / 0 | 0 | 0 |
| marker missing | `MARKER_FAILURE` | exit 0 and stderr pass | 1 | 1 / 0 | 0 | 0 |
| owned descendant, first | `TIMEOUT` | descendant admitted | 1 | 2 / 0 | 1, 0 | 0 |
| owned descendant, repeat | `TIMEOUT` | semantics equal | 1 | 2 / 0 | 1, 0 | 0 |
| unproven exclusion | `UNPROVEN_DESCENDANT` | underlying timeout | 1 | 1 / 2 | 0 | 0 |

The owned-descendant cases proved full ancestry to the direct PID, executable equality, canonical project-root equality, exact script identity and deepest-first cleanup. The descendant was closed before the direct process. The repeat produced identical classification/schema/order semantics after excluding PID and timestamp values.

The exclusion case observed the controlled PowerShell helper and its console descendant as unproven executable identities. Both records had `cleanup_eligible=false`; neither PID entered cleanup or the closed-PID set. They self-exited within the bounded interval before the driver continued, and the global Godot count remained zero.

Every wrapper invocation reported `cleanup_invocation_count=1`, including pass, native failure, timeout, stderr-policy failure, marker failure and unproven-descendant outcomes. Remaining owned PID sets were empty in every case.

## Static safety

All static checks passed:

- `ProcessStartInfo` with separate `ArgumentList` and `UseShellExecute=false`;
- explicit stdout/stderr redirection;
- no `Start-Process` Godot launch;
- no process-name-wide or wildcard termination;
- the sole termination form is exact `Stop-Process -Id` over an admitted record;
- no enumerated process-name pipeline into cleanup;
- exact project-option parsing and canonical path equality;
- no project-identity substring test.

Ownership records are capped at 64 descendants, output at 200 bounded lines, command-line evidence at 2,048 characters and input vectors/values at explicit bounds. Cleanup order uses depth and ancestry path, never PID magnitude.

## Repairable qualification history

Focused qualification was repaired and rerun as Task 0024S permits. Pre-Godot failures covered an over-specific static assertion and malformed test command-line quoting. Two early full-suite attempts reached the final unproven case but supplied five PowerShell array elements instead of the intended three, causing fixture-native exit 9; the array construction was corrected. A later path-only run exposed a missing Unicode P/Invoke declaration and was corrected before any Godot launch. None of these repairable attempts ran a core-mechanics matrix.

The final exact wrapper/driver revision completed all 10 path cases and all 8 lifecycle invocations with terminal marker:

```text
TASK_0024S_WINDOWS_PATH_AND_WRAPPER_QUALIFICATION_PASS
```

## Frozen and protected surfaces

No schema-v2 contract/schema, loader, Simulation, solver, core-mechanics test, Task 0012 fixture, UID sidecar, catalog, formal level, scene, Gameplay/AppRoot, project setting, asset, font, audio, localization, build/export, release or submission surface was modified. Production Profile, ordinary user data and the test-profile root were not accessed.

This pass establishes only the owned Godot wrapper qualification. It does not accept the provisional schema-v2 foundation and does not authorize the later one-shot final validation.

# Task 0011RV GPT baseline-blocker adjudication

- Status: `BLOCKED_PENDING_FOCUSED_DIAGNOSIS`
- Reported local/remote baseline: `2187d7a1aaf7af0518c0f770a6c76b280d013698`
- Reported worktree: clean
- Reported terminal verdict: `BLOCKED_BASELINE_REGRESSION`
- Reported symptom: required preflight returned exit code 1, mentioned `LEVEL_ID_MISMATCH`, and did not produce the seven required pass markers
- Adjudication date: 2026-07-16
- Adjudicated by: GPT Project Sources advisor

## Accepted stop behavior

Task 0011RV correctly required the owner review to stop before human interaction when the baseline preflight did not establish all seven accepted markers. No owner feedback was recorded and no repository file changed. This preserves the documentation-only human-review boundary.

## Important source finding

The literal `LEVEL_ID_MISMATCH` line is not, by itself, proof that the accepted catalog or formal levels regressed.

The aggregate repository suite deliberately exercises two negative paths:

1. catalog validation points a catalog entry at `docs/level_design/examples/level_v1_minimal_valid.json` and requires the returned code `CATALOG_LEVEL_ID_MISMATCH`;
2. reusable Gameplay is deliberately configured with `level_id=tutorial_echo_bridge` and `level_path=tutorial_reach_exit.json`, then requires `scene.load_error == "LEVEL_ID_MISMATCH"` and no partial runtime state.

The Gameplay script prints that expected error through `printerr(load_error)`. Therefore a healthy aggregate run may contain the text `LEVEL_ID_MISMATCH` on stderr while still passing the corresponding assertion and completing with all markers.

## Why the blocker remains open

The prior Codex report also states that the process exited 1 and the seven pass markers were absent. Those facts cannot be dismissed without the complete command, separated stdout/stderr, actual native process exit code, and all failing assertion/error lines.

Potential explanations include:

- a genuine assertion or parser/runtime failure elsewhere in the suite;
- a different Godot executable or command shape from the accepted Task 0011R run;
- wrapper logic treating expected negative-path stderr as failure;
- stale process/import state or environmental startup differences;
- incomplete/truncated output causing the wrong line to be treated as the root failure.

No implementation repair is authorized until these alternatives are distinguished.

## Decision

Issue `Task 0011RVD — baseline regression and expected-stderr diagnosis`.

The diagnostic must make no repository writes. It must:

- recover the exact accepted aggregate command;
- run it in fresh Godot processes with stdout and stderr redirected separately;
- record the actual native exit code;
- identify every failed assertion, parser error, script error, crash, and missing marker;
- confirm whether `LEVEL_ID_MISMATCH` is only the expected negative-path emission;
- compare two identical fresh-process runs;
- preserve all hashes, Git state, repository files, imports, and user data.

If both runs exit 0 and produce all seven markers, classify the original stop as `FALSE_BLOCKER_EXPECTED_NEGATIVE_PATH_STDERR` and resume the already-authorized Task 0011RV owner protocol in the same Codex session.

If either run exits nonzero or lacks a marker, stop with `BLOCKED_CONFIRMED_BASELINE_REGRESSION` and report the first causal failure without modifying code or tests.

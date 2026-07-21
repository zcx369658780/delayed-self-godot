# Task 0023ZR GPT disclosure-scanner blocker adjudication

- Reported terminal verdict: `BLOCKED_ISOLATED_PRODUCTION_POLICY_SANDBOX_MATRIX_RETRY`
- GPT adjudication: `TASK_0023ZR_BLOCKED_ON_DISCLOSURE_SCANNER_URI_SCHEME_FALSE_POSITIVE_AFTER_FIRST_CASE`
- Accepted implementation under test: `afe8c6fffdc98992b732fce46f206ad0dc8553a1`
- Real production Profile authority: none
- Test-root authority: none
- Product defect established: no
- Actual absolute-path disclosure established: no

## Evidence boundary

This adjudication accepts the owner/Codex execution summary and the stated external-audit result. GPT did not independently open the local external audit at:

```text
D:\Delayed_Self_Evidence\0023ZQ_isolated_production_policy_matrix\0023zr_blocked_attempt_1_audit.json
```

The accepted reported facts are:

- the Godot executable-path binding qualification passed with a path containing spaces;
- the complete 14/14 pre-validation passed;
- the no-guard proof passed;
- Attempt 1 entered its first behavior case and emitted the expected behavior markers;
- the disclosure scanner then classified the `s:/` substring inside the standard Godot banner URL as a Windows disk path;
- exact owned sandbox-data cleanup completed;
- zero Godot processes remained;
- Attempt 2 did not run;
- no product source, ordinary production Profile, ordinary user-data location or test root was contacted or modified;
- no repository commit or push occurred.

## Classification

The blocked result is valid and the stop was correct. The matrix contract requires fail-closed disclosure scanning, so Codex was required to stop on the reported scanner hit.

The reported token is not evidence of an actual disk-path leak. In a URL such as:

```text
https://godotengine.org
```

a permissive drive-path expression equivalent to `[A-Za-z]:[\\/]` can start at the final `s` of `https` and match `s:/`. A valid Windows drive-path detector must distinguish that embedded URI-scheme substring from a drive designator using a left-boundary rule.

Therefore:

```text
runner launch binding: qualified
sandbox behavior entry: reached for the first case
forbidden-disclosure classifier: false positive
actual path disclosure: not established
product/profile-policy defect: not established
first case acceptance: not established
complete Attempt 1: not established
Attempt 2: not run
complete matrix: not established
```

The first case cannot be retrospectively accepted merely because its behavior markers were normal. The retained stdout/stderr still failed the active evidence scanner, and the rest of the matrix did not execute.

## Required repair direction

A continuation may repair only the runner-side disclosure classifier and its validation surface. The repair must:

1. require a real drive-path candidate to have a valid left boundary rather than matching inside an alphanumeric URI scheme;
2. continue detecting genuine `C:\\...`, `D:/...`, quoted/assigned drive paths and drive paths inside `file:///C:/...`;
3. preserve separate UNC-path detection;
4. reject actual absolute paths fail-closed;
5. not strip or blanket-allow all URL tokens;
6. not whitelist arbitrary Godot output lines;
7. include deterministic positive and negative synthetic vectors before any behavior retry;
8. preserve the accepted `ProcessStartInfo.FileName` plus per-argument `ArgumentList` launcher repair;
9. use fresh retry-owned attempt roots and preserve all earlier blocked evidence.

No product source, behavior expectation, manifest outcome, sandbox attestation or protected-data boundary may be weakened.

## Verdict

```text
TASK_0023ZR_BLOCKED_ON_DISCLOSURE_SCANNER_URI_SCHEME_FALSE_POSITIVE_AFTER_FIRST_CASE
```

This verdict authorizes no real player-data access, real recovery/write, default activation, aggregate registration, Menu flow, settings, localization, build/export, release, upload or festival submission.
# Task 0023ZS GPT acceptance — isolated production-policy matrix

- Reviewed implementation commit: `4128f9b921906e24b2dc5d752b9f4eaf45e59d9b`
- Review base: `6b40c0fbb590795714bdab6a32af6caacb35e2f1`
- Accepted product implementation under test: `afe8c6fffdc98992b732fce46f206ad0dc8553a1`
- Verdict: `TASK_0023ZS_ISOLATED_PRODUCTION_POLICY_SANDBOX_MATRIX_ACCEPTED`
- Real production Profile authority: none
- Test-root authority: none

## 1. Scope and repository review

The reviewed commit is one strict descendant of the Task 0023ZS checkpoint and changes only:

- the five authorized Task 0023ZQ/ZS harness artifacts;
- the Task 0023ZS execution report;
- the seven authorized CURRENT/project documentation files.

No product source, scene, project setting, catalog/formal data, UI/gameplay surface, historical test authority or task file changed. The repository main scene remains the memory-only AppRoot and no autoload/global store was introduced.

## 2. Disclosure-scanner repair

The runner retains the accepted `System.Diagnostics.ProcessStartInfo.FileName` plus one `ArgumentList` entry per Godot argument. No shell-command flattening or persistent environment mutation was introduced.

The drive-path classifier now requires a non-URI left boundary:

```text
(?<![A-Za-z0-9+.\-])[A-Za-z]:[\\/]
```

Separate UNC detection remains active. The implementation does not strip URLs, blanket-allow `://`, whitelist the Godot banner or downgrade disclosure failures.

The scanner qualification proves eleven deterministic vectors:

- five genuine drive-path positives, including `file:///C:/...`;
- one UNC positive;
- five negatives covering HTTP, HTTPS, the real Godot banner form, `res://` and `user://`.

The qualification passed before behavior and again after the two matrix attempts.

## 3. Harness and matrix contract

The accepted manifest contains exactly:

- schema version 1;
- three ordered stages;
- 22 unique cases;
- one assertion outcome per case;
- six required marker rows per case, for 132 total marker rows per attempt;
- explicit target/recovery/activation/transaction/write-disable expectations;
- ten frozen product/project hashes.

The validator proves guard-before-attestation, attestation-before-behavior, exact sandbox targeting, no test-root APIs, one-to-one case/manifest mapping, process-local APPDATA/LOCALAPPDATA assignment, exact-owned cleanup, Attempt-2 gating, fail-closed disclosure scanning and unchanged product/main-scene/autoload state. Its final deterministic count is 393 assertions.

## 4. Execution evidence accepted

The following evidence is accepted with the explicit owner/Codex provenance disclosure in the Task 0023ZS report:

```text
scanner qualification pre:  11 / 11
pre zero-I/O validation:     14 / 14
no-guard proof:              native exit 2
Attempt 1:                   22 / 22 cases, 132 / 132 marker rows, PASS_COMPLETE_MATRIX
Attempt 2:                   22 / 22 cases, 132 / 132 marker rows, PASS_COMPLETE_MATRIX
scanner qualification post: 11 / 11
post zero-I/O validation:    14 / 14
final validator:             393 assertions
```

Each attempt started from a separately absent process-local external APPDATA/LOCALAPPDATA sandbox. Each process attested the sandbox before Profile/configuration/filesystem behavior. Each attempt retained the required bounded evidence, passed disclosure scanning, completed exact cleanup of owned data trees and left zero residual Godot processes.

## 5. Protected-data adjudication

No ordinary production Profile, ordinary user-data directory, target metadata, sibling, test root or historical fixture was opened, probed, enumerated or modified. Historical blocked evidence remained byte-identical and was not reused as passing evidence.

This acceptance establishes that the frozen production-policy implementation behaves as specified inside two fresh isolated external sandboxes. It does not establish or authorize:

- reading the existing production Profile;
- probing its current metadata or exact owned sibling states;
- recovery-copy creation against real player data;
- a first real target write;
- default production activation;
- aggregate registration;
- Menu New/Continue/Reset;
- settings/localization;
- build/export, RC, upload, release or festival submission.

## 6. Final verdict

```text
TASK_0023ZS_ISOLATED_PRODUCTION_POLICY_SANDBOX_MATRIX_ACCEPTED
```

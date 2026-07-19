# Task 0023R — Repair and prove the Profile test-isolation gate

- Status: `READY`
- Gate: `PROTECTED PLAYER DATA / STANDALONE TEST-PATH ISOLATION PREFLIGHT`
- Repository/root/branch: `zcx369658780/delayed-self-godot` / `D:\Delayed_Self` / `main`
- Parent blocked task: `tasks/0023_persistent_local_profile_core_implementation.md`
- Governing amendment: `tasks/0023_profile_test_isolation_amendment.md`
- GPT blocker adjudication: `docs/reports/0023_GPT_PROFILE_TEST_ISOLATION_BLOCKER_ADJUDICATION.md`
- Expected adjudication checkpoint: `d5a37bb8633d4efdd98f92cd8ae34cbd8e79a92d`

## 1. Objective

Implement and independently prove only the canonical test-path isolation policy required before persistent Profile work may resume.

This task must establish that legal synthetic fixture paths under `user://delayed_self_test_profiles/` are accepted, every production/escape/spoof path is rejected, and the standalone preflight cannot read, write, create, rename, copy, hash, parse, delete, or fall back to the real production Profile.

This task does **not** implement Profile loading, serialization, recovery, transactional writes, reset, AppRoot integration, persistence, menu/settings/localization, or aggregate regression.

## 2. Startup and protected-data gate

Before edits or any Godot process:

- require root exactly `D:\Delayed_Self`;
- require clean `main`, expected SSH origin, `HEAD == origin/main`, divergence `0/0`;
- fetch and fast-forward only;
- require HEAD contains `d5a37bb8633d4efdd98f92cd8ae34cbd8e79a92d`;
- verify Godot `4.7.stable.steam.5b4e0cb0f` or the exact documented equivalent;
- require no residual Godot process.

The real production Profile must remain in place:

```text
user://delayed_self_profile.json
```

Do not open it through Godot or PowerShell. Do not read, parse, hash, copy, rename, back up, delete, repair, reset, or compare its contents.

Before the first Godot process, capture only these non-content metadata through PowerShell `Get-Item`/`Test-Path` or equivalent filesystem metadata APIs:

```text
exists
Length
LastWriteTimeUtc
```

Do not use `Get-Content`, file hashing, byte reads, stream opens, or any content-oriented command. Record the same metadata after the standalone preflight and require exact equality.

Stop immediately if metadata collection itself requires content access or if the production Profile metadata changes.

## 3. Required reads

Read in order:

1. `AGENTS.md`, current startup/active documents, and this task;
2. GPT blocker adjudication;
3. Task 0023 and its isolation amendment;
4. Task 0022 plan/acceptance;
5. current AppRoot/MemoryProgress tests only for future interface context—do not run or modify them.

Print a concise path-policy, standalone-test, metadata, evidence, cleanup, rollback, and stop-condition plan before writing.

## 4. Authorized implementation surface

Create one policy-only skeleton:

```text
scripts/app/local_profile.gd
class_name DelayedSelfLocalProfile
```

At this gate it may contain only constants, canonical test-path construction, fixture-ID validation, and path validation. It must perform **no file I/O** and must not instantiate or compose `MemoryProgress` yet.

Preferred public surface:

```text
static func build_test_profile_path(fixture_id: String) -> Dictionary
static func validate_test_profile_path(path: String) -> Dictionary
```

Structured results must include at least:

```text
ok: bool
status: String
path: String only when ok
```

Do not add a production-path override, command-line path, environment-variable path, arbitrary base-directory injection, service locator, autoload, or fallback behavior.

## 5. Exact canonical path grammar

Constants:

```text
PRODUCTION_PROFILE_PATH = "user://delayed_self_profile.json"
TEST_PROFILE_ROOT = "user://delayed_self_test_profiles/"
PROFILE_FILENAME = "delayed_self_profile.json"
```

The only accepted test path shape is:

```text
user://delayed_self_test_profiles/<fixture-id>/delayed_self_profile.json
```

`fixture-id` must match exactly:

```text
[A-Za-z0-9][A-Za-z0-9_-]{0,63}
```

Required policy:

1. `build_test_profile_path(valid_fixture_id)` returns the one canonical path.
2. `validate_test_profile_path(path)` accepts only a byte-for-byte canonical path that could have been returned by the builder.
3. Forward slash `/` is the only separator. Do not normalize backslashes or accept an input after cleanup.
4. No dot or dot-dot segment, empty segment, doubled separator, trailing separator, query/fragment notation, percent-encoded substitute, Unicode separator lookalike, or alternate filename is accepted.
5. The exact prefix must include the trailing slash; sibling-prefix paths such as `user://delayed_self_test_profiles_evil/...` are rejected.
6. The production path is always rejected.
7. `res://`, relative paths, absolute OS paths, drive-letter paths, UNC paths, and `file://` paths are rejected.
8. A directory path without the exact filename is rejected.
9. An empty, overlength, or invalid fixture ID is rejected.
10. Validation has no fallback result. Failure returns no usable path.

Do not call `simplify_path`, `globalize_path`, separator replacement, URL decode, or any normalization that converts an invalid input into an accepted one.

## 6. No-I/O source gate

For this task, `scripts/app/local_profile.gd` must contain no use of:

```text
FileAccess
DirAccess
ResourceLoader
ResourceSaver
ProjectSettings.globalize_path
OS.get_cmdline_args / OS.get_cmdline_user_args
Environment-variable reads
```

It must not call any helper that performs file access. The standalone test must also perform no file operation. Static source audit is required in addition to runtime assertions.

The production path constant may exist only so the validator can reject it explicitly and so the later implementation has one canonical authority.

## 7. Standalone preflight test

Create:

```text
tests/app/task_0023r_profile_test_isolation_gate.gd
```

Run it directly as a standalone script. It must not instantiate AppRoot, scenes, MemoryProgress, a Profile adapter instance, or `tests/run_all.gd`.

Required positive cases include at least:

```text
user://delayed_self_test_profiles/a/delayed_self_profile.json
user://delayed_self_test_profiles/fixture_001/delayed_self_profile.json
user://delayed_self_test_profiles/A-Z_09/delayed_self_profile.json
one fixture ID of exactly 64 valid characters
```

Required negative classes include at least:

- production Profile path;
- test-root directory alone;
- missing or wrong filename;
- empty fixture ID;
- 65-character fixture ID;
- leading `-` or `_` fixture ID;
- spaces, dots, colon, slash, backslash, non-ASCII, and control characters in fixture ID;
- `.` and `..` segments;
- doubled slash;
- trailing slash;
- sibling-prefix spoof;
- `res://`;
- relative path;
- `C:\...`, `C:/...`, UNC, `/absolute/...`, and `file://...`;
- backslash-separated `user://` lookalike;
- percent-encoded dot/slash forms;
- Unicode slash/backslash lookalikes;
- canonical prefix plus extra suffix after the filename.

Also prove:

- every accepted path equals `build_test_profile_path(extracted_fixture_id).path` exactly;
- every rejected result has no usable path;
- builder and validator are deterministic across repeated calls;
- source audit finds no prohibited I/O or arbitrary-path surface;
- the test process creates no fixture directory or file.

The standalone output must include exactly once:

```text
TASK_0023R_PROFILE_TEST_ISOLATION_GATE_PASS
```

Exit must be `0`, stdout must contain the assertion total, and stderr must be empty.

## 8. Execution order and hard stop

Run only in this order:

1. Git/toolchain/process checks;
2. external production metadata snapshot;
3. static source audit;
4. standalone isolation preflight;
5. external production metadata snapshot comparison;
6. test-root residue audit;
7. documentation/Git closeout.

Do **not** run:

```text
Task 0023 focused suite
aggregate tests
AppRoot tests
native product flow
Profile load/write/recovery probes
```

Any preflight failure ends the task. Do not continue into Profile implementation.

## 9. Evidence and cleanup

Use only:

```text
D:\Delayed_Self_Evidence\0023R_profile_test_isolation_gate\
```

Record:

- startup/Git/toolchain state;
- exact source audit command/output;
- standalone command/stdout/stderr/exit;
- positive/negative case inventory;
- production Profile non-content metadata before/after;
- proof that no production content command was used;
- test-root existence/residue before/after;
- changed-path audit, rollback, and final Git state.

Do not stage evidence or any generated file.

If `user://delayed_self_test_profiles/` already contains unrelated/pre-existing data, do not read or delete it. Record only its existence and stop with a blocker unless the task can prove a unique no-I/O preflight without touching the directory.

## 10. Authorized repository paths

```text
scripts/app/local_profile.gd
tests/app/task_0023r_profile_test_isolation_gate.gd
docs/reports/0023R_PROFILE_TEST_ISOLATION_GATE_REPORT.md
docs/CODEX_ACTIVE_TASK_CURRENT.md
docs/CODEX_STARTUP_SNAPSHOT_CURRENT.md
docs/DEVELOPMENT_PLAN_CURRENT.md
docs/DOC_INDEX_CURRENT.md
docs/HANDOFF_MASTER_CURRENT.md
docs/project_memory.md
docs/production/COMPLETE_FLOW_PRODUCTION_CLOSURE_PLAN_CURRENT.md
```

Do not modify AppRoot, MemoryProgress, `tests/run_all.gd`, any other test, scene, `project.godot`, formal data, catalog, Simulation, solver, schema, Gameplay, UI, localization, assets, export, release, or submission files.

## 11. Report, commit, and rollback

Create:

```text
docs/reports/0023R_PROFILE_TEST_ISOLATION_GATE_REPORT.md
```

The report must include the exact policy interface, grammar, case matrix, no-I/O source audit, standalone result, production metadata comparison, test-root residue result, evidence root, limitations, cleanup, and rollback.

Require one commit:

```text
fix: add Delayed Self profile test isolation gate
```

Push normally. Finish with clean worktree, `HEAD == origin/main`, divergence `0/0`, and no residual Godot process.

Rollback removes only the policy skeleton, standalone test, report, and minimum CURRENT-document updates. It must not access the production Profile or any pre-existing test-root content.

## 12. Terminal verdict

Return exactly one:

```text
PROFILE_TEST_ISOLATION_GATE_READY_FOR_GPT_REVIEW
BLOCKED_PROFILE_TEST_ISOLATION_GATE
```

Include commit SHA if produced, changed paths, assertion count, positive/negative case counts, source-audit result, production metadata equality, test-root residue result, evidence root, cleanup, and final Git state.

This task does not authorize persistent Profile implementation or a retry of Task 0023. A revised implementation task may be issued only after GPT accepts this isolation gate.

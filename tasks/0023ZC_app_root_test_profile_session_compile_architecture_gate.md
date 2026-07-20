# Task 0023ZC — Implement the AppRoot test-profile orchestration compile/architecture gate

- Status: `READY`
- Gate: `PROTECTED PLAYER DATA / APPROOT ORCHESTRATION COMPILE + ZERO-PROFILE-I/O ARCHITECTURE`
- Repository/root/branch: `zcx369658780/delayed-self-godot` / `D:\Delayed_Self` / `main`
- GPT adjudication: `docs/reports/0023ZB_GPT_APP_ROOT_TEST_PROFILE_SESSION_PRE_FIXTURE_INCOMPLETE_ADJUDICATION.md`
- Required checkpoint: `900c8149967048ee00d87e323ff0a7f6c0d524bf`
- Fixed fixture: **none; no fixture operation is authorized in this task**

## 1. Objective

Implement and compile the bounded AppRoot test-profile orchestration source without running any configured Profile filesystem behavior.

This gate may establish only:

```text
explicit pre-tree canonical test-path configuration
+ configured-branch source architecture
+ persistence-before-runtime-commit source ordering
+ classified public progress-snapshot shape correction
+ unchanged normal memory-only AppRoot behavior
+ parser/interface compilation
+ zero Profile/test-fixture I/O
```

It must not load, persist, reset, recover, create, inspect, or clean any test Profile fixture. It does not prove process-restart persistence, rollback, recovery, or AppRoot filesystem integration behavior.

## 2. Historical task closure

Do not execute, resume, edit, or reuse fixtures from:

```text
tasks/0023Y_app_root_test_profile_session_gate.md
tasks/0023Y_profile_test_app_root_session_orchestration_gate.md
tasks/0023Z_app_root_test_profile_session_retry_after_parser_gate.md
tasks/0023ZA_app_root_test_profile_session_instrumented_diagnostic_retry.md
tasks/0023ZB_app_root_test_profile_session_evidence_complete_rebuild.md
```

No source/test draft from those tasks is accepted. Reimplement from the current repository plus the accepted 0023W/0023X contracts and GPT adjudications.

## 3. Startup gate

Before edits or Godot processes:

1. require absolute root `D:\Delayed_Self`, branch `main`, expected origin, and clean tracked/untracked worktree;
2. run the startup Git facts required by `AGENTS.md`;
3. fetch and fast-forward only;
4. require `HEAD == origin/main` and ancestry of `900c8149967048ee00d87e323ff0a7f6c0d524bf`;
5. read the complete 0023W and 0023X GPT acceptance reports and the 0023ZA/0023ZB adjudications;
6. verify pinned Godot `4.7.stable.steam.5b4e0cb0f` or the exact documented equivalent;
7. require no residual Godot process.

Stop on divergence, conflict, unexpected files, remote mismatch, or missing checkpoint.

## 4. Protected production and test-root boundary

Before every Godot group and after every group, record only production Profile non-content metadata:

```text
exists = true
Length = 473
LastWriteTimeUtc = 2026-07-19T08:15:02.2089459Z
```

Do not open, read, parse, hash, copy, rename, back up, delete, reset, repair, compare, or write production Profile content.

For `user://delayed_self_test_profiles/`, record only whether the root exists. Do not enumerate, inspect, create, clean, or modify it.

This task has no fixture ID. Do not call `build_test_profile_path` for a task-owned fixture and do not check whether any candidate fixture directory exists.

Canonical test-profile strings may exist only as in-memory literals for zero-I/O validation/compile calls, for example:

```text
user://delayed_self_test_profiles/task_0023zc_compile_only/delayed_self_profile.json
```

They must never be passed to a boot path that constructs or calls the filesystem store.

Any Profile/test-root filesystem operation or production metadata change is an immediate stop with no implementation commit.

## 5. Mandatory accepted prerequisites

Before editing, rerun exactly the accepted standalone gates:

```text
0023R path isolation = 123 assertions / 4 positive / 39 negative
0023T codec compile + behavior = compile marker + 34 assertions
0023V store-instance compile + configuration = compile marker + 28 assertions
0023W store compile + filesystem behavior = compile marker + 68 assertions
0023X adapter compile + behavior = compile marker + 31 assertions
```

Every command must exit 0, print its marker exactly once, and have empty stderr. Require the 0023W fixture absent after its own cleanup, unchanged protected metadata, unchanged test-root existence, and no Godot process.

## 6. Frozen authorities

Do not modify:

```text
scripts/app/profile_codec.gd
scripts/app/local_profile.gd
scripts/app/profile_progress_adapter.gd
scripts/app/memory_progress.gd
all existing 0023R–0023X tests
formal catalog/level data
Simulation/solver/schema/canonical state
Gameplay/Help/Timeline/Level Select/final acknowledgment
scenes/project.godot
```

Normal unconfigured AppRoot routing, direct-development routing, record-once handling, non-final automatic return, and final retained acknowledgment/return/replay behavior remain frozen.

Stop if the task appears to require a frozen-source change.

## 7. Authorized AppRoot surface

Modify only `scripts/app/app_root.gd` for product source behavior.

Add a bounded pre-tree test-only configuration surface equivalent to:

```text
configure_test_profile(canonical_test_profile_path: String) -> Dictionary
```

It must:

1. be callable only before tree entry, `_ready`, or boot;
2. validate through the frozen 0023R canonical virtual-path policy before retaining anything;
3. reject the production path and every invalid path with zero Profile I/O and no fallback;
4. retain exactly one validated canonical virtual path;
5. permit a valid retry after a failed first attempt;
6. reject reconfiguration after first success;
7. reject valid configuration after boot/tree entry before any store construction or I/O;
8. expose no virtual/globalized path, source content, file handle, store/adapter reference, or production fallback.

Do not add:

```text
create_production
production-mode flags
arbitrary OS-path injection
environment/command-line Profile path selection
autoloads
background threads
dependency injection
a second router
```

## 8. Configured-branch source architecture

The configured test-profile branch may be written but must not be executed in this task.

Its source must encode this order after validated catalog load:

```text
construct/configure accepted 0023X adapter
→ obtain defensive catalog facts
→ construct/configure accepted 0023W store
→ store.load_profile once
→ accept only MISSING_CLEAN / LOADED / SANITIZED / RECOVERED_CLEAN
→ adapter.load_profile normalized Profile
→ use adapter as runtime progress authority
→ continue through existing router
```

On configuration/load/hydration failure, source must avoid exposing partial progress authority and route to one existing bounded Safe Error with stable status-only diagnostics.

No configured branch may run from an unconfigured normal boot.

## 9. Completion source ordering

Preserve the existing active-Gameplay and record-once guards.

Configured test-profile source must encode:

```text
adapter.prepare_completion
→ NO_CHANGE: recorded success without write/commit
→ CANDIDATE_READY: store.persist_profile
→ accept only PERSISTED / NO_CHANGE
→ adapter.commit_profile only after persistence success
→ only then claim recorded completion/navigation
```

Failure source must not commit runtime state, must preserve the pre-completion runtime/Profile state contract, and must enter bounded Safe Error without false Level Select return or final acknowledgment success.

This task does not execute or behaviorally prove any of these branches.

## 10. Mandatory classified public-snapshot correction

`get_progress_snapshot()` must retain exactly the existing public shape in both modes:

```text
completed_level_ids
best_turns
unlocked_level_ids
```

Required implementation:

- memory-only mode returns a defensive copy of `DelayedSelfMemoryProgress.snapshot()`;
- configured test-profile mode returns a defensive copy of the 0023X adapter snapshot's nested `runtime` Dictionary;
- never return adapter wrapper keys such as `configured`, `catalog_facts`, or `profile_loaded` through the public API;
- never expose settings, Profile content, paths, recovery/temp names, or diagnostics.

A separate bounded test-session snapshot may expose only mode/configured/boot/load/persist status identifiers plus the public progress snapshot.

## 11. Failure-seam forwarding surface

A test-only method equivalent to:

```text
set_test_profile_failure_seam(stage: String) -> Dictionary
```

may be added for later fixture tests. It must:

- reject before a configured store exists;
- forward only accepted 0023W failure-stage identifiers after configured boot;
- accept no path or operation argument;
- expose no store reference, filesystem handle, raw error, or path;
- never select production mode.

This method is compiled only and is not behaviorally exercised against a store in this task.

## 12. Explicit typing policy

In changed AppRoot source and new 0023ZC tests:

- explicitly type locals receiving dynamic method results, `Dictionary.get`, scene instantiation, active-screen access, adapter/store results, await results, ternaries, JSON results, and untyped collection access;
- use `Variant` where no narrower stable type exists;
- do not use `:=` with dynamic or Variant-returning expressions;
- explicitly type arrays/dictionaries crossing helper boundaries and loop elements from untyped collections.

Run a static audit before the first compile smoke and again at the end.

## 13. Required zero-Profile-I/O tests

Create only:

```text
tests/app/task_0023zc_app_root_profile_orchestration_parser_smoke.gd
tests/app/task_0023zc_app_root_profile_orchestration_compile_contract.gd
```

### 13.1 Parser smoke

Preload the changed AppRoot script/scene and frozen store/adapter scripts. Do not enter the tree, call boot, validate a real fixture, or perform Profile I/O.

Print exactly once:

```text
TASK_0023ZC_APP_ROOT_PROFILE_ORCHESTRATION_PARSER_SMOKE_PASS
```

Allow at most five parser-only correction attempts in authorized files.

### 13.2 Compile/contract test

Use only in-memory canonical virtual strings and no fixture operation. Cover at minimum:

1. invalid and production paths reject before tree entry;
2. failed first configuration permits a later valid canonical configuration;
3. first successful configuration is immutable;
4. session snapshot is bounded and does not expose the retained path;
5. failure-seam forwarding rejects before store construction;
6. a valid configured off-tree AppRoot can be freed without entering the tree or constructing a store;
7. a separate unconfigured AppRoot enters the tree and retains existing memory-only Main Menu behavior;
8. memory-only public progress snapshot has exactly the three required keys, is defensive, and initially unlocks only Tutorial 0;
9. valid configuration after tree entry rejects with zero Profile I/O;
10. direct-development routing remains unchanged in an unconfigured instance where already covered by the focused test;
11. no test-root existence change and no production metadata change occurs.

The compile/contract test must never enter a successfully configured AppRoot into the tree.

Print exactly once:

```text
TASK_0023ZC_APP_ROOT_PROFILE_ORCHESTRATION_COMPILE_CONTRACT_PASS
```

Require exit 0 and empty stderr. Do not add an aggregate marker and do not run `tests/run_all.gd`.

## 14. Static architecture audit

Before and after tests, audit the changed source and new tests. Require evidence that:

- no production constructor/fallback exists;
- no environment/command-line/arbitrary OS Profile path exists;
- no configured branch can activate from normal unconfigured boot;
- store/adapter construction occurs only in the explicitly configured boot branch;
- store load occurs only after successful store configuration;
- adapter commit appears only after accepted persistence success;
- public progress snapshot selects nested adapter `runtime` in configured mode;
- new tests contain no `FileAccess`, `DirAccess`, fixture creation/cleanup, store load/persist/reset call, or test-root enumeration;
- production path appears only in rejection/validation checks;
- frozen files are byte-identical to the pre-task checkpoint.

Any ambiguous ordering or source path leak is a blocker.

## 15. Post-test gates

After parser and compile/contract tests pass:

1. rerun both 0023ZC tests from fresh processes;
2. rerun 0023R/0023T/0023V/0023W/0023X;
3. repeat explicit-typing and architecture audits;
4. confirm frozen files unchanged;
5. confirm production metadata and test-root existence unchanged;
6. confirm the 0023W fixture remains absent;
7. require no residual Godot process.

Do not run any configured AppRoot boot, fixed fixture, Profile store operation, behavior matrix, aggregate, or product export.

## 16. Authorized repository paths

```text
scripts/app/app_root.gd
tests/app/task_0023zc_app_root_profile_orchestration_parser_smoke.gd
tests/app/task_0023zc_app_root_profile_orchestration_compile_contract.gd
docs/reports/0023ZC_APP_ROOT_PROFILE_ORCHESTRATION_COMPILE_GATE_REPORT.md
docs/CODEX_ACTIVE_TASK_CURRENT.md
docs/CODEX_STARTUP_SNAPSHOT_CURRENT.md
docs/DEVELOPMENT_PLAN_CURRENT.md
docs/DOC_INDEX_CURRENT.md
docs/HANDOFF_MASTER_CURRENT.md
docs/project_memory.md
docs/production/COMPLETE_FLOW_PRODUCTION_CLOSURE_PLAN_CURRENT.md
```

Do not modify any other source, existing test, task, scene, project setting, formal data, asset, localization, export, release, or submission surface.

## 17. Evidence and Git

Use only:

```text
D:\Delayed_Self_Evidence\0023ZC_app_root_profile_orchestration_compile_gate\
```

Record startup facts, protected metadata, prerequisite results, parser-attempt ledger, compile/contract assertions, source audits, changed paths, frozen hashes, and final Git state.

Create:

```text
docs/reports/0023ZC_APP_ROOT_PROFILE_ORCHESTRATION_COMPILE_GATE_REPORT.md
```

Require one implementation commit:

```text
feat: add Delayed Self AppRoot profile orchestration compile gate
```

Stage authorized paths explicitly, run `git diff --cached --check`, fetch and stop on drift, then push normally.

Finish with clean worktree, `HEAD == origin/main`, divergence `0/0`, no Godot process, unchanged production metadata/test-root existence, and no task-owned fixture.

## 18. Terminal verdict and non-claims

Return exactly one:

```text
APP_ROOT_PROFILE_ORCHESTRATION_COMPILE_GATE_READY_FOR_GPT_REVIEW
BLOCKED_APP_ROOT_PROFILE_ORCHESTRATION_COMPILE_GATE
```

Include commit SHA if produced, parser/contract results and assertion count, prerequisite regressions, static-audit result, protected metadata, absence of Profile/test-fixture I/O, changed paths, evidence root, and final Git state.

A passing verdict establishes only compile-level AppRoot architecture and unchanged default-memory behavior. It does not establish configured store load/persist/reset, recovery, rollback, process-restart persistence, full behavior-harness completeness, two-pass evidence, production Profile operation, product menus/settings/localization, aggregate coverage, build/export, RC, release, upload, or festival submission readiness.
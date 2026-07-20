# Task 0023ZO — Design production Profile activation and prepare the explicit player-data authorization gate

- Status: `READY`
- Gate: `PROTECTED PLAYER DATA / PRODUCTION PROFILE ACTIVATION DESIGN + AUTHORIZATION PACKAGE`
- Repository/root/branch: `zcx369658780/delayed-self-godot` / `D:\Delayed_Self` / `main`
- GPT prerequisite acceptance: `docs/reports/0023ZN_GPT_APP_ROOT_PROFILE_SESSION_FULL_MATRIX_ACCEPTANCE.md`
- Required checkpoint: `72dc42448261b8847c224a903743d815cf9e6136`
- Production Profile path: `user://delayed_self_profile.json`
- Existing permitted metadata: `true / 473 / 2026-07-19T08:15:02.2089459Z`
- Product source changes: **forbidden**
- Godot / PowerShell execution: **forbidden**
- Production Profile content access: **forbidden**

## 1. Objective

Produce a docs-only implementation and authorization plan for activating the already accepted Profile v1 stack on normal product boot.

The plan must answer, without executing or changing the product:

```text
how normal AppRoot boot will configure the production store
when the existing production Profile will first be read
when the product is allowed to write for the first time
how missing / malformed / unknown-version profiles behave
how test-only configuration remains isolated
how direct-development routes remain bounded
how code rollback avoids deleting or rewriting player data
what exact later operation requires explicit user authorization
what evidence is required before and after that operation
```

This task is not the activation implementation. It creates the narrow decision record and the exact future task boundary.

## 2. Absolute safety boundary

Do not:

- run Godot, PowerShell validation, the canonical runner, aggregate tests, exports, or builds;
- open, read, parse, hash, copy, rename, back up, delete, reset, repair, compare, or write `user://delayed_self_profile.json` content;
- enumerate `user://delayed_self_test_profiles/` or inspect any fixture;
- modify product source, tests, scenes, `project.godot`, manifests, harnesses, assets, localization, or export settings;
- invoke any runtime path that would configure a production store;
- stage or commit external evidence files.

Only the production Profile's existing non-content metadata may be repeated from accepted records. Do not refresh it from the filesystem in this task.

## 3. Startup gate

Before documentation edits:

1. require absolute root `D:\Delayed_Self`, branch `main`, expected origin, and no Git operation in progress;
2. require a clean tracked/untracked worktree and no staged changes;
3. fetch and fast-forward only;
4. require `HEAD == origin/main` and ancestry of `72dc42448261b8847c224a903743d815cf9e6136`;
5. read the complete 0023ZN GPT acceptance and execution report;
6. read the current production-closure plan, AppRoot source, codec/store/adapter/MemoryProgress source, and current startup/active documents;
7. use static repository inspection only.

Stop on divergence, conflict, unexpected local changes, missing checkpoint, or any request to access player data.

## 4. Frozen authorities

Treat as accepted and immutable:

```text
Profile v1 schema and 65,536-byte bound
production path user://delayed_self_profile.json
missing profile = clean memory state, no mandatory boot write
exact version/type/catalog validation
unknown IDs dropped deterministically
malformed/unknown-version source preserved before clean recovery
safe-error behavior when recovery copy cannot be made
unique temp sibling + flush/close + replace
prepare → persist → commit ordering
NO_CHANGE does not write or commit
MemoryProgress derives unlocks and returns sorted snapshots
test-profile canonical-path isolation
configured AppRoot boot/load/hydration order
normal current AppRoot remains memory-only until a later authorized activation
```

The eight-level catalog, finale, Gameplay, route, Help, Timeline, Level Select, and formal-data contracts remain frozen.

## 5. Required static architecture decision

The plan must choose and justify one production activation seam. Compare at least:

```text
A. AppRoot internally configures the production path before entering the tree
B. a dedicated boot/composition object configures AppRoot before tree entry
C. project/autoload-level store ownership
```

Prefer the smallest extension of the accepted AppRoot configuration seam. Reject any option that:

- creates a second navigation framework;
- makes tests use the production path;
- writes on every boot;
- bypasses prepare → persist → commit;
- serializes unlocks or puzzle mid-state;
- exposes Profile content/path in public snapshots or errors.

The decision must specify exact likely files and functions but must not edit them.

## 6. Required boot-state contract

Define exact expected behavior for these normal-product states:

### 6.1 Missing production Profile

- normal boot loads a clean in-memory v1 profile;
- Main Menu remains available;
- no file is created merely by booting;
- first write occurs only on an intentional persistent change.

### 6.2 Valid partial/completed production Profile

- boot loads, validates, hydrates, and exposes only bounded runtime progress;
- no write or timestamp change occurs during successful read-only boot;
- Continue/New Game UI remains a later slice unless already required by activation.

### 6.3 Malformed or unknown-version production Profile

- original target is never silently overwritten;
- bounded recovery copy behavior follows the accepted store contract;
- if recovery copy succeeds, boot continues from clean memory with a bounded recovery status;
- if recovery copy fails, enter Safe Error and disable Profile writes;
- no raw path, bytes, schema body, or filesystem error is exposed.

### 6.4 Runtime persistence failure

- persistence failure prevents adapter commit;
- runtime progress does not falsely advance;
- route enters the accepted bounded Safe Error behavior;
- known-good target remains intact.

## 7. First-read and first-write authorization model

The plan must explicitly separate:

```text
code implementation without production runtime execution
synthetic/fixed-fixture validation
controlled production read-only boot
controlled production first-write test
normal default activation
```

For each step, state whether it:

- reads production Profile content;
- can modify production metadata/content;
- requires explicit user authorization;
- can be rolled back by code revert alone;
- needs a backup/recovery proof.

The later controlled production read or write task must not be hidden inside a general implementation task.

## 8. Existing 473-byte Profile handling

The current accepted metadata indicates an existing production Profile:

```text
exists = true
Length = 473
LastWriteTimeUtc = 2026-07-19T08:15:02.2089459Z
```

Without accessing its content, define a safe activation policy covering:

1. no deletion, reset, rename, backup, copy, parse, or comparison before explicit authorization;
2. no assumption that the file is valid merely because its length is plausible;
3. a later controlled read must use only the production code path and bounded result/status evidence where possible;
4. no report may disclose Profile content;
5. first-write authorization must name the intentional action that causes the write and the exact before/after metadata evidence;
6. code rollback must never attempt to roll back player data automatically.

## 9. Test and evidence plan

Design a staged future verification plan that uses only isolated fixtures until explicit production authorization.

At minimum include:

```text
compile/parser/static contract gate
synthetic missing/valid/malformed/unknown-version fixture tests
normal boot memory-vs-production mode contract
read-only valid-profile boot with zero write proof
first intentional completion write
NO_CHANGE replay zero-write proof
recovery-copy success/failure
process restart and fresh reload
public snapshot disclosure checks
exact cleanup for test fixtures
production metadata protection
```

Specify which accepted 0023R–0023ZN tests remain frozen and which new focused tests would be required.

Do not propose rerunning the large full matrix as part of every implementation edit. Use narrow compile/static/fixture gates first, then one separately authorized final production-activation acceptance.

## 10. Rollback and compatibility plan

Define:

- code rollback boundaries;
- why code rollback must not delete or rewrite an existing Profile;
- schema-version compatibility limitations;
- how a newer Profile blocks an older build safely;
- what evidence is retained after malformed/unknown-version recovery;
- how Safe Error prevents continued writes after unsafe recovery failure;
- how to disable activation in development without changing the production file.

Do not introduce broad migration, slots, cloud, accounts, or legacy format support.

## 11. Recommended task decomposition

The report must propose narrowly bounded future tasks. The recommended sequence should distinguish at least:

1. production-activation code planning/compile gate with no production runtime I/O;
2. isolated fixture behavior gate;
3. explicit-user-authorized controlled production read-only boot;
4. explicit-user-authorized controlled first-write/NO_CHANGE verification;
5. final default-activation acceptance;
6. aggregate registration only after the focused gates are accepted;
7. Menu New/Continue/Reset and pause/quit confirmation as the next product-flow slice.

Each proposed task must state authorized files, forbidden operations, required evidence, stop rules, and non-claims.

## 12. Required output

Create exactly:

```text
docs/reports/0023ZO_PRODUCTION_PROFILE_ACTIVATION_DESIGN_AND_AUTHORIZATION_PLAN.md
```

The report must contain:

- current accepted architecture and frozen facts;
- chosen activation seam and rejected alternatives;
- boot-state table;
- first-read/first-write authorization table;
- handling of the existing 473-byte Profile without content access;
- implementation file/function map;
- fixture and production evidence plan;
- rollback and compatibility plan;
- staged future task sequence;
- an explicit list of operations requiring user authorization;
- exact non-claims.

Update only authorized current documentation listed below.

## 13. Authorized repository paths

```text
docs/reports/0023ZO_PRODUCTION_PROFILE_ACTIVATION_DESIGN_AND_AUTHORIZATION_PLAN.md
docs/CODEX_ACTIVE_TASK_CURRENT.md
docs/CODEX_STARTUP_SNAPSHOT_CURRENT.md
docs/DEVELOPMENT_PLAN_CURRENT.md
docs/DOC_INDEX_CURRENT.md
docs/HANDOFF_MASTER_CURRENT.md
docs/project_memory.md
docs/production/COMPLETE_FLOW_PRODUCTION_CLOSURE_PLAN_CURRENT.md
```

Do not modify any other repository path.

## 14. Validation and closeout

Before commit:

- verify only authorized documentation paths changed;
- verify no product/test/harness/scene/project-setting diff;
- verify no Godot/PowerShell/runner/aggregate/export/build command ran;
- verify no production or test-root filesystem access was performed;
- run Markdown/link/path consistency checks that do not execute product code;
- stage authorized paths explicitly;
- run `git diff --cached --check`;
- fetch and stop on remote drift;
- push normally.

Commit message:

```text
docs: plan Delayed Self production profile activation
```

## 15. Terminal verdict

Return exactly one:

```text
PRODUCTION_PROFILE_ACTIVATION_DESIGN_READY_FOR_GPT_REVIEW
BLOCKED_PRODUCTION_PROFILE_ACTIVATION_DESIGN
```

A passing result establishes only a reviewed production-activation design and authorization package. It does not authorize reading or writing the existing production Profile, modify AppRoot, enable default persistence, implement menus/settings/localization, register aggregate coverage, build/export, release, upload, or festival submission.

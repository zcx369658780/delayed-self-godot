# Task 0023ZT controlled production read-only harness construction report

- Verdict: `CONTROLLED_PRODUCTION_READ_ONLY_HARNESS_READY_FOR_GPT_REVIEW`
- Construction checkpoint: `19c31a73c92750b3d4621900f9b8ae2876cc6be9`
- Required ancestry: `7739ac26420e4c006b8fc6eba0f6b01a9d641ea1`
- Accepted implementation ancestry: `afe8c6fffdc98992b732fce46f206ad0dc8553a1`
- Godot: `4.7.1.stable.steam.a13da4feb`
- Real production Profile content/metadata/sibling access: `0`
- Future guard-passing executions: `0`
- Production configuration runtime calls: `0`
- Test-root operations: `0`

## Repository changes

The five new inert harness artifacts are:

```text
tests/app/task_0023zt_controlled_production_read_only_observation.gd
tests/app/task_0023zt_controlled_production_read_only_parser_smoke.gd
tests/app/task_0023zt_controlled_production_read_only_validator.gd
tests/app/task_0023zt_controlled_production_read_only_manifest.json
tests/app/task_0023zt_capture_controlled_production_read_only.ps1
```

This report and the authorized CURRENT documents are the only other changed
paths. Product source, scenes, project settings, catalog/formal data,
historical tests/runners and the five accepted 0023ZQ/ZS artifacts remain
frozen. The main scene remains `res://scenes/app/app_root.tscn`, and no
`[autoload]` section exists.

## Inert authorization architecture

The future runner requires the exact owner parameter:

```text
-OwnerAuthorization TASK_0023ZU_OWNER_AUTHORIZED_PRODUCTION_READ_ONLY
```

It then requires `docs/CODEX_ACTIVE_TASK_CURRENT.md` to contain both Task
`0023ZU` and status
`OWNER_AUTHORIZED_CONTROLLED_PRODUCTION_READ_ONLY_EXECUTION`. Only after those
runner gates may future code derive the ordinary data target, inspect exact
non-content metadata or create the reserved evidence root.

The one future child process receives a process-local exact environment guard:

```text
DELAYED_SELF_0023ZU_PRODUCTION_READ_AUTHORIZATION=TASK_0023ZU_OWNER_AUTHORIZED_PRODUCTION_READ_ONLY
```

and one exact user argument:

```text
--task-0023zu-controlled-production-read-only
```

The observation script checks both child guards in `_initialize()` before
loading product code, instantiating a Node, configuring a policy, adding a
composition root, or performing any filesystem/user-data operation. A mismatch
emits exactly one bounded blocked marker and exits 2. The authorized branch
configures exactly `PRODUCTION_READ_ONLY`, adds one bootstrap/composition root,
waits three bounded frames and reads only bounded public snapshots.

## Bounded future outputs

Allowed retained observations are target existence/length/UTC write-time
before and after, bounded load/boot/route values, completed/best-turn/unlocked
counts, exact public progress-key count, four sibling-category counts before
and after, native exit, stderr byte count and deterministic marker counts.

Forbidden retained material includes raw Profile bytes/JSON, content hashes,
completed IDs, best-turn values, settings values, unsupported numeric version,
ordinary absolute paths, sibling filenames, raw filesystem errors and
store/adapter objects.

The exact status/route matrix is:

| load status | boot status | route |
|---|---|---|
| `MISSING_CLEAN` | `PRODUCTION_PROFILE_READY` | `MAIN_MENU` |
| `LOADED` | `PRODUCTION_PROFILE_READY` | `MAIN_MENU` |
| `SANITIZED_PENDING_RECOVERY` | `PRODUCTION_PROFILE_READY` | `MAIN_MENU` |
| `RECOVERY_REQUIRED_READ_ONLY` | `FAILED_RECOVERY_REQUIRED_READ_ONLY` | `SAFE_ERROR` |
| `UNSUPPORTED_VERSION_READ_ONLY` | `FAILED_UNSUPPORTED_VERSION_READ_ONLY` | `SAFE_ERROR` |

## Exact no-write audit design

The runner contains direct `-LiteralPath` target observations and exactly four
owned sibling categories (`recovery`, `activation_backup`, `temp`,
`transaction`) over indices `0..7`: 32 fixed candidate checks per pre/post
phase. It records only category totals and requires exact pre/post equality.
There is no parent enumeration, wildcard/glob, retry, cleanup, deletion,
copy, rename, restore or rollback behavior. Target existence, length and UTC
write time must remain identical; absence before also requires absence after.

The launcher uses `ProcessStartInfo.FileName`, one `ArgumentList` entry per
argument and one syntactic process-start site. It does not override APPDATA or
LOCALAPPDATA, invoke another shell, flatten arguments or mutate persistent
environment state.

## Validation

The new parser smoke passed with native exit 0, empty stderr and one pass
marker. The initial static-validator execution correctly compiled but exposed
four overly strict self-check expressions: three expected guard literals
inside `_initialize()` although they were frozen as top-level constants, and
one used direct Dictionary equality for marker cardinality. Only the new
validator was corrected. Its fresh retry passed 123 assertions with native
exit 0, empty stderr and one pass marker.

All authorized zero-I/O regressions passed in fresh processes with native exit
0, empty stderr, one required marker and zero residual Godot processes:

```text
0023ZP compile smoke + static contract
0023ZS parser smoke + static validator
0023R path policy
0023T codec compile + pure codec
0023V store configuration compile + pure configuration
0023X adapter compile + pure adapter
0023ZC parser + zero-I/O compile contract
0023ZF parser only
```

The observation no-guard proof ran exactly once: native exit 2, empty stderr,
one guard-blocked marker and zero behavior/observation markers. The runner
no-authorization proof ran exactly once: native exit 2, empty stderr, one
authorization-blocked marker and no Godot child. No valid future guard value
was used and CURRENT was not modified to simulate Task 0023ZU.

## Frozen hashes

| path | SHA-256 |
|---|---|
| `scripts/app/app_bootstrap.gd` | `96ba1be8afd85ea548f823f095511f643879c6127322dbb91aa9cce01faf7f74` |
| `scenes/app/app_bootstrap.tscn` | `7391270ff909370ac727e10cb14e732488e5652f9e37bec904b9fe027f1d25b0` |
| `scripts/app/app_root.gd` | `79d92b823d4483c0ec97caced1c77bace147313e7b1694e12537146031fe89b7` |
| `scripts/app/local_profile.gd` | `91cb39e1d75189d0eb7b7d5e26a05f6a4524c2f95131ecb7276417f76d3aa89b` |
| `scripts/app/profile_codec.gd` | `c594ef1aed66471be18f8d95567dc5bce486a2c64cb62cd637431251070f8e12` |
| `scripts/app/profile_progress_adapter.gd` | `4c35ee3f0ec1c932ab30ffa3c3130870a3febfc7b2f2a6a219efd2a819f5f563` |
| `scripts/app/memory_progress.gd` | `41651ebcff17fd09247c3e5e820fff940c896efc25c5ba17ee7af668bbd4d567` |
| `scripts/app/route_request.gd` | `63e72c4c2b268d7909892665e1bdfb606a3992e5b1fe0f976b188032f66b561d` |
| `project.godot` | `faeb4a90b435aa81bd1c122ee12972e82db8dd5a90c448e850781e3d4b88c0d2` |
| five accepted `task_0023zq*` artifacts | manifest-bound individually; all matched |

The external startup inventory froze all 390 tracked repository files. Final
audit compares every non-authorized tracked path against that inventory.

## Zero-contact command audit

No command opened, statted, hashed or refreshed the production Profile; no
command queried or printed the ordinary user-data directory; no command
probed production siblings or touched the test root, historical fixtures or
Tasks 0023ZQ–0023ZS APPDATA sandboxes. The future 0023ZU evidence root was not
created, inspected or enumerated. Static source reads of the accepted owned
sibling naming contract were the only sibling-related activity.

Construction evidence is retained only under:

```text
D:\Delayed_Self_Evidence\0023ZT_controlled_production_read_only_harness_construction\
```

It contains only Git/hash facts, parser/static/regression outputs, the two
negative proofs and bounded audits. It contains no production content,
metadata, paths or sibling observations.

Task 0023ZU remains inactive. Any real controlled production read-only
observation requires a new task plus separate explicit owner authorization;
this construction result authorizes no access, recovery, write, reset, default
activation, aggregate, menu/settings/localization, build/export, RC, release,
upload or submission work.

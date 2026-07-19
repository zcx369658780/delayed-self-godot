# Task 0023U GPT Profile-store self-type compile blocker adjudication

- Reported terminal: `BLOCKED_PROFILE_FILESYSTEM_STORE`
- Disposition: `TASK_0023U_BLOCKER_ACCEPTED_REQUIRE_INSTANCE_CONFIGURATION_COMPILE_GATE`
- Blocked task: `tasks/0023U_profile_filesystem_store_gate.md`
- Repository checkpoint reported: `27ac01c0e49b129ff845755f5dbfc68302a8fccb`
- Product/Profile implementation retained: none

## Accepted facts

Task 0023U completed its accepted zero-I/O prerequisites, then stopped on the first store compile smoke because the draft `local_profile.gd` used an unresolved self-type reference inside the class-level creation path. No filesystem behavior test, fixture creation, AppRoot integration, MemoryProgress integration, aggregate regression, or product Profile operation followed.

All Task 0023U draft changes were rolled back. The repository was reported clean at `HEAD == origin/main`, and the production Profile remained present with the same 473-byte length and protected modification-time baseline. Its contents were not read. No task-owned fixture or residual Godot process remained.

This is a narrow GDScript construction/interface blocker. It is not evidence that the accepted Task 0023R path policy, Task 0023T pure codec, retained Windows replacement probe, or planned filesystem contracts are invalid.

## Adjudication

Do not retry the complete filesystem store immediately. First prove one Godot-4.7-compatible, explicitly typed instance-creation/configuration surface with zero I/O.

The revised architecture removes the class-internal static factory from the required surface. Callers will preload the script, instantiate it externally, and configure the fresh instance through one instance method:

```gdscript
const LocalProfileScript = preload("res://scripts/app/local_profile.gd")
var store: RefCounted = LocalProfileScript.new()
var configured: Dictionary = store.configure_test(catalog_facts, canonical_test_profile_path)
```

The instance method must:

```text
configure_test(catalog_facts: Dictionary, canonical_test_profile_path: String) -> Dictionary
```

- validate the path with the accepted Task 0023R policy before retaining it;
- validate and defensively copy the minimum catalog facts without using Profile filesystem I/O;
- configure a fresh instance once only;
- reject production/invalid paths with no retained fallback;
- reject reconfiguration;
- leave all load/persist/recovery/reset methods absent in the compile gate.

The instance may expose zero-I/O inspection methods for the compile gate, such as `is_configured()` and a structured configuration snapshot. It must not expose a generic arbitrary-path constructor/setter, production creation path, path normalization, environment/command-line input, or filesystem operation.

## Decision policy

If the instance-configuration compile gate passes on the pinned Godot 4.7 toolchain, GPT may issue a revised test-fixture-only filesystem-store task using this accepted construction pattern. That later task must still keep AppRoot, MemoryProgress and aggregate integration closed.

If the narrowed gate cannot compile within its bounded attempts, return another blocker and reconsider splitting the policy and store into separate scripts. Do not weaken explicit typing or data-isolation requirements merely to silence the compiler.

## Boundaries

This adjudication does not implement or accept Profile loading, filesystem writes, recovery copies, replacement, reset, production Profile access, AppRoot integration, restart persistence, aggregate regression, menus, settings, localization, export, RC, release, or submission.

```text
TASK_0023U_BLOCKER_ACCEPTED_REQUIRE_INSTANCE_CONFIGURATION_COMPILE_GATE
```

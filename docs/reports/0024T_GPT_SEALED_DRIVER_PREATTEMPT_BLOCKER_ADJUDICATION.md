# Task 0024T GPT sealed-driver pre-attempt blocker adjudication

- Verdict: `TASK_0024T_BLOCKED_ON_SEALED_DRIVER_POWERSHELL_COMPARISON_DEFECT_BEFORE_ANY_CASE`
- Product defect established: no
- Foundation acceptance established: no
- Final validation cases executed: `0 / 4`
- Task 0024T continuation authority: consumed and closed
- Required next step: new bounded correction gate with new artifacts, new seal and one fresh final-driver authorization

## Accepted blocker facts

Task 0024T completed its repairable static preparation before sealing:

- exactly four ordered cases;
- 44 unique coverage IDs;
- 26 frozen hashes;
- accepted wrapper blob verification;
- manifest, static validator, single-use driver and complete-v2 test;
- one read-only external seal with SHA-256 `c9f7f2eb1f781280bc9d4a778367da2cde2dfc805ce20578c42098e9bb3caf29`.

The exactly-once driver was then invoked once. It failed before attempt-record creation, before wrapper invocation and before all Godot validation cases.

The sealed driver used:

```powershell
Assert-True (Get-GodotCount -eq 0) 'Godot process exists at final-session start'
```

PowerShell interpreted `-eq` and `0` as arguments to the function call rather than as a comparison of the returned scalar. `Get-GodotCount` returned integer zero, which was converted to Boolean false by `Assert-True`. Actual pre/post Godot counts were zero.

## GPT classification

This is a final-harness defect:

- not a wrapper qualification failure;
- not a schema-v2 failure;
- not a Simulation failure;
- not a BFS/replay/canonical/malformed-input result;
- not a Task 0012 or formal-level regression;
- not a process leak;
- not a protected-data boundary breach.

Because Task 0024T authorized only one driver invocation and prohibited editing sealed artifacts or resealing, Codex correctly stopped without repair or rerun.

## Binding closure

Task 0024T is closed and must not be resumed directly.

Preserve without modification:

- the Task 0024T manifest;
- static validator;
- final driver;
- complete-v2 GDScript;
- external seal;
- blocker report and CURRENT closeout;
- all hashes and evidence.

Do not retrospectively create an attempt record or claim that a validation case ran.

## Required correction doctrine

A successor gate must:

1. create new Task 0024U artifact identities and a new external evidence root;
2. keep every 0024T sealed artifact immutable;
3. use explicit scalar assignment before each process-count comparison, for example:

```powershell
$initialGodotCount = Get-GodotCount
Assert-True ($initialGodotCount -eq 0) '...'
```

4. extend static validation to reject a bare function invocation inside a comparison-looking assertion argument;
5. prove the precondition comparison semantics without launching Godot before sealing;
6. statically seal the new fixed four-case session;
7. authorize one fresh final-driver invocation only;
8. execute each fixed wrapper case once with no retry;
9. retain mandatory accepted-wrapper cleanup and zero-process isolation;
10. keep provisional implementation, formal data, UID files, Profile and product surfaces frozen.

## Non-claims

This adjudication does not accept the provisional foundation and does not authorize sequence 9–12, catalog/finale/Profile changes, presentation, localization, assets/audio, build, release, upload or submission.
# Task 0024S GPT acceptance — Windows path identity and owned-wrapper qualification

- Verdict: `TASK_0024S_WINDOWS_PATH_IDENTITY_AND_OWNED_WRAPPER_QUALIFICATION_ACCEPTED`
- Accepted implementation/evidence commit: `7c0712d6a602dc23200ccb147d0096acc6333305`
- Scope accepted: harness qualification only
- Core-mechanics foundation acceptance: not established by this gate
- Final core-mechanics validation authority: not consumed by Task 0024S

## Accepted findings

Task 0024S preserved the eleven-file Task 0024R continuation byte-identically before ff-only synchronization and changed only authorized wrapper, qualification and documentation paths.

The wrapper no longer derives project identity from a raw command-line substring. It parses the Windows argument vector, accepts exactly one `--path <value>` or `--path=<value>`, canonicalizes fully-qualified Windows paths with separator, redundant-segment and trailing-separator normalization, and compares exact identity with `OrdinalIgnoreCase`. Prefix, suffix, backup, nested-project and unrelated-root paths remain non-equivalent.

The remaining descendant gates stayed independent: ancestry to the direct PID, creation time, executable identity, one exact `--script` identity, one `--headless` argument and forbidden editor/project-manager/export/main-scene rejection.

The focused qualification passed ten path-identity cases and eight lifecycle invocations. Normal exit, native exit 7, timeout, stderr-policy failure, marker failure, owned descendant, deterministic repeat and unproven-descendant exclusion were independently classified. Cleanup entered exactly once in every invocation. Owned descendants were ordered deepest-first and the direct PID last. Unproven descendants remained cleanup-ineligible and were not closed. Every case ended with zero Godot processes.

Static safety checks found no process-name-wide or wildcard termination, no shell-flattened Godot launch and only exact-PID cleanup over admitted records. Ownership and output evidence are bounded.

## Frozen and non-claims

No core-mechanics final matrix ran or was imitated. Schema v2, loader, Simulation, solver, Task 0012, UID sidecars, formal catalog/levels, Profile and product surfaces remained frozen.

This acceptance qualifies `tests/tools/run_owned_godot_headless.ps1` for later controlled validation. It does not accept the provisional schema-v2/Simulation/solver implementation at `fdaf2b81fc71c60e4b3548422be94953146f25f4`.

## Next gate

A separate manifest-locked task may construct a complete validation harness and execute one fresh final validation session. Preparation/static validation may be repaired before the final session is sealed. After the final driver is invoked once, no rerun is authorized within that task.

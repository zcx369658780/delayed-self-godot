# Task 0024AK GPT module-session reload and durability blocker acceptance

- Date: 2026-07-23
- Result commit: `e6b57d4ed2f703287abab88809a551c5da50114d`
- Terminal result: `BLOCKED_SCHEMA_V2_RETAINED_DRIVER_SCOPE_ISOLATION`
- GPT verdict: `TASK_0024AK_HONEST_MODULE_SESSION_RELOAD_DURABILITY_BLOCKER_ACCEPTED_FRESH_PROCESS_ISOLATED_GATE_REQUIRED`

## Adjudication

Task 0024AK is accepted as an honest terminal retained-cycle blocker. It is not accepted as a completed retained qualification and it does not authorize owner subjective review, product admission or release work.

The pre-retention machine evidence is valid and materially advances the gate:

- the standalone wrapper adapter, parameter-free evidence module and non-dot-sourced driver architecture passed scope, AST, parser and driver-preflight probes;
- the frozen Task 0024AJ focused validator passed twice through the new adapter;
- both runs retained wrapper schema v2, `PASS/PASS`, native exit `0`, one literal marker occurrence, empty stderr, cleanup exactly once, empty owned/unproven PID arrays and Godot `0/0`;
- both runs retained the complete thirteen-record AJ evidence set, the exact thirteen nonempty pairwise-distinct lifecycle signatures, four candidate Gameplay preflights, swapped-identity control, sensor/barrier lifecycle, crate, key/lock/inventory, latch, fit/layering and v1 regression;
- PRE_FINAL, POST_FINAL and closeout audits reported zero historical mismatch and zero unauthorized path drift.

## Terminal retained-cycle failure

The unique Task 0024AK manifest `2de60fc6-9065-4ecf-a5d9-a09b739f1461` and invocation `a3331dbe-26b5-4a56-ade6-25bfc0aefd9a` are consumed and immutable.

The first case invoked the AK standalone adapter and Godot and returned one parseable capture. The parent driver then attempted to call `ConvertFrom-Task0024AKWrapperValues` before writing a durable case record, but that exported function was no longer resolvable. The remaining four cases were not invoked. No retained case record or retained result was created, and final Godot count was zero.

The precise mechanism is a PowerShell session module-table lifetime defect:

1. the parent driver imported `task_0024ak_evidence_parser.psm1` into its local scope;
2. the separately invoked adapter script imported the same module with `Import-Module -Force`;
3. `-Force` reloaded the module in the shared PowerShell session, invalidating the parent driver's previously imported command binding;
4. after the adapter returned, the parent command name was unavailable;
5. because raw-wrapper revalidation preceded durable case-file creation, the successfully executed first case left no retained record.

This is a retained-driver/module-session/durability defect, not evidence of a failure in the frozen AJ validator, presentation helper, Gameplay, Simulation, candidate levels, isolated staging route, catalog or Profile implementation.

## Frozen facts

The following are terminal and must not be repaired, relabeled, reconstructed or rerun under Task 0024AK:

- manifest `2de60fc6-9065-4ecf-a5d9-a09b739f1461`;
- invocation `a3331dbe-26b5-4a56-ade6-25bfc0aefd9a`;
- every committed `task_0024ak_*` artifact;
- the Task 0024AK report and this GPT acceptance;
- all historical Task 0024AF–0024AJ artifacts.

## Required fresh gate

A new task identity is required. The next retained architecture must isolate the PowerShell module table by process, not merely by script scope:

- a parent orchestrator must not import or call PowerShell parser-module functions;
- each case must run in a fresh `pwsh -NoProfile -NonInteractive -File` worker process;
- each worker must complete parsing and atomically persist its case record before returning success;
- the parent must independently validate the durable JSON file using a non-PowerShell parser;
- progress must be atomically journaled after every case;
- a synthetic crash-after-worker-success probe must prove evidence survives parent failure;
- a complete five-case non-retained rehearsal using the exact final worker/orchestrator path must pass before a new retained manifest may be declared.

Production remains exactly eight cataloged levels with sequence 8 as the sole formal finale. Owner playthrough remains `NOT_YET_REVIEWED`; visual art direction remains not final; catalog admission remains `NOT_AUTHORIZED`.

# Task 0024AW C02 machine-validation report

## Verdict

`PASS_FOR_GPT_REVIEW`.

C02 `phase_1_c02_crate_pressure_imprint / Pressure Imprint / 压印回路` is an uncatalogued, unsequenced schema-v2 candidate. Machine validation does not authorize catalog admission, owner acceptance, Profile integration, finale movement, presentation acceptance, build, release, upload, or submission.

## Candidate and intended mechanic

The 9×8 level contains one YOU, one delay-2 ECHO, one crate, one `YOU_ONLY` sensor with `include_crates=true`, one two-cell grouped barrier, one Plate, one Door, and one YOU-only EXIT. The accepted shortest witness is:

`UP, RIGHT, DOWN, DOWN, RIGHT, RIGHT, RIGHT, UP, UP, UP, UP, UP, RIGHT, RIGHT`.

On turn 2 YOU legally pushes the crate onto the eligible sensor and the next state opens the grouped route. The crate remains on that sensor when ECHO crosses the open barrier on turn 7. ECHO alone reaches the Plate and opens the Door state on turn 9; YOU crosses the already-open Door on turn 12 and reaches EXIT on turn 14.

## Solver and all-shortest proof

- Shared BFS: `SOLVED`, `L*=14`, exact `N*=1`.
- All-shortest enumeration through shared `Simulation.transition`: `1/1` full mask, zero omissions, complete, 7,257 composite states.
- Every shortest solution has exactly one consequential YOU push.
- Replay is deterministic, restart equals the complete initial mutable state, and moving only the crate changes the canonical key.

## Controls and probes

Complete finite-state unsolved controls: no-push 736 states; sensor excludes crate 1,211; no crate 7,780; displaced crate 5,611; no ECHO 38. The schema-consistent initially-open fixture solves through a different 19-turn bypass and omits the full crate chain. Broadening the sensor to `ANY_ACTOR` admits an 18-turn no-push completion (3,263 visited states), eliminating exact crate necessity even though its unrestricted shortest metrics remain 14/1.

The focused test also proves no barrier or Door terrain bypass, ECHO cannot activate the YOU-only sensor, push/enter the crate, or complete EXIT, an illegal YOU push moves neither YOU nor crate, the crate stays on the sensor during ECHO crossing, and restart leaves no entity/state/history/completion residue.

## Iteration history

Pre-final authoring was bounded to the new candidate and its dedicated test/helpers. Early discarded layouts included an `L*=12` route whose no-crate and exclude-crate controls remained solvable, and an `L*=18` route outside the target band. The final single-entry crate-sensor lane plus isolated ECHO route reached the target without changing schema, Simulation, BFS, catalog, or production levels. A UID import scan created transient untracked UIDs for existing scripts; all those exact side effects were removed, the dedicated C02 UID was reviewed and retained, and Godot returned to zero before PRE_FINAL.

## Qualification and retained lifecycle

Focused qualifications `1c501269-c58d-4eac-b525-b67045ceb56a` and `2c24d494-a724-4c5c-8db2-04273fcdabde` passed in fresh processes. Matrix qualification `49ae9bb0-fbcb-4dd6-8166-d02e9ce458ea` passed Aggregate with exact marker `TASK_0003_TESTS_PASS assertions=621 vectors=9` and exact stderr `LEVEL_ID_MISMATCH`, then complete-v2 with `TASK_0024V_V2_COMPLETE_PASS` and empty stderr.

Manifest `92ba1407-b34c-4de8-aa81-c4da4978bdaa` was consumed exactly once. Fresh PowerShell workers durably wrote and reopened all three case records; the Python parent independently journaled them. Focused, Aggregate, and complete-v2 all passed. Cleanup ran exactly once per case; no owned or unproven PID remained; final Godot count was zero. The cycle is consumed and must never be repaired, rerun, replaced, or reconstructed.

## Presentation and protected boundaries

`presentation_status = MACHINE_CONTRACT_READY_OWNER_REVIEW_PENDING`. Existing schema-v2 minimum cues can represent the crate, eligibility, barrier, Plate, Door, ECHO, and state changes, but no owner session or final visual judgment occurred.

Production catalog remains eight entries, sequence 8 remains the sole formal finale, Profile was not accessed, DeepSeek was not invoked, and S01/0024AX remains closed pending GPT acceptance of this task.

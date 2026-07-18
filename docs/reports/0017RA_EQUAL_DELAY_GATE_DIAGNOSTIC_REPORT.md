# Task 0017RA equal-delay gate diagnostic report

- Status: `BRIDGE_EQUAL_DELAY_STRICT_GATE_RETAINED_READY_FOR_GPT_REVIEW`
- Selected policy: `A — PRESERVE STRICT GATE`
- Baseline bridge SHA-256: `805cdc05ea9b3805189ba7be4938cb7ede4e7056b9ae9a7e911df96a801d58ee`
- Existing Task 0017R blocker report preserved SHA-256: `095bb7c54e49f031a6ab9c7d173b67d159e781edea29483f11dec7e6c67ae249`
- External evidence: `D:\Delayed_Self_Evidence\0017RA_equal_delay_gate_adjudication\`

## Candidate and methods

The near candidate is the accepted bridge with only terrain cell `[5,4]` changed from `.` to `#`. It is `DIAGNOSTIC_ONLY_NOT_FORMAL`.

The corrected diagnostic validates every variant through the tracked LevelLoader, uses the tracked Simulation and Solver, and augments the canonical state with monotonic curriculum flags. It explores all accepted actions until the augmented queue is exhausted. No product path is written.

The first external attempt exited 1 on a strict GDScript type-inference parse error. The corrected augmented run and the trace run both exited 0 with empty stderr. The successful augmented search took longer than the foreground command timeout but completed normally in the retained Godot process and wrote its atomic result.

## Simulation proof

`echo_history_index_for_state` depends only on history size and delay. Equal-delay actors therefore receive the same action. Because they share a position and `_destination` uses the same terrain and start-of-turn closed-Door snapshot, they settle identically. Induction preserves overlap for every reachable transition. `pressed_plate_ids` deduplicates occupied cells, so overlapped ECHOs cannot press distinct A/B cells.

The complete runtime searches observed no overlap-invariant violation.

## Exact diagnostics

| Variant | Solve status | L* | N* | Visited | Frontier |
|---|---|---:|---:|---:|---:|
| Actual 2/4 near candidate | solved | 14 | 7 EXACT | 9,683 | 2,362 |
| Equal 2/2 | complete unsolved | — | — | 175 | 45 |
| Equal 4/4 | complete unsolved | — | — | 4,375 | 1,125 |

The actual candidate's complete augmented search visited 441,222 states, maximum frontier 31,886. Results:

1. `any_completion_without_spacing_event = false`;
2. `any_completion_without_intended_crossing = true`;
3. `any_completion_with_you_substitution = true`;
4. `any_completion_realizes_intended_chain = false` under the required no-substitution class.

The shortest 14-input witness opens A+B at turn 7 with YOU on Plate A, later forms the separated ECHO state with YOU free at turn 12, enters the Door at turn 13, and completes at turn 14. A separate 14-input completed witness reaches the goal without satisfying the tracked intended-crossing chain. Both contain a true mixed `BLOCKED/MOVED` spacing event.

For 2/2, the complete augmented search is 175 states / frontier 45 and has no completion class. For 4/4, it is 8,724 augmented states / frontier 1,127 and has no completion class. There are therefore no shortest role states or solution classes to characterize for either equal-delay control.

## Correction of the parent diagnostic

The preserved uncommitted Task 0017R blocker report stated that the near candidate's equal-delay controls solved. That report is committed byte-for-byte as required, but its equal-delay interpretation is superseded here. The current task reconstructs and validates each changed-delay dictionary through LevelLoader before search; the resulting controls exhaust unsolved. This correction does not rescue the candidate because its actual 2/4 completion classes violate the direct YOU-free curriculum gate.

## Policy evaluation

- **A — preserve strict gate:** selected. The candidate violates a direct curriculum gate, and both normalized equal-delay controls already satisfy the strict proxy.
- **B — direct gate replacement:** rejected. Policy B requires all three actual-candidate augmented necessity searches to be complete-negative; two fail.
- **C — Help-only:** rejected. Evidence does not prove geometry simplification is fundamentally incompatible, only that the near candidate is unsuitable.

## Scope and artifacts

Created the adjudication and this report; updated only minimum CURRENT documentation. The existing `docs/reports/0017R_BRIDGE_CURRICULUM_REPAIR_REPORT.md` was preserved byte-for-byte. No product, formal level, catalog, source, test, schema, scene, project setting, asset, persistence, build, export, or release path changed.

External artifact hashes and commands are recorded in `EVIDENCE_INDEX.md`; nothing external enters Git.

## Non-claims

This is a design-gate adjudication, not bridge implementation, Help repair, owner evidence, curriculum closure, finale acceptance, candidate readiness, export, release, or submission readiness.

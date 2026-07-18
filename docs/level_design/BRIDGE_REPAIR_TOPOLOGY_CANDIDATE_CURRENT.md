# Bridge repair topology candidate (CURRENT)

- Status: `BLOCKED_NO_BOUNDED_STRICT_GATE_CANDIDATE`
- Task: `tasks/0017RB_bridge_topology_search_and_candidate_selection.md`
- Selected candidate: none
- Product/formal level change: none
- Accepted bridge SHA-256: `805cdc05ea9b3805189ba7be4938cb7ede4e7056b9ae9a7e911df96a801d58ee`

## Selection disposition

The bounded search generated 32 deterministic raw candidates, screened all 32 with the tracked normal solver, ran the complete strict controls on six normal-band survivors, and completed augmented finite-state proof for the four strict survivors. No candidate passed every direct curriculum gate, so no replacement candidate is selected.

| Stage | Task limit | Used | Survived |
|---|---:|---:|---:|
| A structural generation | 512 | 32 | 32 |
| B normal solver | 32 | 32 | 6 |
| C strict controls | 10 | 6 | 4 |
| D augmented proof | 4 | 4 | 0 |

The six Stage-B survivors all had `L*=14`, `N*=7 EXACT`, visited states from 9,683 to 10,308, frontier 2,362, and a no-WAIT witness. Two were rejected before strict search because their added cells formed disconnected unused floor components.

## Complete Stage-D result

| Candidate | Added floor | Augmented states | Frontier | No spacing bypass | No intended-chain bypass | No YOU substitution | No reversed roles |
|---|---|---:|---:|---|---|---|---|
| `baseline_016` | `[5,1]` | 644,077 | 39,044 | pass | fail | fail | fail |
| `baseline_004` | `[4,4]` | 716,216 | 47,631 | pass | fail | fail | fail |
| `baseline_007` | `[3,4]` | 736,156 | 43,962 | pass | fail | fail | fail |
| `baseline_019` | `[2,5]` | 914,956 | 56,657 | pass | fail | fail | fail |

Every completed class in every candidate includes a true mixed `BLOCKED/MOVED` spacing change. However, each candidate admits a completed route without the required E2-on-A/E4-on-B following-snapshot crossing, a completed route using YOU substitution at an A+B-open result, and a completed route with reversed E2/E4 Plate roles.

The four candidates pass complete-unsolved no-ECHO, E2-only, E4-only, equal 2/2, and equal 4/4 controls. That proxy success does not override the failed complete direct curriculum gates.

## Comparison and consequence

The rejected `[5,4]`-closed near candidate has `L*=14`, `N*=7 EXACT`, 9,683 visited, frontier 2,362, and the same direct curriculum failure. The Stage-D candidates add one floor cell and increase reachable/augmented burden without distinguishing themselves at the required lesson gate.

Because no Stage-D survivor exists, curriculum/recovery ranking and later implementation-surface authorization do not activate. The formal bridge, Gameplay Help, Timeline, tests, catalog, progression, and `two_echo_convergence` remain unchanged. GPT must provide a fresh bounded design direction before topology search or implementation resumes. Finale planning remains blocked.

# Task 0019A finale band reconciliation report

- Task: `tasks/0019A_finale_candidate_band_reconciliation_and_fallback_adjudication.md`
- Continued by: `tasks/0019B_b007_fixed_candidate_complete_proof_continuation.md`
- Result after final continuation: `FINALE_SCOPE_REASSESSMENT_REQUIRED_FOR_GPT_REVIEW`
- Product paths changed: none

## Candidate-A reconciliation

The frozen Task 0019 ledger contained 32 structurally valid Stage-B candidates.
Ledger fields, candidate hashes, raw solver JSON, and stderr agreed with zero
mismatches. Status distribution was:

```text
SOLVED exact = 8
UNSOLVABLE_WITHIN_COMPLETE_FINITE_STATE = 13
TIME_LIMIT = 11
PLAN_BAND survivors = 0
NARROW_BAND survivors = 0
```

For the eight exact solves:

| Metric | Min | Q1 | Median | Q3 | Max | Distinct |
|---|---:|---:|---:|---:|---:|---:|
| L* | 10 | 11 | 11.5 | 13 | 15 | 5 |
| N* | 2 | 12 | 31.5 | 60 | 114 | 7 |
| visited | 8,376 | 10,825.75 | 35,338.5 | 63,793 | 112,937 | 8 |
| frontier | 3,315 | 4,046.25 | 15,908 | 21,506 | 43,265 | 8 |

PLAN_BAND rejection masks were: unavailable L*/N* plus solver status 17;
unavailable L*/N*, frontier, and solver status 7; L*+N* 3; L*+N*+visited
2; L* 2; and L*+visited 1. NARROW_BAND rejection masks were: unavailable
L*/N* plus solver status 12; unavailable L*/N*, frontier, and solver status
10; unavailable L*/N*, visited, and solver status 2; L*+N* 4;
L*+N*+visited 2; L*+N*+frontier 1; and L*+visited 1.

Nearest PLAN_BAND IDs were 48, 50, 3, 69, 62, 63, 27, and 49. The
lower-operational-burden Pareto IDs were 3 and 69. Neither diagnostic list was
treated as acceptance.

## Fallback-B pilot and B007

The pilot used 7/16 structural, 7/8 normal-solver, 1/3 strict-control, and 1/1
augmented-proof slots. Three candidates met PLAN_BAND metrics: B003 was
automatic/ceremonial at the final stage, B006 required a repeated blocked-input
phase macro, and B007 alone advanced.

`B007` SHA-256 is
`2e4cd14ba50bbbd5d3eb223bc82a35f17cc8b5a7e95d1b79c9fef5a37fa21325`.
It solved at `23 / 3 EXACT / 77,848 / 23,861`. No-ECHO, E2-only,
E4-only, equal 2/2, and equal 4/4 controls exhausted complete-unsolved at
`14/4`, `350/105`, `8,750/2,625`, `350/105`, and `8,750/2,625`
visited/frontier. Replay, restart, entity distinction, D1/D2 articulations,
and distances A-to-D1 2, B-to-D1 3, S-to-D2 3 passed.

The Task 0019A augmented attempt stopped at 180,000 ms with 665,338 visited
states and frontier 143,810. Task 0019B then made the one GPT-authorized final
attempt with the same 2,000,000-state ceiling and 900-second wall-time ceiling.
It reached `STATE_LIMIT` at 668,807 ms, 2,000,004 visited states, and frontier
201,872 without exhaustion.

## Disposition

The exact Task 0019B policy selects:

```text
C1 — SCOPE_REASSESSMENT
```

No candidate has a complete augmented proof. A later GPT planning task must
choose between reducing the sequence-9 grammar and retaining sequence 8 as the
final level. No further resource expansion, candidate generation, candidate C,
fallback activation, or product implementation is authorized.

External evidence:

- `D:\Delayed_Self_Evidence\0019_signal_convergence_finale\`
- `D:\Delayed_Self_Evidence\0019A_finale_band_reconciliation\`
- `D:\Delayed_Self_Evidence\0019B_b007_complete_proof\`

# Signal Convergence candidate adjudication (CURRENT)

- Tasks: `0019`, `0019A`, `0019B`
- Status: `FINALE_SCOPE_REASSESSMENT_REQUIRED_FOR_GPT_REVIEW`
- Current disposition: `C1 — SCOPE_REASSESSMENT`
- Formal candidate: none
- Product baseline: eight levels; `two_echo_convergence` remains sequence 8 and the sole final level

## Immutable bands and candidate-A result

```text
PLAN_BAND:   L*=21–30 / N*=1–12 EXACT / visited=20,000–300,000 / frontier=2,000–50,000
NARROW_BAND: L*=22–28 / N*=1–8  EXACT / visited=30,000–250,000 / frontier=3,000–40,000
```

All 32 frozen candidate-A Stage-B definitions were reconciled against their raw
solver artifacts with zero ledger mismatches. Results were 8 exact solved, 13
complete-unsolved, and 11 time-limited. No candidate passed either band.

PLAN_BAND individual rejection counts were L* 32, N* 29, visited 3, and
frontier 7. NARROW_BAND counts were L* 32, N* 31, visited 5, and frontier 11.
The nearest and Pareto diagnostics were not treated as acceptance.

## Fixed fallback-B candidate B007

The bounded fallback pilot retained only external candidate `B007` for complete
proof:

```text
candidate SHA-256 = 2e4cd14ba50bbbd5d3eb223bc82a35f17cc8b5a7e95d1b79c9fef5a37fa21325
board = 10x8
dependency order = A+B Door first, single-Plate Door final
L* = 23
N* = 3 EXACT
visited = 77,848
maximum frontier = 23,861
```

Task 0019B reproduced the exact witness, restart, normal metrics, five
complete-unsolved controls, pairwise-distinct static entities, both Door
articulations, and Plate-to-Door distances. The selected witness maps E2 to A
and E4 to B, crosses D1 from the following open snapshot, later uses E2 on S,
crosses D2 from the following open snapshot, and completes with YOU.

## Final proof result and decision

The sole final augmented proof kept the 2,000,000-state ceiling and extended
only wall time from 180 to 900 seconds. It stopped at:

```text
status = STATE_LIMIT
elapsed_ms = 668,807
visited_states = 2,000,004
maximum_frontier = 201,872
```

The augmented reachable space was not exhausted. Therefore no direct-gate
class, including ordered-chain necessity, early-S exclusion, YOU substitution,
reverse roles, Door bypass, or all-shortest compliance, is proved pass or fail.
`B007` remains external and is not `DIAGNOSTIC_SELECTED_NOT_FORMAL`.

Task 0019B requires C1 after either frozen ceiling is reached. Recommend a new
GPT planning decision between reducing the sequence-9 grammar and retaining
sequence 8 as the final level. This document does not choose between them.

## Boundary and rollback

No formal finale, catalog migration, product source, test, schema, scene,
setting, Help, Timeline, localization, persistence, build, export, release, or
submission change exists. Candidate A search is closed, fallback B is not
activated, candidate C is unauthorized, and another proof expansion is
forbidden. Repository rollback is removal of the Task 0019A/0019B
documentation-only commit; external evidence remains diagnostic.

# Task 0019B B007 complete-proof report

- Task: `tasks/0019B_b007_fixed_candidate_complete_proof_continuation.md`
- Gate: `FIXED EXTERNAL CANDIDATE / FINAL COMPLETE AUGMENTED PROOF`
- Verdict: `FINALE_SCOPE_REASSESSMENT_REQUIRED_FOR_GPT_REVIEW`
- Disposition: `C1 — SCOPE_REASSESSMENT`
- Product paths changed: none

## Candidate identity gate

The exact retained B007 JSON reproduced SHA-256
`2e4cd14ba50bbbd5d3eb223bc82a35f17cc8b5a7e95d1b79c9fef5a37fa21325`.
It is a 10x8 fallback-B candidate with A+B/D1 first and S/D2 final. Static
entities are pairwise distinct and both Doors are terrain articulations.

Normal solver reproduction:

```text
status = SOLVED
L* = 23
N* = 3 EXACT
visited_states = 77,848
maximum_frontier = 23,861
witness replay = completed
restart = exact
```

Witness:

```text
RIGHT RIGHT RIGHT RIGHT RIGHT RIGHT
UP UP UP LEFT RIGHT DOWN DOWN DOWN
UP UP LEFT UP RIGHT RIGHT UP RIGHT UP
```

The witness produces E2-on-A/E4-on-B, crosses D1 on the following input, later
places E2 on S, enters D2 from its following open snapshot, and reaches EXIT
with YOU. It contains no repeated blocked-input macro.

All five Stage-C controls reproduced complete-unsolved:

| Control | Visited | Frontier |
|---|---:|---:|
| no ECHO | 14 | 4 |
| E2 only | 350 | 105 |
| E4 only | 8,750 | 2,625 |
| delays 2/2 | 350 | 105 |
| delays 4/4 | 8,750 | 2,625 |

Distances reproduced as A-to-D1 2, B-to-D1 3, and S-to-D2 3.

## Final bounded proof

The retained reference harness and canonical Simulation transition were used.
Only `AUGMENTED_TIME_LIMIT_MS` changed from 180,000 to the authorized 900,000;
the state ceiling, action order, event masks, candidate, and normal limits
remained unchanged. No optimized representation was necessary, so no
raw/compact substitution or transition cross-check was performed.

```text
augmented_state_limit = 2,000,000
wall_time_limit_ms = 900,000
status = STATE_LIMIT
elapsed_ms = 668,807
visited_states = 2,000,004
maximum_frontier = 201,872
stderr = empty
```

The retained harness checks the ceiling at the loop boundary; one expansion can
insert up to five successors, explaining the four-state reporting overshoot.
The frozen state ceiling was reached before exhaustion.

## Direct gates and structural audit

All direct-gate class results remain `UNVERIFIED` because complete exhaustion
did not occur:

- completion without the opening A+B chain: unverified;
- useful S before A+B crossing/enabling: unverified;
- completion with YOU substitution: unverified;
- completion with reverse E2/E4 mapping: unverified;
- completion bypassing either Door articulation: unverified;
- all shortest completions containing the ordered B chain: unverified.

The retained limit output does not serialize non-exhaustive partial class
counts; no partial observation is promoted to a pass or failure claim.
Section 9 differentiation/recovery/observability acceptance audit was correctly
not run because it is conditional on complete direct-gate passage.

## Decision and boundaries

Task 0019B mandates scope reassessment whenever either frozen ceiling is
reached without exhaustion and forbids another expansion. B007 is not selected,
fallback B is not activated, and no product implementation follows.

Recommend a fresh GPT planning choice between reducing the sequence-9 grammar
and retaining sequence 8 as the final level. This report does not decide which
option wins.

External evidence root:

```text
D:\Delayed_Self_Evidence\0019B_b007_complete_proof\
```

The evidence index records commands, limits, outputs, event-policy provenance,
artifact hashes, and the unchanged prior-evidence boundary. No formal level,
catalog, source, tests, schema, scene, setting, Help, Timeline, localization,
persistence, build, export, release, or submission surface changed.

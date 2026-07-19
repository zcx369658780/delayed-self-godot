# Task 0019A GPT B007 proof-limit adjudication

- Reviewed terminal verdict: `BLOCKED_FINALE_PROOF_LIMIT`
- Repository checkpoint: `2ea16a4550513c04e184d7cb9d8b912eced05028`
- Verdict: `TASK_0019A_BLOCKER_ACCEPTED_B007_FIXED_CANDIDATE_PROOF_CONTINUATION_REQUIRED`
- Candidate A disposition: no `PLAN_BAND` survivor
- Candidate B disposition: `B007` is the sole proof-pending fallback candidate
- Product change: none

## Accepted evidence

Task 0019A reconciled all 32 candidate-A Stage-B results and found zero survivors under both the accepted Task 0018 `PLAN_BAND` and the narrower Task 0019 band. Candidate A therefore has no remaining candidate under the authorized ledger.

The bounded fallback-B pilot produced three `PLAN_BAND` results. Only `B007` advanced to Stage C. Its frozen normal metrics are:

```text
L* = 23
N* = 3 EXACT
visited_states = 77,848
maximum_frontier = 23,861
```

`B007` passed all five complete-unsolved controls (`no-ECHO`, `E2-only`, `E4-only`, equal `2/2`, equal `4/4`) and both Door-articulation checks. It is therefore materially stronger than an ordinary metric survivor.

The Stage-D run stopped at the authorized 180-second wall-time ceiling after visiting 665,338 augmented states with frontier 143,810. The reachable augmented space was not exhausted. This is an unverified resource-limit result, not evidence that the candidate passes or fails the direct two-stage curriculum gates.

## Adjudication

Do not activate fallback B and do not implement `B007` yet. Complete proof remains mandatory.

Do not select disposition C1 yet either. Task 0019A identified one candidate that passed every gate preceding complete augmented exhaustion. A single fixed-candidate proof continuation is proportionate before reducing or omitting sequence 9.

Authorize one final external proof attempt for exact retained candidate `B007` only:

```text
augmented_state_limit = 2,000,000
wall_time_limit = 900 seconds
candidate search/regeneration = forbidden
normal metrics and Stage-C controls = frozen and must reproduce
```

The state ceiling remains unchanged from Task 0019A; only wall time is extended to match the observed throughput. The proof implementation may use a more compact external representation, but it must preserve the tracked Simulation transition contract and cross-check canonical/event classifications against the retained Task 0019A harness before relying on optimized output.

## Final decision policy

This continuation is the final proof attempt for the current three-Plate/two-Door finale grammar.

- If the augmented space exhausts and every direct B-chain gate passes, record `B007` as `DIAGNOSTIC_SELECTED_NOT_FORMAL` and recommend explicit fallback-B activation in a later implementation task.
- If the space exhausts and any bypass, YOU substitution, reverse-role class, Door bypass, early-final-stage class, or ordered-chain violation exists, select scope reassessment.
- If 2,000,000 states or 900 seconds is reached without exhaustion, select scope reassessment rather than requesting another proof-limit expansion.
- Any mismatch in candidate definition, normal metrics, strict controls, tracked transitions, or retained evidence is a blocker and must not be repaired by changing product files.

## Boundaries

No formal level, catalog, source, test, schema, scene, setting, Help, Timeline, persistence, build, export, release, or submission change is authorized. Candidate B remains external. Candidate C remains unauthorized. Existing sequence 8 remains the sole final level.

This adjudication is not candidate acceptance, finale acceptance, owner evidence, production readiness, export readiness, release readiness, or submission readiness.

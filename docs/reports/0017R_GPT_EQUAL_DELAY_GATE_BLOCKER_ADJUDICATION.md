# Task 0017R equal-delay gate blocker adjudication

- Reported status: `BLOCKED_NO_BOUNDED_GEOMETRY_CANDIDATE`
- Parent task: `tasks/0017R_bridge_curriculum_geometry_and_help_repair.md`
- Accepted baseline bridge SHA-256: `805cdc05ea9b3805189ba7be4938cb7ede4e7056b9ae9a7e911df96a801d58ee`
- GPT verdict: `TASK_0017R_BLOCKER_ACCEPTED_EQUAL_DELAY_GATE_REQUIRES_ADJUDICATION`

## Adjudication

The stop is accepted. Task 0017R required no-ECHO, E2-only, E4-only, equal-delay 2/2, and equal-delay 4/4 controls all to exhaust unsolved. No bounded candidate satisfied every gate, and the near candidate was correctly not written into product data.

The reported near candidate is nevertheless material diagnostic evidence: `L*=14`, `N*=7 EXACT`, 9,683 visited states, frontier 2,362, with no-ECHO/E2-only/E4-only complete-unsolved. Its equal-delay variants remain solvable, so it cannot be accepted under the current contract.

## Gate question

The strict equal-delay-unsolved control is an indirect proxy for the intended lesson. The product goal is more directly expressed as:

1. the actual level cannot complete without a post-activation spacing-changing `BLOCKED/MOVED` event;
2. the actual level cannot complete without two separated ECHOs holding A+B while YOU remains free for the following open-snapshot crossing;
3. equal-delay shared-spawn ECHOs cannot realize that intended three-role chain, even if a counterfactual equal-delay level remains solvable through a different YOU-substitution route.

This possible revision must not be assumed. It requires complete finite-state augmented searches and an explicit design decision.

## Boundary

No product, formal level, Help, test, catalog, Simulation, solver, schema, scene, or project-setting change is authorized. The current accepted bridge remains the rollback baseline. Finale planning remains blocked.

A new planning/diagnostic task may inspect the external near candidate, characterize every equal-delay solution class relevant to the teaching chain, and choose exactly one future gate policy. It may not implement the candidate.

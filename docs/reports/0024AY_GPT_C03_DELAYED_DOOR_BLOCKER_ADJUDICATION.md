# GPT adjudication — Task 0024AY C03 delayed-door blocker

- Reviewed result commit: `a41915df8c4b3aca73ff3a6d90bac9dbca869909`
- Codex verdict: `BLOCKED`
- GPT adjudication: `TASK_0024AY_BLOCKER_ACCEPTED_CONTRACT_RECONCILIATION_RETRY_AUTHORIZED`

## Accepted facts

Task 0024AY stopped correctly before PRE_FINAL. The best discarded layout was solved at `L*=15`, exact `N*=14`, but only `2/14` shortest completions contained the eight-event mask that required an intentional same-turn failed Door input; `12` shortest paths omitted that input. No candidate or focused test was retained, no manifest was created, Aggregate/complete-v2 were not run, and no protected surface changed.

## Root-cause adjudication

The evidence does not show that the C03 crate-phase/next-turn-Door concept is infeasible. The twelve omitted paths still preserve crate push, ECHO crate block, useful phase shift, Plate entry, subsequent Door crossing and YOU completion. They replace an intentional failed input with an equal-budget positioning action.

Requiring every optimal solution to spend an input colliding with a closed Door is stricter than the accepted simulation lesson. The product-relevant rule is temporal separation:

1. Door is closed at the start of the transition where ECHO first enters the Plate;
2. Door becomes open only after that transition resolves;
3. YOU does not cross the Door on that Plate-entry transition;
4. YOU crosses only on a later transition whose start snapshot already has the Door open.

A blocked-input trace remains useful as an independent diagnostic probe, but it is not required in every shortest solution.

## Decision

- Preserve Task 0024AY as immutable blocked evidence.
- Do not reconstruct its discarded candidate or create a retroactive manifest.
- Authorize exactly one bounded continuation task, `0024AYR`, to reconcile the event contract and retry C03.
- Keep crate push, ECHO crate block/phase shift, ECHO Plate occupancy, next-turn Door opening, later YOU crossing and YOU-only EXIT mandatory in every shortest completion.
- Require one separate reachable shared-Simulation diagnostic trace proving that a same-turn Door attempt is blocked under the start-snapshot rule.
- If 0024AYR cannot pass within the existing solver budgets and bounded iteration limit, cut C03 from Phase 1 and proceed to S03 only under a new GPT decision.

## Preserved boundaries

Production catalog remains eight levels; sequence 8 remains the formal finale. C03 remains uncatalogued, unsequenced and owner-unreviewed. Profile, schema, Simulation, solver, Aggregate, scenes, build/release/submission and DeepSeek routing remain unchanged. S03/0024AZ is not authorized by this adjudication.
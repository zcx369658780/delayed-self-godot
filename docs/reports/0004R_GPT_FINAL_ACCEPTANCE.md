# Task 0004R GPT final acceptance

- Verdict: `TASK_0004R_UX_REPAIR_ACCEPTED_PENDING_USER_RETEST`
- Accepted commit: `caeff311fda77b0261a7d78672afb9244ff23549`
- Accepted task: `tasks/0004R_fix_exit_objective_and_echo_readability.md`
- Acceptance date: 2026-07-14
- Accepted by: GPT Project Sources advisor

## Review basis

GitHub review confirmed that the implementation is exactly one commit ahead of the Task 0004R issue point and changes exactly the twelve authorized source, scene, test, review, report, and current-document paths. The formal level, schema, normative vectors, loader, BFS solver, project settings, renderer, viewport, controls, plugins, dependencies, assets, export surfaces, saves, builds, and release surfaces were not changed.

The repair directly maps each accepted Task 0004 finding to a bounded presentation change:

1. The persistent objective now states that `YOU` must enter `EXIT`, that `ECHO` cannot finish, and that `ECHO` should hold `PLATE` so `YOU` can cross `DOOR`.
2. `EXIT` is now a persistent blue diamond/target frame with a visible label redrawn after actors, preventing the purple echo from erasing destination identity.
3. `YOU`, `ECHO`, `PLATE`, `DOOR`, and `EXIT` are explicitly named in the visible legend, with actor `Y`/`E` markers.
4. The HUD exposes `Echo next: <ACTION>` through one pure `echo_action_for_state` query also used by the accepted transition, avoiding duplicated history indexing.
5. Completion presents a prominent `COMPLETE — YOU reached EXIT` state with restart guidance.

## Accepted regression evidence

The repository report records:

- baseline before repair: 128 assertions, 9/9 vectors;
- final after repair: 135 assertions, 9/9 vectors;
- unchanged solver result: `SOLVED`, `L*=9`, `N*=31 (EXACT)`, 1,318 visited states;
- unchanged echo-isolated result: `UNSOLVABLE_WITHIN_COMPLETE_FINITE_STATE`, 1,006 visited states;
- successful bounded main-scene launch;
- external 960×540 screenshots for initial, echo-on-exit, and completed states, with hashes and privacy-bounded evidence indexing.

The implementation code confirms that the exit overlay is drawn after actors, the objective/legend/next-action/completion copy is explicit, and the pure echo-action query derives from the same accepted history semantics used during transition.

## Accepted claims

For commit `caeff311fda77b0261a7d78672afb9244ff23549`, the following are accepted:

1. The specified P1/P2 defects have targeted implementation repairs.
2. The accepted `simulation_v1`, `level_v1`, formal level semantics, normative vectors, shortest-path result, and echo-necessity result remain unchanged.
3. Automated tests cover the required objective, entity terms, next-action behavior, restart state, completion copy, and scene instantiation.
4. The repaired presentation can render a persistent EXIT identity even when ECHO occupies the exit cell.
5. No third-party asset, plugin, dependency, save, menu, export, build, release, Web, or submission surface was introduced.

## Non-claims

This acceptance does not establish:

- that the authenticated user has successfully completed the repaired puzzle;
- that a fresh first-time player will understand the mechanic;
- independent visual or accessibility acceptance;
- final art quality;
- Windows export or clean-machine execution;
- Web, save, menu, settings, audio, performance, release, or submission readiness.

The authenticated user has already learned the intended roles during the prior adjudication, so the next task is a targeted repair verification rather than a new blind first-player experiment. A later fresh-player or independent review may still be required before final tutorial/content acceptance.

## Next gate

`Task 0004V — targeted victory-condition and entity-readability user retest` is authorized. It must launch the accepted repaired commit, collect the user's direct observations, verify that the new objective/legend/EXIT/next-action/completion cues are visible and correct, and record whether the user can complete the puzzle without receiving a movement sequence. It must not modify the implementation. Any remaining P0/P1 issue requires a separate repair task; a positive targeted retest may permit Task 0005 system-skeleton and tutorial-level planning while retaining a future fresh-player review requirement.

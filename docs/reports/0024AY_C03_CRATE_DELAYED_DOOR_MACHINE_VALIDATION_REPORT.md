# Task 0024AY C03 crate-delayed-door machine-validation blocker report

## Verdict

`BLOCKED`.

C03 did not reach PRE_FINAL. No retained manifest was created or consumed; Aggregate and complete-v2 were not run. The uncatalogued candidate and its failing focused test were removed rather than retained as a machine-qualified level.

## Best discarded layout

The strongest bounded layout used one delay-2 ECHO, one crate, one Plate and one Door. Shared BFS returned `SOLVED`, `L*=15`, exact `N*=14`, 8,070 states, frontier 1,230 and 1,834 ms. One deterministic witness satisfied the complete required chain:

```text
DOWN RIGHT DOWN DOWN DOWN DOWN RIGHT RIGHT UP RIGHT UP RIGHT RIGHT UP UP
```

## Terminal blocker

Complete all-shortest enumeration used only shared `Simulation.transition` and a composite canonical key carrying the eight-event mask. It found exact completed paths `14`, full event mask `2/14`, omissions `12`, and 106,847 composite states. Full paths used exactly one consequential push and one ECHO-crate block.

Representative omission:

```text
DOWN RIGHT DOWN RIGHT DOWN DOWN RIGHT RIGHT UP RIGHT UP RIGHT RIGHT UP UP
```

This path preserves crate push, ECHO crate block, useful phase change and Plate entry. It exchanges “move adjacent, then intentionally collide with the closed Door” for an equal-budget history action followed by movement to adjacency on the Plate-entry transition. It crosses the already-open Door next turn and reaches EXIT in the same 15-turn optimum.

The task requires every shortest path to have the complete mask and zero omissions. It also forbids weakening tests and requires `BLOCKED` when that proof cannot pass. The exact `2/14` result is terminal for this execution.

## Iteration and lifecycle

Pre-final variants tested the inherited sequence-9 topology, Door positions `[2,5]`, `[2,4]` and `[2,3]`, ECHO delays 2 and 3, an opened resynchronization cell, and a one-turn Plate window. Rejections included missing same-turn Door attempt, absent crate-block chain, capped multiplicity, and the final exact omission set. Every launch used the accepted wrapper, cleanup once, no owned/unproven PID residue and final Godot zero.

- PRE_FINAL: not reached.
- Focused twice: not run.
- Aggregate and complete-v2: not run.
- 0024AY manifest: not created.
- retained cycle: not run.
- 0024AW/0024AX consumed manifests: not invoked or modified.
- Candidate/focused test: not retained.
- Catalog/Profile/scenes/schema/Simulation/solver/Aggregate/existing levels: unchanged.
- Production catalog: eight; formal finale: sequence 8.
- Profile accessed: no; DeepSeek invoked: no.

This is not a machine-validated candidate and not `PASS_FOR_GPT_REVIEW`. A new explicit GPT adjudication or redesigned task is required; S03/0024AZ remains closed.

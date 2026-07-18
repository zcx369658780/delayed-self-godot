# Task 0017D GPT bridge curriculum repair plan acceptance

- Reviewed commit: `b875bd2da2ace9ecc320132873e43d5d3ad8f961`
- Verdict: `TASK_0017D_BRIDGE_CURRICULUM_REPAIR_PLAN_ACCEPTED`
- Primary: `MINIMAL_BRIDGE_GEOMETRY_PLUS_CONTEXTUAL_CAUSAL_HELP`
- Fallback: `SIMPLIFIED_GEOMETRY_WITHOUT_HELP_CHANGE`
- Finale: `FINALE_PLANNING_BLOCKED_PENDING_REPAIR`

## Accepted diagnosis

The bridge remains mechanically correct and machine-valid. The owner independently completed its intended chain and understood blocker-driven spacing change and next-input Door entry. The defect is curriculum burden: the room combines useful phase discovery, role assignment, overshoot avoidance, YOU staging, and recovery in one step, while existing Help and Timeline did not support a credible experiment.

External prefix searches show selected states are machine-recoverable. They are diagnostic evidence only and must not become route or remaining-distance hints.

## Accepted implementation target

A later task may replace only `echo_spacing_bridge` geometry and add one manual, zero-turn contextual Help section. Preserve shared-spawn E2/E4 delays 2/4, two distinct Plates, one A+B Door, player-only EXIT, required early `BLOCKED/MOVED` spacing change, dual-ECHO necessity, fixed E2-on-A/E4-on-B shortest-solution roles, and following open-snapshot crossing.

Hard candidate bands:

```text
11 <= L* <= 14
4 <= N* <= 64
N* status = EXACT
1000 <= visited_states <= 12000
100 <= maximum_frontier <= 2500
meaningful decisions = 2–3
recoverable alternatives >= 3
```

## Help refinement

Planning copy is accepted semantically, not verbatim. Help may explain only:

- a closed Door or wall can block one ECHO while another moves, changing spacing;
- observe `MOVED/BLOCKED` and try a different route or loop;
- the two ECHOs must remain on separate A/B Plates while YOU stays free to cross after A+B opens;
- only YOU completes.

It must not disclose an action sequence, coordinates, turn number, target spacing, next input, exact E2/A–E4/B mapping, branch choice, screenshot route, solver output, remaining distance, or whether a state is solvable.

Do not trigger this section from the broad condition “multiple ECHOs plus A+B” alone. Use a stable data-derived predicate that includes `metadata.intended_mechanics` containing `echo_spacing_change` and the relevant multi-ECHO/two-Plate-AND structure. Tests must prove that byte-identical `two_echo_convergence` does not receive bridge-specific Help.

Timeline behavior and copy remain unchanged. Dotted-line reduction is outside this implementation.

## Proof boundary

A formal replacement requires a new SHA-256 and the complete Task 0017 proof family, including exact solve/count/replay/restart, all-shortest causal and role traces, complete no-ECHO/E2-only/E4-only controls, equal-delay and dependency controls, blocker/Plate relocation, Door removal, substitution, overlap, articulation, EXIT, progression, Level Select tail access, captures, aggregate regression, and preservation of the other seven formal levels.

Help requires focused trigger, copy, zero-turn, canonical-state, no-route, 960×540, grayscale, reduced-motion, and non-target-level tests.

Machine acceptance will not close the curriculum finding. A separate owner-only repair retest is required before finale planning.

## Fallback and stop conditions

Use `SIMPLIFIED_GEOMETRY_WITHOUT_HELP_CHANGE` only if focused evidence shows the contextual Help cannot remain readable and non-route. Stop if no bounded candidate preserves the causal and necessity gates, Help must become a walkthrough, or the repair requires schema, Simulation, solver, Timeline, catalog, new mechanics, or changes to existing levels.

This acceptance is not a repaired-level, owner, difficulty, balance, finale, export, release, or submission acceptance.

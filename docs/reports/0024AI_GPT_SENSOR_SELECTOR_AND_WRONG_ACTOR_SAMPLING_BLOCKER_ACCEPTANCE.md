# Task 0024AI GPT sensor-selector and wrong-actor sampling blocker acceptance

- Verdict: `TASK_0024AI_HONEST_SENSOR_SELECTOR_AND_WRONG_ACTOR_SAMPLING_BLOCKER_ACCEPTED_FRESH_SENSOR_GATE_REQUIRED`
- Result commit: `2df29272b4c1696063aae00ed8e796e28f4f5929`
- Classification: honest validation-harness blocker; no schema-v2 product acceptance

## Accepted facts

The four candidate Gameplay preflights passed using the exact `level_id` returned by public `LevelLoader` and the exact matching level path. All four configured successfully, became runtime-ready, emitted no `LEVEL_ID_MISMATCH`, and returned Gameplay snapshots equal to the pure presentation helper.

The wrapper record was complete and non-null. Native exit was `1` only because the focused validator retained seven failed assertions. Cleanup ran exactly once, no owned or unproven PID remained, and Godot returned to zero. No fresh retained-cycle manifest was declared or consumed. Historical Task 0024AF–0024AH artifacts remained byte-identical.

## Exact blocker

The validator selected sensors with the non-public variants `YOU_INACTIVE`, `ECHO_INACTIVE`, `YOU_ACTIVE`, and `ECHO_ACTIVE`. The presentation helper actually derives `state_variant` from the level's public `activator`, so the exact variants are `YOU_ONLY_INACTIVE`, `ECHO_ONLY_INACTIVE`, `YOU_ONLY_ACTIVE`, and `ECHO_ONLY_ACTIVE`. The four selector results were therefore empty even though the inventory and barrier lifecycle records were present.

The fixed action-9 wrong-actor assertion also required every sensor to be inactive. That is not the accepted identity-control contract: a correct actor may already activate one sensor while a wrong actor must leave only the mismatched sensor inactive. Wrong-actor evidence must be established through the accepted sequence-11 swapped-identity control or an equivalent bounded shared-Simulation control, not by assuming both sensors are inactive at one fixed witness turn.

## Boundary

This acceptance does not accept the minimum presentation, populate owner-review answers, admit candidates to the production catalog, or authorize finale/Profile/progression changes. A new task identity must preserve all Task 0024AI artifacts and complete exact sensor-state sampling before any fresh final cycle.
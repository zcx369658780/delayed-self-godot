# Task 0018 GPT Signal Convergence finale plan acceptance

- Reviewed commit: `2cd297e6ab5fda3596ba389af43537feed94d753`
- Verdict: `TASK_0018_SIGNAL_CONVERGENCE_FINALE_PLAN_ACCEPTED`
- Selected primary: `A — SINGLE_DOOR_FIRST_AND_DOOR_FINAL`
- Sole fallback: `B — AND_DOOR_FIRST_SINGLE_DOOR_FINAL`
- Implementation status: separately gated

## Accepted design

Prospective sequence 9 is frozen as:

```text
signal_convergence / Signal Convergence / 信号汇流
```

The accepted primary is a two-stage schema-v1 synthesis:

1. an ECHO-driven single-Plate result opens the first Door and creates necessary route access or phase;
2. after that causally enabling stage, E2 and E4 form the final A+B result while YOU remains free to enter the second Door from the following open snapshot and reach the player-only EXIT.

This is materially distinct from sequence 8 because A+B is the second dependency result of a required two-stage chain rather than the room's only dependency. It is distinct from Level 6 because the two Doors are not repeated independent single-Plate windows.

## Accepted prospective grammar

A later candidate must retain exactly one YOU, shared-spawn E2/E4 at delays 2/4, three distinct Plates, two initially closed Doors, one single-Plate dependency, one two-Plate A+B dependency, exactly two dependency stages, one player-only EXIT beyond the final Door, and a board no larger than 10×8.

No new mechanic, action, collision rule, latch, persistent Door, timer, switch, key, box, hazard, actor-owned Plate, route trigger, or goal rule is authorized.

## Implementation refinements

The implementation gate must narrow the quantitative authoring target before search and must not broaden it after seeing results. Candidate A alone is authorized. Candidate B requires a new GPT task after a documented candidate-A stop.

The first Door must be causally necessary, not a ceremonial corridor gate. Complete or appropriately augmented evidence must reject:

- completion without the first dependency stage;
- a useful A+B result before the first-stage enabling chain;
- final A+B completion through YOU substitution;
- terrain or Door bypass of either stage;
- accidental third-stage behavior;
- complexity produced only by distance, repeated collision, literal WAIT, or hidden route knowledge.

Every shortest solution must contain both open-result/following-input Door entries in order. The final stable role mapping must be measured and frozen by the selected candidate; it must not be disclosed in Help.

## Presentation and evidence boundary

Board geometry, Plate labels/shapes/pips, E2/E4 badges/outlines, Door state, and transition-derived outcomes remain primary. Timeline remains optional. Help remains manual, zero-turn, contextual, and non-route. No finale-specific Help or localized copy is authorized in the implementation task unless separately gated.

Future review remains:

```text
OWNER_ONLY_REVIEW
FRESH_INDEPENDENT_REVIEW_UNAVAILABLE_BY_OWNER_CONSTRAINT
```

No third-party reviewer may be sought, required, contacted, recruited, or suggested.

## Boundary

This acceptance authorizes a fresh bounded implementation-and-validation task for candidate A only. It does not establish a formal finale, measured metrics, owner acceptance, fresh/independent evidence, difficulty/fun acceptance, narrative production, localization, save/build/export, release, or submission readiness.

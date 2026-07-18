# Task 0017RA GPT equal-delay gate acceptance

- Reviewed commit: `efb628a18799689e4398da7bdc868682a5381e9a`
- Verdict: `TASK_0017RA_STRICT_EQUAL_DELAY_GATE_ACCEPTED`
- Selected policy: `A — PRESERVE STRICT GATE`
- Current accepted bridge SHA-256: `805cdc05ea9b3805189ba7be4938cb7ede4e7056b9ae9a7e911df96a801d58ee`
- Finale: `FINALE_PLANNING_BLOCKED_PENDING_BRIDGE_REPAIR`

## Accepted correction

The preserved Task 0017R blocker report stated that the `[5,4]`-closed near candidate's equal-delay controls solved. Task 0017RA correctly supersedes that interpretation. Each changed-delay dictionary was normalized through the tracked LevelLoader before search. The complete controls are:

```text
equal delay 2/2: UNSOLVABLE_WITHIN_COMPLETE_FINITE_STATE, visited 175, frontier 45
equal delay 4/4: UNSOLVABLE_WITHIN_COMPLETE_FINITE_STATE, visited 4,375, frontier 1,125
```

Shared-spawn equal-delay ECHOs receive the same history action, start each transition overlapped, and resolve against the same terrain and Door snapshot. They therefore remain overlapped by induction and cannot occupy two distinct Plate cells.

## Near-candidate disposition

The near candidate remains rejected despite `L*=14`, `N*=7 EXACT`, 9,683 visited states, frontier 2,362, and a required real spacing-change event.

Complete augmented search explored 441,222 states and found:

- no completion without a real spacing-changing mixed `BLOCKED/MOVED` event;
- at least one completion without the required intended crossing chain;
- YOU substitution in every completed augmented class;
- no completed no-substitution class realizing the intended E2-on-A, E4-on-B, YOU-free crossing chain.

The candidate therefore fails direct curriculum gates in addition to being unsuitable under the retained strict policy. It is not authorized for product use.

## Accepted policy

Future bridge geometry must satisfy both:

1. strict complete-unsolved controls for no-ECHO, E2-only, E4-only, equal 2/2, and equal 4/4 variants; and
2. complete augmented proof that the actual 2/4 room has no completion without the required spacing event, separated fixed-role A+B chain, and YOU-free open-snapshot crossing.

All negative claims require complete finite-state exhaustion. Resource-limited outcomes remain unverified.

## Next gate

A fresh task may run a larger but still bounded external topology search. It must not weaken the accepted metric, causal, necessity, direct curriculum, Help, or owner-retest requirements. Candidate selection is required before formal replacement or Gameplay Help implementation resumes.

This acceptance does not implement a repaired bridge, authorize owner retest or finale work, or establish difficulty, balance, export, release, or submission readiness.

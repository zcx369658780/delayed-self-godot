# Task 0014 GPT final acceptance

- Verdict: `TASK_0014_LEVEL_7_IMPLEMENTATION_PLAN_ACCEPTED`
- Accepted planning commit: `e964518172add3c36523a0989d5d1eab11740b33`
- Accepted task: `tasks/0014_level_7_two_echo_convergence_planning.md`
- Acceptance date: 2026-07-17
- Accepted by: GPT Project Sources advisor

## Review basis

GitHub review confirmed that the Task 0014 result is exactly one documentation-only commit ahead of the task publication point. It creates the implementation plan and planning report and updates only authorized current planning, startup, handoff, index, memory, roadmap, and presentation documents. No formal level, catalog JSON, runtime, solver, schema, scene, test, fixture, project setting, asset, audio, import, dependency, user-data, build, export, release, account, or submission surface changed.

Godot and the solver were correctly not run because this was a planning-only gate. All quantitative values in the plan remain prospective targets rather than implementation evidence.

## Accepted target

Task 0014 selects exactly one Level 7 implementation target:

```text
two_echo_convergence / Two Echo Convergence / 双影汇流
```

Frozen structure:

- one current player;
- exactly two shared-spawn, shared-history ECHOs;
- `echo_near` at delay 2;
- `echo_late` at delay 4;
- exactly two distinct Plates, `plate_a` and `plate_b`;
- exactly one initially closed combinational Door, `door_convergence`;
- exact dependency set `all_plate_ids=[plate_a, plate_b]` as an unordered AND-set;
- one player-only EXIT beyond the Door;
- exactly 9×7 geometry;
- a compact figure-eight/recovery topology feeding one visible convergence lane;
- the Door as an unavoidable terrain articulation;
- at least one necessary two-ECHO Plate-occupancy window of width 1–2 turns.

The selected concept adds a new temporal obligation—two replay offsets from one history converging simultaneously—without repeating Level 6's two serial Door-window grammar. It also preserves Level 8's proposed three-Plate, two-stage synthesis role.

## Accepted prospective gates

The implementation candidate must satisfy all hard target bands:

```text
17 <= L* <= 25
1 <= N* <= 8
N* status = EXACT
8000 <= visited_states <= 150000
1000 <= maximum_frontier <= 25000
required convergence window = 1–2 turns
meaningful decisions >= 4
audited recoverable wrong choices >= 3
```

Starting limits remain:

```text
depth_limit = 64
state_limit = 500000
time_limit_ms = 30000
solution_count_cap = 1000000
```

A timeout, depth/state limit, or count cap is not exact or complete evidence. The implementation task must re-author within bounded scope rather than weaken the frozen targets.

## Accepted proof obligations

The later implementation must establish, at minimum:

1. strict schema/catalog load, solve, witness replay, exact restart, metrics, limits, and formal SHA-256;
2. individual necessity of both delay-2 and delay-4 ECHOs;
3. no-ECHO/player-only complete-unsolved control;
4. both Plate-isolation controls;
5. A-only and B-only dependency replacements materially simplify or destroy the intended teaching structure;
6. equal-delay 2/2 and 4/4 controls materially change or destroy the two-offset obligation;
7. Plate-relocation, Door-removal, articulation, bypass, overlap, EXIT, and open-snapshot controls;
8. every accepted shortest solution uses the required A+B convergence and the following open start-turn Door snapshot;
9. at least four meaningful decisions and at least three bounded recovery traces;
10. all six prior formal hashes, accepted metrics, progression, reusable Gameplay behavior, and existing aggregate markers remain unchanged except for the authorized Level 7 additions.

Legal actor overlap must not allow one actor to satisfy two distinct Plate cells. If either ECHO cannot be proven individually necessary, or one actor/route bypasses the convergence, the candidate is rejected rather than accepted with caveats.

## Presentation decisions

Accepted Timeline disposition:

```text
TIMELINE_REMOVED_FROM_LEVEL_7_TEACHING_GOAL
```

Level 7 must be solvable through visible board state and learned replay rules without reverse-counting the Timeline. The inherited Timeline may remain optional and contract-derived, but no Timeline redesign is authorized or required by this acceptance.

Accepted Help disposition:

```text
HELP_CONTEXTUAL_OPTIONAL
```

Help may explain vocabulary and controls but must not reveal movement, route, branch choice, exact timing, occupancy schedule, or a solver witness. It cannot compensate for unreadable board state.

The implementation must add only the minimum reusable primitive cues required by the accepted plan:

- persistent A/B labels plus distinct Plate/Door-pip shapes;
- `A + B` Door dependency tokens with independently readable committed states;
- stable E2/E4 badges plus different persistent outlines;
- readable ECHO-overlap composition;
- supplementary color only, never color as the sole relationship cue;
- legibility at 960×540 and in grayscale.

These cues may be implemented through the existing reusable Gameplay presentation only. They do not authorize a general HUD, Timeline, Help, asset, font, audio, animation, scene-layout, or visual-system redesign.

## Gate adjudication

1. Task 0014 is accepted as an implementation-ready Level 7 plan.
2. Candidate A, AND convergence, is the only authorized Level 7 target.
3. Candidate B and Candidate C remain rejected planning alternatives and must not enter the catalog.
4. The plan resolves the Task 0013B findings appropriately: dependency identity becomes redundant and board-first; Timeline is not assumed useful; Help is optional and non-compensatory.
5. No planning repair is required before bounded implementation.
6. The next gate is one implementation and formal-validation task for exactly this selected target.

## Non-claims

This acceptance does not establish a created, schema-valid, solvable, replayable, difficult, fun, balanced, internally playable, fresh-reviewed, or candidate Level 7. It does not authorize Level 8, Timeline/Help redesign, narrative, assets, fonts, audio, animation, localization, persistence, Gate, export, release, or submission.

The owner-only review constraint remains durable. Any later Level 7 human review must be classified `AUTHENTICATED_OWNER_NOT_FRESH_NOT_INDEPENDENT_LEVEL_7_REVIEW`; `FRESH_INDEPENDENT_REVIEW_UNAVAILABLE_BY_OWNER_CONSTRAINT` remains a disclosed residual limitation.

## Next gate

Issue one bounded implementation task that may create one formal Level 7 JSON, append the seventh catalog entry and transfer the final flag, add focused validation/capture tests, implement only the accepted primitive A/B and E2/E4 cues through reusable Gameplay, synchronize exact evidence into current documents, and create one implementation report.

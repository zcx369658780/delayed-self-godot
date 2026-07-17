# Task 0015D GPT final acceptance

- Date: 2026-07-17
- Repository: `zcx369658780/delayed-self-godot`
- Accepted planning commit: `c348d5e7c42e892c15dcb5e3452e80d5d7d1fd39`
- Accepted task: `tasks/0015D_level_7_false_unsolvable_diagnostic_and_repair_planning.md`
- Verdict: `TASK_0015D_LEVEL_7_FALSE_UNSOLVABLE_REPAIR_PLAN_ACCEPTED`
- Selected repair bundle: `TRANSITION_DERIVED_ECHO_DIVERGENCE_FEEDBACK`
- Formal Level 7 baseline: `27a678da47d1ba34ed012f8840b8c80c775e8be1`
- Formal Level 7 SHA-256: `772410d3b8bb807e35472ee2a7d07b703de66e1e0e92ffb4d1ff8433a345d5fd`

## Review basis

The Task 0015D changeset is exactly one documentation-only commit after the task publication point. It creates the diagnostic report and repair plan and updates only authorized current Markdown sources. It does not modify Gameplay, simulation, solver, formal levels, catalog, schema, tests, scenes, project settings, Timeline, Help, assets, persistence, build, export, or release surfaces.

The diagnostic reused the accepted healthy aggregate evidence and ran a separate external, non-product diagnostic against the accepted Level 7 and shared Simulation. Level 7 remains machine-correct and internally playable with unchanged exact evidence:

```text
L* = 19
N* = 6 EXACT
visited_states = 61975
maximum_frontier = 21449
formal_sha256 = 772410d3b8bb807e35472ee2a7d07b703de66e1e0e92ffb4d1ff8433a345d5fd
```

The exact owner screenshot state was reconstructed and remains solvable. There is no machine, runtime, formal-data, or Git contradiction.

## Accepted causal diagnosis

The blocking owner finding is correctly classified as:

```text
BLOCKING_P2_FALSE_UNSOLVABLE_MENTAL_MODEL_AND_RECOVERY_FAILURE
```

The owner inferred that E2 and E4 retain a fixed two-step physical separation. The opening lane makes that belief plausible because both active ECHOs preserve the same two-cell vector for several turns. Existing presentation identifies actors and dependencies but does not explain the later transition outcomes that invalidate the fixed-spacing model.

The accepted trace distinguishes three facts:

1. spacing first changes when E2 becomes active before E4;
2. after the apparent invariant forms, different history slots change the signed vector;
3. the clearest causal event occurs when E2 is blocked while E4 moves, followed by different replay actions expanding the spacing to the required A/B offset.

The central reusable rule is therefore:

> E2 and E4 read different history slots. Their requested actions, prior positions, and terrain/blocking outcomes may differ, so their relative spacing can change.

The plan correctly avoids the false statement that both ECHOs necessarily receive the same action and settle differently.

## Accepted primary repair

The sole authorized primary direction is:

```text
TRANSITION_DERIVED_ECHO_DIVERGENCE_FEEDBACK
```

A later implementation may add short, reusable, presentation-only feedback derived from the already returned transition record:

- stable E2/E4 identity;
- actual replay action and `MOVED` or `BLOCKED` outcome;
- concise notification when signed or Manhattan spacing changes;
- a compact blocked/moved causal phrase when applicable;
- board-visible endpoint/trail reinforcement.

The feedback must not reveal target coordinates, required separation, Plate assignments, remaining moves, exact timing, next input, solver state, route, or witness. It must not run a solver, duplicate collision rules, or hardcode the Level 7 solution.

The current `scripts/gameplay/vertical_slice.gd` already receives `before`, `result.state`, and `result.actor_actions.echoes`, so this bundle is technically feasible without modifying Simulation or reproducing puzzle logic in presentation.

## Alternative dispositions

- geometry-only early divergence: accepted only as a separately authorized fallback after the primary repair and owner retest fail;
- contextual Help text: not selected because Help and a high-level explanation already failed to correct the model;
- solver/recoverability progress feedback: rejected because it risks route-specific or solver-like claims;
- delay 5, Plate relocation, or persistent Door: rejected as immediate repair because they alter formal design or semantics and may hide the actual comprehension problem;
- exact-operation walkthrough: rejected as the default because it teaches a route rather than the reusable causal model;
- push boxes: deferred new-mechanic scope;
- supplementary color: may remain supplementary but cannot solve the causal gap alone.

## Implementation boundary

The accepted primary implementation is limited to the minimum necessary subset of:

```text
scripts/gameplay/vertical_slice.gd
tests/gameplay/<focused transition-feedback test>.gd
tests/gameplay/<focused capture harness>.gd
tests/run_all.gd
docs/reports/<repair implementation report>.md
necessary current Markdown sources
```

It must preserve every formal level file, catalog, schema, Simulation, solver, scenes, project settings, Timeline model/index/layout, Help architecture/copy, assets, audio, persistence, build, export, release, and Level 8.

## Acceptance requirements carried forward

The repair must preserve all seven formal hashes and all accepted metrics, including Level 7 `L*=19`, `N*=6 EXACT`, visited `61975`, and frontier `21449`. Tests must cover stable spacing, ordinary spacing change, overlap-to-separation, moved/blocked divergence, restart reset, direct launch, completion, and no-cue states. Captures must verify 960×540 and grayscale readability without obscuring actors, dependencies, Door, EXIT, HUD, or completion feedback.

After machine and capture acceptance, the owner-only retest must determine whether the owner now understands that different history slots and terrain outcomes can change ECHO spacing. Unassisted completion is preferred; an incomplete attempt may still materially reduce the blocker only if the owner no longer judges the level mathematically impossible and can propose a credible experiment or recovery strategy.

## Gate adjudication

1. Task 0015D is accepted.
2. Level 7 remains GPT accepted at `INTERNAL_PLAYABLE`; its formal data and machine evidence remain unchanged.
3. The owner Level 7 result remains non-promotion with one blocking P2.
4. One bounded presentation-only repair is authorized as the next gate.
5. Geometry re-authoring remains fallback-only and requires a new task plus complete formal revalidation.
6. Level 8 remains blocked until the primary repair and owner-only retest close or materially reduce the blocking P2.
7. Fresh/independent review remains unavailable by owner constraint and is not claimed.

## Non-claims

This acceptance does not establish a completed repair, owner acceptance, human difficulty, fun, balance, `FRESH_PLAYER_REVIEWED`, `CANDIDATE_ACCEPTED`, final Timeline/Help disposition, Level 8 authority, final presentation, assets/audio/narrative, complete flow, export, release, or submission readiness.

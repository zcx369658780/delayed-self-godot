# Task 0004 GPT first-player evidence adjudication

- Verdict: `FIRST_PLAYER_REVIEW_RECORDED_P1_REPAIR_REQUIRED`
- Reviewed implementation commit: `14180dc3e110607d4abdee5f8bf314a58f62fb39`
- Source task: `tasks/0004_first_player_ux_and_visual_readability_review.md`
- Evidence date: 2026-07-14
- Reviewer: authenticated project owner/user
- Adjudicator: GPT Project Sources advisor

## Evidence received

The user supplied a screenshot of the running Godot debug window and the following direct feedback in Chinese:

> 影子是紫色圆，玩家控制白色圆，按下机关时可以开门让影子过去。
>
> 验收通过，游戏玩法可行，不过目前没找到胜利条件。

The screenshot visibly records:

- `Turn: 77`;
- `Echo delay: 3`;
- `Door: OPEN`;
- the white/cyan current player occupying the pressure plate;
- the purple echo occupying the exit cell and visually covering most of the blue circular exit marker;
- the level not completed.

The user ended the playtest without finding the victory condition. This is recorded as `PLAYTEST_ENDED_NOT_COMPLETED`; elapsed time, restart count, and the fixed numeric ratings were not supplied and must not be invented.

## Positive evidence

1. The user correctly distinguished the white/cyan controllable player from the purple echo.
2. The user understood that occupying the pressure plate changes the door to an open state.
3. The user judged the core gameplay idea to be feasible/playable.
4. No crash or runtime defect was reported in this playtest.

## P1 findings

### P1-1 — Victory condition is not discoverable

The user did not identify that only the current white/cyan player can complete the level by entering the exit. At turn 77 the playtest still had no understood completion route. A valid solver result does not mitigate this first-player comprehension failure.

Required repair direction:

- state the objective explicitly in the play HUD;
- state that the purple echo cannot finish the level;
- make completion feedback visually prominent.

### P1-2 — Exit is visually confused with and occluded by the echo

The exit and echo are both circular, blue/purple entities with light outlines. The current draw order renders the exit before the echo, so an echo occupying the exit cell covers the exit marker. The supplied screenshot demonstrates this exact state.

Required repair direction:

- give the exit a different silhouette from actors, such as a diamond/portal/tile marker;
- keep a persistent `EXIT` cue visible when either actor occupies the cell;
- do not rely on color alone.

### P1-3 — The intended causal roles were inverted

The user understood the puzzle as: the current player holds the plate so the echo can pass the door. The accepted design requires the opposite teaching goal: the delayed echo holds the plate while the current player crosses the door and reaches the exit.

Required repair direction:

- use explicit `YOU`, `ECHO`, `PLATE`, `DOOR`, and `EXIT` labels/legend;
- state the two-role objective without revealing the movement solution;
- preserve the accepted simulation and level semantics.

## P2 findings

### P2-1 — History does not explicitly identify the echo's next action

The HUD labels history as oldest-to-newest, but does not directly state which action the delay-3 echo will execute next. This increases cognitive load and weakens the connection between history and the moving echo.

Required repair direction:

- show `Echo next: <ACTION>` or an equally explicit marker derived from the current accepted history semantics;
- retain the full oldest-to-newest queue for planning.

### P2-2 — Existing instruction is insufficiently specific

`Let your echo hold the plate.` describes one subgoal but omits the actual terminal goal and the player-only completion rule. It did not prevent the role inversion observed above.

## Non-claims

This evidence does not establish:

- an unassisted completed playthrough;
- acceptable first-player objective clarity;
- numeric UX ratings;
- independent visual review;
- final art quality;
- export, release, or submission readiness.

The user's statement that the gameplay is viable is accepted as positive concept feedback, not as acceptance of the current UX implementation.

## Decision

Task 0004 has produced sufficient real-user evidence to require a focused repair before additional level production. The next gate is:

`Task 0004R — exit, objective, role-causality, and echo-next-action readability repair`.

Task 0004R must preserve `simulation_v1`, `level_v1`, the accepted vertical-slice level semantics, all nine normative vectors, and solver results unless a separately reviewed contract change is issued. A subsequent user retest is required before the first-player UX gate can be considered passed.

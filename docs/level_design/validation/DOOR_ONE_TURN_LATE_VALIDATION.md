# Door One Turn Late validation

- Formal path: `data/levels/door_one_turn_late.json`
- Formal ID: `door_one_turn_late`
- Status ladder reached: `INTERNAL_PLAYABLE`
- Loader/schema result: `VALID_LEVEL`; one delay-2 Echo, one Plate, one combinational Door, one player-only EXIT

## Solver and replay

- Solver status: `SOLVED`
- `L*=9`
- `N*=7 (EXACT)`
- Visited states: 291
- Maximum frontier: 116
- Limits: depth 24, states 100,000, time 10,000 ms, solution-count cap 1,000,000
- Solver witness: `["RIGHT", "RIGHT", "UP", "UP", "UP", "RIGHT", "RIGHT", "UP", "UP"]`
- Replay result: `REPLAYED`; completed state has YOU `[5,1]`, ECHO `[3,3]`, turn index 10, history `["UP","UP"]`, and the Door closed after traversal
- Restart result: exact reconstruction of the initial state

## Exact Door-timing trace

The shortest witness contains the required consecutive transitions:

1. At action index 4 (turn 5), the start snapshot has YOU `[3,3]`, ECHO `[3,5]`, and `door_timing=false`. Submitted `UP` is blocked for YOU. ECHO replays `UP` to `plate_timing` at `[3,4]`. The resulting turn-6 state keeps YOU `[3,3]` and commits `door_timing=true`.
2. The next submitted action is `RIGHT`. Its start snapshot is open, so YOU enters the Door cell `[4,3]`. ECHO leaves the Plate and the resulting state closes the Door, demonstrating that entry used the start-of-turn snapshot rather than the newly calculated result.

## Necessity and shortcut evidence

A controlled no-Echo representation is schema-valid only through the test-only tutorial-zero allowance and exhausts the complete finite state space unsolved: 5 visited states, maximum frontier 1, under the same limits. The single corridor has no path around the Door, so this also proves no player-only bypass. A separate valid-state transition places ECHO on EXIT and records `completed=false`. The compact folded geometry is distinct from accepted levels 1–3 and fits the frozen 960×540 presentation without changing Gameplay or viewport code.

## Limitations

This record proves strict schema validity, bounded solver/replay parity, the exact two-transition timing lesson, cooperation necessity, shortcut absence, player-only completion, exact restart, and internal runtime smoke only. Fresh-player review and candidate acceptance have not occurred; this level is neither `FRESH_PLAYER_REVIEWED` nor `CANDIDATE_ACCEPTED`.

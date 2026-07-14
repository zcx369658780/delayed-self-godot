# Tutorial Echo Bridge validation

- Formal path: `data/levels/tutorial_echo_bridge.json`
- Formal ID: `tutorial_echo_bridge`
- Status ladder reached: `INTERNAL_PLAYABLE`
- Loader/schema result: `VALID_LEVEL`; one delay-3 Echo sharing the player spawn, one Plate, and one combinational Door

## Solver and replay

- Solver status: `SOLVED`
- `L*=9`
- `N*=12 (EXACT)`
- Visited states: 1,975
- Maximum frontier: 509
- Limits: depth 64, states 100,000, time 10,000 ms, solution-count cap 1,000,000
- Solver witness: `["RIGHT", "RIGHT", "UP", "DOWN", "LEFT", "DOWN", "DOWN", "RIGHT", "RIGHT"]`
- Replay result: `REPLAYED`; completed state has player `[4,4]`, Echo `[2,2]`, turn index 10, history `["DOWN", "RIGHT", "RIGHT"]`, and the Door closed after traversal
- Restart result: exact reconstruction of the initial state

## Cooperation, necessity, and bypass evidence

At witness action index 5 (`DOWN`), the start state has YOU at `[2,2]`, ECHO at `[3,1]` on `plate_bridge`, and `door_bridge` open. The accepted transition uses that start-of-turn open snapshot and moves YOU into the Door cell `[2,3]`; the result retains the open Door because ECHO remains on the Plate. This demonstrates the accepted next-turn entry timing without changing simulation semantics.

A controlled no-Echo representation, enabled only for evidence by the existing zero-Echo tutorial allowance, exhausts its complete finite state space with `UNSOLVABLE_WITHIN_COMPLETE_FINITE_STATE`: 10 visited states, maximum frontier 3, under the same depth/state/time/count limits. Therefore no player-only completion bypass exists in the controlled state space. A separate trace places ECHO on EXIT and confirms `completed=false`, preserving current-player-only completion.

## Runtime and limitations

The catalog-hosted `GUIDED_ECHO` route and development direct route process successfully through the same gameplay scene used by all three catalog entries. This record proves schema validity, bounded solver/replay parity, delayed-Echo necessity, bypass checks, restart exactness, and internal playability only. Human/fresh-player acceptance has not occurred; the level is neither `FRESH_PLAYER_REVIEWED` nor `CANDIDATE_ACCEPTED`.

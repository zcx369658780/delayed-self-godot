# Two Keys One Door validation

- Formal path: `data/levels/two_keys_one_door.json`
- Formal ID: `two_keys_one_door`
- Status ladder reached: `INTERNAL_PLAYABLE`
- Loader/schema result: `VALID_LEVEL`; one delay-3 Echo, two distinct Plates, one combinational Door requiring both Plate IDs, one player-only EXIT

## Solver and replay

- Solver status: `SOLVED`
- `L*=12`
- `N*=1 (EXACT)`
- Visited states: 1,260
- Maximum frontier: 225
- Limits: depth 32, states 500,000, time 20,000 ms, solution-count cap 1,000,000
- Solver witness: `["RIGHT", "RIGHT", "RIGHT", "RIGHT", "UP", "UP", "RIGHT", "RIGHT", "UP", "UP", "LEFT", "LEFT"]`
- Replay result: `REPLAYED`; completed state has YOU `[5,1]`, ECHO `[6,3]`, turn index 13, history `["UP","LEFT","LEFT"]`, and the Door closed after traversal
- Restart result: exact reconstruction of the initial state

## AND-state and open-snapshot trace

At action index 6, the resulting turn-8 state has ECHO on `plate_echo` at `[5,5]`, YOU on `plate_you` at `[6,3]`, pressed Plate IDs `["plate_echo","plate_you"]`, and `door_and=true`. The actors occupy distinct positions, so legal overlap cannot be the source of the open state. The following `RIGHT` begins with the Door open and moves YOU into the Door cell `[7,3]`; both actors then leave their Plates and the resulting Door state closes.

## Dependency variants and shortcut audit

- No-Echo controlled variant: `UNSOLVABLE_WITHIN_COMPLETE_FINITE_STATE`, 8 visited, frontier 1.
- Relocate `plate_echo` beyond the closed Door to `[6,1]`: complete unsolved, 1,000 visited, frontier 225.
- Relocate `plate_you` beyond the closed Door to `[6,1]`: complete unsolved, 1,000 visited, frontier 225.
- Door depending only on `plate_echo`: solved at 12 turns, `N*=1 (EXACT)`, 1,260 visited, frontier 225.
- Door depending only on `plate_you`: solved at 12 turns, `N*=1 (EXACT)`, 1,261 visited, frontier 229.

The relocation variants prove each formal Plate dependency is necessary. The single-dependency controls show that either one-Plate Door would admit completion and therefore would not encode the accepted AND teaching goal. With two actors and two distinct Plate positions, every open AND state requires separate occupancy; one actor alone or actor overlap cannot press both. The single corridor has no route around the Door. A separate valid-state transition places ECHO on EXIT and records `completed=false`.

## Limitations

This record proves strict schema validity, bounded solver/replay parity, simultaneous two-Plate AND occupancy, open-snapshot entry, Echo and per-Plate necessity, shortcut absence, overlap non-triviality, player-only completion, exact restart, and internal runtime smoke only. Fresh-player review and candidate acceptance have not occurred; this level is neither `FRESH_PLAYER_REVIEWED` nor `CANDIDATE_ACCEPTED`.

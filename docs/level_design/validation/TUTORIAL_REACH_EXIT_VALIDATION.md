# Tutorial Reach Exit validation

- Formal path: `data/levels/tutorial_reach_exit.json`
- Formal ID: `tutorial_reach_exit`
- Status ladder reached: `INTERNAL_PLAYABLE`
- Loader/schema result: `VALID_LEVEL`; zero Echoes, zero Plates, zero Doors; `allow_zero_echo_tutorial=true`

## Solver and replay

- Solver status: `SOLVED`
- `L*=3`
- `N*=3 (EXACT)`
- Visited states: 6
- Maximum frontier: 2
- Limits: depth 12, states 10,000, time 10,000 ms, solution-count cap 1,000,000
- Solver witness: `["UP", "RIGHT", "RIGHT"]`
- Replay result: `REPLAYED`; completed state has player `[3,1]`, turn index 4, empty Echo positions, empty Door states, and history `[]`
- Restart result: exact reconstruction of the initial state

## Mechanic and bypass evidence

The formal level intentionally contains no delayed Echo mechanic. The distinct spawn and EXIT prove that completion is not true at start; the solver witness reaches EXIT using only accepted movement actions. The open room provides a movement choice without an intentional trap. Player-only EXIT completion is exercised through the shared simulation authority.

## Runtime and limitations

The catalog-hosted `INTRO_MINIMAL` route and development direct route process successfully. The HUD omits Echo, delay, history, Plate, Door, and WAIT guidance. This record proves schema validity, bounded solver/replay parity, restart exactness, and internal playability only. Human/fresh-player acceptance has not occurred; the level is neither `FRESH_PLAYER_REVIEWED` nor `CANDIDATE_ACCEPTED`.

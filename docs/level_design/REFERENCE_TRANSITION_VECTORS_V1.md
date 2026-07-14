# Reference transition vectors v1

- Machine fixtures: [`turn_transition_vectors_v1.json`](reference/turn_transition_vectors_v1.json)
- Simulation contract: [`GAMEPLAY_SIMULATION_CONTRACT_CURRENT.md`](../game_design/GAMEPLAY_SIMULATION_CONTRACT_CURRENT.md)
- Status: `NORMATIVE_SPECIFICATION_NOT_RUNTIME_EXECUTED`

These vectors are executable-shaped acceptance fixtures for a future runtime and solver. Task 0002 checked their JSON structure and internal arithmetic with Python standard-library logic; no Godot runtime or solver executed them. Task 0003 must implement and replay them before claiming conformance.

## Fixture conventions

- Coordinates use top-left origin, rightward `x`, downward `y`.
- State histories are oldest-to-newest and exactly `max_delay` long.
- Echo and door arrays are stable-ID sorted.
- `door_states` are the start/next-state logical values, not animation state.
- `pressed_plate_ids` are derived transition output for explanation and are not stored in the canonical state key.
- `turn_index` is carried as a runtime/metric field but excluded from the canonical key.
- `RESTART` has `player_input=null` and null actor actions because it reconstructs state without executing a world turn.

## Coverage map

| Vector | Normative behavior |
|---|---|
| `delay_3_turn_1_replays_on_turn_4` | Delay indexing and oldest-first history shift |
| `blocked_player_action_is_recorded` | Blocked cardinal action consumes the turn and remains in history |
| `echo_blocked_by_current_closed_door` | Replayed action uses the current door snapshot and is not rewritten |
| `plate_opens_door_after_movement_only` | Movement uses the old door state; plate commits opening for next turn |
| `player_and_echo_may_overlap` | Independent proposals and legal actor overlap |
| `history_changes_canonical_identity` | Equal positions with different histories are distinct; turn index is excluded |
| `restart_reconstructs_declared_initial_state` | Exact spawn/door/history/turn/completion reset |
| `echo_on_exit_does_not_complete` | Echo occupancy cannot satisfy the exit |
| `player_on_exit_completes` | Current-player exit sets terminal completion |

## Conformance requirements

A conforming future implementation must:

1. load the fixture and state without changing array/ID semantics;
2. emit the exact expected actor actions and logical result;
3. serialize the exact `canonical_key` string;
4. keep transition errors separate from normal blocked movement;
5. report every mismatch rather than updating expected output to match implementation;
6. run all vectors for any change to movement, history, doors/plates, restart, completion, or state-key serialization.

The two exit vectors intentionally distinguish player and echo occupancy. The history-key vector intentionally compares turn indices 7 and 99 while changing history: different history changes identity, while absolute turn alone must not.

## Known limitation

The fixture file is not itself the level-schema format; its `fixtures` are compact immutable fragments paired with explicit input states. Formal levels use `schemas/level_v1.schema.json`. A later test harness must validate formal level files first, then map them into the same state/transition representation.

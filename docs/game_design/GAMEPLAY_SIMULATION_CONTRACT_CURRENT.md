# Gameplay simulation contract (CURRENT)

- Contract version: `simulation_v1`
- Acceptance status: `PENDING_GPT_REVIEW`
- Level schema: [`level_v1.schema.json`](../../schemas/level_v1.schema.json)
- Human schema contract: [`LEVEL_SCHEMA_V1_CURRENT.md`](../level_design/LEVEL_SCHEMA_V1_CURRENT.md)
- Normative fixtures: [`turn_transition_vectors_v1.json`](../level_design/reference/turn_transition_vectors_v1.json)
- Status: specification only; not runtime-executed

This document is the Task 0002 normative candidate for schema-v1 logical behavior. After GPT acceptance, runtime, solver, replay, and validation must implement the same transition. Presentation may animate the resolved result but cannot participate in logical resolution.

## 1. Coordinates, actions, and ordering

- Grid origin is top-left `(0, 0)`; `x` increases right and `y` increases down.
- Legal player actions are exactly `UP`, `RIGHT`, `DOWN`, `LEFT`, `WAIT`.
- Deltas are `UP=[0,-1]`, `RIGHT=[1,0]`, `DOWN=[0,1]`, `LEFT=[-1,0]`, `WAIT=[0,0]`.
- Solver expansion order is exactly `UP`, `RIGHT`, `DOWN`, `LEFT`, `WAIT`.
- Action strings are case-sensitive. `INTERACT`, push, combat, enemies, hazards, anchors, teleporters, latches, one-way tiles, and real-time actions are outside v1.

## 2. State and immutable level data

The operational state `S_t`, immediately before player input on turn `t`, contains:

```text
turn_index: positive integer, initially 1
player_position: [x, y]
echo_positions: [{ id, position }] sorted by echo ID
door_states: [{ id, open }] sorted by door ID
history: exactly max_delay actions, oldest to newest
completed: boolean
```

`max_delay` is the maximum declared echo delay. With no echoes in an explicitly allowed tutorial-zero level, it is `0` and history is `[]`. Before turn 1, history is `max_delay` copies of `WAIT`.

Terrain, dimensions, spawns, echo IDs/delays, plates, door definitions, exit, and metadata are immutable level data. Plate occupancy is derived from actor positions and is not stored. Door state is stored because the start-of-turn snapshot governs entry during that turn. `turn_index` is an operational metric and is excluded from normal state deduplication.

IDs are lower snake_case and unique within each entity family. Whenever state or output contains echoes or doors, order them by ascending ID using bytewise/ASCII order; the allowed ID alphabet makes this deterministic.

A supplied state is valid only when its actor/door ID sets exactly match the level, arrays are ID-sorted, positions are in bounds on floor or an overlaid door, history has exactly `max_delay` legal actions, each door state equals the combinational result of current actor/plate occupancy, and `completed` is true exactly when the player is on the exit. Runtime-created states preserve these invariants. A malformed external fixture/replay state is `INVALID_STATE`, not normal gameplay.

## 3. History and echo indexing

On turn `t`, the player supplies `u_t`. An echo with delay `d` executes `u_(t-d)`; if `t-d <= 0`, it executes `WAIT`.

For history stored oldest-to-newest, an echo reads:

```text
history[max_delay - d]
```

before the queue is shifted. After resolution, remove the oldest entry and append the submitted player action. Thus a delay-3 echo first replays `u_1` on turn 4.

A cardinal action blocked by a boundary, wall, or closed door still consumes the turn and is appended unchanged. It is not rewritten as `WAIT`.

## 4. Traversability and simultaneous movement

At turn start, capture one door-state snapshot. For each actor independently:

1. derive its action from player input or history;
2. compute the proposed destination from its current position;
3. accept that destination only if it is in bounds, its terrain cell is `.`, and no door closed in the captured snapshot occupies it;
4. otherwise retain the current position.

Only entry is blocked. An actor already on a door tile may leave even when that door is closed.

Apply all accepted actor positions simultaneously. Actors never block one another: player/echo and echo/echo overlap is legal. No swap, collision, priority, or push resolution exists.

## 5. Plates, doors, and completion

After simultaneous movement:

1. A plate is pressed if the player or any echo occupies its position.
2. A door is open iff every ID in its `all_plate_ids` is pressed.
3. Commit all door states simultaneously.
4. Set `completed=true` iff the current player occupies the exit.

The new door states appear in `S_(t+1)` and affect entry only on the next turn. An echo cannot complete the level. Doors are combinational only: no memory, toggle, latch, timer, or damage. A door may close around an actor without harm.

Schema v1 has exactly one goal predicate: current player on the exit. Completed states are terminal. Runtime and solver must not expand them; a direct transition request returns `TERMINAL_STATE` without mutation.

## 6. Normative transition

For validated level data and a non-terminal state, `F(S_t, u_t)` executes:

```text
0. validate the case-sensitive input action
1. read S_t and capture current door states
2. resolve player action and each echo action from history
3. compute destinations independently against the captured snapshot
4. apply all actor positions simultaneously
5. evaluate pressed plates from the new positions
6. compute and commit all next door states
7. evaluate current-player exit success
8. shift history and append u_t
9. increment turn_index and emit S_(t+1)
```

The transition is all-or-nothing. Animation, audio, frame time, wall-clock time, and node order cannot affect it.

## 7. Boundary errors versus blocked movement

Level JSON is validated once at the loader boundary. Invalid data produces `INVALID_LEVEL` plus one or more stable validation codes and constructs no state. Unknown fields are rejected.

| Condition | Result |
|---|---|
| Unknown/lowercase/non-string action | `INVALID_ACTION`; no transition and no mutation |
| Transition requested from completed state | `TERMINAL_STATE`; no transition and no mutation |
| Invalid level or invalid supplied state shape/invariant | `INVALID_LEVEL` or `INVALID_STATE`; no partial state |
| Legal cardinal action meets boundary/wall/closed door | Normal successful transition; actor stays, turn/history advance |

Validation codes are defined by the schema contract. Human-readable messages are diagnostic and not canonical logic.

## 8. Canonical state key

The solver key includes every future-relevant mutable value and nothing presentational:

```json
[[player_x,player_y],[[echo_id,x,y],...],[[door_id,open],...],[history_action,...],completed]
```

Serialize this JSON array as UTF-8 with no insignificant whitespace. Echo and door tuples are ID-sorted; booleans are JSON `true`/`false`; action strings use the exact enum values.

Example:

```text
[[1,2],[["echo_a",3,4]],[["door_a",false]],["WAIT","UP","LEFT"],false]
```

Implementations must emit exactly this compact JSON form. The JSON fixtures contain exact canonical strings.

Exclude terrain/static definitions, delays/spawns, plate occupancy, presentation state, animation/audio, wall-clock time, and `turn_index`. Two states with identical positions but different history are not equivalent because echoes can take different future actions. Absolute turn is normally redundant because the fixed queue contains all future-relevant input memory; BFS depth records elapsed turns.

## 9. Restart

Restart is not an action and does not call `F`. It reconstructs state from validated immutable level data:

- `turn_index=1`;
- actor positions equal declared spawns in stable ID order;
- door states equal validated `initial_open` values;
- history is `WAIT` repeated `max_delay` times;
- `completed=false`.

For combinational consistency, validation requires each `initial_open` value to equal whether all referenced plates are occupied by initial actor spawns. Restart never preserves prior movement, history, door state, or completion. Undo is outside v1.

## 10. BFS solver and validation contract

The baseline solver is bounded breadth-first search:

1. validate level and construct restart state;
2. enqueue it at depth 0 and add its canonical key to `visited`;
3. expand actions in the fixed order;
4. use this same transition and goal result;
5. deduplicate by canonical key and shortest discovery depth;
6. stop shortest-depth expansion only after all states at the first goal depth needed for `N*` are processed.

For shortest-solution counting, retain for each canonical key its first depth, a capped count of distinct shortest action sequences reaching it, and one deterministic first predecessor/action for replay. A new key is enqueued once. Reaching an existing key at the same depth adds the incoming path count but does not enqueue a duplicate; reaching it at a greater depth adds nothing. `N*` counts distinct action sequences, not distinct goal-state keys, by summing shortest-depth path counts that reach goal transitions.

Required output:

- status;
- shortest turn count `L*` when solved;
- one action-array shortest solution suitable for replay;
- shortest-solution count `N*` and `shortest_solution_count_status` of `EXACT` or `CAPPED`;
- visited-state count;
- maximum frontier size;
- configured depth, state, time, and solution-count limits.

Statuses are exactly:

- `SOLVED`
- `UNSOLVABLE_WITHIN_COMPLETE_FINITE_STATE`
- `DEPTH_LIMIT`
- `STATE_LIMIT`
- `TIME_LIMIT`
- `INVALID_LEVEL`

`UNSOLVABLE_WITHIN_COMPLETE_FINITE_STATE` is allowed only when the reachable finite state space was exhausted without hitting a resource limit. A limit result is never called unsolvable. Time is an external stopping resource, never transition input.

When counting reaches the configured solution cap, store the cap as the reported lower-bound count and set `shortest_solution_count_status=CAPPED`; never present it as exact. A deterministic first predecessor chain supplies the replayable solution independently of count accumulation.

Any semantic change must revalidate every accepted level and compare schema validity, `L*`, solution-count value/status, and replay under the changed runtime/solver contract.

## 11. Authority and evidence

The JSON vectors are normative specification fixtures, not proof of an implementation. Task 0003 or a later test gate must implement and replay them before any runtime correctness claim. If runtime, solver, schema, prose, or fixtures disagree, the accepted contract and a new correction task govern; do not silently accommodate divergent behavior.

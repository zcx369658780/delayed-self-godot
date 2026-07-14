# Level schema v1 contract (CURRENT)

- Machine schema: [`schemas/level_v1.schema.json`](../../schemas/level_v1.schema.json)
- Minimal valid example: [`level_v1_minimal_valid.json`](examples/level_v1_minimal_valid.json)
- Simulation semantics: [`GAMEPLAY_SIMULATION_CONTRACT_CURRENT.md`](../game_design/GAMEPLAY_SIMULATION_CONTRACT_CURRENT.md)
- Encoding: UTF-8 JSON, no comments, no trailing commas

Schema v1 is strict and versioned. Unknown fields are rejected (`additionalProperties=false`) so misspellings or unsupported mechanics cannot silently change meaning. A future incompatible contract requires a new schema version and migration/revalidation task; do not fork v1 behavior by consumer.

## 1. Top-level fields

| Field | Contract |
|---|---|
| `schema_version` | Required integer constant `1` |
| `level_id` | Required stable lower-snake-case ID |
| `title` | Required non-empty display string |
| `terrain_rows` | Required rectangular array of `#` wall / `.` floor strings |
| `player_spawn` | Required `[x,y]` coordinate |
| `echoes` | Required array of `{id, delay, spawn}` |
| `plates` | Required array of `{id, position}` |
| `doors` | Required array of `{id, position, initial_open, all_plate_ids}` |
| `exit` | Required `{position}` |
| `metadata` | Required authoring intent, not simulation state |
| `validation` | Required search recommendation plus optional non-authoritative expectation |

## 2. Bounded v1 envelope

- Terrain width and height: 1–64 cells; every row has the same non-zero length.
- Coordinates: two integers, each 0–63, then cross-validated against actual width/height.
- Echo delay: 1–16 inclusive. This caps future-relevant history at 16 actions, keeps canonical keys bounded, and is ample for the initial puzzle scope; increasing it requires a later schema decision.
- At most 8 echoes and 64 plates/doors. These parser-safety bounds do not imply that such large levels are usable or solver-feasible.
- Stable IDs match `^[a-z][a-z0-9]*(?:_[a-z0-9]+)*$` and are unique within their entity family.

## 3. Terrain and placement validation

JSON Schema checks types, enums, local ranges, required fields, and unknown fields. A loader must additionally perform cross-field checks that standard JSON Schema cannot express conveniently:

1. `terrain_rows` are rectangular.
2. Every coordinate is within actual bounds.
3. Player spawn, echo spawns, plates, doors, and exit are on `.` cells.
4. Every plate position, every door position, and the exit position are pairwise distinct, including within a family.
5. Player/echo spawns may overlap each other and plates, but not doors or exit.
6. IDs are unique within echoes, plates, and doors.
7. Every door has at least one unique `all_plate_ids` entry and every entry resolves to an existing plate.
8. `initial_open` equals whether every referenced plate is occupied by at least one initial actor spawn.
9. An empty `echoes` array is allowed only when `metadata.allow_zero_echo_tutorial=true`. Such a level is tutorial scaffolding, not an official delayed-echo puzzle; official candidates require at least one echo.

Underlying terrain remains `.` under plates, doors, the exit, and actor spawns. Static entities do not replace terrain characters.

## 4. Entity semantics

### Echo

```json
{"id":"echo_main","delay":3,"spawn":[1,2]}
```

IDs determine canonical ordering; array order in source does not. Delay is immutable. Actor overlap is legal.

### Plate

```json
{"id":"plate_entry","position":[2,2]}
```

Plate pressed state is derived after simultaneous movement and is not serialized in runtime state.

### Door

```json
{
  "id":"door_entry",
  "position":[4,2],
  "initial_open":false,
  "all_plate_ids":["plate_entry"]
}
```

`all_plate_ids` is an AND-set. Source order has no logical effect; validators reject duplicate references. Only this combinational mode exists in v1.

### Exit

```json
{"position":[5,1]}
```

Only the current player triggers it. It cannot overlap a door or plate, and actor spawns cannot start on it.

## 5. Metadata and validation hints

`metadata` requires:

- `teaching_goal`: concise author intent;
- `intended_mechanics`: unique lower-snake-case labels, descriptive only;
- `notes`: author notes; may be empty;
- `allow_zero_echo_tutorial`: explicit boolean exception flag.

Metadata never changes transitions. Unsupported mechanics cannot be enabled through labels or notes.

`validation.recommended_search_depth` is a positive bounded recommendation. `expected_min_turns`, when present, is non-authoritative author expectation and is not evidence until a future solver returns and replays it. Loader validity must not depend on either value.

## 6. Stable validation errors

A validator returns `INVALID_LEVEL` with one or more stable codes, preferably including a JSON path and diagnostic message:

| Code | Meaning |
|---|---|
| `JSON_PARSE_ERROR` | Invalid UTF-8 JSON syntax, comments, or trailing comma |
| `SCHEMA_SHAPE_ERROR` | Required/type/enum/range/unknown-field failure |
| `UNSUPPORTED_SCHEMA_VERSION` | `schema_version` is not 1 |
| `DUPLICATE_ID` | Duplicate within an entity family |
| `RAGGED_TERRAIN` | Unequal row widths |
| `OUT_OF_BOUNDS` | Coordinate outside actual terrain |
| `NOT_FLOOR` | Entity coordinate is not on `.` |
| `STATIC_POSITION_OVERLAP` | Plate/door/exit positions overlap |
| `ACTOR_ON_FORBIDDEN_STATIC` | Spawn is on a door or exit |
| `UNKNOWN_PLATE_REFERENCE` | Door references missing plate |
| `DUPLICATE_PLATE_REFERENCE` | Door repeats a plate ID |
| `INITIAL_DOOR_STATE_MISMATCH` | `initial_open` conflicts with initial spawn occupancy |
| `ECHO_REQUIRED` | Official puzzle has no echo, or empty echoes lacks explicit tutorial flag |

Diagnostics are not state-transition outputs. Invalid data constructs no partial runtime state and is never sent to the solver.

## 7. Initial state construction

After validation:

1. sort echoes and doors by stable ID;
2. set actor positions to declared spawns;
3. set doors to declared, validated `initial_open`;
4. set `max_delay` to the greatest echo delay, or zero for tutorial-zero;
5. create `history` as `WAIT` repeated `max_delay` times;
6. set `turn_index=1` and `completed=false`.

Restart calls this same construction. No runtime residue is retained.

## 8. Versioning policy

Version 1 rejects unknown fields and unsupported mechanics. Additive metadata that consumers must understand still requires an explicit contract update. Any change to transition-relevant fields or semantics requires a new task, updated vectors, all accepted-level revalidation, solver/runtime replay, and a schema-version decision. Consumers must not implement private extensions under `schema_version: 1`.

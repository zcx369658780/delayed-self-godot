# Level schema v2 contract (CURRENT)

- Machine schema: [`level_v2.schema.json`](../../schemas/level_v2.schema.json)
- Compatibility: schema v1 remains strict, unchanged and behavior-identical.
- Simulation authority: [`GAMEPLAY_SIMULATION_CONTRACT_V2_CURRENT.md`](../game_design/GAMEPLAY_SIMULATION_CONTRACT_V2_CURRENT.md)

Schema v2 repeats every required v1 field and adds explicit arrays: `crates`, `keys`, `locks`, `barrier_groups`, `sensors`, and `latches`. All arrays are required, may be empty, reject unknown fields, and are normalized by stable ID. The one submission-core key family is the literal `main`.

`crates` use `{id, position}`. `keys` and `locks` use `{id, position, key_type:"main"}`. A barrier group uses a stable ID, one or more unique `cells`, `initial_open`, and a non-empty AND-set of `all_sensor_ids`. Sensors declare a stable ID, position, exact `activator` enum (`ANY_ACTOR`, `YOU_ONLY`, `ECHO_ONLY`), and explicit `include_crates`. Latches declare their activator, target group, and one terminal `target_open` value.

All v2 overlays must be in-bounds floor cells. Crates, keys, locks, barrier cells, v1 doors and the exit are mutually exclusive static cells; sensors and latches may share a floor cell with actors, crates, keys or each other. A v2 barrier group initial state must match its declared sensors at initial actor/crate occupancy. IDs are unique within each entity family; references are exact and all unknown fields/references are rejected atomically.

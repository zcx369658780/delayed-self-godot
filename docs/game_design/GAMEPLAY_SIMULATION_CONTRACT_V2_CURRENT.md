# Gameplay simulation contract v2 (CURRENT)

Schema v2 extends, but never reinterprets, `simulation_v1`. State adds sorted barrier states, crate positions, remaining key IDs, held-key inventory, removed lock IDs and latch states; `turn_index` remains excluded from canonical deduplication.

For a legal non-terminal turn: capture the start snapshot; derive YOU/ECHO actions; block walls, closed v1 doors, closed barriers and locks; allow at most one cardinal YOU crate push into a free traversable start-snapshot cell and reserve its destination; resolve actor movement simultaneously (ECHOs cannot enter crates or a reserved crate destination); commit actor/crate positions; collect YOU-only keys; resolve typed sensor occupancy and first-use latches; derive next v1 doors and v2 barrier states; defer requested barrier closure while an actor or crate occupies any group cell; evaluate YOU-only exit; then shift history and increment the turn.

Keys collected by YOU become `held_keys`; entering a matching lock with one held `main` key consumes one key, records that lock ID as removed, and enters in the same turn. ECHOs cannot collect or remove either. A sensor counts YOU/ECHOs according to its exact activator; crates count only when `include_crates=true`. A latch activates only once, persists to restart, and overrides its target group to its declared terminal state. Grouped sensor/latch results affect entry next turn. Restart reconstructs every mutable v2 field from immutable definitions.

The compact canonical JSON tuple is `[player, echoes, doors, barriers, crates, remaining_keys, held_keys, removed_locks, latches, history, completed]`, with all ID-bearing values ASCII-sorted. BFS and replay use only this transition and key.

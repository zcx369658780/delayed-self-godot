# Level catalog v1 contract (CURRENT)

- Machine schema: [`catalog_v1.schema.json`](../../schemas/catalog_v1.schema.json)
- Tracked catalog: [`level_catalog_v1.json`](../../data/catalog/level_catalog_v1.json)
- Formal puzzle contract: [`LEVEL_SCHEMA_V1_CURRENT.md`](../level_design/LEVEL_SCHEMA_V1_CURRENT.md)
- Encoding: UTF-8 JSON, no comments or trailing commas

## Authority boundary

Catalog v1 owns product ordering, routing, unlock prerequisites, title keys, classification, HUD selection, and the current catalog-final flag. It never defines terrain, actors, actions, doors, completion, solver behavior, or any other puzzle rule. Each `level_path` resolves to a separately validated `level_v1` JSON, and catalog `level_id` must equal its formal ID.

The complete catalog is validated before Main Menu or Level Select is constructed. A single error returns `INVALID_CATALOG`, an empty normalized catalog, stable diagnostics, and the Safe Error route. Partial publication and silent fallback are forbidden.

## Shape

Top-level fields are exactly `catalog_version` (integer constant `1`) and `entries` (1–64 entries). Every entry contains exactly:

- `level_id`: lower-snake-case stable ID;
- `level_path`: `res://data/levels/*.json` formal path;
- `sequence`: unique, contiguous integer sequence beginning at 1;
- `display_title_key`: stable dotted product/localization key;
- `classification`: `tutorial` or `standard`;
- `unlock_prerequisites`: unique catalog IDs;
- `hud_mode`: `INTRO_MINIMAL`, `GUIDED_ECHO`, or `STANDARD_COMPACT`;
- `final_level`: boolean;
- optional `best_turn_threshold`: positive integer backed by accepted evidence.

Unknown fields are rejected. Prerequisites cannot be duplicated, self-referential, unknown, cyclic, or unreachable from a root entry. The tracked runtime catalog has exactly one `final_level=true` entry.

The current one-entry development catalog marks `vertical_slice_delay_3` as final only because it is the last implemented catalog entry. This is not a narrative ending, candidate-completion, release, or submission claim. No best-turn threshold is recorded.

## Normalized runtime data

Entries are sorted by `sequence`. After cross-reference validation, each normalized entry includes the accepted `LevelLoader` result as `formal_level` and its `title` as `formal_title`. Task 0006 uses `formal_title` as an explicit development UI fallback while retaining `display_title_key`; no hidden title registry or localization implementation is introduced.

Repository tests may explicitly enable fixture paths under `tests/app/` and the accepted level examples to exercise invalid-formal-level and ID-mismatch branches. Runtime `load_file()` never enables that mode and remains restricted to `data/levels/`.

## Stable validation codes

| Code | Meaning |
|---|---|
| `CATALOG_JSON_PARSE_ERROR` | Catalog is unreadable or malformed JSON |
| `CATALOG_UNKNOWN_FIELD` | Top-level or entry field is not allowed |
| `CATALOG_UNSUPPORTED_VERSION` | Version is not 1 |
| `CATALOG_SHAPE_ERROR` | Required field, type, range, or collection shape is invalid |
| `CATALOG_INVALID_FORMAT` | ID, title key, or formal path format is invalid |
| `CATALOG_DUPLICATE_LEVEL_ID` | A level ID appears more than once |
| `CATALOG_DUPLICATE_SEQUENCE` | A sequence value appears more than once |
| `CATALOG_NONCONTIGUOUS_SEQUENCE` | Sequence is not contiguous from 1 |
| `CATALOG_UNKNOWN_CLASSIFICATION` | Classification is unsupported |
| `CATALOG_UNKNOWN_HUD_MODE` | HUD mode is unsupported |
| `CATALOG_DUPLICATE_PREREQUISITE` | A prerequisite repeats within one entry |
| `CATALOG_SELF_PREREQUISITE` | An entry requires itself |
| `CATALOG_UNKNOWN_PREREQUISITE` | A prerequisite ID is absent |
| `CATALOG_PREREQUISITE_CYCLE` | Prerequisite graph contains a cycle |
| `CATALOG_UNREACHABLE_ENTRY` | Entry cannot be reached from any root |
| `CATALOG_LEVEL_FILE_MISSING` | Formal level file does not exist |
| `CATALOG_FORMAL_LEVEL_INVALID` | Accepted `LevelLoader` rejects the formal level |
| `CATALOG_LEVEL_ID_MISMATCH` | Catalog and formal IDs differ |
| `CATALOG_FINAL_COUNT_INVALID` | Runtime catalog has zero or multiple final entries |

Messages and JSON paths are bounded diagnostics; codes and the no-partial-catalog result are the stable behavior.

## Routing and progress

The application route IDs are `BOOT`, `MAIN_MENU`, `LEVEL_SELECT`, `GAMEPLAY`, and `SAFE_ERROR`. Gameplay receives one validated payload containing catalog ID, formal path, HUD mode, classification, development-direct flag, and current-catalog final flag. Development launch accepts only a user argument such as `--level-id=vertical_slice_delay_3`; it never accepts a user-supplied file path and still resolves through this catalog.

The Task 0006 progress adapter is memory-only. Root entries begin unlocked; an entry unlocks only after every prerequisite is completed; completion is idempotent; best turns retain the lower positive count; invalid input fails safely; reset restores deterministic initial facts. It does not access `user://`, decide puzzle completion, or call simulation transitions.

# Godot safety and release gates (CURRENT)

## Toolchain and generated state

Exact Godot/editor/export-template version, renderer, platform targets, and critical plugins must be inventoried and frozen by separate tasks. Do not install or upgrade them opportunistically. Never commit `.godot/`, editor-local state, credentials/signing material, crash dumps, raw evidence, or unauthorized exports/builds.

## Architecture boundary

Simulation is deterministic and separate from display. Identical initial state and input sequence must produce identical results. Animation is never the sole logic timer. Level data is separate from presentation; puzzle rules are not duplicated in UI or per-level scenes. Runtime and solver use the same rules or one executable/verifiable contract. GDScript is the initial assumption only after authorization; C#, GDExtension, and native plugins require a separate necessity review.

## Protected release surfaces

Save format/path/migration, player-data deletion, export templates, signing, builds, tags/releases, repository settings, platform accounts, uploads, and public festival submission each require explicit gates. Tests use isolated profiles and never overwrite real player data. Release claims require export, smoke-test, license, rules, and submission-package evidence.

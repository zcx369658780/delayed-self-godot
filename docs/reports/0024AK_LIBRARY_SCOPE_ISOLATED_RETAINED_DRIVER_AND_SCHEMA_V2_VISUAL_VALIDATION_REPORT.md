# Task 0024AK library-scope-isolated retained driver and schema-v2 visual validation report

## Terminal result

`BLOCKED_SCHEMA_V2_RETAINED_DRIVER_SCOPE_ISOLATION`

Task 0024AK built and qualified a standalone wrapper adapter, parameter-free evidence-parser module and non-dot-sourced final driver. Scope/parser probes, two independent real focused qualifications and PRE_FINAL preservation all passed. The unique retained manifest was then consumed, the first AJ adapter/Godot case returned one parseable capture, and the final driver failed before durably recording that case because `ConvertFrom-Task0024AKWrapperValues` was no longer resolvable in driver scope. The retained cycle is terminal and must not be repaired or rerun.

## Architecture and authoring qualification

- The standalone adapter exposes no `Library` parameter and invokes the accepted wrapper only in child scope.
- The `.psm1` has no top-level `param()`, exports exactly `ConvertFrom-Task0024AKWrapperValues` and `ConvertFrom-Task0024AKEvidenceLines`, and exports no variables.
- The final driver has no dot-source invocation, uses only `AkDriverGodotExecutable`, `AkDriverProjectRoot` and `AkDriverManifestPath`, and checks immutable bindings after module import and around each case.
- Sentinel probes imported the module twice with `-Force`; all eight generic/driver sentinels remained byte-identical.
- PowerShell 7.6.1 AST, scope, parser, semantic evidence and driver-preflight probes passed. Windows PowerShell 5.1 scope probing passed; its optional parser run does not support `ConvertFrom-Json -Depth` and was not used for qualification.
- Parser negatives rejected missing/duplicate/extra/non-JSON/truncated/array/null/wrong-version/wrong-type wrapper results; marker zero/two/regex-lookalike cases; missing/duplicate/invalid/over-bound evidence; and invalid swapped-control/action-11/action-12 lifecycle evidence.
- Manifest preflight binds the validated record to exact UTF-8 bytes, byte count and SHA-256. The driver rechecks those bytes while holding the manifest read lock and creates the consumption sidecar with `CreateNew`.

## Preserved authoring failure

The first pre-retention focused attempt failed because the adapter initially counted only stdout lines exactly equal to the required marker, while the frozen AJ validator emits the marker followed by `assertions=230`. That authoring failure is preserved at `task_0024ak_qualification_focused_1_failure.json` (SHA-256 `93e189fc734808afbb40db051405ed3451a80bb0841409182b47a3471d2e2ea1`). Before manifest declaration, the AK-only counter was corrected to literal ordinal substring occurrence counting and independently reviewed. No retained budget had been consumed.

## Repeatable focused qualification

Both fresh runs executed the frozen AJ validator through the AK standalone adapter under PowerShell 7 and passed:

- qualification 1 wrapper SHA-256: `3d9f637c42a82654ac285117607294dde21e9dc69a6d27117b20484b266c699a`;
- qualification 2 wrapper SHA-256: `d5cdceb06bd0d2d6a77f38e1f0faf1eb968e971a616450ad57ea1119a9ca8bf6`;
- both wrapper records were schema v2 with status/underlying status `PASS`, native exit 0, marker occurrence exactly one, empty stderr, cleanup exactly once, empty remaining owned/unproven PID arrays and adapter/main Godot counts `0/0`;
- both complete AJ parses retained exactly thirteen unique bounded records and the exact thirteen nonempty, pairwise-distinct signatures;
- four public-loader Gameplay route preflights, the accepted swapped-identity wrong-actor control, action 10 open/nondeferred/unoccupied, action 11 cell `[4,1]` deferred, action 12 cell `[5,1]` deferred, action 13 vacancy-close, crate, key/lock/inventory, latch, fit/layering and v1 regression all passed.

Qualification record SHA-256 values are `a2f6ca92eb9b936ccbac8ebd79efb68fd31864b83ed7f4746d729e1752c5170a` and `d8f5d77e598968fe9813ac4fa3aada66582a2a428930b369911209b03786136d`.

## Consumed retained-cycle blocker

- Manifest ID: `2de60fc6-9065-4ecf-a5d9-a09b739f1461`.
- Manifest SHA-256: `deb56535ea53fcd6f581e73e264c4dc053cd4c88c53939f577a0e9b134c4a58a`.
- Invocation ID: `a3331dbe-26b5-4a56-ade6-25bfc0aefd9a`.
- The driver atomically wrote `CONSUMED_BEFORE_FIRST_CASE` at `2026-07-23T03:29:55.4280813Z`.
- Consumption sidecar SHA-256: `e9275a349e820f414b4bb18d6309aa3755fbe888579b2927aebbfd188b45da96`.
- The first case, `sensor_contract_dynamic_signature`, invoked the adapter/Godot and returned one parseable adapter capture. The driver then failed at line 247 while attempting raw-wrapper revalidation: `The term 'ConvertFrom-Task0024AKWrapperValues' is not recognized as a name of a cmdlet, function, script file, or executable program.`
- The first capture was not durably retained, so it is not reported as a retained PASS. Zero driver case records and no retained result JSON exist.
- `isolated_staging_route`, `batch_1_12`, `aggregate` and `complete_v2` were not executed.
- Final Godot count was 0. Blocker evidence SHA-256: `1675e846df58d0be79ed9acb32850d0f4a694d5e94b05558e1f88afc3a922e43`.
- The manifest, sidecar and blocker are frozen terminal evidence. No repair or rerun is authorized under Task 0024AK.

## Audits, routing and boundaries

- PRE_FINAL audit SHA-256 `3b76b87698e3852f72c8687ff230817ef5613a57d86d97d02d8a76ed7abfd404` passed with zero historical mismatch and zero unauthorized paths.
- POST_FINAL audit SHA-256 `22f0a4182548be275846c5aaaeabdb117e0cd0c7fd6b8f6afcc550124052b082` also passed with zero historical mismatch and zero unauthorized paths.
- Final documentation closeout audit SHA-256 `e7b7e05347be05c3c19bbdc15a68e22d5e9068ba596252cae79999c9af70c0ea` passed with zero historical mismatch and zero unauthorized paths.
- `.codex/config.toml` remained untracked, unstaged and byte-identical at SHA-256 `d4c670da3c2404921a1ab177f4e5405449bc8321d713cc0b42b8046201fd33cc`.
- All Task 0024AF–AJ artifacts, the frozen AJ validator, accepted wrapper, `schema_v2_presentation.gd`, `vertical_slice.gd`, production catalog/levels/scenes, Simulation/solver, App/Profile and release surfaces remained unchanged.
- Multi-subagent routing used a read-only PowerShell scope/contract mapper, an AK-only driver implementation worker and an independent reviewer/test auditor. Only the main agent ran Godot, declared/executed the manifest and performed Git integration.
- Owner route remains `MACHINE_QUALIFIED_ISOLATED_STAGING_ROUTE`; owner playthrough remains `NOT_YET_REVIEWED`; visual-art direction is not final; catalog admission remains `NOT_AUTHORIZED`.

## Required next gate

GPT/owner must adjudicate this honest consumed-cycle blocker and, if desired, issue a new bounded task identity. Task 0024AK itself is terminal. This result does not authorize owner subjective acceptance, production catalog/progression/finale/Profile changes, localization, assets/audio, build/export, release, upload or submission.

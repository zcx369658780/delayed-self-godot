# Complete-flow production-closure plan (CURRENT)

- Task: `tasks/0022_complete_flow_and_production_closure_planning.md`
- Status: `COMPLETE_FLOW_PRODUCTION_CLOSURE_PLAN_READY_FOR_GPT_REVIEW`
- Product changes in this task: none
- Selected first implementation slice: **persistent local profile core and isolated tests**

## 1. Authority and current architecture

The formal product remains exactly eight catalog entries. Sequence 8
`two_echo_convergence` is the sole final level; the catalog and all formal level
files remain byte-identical. Task 0021's catalog-derived final acknowledgement,
record-once guard, non-final automatic return, and final Gameplay return/replay
behavior are frozen. Sequence 9, B007, and candidate A/B/C are historical or
deferred only.

Static inspection only was used: codebase graph queries, source/document reads,
and inventory commands. No Godot run, capture, export, asset/font/audio
acquisition, or player-data creation occurred.

| Surface | Proven state | Closure gap / constraint |
|---|---|---|
| AppRoot | One generic replace-screen route host: Boot, Main Menu, Level Select, Gameplay, Safe Error | Extend this seam; do not replace it with a navigation framework. |
| Progress | `DelayedSelfMemoryProgress` derives unlocks from the validated catalog and holds completed IDs/best turns only in memory | Its current test asserts no `user://` write; persistence must be introduced behind a bounded adapter. |
| Menu / Level Select | Menu is Play/Quit development shell; Level Select scrolling/focus is accepted | Continue/New Game/Reset, Settings, Credits, pause and confirmations are missing; scroll/focus stays stable. |
| Gameplay | Deterministic Simulation owns state; Help is non-route and Timeline optional | Pause must not mutate puzzle state; final acknowledgement remains as accepted. |
| Safe Error | Bounded error surface returns to Main Menu | Profile recovery must be actionable without exposing contents or overwriting evidence first. |
| Presentation | 960x540 canvas-items/keep, Compatibility renderer, keyboard baseline | No settings, translation, fonts, icon/splash, audio buses, or export preset exist. |
| Licensing / public status | Ledger and attribution have no cleared asset entries; README was bootstrap-stale | No external asset/font/audio may enter before a separate ledger-clearing task. |

## 2. Protected local-profile contract

### Scope and format

Use Godot-supported `user://` storage only, never `res://`, repository paths,
or an externally supplied path. One local JSON file, for example
`user://delayed_self_profile.json`, owns both progress and settings: one atomic
commit avoids divergent completion/language state. The root is exactly:

```json
{
  "profile_schema_version": 1,
  "progress": {"completed_level_ids": [], "best_turns": {}},
  "settings": {"language": "en", "window_mode": "windowed", "reduced_motion": false}
}
```

Completed IDs are unique strings; best turns are positive integers. Unlocks are
derived from the current validated catalog, never serialized. There is no
in-progress puzzle save, named slot, account, cloud synchronization, ending-seen
flag, or unbounded migration. No legacy on-disk format currently exists; v1 is
the only initial migration boundary.

### Load, write, recovery, and reset

1. Missing file produces a clean v1 profile in memory; it need not write until
   the first intentional persistent change.
2. Parse only a bounded file size. Require the root, exact version, expected
   containers/types, catalog-known IDs, and valid positive turns. Drop unknown
   IDs and invalid best-turn entries deterministically; preserve only valid data.
3. Malformed, truncated, unreadable, or unknown-version data is never silently
   overwritten. Retain a bounded same-directory recovery copy with a non-secret,
   collision-safe suffix when possible, then continue from a clean in-memory
   profile and show a localized non-blocking recovery notice or Safe Error path.
   If a safe rename/copy cannot be completed, leave the original untouched and
   enter Safe Error rather than write over it.
4. Serialize to a unique temp sibling, flush/close, then replace the target with
   platform-supported replacement. Failure leaves the known-good target intact;
   remove only the temp file that this write created when safely identifiable.
   A later implementation must document the exact Godot 4.7 replacement API and
   test its Windows failure branch before claiming atomicity.
5. Reset belongs in Settings/profile management, not Level Select. It requires
   a destructive confirmation naming progress/best-turn loss. Confirmed reset
   deletes or reinitializes only this profile file, returns to the Main Menu
   clean-profile state, and never touches repository files or unrelated user
   data. Cancel is a no-op.

Tests receive an explicit test-only `user://` subdirectory/overridable profile
path created and removed inside the test fixture. Tests must prove that the
production profile path is never read, modified, or deleted. Rollback of a
product build cannot promise compatibility with a newer saved profile; therefore
profile schema changes require a separate compatibility task and a backup-first
policy. This slice stops on any path escape, destructive recovery, nonvalidated
catalog data, or inability to isolate tests.

## 3. Complete navigation contract

No new router is authorized. AppRoot retains route ownership; overlays may be
bounded presentation states of the active route.

| Profile | Main Menu availability | Flow and destructive actions |
|---|---|---|
| Clean | New Game (enabled); Continue (disabled with clear reason); Settings; Credits; Quit | New Game enters Level Select with only sequence 1 unlocked. Quit opens confirmation. |
| Partial | Continue (enabled); New Game (same clean-start intent, confirmation only if it would discard progress); Settings; Credits; Quit | Continue enters Level Select at its highest unlocked entry; New Game resets only after confirmation; Reset remains in Settings. |
| Completed | Continue (enabled); New Game (confirmation); Settings; Credits; Quit | Continue enters Level Select with all eight entries selectable and permits final replay; no automatic ending replay. |

```text
Boot -> validated catalog/profile load -> Main Menu
Main Menu -> New Game or Continue -> Level Select -> Gameplay
Gameplay -> Pause {Resume | Restart confirmation? | Level Select confirmation | Quit confirmation}
Gameplay final completion -> FINAL_ACKNOWLEDGEMENT_VISIBLE -> Level Select
Level Select Back -> Main Menu; Main Menu -> Settings/Credits -> Main Menu
Safe Error -> Main Menu only after the bounded condition is handled
```

Restart is immediate only if it already remains the accepted `R` behavior;
pause-menu Restart, leaving a live level, and application Quit require an
appropriate confirmation where state/progress could be lost or the application
would close. Pause is presentation/input suspension only: no Simulation turn,
Help route change, Timeline requirement, or progress record. Esc closes Help
first, then pause; it retains the Task 0021 final-acknowledgement Esc return.

## 4. Minimum settings contract

Settings are validated, defaulted, persisted through the profile, and applied
without changing current puzzle state:

| Setting | Decision | Contract |
|---|---|---|
| Language | IMPLEMENT | `en` and `zh-Hans`; apply existing UI after a bounded redraw/route refresh and retain selection. |
| Window mode | IMPLEMENT | `windowed` / `fullscreen`; validate enum and preserve the 960x540 keep-aspect presentation contract. |
| Reduced motion | IMPLEMENT | Static/less-motion presentation flag; default false; never changes rule timing or state. |
| Display scale / resolution | DEFER | Existing keep-aspect evidence is adequate; revisit only with a concrete Windows readability failure. |
| Master volume | OMIT_FOR_RC | There is no retained audio surface or bus; do not add a meaningless control. |
| Controller / Web controls | DEFER | Outside the Windows critical path. |

## 5. Localization, font, and bounded narrative copy

Use one centralized keyed-string service/table for English and Simplified
Chinese, rather than literal-by-literal exceptions. Coverage is mandatory for
Main Menu; New/Continue/Reset; Level Select and locks; Gameplay HUD/legend,
Help, Timeline, pause, confirmations and errors; final acknowledgement;
Settings; Credits; and README/public status where applicable. Language fallback
is English only when a key is missing during development; an RC requires zero
missing keys in either shipped language.

Font acquisition is **DEFERRED_PENDING_SEPARATE_LICENSED_FONT_TASK**. Before
import, a candidate must have Chinese glyph coverage, Windows redistribution and
modification rights, ledger evidence, attribution requirements, fallback
behavior, and 960x540 plus resized text-fit evidence. Do not rely on a
machine-default font as a release claim. Current procedural presentation stays
valid development baseline.

Narrative revision is a later localization/presentation slice using existing
surfaces only: a concise premise on Main Menu, progressively clearer objective
language/level-select framing, and a final acknowledgement whose late-but-heard
meaning is earned by earlier copy. It must remain readable, non-verbose,
non-route-revealing, mute-equivalent, and free of cutscenes, voice acting,
branching, rooms, or formal-level changes. This addresses the owner P3 finding
without claiming a new owner review or resolving Level 7's disclosed transition.

## 6. Credits, public status, and polish decisions

Credits is a simple AppRoot-reachable page generated from the authoritative
ledger/attribution facts; it contains no invented credits. README is corrected
in this documentation-only task to describe the playable eight-level internal
project honestly while retaining that persistence/settings/localization/assets,
export, RC, release, and submission are incomplete.

| Surface | Decision | Evidence boundary |
|---|---|---|
| Procedural current visuals | RETAIN_FOR_RC_BASELINE | No asset is required for puzzle comprehension. |
| Visual reskin | DEFER | Separate licensed asset selection/ledger task only. |
| Icon / splash | PLAN_REQUIRED_BEFORE_EXPORT | Need Windows packaging asset provenance and project-setting change in a later authorized slice. |
| Audio / music | OMIT_FOR_RC | No audio is retained; all comprehension must remain mute-equivalent. A future audio proposal requires license ledger, attribution, bus/event mapping, and mute acceptance. |
| Image Help | DEFER | Optional later presentation slice; not a persistence/menu/localization blocker. |
| Level 7 transition | DISCLOSED_RESIDUAL_LIMITATION | No new room or change is authorized here. |

## 7. Reversible implementation slices

| # | Objective / likely path domains | Prerequisites and acceptance | P0/P1 stop, rollback, non-claims |
|---|---|---|---|
| 1 **SELECTED** | Persistent local profile core and isolated tests; `scripts/app/`, focused `tests/app/`, test registration, docs | Contract above; clean/malformed/version/atomic-failure/isolation coverage; catalog and formal hashes unchanged | Stop on real-profile touch, unsafe overwrite, or semantic drift. Roll back adapter/test topic only. Not UI, migration breadth, cloud, or release readiness. |
| 2 | Menu New/Continue/Reset plus pause/quit-confirmation; AppRoot, existing UI scenes/scripts, focused tests | Slice 1 accepted; all three profile states and final acknowledgement preserved | Stop on route replacement, double record, input trap, or reset without confirm. Roll back flow topic only. Not settings/localization. |
| 3 | Persistent settings; profile adapter, AppRoot/presentation/UI, focused tests | Slice 1; enum/default/application tests and no puzzle-state mutation | Stop on resize/state regression or invalid default. Roll back settings topic only. Not accessibility certification. |
| 4 | Localization, licensed-font decision, bounded narrative copy; string service/resources, existing UI, docs/tests | Cleared font evidence before import; key and text-fit inventory | Stop on missing-language exception, illegal font, clipping, or route-revealing Help. Roll back presentation topic. Not cutscene/audio/owner closure. |
| 5 | Credits/Attribution, README, icon/splash, polish accept-or-defer closure | Ledger facts; separate asset authorization for any binary/import/project setting | Stop on invented attribution or unlicensed asset. Roll back documentation/presentation topic. Not export. |
| 6 | Complete-flow machine/capture acceptance; read-only product/test/capture/report domains | Slices 1–5 as selected; clean/partial/completed, corruption, pause, settings, both languages, 960x540/resize captures | Stop on P0/P1 failure or product drift; no repair in acceptance gate. Not owner review. |
| 7 | Owner-only complete-flow walkthrough; review/report docs | Slice 6 evidence; preserve owner-only/not-fresh/not-independent disclosure | Stop on P0/P1 owner issue; no autonomous product repair. Not independent evidence or acceptance. |
| 8 | Windows export/build validation; separately authorized export settings, package, tests, report | Slices 1–7 and resolved icon/license facts | Stop on toolchain/package/data-loss failure; rollback generated package only. Not RC, upload, release, or festival submission. |

## 8. Readiness matrix

| Area | Current | Expected status | Planned slice | Windows RC blocker / scope cut |
|---|---|---|---|---|
| Eight formal levels, deterministic rules, catalog | READY | READY | Preserve | Preserve byte-identically |
| Finale acknowledgement / bounded return | READY | READY | Preserve | Preserve Task 0021 contract |
| Level Select scrolling / Safe Error / window baseline | READY | READY | Preserve | Preserve existing contracts |
| Persistent profile and reset safety | MISSING | READY | 1–2 | RC blocker until accepted |
| New/Continue/pause/confirmations/Credits | MISSING | READY | 2 then 5 | RC blocker until accepted |
| Settings | MISSING | READY | 3 | RC blocker until accepted |
| EN + zh-Hans localization/font | MISSING | PARTIAL | 4 | RC blocker until licensed font proven |
| Narrative weight / Help clarity | PARTIAL | PARTIAL | 4 | Optional quality; owner P3 remains disclosed |
| Attribution / visual assets / icon/splash | PARTIAL | PARTIAL | 5 | Icon/splash RC blocker; reskin scope cut |
| Audio | NOT_APPLICABLE | NOT_APPLICABLE | Omit | Explicit `OMIT_FOR_RC` |
| Complete-flow capture / owner review | MISSING | READY | 6 | RC blocker; owner limitation remains disclosed |
| Windows export/version/package evidence | MISSING | READY | 8 | RC blocker |
| Controller, Web, cloud/accounts, named slots, cutscenes | DEFERRED | DEFERRED | None | Explicit scope cuts |

## 9. Boundaries and review

This is a plan, not authorization to write product code, create player data,
acquire/import assets, fonts or audio, build/export, conduct owner review, or
release/submit. Every implementation slice needs a new task with its own
authorized paths and acceptance evidence. GPT Project Sources retains final
acceptance; the owner retains product choices, licensing, accounts, release,
and irreversible actions.

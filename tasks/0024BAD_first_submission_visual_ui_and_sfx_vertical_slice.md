# Task 0024BAD — First submission visual/UI and essential-SFX vertical slice

- Status: `READY`
- Repository/root/branch: `zcx369658780/delayed-self-godot` / `D:\Delayed_Self` / `main`
- Required checkpoint: `d1738ea0f63e2aa625e6e78f3222dd474b234cc2`
- Previous gate: `TASK_0024BAC_DEEPSEEK_WRAPPER_WORKER_IDENTITY_BASELINE_ACCEPTED`
- Owner decisions: `10_OF_10_ACCEPTED_AS_RECOMMENDED`
- Scope: stable eight levels; catalog 8; sequence 8 sole finale
- S04/0024BB: deferred post-submission
- Visual: `RECOMMEND_VISUAL_V1`
- Font: `RECOMMEND_DUAL_FONT_TEST_GATE`
- Audio: `RECOMMEND_AUDIO_A1`
- Fallback: `ESSENTIAL_SFX_ONLY_NO_MUSIC`
- Music/font/third-party graphic runtime import: not authorized
- Profile/catalog/finale/build/release/submission: not authorized
- Multi-subagent: mandatory

## Objective

Implement one real submission-facing visual/audio vertical slice:

1. project-native paper/ink visual-token foundation;
2. gameplay board reskin for production-eight common mechanics;
3. shared styling for main menu and level select;
4. six deterministic project-created SFX and first audio buses/router;
5. full production-eight regression and real runtime review captures;
6. Crow Producer music-license evidence and a bounded CC0 graphic-source shortlist;
7. no music, font or third-party graphic import;
8. one commit and push; truthful `PASS_FOR_GPT_REVIEW`, `BLOCKED` or `UNVERIFIED`.

This is not the final reskin or full fourteen-SFX rollout.

## Frozen owner defaults

```text
visual_strategy_approval = RECOMMEND_VISUAL_V1
paper_ink_direction_approval = HAND_DRAWN_DELAYED_NOTEBOOK_KEEP
YOU_ECHO_shape_approval = YOU_AND_ECHO_GEOMETRIC_SEPARATION
UI_density_approval = KEEP_MIN_DENSITY
font_recommendation_approval = RECOMMEND_DUAL_FONT_TEST_GATE
music_shortlist_audition = AUDITION_WITH_OWNER_ON_GATED_IMPORT_LIST
music_license_evidence_available = SELECT_TRACK_AFTER_LEGAL_EVIDENCE
SFX_strategy_approval = RECOMMEND_AUDIO_A1
finale_music_optional_or_required = OPTIONAL
no_music_fallback_acceptance = YES
```

## Mandatory GPT roles

Use at least:

```text
planner_high
docs_reader
code_mapper
impl_worker
code_reviewer
```

`docs_writer` is recommended. Main agent alone owns scope, interfaces, Godot/tests, integration, Git and verdict. Subagents never commit/push, access Profile, consume retained manifests or expand scope.

## Optional DeepSeek

DeepSeek is optional and never counts as a GPT role. Before use verify accepted wrapper/worker/CLI identities. The only route is:

```powershell
& "C:\Users\zcxve\.codex\helpers\Invoke-DeepSeekFileTask.ps1" `
  -TaskFile "<absolute secret-free task JSON>"
```

If used, it may edit exactly one new low-risk file:

```text
docs/licenses/EXTERNAL_FREE_ASSET_SOURCE_SHORTLIST_CURRENT.md
```

No code, tests, scenes, assets, audio, manifests, reports or current pointers. Any drift fails closed without MCP/native fallback. GPT-5.6 reviews every byte.

## Required reads

Read AGENTS/current task/startup, 0024BAC acceptance/report, owner decision acceptance/sheet, visual/audio plans and manifests, critical path/readiness, license ledgers, `project.godot`, app root, main menu, level select, vertical slice, presentation helper, Simulation, catalog, eight level JSONs, aggregate and owned wrapper.

Resolve exact main-menu and level-select script paths before writing. Freeze the final path allowlist; do not widen it later.

## External-source audit

### Crow Producer

Sources:

```text
https://www.bilibili.com/video/BV1uFcwe1EDV
https://drive.google.com/drive/folders/1ce8LP87A2Yc1xRLvaCpZr13KI5S-f_Aw?usp=sharing
https://drive.google.com/file/d/1ID9Fy3Xmt7erOrORCblrEuGxMQsG1nhv/view
```

Record only source-supported terms:

```text
copyright retained by 乌鸦Producer
commercial-game use allowed without extra royalty
required credit = 音乐由[乌鸦Producer]提供
non-exclusive
no direct resale
applicable-law compliance
editing/conversion permission unresolved
```

Record audition metadata, but do not download/import/play music:

```text
晚安，星期八.wav | Drive 1zucejf8-pe6sjPPe2fuVw62qY8F6icrY | 34,440,316 bytes | menu
优哉游哉(loop).wav | Drive 1_l8gcHescLwdhJ3X_8Xco48zYX96vRSO | 25,404,968 bytes | gameplay
宇宙，我，和她.wav | Drive 10O2IFtbbm4xkZ-mS3h8ZVi8YObAzDiSH | 45,826,638 bytes | optional finale
```

Create `docs/licenses/CROW_PRODUCER_MUSIC_LICENSE_EVIDENCE_CURRENT.md`.

### Free graphics shortlist

Audit at most four sources:

```text
https://kenney.nl/assets/roguelike-rpg-pack
https://screamingbrainstudios.itch.io/tiny-top-down-pack
https://nieobie.itch.io/free-icons
https://myuxen.itch.io/ultimate-ui-pixel-asset-pack
```

Keep only sources with explicit CC0-1.0 or equally clear commercial terms. Record author, license, modification/attribution/redistribution terms, formats, style fit and possible secondary use. Core YOU/ECHO/terrain/Plate/Door remains project-native. No pack download/import.

Create `docs/licenses/EXTERNAL_FREE_ASSET_SOURCE_SHORTLIST_CURRENT.md`.

## Visual implementation

Create a pure deterministic visual layer, recommended:

```text
scripts/presentation/submission_visual_theme.gd
```

No game logic, Profile/catalog/file access or alternate state store. Preserve 960x540, 60-pixel logical cell, reduced-motion/static fallback and shape/text redundancy.

Apply to real runtime:

```text
scenes/vertical_slice/vertical_slice.tscn
scripts/gameplay/vertical_slice.gd
scenes/ui/main_menu.tscn
actual main-menu script
scenes/ui/level_select.tscn
actual level-select script
```

Required gameplay families:

```text
paper field
floor sparse ticks
wall dense hatch
YOU solid core + Y
ECHO dashed/double outline + E2/E3/E4
exit double diamond
plate inactive/active structural difference
door closed bars/open frame
blocked X
timeline current/echo/action glyphs
```

Required UI slice:

```text
paper field
ink panel/button style
double focus outline
locked/available/selected/completed level marks
minimal density
```

No state may depend on color alone. Simulation, geometry, input, route signals, completion and restart remain unchanged.

Produce at least two real 960x540 PNGs under `docs/reviews/evidence/0024BAD/`: gameplay plus main-menu or level-select. Record SHA and capture command/path. No mockups or generated concept art.

## Six-SFX baseline

Implement exactly:

```text
ui_focus_or_move
ui_confirm
YOU_move
ECHO_move
blocked_or_invalid
level_complete
```

Create deterministic standard-library generator:

```text
tools/audio/generate_submission_sfx.py
```

Generate mono 16-bit PCM WAV at 44.1 or 48 kHz:

```text
audio/sfx/ui/focus_move.wav
audio/sfx/ui/confirm.wav
audio/sfx/gameplay/you_move.wav
audio/sfx/gameplay/echo_move.wav
audio/sfx/gameplay/blocked_invalid.wav
audio/sfx/gameplay/level_complete.wav
```

No sampled/external audio, network, ambiguous randomness or OGG conversion. Rerun must be byte-identical.

Create/update `default_bus_layout.tres` with `Master`, `UI`, `Gameplay`, `Music`.

Create a bounded router, recommended:

```text
scripts/audio/submission_sfx_router.gd
```

It preloads only six WAVs, maps accepted events to buses/resources, contains no gameplay decisions, suppresses focus spam, distinguishes YOU/ECHO without stereo dependence, never plays movement on blocked action, plays completion once and remains valid with silent Music bus.

Integrate only main-menu/level-select focus+confirm, successful YOU move, successful ECHO replay move, blocked/invalid cardinal action and first completion transition.

## Tests

Create focused visual and audio tests under `tests/presentation/` and `tests/audio/`, plus task-owned helpers.

Required proof:

- visual descriptors deterministic and state-pure;
- all required visual families present;
- color-ignored YOU/ECHO, floor/wall, plate and door signatures differ;
- E2/E3/E4 readable;
- UI focus/locked/selected/completed signatures differ;
- bounds stay within 960x540;
- restart restores snapshot;
- generator rerun byte-identical;
- WAVs parse/load and buses exist;
- event map deterministic;
- blocked/YOU/ECHO/completion cue semantics exact;
- no Music resource loaded;
- audio never changes canonical state/history/completion;
- all eight production levels load and regress unchanged.

Run focused tests, current Aggregate, complete-v2, app/menu/select tests and eight-level solver/replay regression through the accepted owned wrapper. Fresh processes, cleanup once, no PID residue, final Godot zero. Use a fresh retained identity only if current project policy explicitly requires one; never reuse historical manifests.

## Documents

Update owner decision sheet, visual/audio manifests, UI matrix, readiness, critical path and current license/attribution ledgers.

Create:

```text
docs/licenses/CROW_PRODUCER_MUSIC_LICENSE_EVIDENCE_CURRENT.md
docs/licenses/EXTERNAL_FREE_ASSET_SOURCE_SHORTLIST_CURRENT.md
docs/presentation/SUBMISSION_VISUAL_AUDIO_VERTICAL_SLICE_CONTRACT_CURRENT.md
docs/reports/0024BAD_FIRST_SUBMISSION_VISUAL_AUDIO_VERTICAL_SLICE_REPORT.md
docs/handoffs/DELAYED_SELF_SESSION_HANDOFF_AFTER_TASK_0024BAD_VISUAL_AUDIO_SLICE_2026_07_27.md
```

Update current task/startup/index/development/handoff/memory. Successful items become `IMPLEMENTED_BASELINE_OWNER_REVIEW_PENDING`; six SFX implemented, eight remain planned; music remains audition/license-only; imported music/third-party graphics/fonts remain zero.

## Authorized paths

Only:

```text
default_bus_layout.tres
scripts/presentation/submission_visual_theme.gd(.uid)
scripts/audio/submission_sfx_router.gd(.uid)
tools/audio/generate_submission_sfx.py
six WAV paths listed above
vertical-slice scene/script
main-menu scene/exact script
level-select scene/exact script
new 0024BAD presentation/audio tests and helpers
docs/reviews/evidence/0024BAD/*.png
new/update docs explicitly listed in this task
```

The exact two UI script paths must replace placeholders before writing. No additional runtime path after implementation begins.

## Protected

Do not modify `project.godot`, catalog, level JSONs, Simulation, solver, Profile/app-root/profile scripts, schemas, existing tests, localization, music, fonts, shaders, build/export/release/submission, historical evidence, S04 or user-level configuration/infrastructure. No external graphic files.

## Startup/failure

Require synchronized clean main, checkpoint ancestry, only unchanged `.codex/config.toml`, accepted Godot and zero process count. Freeze protected hashes. Stop on drift, Profile need or unsupported render/audio seam.

Return `BLOCKED` for mechanics/route change, unreadable shape distinction, overflow, nondeterministic WAV, missing/duplicated cues, license overclaim, music/font/third-party import, protected change, Profile access or process ambiguity. Return `UNVERIFIED` for bounded test/capture limits without defect.

## Commit

Require catalog 8, finale 8, S04 deferred, zero level/Simulation/solver/Profile changes, zero music/font/third-party imports, exactly six WAVs, at least two review PNGs and Godot zero.

Exactly one commit:

```text
feat: add submission visual and SFX vertical slice
```

Explicit stage only; full staged review; no amend/rebase/squash/force push/second commit. Push main and verify clean synchronized remote.

## Verdict fields

```text
owner_visual_audio_decisions = 10_OF_10_ACCEPTED_RECOMMENDED_DEFAULTS
visual_slice_status = IMPLEMENTED_BASELINE_OWNER_REVIEW_PENDING / BLOCKED / UNVERIFIED
visual_required_families = <exact>/<exact>
UI_surfaces_reskinned = <exact>
generated_SFX = 6
SFX_router_status = PASS / FAIL / NOT_VERIFIED
visual_snapshot_deterministic = YES / NO / NOT_VERIFIED
SFX_bytes_deterministic = YES / NO / NOT_VERIFIED
production_eight_regression = PASS / FAIL / NOT_VERIFIED
review_capture_count = <exact>
Crow_Producer_license_status = COMMERCIAL_USE_ATTRIBUTION_CONFIRMED_EDIT_CONVERSION_UNRESOLVED / OTHER
music_imported = NO / YES
third_party_graphics_imported = NO / YES
font_imported = NO / YES
DeepSeek_optional_delegation = NOT_USED / USED_ACCEPTED / USED_REJECTED / BLOCKED_FAIL_CLOSED
production_catalog_modified = NO / YES
formal_finale_modified = NO / YES
Profile_accessed = NO / YES
next_gate = OWNER_VISUAL_AUDIO_VERTICAL_SLICE_REVIEW / BLOCKED / UNVERIFIED
final_task_verdict = PASS_FOR_GPT_REVIEW / BLOCKED / UNVERIFIED
```

Success opens only `OWNER_VISUAL_AUDIO_VERTICAL_SLICE_REVIEW`. Full UI rollout, remaining SFX, font/zh-Hans, music audition/import, external graphic import and build remain closed. S04 stays deferred.

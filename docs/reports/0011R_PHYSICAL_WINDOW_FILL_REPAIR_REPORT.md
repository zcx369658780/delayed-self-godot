# Task 0011R physical-window fill repair report

## Task and Git facts

- Task: `tasks/0011R_physical_window_fill_scaling_and_centering_repair.md`
- Repository/root: `zcx369658780/delayed-self-godot`, `D:\Delayed_Self`
- Branch: `main`
- Starting local `HEAD` and `origin/main`: `9bac777f27c0d42be9b801ff8ce97c611900ab52`
- Accepted presentation implementation: `c26d8be1c97dbe057f633b55ea7689f35272c577`
- Accepted owner evidence: `39d0882e90771c1c54ebdb6477f560e81168fa9e`
- Toolchain: Godot `4.7.stable.steam.5b4e0cb0f`, Compatibility renderer
- Commit policy: exactly one implementation/documentation commit, `fix: scale and center Delayed Self window content`
- External evidence: `D:\Delayed_Self_Evidence\0011R_window_fill_repair\EVIDENCE_INDEX.md`

The startup worktree was clean and was fast-forwarded from `39d0882e90771c1c54ebdb6477f560e81168fa9e` to the task baseline before any write. The implementation remains pending GPT review and owner retest.

## Root-cause diagnosis

The defect was caused by four incorrectly scoped keys in `project.godot`. Under the existing `[display/window]` section, the file used:

```text
window/size/viewport_width
window/size/viewport_height
window/stretch/mode
window/stretch/aspect
```

Godot concatenated the section and property names, registering them as non-authoritative `display/window/window/...` keys. The intended values existed only at those erroneous paths. The effective Godot 4.7 settings remained engine defaults: viewport `1152×648` and content-scale/stretch mode `disabled`.

The exact hierarchy is the Window/root Viewport, `AppRoot` Node, full-rect `RouteHost` Control, and one active Main Menu, Level Select, Gameplay, or Safe Error screen. Gameplay is a Node2D with a CanvasLayer and accepted fixed logical coordinates. With scaling disabled, resizing the 1280×720 client expanded the root Viewport and RouteHost to 1280×720, while Gameplay still drew its accepted background and UI only in `[0,0,960,540]`. That produced a 320 px right strip and 180 px bottom strip joined as the owner-reported gray L shape.

Changing only the background color would have hidden neither the native-size top-left content nor the incorrect transform. It would have been a cosmetic fake fix, so it was rejected.

## Before and after measurements

Before repair:

- normal startup effective client/logical size: `1152×648`;
- effective stretch mode: `disabled`;
- explicit probe outer window: `1298×767`;
- explicit probe client: `1280×720`;
- root Viewport and RouteHost after resize: `1280×720`;
- fixed logical content rectangle: `[0,0,960,540]`;
- unused remainder: 320 px on the right and 180 px on the bottom.

After repair:

| Route/case | Outer | Client | Content rectangle | Scale | Bars |
|---|---:|---:|---|---:|---|
| Main Menu | 978×587 | 960×540 | `[0,0,960,540]` | 1.0 | none |
| Level Select | 978×587 | 960×540 | `[0,0,960,540]` | 1.0 | none |
| Level 5 exact 16:9 | 1298×767 | 1280×720 | `[0,0,1280,720]` | 4/3 | none |
| Level 5 wide | 1458×767 | 1440×720 | `[80,0,1280,720]` | 4/3 | left/right 80 px |
| Help exact 16:9 | 1298×767 | 1280×720 | `[0,0,1280,720]` | 4/3 | none |
| Level 4 open result | 1298×767 | 1280×720 | `[0,0,1280,720]` | 4/3 | none |
| Resize with Help open | 1298×847 | 1280×800 | `[0,40,1280,720]` | 4/3 | top/bottom 40 px |

The exact 16:9 case has no remainder or offset. Wide and tall clients use only the necessary axis and symmetric bars. The bars are intentionally black, consistent with the dark presentation, rather than the pre-repair default gray region.

## Implementation

`project.godot` now uses the valid Godot 4.7 keys:

```text
display/window/size/viewport_width=960
display/window/size/viewport_height=540
display/window/stretch/mode="canvas_items"
display/window/stretch/aspect="keep"
```

This retains 960×540 as the only logical layout coordinate system. Godot's built-in content scaling performs the authoritative uniform transform and centering; no manual CanvasItem transform, responsive HUD reflow, or 1280×720 logical migration was introduced. The existing default resize policy remains enabled.

`scripts/app/window_presentation.gd` records the frozen logical size, intentional black bar color, and a pure reference transform equivalent to `min(W/960,H/540)` with centered offsets. `scripts/app/app_root.gd` sets the clear background from that policy and exposes a read-only snapshot used by tests and evidence. The policy does not handle input, call simulation, reload routes, or own rendering geometry.

No scene or Gameplay file required modification. All screens already enter the same full-rect `RouteHost`; fixing the root content-scale settings makes Main Menu, Level Select, Gameplay, Help, completion surfaces, and Safe Error follow the same transform.

## Tests and state invariants

The focused test was developed in vertical RED→GREEN slices:

1. valid 960×540 and `canvas_items` setting assertions failed against the erroneous double-window keys, then passed after the four-key correction;
2. exact/wide/tall reference-transform assertions failed before the policy helper existed, then passed with uniform centered transforms;
3. intentional bar color and shared AppRoot policy assertions failed, then passed after the minimal AppRoot integration.

Final repository tests cover:

- exact 960×540 logical reference;
- exact 16:9 fill;
- symmetric pillarboxing and letterboxing;
- deterministic/idempotent transforms;
- shared RouteHost policy for Main Menu, Level Select, Gameplay/Help, and Safe Error;
- dark intentional bars;
- unchanged accepted Gameplay and Help logical rectangles;
- resize with Help open preserving exact state, history, turn, canonical key, and route;
- the existing five-level reachability/completion, unlock, input-order, rapid-input, replay, and restart checks.

The resize path is Godot's built-in viewport transform. It contains no call to `Simulation.transition`, no synthesized input, and no progress or route mutation.

## Regression

Preflight retained the six accepted markers at `assertions=301 vectors=9`. Final aggregate result:

```text
TASK_0003_TESTS_PASS assertions=314 vectors=9
TASK_0006_APP_SHELL_TESTS_PASS
TASK_0007_TUTORIAL_LEVELS_TESTS_PASS
TASK_0008_PROGRESSIVE_HUD_TESTS_PASS
TASK_0009AR_LEVELS_4_5_TESTS_PASS
TASK_0011_PRESENTATION_RECOVERY_TESTS_PASS
TASK_0011R_WINDOW_FILL_TESTS_PASS
```

Accepted metrics and controls remain unchanged:

| Level | L* | N* | Count | Visited | Frontier | Controlled-unsolved |
|---|---:|---:|---|---:|---:|---|
| Tutorial 0 | 3 | 3 | EXACT | 6 | 2 | not applicable |
| Tutorial 1 | 9 | 12 | EXACT | 1,975 | 509 | no ECHO: 10 visited |
| Level 3 | 9 | 31 | EXACT | 1,318 | 393 | isolated ECHO: 1,006 visited |
| Level 4 | 9 | 7 | EXACT | 291 | 116 | no ECHO: 5 visited |
| Level 5 | 12 | 1 | EXACT | 1,260 | 225 | no ECHO: 8 visited |

Formal level SHA-256 values remain:

- `tutorial_reach_exit`: `38e466bb5922f1987a99d79c7527a4a8eab8e6cfdbe76fd8159f80b0a40cf2c4`;
- `tutorial_echo_bridge`: `681d99057c4e6034a490644d75960ff23d8f43bd1b91850f48179b79fc04a3cf`;
- `vertical_slice_delay_3`: `8751da5051fbebaaa5ae7c895d9be9f086e8d8f2e87876a80c379dc06262f1d8`;
- `door_one_turn_late`: `1775cf89ae4a94f65a76dac2b791a31395443de88205d0ed1b6233331dbda577`;
- `two_keys_one_door`: `f4c6791dfc84d17fb450721e654091a2baeb522e55d660a5d73878cd977651cd`.

Routes, unlock results, rapid-input order, simulation semantics, 60 px logical board pitch, HUD zones, Help, Timeline, Door/Plate/ECHO feedback, and reduced-motion substitute remain unchanged.

## Changed repository paths

Implementation/configuration:

- `project.godot` — correct four exact display/window setting paths;
- `scripts/app/window_presentation.gd` — pure logical-to-client reference policy and bar color;
- `scripts/app/app_root.gd` — apply the intentional clear background and expose read-only policy evidence.

Tests/evidence harness:

- `tests/app/task_0011r_window_fill.gd`;
- `tests/app/capture_task_0011r.gd`;
- `tests/run_all.gd`.

Documentation:

- this report;
- the six narrowly updated current startup/task/index/plan/handoff/project-memory documents.

No scene, Gameplay, simulation, solver, schema, level, catalog, fixture, asset, font, audio, import, dependency, save, export, build, release, account, or repository-setting surface outside the exact repair changed.

## External evidence

`D:\Delayed_Self_Evidence\0011R_window_fill_repair\EVIDENCE_INDEX.md` records commands, privacy boundary, before/after diagnosis, outer and client sizes, content rectangles, scale/bar measurements, final game-window-only PNGs, UTC timestamps, sizes, and SHA-256 hashes. External evidence, logs, diagnostic scripts, screenshots, and `.godot` data are not staged.

## Rollback

If GPT rejects the repair, preserve history and create a normal revert of the single Task 0011R commit. That revert restores the previous four invalid project-setting lines, removes the window-presentation helper and focused tests/capture harness, restores AppRoot and `tests/run_all.gd`, and restores the prior current-document pointers. Re-run the accepted preflight suite afterward. Do not use reset, rebase, amend, broad checkout/restore, or force-push.

## Protected surfaces and non-claims

This repair does not claim owner approval, fresh or independent review, final responsive layout, final art, asset/font clearance, accessibility, localization, licensed audio/narrative, Level 6, new Gate semantics, save/settings, complete flow, export, Web, release, or submission readiness. WAIT remains `DEFERRED_VALIDATION_RESEARCH`; the latched/one-shot Gate remains `DRAFT_NOT_ACCEPTED`.

## Recommendation

Recommend GPT review this focused repair and, if accepted, issue the required short authenticated-owner window-fill retest. Level 6 `staggered_doors` remains separately gated and must not start until the repair and owner confirmation are accepted.

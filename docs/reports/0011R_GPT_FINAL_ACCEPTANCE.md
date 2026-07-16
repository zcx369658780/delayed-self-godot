# Task 0011R GPT final acceptance

- Verdict: `TASK_0011R_PHYSICAL_WINDOW_FILL_REPAIR_ACCEPTED_PENDING_OWNER_RETEST`
- Accepted implementation commit: `a07c4be075aaa5c57e9d48869392f29dadaaa1d5`
- Accepted task: `tasks/0011R_physical_window_fill_scaling_and_centering_repair.md`
- Acceptance date: 2026-07-16
- Accepted by: GPT Project Sources advisor

## Review basis

GitHub review confirmed that the implementation is exactly one commit ahead of the Task 0011R issue point and changes only the authorized display/window settings, AppRoot window-presentation policy, focused tests/capture harness, implementation report, and narrowly necessary current-document surfaces.

No scene, Gameplay presentation, simulation, LevelLoader, solver, schema, formal level, catalog, fixture, progress semantic, asset, font, audio, import, save, export, build, release, account, or unrelated repository-setting surface changed.

## Accepted diagnosis

The prior physical-window defect was caused by four incorrectly scoped keys under the `[display/window]` section of `project.godot`:

- `window/size/viewport_width`;
- `window/size/viewport_height`;
- `window/stretch/mode`;
- `window/stretch/aspect`.

Godot therefore registered ineffective `display/window/window/...` properties. The effective Godot 4.7 configuration remained at its defaults, including a `1152×648` viewport and disabled content scaling. When the physical client became `1280×720`, the root Viewport and RouteHost expanded while the accepted Gameplay composition continued drawing only inside `[0,0,960,540]`, producing the owner-observed right/bottom L-shaped remainder.

Changing only the gray background would not have repaired the transform and is not accepted as a valid solution.

## Accepted repair

The implementation now uses the valid Godot 4.7 properties:

```text
display/window/size/viewport_width=960
display/window/size/viewport_height=540
display/window/stretch/mode="canvas_items"
display/window/stretch/aspect="keep"
```

Accepted behavior:

1. `960×540` remains the only logical layout coordinate system.
2. Godot's built-in content scaling owns the authoritative uniform transform and centering.
3. Exact larger 16:9 client areas fill completely with no right/bottom remainder.
4. Wider or taller client areas use only the necessary axis and produce symmetric intentional black bars.
5. Main Menu, Level Select, Gameplay, Help, completion surfaces, and Safe Error share the same root policy.
6. Runtime resize/maximize does not reload routes, call `Simulation.transition`, synthesize input, change progress, or modify puzzle state.
7. The accepted 60 px board, HUD zones, Help, Timeline, Door/Plate/ECHO feedback, and reduced-motion behavior remain unchanged in logical coordinates.

The pure `window_presentation.gd` helper is accepted as a reference/evidence policy only. It does not own gameplay input or puzzle rendering geometry.

## Accepted measurements

Accepted evidence includes:

- `1280×720` client → content `[0,0,1280,720]`, scale `4/3`, no bars;
- `1440×720` client → content `[80,0,1280,720]`, symmetric 80 px pillarbox bars;
- `1280×800` client → content `[0,40,1280,720]`, symmetric 40 px letterbox bars;
- Help-open resize preserving route, turn, history, canonical key, and state.

## Accepted regression

The final repository suite records:

```text
TASK_0003_TESTS_PASS assertions=314 vectors=9
TASK_0006_APP_SHELL_TESTS_PASS
TASK_0007_TUTORIAL_LEVELS_TESTS_PASS
TASK_0008_PROGRESSIVE_HUD_TESTS_PASS
TASK_0009AR_LEVELS_4_5_TESTS_PASS
TASK_0011_PRESENTATION_RECOVERY_TESTS_PASS
TASK_0011R_WINDOW_FILL_TESTS_PASS
```

All five formal hashes, solver metrics, controlled-unsolved results, routes, unlock results, replay/restart behavior, rapid-input order, and simulation semantics remain unchanged.

## Observations and non-claims

- This acceptance establishes root-cause correctness, implementation scope, runtime evidence, and regression conformance.
- It does not yet establish direct owner confirmation that the visible L-shaped remainder is gone on the owner's machine.
- It does not establish responsive HUD reflow, final art, final dependency visualization, accessibility, localization, asset/font clearance, audio, narrative, Level 6, Gate semantics, save/settings, complete flow, export, Web, candidate, release, or submission readiness.
- WAIT remains `DEFERRED_VALIDATION_RESEARCH`.
- The latched/one-shot Gate remains `DRAFT_NOT_ACCEPTED`.
- A qualifying fresh/independent review remains mandatory before candidate acceptance.

## Next gate

`Task 0011RV — short owner window-fill retest` is authorized as a documentation-only gate. It must verify on the owner's machine that normal startup, maximize/resize, Main Menu, Level Select, one Gameplay screen, and Help use the available physical client area correctly, with no top-left native-size canvas or right/bottom L-shaped remainder and no input/state regression.

If the owner confirms the repair with P0=0/P1=0 and no material remaining window-fill P2, GPT may authorize the planned difficult Level 6 `staggered_doors`. No licensed asset/font slice is required before that content task unless the owner explicitly changes priority.
# Presentation, viewport, and HUD direction (CURRENT)

- Status: `PLANNING_RECOMMENDATION_FOR_GPT`
- Task: [`0010`](../../tasks/0010_presentation_difficulty_asset_audio_narrative_and_gate_planning.md)
- Runtime authority: presentation reads committed `simulation_v1` state and never changes puzzle outcomes.
- Evidence labels: `SOURCE_MEASURED`, `RUNTIME_OBSERVED`, and `ESTIMATED` are intentionally distinct.

## Decision summary

Recommend **Option A: retain the 960×540 logical viewport and rebuild the Gameplay composition around a board-first 60 px grid**. Use a compact right rail, remove the permanent bottom control line after initial discovery, make `H` a modal reference card, and show the timeline contextually. This is the lowest-risk way to address the owner's board-size and information-value findings without changing project settings or asset-resolution assumptions.

Use **Option B: 1280×720** as the fallback only if a later 960×540 implementation capture cannot meet the board, Chinese-text, and accessibility criteria below. Responsive Option C remains a later desktop-resize enhancement, not the immediate baseline.

No layout, viewport, scene, or copy change is implemented by this document.

## Task 0015 bounded implementation fact

Level 7 adds only reusable primitive cues in `scripts/gameplay/vertical_slice.gd`: data-derived A/triangle, B/circle, `A+B` independent pips, E2 solid outline, E4 double-dashed outline, and overlap-preserving badges. Eight native 960×540 captures, including grayscale, passed. This does not change the viewport, board/right-rail layout, Timeline model, Help architecture, font/assets, or the broader presentation recommendation.

## Task 0015V owner evidence

The owner found A/B labels/shapes clear, understood E2/E4 different delays, and could distinguish overlapping actors despite crowding. The owner did not use Timeline and said reverse-counting it was harder than the puzzle. Help was opened but did not enable completion. The owner then inferred that physical ECHO spacing was invariant and that the machine-solvable level was impossible. This is a non-promotion P2 presentation/difficulty finding, not authorization to change Timeline, Help, delay, geometry, Door semantics, color, art, or animation. A separately bounded diagnostic/repair task should compare minimal ways to expose route/obstacle-induced relative-position changes before Level 8.

## Task 0015D repair direction

Task 0015D deterministically shows that signed and Manhattan E2/E4 spacing changes across the accepted route and that the exact owner screenshot state remains solvable. The selected later repair is a reusable transition-derived cue: identify E2/E4 moved/blocked outcomes and pulse `ECHO SPACING CHANGED` only when committed before/after positions justify it. It must remain non-route, non-solver, non-Timeline-dependent, 960×540 legible, grayscale-readable, and preserve existing badge/outline and A/B shape cues. Formal Level 7, scenes, Help, Timeline, viewport, and project settings remain unchanged under the primary plan.

## Task 0015R implementation fact

Task 0015R implements the accepted cue in reusable Gameplay. It consumes returned before/after ECHO positions and actual replay actions, classifies `MOVED/BLOCKED/WAITED`, orders actors by delay/ID, and shows `ECHO SPACING CHANGED` only when signed or Manhattan spacing changes. The compact badge occupies `Rect2(24, 66, 540, 18)`, between the goal strip and board; endpoint rings/symbols are drawn beneath actors. Stable spacing, zero/single ECHO, A+B convergence, restart, load, and completion remain cue-free. Ten native 960×540 captures, reduced-motion, grayscale, and overlap audits pass without changing scenes, Help, Timeline, viewport, formal data, or project settings. Owner comprehension remains pending a separate retest.

## Current-state measurement

### Viewport and window behavior

| Fact | Value | Confidence / consequence |
|---|---:|---|
| Logical viewport | 960×540 | `SOURCE_MEASURED` from `project.godot` |
| Stretch | `canvas_items`, aspect `keep` | `SOURCE_MEASURED`; source inspection indicates uniform scaling with preserved aspect, not responsive reflow |
| Explicit physical window override | none recorded | `SOURCE_MEASURED`; the logical size is the only repository default |
| Compatibility renderer | enabled | `SOURCE_MEASURED` |
| Runtime capture | 960×540, OpenGL Compatibility on the accepted Windows/GPU toolchain | `RUNTIME_OBSERVED` on 2026-07-16; all seven existing capture paths completed |
| Larger OS window | expected to scale the 960×540 canvas uniformly and letterbox/pillarbox on aspect mismatch | `ESTIMATED` from the stretch configuration; it does not create a larger logical board or reflow HUD regions |

The owner's accepted observation that a larger window still felt board-small is consistent with this configuration: enlarging the OS window scales the complete composition, including its unused space and HUD, rather than reallocating it.

### Board geometry

- Board origin: `(48, 150)` logical pixels (`SOURCE_MEASURED`).
- Cell pitch: `54 px`; drawn cell rectangle: `51×51 px` (`SOURCE_MEASURED`).
- Current board drawing reserves the full formal grid, including wall cells.

| Level | Formal grid | Grid footprint at 54 px | Traversable cells | Drawn traversable-cell share of 960×540 |
|---|---:|---:|---:|---:|
| Tutorial 0 | 5×4 | 270×216 | 6 | 3.01% |
| Tutorial 1 | 7×6 | 378×324 | 16 | 8.03% |
| Level 3 | 9×4 | 486×216 | 13 | 6.52% |
| Level 4 | 7×7 | 378×378 | 9 | 4.52% |
| Level 5 | 9×7 | 486×378 | 13 | 6.52% |

Grid footprints and cell shares are `SOURCE_MEASURED`; percentage uses `traversable_count × 51² / (960×540)`. It is a useful allocation indicator, not a claim about perceptual salience. The maximum grid footprint uses 35.44% of the logical viewport, while the sparse active floor uses at most 8.03%.

The 7-row boards occupy `y=150..528`. The permanent History/control label occupies `y=420..520`; therefore it overlays the lower two board rows. This overlap is both `SOURCE_MEASURED` and visible in the `RUNTIME_OBSERVED` Level 4/5 captures.

### HUD regions and type

| Region | Source rectangle | Font | Current behavior |
|---|---:|---:|---|
| Objective | x 48–560, y 24–132 | 18 | always present; standard mode collapses after first input |
| Status | x 590–925, y 24–190 | 22 | permanent title, turn, first Echo delay, first Door status |
| Timeline | x 590–935, y 195–330 | 15 | permanent when Echo exists and level is incomplete |
| Legend | x 590–925, y 335–455 | 14 | permanent compact key; expanded in Help |
| History/controls | x 48–575, y 420–520 | 16 | permanent one-line controls after initial collapse |
| Completion | x 130–555, y 210–330 | 28 | conditional overlay |
| Board labels | actor 15; EXIT 14 | fallback font | drawn in the board layer |

All values are `SOURCE_MEASURED`. The smallest persistent HUD text is 14 px. The right rail consumes about 370 px from x=590 to the viewport edge, while the largest board ends at x=534. `EchoNext` is defined but always hidden; its function is represented inside Timeline.

### Permanent surfaces by HUD mode

| Mode | Before disclosure | After first actions | Help expanded |
|---|---|---|---|
| `INTRO_MINIMAL` | objective, status, YOU/EXIT legend, controls | same except compact controls | objective and controls expand; no timeline |
| `GUIDED_ECHO` | three-line objective, status, full legend, timeline, controls | compact legend/causality copy and controls | full legend, expanded timeline, full controls |
| `STANDARD_COMPACT` | objective, status, compact legend, timeline, controls | compact objective plus all other surfaces | full objective/legend/timeline/controls |

### Level 4 presentation sequence

1. Start snapshot: Door is red/closed; Status says `Door: CLOSED`.
2. The critical `UP` is submitted while YOU is blocked by the closed snapshot.
3. ECHO moves onto the Plate; ECHO and Plate are redrawn at their committed positions.
4. The Door immediately redraws green/open in the resulting state; Status changes to `Door: OPEN`.
5. No transition pulse, persistence cue, caption, or explicit “usable on next input” indicator appears.
6. The next `RIGHT` enters the Door cell from the open start snapshot.
7. ECHO leaves the Plate and the result redraws the Door closed, potentially around YOU.

Steps 1–7 are `SOURCE_MEASURED`; 960×540 captures of steps 1 and 4 are `RUNTIME_OBSERVED`. The brief green frame and status word carry nearly all timing information, which matches the owner's P2 finding.

## Options

### Option A — retain 960×540, board first (recommended)

| Dimension | Plan |
|---|---|
| Board-area target | 60 px pitch; max 9×7 footprint 540×420 (43.75% of viewport); board zone about x 24–564, y 84–504 |
| HUD | top-left one-line goal; x 600–936 right rail for title/turn/state and contextual timeline; Help/legend in modal overlay; no permanent board-overlapping footer |
| Readability | minimum 16 px secondary text, 18 px instructions, 22 px title; important states have shape/text as well as color |
| Current five levels | no level-data change; all fit at 60 px; sparse layouts gain 11.1% linear scale |
| Godot approach | later edit to the reusable Gameplay scene/script constants and label anchors; keep `project.godot` unchanged |
| Evidence burden | full regression, seven 960×540 captures, overlap bounds, Help/Timeline snapshots, owner Level 4 sequence review |
| Accessibility | fewer permanent labels, larger minimum type, modal reference, redundant Door cues |
| Asset resolution | crisp vector/procedural or 60 px-cell sprites; author at 120 px or scalable source for 2× displays |
| Risks | still constrained for long Chinese copy or grids larger than 9×7; hard-coded layout remains non-responsive |
| Rollback | restore scene/script presentation constants and labels; simulation and data remain untouched |

### Option B — adopt 1280×720 (fallback)

| Dimension | Plan |
|---|---|
| Board-area target | 72 px pitch; max 9×7 footprint 648×504; 51.3% width and 70% height |
| HUD | 360–400 px right rail, top goal strip, contextual overlays |
| Readability | 18 px minimum body and more Chinese wrapping capacity |
| Current five levels | formal levels unchanged; captures and all anchors must migrate |
| Godot approach | change logical viewport and window defaults, scene anchors, draw background, min-size policy, and capture expectations in a separate task |
| Evidence burden | full regression plus 1280×720 and minimum-window captures; compare OS scaling and DPI |
| Accessibility | more text room and larger board; higher minimum physical window demand |
| Asset resolution | 72/144 px cell sources or scalable originals; larger UI textures |
| Risks | project-setting migration, asset rework, capture churn, possible 720p taskbar/window fit issues |
| Rollback | revert viewport/settings and presentation anchors together; retain 960 assets until acceptance |

### Option C — responsive board-first layout

| Dimension | Plan |
|---|---|
| Board-area target | 55–70% of available width and up to 84% height, fitted from formal grid bounds |
| HUD | right rail at wide aspect; collapsible bottom/overlay at narrow aspect |
| Readability | best use of large windows; must clamp text and cell scale |
| Current five levels | same data; each size/aspect becomes a layout case |
| Godot approach | container-driven UI plus calculated board transform and bounded stretch rules |
| Evidence burden | a window-size/aspect matrix, reflow tests, hit/overlay bounds, screenshots at every breakpoint |
| Accessibility | potentially strongest, but failures can hide controls or produce tiny board cells |
| Asset resolution | scalable/vector or multiple raster tiers |
| Risks | highest implementation and regression complexity; layout logic may become another fragile authority |
| Rollback | keep the fixed 960 composition as a selectable fallback until responsive acceptance |

## Recommended baseline specification

- Logical viewport and minimum supported content size: **960×540**.
- Physical window: default to the logical size; larger windows uniformly scale the canvas under the current policy. A later task may set a minimum window size, but this plan does not change settings.
- Board target: 60 px pitch; max current footprint 540×420; no board/HUD overlap; preserve at least 24 px outer margin and 36 px separation from the right rail.
- HUD zones: goal/title strip y 18–64; board x 24–564/y 84–504; status/timeline rail x 600–936; modal Help centered within x 96–864/y 54–486.
- Standard persistent information: level title, turn, compact Door state icon/text when Doors exist, one-line goal until first input, `H Help` discoverability.
- Controls: visible before first input and in Help/Pause; hidden from the board after disclosure.
- Timeline: always visible in `GUIDED_ECHO`; contextual in standard mode when `echoes > 1`, distinct delays > 1, `max_delay >= 4`, or a later accepted catalog presentation flag requires it. It remains hidden in Tutorial 0. Highlight only the slot replayed next.
- `H` Help: zero-turn modal/reference card containing controls, entity key, full timeline explanation, and objective; keyboard focus and screen-reader-friendly text remain testable.
- Fallback: adopt Option B only after a captured Option A proof fails a named acceptance criterion.

The contextual threshold is presentation-only and reads validated level/catalog facts. It must not change history indexing, action resolution, or catalog-v1 semantics. If a new catalog field is desired, that is a separate catalog contract task.

## Timeline and Help product decision

| Direction | Benefit | Cost/risk | Decision |
|---|---|---|---|
| Keep all three current slots always visible whenever an ECHO exists | maximum continuous exposure; simple behavior | owner found no value in current simple levels; permanently consumes 135 px of right-rail height | reject as the standard default; retain in guided tutorial |
| Show Timeline only when ECHOs exist and complexity crosses the declared threshold | preserves board/status space while surfacing planning aid for multi-delay/harder content | threshold must be deterministic, tested, and explainable | recommend |
| Move detailed action names and explanations into Help, keep compact arrows/pointers in main HUD | reduces prose while retaining glanceable prediction | glyphs need accessible labels and first-use teaching | recommend when Timeline is active |
| Emphasize only the slot replayed next | directs attention to the immediate causal prediction | multiple ECHOs may require two simultaneous pointers | recommend; show one pointer per ECHO with stable ID/delay |
| Convert `H` Help to a modal reference card | restores objective, controls, legend, and full Timeline without permanent clutter | modal focus/close behavior and zero-turn guarantee need tests | recommend |

Keyboard discoverability remains through a small persistent `H Help` affordance, the initial controls card, and Pause. Future multi-delay levels automatically qualify for Timeline visibility because they have multiple ECHOs/distinct delays. Accessibility requires readable action text in Help, non-color slot emphasis, stable oldest→newest ordering, focus return after close, and full keyboard operation.

## Task 0014 Level 7 disposition

For the selected prospective Level 7 `two_echo_convergence`, the primary verdict is:

```text
TIMELINE_REMOVED_FROM_LEVEL_7_TEACHING_GOAL
```

The current contextual compact Timeline may remain visible as an inherited, contract-derived optional status surface, but Level 7 cannot require reverse-counting or Timeline use for completion or owner-review success. No Timeline indexing, compact/expanded layout, or disclosure change is authorized by Task 0014. Redesign requires a separate task and evidence that board-first reasoning fails after actor/dependency legibility is correct.

Help verdict:

```text
HELP_CONTEXTUAL_OPTIONAL
```

Help may provide a zero-turn visual/text legend for controls, E2/E4 delay identities, A/B shapes, `A+B`, and next-turn Door behavior. It cannot disclose a route, movement sequence, branch, or exact synchronization count and cannot compensate for unreadable board state.

## Task 0015RV owner-feedback disposition

The Task 0015RV assisted owner retest closes the fixed-spacing false-unsolvable blocker for owner evidence. The owner found the transition feedback accurate and clear enough, reported no stable-spacing false cue, and explained how Door/terrain blocking can make one ECHO stop while another moves.

Carry forward as planning inputs:

- the owner still found the Level 6-to-7 difficulty increase abrupt;
- Help was used but did not help;
- Timeline remained unused and too abstract;
- ECHO next-action dotted paths and Door/Plate dependency paths can overlap and look cluttered;
- later icon/letter/art relationship language is preferred, while retaining non-color cues.

The owner requested direct operation walkthroughs, but this evidence does not authorize route-revealing Help. Any Help, Timeline, path-language, intermediate-level, or production-art change requires a separate task and comparison evidence.

Level 7 dependency presentation must combine A/B labels with distinct shapes, E2/E4 badges with distinct outlines, and supplementary color. Overlapping ECHOs preserve both badges/outlines. The cues must remain legible at 960×540, in grayscale, in static screenshots, and during motion. The later owner review is `AUTHENTICATED_OWNER_NOT_FRESH_NOT_INDEPENDENT_LEVEL_7_REVIEW`; do not seek or require a third party under `FRESH_INDEPENDENT_REVIEW_UNAVAILABLE_BY_OWNER_CONSTRAINT`.

## Task 0016 bridge/finale planning disposition

Task 0016 selects `INSERT_BRIDGE_BEFORE_CURRENT_LEVEL_7` and freezes the presentation policy:

```text
LABEL_SHAPE_PIP_PRIMARY_NO_NEW_LINES
```

The proposed `echo_spacing_bridge` must teach its spacing-change cause from board state and transition feedback. Timeline remains optional and cannot be a completion dependency. Help remains contextual and non-route; exact moves, branch choices, synchronization counts, and walkthroughs are rejected. Labels, shapes, and pips are primary; color is supplementary; E2/E4 identity remains badge/outline based. No new always-on dotted relationship line may be introduced, and any later change to existing lines requires a separate implementation and capture/test gate.

The policy is planning only. Task 0016 does not modify Gameplay, Help, Timeline, path rendering, viewport, formal data, or project settings.

## Task 0016R mechanical correction

GPT rejected the one-Plate/one-Door bridge's dual-ECHO necessity claim. Task 0016R revises the proposed bridge to two Plates and one A+B Door while retaining:

```text
LABEL_SHAPE_PIP_PRIMARY_NO_NEW_LINES
```

The extra Plate does not authorize extra always-on lines. A/B labels, distinct shapes, and independent Door pips remain primary; E2/E4 badges/outlines identify actors; color remains supplementary. The early `BLOCKED/MOVED` transition and committed board state must teach the spacing change. Timeline remains optional and Help remains contextual/non-route. This revision changes planning only, not presentation code or captures.

## Likely later implementation paths

- `scenes/vertical_slice/vertical_slice.tscn`
- `scripts/gameplay/vertical_slice.gd`
- `scripts/gameplay/timeline_model.gd` only if the presentation text API must change
- focused files under `tests/gameplay/`
- `tests/run_all.gd` only to register focused assertions
- one implementation report and narrowly necessary current documents

`project.godot`, levels, schemas, simulation, solver, and catalog need not change for Option A.

## Acceptance criteria for the later implementation

Automated:

1. all five accepted regression markers and metrics remain exact;
2. board, objective, status, timeline, legend, controls, and completion rectangles do not overlap at 960×540 in every HUD mode/state;
3. Help toggles without a turn or canonical-key change;
4. contextual Timeline visibility matches the declared presentation threshold and every pointer still comes from the shared query;
5. minimum font sizes meet the baseline; no label clips its measured bounds;
6. all five levels and development-direct routes use the same Gameplay path.

Visual/human:

1. captures show every current board at least 11% larger linearly than the accepted baseline;
2. the 7-row board has no permanent text drawn across active cells;
3. closed/open Door is distinguishable in grayscale and without audio;
4. the Level 4 open-result capture visibly says or symbolizes “usable on next input” without giving a movement route;
5. the owner repeats the five-level sequence and reports whether effective board size improved;
6. later authenticated-owner evidence evaluates discoverability and information density under the owner-only constraint; missing fresh/independent evidence remains disclosed and is never claimed.

## Stop and rollback conditions

Stop and return to planning if 60 px cannot fit all accepted boards without overlap, minimum text requires clipping, presentation code begins deriving puzzle rules, or the owner still reports a materially small board after the captured Option A pass. Roll back presentation-only files on a regression; do not compensate by altering levels or simulation.

# Task 0010 presentation, difficulty, and production direction planning report

- Terminal recommendation: `PASS_FOR_GPT_REVIEW`
- Task: [`tasks/0010_presentation_difficulty_asset_audio_narrative_and_gate_planning.md`](../../tasks/0010_presentation_difficulty_asset_audio_narrative_and_gate_planning.md)
- Repository root: `D:\Delayed_Self`
- Branch: `main`
- Starting `HEAD` and `origin/main`: `1a538e8a4ccf4ac7b65123517735a37c4e093248`
- Prior accepted implementation: `9516c44688d5416c154167e8be002a60de7ce327`
- Prior accepted owner evidence: `a4dca805835a48d6d06f241d52e4f275ac61251b`
- Toolchain: Godot `4.7.stable.steam.5b4e0cb0f`, GDScript, Compatibility renderer
- Commit policy: one documentation-only commit, `docs: plan Delayed Self presentation and difficulty recovery`

## Result

Task 0010 produces an implementation-ready recovery direction without changing any runtime/content/settings surface. It selects a low-risk 960×540 board-first layout, defines non-semantic Door feedback, turns Timeline/Help into contextual references, sets measurable human-plus-machine difficulty gates, establishes provenance before acquisition, drafts a lightweight eight-level narrative, and defers the latched Gate pending a separate contract/prototype chain.

No planned improvement is represented as implemented, accepted, license-cleared, or human-validated.

## Documents created

1. [`PRESENTATION_VIEWPORT_AND_HUD_DIRECTION_CURRENT.md`](../ux/PRESENTATION_VIEWPORT_AND_HUD_DIRECTION_CURRENT.md)
2. [`FIVE_LEVEL_DIFFICULTY_RECOVERY_AND_LEVELS_6_8_PLAN.md`](../level_design/FIVE_LEVEL_DIFFICULTY_RECOVERY_AND_LEVELS_6_8_PLAN.md)
3. [`DOOR_PLATE_AND_ECHO_FEEDBACK_STORYBOARD.md`](../ux/DOOR_PLATE_AND_ECHO_FEEDBACK_STORYBOARD.md)
4. [`ASSET_AUDIO_LICENSE_AND_PIPELINE_PLAN_CURRENT.md`](../art/ASSET_AUDIO_LICENSE_AND_PIPELINE_PLAN_CURRENT.md)
5. [`DELAYED_SELF_NARRATIVE_DIRECTION_CURRENT.md`](../narrative/DELAYED_SELF_NARRATIVE_DIRECTION_CURRENT.md)
6. [`LATCHED_ONE_SHOT_GATE_ADR_DRAFT.md`](../architecture/LATCHED_ONE_SHOT_GATE_ADR_DRAFT.md)
7. [`M3_PRESENTATION_DIFFICULTY_AND_PRODUCTION_RECOVERY_PLAN.md`](../version_plans/M3_PRESENTATION_DIFFICULTY_AND_PRODUCTION_RECOVERY_PLAN.md)
8. this report.

Updated narrowly: startup snapshot, active task, documentation index, development plan, master handoff, and project memory.

## Current-state measurements

`SOURCE_MEASURED`:

- logical viewport 960×540; `canvas_items` stretch with aspect `keep`;
- board origin `(48,150)`, cell pitch 54 px, drawn cells 51×51;
- current grids range from 5×4 to 9×7; maximum footprint 486×378, 35.44% of the viewport;
- traversable drawn-cell share ranges from 3.01% to 8.03%; Levels 3 and 5 are 6.52%;
- the 7-row board reaches y=528 while the permanent control label occupies y=420–520, creating a source-proven overlap;
- current persistent type reaches 14 px in the compact legend and 15 px in Timeline;
- larger windows are expected to uniformly scale/letterbox this composition rather than reflow it.

`RUNTIME_OBSERVED`:

- a bounded 960×540 Compatibility-renderer capture run produced all seven accepted Level Select/Level 4/Level 5 capture states;
- Level 4 open feedback is primarily a green hollow rectangle plus right-rail `Door: OPEN`;
- the control footer visibly crosses the lower board rows in Level 4/5;
- Level 5 AND state remained readable.

Temporary captures/logs were used only for planning observation and are not repository artifacts. A headless screenshot attempt used Godot's dummy renderer and could not expose a viewport texture; the normal Compatibility-renderer capture then passed. This limitation does not affect the accepted headless regression.

## Presentation decision

Recommended baseline: retain 960×540, use a 60 px board pitch, reserve an overlap-free x 24–564/y 84–504 board zone, use x 600–936 as a compact right rail, remove the permanent board footer after disclosure, and make Help modal. The 9×7 footprint becomes 540×420 (43.75% of the viewport), an 11.1% linear increase without project-setting migration.

Timeline is always available in the guided ECHO tutorial and contextual in standard play for multi-ECHO, distinct-delay, `max_delay>=4`, or otherwise accepted presentation complexity. `H` becomes a zero-turn modal card. Option B, 1280×720, is the fallback only if captured 960×540 acceptance criteria fail. Responsive reflow is deferred because its test burden is disproportionate to the current project.

## Difficulty and Levels 6–8

The framework separates machine complexity from human difficulty using `L*`, exact/capped `N*`, visited/frontier burden, actor/delay structure, dependency depth, synchronization windows, meaningful branches, error recovery, trial-and-error bypass, mental state, observability, and later human completion evidence.

Existing Levels 1–5 remain unchanged. Levels 1–2 stay tutorials; Levels 3–5 stay short onboarding/checkpoint levels while presentation recovery and later sequence evidence determine whether any formal rebalance is justified.

Concept targets, all `PROPOSAL_ONLY`:

- Level 6 `staggered_doors`: one d=3 ECHO, two Plates/two distinct Doors, `L*` 15–21, `N*` 1–12, 2,000–40,000 visited target.
- Level 7 `two_echo_convergence`: d=2/d=4 ECHOs, two Plates/one AND Door, `L*` 17–25, `N*` 1–8, 8,000–150,000 visited; Timeline prediction must be demonstrated.
- Level 8 `signal_convergence`: two ECHOs, three Plates/two accepted Doors, `L*` 21–30, `N*` 1–6, 20,000–300,000 visited; no Gate dependency.

Every level requires schema/solver/replay/restart, mechanic-necessity controls, bypass audits, observable state, and human evidence. A witness alone is never acceptance.

## Door, Timeline, and Help recommendation

The minimal Door feedback uses existing primitives: Plate depression/ring, dependency pulse, barred-versus-hollow Door shapes, `OPEN · NEXT INPUT` teaching badge, blocked Door X, and a distinct ECHO replay trail. The proposed normal presentation reaches the next-input handoff within 260–320 ms and may buffer one input; logic commits before animation.

The Level 4 storyboard explicitly distinguishes the closed start snapshot, blocked YOU action, ECHO-on-Plate result, committed open state, next-input entry, and safe closure around/behind YOU. Color and audio are supplemental to shape/icon/text.

Timeline remains available but stops occupying permanent space in current simple standard levels. Help becomes a modal reference and maintains keyboard discoverability. These are recommendations, not deletions or current behavior changes.

## Visual, license, and audio direction

Recommend a minimalist temporal-neon laboratory: solid YOU, hollow/dashed ECHO, recessed Plates, live combinational Door pips/circuit paths, persistent diamond EXIT, restrained dark facility panels, and scalable/procedural sources. A pixel-art maintenance station remains the alternative if one coherent pack proves cheaper and clearer.

Policy prefers CC0; conditionally permits CC-BY 4.0, MIT/BSD where applicable, and SIL OFL 1.1 fonts with full obligations; rejects unclear, NC, incompatible SA, ripped, no-redistribution, and unclear-rights AI material without a separate decision.

Source-shortlist status: `NETWORK_RESEARCH_COMPLETED_NO_DOWNLOAD`.

- Visual: Kenney Sci-Fi RTS, UI Pack - Sci-Fi, and 1-Bit Pack; official pages report Creative Commons CC0.
- Audio/SFX: Kenney UI Audio, Digital Audio, and Interface Sounds; official pages report CC0.
- Music: OpenGameArt `cc0 space music` by madeso (three OGG tracks exposed by the page) and Kenney Music Jingles; pages report CC0.
- Fonts: Source Han Sans and Atkinson Hyperlegible Next; official repositories contain SIL OFL 1.1 license text.

No archive/file/version/hash has been acquired or verified. Every candidate remains research-only. The future ledger template captures source, author, license, attribution, file map, modifications, import settings, hashes, and approval state.

The audio plan covers player/ECHO movement, blocked move, Plate on/off, Door open/close, completion, menu navigation, and one sparse loop. Audio must remain optional, duck under critical cues, loop cleanly, and never become the only state channel. Persistent volume settings remain a separate protected task.

## Narrative direction

The premise follows a maintenance unit reconstructing a years-late distress signal through its own delayed actions. Eight short pre/post beats move from diagnostic recognition to identity and final acknowledgement: too late to save, not too late to hear. Delivery uses short dismissible cards and environmental motifs, not dialogue, cutscenes, collectibles, branching goals, or story-state persistence.

Recommend introducing text after the primitive layout/Door-feedback pass and before final licensed art/music selection.

## Gate ADR

[`LATCHED_ONE_SHOT_GATE_ADR_DRAFT.md`](../architecture/LATCHED_ONE_SHOT_GATE_ADR_DRAFT.md) remains exactly `DRAFT_NOT_ACCEPTED`. It compares no Gate, latched Gate, disappearing Gate, and persistent environmental switch. The recommendation is to defer; if later justified, prototype a visually distinct monotonic latched Gate only after contract/schema/vector acceptance. Existing levels migrate none and `simulation_v1`/`level_v1` remain unchanged.

## Integrated roadmap and next task

The roadmap sequences:

1. primitive board/HUD plus Door feedback;
2. provenance and one licensed visual/font slice;
3. audio foundation with settings boundary;
4. narrative text prototype;
5. Levels 6, 7, and 8 as separate validation gates;
6. owner sequence review;
7. qualifying fresh/independent review;
8. separate save, complete-flow, export, license, and release gates.

Recommended immediate next task: bounded primitive 960×540 board/HUD and Door-feedback recovery using current shapes. It addresses the direct owner findings without asset or semantic dependencies and stabilizes the presentation vocabulary for later production. It is not authorized by this report.

## Regression and immutable baseline

Pre-work regression passed:

- `TASK_0003_TESTS_PASS assertions=280 vectors=9`
- `TASK_0006_APP_SHELL_TESTS_PASS`
- `TASK_0007_TUTORIAL_LEVELS_TESTS_PASS`
- `TASK_0008_PROGRESSIVE_HUD_TESTS_PASS`
- `TASK_0009AR_LEVELS_4_5_TESTS_PASS`

Accepted metrics remained exact: Tutorial 0 `3/3 EXACT/6/2`; Tutorial 1 `9/12 EXACT/1975/509`; Level 3 `9/31 EXACT/1318/393`; Level 4 `9/7 EXACT/291/116`; Level 5 `12/1 EXACT/1260/225`, including accepted controlled unsolved results.

Current SHA-256 values are unchanged from the accepted files/commit:

- `tutorial_reach_exit.json`: `38e466bb5922f1987a99d79c7527a4a8eab8e6cfdbe76fd8159f80b0a40cf2c4`
- `tutorial_echo_bridge.json`: `681d99057c4e6034a490644d75960ff23d8f43bd1b91850f48179b79fc04a3cf`
- `vertical_slice_delay_3.json`: `8751da5051fbebaaa5ae7c895d9be9f086e8d8f2e87876a80c379dc06262f1d8`
- `door_one_turn_late.json`: `1775cf89ae4a94f65a76dac2b791a31395443de88205d0ed1b6233331dbda577`
- `two_keys_one_door.json`: `f4c6791dfc84d17fb450721e654091a2baeb522e55d660a5d73878cd977651cd`

Post-documentation regression repeated all five markers, exact metrics, and controlled unsolved results. Final scope inspection found only the 14 authorized Markdown paths; internal links resolved; `git diff --check` passed; and formal levels/catalog/runtime/settings remained unchanged.

## Protected surfaces and non-claims

No source, scene, formal level, catalog, schema, test, project setting, viewport, import, asset, font, audio, plugin, dependency, persistence, export, build, release, account, or repository setting is changed. No file is downloaded or imported.

This task does not establish implemented presentation recovery, higher difficulty, Level 4 clarity, Timeline/Help utility, license clearance, final art/audio/narrative, Gate acceptance, fresh/independent review, candidate acceptance, save, complete flow, accessibility, localization, export, Web, release, or submission readiness.

## Decisions still requiring GPT or owner authority

- GPT acceptance of the 960×540 baseline, contextual Timeline/Help, difficulty bands, roadmap, and Gate deferral;
- owner confirmation of the final visual tone after a representative slice;
- exact source/package/release/font/audio selection and license clearance;
- final narrative wording and Chinese localization voice;
- whether the candidate includes all Levels 6–8 after evidence;
- any future Gate contract/prototype authorization;
- every protected M4/release task.

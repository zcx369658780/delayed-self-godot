# Task 0010 GPT final acceptance

- Verdict: `TASK_0010_PRESENTATION_DIFFICULTY_AND_PRODUCTION_PLANNING_ACCEPTED`
- Accepted planning commit: `37ab72513ed456d216bfe642282b6cac9e5484bd`
- Accepted task: `tasks/0010_presentation_difficulty_asset_audio_narrative_and_gate_planning.md`
- Acceptance date: 2026-07-16
- Accepted by: GPT Project Sources advisor

## Review basis

GitHub review confirmed that the planning implementation is exactly one commit ahead of the Task 0010 issue point and changes only the fourteen authorized planning/report/current-document Markdown paths. No runtime source, scene, formal level, catalog, schema, test, project setting, viewport setting, imported resource, asset, font, audio, plugin, dependency, persistence, export, build, release, account, or repository-setting surface changed.

The accepted pre-work and post-documentation baseline retains all five markers:

- `TASK_0003_TESTS_PASS assertions=280 vectors=9`;
- `TASK_0006_APP_SHELL_TESTS_PASS`;
- `TASK_0007_TUTORIAL_LEVELS_TESTS_PASS`;
- `TASK_0008_PROGRESSIVE_HUD_TESTS_PASS`;
- `TASK_0009AR_LEVELS_4_5_TESTS_PASS`.

All five accepted level hashes, solver metrics, controlled-unsolved results, replay behavior, and runtime authorities remain unchanged.

## Accepted presentation decision

The immediate implementation baseline is accepted as:

1. retain the `960×540` logical viewport and current stretch policy;
2. rebuild Gameplay around a board-first `60 px` pitch;
3. reserve an overlap-free board zone approximately `x=24..564`, `y=84..504`;
4. reserve a compact right rail approximately `x=600..936`;
5. remove the permanent post-disclosure control footer from the board region;
6. use at least 16 px secondary text, 18 px instructions, and 22 px title/status text where the plan specifies;
7. make `H` a zero-turn modal reference card;
8. keep Timeline always available in `GUIDED_ECHO`, hidden in `INTRO_MINIMAL`, and contextual in standard play when accepted presentation complexity warrants it;
9. keep `1280×720` as fallback only if a later captured 960×540 implementation fails named acceptance criteria;
10. defer responsive reflow until the fixed presentation baseline is stable.

This accepts an implementation direction, not an implemented layout or a human readability result.

## Accepted Door, Plate, and ECHO feedback direction

The immediate primitive feedback vocabulary is accepted for implementation planning:

- pressed/released Plate shape and ring feedback;
- visible dependency paths/pulses from each referenced Plate to its Door;
- barred closed Door versus hollow/open aperture independent of color;
- stable per-Plate dependency pips, including the two-Plate AND case;
- distinct ECHO replay trail/glyph;
- blocked-Door X/stop feedback;
- a teaching-only `OPEN · NEXT INPUT` badge for the first relevant Level 4 open result;
- committed logic before presentation, with no animation-derived puzzle state;
- a normal visual handoff target within approximately 260–320 ms, without dropped or duplicated player input;
- audio remaining unnecessary for state comprehension.

The exact Level 4 teaching sequence remains the accepted combinational-Door rule: closed start snapshot, blocked player movement, ECHO presses Plate, result commits Door open, next submitted turn enters, and the Door may then close around or behind the occupant.

## Accepted difficulty recovery framework

Levels 1–5 remain unchanged and serve as tutorials/onboarding checkpoints. Difficulty is not inferred from `L*`, `N*`, or solver burden alone.

The planning targets for future concepts are accepted as proposal bands, not implementation results:

- Level 6 `staggered_doors`: `L* 15–21`, `N* 1–12`, two distinct Door windows;
- Level 7 `two_echo_convergence`: delays `2` and `4`, `L* 17–25`, `N* 1–8`, Timeline prediction must become demonstrably useful;
- Level 8 `signal_convergence`: two ECHOs, three Plates, two accepted Doors, `L* 21–30`, `N* 1–6`.

Every future level must pass schema, solver, replay, restart, actor/dependency necessity, shortcut/bypass, observability, and human gates. A witness, large `L*`, low `N*`, owner completion, or high state count alone is never acceptance.

## Accepted production and provenance direction

The project adopts provenance-before-acquisition planning:

- prefer CC0/public-domain-equivalent material;
- conditionally allow CC-BY 4.0, applicable MIT/BSD material, and SIL OFL 1.1 fonts with full obligations;
- reject unclear, non-commercial, no-derivatives, incompatible share-alike, ripped, no-redistribution, missing-source, and unclear-rights AI media without a separate legal/product decision;
- preserve exact source, author, version/date, license evidence, file mapping, modifications, attribution, import settings, hashes, review status, and approval commit for every acquired file;
- keep all researched packs, fonts, SFX, and music at `RESEARCH_ONLY / NOT_ACQUIRED / NOT_VERIFIED` until a later acquisition task.

The recommended visual direction is a minimalist temporal-neon laboratory using readable, scalable entity/state shapes. The accepted acquisition sequence begins only after primitive presentation recovery and permits one bounded representative visual/font slice before any broad reskin.

## Accepted narrative direction

The lightweight premise—reconstructing a years-late distress signal through delayed versions of the self—is accepted for later bounded text prototyping. Delivery should use short dismissible pre/post cards and environmental motifs, without dialogue systems, cutscenes, collectibles, branching goals, or narrative-state persistence.

No final wording, localization voice, font, card UI, or narrative implementation is accepted by this gate.

## Gate ADR adjudication

`docs/architecture/LATCHED_ONE_SHOT_GATE_ADR_DRAFT.md` remains exactly `DRAFT_NOT_ACCEPTED`.

The active candidate baseline continues to use combinational Plate Doors only. A persistent latched Gate is deferred until presentation recovery and at least one multi-delay schema-v1 level provide evidence that permanent topology change is still needed. If later authorized, it must proceed through a successor ADR/contract decision, schema and normative vectors, runtime/solver parity, one isolated prototype, owner review, and qualifying fresh review. Existing levels migrate none.

## Integrated roadmap

The accepted sequence is:

1. primitive board/HUD and Door-feedback recovery;
2. provenance setup and one licensed visual/font slice;
3. audio foundation;
4. narrative text prototype;
5. Levels 6, 7, and 8 as separate validation gates;
6. owner sequence review;
7. qualifying fresh/independent review;
8. separate M4 save, complete-flow, export, license, release, and submission gates.

Optional Gate research remains a separately authorized branch after stronger schema-v1 evidence.

## Observations and non-claims

This acceptance does not establish implemented presentation recovery, a larger perceived board, Level 4 teaching clarity, final Timeline/Help utility, higher human difficulty, license clearance, imported assets/fonts/audio, final visual style, final narrative, Gate acceptance, fresh/independent review, candidate acceptance, persistent save, complete flow, accessibility, localization, export, Web, release, or submission readiness.

## Next gate

`Task 0011 — primitive board/HUD and Door-feedback recovery` is authorized as a bounded implementation gate. It may change only the reusable Gameplay presentation, focused presentation helpers/tests, one implementation report, and narrowly necessary current documents. It must preserve `project.godot`, simulation, solver, schemas, all five formal levels, catalog, progress, assets, audio, and every accepted metric/hash. Human owner adjudication follows in a separate review gate after implementation acceptance.
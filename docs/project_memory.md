# Project memory

Durable project decisions only; live task progress belongs in current docs and reports.

## Frozen facts

- Repository: `zcx369658780/delayed-self-godot`; visibility: public; default branch: `main`.
- Canonical local root: `D:\Delayed_Self`.
- Working title: `迟到的我 / Delayed Self`.
- Game direction: offline single-player, 2D top-down grid, turn-based delayed-echo puzzle.
- Primary target: Windows.
- Candidate milestone: 2026-08-10; final submission: 2026-09-06 23:59; video: 2026-09-10.
- Simulation must be deterministic and solver/runtime-consistent; presentation cannot own puzzle rules.
- Public submission, releases, repository administration, saves, upgrades, external assets, and final licensing are separately authorized protected surfaces.
- Final acceptance belongs to the GPT Project Sources advisor; Codex supplies implementation and evidence.
- Task 0000 was accepted by the GPT Project Sources advisor on 2026-07-14 at commit `67089cc0546a83b2842d2e2fc4985cb9e20f00df`.
- Task 0001 was accepted on 2026-07-14 at implementation commit `227ea8b86de1699d540113f0a3052214cc294beb`.
- Frozen Task 0001 baseline: standard Godot 4.7 stable, GDScript, Compatibility renderer, Windows desktop x86_64 for the vertical slice, Web deferred, and approved `D:\Delayed_Self_Evidence` path without creation authority.
- Task 0002 simulation/schema contract was accepted with observation on 2026-07-14 at implementation commit `f390f5a4ced31252f8804fba99da1226c9f64be4`.
- Task 0003 is the first implementation gate: its runtime, loader, replay, tests, and BFS share `simulation_v1`; its formal slice uses one delay-3 echo, one plate, one combinational door, and one player-only exit.
- Task 0003 was accepted with observations on 2026-07-14 at implementation commit `14180dc3e110607d4abdee5f8bf314a58f62fb39`.
- Task 0004 authentic user evidence found three P1 issues: undiscoverable player-only victory, circular EXIT occluded by ECHO, and inverted player/echo causal roles; explicit next-action and terminal-goal copy were P2 findings.
- Task 0004R preserves gameplay semantics while repairing objective, legend, persistent diamond EXIT, next echo action, and completion feedback; a user retest is required before UX acceptance.
- Task 0004R was accepted pending user retest on 2026-07-14 at implementation commit `caeff311fda77b0261a7d78672afb9244ff23549`.
- Task 0004V records a same-user, not-blind, unassisted completion at visible Turn 10 with no P0/P1; information density and limited Echo next/History usefulness remain a P2 observation, and later fresh-player/independent review is still required.
- Task 0004V was accepted with observations on 2026-07-14 at evidence commit `67b9a9cbfcefd2458b481c33673aeb23520a51f4`.
- Task 0005 planning was accepted on 2026-07-14 at planning commit `0de8fa7435dc1024f35161d90cd03419a53730dd`.
- Task 0006 was accepted on 2026-07-14 at implementation commit `4fc742723b1ea5dbefb19cf4ea27acacc2ad9f36`; it established the strict catalog v1, AppRoot routing, Safe Error, validated direct-level argument, and memory-only progress.
- Task 0007 chooses Approach B: the historical `vertical_slice` scene/script name remains a development compatibility artifact while one generalized gameplay implementation hosts Tutorial 0, Tutorial 1, and the unchanged accepted vertical slice. Tutorial 0 is a zero-Echo movement/EXIT level; Tutorial 1 is a delay-3 Echo/Plate/Door level. Both are machine validated and internally playable, but not fresh-player reviewed or candidate accepted.
- Task 0007 was accepted on 2026-07-14 at implementation commit `833016b9260841227d3ed97ddf6c56ee6ae91dc9`.
- Task 0008 Phase A uses one presentation-only timeline model and one pure `Simulation.echo_history_index_for_state` query shared by existing Echo action lookup. Disclosure is event-driven, help is session-local and zero-turn, restart keeps earned disclosure flags while reconstructing exact simulation state, and English development copy remains pending a separate localization decision.
- Task 0008 Phase A was accepted at implementation commit `3f35078b5d7e71db871140ca440c38069ea5d057`. The revised owner-targeted retest is `NOT_FRESH_NOT_BLIND_OWNER_RETEST`: Tutorials 0–1 completed unassisted through normal flow, third level reached, P0=0/P1=0/P2=2/P3=0. Limited `H` Help value in the simple sequence and right-side HUD crowding at 960×540 remain open P2 findings.
- Task 0008 was GPT accepted with observations at owner-evidence commit `9f5084219b801ec177a049b64bff52cdf4799843`; the owner retest does not substitute for fresh/independent review.
- Task 0009A stopped cleanly because its bounded authoring pass did not establish strict literal-WAIT relevance relative to a no-WAIT search that still permits blocked cardinals. `wait_for_the_echo` is `DEFERRED_VALIDATION_RESEARCH`; this is not a claim that WAIT is impossible or redundant.
- Task 0009AR adds `door_one_turn_late` (`L*=9`, `N*=7 (EXACT)`) and `two_keys_one_door` (`L*=12`, `N*=1 (EXACT)`) as internally playable schema-v1 levels, extends the tracked catalog to five entries, and preserves every accepted runtime authority and first-three metric. GPT and human review remain pending.
- Task 0009AR was GPT accepted at implementation commit `9516c44688d5416c154167e8be002a60de7ce327` with no fresh-player or candidate claim.
- Task 0009AV is `NOT_FRESH_NOT_BLIND_OWNER_SEQUENCE_REVIEW`: all five levels completed unassisted through normal flow, unlock/return worked, P0=0/P1=0/P2=4/P3=2. Carry flat/easy difficulty, weak Level 4 timing visibility, low current timeline/Help value, and small effective board area. A latched/one-shot Gate and licensed visual/audio/narrative direction are future proposals only, not accepted implementation authority.
- Task 0009AV was GPT accepted with findings at evidence commit `a4dca805835a48d6d06f241d52e4f275ac61251b`; fresh/independent and candidate claims remain open.
- Task 0010 recommends a 960×540 board-first 60 px presentation baseline, contextual Timeline and modal Help, primitive non-semantic Door feedback, measurable schema-v1 Levels 6–8, a provenance-first licensed production pipeline, and an eight-level lightweight narrative. Its latched/one-shot Gate ADR is `DRAFT_NOT_ACCEPTED` and defers implementation pending later contract/prototype evidence.
- Task 0010 was GPT accepted at planning commit `37ab72513ed456d216bfe642282b6cac9e5484bd`; its production, difficulty, narrative, asset/audio, and Gate directions remain plans until separately authorized.
- Task 0011 implements the accepted 960×540/60 px board-first primitive presentation using the one reusable Gameplay path. Standard Timeline is contextual, Help is modal and zero-turn, Door/Plate dependencies use shape/path/pip feedback, Level 4 exposes `OPEN · NEXT INPUT`, and Level 5 exposes two stable AND pips. Approach A keeps transitions immediate; presentation records are non-authoritative. Regression is 301 assertions/9 vectors with unchanged formal hashes and metrics.
- Task 0011 was GPT accepted at implementation commit `c26d8be1c97dbe057f633b55ea7689f35272c577` pending owner review. Task 0011V is `NOT_FRESH_NOT_BLIND_OWNER_PRESENTATION_REVIEW`: all five levels completed unassisted through normal flow, unlock/return and input worked, and rules/mechanisms were much clearer. P0=0/P1=0/P2=1/P3=1. The fixed 960×540 logical canvas still leaves materially visible unused right/bottom physical-window space; the owner chose priority `B`, so focused Task 0011R is recommended before licensed visual/font work. Dashed paths should not be the primary future complex-level relationship language; stable shapes/icons/colors plus contextual highlighting are a future direction, with color supplementary.
- Task 0011V was GPT accepted at evidence commit `39d0882e90771c1c54ebdb6477f560e81168fa9e` with focused repair required. Task 0011R diagnoses invalid double-prefixed `display/window/window/...` keys and corrects them to the Godot 4.7 960×540 `canvas_items`/`keep` policy. Exact 16:9 fills; mismatched clients use centered symmetric black bars. AppRoot owns only the intentional clear color and read-only evidence snapshot; Godot owns the transform. Regression is 314 assertions/9 vectors with unchanged hashes, metrics, routes, unlocks, and simulation. GPT and owner retest remain pending.
- The player/ECHO route-divergence suggestion is `DEFERRED_POST_MVP`; it must not enter `level_v1` or the pre-candidate task sequence.

## Pending decisions

Task 0011R GPT adjudication and the required short authenticated-owner window-fill retest are pending. The owner P2 is not closed by machine evidence alone. Detailed owner answers for Level 4 timing, Level 5 AND, Help, Timeline, and per-level overlap remain not provided. Difficulty progression, Level 6, any new Gate semantics, WAIT feasibility, asset acquisition, persistent save, final licensed art/audio/narrative, qualifying fresh/independent review before candidate acceptance, accessibility, localization, export, Web, and release evidence remain separate gates.

# Task 0020 GPT eight-level finale-closure plan acceptance

- Reviewed commit: `9b4eabfb9d589714711eb8d7943b5fb9087f4fa0`
- Verdict: `TASK_0020_EIGHT_LEVEL_FINALE_CLOSURE_PLAN_ACCEPTED`
- Formal scope: exactly eight levels
- Formal finale: sequence 8 `two_echo_convergence`
- Selected direction: `B — FINAL_COMPLETION_OVERLAY_PLUS_BOUNDED_RETURN_STATE`
- Fallback: `A — FINAL_COMPLETION_COPY_ONLY`
- Next gate: bounded finale-presentation implementation only

## Accepted scope decision

The current product remains frozen at eight formal levels. The eight-entry catalog, all formal level files, accepted hashes/metrics, Simulation, schema, solver, Help predicate, and optional Timeline policy remain immutable. Sequence 9, B007, reduced-grammar authoring, candidate A/B/C search, and proof expansion remain outside current product scope.

Sequence 8 already provides the mechanical final convergence. The remaining finale gap is presentation and routed return, not another puzzle room.

## Accepted ending contract

Use the validated catalog-derived `route_payload.final_level` fact together with ordinary Simulation completion. Do not branch on `level_id`, level title, sequence number, progress count, coordinates, witness state, or new metadata.

For non-final levels, preserve the existing successful-completion behavior: record completion/best turns and automatically return to Level Select.

For the catalog-marked final level:

1. preserve the ordinary YOU-on-EXIT completion and canonical state;
2. record completion/best turns exactly once through the existing progress interface;
3. keep the active Gameplay screen instead of immediately replacing it;
4. show one deterministic final acknowledgment using the existing completion presentation surface;
5. provide a visible explicit acknowledgment action that returns through the existing Level Select route;
6. preserve `R` as replay/restart and `Esc` as a bounded return path;
7. prevent repeated input from double-recording, double-routing, or stranding the app.

Provisional implementation copy may be:

```text
THE SIGNAL ARRIVED LATE.
IT WAS HEARD.

Enter / Space: Level Select
R: Replay
```

The copy is an implementation placeholder for later owner/narrative review. It must not create a localization exception or claim final production copy.

## Implementation surface

A later task may modify only the minimum necessary subset of:

- `scripts/app/app_root.gd`;
- `scripts/gameplay/vertical_slice.gd`;
- one focused app/gameplay test file;
- `tests/run_all.gd`;
- implementation report and minimum CURRENT documentation.

No new scene, ending subsystem, persistence field, catalog change, formal-level change, Simulation/solver/schema change, asset/audio dependency, cutscene, credits system, or hard-coded final-level identity is authorized. If a new scene or focus architecture becomes necessary, stop and return to GPT.

## Machine contract for the implementation gate

The implementation task must prove at minimum:

- the trigger is the validated `final_level` route fact plus ordinary completion;
- entries 1–7 retain automatic return;
- sequence 8 enters a stable acknowledgment state after completion;
- progress/best turns are recorded once per active Gameplay session, including replay/recompletion safety;
- acknowledgment, `Esc`, and `R` have deterministic non-conflicting behavior;
- Help and Timeline do not open or alter state during the final acknowledgment;
- direct-development routing retains the catalog-derived final fact without hard-coded identity;
- all eight formal hashes/metrics and the catalog hash remain exact;
- aggregate regression remains at 9 vectors, all prior markers appear exactly once, and one new stable Task 0021 marker appears exactly once.

Native capture acceptance remains a separate Gate 2. Gate 1 may use headless/layout assertions but does not claim independent capture, owner, complete-flow, build, export, release, or festival readiness.

## Production-readiness disposition

The Task 0020 readiness matrix is accepted as a source-backed plan. Persistent save/settings/reset, complete menu/pause/credits, coherent localization/font, icon/splash, rights/attribution, Windows reproducible export, RC acceptance, and festival materials remain later separately bounded gates. Controller and Web remain explicit deferrals.

## Stop and rollback

Stop if the implementation requires a hard-coded level ID, catalog/schema/formal-level change, canonical-state mutation, new scene architecture, persistence coupling, double completion recording, input trapping, or non-final routing regression. Rollback is the single finale-presentation topic.

This acceptance is not ending implementation, machine/capture acceptance, owner acceptance, production readiness, export/build readiness, RC acceptance, release, upload, or submission readiness.

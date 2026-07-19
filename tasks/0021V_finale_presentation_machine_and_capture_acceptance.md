# Task 0021V — Validate the eight-level finale presentation in native product flow

- Status: `READY`
- Gate: `NATIVE MACHINE / ROUTE / CAPTURE ACCEPTANCE`
- Repository/root/branch: `zcx369658780/delayed-self-godot` / `D:\Delayed_Self` / `main`
- Accepted implementation: `ad5d71275e9b218b9bf5dec08f27b460d37398d9`
- GPT acceptance: `docs/reports/0021_GPT_EIGHT_LEVEL_FINALE_PRESENTATION_ACCEPTANCE.md`
- Acceptance commit: `7d1f66bb10360ed6c3eb85096421a9451d076fec`
- Formal scope: exactly eight levels; sequence 8 `two_echo_convergence` remains sole final

## 1. Objective

Independently validate Task 0021 in the native Compatibility-renderer product flow without changing implementation.

Prove that:

```text
non-final completion -> record once -> automatic Level Select return
final completion     -> record once -> FINAL_ACKNOWLEDGEMENT_VISIBLE
```

and that the final acknowledgment is readable, deterministic, state-safe, and provides clear bounded return/replay behavior.

This task is validation and documentation only. It must not fix product defects or begin owner review, production closure, persistence/settings, localization, assets/audio, build/export, RC, release, or submission work.

## 2. Startup gate

Before any run:

- verify exact root `D:\Delayed_Self`, branch `main`, and expected SSH origin;
- require a clean tracked and untracked worktree;
- fetch and fast-forward only;
- require `HEAD == origin/main` and that HEAD contains acceptance commit `7d1f66bb10360ed6c3eb85096421a9451d076fec`;
- verify Godot `4.7.stable.steam.5b4e0cb0f` or exact documented equivalent;
- require no residual Godot process.

Stop on divergence, conflict, unexpected files, wrong toolchain, or unexpected generated paths.

Read `AGENTS.md`, current startup/active-task documents, this task, Task 0021 and its implementation report, GPT acceptance, Task 0020 plan, AppRoot, Gameplay, progress adapter, catalog, formal hashes, focused test, aggregate registration, capture conventions, and generated-file safety rules.

Before running, print a concise validation plan covering tests, native route setup, captures, input branches, hash checks, cleanup, stop conditions, and report outputs.

## 3. Frozen implementation and forbidden scope

Treat Task 0021 product/test implementation as frozen.

Do not modify:

```text
scripts/
scenes/
tests/
data/
schemas/
project.godot
```

Do not change completion copy, font size, rectangles, input mappings, route behavior, progress behavior, formal data, catalog, Help, Timeline, Simulation, solver, settings, persistence, assets, audio, or export configuration.

If a product or test defect is found, record it and stop with the required blocker verdict. Do not repair it in this task.

## 4. Required machine reruns

Run the existing Task 0021 focused suite and the full aggregate from the accepted toolchain.

Require:

```text
focused assertions = 42
focused exit = 0
focused stderr = empty
aggregate assertions = 621
aggregate vectors = 9
all fourteen stable markers exactly once
aggregate exit = 0
aggregate stderr = intentional LEVEL_ID_MISMATCH only
```

Any different count, marker multiplicity, error, warning, crash, parser failure, or unexpected stderr is a blocker.

## 5. Frozen data and source audit

Verify and record:

- catalog SHA-256 exactly `a2bfa892f77370ac4d7e93ba5b6ce5970f0d7ba75160e1b2d00c4384f3da4e51`;
- all eight accepted formal level SHA-256 values exactly;
- accepted metrics for all eight levels exactly;
- sequence 8 remains the only `final_level=true` entry;
- AppRoot and Gameplay use catalog-derived `route_payload.final_level`, with no hard-coded `two_echo_convergence`, sequence number, title, coordinates, or progress-count finale check;
- `FINAL_ACKNOWLEDGEMENT_VISIBLE` remains presentation-derived and absent from Simulation/canonical state;
- no scene, catalog, formal data, progress adapter, Help, Timeline, Simulation, solver, schema, project-setting, persistence, asset, audio, build, export, release, or submission drift exists relative to the accepted commit.

## 6. Native product-flow setup

Use repository-external harnesses and evidence only under:

```text
D:\Delayed_Self_Evidence\0021V_finale_presentation_acceptance\
```

Exercise the actual AppRoot-hosted route. A bounded validation harness may seed the existing memory-only progress adapter in memory to unlock sequence 8, but must not add a product API, write player data, or alter repository files.

Use the exact accepted final-level witness or an equivalent deterministic product-flow route only inside the external harness. Do not publish the route as Help or owner-review material.

All captures must be game-window-only. Do not collect desktop, account, notification, face, voice, raw keyboard log, or unrelated-window evidence.

## 7. Required native behaviors

Validate in separate fresh AppRoot/GamePlay instances where input alternatives could interfere.

### 7.1 Non-final control

Complete one unlocked non-final level through hosted product flow and prove:

- progress records once;
- route changes automatically to Level Select;
- final acknowledgment does not appear;
- active screen count remains one;
- no stale Gameplay callback changes the later route.

### 7.2 Final completion

Complete sequence 8 through hosted product flow and prove:

- progress/best turns record once;
- route remains `GAMEPLAY`;
- the same Gameplay instance remains active;
- `FINAL_ACKNOWLEDGEMENT_VISIBLE` is present;
- completed Simulation state and canonical key remain unchanged after presentation activation;
- exact provisional copy is visible;
- Timeline and Help are hidden;
- movement, H, and non-return gameplay inputs do not enter Simulation or change the canonical key.

### 7.3 Return inputs

Using separate fresh final-completion instances, validate each:

- Enter / `ui_accept` returns once to Level Select;
- Space / `wait_turn` returns once to Level Select rather than entering Simulation;
- Esc returns once to Level Select;
- repeated key events or echo events cannot double-route;
- active screen count remains one after return.

### 7.4 Replay

From the final acknowledgment:

- R reconstructs the exact initial state;
- acknowledgment state and return guard clear;
- route remains Gameplay;
- replay can complete and show the acknowledgment again;
- completion/best-turn state is not recorded a second time in the same Gameplay session;
- later Enter/Space/Esc still returns exactly once.

### 7.5 Direct-development route

Launch sequence 8 through the generic development-direct route and prove:

- the catalog-derived final fact still produces the acknowledgment;
- locked prerequisite state may reject progress recording as designed;
- presentation and return remain correct;
- no special level-ID behavior exists.

## 8. Required captures

Capture and manually inspect at least the following native Compatibility-renderer frames:

1. non-final completion immediately before automatic return, or the nearest deterministically capturable product-flow state plus route trace;
2. sequence-8 pre-completion state;
3. final acknowledgment at native 960x540;
4. final acknowledgment after reduced-motion is enabled through the accepted test hook;
5. final acknowledgment in a grayscale capture treatment;
6. final acknowledgment at one wider proportional window size;
7. final acknowledgment at one non-proportional resized window with accepted bars/transform;
8. Level Select immediately after Enter return;
9. final Gameplay immediately after R replay/reset;
10. Level Select after Esc or Space return;
11. direct-development final acknowledgment;
12. a non-final completed control without final copy.

For every capture verify:

- exact intended surface is visible;
- no clipping, overlap, horizontal overflow, off-screen text, or unreadable control hint;
- acknowledgment copy fits its bounded rectangle;
- board, entities, and completion surface do not create critical collisions;
- grayscale and reduced-motion retain the full meaning;
- resized presentation preserves the accepted logical 960x540 transform and symmetric bars where applicable;
- no Help or Timeline leakage appears in the final acknowledgment;
- no route/witness text appears.

Record exact image dimensions and do not normalize images while claiming native dimensions.

## 9. Evidence and cleanup

The external evidence index must include:

- commands and exact toolchain;
- focused and aggregate stdout/stderr;
- catalog/formal/source audit;
- route and progress snapshots;
- canonical keys before/after final acknowledgment and ignored inputs;
- one-record and one-return counters;
- exact capture list, dimensions, manual audit, and SHA-256 values;
- cleanup and Godot-process audit.

After all runs, close every Godot process.

Generated cleanup is authorized only under the narrow established rule: if `project.godot` is the sole unintended tracked change and all untracked paths are regular repository-local `.gd.uid` files, restore literal worktree `project.godot` and delete only the enumerated UIDs one by one. Stop on any differing set. Never use broad clean/reset/stash/rebase/amend/force operations.

## 10. Acceptance and blocker policy

Accept only when all machine, route, state, progress, input, capture, resize, grayscale, reduced-motion, hash, regression, and cleanup gates pass.

Stop with a blocker on any:

- final/non-final branch error;
- double or missing progress recording;
- double return, stale callback, or active-screen leak;
- canonical-state mutation from presentation or ignored inputs;
- R replay mismatch;
- Help/Timeline/input leakage;
- hard-coded final identity;
- copy clipping, unreadable return action, grayscale/reduced-motion loss, or resize failure;
- hash/metric/catalog/test drift;
- unexpected repository or generated-file change.

Do not perform product fixes.

## 11. Repository outputs

Create/update documentation only:

```text
docs/reports/0021V_EIGHT_LEVEL_FINALE_PRESENTATION_ACCEPTANCE_REPORT.md
docs/CODEX_ACTIVE_TASK_CURRENT.md
docs/CODEX_STARTUP_SNAPSHOT_CURRENT.md
docs/DEVELOPMENT_PLAN_CURRENT.md
docs/DOC_INDEX_CURRENT.md
docs/HANDOFF_MASTER_CURRENT.md
docs/project_memory.md
docs/ux/PRESENTATION_VIEWPORT_AND_HUD_DIRECTION_CURRENT.md
```

Stage explicit authorized Markdown paths only.

Use one commit with exact message:

```text
docs: validate Delayed Self final acknowledgment flow
```

Push normally and require clean worktree, `HEAD == origin/main`, divergence `0/0`, and zero residual Godot processes.

## 12. Terminal verdict

Return exactly one:

```text
EIGHT_LEVEL_FINALE_PRESENTATION_ACCEPTED_FOR_OWNER_REVIEW
BLOCKED_EIGHT_LEVEL_FINALE_PRESENTATION_MACHINE_OR_CAPTURE
```

Include commit SHA when documentation is produced, focused/aggregate results, exact hashes, native route outcomes, recording/return/replay results, capture count/dimensions/audit, external evidence root, cleanup, and final Git state.

## 13. Non-claims

This task does not establish owner acceptance, fresh or independent review, final copy/localization acceptance, complete-flow or production readiness, persistent save/settings/menu readiness, build/export readiness, release-candidate acceptance, release, upload, or festival submission readiness.

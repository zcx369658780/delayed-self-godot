# Task 0022 — Plan complete-flow and production closure

- Status: `READY`
- Gate: `COMPLETE-FLOW / PROTECTED-DATA / PRODUCTION-CLOSURE PLANNING`
- Repository/root/branch: `zcx369658780/delayed-self-godot` / `D:\Delayed_Self` / `main`
- Parent plan: `docs/production/EIGHT_LEVEL_FINALE_CLOSURE_AND_PRODUCTION_PLAN_CURRENT.md`
- Owner adjudication: `docs/reports/0021W_GPT_OWNER_FINALE_WALKTHROUGH_ADJUDICATION.md`
- Expected publication checkpoint: `83ff84dfff45095f5fcd52fed60119d2b7211dc0`

## 1. Objective

Produce an implementation-ready, source-backed plan for Task 0020 Gate 4 without changing the product.

The plan must close or explicitly defer the critical non-export gaps between the accepted eight-level finale flow and a complete desktop product:

- persistent progress/profile safety;
- New Game / Continue / Reset;
- menu, pause, quit-confirmation, and Credits flow;
- settings and settings persistence;
- coherent English/Simplified-Chinese localization and licensed font strategy;
- bounded narrative-copy revision, including the final acknowledgment;
- Credits/Attribution and public README accuracy;
- icon/splash and visual/audio accept-or-defer decisions.

Select exactly one first implementation slice and define the ordered, independently reversible slices that follow it.

## 2. Startup gate

Before inspection:

- verify root exactly `D:\Delayed_Self`;
- verify branch `main`, expected SSH origin, and clean tracked/untracked worktree;
- fetch and use only `git merge --ff-only origin/main` when needed;
- require `HEAD == origin/main` and that HEAD contains `83ff84dfff45095f5fcd52fed60119d2b7211dc0`;
- require no residual Godot process.

Stop on divergence, conflict, wrong root/remote, unexpected files, or an uncommitted product path.

## 3. Required reads and source inspection

Read:

1. `AGENTS.md`, current startup/active-task documents, and this task;
2. Task 0020 plan/report/GPT acceptance;
3. Tasks 0021, 0021V, 0021W and their implementation, machine/capture, owner, and GPT-adjudication documents;
4. the GDD, production roadmaps, presentation direction, license/attribution documents, README, and environment/toolchain reports;
5. current AppRoot, Main Menu, Level Select, Safe Error, Gameplay, memory-progress adapter, project settings/input map, scenes, tests, and catalog.

Inspect the repository for any existing persistence, settings, localization, font, Credits, icon/splash, audio, version, export, and public-status surfaces. Do not assume absence or readiness without source evidence.

No Godot, regression, capture, build, export, download, font acquisition, or asset acquisition is required unless a read-only parser/inspection command is essential. Record any command used.

## 4. Frozen product authorities

Preserve:

- exactly eight formal levels and the byte-identical eight-entry catalog;
- sequence 8 `two_echo_convergence` as the sole final level;
- Task 0021/0021V final acknowledgment flow and record-once behavior;
- Simulation, solver, schema, action order, canonical state, Help predicate, Timeline optionality, Level Select scrolling, Safe Error, and window-presentation contracts;
- owner-only review boundary;
- sequence 9/B007/candidate A/B/C as deferred historical evidence only.

Do not propose new formal levels, transitional rooms, sequence-9 revival, route walkthrough Help, a cutscene system, networking/accounts, cloud save, achievements, controller support, or Web as part of the critical path.

## 5. Persistent profile/save planning

Specify a minimum local desktop persistence contract before any UI implementation:

- user-data location using Godot-supported user storage, never repository paths;
- one versioned profile format with an explicit schema/version field;
- completed level IDs and best turns required to preserve current progression semantics;
- settings data ownership: same file or separately justified file;
- atomic write strategy and replacement behavior;
- deterministic load validation;
- missing-file clean-profile behavior;
- malformed/truncated/unknown-version/corrupt-file recovery behavior;
- safe backup/quarantine policy if used;
- migration policy and explicit statement when no legacy on-disk format exists;
- reset confirmation and deletion/reinitialization semantics;
- test-only profile directory isolation so tests never touch real user data;
- rollback and player-data safety boundary.

Do not design cloud sync, multiple named save slots, account identity, or unbounded migrations.

## 6. Complete navigation planning

Define the minimum coherent product flow and state transitions for:

```text
Boot
→ Main Menu
→ New Game / Continue
→ Level Select
→ Gameplay
→ Pause / Resume / Restart / Level Select / Quit confirmation
→ Final acknowledgment
→ Level Select or Main Menu
→ Credits / Settings
```

Plan exact menu availability for clean, partial, and completed profiles. Resolve the semantics of New Game versus Continue and whether Reset belongs in Settings or profile management. Require confirmation for destructive reset and application quit where appropriate.

Do not replace the accepted generic route architecture with a new navigation framework unless source evidence proves it unavoidable; such a result must be a blocker, not an automatic redesign.

## 7. Settings planning

Select the smallest settings contract that supports the Windows critical path. Evaluate and explicitly include, defer, or reject:

- windowed/fullscreen mode;
- reduced motion;
- master volume only if audio is retained for current scope;
- language selection;
- optional display-scale or resolution controls only if the existing keep-aspect presentation needs them.

Settings must be persistent, validated, safely defaulted, and applied without changing puzzle state. Controller mappings and Web-specific settings remain deferred.

## 8. Localization, font, and narrative-copy planning

Plan one coherent localization architecture rather than isolated translated strings:

- English and Simplified Chinese target set;
- stable string keys or another bounded source-backed approach;
- coverage inventory for Main Menu, Level Select, Gameplay HUD, Help, errors, final acknowledgment, Settings, Credits, confirmations, and public-facing status text where applicable;
- licensed font requirements, glyph coverage, fallback behavior, redistribution rights, and attribution;
- 960×540 and resized text-fit validation;
- language-switch behavior and persistence;
- prohibition on English-only or Chinese-only one-off exceptions.

The owner P3 narrative finding may be addressed only as bounded copy planning using existing UI surfaces. Do not add cutscenes, voice acting, branching narrative, or new formal levels. Explain how earlier copy can provide enough narrative weight for the accepted final acknowledgment without becoming verbose or route-revealing.

## 9. Credits, licensing, public status, and polish decisions

Inventory and plan:

- Credits/Attribution page and authoritative license ledger flow;
- README correction from bootstrap/development-shell status to accurate playable-project status;
- icon and splash requirements for Windows packaging;
- procedural/current visuals versus optional licensed visual polish;
- audio/music as one explicit `IMPLEMENT`, `DEFER`, or `OMIT_FOR_RC` decision, including mute-equivalence and license evidence;
- image-based Help as an optional later presentation slice only, not a blocker to persistence/menu/localization;
- Level 7 difficulty transition as a disclosed residual limitation; no new room is allowed.

No asset, font, audio, or image may be downloaded, generated, imported, or licensed in this planning task.

## 10. Slice and dependency design

Define independently reversible implementation slices. At minimum evaluate this order:

1. persistent profile/save core and isolated tests;
2. Main Menu New Game/Continue/Reset plus pause/quit-confirmation flow;
3. persistent settings;
4. localization/font and bounded narrative copy;
5. Credits/Attribution, README, icon/splash, and polish accept-or-defer closure;
6. complete-flow machine/capture acceptance;
7. owner-only complete-flow walkthrough;
8. Windows export/build validation.

Select exactly one first implementation slice. The default should be the persistence core unless source evidence proves another protected prerequisite must come first.

For every slice record:

- objective and user-visible result;
- exact likely path domains, without granting blanket write authority;
- prerequisites;
- acceptance evidence;
- P0/P1 stop conditions;
- rollback boundary;
- non-claims.

## 11. Risk and readiness matrix

Update the Task 0020 production-readiness matrix using only:

```text
READY
PARTIAL
MISSING
DEFERRED
NOT_APPLICABLE
```

Separate:

- current proven state;
- state expected after each planned slice;
- Windows RC blockers;
- optional quality improvements;
- explicit scope cuts.

Do not mark persistence, settings, localization, assets, builds, RC, or festival packaging ready on the basis of planning.

## 12. Required outputs

Create:

```text
docs/production/COMPLETE_FLOW_PRODUCTION_CLOSURE_PLAN_CURRENT.md
docs/reports/0022_COMPLETE_FLOW_PRODUCTION_CLOSURE_PLANNING_REPORT.md
```

The plan must include:

- source-backed current architecture and gap inventory;
- protected save/profile contract;
- complete navigation contract;
- settings contract;
- localization/font/narrative-copy contract;
- licensing/public-status/polish decisions;
- ordered reversible slices;
- exactly one selected first implementation slice;
- readiness matrix;
- stop, rollback, owner-review, export, and non-claim boundaries.

Update only the minimum CURRENT planning, navigation, handoff, roadmap, GDD/production, and project-memory Markdown files needed to point to the plan.

## 13. Authorized repository paths

Documentation only. May create/update the two outputs above and the minimum necessary Markdown under:

```text
docs/CODEX_ACTIVE_TASK_CURRENT.md
docs/CODEX_STARTUP_SNAPSHOT_CURRENT.md
docs/DEVELOPMENT_PLAN_CURRENT.md
docs/DOC_INDEX_CURRENT.md
docs/HANDOFF_MASTER_CURRENT.md
docs/project_memory.md
docs/production/
docs/game_design/
docs/ux/
README.md
```

README may be changed only if Task 0022 explicitly produces a documentation-only accuracy correction that is clearly separable and justified; otherwise plan it for a later implementation slice.

Do not modify product source, tests, scenes, project settings, formal data, catalog, schemas, assets, licenses, export files, or user data.

## 14. Git discipline

Require one documentation-only commit:

```text
docs: plan Delayed Self complete-flow production closure
```

Stage explicit authorized Markdown paths only. Run link validation and `git diff --check`. Preserve a clean worktree, `HEAD == origin/main`, divergence `0/0`, and no Godot process.

## 15. Terminal verdict

Return exactly one:

```text
COMPLETE_FLOW_PRODUCTION_CLOSURE_PLAN_READY_FOR_GPT_REVIEW
BLOCKED_COMPLETE_FLOW_PLANNING_INCONSISTENCY
```

Include the commit SHA, selected first implementation slice, ordered slice list, protected persistence decisions, localization/font decision, audio/visual scope decision, output paths, and final Git state.

This task authorizes no product implementation, player-data creation, localization/font acquisition, asset/audio work, build/export, owner review, RC, upload, release, or festival submission.

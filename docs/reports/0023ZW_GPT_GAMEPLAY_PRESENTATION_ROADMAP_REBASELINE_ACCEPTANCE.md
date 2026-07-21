# Task 0023ZW GPT acceptance — gameplay breadth and presentation roadmap rebaseline

- Verdict: `TASK_0023ZW_GAMEPLAY_PRESENTATION_ROADMAP_REBASELINE_ACCEPTED_WITH_BINDING_SEQUENCE_POLICY`
- Reviewed implementation commit: `d96dc822b0785ff231099380d4ed13de451de9ca`
- Accepted predecessor: `TASK_0023ZV_PROCESS_RECONCILIATION_AND_CONTROLLED_READ_ACCEPTED`
- Review date: 2026-07-21

## Accepted direction

The product target is now twelve submission-core levels with levels 13–14 retained only as date- and stability-gated stretch scope. The submission default is Simplified Chinese. The presentation direction is the hand-drawn delayed-notebook / ink-ECHO style. A minimal credited music layer of two loops plus an optional restrained finale cue is accepted as the target, subject to a separate license-ledger and asset-import gate.

Core mechanic families selected for implementation planning are:

- YOU-only push crates;
- YOU-only consumable keys and locks;
- grouped multi-cell barriers / bridges;
- typed occupancy sensors (`ANY_ACTOR`, `YOU_ONLY`, `ECHO_ONLY`) with explicit crate eligibility;
- one-shot room-local latches.

Paired portals, one-way gates, fragile floors and conveyors remain stretch candidates and are not core implementation authority.

## Binding sequence and Profile policy

The planning package is accepted with one binding correction: the existing eight implemented levels must not be reordered or replaced.

- Existing level IDs and sequences 1–8 remain stable.
- Existing `two_echo_convergence` remains sequence 8 and becomes the chapter-2 capstone when expansion is implemented.
- New core rooms are appended as sequences 9–12.
- A new sequence-12 room may become the sole formal finale only through a later catalog/profile integration gate.
- Existing completed IDs, best-turn records and settings must be preserved.
- Existing profiles do not silently change language.
- New-profile default may become `zh-Hans` only through a separately accepted compatibility/default-activation gate.
- Level 9 should unlock only when the stable sequence-8 room is completed; existing 1–8 progression remains unchanged.

This policy avoids reinterpreting or rewriting the observed development Profile (`7 completed / 7 best-turn / 8 unlocked`).

## Mechanic-contract acceptance

The deterministic turn doctrine in the rebaseline is accepted as design authority for future implementation: movement feasibility from one turn-start snapshot, YOU-only item/push resolution after movement, sensors/latches after item resolution, barrier changes applying to the next turn, and exit evaluation last. Restart restores all room-local mutable state. ECHOs never replay crate pushes or item collection.

Implementation must remain backward compatible with all eight existing rooms and must extend Simulation, schema, solver, canonical state hashing and focused tests before formal level data or presentation integration.

## Presentation, language and audio

The hand-drawn notebook direction is accepted as the target identity layer. Grid/collision geometry remains deterministic underneath. Visual communication must use icon/shape/text redundancy and cannot depend on color alone.

`LXGW WenKai GB / 霞鹜文楷 GB` is accepted only as a candidate pending OFL file, glyph coverage and package-size verification. No font acquisition/import is authorized by this acceptance.

The supplied Crow Producer notice visibly states commercial-project use is allowed without an additional copyright fee, requires the exact attribution `音乐由[乌鸦Producer]提供`, is non-exclusive and forbids standalone resale. Track identity, source provenance, conversion/editing interpretation, attribution placement and package import still require a separate asset/license gate. No audio download, conversion or import is authorized here.

## Scope and non-claims

The commit changed only the thirteen authorized documentation paths. Product source, scenes, catalog/formal level data, schema, tests, project settings, Profile data, assets, fonts, audio and build outputs remain unchanged. The implemented game still contains exactly eight formal levels until later implementation gates pass.

This acceptance does not authorize catalog expansion, Profile writes or reset, final-flag movement, presentation asset import, localization implementation, audio import, build/export, upload or submission.

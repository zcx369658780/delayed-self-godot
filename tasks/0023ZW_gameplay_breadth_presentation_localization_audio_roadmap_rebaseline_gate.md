# Task 0023ZW — Rebaseline gameplay breadth, presentation, localization, audio and submission roadmap

- Status: `READY`
- Gate: `DOCUMENTATION ONLY / MAJOR PRODUCT-SCOPE REBASELINE + ZERO IMPLEMENTATION`
- Repository/root/branch: `zcx369658780/delayed-self-godot` / `D:\Delayed_Self` / `main`
- GPT prerequisite acceptance: `docs/reports/0023ZV_GPT_PROCESS_RECONCILIATION_AND_CONTROLLED_READ_ACCEPTANCE.md`
- Required checkpoint: `c1bc679ef73b8a86d9dac8559b3dfc010ccbe5b6`
- Accepted controlled-read result: `LOADED / PRODUCTION_PROFILE_READY / MAIN_MENU`
- Player-data authority: none
- Asset-import/download authority: none
- Product implementation authority: none

## 1. Objective

Replace the previous persistence-first eight-level closure roadmap with a decision-ready product rebaseline reflecting the owner's explicit direction:

1. prioritize mechanic breadth and replayable puzzle variety over higher difficulty;
2. add Sokoban-like crate interaction, player-only keys/locks and broader barrier/bridge mechanisms;
3. evaluate additional low-complexity mechanics that strengthen the delayed-self/ECHO identity rather than becoming generic puzzle gimmicks;
4. move from raw geometric presentation to a coherent hand-drawn notebook/ink visual language while preserving simple collision geometry underneath;
5. make Simplified Chinese the submission default language;
6. introduce a minimal but real music layer using the owner-provided Crow Producer free-commercial music library, with exact attribution/licensing obligations;
7. replan level count, finale position, Profile/catalog implications, production gates and submission schedule.

This task produces plans and decisions only. It must not modify product source, scenes, data, tests, project settings, Profile files, assets, fonts, audio files, import metadata, export settings or build outputs.

## 2. Startup and frozen authority

Require clean root/branch/origin, fetch and fast-forward only, `HEAD == origin/main`, ancestry of:

```text
c1bc679ef73b8a86d9dac8559b3dfc010ccbe5b6
7b6385926ae872cecd45b6fce106403152d339aa
09e83bc6e21aa2c6598043a5ea2dfa602953429d
afe8c6fffdc98992b732fce46f206ad0dc8553a1
```

Read the canonical GDD, gameplay simulation contract, level schema/catalog contracts, current eight level files/catalog, Task 0020/0022 production plans, Task 0023ZO activation design, Task 0023ZS/ZT/ZV reports and all CURRENT authority docs.

The existing eight levels and sequence-8 finale remain the accepted implementation baseline during planning. This task may recommend replacing the old count/finale policy, but cannot change catalog data, final flags, IDs or Profile behavior.

## 3. Required level-count decision package

Compare and score these options:

```text
A. 12 formal levels: 8 accepted baseline levels + 4 new mechanic-breadth levels
B. 14 formal levels: 8 accepted baseline levels + 6 new mechanic-breadth levels
C. 12 formal levels for submission + 2 predeclared stretch levels only if stability/date gates pass
D. 8 main levels + optional post-ending bonus rooms without moving the current finale
```

Default recommendation to test is **C: 12 submission-core levels plus 2 stretch levels**.

For each option address:

- chapter/pacing structure;
- whether `two_echo_convergence` stays final, becomes a chapter capstone, or is succeeded by a new finale;
- stable level IDs versus sequence/catalog reorder;
- current Profile implications, including the observed 7 completed / 8 unlocked state;
- migration/reset/owner-authorization needs;
- solver/state-space and test-harness costs;
- submission-date risk;
- minimum owner playtest burden.

No option becomes frozen until GPT/owner acceptance of this planning task.

## 4. Required mechanic contracts

Produce exact turn-order, collision, replay, schema and visual semantics for at least these candidate mechanics.

### 4.1 Core candidates

1. **Player-only push crates**
   - only YOU may push;
   - ECHOs cannot push or duplicate crate movement;
   - crates occupy one tile, block actor movement and may hold occupancy plates;
   - define wall/door/crate/actor collision order and deadlock expectations.

2. **Player-only keys and consumable locks**
   - only YOU collects keys;
   - entering a matching locked-door interaction consumes the key and removes the door for the rest of the room attempt;
   - ECHOs neither collect nor recreate keys;
   - define restart/replay reset semantics and whether multiple colors are allowed for submission.

3. **Multi-cell barriers and bridges**
   - one mechanism may control multiple marked cells;
   - cells must be visually grouped by a shared hand-drawn mark/color/icon;
   - define simultaneous actor occupancy safety and close/open timing.

4. **Typed occupancy sensors**
   - `ANY_ACTOR`, `YOU_ONLY`, and `ECHO_ONLY` candidates;
   - define whether crates count and how visual language prevents ambiguity;
   - avoid hidden rules.

5. **One-shot latch / permanent room switch**
   - first valid activation permanently changes one bounded barrier group until restart;
   - define whether YOU, ECHO or both can activate each declared type;
   - no toggle spam or memory outside the room attempt.

### 4.2 Stretch candidates

Evaluate but do not automatically select:

- paired teleport pads;
- one-way gates/turnstiles;
- fragile floor tiles;
- deterministic conveyor/moving-floor cells.

Reject mechanics that materially increase implementation/state-space cost without creating a new delayed-self relationship.

## 5. Puzzle-design doctrine

The rebaseline must freeze these intended principles for owner review:

- mechanic breadth, not higher execution difficulty;
- introduce at most one unfamiliar mechanic in an onboarding room;
- core submission rooms combine at most three mechanic families;
- no solution relies on an undocumented priority rule;
- target solution length and branching should not exceed the current hardest accepted room unless explicitly justified;
- every new mechanism must create a role distinction between YOU, ECHO, crate or room state;
- avoid generic Sokoban rooms where the delayed-self system is incidental;
- every core mechanic receives one introduction room and at least one integration room.

Produce a candidate 12-level and 14-level curriculum table with level purpose, introduced mechanics, combined mechanics, expected cognitive lesson and approximate solution-band target. Do not author final level JSON in this task.

## 6. Presentation rebaseline

Prepare a low-cost coherent visual direction named provisionally:

```text
HAND-DRAWN DELAYED NOTEBOOK / INK-ECHO STYLE
```

Required decisions:

- retain grid/collision geometry but replace raw primitives with hand-drawn sprites, irregular ink outlines, paper texture and restrained animation;
- distinguish YOU, ECHO generations, crates, keys, locks, plates, multi-cell barrier groups and exit at a glance;
- use limited color plus shape/icon redundancy for accessibility;
- adopt a handwriting-adjacent Chinese UI font with readable body copy;
- evaluate `LXGW WenKai GB`/霞鹜文楷 GB as the primary UI candidate under OFL-1.1, with a custom or stronger title treatment only if licensing remains clear;
- redesign title screen, menu buttons, level cards, HUD labels, Help/Timeline surfaces and finale overlay without changing navigation semantics;
- define the minimum asset inventory, source/creation method, license ledger and file-size budget;
- separate submission-minimum polish from optional reskin breadth.

No image/font acquisition, generation or import is authorized here.

## 7. Language rebaseline

Prepare the contract for:

```text
submission default = zh-Hans
```

Address:

- current codec default `en` versus new-profile default `zh-Hans`;
- existing development Profile behavior and explicit reset/migration decision;
- whether English remains fully supported for submission, becomes post-submission, or is retained only for key UI strings;
- Chinese copy inventory for title/menu/tutorial/Help/Timeline/level names/errors/finale/credits;
- font coverage and text-fit gates;
- no silent overwrite of an existing player's selected language.

This task may recommend a schema-compatible default change but must not implement or touch the production Profile.

## 8. Audio and license plan

Use the owner-provided source references only as planning inputs:

```text
Bilibili preview: https://www.bilibili.com/video/BV1uFcwe1EDV
Google Drive library: https://drive.google.com/drive/folders/1ce8LP87A2Yc1xRLvaCpZr13KI5S-f_Aw
```

Record the observed license requirements:

- commercial game use allowed without additional royalty;
- non-exclusive;
- no direct resale of the music as a standalone product;
- preserve author attribution;
- required credit format: `音乐由[乌鸦Producer]提供`.

Prepare an owner-audition shortlist, not a final asset selection. Include at minimum:

```text
Main menu candidates:
- 晚安，星期八
- 1：0.618(loop)

Gameplay candidates:
- 1：0.618(loop)
- Circulation(loop)
- 优哉游哉(loop)

Late/finale candidates:
- 宇宙，我，和她
- A Forever Friend
- Follow The Light
```

Explain fit, looping availability, package-size implications and whether conversion to Godot-friendly compressed audio needs a separate explicit license/asset-import gate. Recommend a submission-minimum music plan of two or three tracks plus credits. Do not download, copy, transcode or import audio in this task.

## 9. Revised production roadmap

Produce a dated gate sequence from the current checkpoint to submission. It must distinguish:

1. scope/mechanics finalization;
2. shared mechanic-system implementation;
3. one vertical-slice room per selected mechanism family;
4. curriculum/content batch to 12 core levels;
5. conditional stretch decision for levels 13–14;
6. hand-drawn presentation implementation;
7. Chinese-default/localization/font integration;
8. music audition, license ledger and import;
9. production Profile first-write/default activation and menu flow;
10. complete-flow machine acceptance;
11. owner walkthrough;
12. Windows build, package, video and submission.

Define hard cut dates and scope cuts. Audio breadth, English completeness, levels 13–14 and advanced mechanics must be first candidates for deferral before compromising the 12-level Chinese-default complete flow.

## 10. Required outputs

Create/update only:

```text
docs/game_design/GAMEPLAY_BREADTH_AND_MECHANICS_REBASELINE_CURRENT.md
docs/presentation/HAND_DRAWN_NOTEBOOK_PRESENTATION_DIRECTION_CURRENT.md
docs/audio/MUSIC_SOURCE_LICENSE_AND_AUDITION_PLAN_CURRENT.md
docs/production/EXPANDED_CONTENT_SUBMISSION_ROADMAP_CURRENT.md
docs/reports/0023ZW_GAMEPLAY_PRESENTATION_ROADMAP_REBASELINE_REPORT.md
docs/game_design/DELAYED_SELF_GAME_DESIGN_DOCUMENT_CURRENT.md
docs/production/COMPLETE_FLOW_PRODUCTION_CLOSURE_PLAN_CURRENT.md
docs/DEVELOPMENT_PLAN_CURRENT.md
docs/DOC_INDEX_CURRENT.md
docs/HANDOFF_MASTER_CURRENT.md
docs/project_memory.md
docs/CODEX_ACTIVE_TASK_CURRENT.md
docs/CODEX_STARTUP_SNAPSHOT_CURRENT.md
```

Create missing `docs/presentation/` or `docs/audio/` directories only as parents of the named files. Modify no other path.

## 11. Validation and report

- no Godot execution required;
- no product/Profile/test-root/evidence-root access;
- no asset/font/audio download or import;
- no project setting, level data, catalog, schema, source, scene or test change;
- verify exact changed-path allowlist;
- verify the existing eight-level implementation hashes remain unchanged;
- document external-source facts and any uncertain license interpretation separately;
- end with one recommended product target and clearly labeled stretch scope.

Commit with:

```text
docs: rebaseline Delayed Self gameplay breadth and presentation roadmap
```

## 12. Terminal verdict

Return exactly one:

```text
GAMEPLAY_PRESENTATION_ROADMAP_REBASELINE_READY_FOR_GPT_REVIEW
BLOCKED_GAMEPLAY_PRESENTATION_ROADMAP_REBASELINE
```

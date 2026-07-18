# Task 0017P — Level Select scrollability repair

- Status: `READY`
- Gate: `APP SHELL PRESENTATION REPAIR / TASK 0017 PREREQUISITE`
- Repository/root/branch: `zcx369658780/delayed-self-godot` / `D:\Delayed_Self` / `main`
- Parent blocked task: `tasks/0017_echo_spacing_bridge_implementation.md`
- Blocker adjudication: `docs/reports/0017_GPT_LEVEL_SELECT_PRESENTATION_BLOCKER_ADJUDICATION.md`
- Expected publication checkpoint: `8c32d9f028b51bdbe9e4ac9dbe283de9af3f5482`

## Objective

Repair the existing Level Select so every catalog entry remains reachable at the accepted 960×540 logical viewport. The current fixed `VBoxContainer` places title, all 56px level buttons, and Back in one non-scrollable `600×410` column; eight entries clip the tail.

This task repairs App Shell presentation only. It must not recreate `echo_spacing_bridge`, edit the product catalog, resume Task 0017, or implement the finale.

## Startup and required reads

Verify exact root, `main`, expected origin, clean tracked/untracked state, synchronized `HEAD == origin/main`, and accepted Godot 4.7 toolchain. Read `AGENTS.md`, current startup/task documents, this task, the blocker adjudication, parent Task 0017 for context, `scripts/app/level_select.gd`, `scenes/ui/level_select.tscn`, AppRoot/catalog/progress code, relevant App Shell/progression/window tests, capture conventions, and generated-file safety rules.

Before edits, print the selected files and a concise control-tree, focus, scrolling, test, capture, cleanup, and rollback plan.

## Frozen behavior

Preserve:

- 960×540 logical presentation and window scaling;
- AppRoot routes and Safe Error behavior;
- catalog validation/order;
- MemoryProgress unlock/completion/reset semantics;
- locked/selected signal behavior;
- all formal levels, hashes, metrics, Gameplay, Simulation, solver, Timeline, Help, and Task 0015R feedback.

Do not modify `data/`, `schemas/`, `scripts/simulation/`, `scripts/solver/`, `scripts/gameplay/`, `project.godot`, formal levels, product catalog data, assets, persistence, build/export/release, bridge content, or finale content.

## Required layout

Prefer a code-only change in `scripts/app/level_select.gd`. Keep `scenes/ui/level_select.tscn` unchanged unless code-only is demonstrably insufficient.

Required semantics:

1. title remains fixed above the list;
2. generated level buttons are children of a bounded vertical `ScrollContainer`;
3. Back remains fixed below the list and never scrolls away;
4. horizontal scrolling/clipping is absent;
5. layout is catalog-count independent, with no branch for exactly eight entries;
6. button text, lock suffix, disabled state, minimum height, and signals remain intact;
7. mouse wheel/scrollbar and keyboard/controller focus can reach every enabled entry and Back;
8. locked entries remain unselectable;
9. after layout settles, the highest-sequence unlocked entry is brought into the viewport when otherwise clipped, without unlocking or selecting it;
10. initial progress must not jump to a locked tail.

Suggested tree:

```text
LevelSelect
├─ Background
└─ OuterPanel (VBoxContainer)
   ├─ Title
   ├─ EntryScroll (ScrollContainer)
   │  └─ LevelEntries (VBoxContainer)
   └─ Back
```

Use layout-safe deferred scrolling and `ensure_control_visible` or an equivalent tested method rather than guessed pre-layout offsets.

## Test snapshot

Extend `get_screen_snapshot()` only as needed, preserving existing entry facts. Tests should be able to inspect entry count, highest unlocked ID, scroll range/value, title/scroll/content/Back rectangles, per-entry rectangles and disabled state, visible/intersecting entries, and focused-control identity.

## Focused validation

Add one focused app test and one focused native capture harness; register a new marker in `tests/run_all.gd`:

```text
TASK_0017P_LEVEL_SELECT_SCROLLABILITY_TESTS_PASS
```

Test at minimum:

- current seven-entry product catalog;
- synthetic eight-entry sequence;
- synthetic twelve-entry sequence;
- every entry reachable at 960×540;
- title and Back visible at top and maximum scroll;
- first/middle/last enabled selections emit correct IDs;
- locked entries emit nothing;
- highest unlocked entry auto-visible after layout;
- initial progress does not jump to locked content;
- final entry reachable by scroll and focus navigation;
- no horizontal overflow;
- AppRoot navigation, return, reset, Safe Error, and window behavior unchanged.

Synthetic catalogs remain test-only and must not enter product data.

Final aggregate requirements:

- exit 0;
- assertions at least the accepted 391 baseline; vectors exactly 9;
- all prior ten markers exactly once plus the new marker exactly once;
- seven-entry product catalog and all seven formal hashes/metrics unchanged;
- stderr only the accepted intentional `LEVEL_ID_MISMATCH`;
- no failed assertion, parser/runtime error, or crash.

## Native captures

Capture game-window-only 960×540 evidence for:

1. current seven-entry product catalog;
2. synthetic eight-entry list at top;
3. eight-entry list with final entry visible;
4. highest unlocked entry visible;
5. synthetic twelve-entry list at top and bottom;
6. Back visible at maximum scroll;
7. keyboard/controller focus on the last enabled entry;
8. grayscale frame;
9. existing resized/window-transformed presentation when supported.

Verify title/Back never leave the viewport, the scroll region does not overlap them, final entries are not hidden beneath Back, labels remain legible, the scrollbar does not cover text, and focus/disabled distinctions survive grayscale.

## Evidence and generated files

External evidence root:

```text
D:\Delayed_Self_Evidence\0017P_level_select_scrollability\
```

Record commands, focused/aggregate outputs and exits, 7/8/12-entry snapshots, scroll/focus audits, captures, formal hashes/metrics, and a SHA-256 index. Do not stage evidence, captures, logs, caches, `.godot`, imports, or UID files.

Use the same narrow generated-file cleanup contract already authorized in Task 0017: only when `project.godot` is the sole unintended unstaged tracked change and every untracked item is a repository-local regular `.gd.uid`, with no Godot process, restore only the worktree copy of `project.godot` and remove only the frozen literal UID paths one by one. Any differing set is `BLOCKED_UNEXPECTED_WORKTREE_CHANGE`. Broad clean/restore, wildcard or recursive removal, reset, stash, rebase, amend, or force-push remain forbidden.

## Authorized paths

May modify only the minimum necessary subset of:

```text
scripts/app/level_select.gd
scenes/ui/level_select.tscn              # only if code-only is insufficient
tests/app/<focused scrollability test>.gd
tests/app/<focused capture harness>.gd
tests/run_all.gd
docs/reports/0017P_LEVEL_SELECT_SCROLLABILITY_REPAIR_REPORT.md
docs/CODEX_ACTIVE_TASK_CURRENT.md
docs/CODEX_STARTUP_SNAPSHOT_CURRENT.md
docs/DEVELOPMENT_PLAN_CURRENT.md
docs/DOC_INDEX_CURRENT.md
docs/HANDOFF_MASTER_CURRENT.md
docs/project_memory.md
docs/ux/PRESENTATION_VIEWPORT_AND_HUD_DIRECTION_CURRENT.md
```

Do not modify prior reports/tasks, product catalog data, progression implementation, bridge plan, or any protected surface.

## Report and Git discipline

Create `docs/reports/0017P_LEVEL_SELECT_SCROLLABILITY_REPAIR_REPORT.md` covering Git facts, overflow cause, control tree, scroll/focus/auto-visibility contract, tests, 7/8/12 results, captures, aggregate output, catalog/formal preservation, cleanup, evidence index, rollback, and non-claims.

Stage explicit authorized files only. Require `git diff --check` and cached checks to pass. Commit exactly once:

```text
fix: make Delayed Self level select scrollable
```

Fetch before push and stop on remote drift. Push normally; require clean worktree and `HEAD == origin/main`.

## Stop conditions

Stop without commit if any entry remains unreachable, title/Back scrolls away, locked entries become selectable, focus becomes trapped, auto-visibility changes progress, the fix is hardcoded to eight, horizontal clipping persists, AppRoot/window/baseline behavior regresses, any formal hash/metric changes, required captures fail, or an unauthorized path changes.

Use a specific verdict:

```text
BLOCKED_LEVEL_SELECT_REQUIRES_FORBIDDEN_SURFACE
BLOCKED_LEVEL_SELECT_ENTRY_UNREACHABLE
BLOCKED_LEVEL_SELECT_FOCUS_OR_SCROLL_REGRESSION
BLOCKED_LEVEL_SELECT_PRESENTATION_READABILITY
BLOCKED_BASELINE_OR_FORMAL_REGRESSION
BLOCKED_UNEXPECTED_WORKTREE_CHANGE
```

## Terminal verdict

After successful implementation, validation, one commit, push, and clean audit, return:

```text
LEVEL_SELECT_SCROLLABILITY_REPAIR_READY_FOR_GPT_REVIEW
```

Include commit SHA, changed paths, control tree, 7/8/12 reachability results, focused marker, aggregate assertions/vectors and all eleven markers, captures, catalog/formal preservation, cleanup disposition, report/evidence paths, and final Git state.

After GPT acceptance, a fresh bounded continuation task will recreate and validate `echo_spacing_bridge`. Do not resume Task 0017 in this task.
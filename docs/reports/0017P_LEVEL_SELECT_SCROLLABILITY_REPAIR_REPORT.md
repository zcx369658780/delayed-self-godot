# Task 0017P Level Select scrollability repair report

- Date: 2026-07-18
- Status: `LEVEL_SELECT_SCROLLABILITY_REPAIR_READY_FOR_GPT_REVIEW`
- Start: `main`, `HEAD == origin/main == bbb1b1975ea1e5cb19ed5251b928cc713ef5f81c`
- Required commit: `fix: make Delayed Self level select scrollable`
- Parent Task 0017 remains blocked and was not resumed.

## Cause and bounded repair

The prior Level Select built one fixed `600×410` `VBoxContainer` containing the title, every 56-pixel level button, and Back. Seven entries already overflowed the accepted 960×540 logical viewport; eight entries made the bridge and shifted Level 7 unreachable.

Task 0017P changes only `scripts/app/level_select.gd`:

```text
LevelSelect
├─ Background
└─ OuterPanel (fixed VBoxContainer)
   ├─ Title (fixed)
   ├─ EntryScroll (bounded vertical ScrollContainer)
   │  └─ LevelEntries (generated VBoxContainer)
   └─ Back (fixed)
```

`scenes/ui/level_select.tscn` remains byte-unchanged. The list is catalog-count independent. Horizontal scrolling is disabled. Existing text, lock suffixes, disabled states, 56-pixel minimum button height, selection signals, and Back signal remain intact.

## Scroll, focus, and automatic visibility

- `EntryScroll.follow_focus=true` and per-button `ensure_control_visible` keep focused entries in view.
- A generated focus chain connects every enabled entry and fixed Back; disabled entries are skipped.
- Scrollbars are excluded from keyboard focus to avoid a focus trap.
- After two layout frames, the highest-sequence unlocked entry is brought into view without grabbing focus, emitting a selection, recording progress, or unlocking any tail entry.
- Initial progress has only Tutorial 0 unlocked and remains at scroll value zero.
- Title and Back remain outside the scroll region and visible at top and maximum scroll.

## Validation

Focused runner:

```text
exit 0
90 assertions
0 failures
TASK_0017P_LEVEL_SELECT_SCROLLABILITY_TESTS_PASS
```

The current seven-entry product catalog and synthetic eight-/twelve-entry sequences all pass reachability, top/bottom scroll, signal, disabled-state, auto-visibility, focus, Back, no-horizontal-overflow, AppRoot, Safe Error, and window-transform checks. Keyboard focus reaches synthetic entry 12 at scroll `460/460`, then advances to fixed Back.

Final aggregate:

```text
exit 0
481 assertions / 9 vectors
```

All eleven markers appear exactly once: Tasks 0003, 0006, 0007, 0008, 0009AR, 0011, 0011R, 0012, 0015, 0015R, and `TASK_0017P_LEVEL_SELECT_SCROLLABILITY_TESTS_PASS`. stderr contains only the accepted intentional `LEVEL_ID_MISMATCH`.

## Catalog and formal preservation

The tracked catalog remains byte-unchanged with seven entries. No `data/`, schema, Simulation, solver, Gameplay, Timeline, Help, project setting, scene, asset, persistence, or bridge/finale content changed.

| Level | SHA-256 |
|---|---|
| `tutorial_reach_exit` | `38e466bb5922f1987a99d79c7527a4a8eab8e6cfdbe76fd8159f80b0a40cf2c4` |
| `tutorial_echo_bridge` | `681d99057c4e6034a490644d75960ff23d8f43bd1b91850f48179b79fc04a3cf` |
| `vertical_slice_delay_3` | `8751da5051fbebaaa5ae7c895d9be9f086e8d8f2e87876a80c379dc06262f1d8` |
| `door_one_turn_late` | `1775cf89ae4a94f65a76dac2b791a31395443de88205d0ed1b6233331dbda577` |
| `two_keys_one_door` | `f4c6791dfc84d17fb450721e654091a2baeb522e55d660a5d73878cd977651cd` |
| `staggered_doors` | `3f14c19b50775e36dd5b52664798381cf1292b0a30b377641c03435f45696bc8` |
| `two_echo_convergence` | `772410d3b8bb807e35472ee2a7d07b703de66e1e0e92ffb4d1ff8433a345d5fd` |

Aggregate solver metrics for all seven levels remain unchanged.

## Captures and evidence

Native Godot Compatibility renderer produced nine captures: product seven-entry list; synthetic eight-entry top/final; highest unlocked entry; synthetic twelve-entry top/bottom; final-entry keyboard focus; grayscale; and resized 1280×800 presentation. Visual inspection confirms fixed Title/Back, legible labels, no overlap, no scrollbar-over-text defect, reachable tail entries, and preserved grayscale focus distinction.

External evidence:

```text
D:\Delayed_Self_Evidence\0017P_level_select_scrollability\
```

`EVIDENCE_INDEX.md` records commands, sizes, timestamps, and SHA-256 values. External evidence is not staged.

## Cleanup, changed paths, and rollback

All Godot processes were closed. Godot produced no unintended `project.godot` change, `.gd.uid`, cache, import, or repository-local evidence file, so no generated-file cleanup was required.

Implementation paths:

```text
scripts/app/level_select.gd
tests/app/task_0017p_level_select_scrollability.gd
tests/app/capture_task_0017p.gd
tests/run_all.gd
```

Documentation is limited to this report and authorized CURRENT files. Rollback is the single Task 0017P commit. No rebase, amend, reset, force-push, broad restore, broad staging, or `git clean` is used.

## Non-claims

This repair does not implement or accept `echo_spacing_bridge`, migrate the catalog, resume Task 0017, implement `signal_convergence`, modify gameplay, or claim release readiness. It repairs only the prerequisite Level Select scalability blocker and requests GPT review.

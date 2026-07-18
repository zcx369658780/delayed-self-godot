# Task 0017P GPT final acceptance

- Reviewed commit: `85f804cf33e9d482283db13344b449344efc74f4`
- Parent blocker: `TASK_0017_BLOCKER_ACCEPTED_LEVEL_SELECT_SCROLLABILITY_PREREQUISITE_REQUIRED`
- Verdict: `TASK_0017P_LEVEL_SELECT_SCROLLABILITY_REPAIR_ACCEPTED`
- Accepted status: `APP_SHELL_PREREQUISITE_ACCEPTED`

## Accepted scope

The reviewed commit is one topic commit after Task 0017P publication and changes only the bounded Level Select implementation, focused tests/capture harness, aggregate registration, the repair report, and authorized current documents. It does not change scenes, project settings, catalog data, formal levels, Simulation, solver, Gameplay, Timeline, Help, persistence, bridge content, or finale content.

The repaired control tree is:

```text
fixed Title
bounded vertical ScrollContainer
  generated level-button list
fixed Back
```

The implementation is catalog-count independent. Horizontal scrolling is disabled. Existing button text, lock suffixes, disabled state, selection signal, minimum height, and Back behavior are preserved.

## Interaction acceptance

The following behaviors are accepted:

- seven-, eight-, and synthetic twelve-entry lists are reachable;
- mouse wheel/scrollbar and keyboard/controller focus can reach tail entries;
- disabled entries remain unselectable and are skipped by generated focus navigation;
- scrollbars do not become keyboard focus traps;
- fixed Title and Back remain visible at top and maximum scroll;
- the highest unlocked entry is revealed after layout without taking focus, selecting a level, recording completion, or mutating unlock state;
- initial progress remains at the top with only the initial tutorial unlocked;
- no horizontal overflow is introduced.

## Validation acceptance

Focused validation is accepted at 90 assertions with marker:

```text
TASK_0017P_LEVEL_SELECT_SCROLLABILITY_TESTS_PASS
```

The fresh aggregate is accepted at 481 assertions / 9 vectors with eleven markers exactly once. Native exit is 0 and stderr contains only the intentional `LEVEL_ID_MISMATCH` negative-path diagnostic.

Nine native 960×540 / resized captures cover product seven-entry state, synthetic eight- and twelve-entry top/bottom states, highest-unlocked reveal, tail focus, grayscale, and 1280×800 window presentation. The evidence establishes tail reachability, fixed Title/Back, readable labels, and no scrollbar/text obstruction.

## Preservation

The tracked catalog remains seven entries. All seven formal level hashes and accepted solver metrics remain unchanged. No generated-file cleanup was required.

## Boundary

This acceptance repairs only the App Shell scalability prerequisite. It does not accept or implement `echo_spacing_bridge`, migrate the catalog to eight entries, resume Task 0017 automatically, implement `signal_convergence`, close owner-review gates, or establish release readiness.

A fresh continuation task may now authorize reconstruction, formal validation, catalog integration, and native presentation validation of the previously blocked `echo_spacing_bridge` candidate. The Level Select implementation itself is frozen during that continuation unless a new independently reviewed defect is found.

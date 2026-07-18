# Handoff master (CURRENT)

Task 0017RC is complete at `BRIDGE_CONTEXTUAL_HELP_REPAIR_READY_FOR_GPT_REVIEW`. The accepted bridge remains byte-identical; the only product change is reusable Gameplay Help selected by a stable data-derived predicate.

Final contextual section:

```text
SPACING · Closed DOOR/wall BLOCKS one ECHO while another MOVES, changing spacing.
EXPERIMENT · Compare MOVED/BLOCKED; try another route or loop.
A+B · Two ECHOS hold separate Plates; YOU stays free to cross. Only YOU completes.
```

Trigger requires `echo_spacing_change`, at least two ECHOs, exactly two distinct Plates, and a Door depending on both. It is false for `two_echo_convergence`, zero/single-ECHO rooms, missing metadata, wrong Plate count, duplicate Plate cells, and non-A+B Doors. It does not inspect level ID, turn, positions, history, progress, witness, or solver state.

Validation is focused 28/28, aggregate 578 assertions / 9 vectors / 13 markers, and nine passing 960×540 Compatibility captures. The bridge body is 283/320 px at a contextual-only 16 px; non-target Help stays 18 px. All formal/catalog hashes and metrics remain exact, stderr is only `LEVEL_ID_MISMATCH`, and no generated cleanup was required.

Read Task 0017RC, its implementation report/evidence index, current startup/active-task documents, and live Git truth. Next authority is GPT review and then one separately authorized owner-only repair retest. Do not claim curriculum closure or begin finale, production, export, release, or submission work.

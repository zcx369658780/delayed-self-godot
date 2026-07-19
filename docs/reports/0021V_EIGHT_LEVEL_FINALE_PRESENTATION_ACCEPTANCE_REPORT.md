# Task 0021V eight-level finale-presentation machine and capture acceptance

- Task: `tasks/0021V_finale_presentation_machine_and_capture_acceptance.md`
- Result: `EIGHT_LEVEL_FINALE_PRESENTATION_ACCEPTED_FOR_OWNER_REVIEW`
- Baseline / HEAD: `ad5d71275e9b218b9bf5dec08f27b460d37398d9` / `79d9e5b196cc65b060f53179f27b8f4a51fd9b35`
- Toolchain: Godot `4.7.stable.steam.5b4e0cb0f`, NVIDIA OpenGL Compatibility
- Evidence: `D:\Delayed_Self_Evidence\0021V_finale_presentation_acceptance\`

## Machine and frozen-source audit

Focused regression passed with `42` assertions, exit `0`, and empty stderr.
Aggregate passed with `621` assertions / `9` vectors, exit `0`; all fourteen
stable markers occurred exactly once and its only stderr was the intentional
`LEVEL_ID_MISMATCH` fixture diagnostic. The accepted commit is an ancestor of
HEAD and no `scripts/`, `scenes/`, `tests/`, `data/`, `schemas/`, or
`project.godot` path differs from the accepted implementation commit.

Catalog SHA-256 is `a2bfa892f77370ac4d7e93ba5b6ce5970f0d7ba75160e1b2d00c4384f3da4e51`.
The eight formal hashes remain exactly: tutorial reach exit
`38e466bb5922f1987a99d79c7527a4a8eab8e6cfdbe76fd8159f80b0a40cf2c4`, tutorial
echo bridge `681d99057c4e6034a490644d75960ff23d8f43bd1b91850f48179b79fc04a3cf`,
vertical slice `8751da5051fbebaaa5ae7c895d9be9f086e8d8f2e87876a80c379dc06262f1d8`,
door one turn late `1775cf89ae4a94f65a76dac2b791a31395443de88205d0ed1b6233331dbda577`,
two keys `f4c6791dfc84d17fb450721e654091a2baeb522e55d660a5d73878cd977651cd`,
staggered doors `3f14c19b50775e36dd5b52664798381cf1292b0a30b377641c03435f45696bc8`,
bridge `805cdc05ea9b3805189ba7be4938cb7ede4e7056b9ae9a7e911df96a801d58ee`, and
final `772410d3b8bb807e35472ee2a7d07b703de66e1e0e92ffb4d1ff8433a345d5fd`.
All accepted metrics remain 3/3/6/2, 9/12/1975/509, 9/31/1318/393,
9/7/291/116, 12/1/1260/225, 15/4/6772/1179, 16/12/19059/3734, and
19/6/61975/21449. Sequence 8 is the sole `final_level=true` entry.

AppRoot supplies only catalog-derived `entry.final_level`; AppRoot and Gameplay
use `payload.get("final_level", false)` / `route_payload.get("final_level", false)`.
Neither source contains `two_echo_convergence`. `FINAL_ACKNOWLEDGEMENT_VISIBLE`
is presentation-derived and absent from Simulation/canonical state.

## Native route and state evidence

The external native harness drove fresh AppRoot-hosted instances. The non-final
control recorded Tutorial 0 once and automatically reached Level Select with
one active screen and no final copy. The unlocked final recorded `two_echo_convergence`
once at 19 turns, retained the same Gameplay instance, showed the exact
acknowledgment, hid Help/Timeline, and preserved the completed canonical key
across ignored movement and Help input. Enter, Space, and Esc each returned
once in separate fresh instances. R restored the initial state, cleared the
acknowledgment, permitted re-completion, and did not produce a second record.
The generic `--level-id=two_echo_convergence` route used the same catalog fact;
it displayed the acknowledgment while its locked progress record remained empty.

## Captures and manual audit

Thirteen game-window content frames were recorded with SHA-256 in
`capture_0021v_records.txt`: non-final pre/completed control; final pre-state;
final acknowledgment at 960x540, reduced-motion, grayscale, 1280x720
proportional content, and non-proportional content; Enter/Esc/Space Level
Select returns; R replay; and direct-development final acknowledgment. Manual
inspection found the final copy, return/replay hint, grayscale meaning, and
reduced-motion meaning readable; no clipping, horizontal overflow, Help,
Timeline, or route/witness text leaked.

The non-proportional native window was independently observed at `1280x800`:
logical `960x540`, scale `1.33333333333333`, content rect `(0,40,1280,720)`,
and symmetric 40 px top/bottom bars. The saved content texture for that check
is honestly recorded as `1280x720` rather than claimed as a 1280x800 image.

## Cleanup and non-claims

No product files changed; only this task's authorized Markdown navigation and
report files are updated. No generated cleanup condition occurred, the final
worktree check is clean after documentation commit, and no Godot process remains.
This is machine/capture acceptance only: it is not owner acceptance, final-copy
or localization acceptance, production/complete-flow readiness, build/export,
release, upload, or submission acceptance.

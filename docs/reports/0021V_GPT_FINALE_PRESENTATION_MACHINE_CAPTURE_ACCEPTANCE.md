# Task 0021V GPT finale-presentation machine/capture acceptance

- Reviewed commit: `cfd254daae0fb4857bce2f2770e939aedd17a6ae`
- Reviewed task: `tasks/0021V_finale_presentation_machine_and_capture_acceptance.md`
- Verdict: `TASK_0021V_EIGHT_LEVEL_FINALE_PRESENTATION_ACCEPTED_FOR_OWNER_REVIEW`
- Formal scope: exactly eight levels
- Formal finale: sequence 8 `two_echo_convergence`
- Product change in Task 0021V: none

## Accepted evidence

Task 0021V independently reproduced the Task 0021 focused suite at 42 assertions with empty stderr and the aggregate suite at 621 assertions / 9 vectors with all fourteen markers exactly once. Aggregate stderr contained only the intentional `LEVEL_ID_MISMATCH` fixture diagnostic.

The accepted Task 0021 implementation is an ancestor of the reviewed commit, and no product, test, formal-data, schema, scene, or `project.godot` path drifted from that implementation. The eight formal level hashes, accepted solver metrics, eight-entry catalog hash, and sequence-8 sole-final fact remain exact.

The finale trigger remains derived only from the validated catalog route fact `final_level`. Neither AppRoot nor Gameplay hard-codes `two_echo_convergence`, and `FINAL_ACKNOWLEDGEMENT_VISIBLE` remains a presentation-derived state outside Simulation and the canonical key.

## Native route acceptance

Fresh AppRoot-hosted native runs established:

- non-final completion records once and automatically returns to Level Select;
- final completion records once, retains the same Gameplay instance, and shows the exact acknowledgment;
- Help, Timeline, movement, and Wait do not alter the completed state while acknowledgment is visible;
- Enter, Space, and Esc each produce one bounded routed return in separate fresh instances;
- R restores the exact initial state, permits replay, and the same Gameplay session does not record completion twice;
- development-direct final routing uses the same catalog-derived final fact and does not bypass locked-progress behavior.

## Capture and viewport acceptance

Thirteen game-content frames cover the final and non-final routes, acknowledgment, return inputs, replay, direct route, grayscale, reduced motion, and resized presentation. Manual inspection found no clipping, horizontal overflow, Help/Timeline leakage, or route disclosure.

Eleven saved frames are 960x540 and two are 1280x720. The separate native 1280x800 non-proportional-window observation correctly records logical 960x540 content transformed into `(0,40,1280,720)` with symmetric 40-pixel top and bottom bars. The saved content texture is correctly described as 1280x720 rather than misrepresented as the full window.

## Decision

The machine, route, and capture gate is accepted. The finale presentation may proceed to one authenticated-owner walkthrough under the project's owner-only constraint.

The owner review must be classified as:

```text
AUTHENTICATED_OWNER_NOT_FRESH_NOT_INDEPENDENT_EIGHT_LEVEL_FINALE_WALKTHROUGH
PRIOR_LEVEL_MECHANIC_ROUTE_AND_DEVELOPMENT_EXPOSURE_PRESENT
```

Completion time, turns, restarts, or remembered routes cannot establish fresh discovery, unbiased difficulty, balance, or population evidence. The useful evidence is bounded to full-flow coherence, intentional-final judgment, acknowledgment comprehension/tone, return/replay clarity, presentation observations, and P0-P3 findings.

## Boundaries

This acceptance is not owner acceptance, final-copy/localization acceptance, complete-flow or production readiness, persistent-save/settings/menu readiness, build/export readiness, release-candidate acceptance, public release, upload, or festival submission.

No product repair, production work, save/settings work, asset/audio acquisition, build/export, release, or submission follows automatically.

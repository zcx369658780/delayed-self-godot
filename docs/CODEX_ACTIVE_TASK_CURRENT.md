# Codex active task (CURRENT)

- Status: `IMPLEMENTED_PENDING_GPT_REVIEW`
- Task: `tasks/0011R_physical_window_fill_scaling_and_centering_repair.md`
- Gate: `IMPLEMENTATION / FOCUSED PRESENTATION REPAIR`
- Starting HEAD and `origin/main`: `9bac777f27c0d42be9b801ff8ce97c611900ab52`
- Commit policy: one implementation/documentation commit, message `fix: scale and center Delayed Self window content`
- Push policy: one normal push after fetch and remote-drift check

## Scope

Repair the physical-window/logical-canvas mismatch while retaining the exact 960×540 logical presentation, all accepted gameplay authorities, and the existing board/HUD composition.

## Completion state

The root cause was four invalid double-prefixed display/window keys. Correct Godot 4.7 keys now enable built-in uniform `canvas_items` keep-aspect scaling; exact 16:9 clients fill, wide/tall clients center with symmetric black bars, and all routes use the same AppRoot host policy. Resize preserves state, history, canonical key, Help, route, and input order. Final regression is `314 assertions/9 vectors` with all seven markers and unchanged formal hashes, metrics, controls, routes, unlock results, and simulation semantics.

## Remaining uncertainties

GPT adjudication and the required short authenticated-owner window-fill retest remain pending. This is implementation evidence, not closure of the owner P2 or owner approval. Licensed assets/fonts, Level 6, fresh/independent review, final art/accessibility, audio, narrative, Gate, settings/save, complete flow, localization, export, release, and submission remain separately gated.

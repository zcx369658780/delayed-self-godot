# Evidence and independent review rules (CURRENT)

## Evidence

Prefer concise tracked text: execution/test summaries, puzzle validation, action matrices, license ledgers, review reports, build hashes, environment facts, and external-evidence indexes. Screenshots, recordings, long logs, performance captures, exports, and temporary files stay under the separately frozen external evidence root unless a task explicitly authorizes selected artifacts.

Never claim implemented, playable, solvable, unique, regression-free, performant, save-compatible, license-cleared, release-ready, or uploaded without the matching evidence. Record what was not run and all material uncertainty.

## Independent review

Blind review first evaluates launch, menus, tutorial comprehension, delayed-echo understanding, failure/restart feedback, difficulty, UI/audio, settings, selection, completion flow, blockers, and serious bugs. Reveal review then checks design intent, non-goals, known issues, protected surfaces, and validation records.

Findings use P0–P3 severity and evidence. Review verdicts are `PASS`, `PASS_WITH_OBSERVATIONS`, `CONDITIONAL_PASS`, or `FAIL`; unusable output is `NO_USABLE_REVIEW_VERDICT`. Codex self-review/subagents do not satisfy the independent-player gate.

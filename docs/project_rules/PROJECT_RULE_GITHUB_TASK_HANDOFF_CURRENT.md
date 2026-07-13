# GitHub task and handoff rules (CURRENT)

## Task contract

Tasks live at `tasks/<NNNN>_<topic>.md` and must define objective, scope, non-goals, allowed files, protected surfaces, reads, constraints, validation/evidence, commit/push policy, verdicts, stop conditions, and next gate. A task may tighten durable rules but cannot weaken `AGENTS.md`.

Before writes, record root, branch, HEAD, remotes, status, and recent history; read the full task and its required sources; then summarize scope and authorization. Stop on identity mismatch, dirty tracked files, divergence, conflicts, missing sources, or protected-surface requirements.

Tasks do not implicitly authorize accounts, secrets, repository administration, deletion, publication, uploads, releases/tags, paid services, save modification, upgrades, or force operations. Commit and push require explicit task authorization and a remote-drift check.

## Handoff contract

A handoff identifies the canonical entry point, task path/status, root, branch/HEAD/remote truth, completed evidence, remaining uncertainties, untouched protected surfaces, and next safe gate. It never converts recommendations into authorization or claims final acceptance.

# GPT–Codex–GitHub workflow rules (CURRENT)

## Roles

- GPT Project Sources advisor defines baselines, tasks, gates, risks, and final acceptance.
- Codex reads canonical sources, performs authorized local work and validation, makes single-topic commits/pushes only when authorized, and reports uncertainty honestly.
- The user owns product/aesthetic choices, credentials, platform accounts, public submission, and high-risk or irreversible actions.
- An independent reviewer evaluates the candidate from a player perspective; a Codex reviewer/subagent is development self-review, not independent acceptance.

## Loop

```text
GPT task in main → Codex safe sync → scoped implementation and evidence
→ authorized commit/push → GPT diff/evidence review
→ ACCEPT / REQUEST_CHANGES / BLOCKED → next task
```

Codex verdicts are `PASS_FOR_GPT_REVIEW`, `PASS_WITH_OBSERVATIONS_FOR_GPT_REVIEW`, `BLOCKED`, or `FAIL`. Never use `FINAL_ACCEPTED`.

## Git discipline

Use explicit path staging and one topic per commit. Never use broad staging, destructive reset/restore, history rewriting, force-push, or deletion of user work. Fetch before push and stop if the remote moved. Preserve current documents as live truth and reports as historical evidence.

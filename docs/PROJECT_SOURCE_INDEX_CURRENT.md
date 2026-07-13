# Project source index (CURRENT)

## Authority model

| Source | Purpose | Update rule |
|---|---|---|
| [`AGENTS.md`](../AGENTS.md) | Concise durable hard rules and startup order | Change only through an explicit governance task |
| [`Canonical GDD`](game_design/DELAYED_SELF_GAME_DESIGN_DOCUMENT_CURRENT.md) | Current product/design baseline | Preserve; substantive design changes require GPT advisor decision |
| [`Rule source seed`](project_rules/PROJECT_RULE_SOURCE_SEED_CURRENT.md) | Auditable bootstrap source | Preserve as source history; do not treat as a live-progress pointer |
| [`Split project rules`](project_rules/) | Operational detail organized by concern | Must not weaken the seed or `AGENTS.md` |
| [Current docs](DOC_INDEX_CURRENT.md) | Live gate, task, plan, handoff, and durable decisions | Update in their owning task; current outranks historical reports |
| [`tasks/`](../tasks/) | Per-gate scope, evidence, and Git authorization | May narrow, never weaken, durable rules |
| [`reports/`](reports/) | Historical execution evidence | Append by task; never override current truth |

## Resolution rules

Repository facts and the live task outrank conversational memory. `AGENTS.md` freezes cross-task safety. The task file controls the present allowed surface. The GDD controls design unless an authorized decision updates it. When sources conflict materially, stop and request GPT Project Sources advisor resolution rather than silently choosing.

Task 0000 did not rewrite either seed. It materialized concise execution rules, current pointers, indexes, and compliance placeholders from them.

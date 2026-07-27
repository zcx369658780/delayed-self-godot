# Multi-subagent and submission execution rule (CURRENT)

- Effective date: 2026-07-27
- Authority: Task 0024BAA
- `multi_subagent_mode = MANDATORY`
- `single_agent_execution = NOT_AUTHORIZED_BY_DEFAULT`
- `DeepSeek_tracked_code = DISABLED`
- `main_agent_final_scope_and_Git = EXCLUSIVE`

## Required routing

Nontrivial documentation/planning work uses `planner_high`, `docs_reader`, and `docs_writer_or_code_reviewer`. Code or level work uses `planner_high`, `code_mapper`, `impl_worker`, and an independent `code_reviewer`. Validation or protected-boundary work uses at least four distinct planning, mapping, evidence, and independent-review roles plus the main agent. The main agent is never counted as a subagent.

A future GPT-published task may permit one agent only by stating both:

```text
single_agent_exception = EXPLICITLY_AUTHORIZED
exception_reason = <specific bounded reason>
```

Otherwise single-agent fallback is forbidden.

## Exclusive main-agent duties

Only the main agent may interpret final scope, authorize protected-surface access, integrate writer output, launch Godot or a solver, consume a retained manifest, stage, commit, push, or issue `PASS_FOR_GPT_REVIEW`. A task must still explicitly authorize each protected action.

Subagents must not commit or push, consume manifests, alter repository settings, use accounts or secrets, access Profile/player data, publish/upload, or expand scope. DeepSeek is never a substitute for a GPT role and is disabled for tracked project code.

## Concurrency and evidence

Disjoint read-only work may run concurrently. Writers are serialized by explicit path ownership; no path has concurrent writers. Implementation and review remain independent. At most one process may launch Godot. Every subagent returns a compact path/evidence summary, and the main agent verifies it.

Every nontrivial task report records a routing ledger with `role`, `assigned_scope`, `configured_model_class_or_route`, `inputs`, `files_inspected_or_proposed`, `output_summary`, `main_agent_disposition`, and four `NO` attestations for Git writes, Godot/solver runs, Profile access, and protected-surface access.

## Submission doctrine

Validation quality is never weakened to save time or tokens. Candidate machine evidence does not imply owner acceptance, catalog admission, Profile/finale migration, release readiness, or upload authority. September 4–5, 2026 is the final submission buffer; the first build and first upload must occur earlier. The September 6 23:59 submission deadline and September 10 video deadline are distinct.

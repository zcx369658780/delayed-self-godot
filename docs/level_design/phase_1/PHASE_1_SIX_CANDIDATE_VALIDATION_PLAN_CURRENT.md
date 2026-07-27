# Phase 1 six-candidate validation plan (CURRENT)

- 2026-07-27 status: GPT accepted machine evidence for C02/S01/C03/S03/C07. Their consumed manifests are immutable and must not be rerun or reconstructed. Owner review and admission remain open. S04 is frozen/not authored and deferred post-submission; 0024BC/0024BD planning is superseded by the submission critical path.
No manifest, execution, or evidence identity is created here. Each future task has an independent qualification and retained-evidence lifecycle; no shared one-shot manifest. Timeout is `UNVERIFIED`, never a pass. A blocked candidate may be cut without automatically blocking the other family; 0024BC requires every candidate task to be independently adjudicated.

| Future task | Slot | Expected authored paths | Summary/report | Qualification and final categories | Retained evidence / terminal verdicts |
|---|---|---|---|---|---|
| 0024AW | C02 | authored uncatalogued level, focused test | validation JSON and report complete | `L*=14`, exact `N*=1`; all shortest `1/1`; required controls PASS | retained manifest `92ba1407-b34c-4de8-aa81-c4da4978bdaa` consumed PASS; `PASS_FOR_GPT_REVIEW`; no rerun |
| 0024AX | S01 | authored uncatalogued level, focused test | validation JSON and report complete | `L*=12`, exact `N*=8`; all shortest `8/8`; required controls PASS | retained manifest `e01bba09-6304-4344-b16a-4bfb9d364655` consumed PASS; `PASS_FOR_GPT_REVIEW`; no rerun |
| 0024AY / 0024AYR | C03 | fresh retry candidate and focused test retained | retry validation JSON; report | `L*=14`, exact `N*=2`; revised all-shortest `2/2`; blocked-Door diagnostic PASS | manifest `a5850880-314a-49e7-a67c-860313c14158` consumed PASS; `PASS_FOR_GPT_REVIEW`; no rerun |
| 0024AZ | S03 | authored uncatalogued level, focused test | validation JSON and report complete | `L*=13`, exact `N*=11`; all shortest `11/11`; required controls PASS | manifest `e41c771e-0df0-4ac5-a7d6-545b2175cc3b` consumed PASS; `PASS_FOR_GPT_REVIEW`; no rerun |
| 0024BA | C07 | authored uncatalogued level, focused test | validation JSON and report complete | `L*=14`, exact `N*=1`; all shortest `1/1`; ordered controls PASS | manifest `43be397c-ca57-487b-938f-8a04f18effd7` consumed PASS; `PASS_FOR_GPT_REVIEW`; no rerun |
| 0024BB | S04 | same bounded pattern | task-owned validation JSON; report | parser/schema, cross-route dependency, symmetric paths, removed route, swapped roles, dependency removed, restart | same independent policy and verdicts |

Every final capture must retain qualification results, exact source identity, solver limits/result, symbolic-witness-to-trace comparison, negative controls, replay/canonical/restart results, stderr/process ownership policy when authorized, and a no-rerun boundary. Expected paths are placeholders only; no level, test, summary, or report path is authored now.

## Frozen comparison rubric for 0024BC/BD

solver tractability; shortest-solution quality; intended-mechanic necessity; shortcut resistance; reasoning distinctiveness; failure readability; presentation clarity; owner enjoyment; implementation cost; test/evidence cost; duplicate-mechanic risk; festival schedule fit. No family verdict (`CONTINUE`, `CONTINUE_WITH_CUTS`, `REDESIGN`, `STOP_TRACK`) is assigned now.

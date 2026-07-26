# Phase 1 six-candidate briefs (CURRENT)

`phase_1_status = C02_S01_C03_ACCEPTED_S03_MACHINE_VALIDATED_GPT_REVIEW_PENDING`. C02, S01 and C03 are GPT-accepted machine evidence. S03 Task 0024AZ is machine validated at `L*=13`, exact `N*=11`, all-shortest `11/11`; GPT review is pending. All candidates remain unsequenced and uncatalogued.

| Order | Slot | Support | Budget class | Future task |
|---:|---|---|---|---|
| 1 | C02 | `GPT_ACCEPTED_MACHINE_VALIDATION` | Intro | 0024AW accepted |
| 2 | S01 | `GPT_ACCEPTED_MACHINE_VALIDATION` | Intro | 0024AX accepted |
| 3 | C03 | `GPT_ACCEPTED_MACHINE_VALIDATION` | Intermediate | 0024AYR accepted |
| 4 | S03 | `MACHINE_VALIDATED_FOR_GPT_REVIEW` | Intermediate | 0024AZ complete; GPT pending |
| 5 | C07 | `SUPPORTED_AS_IS` | Synthesis proof | 0024BA |
| 6 | S04 | `SUPPORTED_AS_IS` | Intermediate | 0024BB |

## Read-only support audit

| Slot | Current mechanics/schema | Simulation and solver paths | Missing contract | Bounded future change surface | Risk/action |
|---|---|---|---|---|---|
| C02 | v2 crates; sensor `include_crates`; barrier groups | `_transition_v2`, `pressed_sensor_ids`, BFS canonical crate state | none | authored level + candidate test only | `L*=14`, exact `N*=1`, all-shortest `1/1`; GPT accepted |
| C03 | v2 crate, actor plate/door, delayed echo | v2 next-state door update; shared BFS/replay | none under reconciled temporal-separation contract | authored level + candidate test | 0024AYR `L*=14`, exact `N*=2`, revised all-shortest `2/2`; GPT accepted |
| C07 | v2 crate push, ECHO, plate/door | v2 blocked crate/ECHO movement and shared BFS | none | authored level + candidate test only | `SUPPORTED_AS_IS`; author only under 0024BA |
| S01 | typed sensors and grouped barriers | `_activator_pressed`, `pressed_sensor_ids`, canonical state | none | authored level + candidate test only | `L*=12`, exact `N*=8`, all-shortest `8/8`; GPT accepted |
| S03 | `ECHO_ONLY` sensor, `include_crates=false`, barrier | same typed sensor/barrier paths | none | authored level + candidate test only | `L*=13`, exact `N*=11`, all-shortest `11/11`; GPT pending |
| S04 | typed sensors, grouped barriers, delayed echoes | deterministic v2 transition and shared BFS | none | authored level + candidate test only | `SUPPORTED_AS_IS`; author only under 0024BB |

All classifications are read-only contract findings. Freeform physics, ambiguous priority, nondeterminism, persistence, unbounded search, schema changes, and production surfaces remain blocked. Reserved comparison identities: `0024BC` integrated six-candidate machine/curriculum comparison; `0024BD` owner Phase-1 playthrough and portfolio checkpoint. No fallback is selected.

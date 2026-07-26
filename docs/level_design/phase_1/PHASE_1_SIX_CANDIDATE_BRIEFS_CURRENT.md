# Phase 1 six-candidate briefs (CURRENT)

`phase_1_status = C02_S01_ACCEPTED_C03_BLOCKED_REDESIGN_REQUIRED`. C02 and S01 are GPT-accepted machine evidence. C03 Task 0024AY stopped before PRE_FINAL at all-shortest full mask `2/14`, omissions `12`; no C03 candidate or manifest was retained. All candidates remain unsequenced and uncatalogued.

| Order | Slot | Support | Budget class | Future task |
|---:|---|---|---|---|
| 1 | C02 | `GPT_ACCEPTED_MACHINE_VALIDATION` | Intro | 0024AW accepted |
| 2 | S01 | `GPT_ACCEPTED_MACHINE_VALIDATION` | Intro | 0024AX accepted |
| 3 | C03 | `BLOCKED_REDESIGN_REQUIRED` | Intermediate | 0024AY blocked before PRE_FINAL |
| 4 | S03 | `SUPPORTED_AS_IS` | Intermediate | 0024AZ |
| 5 | C07 | `SUPPORTED_AS_IS` | Synthesis proof | 0024BA |
| 6 | S04 | `SUPPORTED_AS_IS` | Intermediate | 0024BB |

## Read-only support audit

| Slot | Current mechanics/schema | Simulation and solver paths | Missing contract | Bounded future change surface | Risk/action |
|---|---|---|---|---|---|
| C02 | v2 crates; sensor `include_crates`; barrier groups | `_transition_v2`, `pressed_sensor_ids`, BFS canonical crate state | none | authored level + candidate test only | `L*=14`, exact `N*=1`, all-shortest `1/1`; GPT accepted |
| C03 | v2 crate, actor plate/door, delayed echo | v2 next-state door update; shared BFS/replay | all-shortest mandatory-attempt topology unresolved | redesigned level + candidate test only under a new task | 0024AY best discarded `L*=15`, `N*=14`, full mask `2/14`; `BLOCKED` |
| C07 | v2 crate push, ECHO, plate/door | v2 blocked crate/ECHO movement and shared BFS | none | authored level + candidate test only | `SUPPORTED_AS_IS`; author only under 0024BA |
| S01 | typed sensors and grouped barriers | `_activator_pressed`, `pressed_sensor_ids`, canonical state | none | authored level + candidate test only | `L*=12`, exact `N*=8`, all-shortest `8/8`; GPT accepted |
| S03 | `ECHO_ONLY` sensor, `include_crates=false`, barrier | same typed sensor/barrier paths | none | authored level + candidate test only | `SUPPORTED_AS_IS`; author only under 0024AZ |
| S04 | typed sensors, grouped barriers, delayed echoes | deterministic v2 transition and shared BFS | none | authored level + candidate test only | `SUPPORTED_AS_IS`; author only under 0024BB |

All classifications are read-only contract findings. Freeform physics, ambiguous priority, nondeterminism, persistence, unbounded search, schema changes, and production surfaces remain blocked. Reserved comparison identities: `0024BC` integrated six-candidate machine/curriculum comparison; `0024BD` owner Phase-1 playthrough and portfolio checkpoint. No fallback is selected.

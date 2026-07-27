# Submission visual style-token specification (CURRENT)

## Semantic tokens

| Token | Proposed value/behavior | Non-color backup |
|---|---|---|
| paper_background | warm low-contrast paper field | subtle static fibre pattern |
| primary_ink | near-black structural ink | solid 2–3 px stroke |
| secondary_ink | muted annotation ink | dashed/thinner stroke |
| echo_ink | cool violet delayed mark | dashed/double outline plus delay badge |
| warning_mark | warm red/amber | triangle or X notch |
| success_mark | green/blue accent | check/diamond/radiating outline |
| disabled_mark | low-value gray | diagonal strike/hatch |
| grid_line | quiet cool-gray | consistent cell boundary |
| focus_outline | high-contrast cyan/white | double rectangular/rounded outline |

## Non-color signatures

| Signature | Frozen requirement |
|---|---|
| YOU_shape | solid circular/ink body, central core and `Y` |
| ECHO_shape_and_delay_badge | translucent body, dashed/double outline and `E2/E3/E4` |
| wall_hatch | dense diagonal notebook hatch |
| floor_mark | sparse paper/grid tick |
| plate_inactive | hollow ring/shape |
| plate_active | filled center plus outer emphasis |
| door_closed | three or more vertical bars |
| door_open | separated frame/hollow passage |
| exit_mark | diamond plus `EXIT` |
| locked_level | padlock/strike plus text |
| completed_level | check/stamp plus text |
| selected_level | double focus outline and pointer |
| error | X-in-box plus error text |
| restart | circular arrow plus `R` |
| timeline_current | solid pointer/boxed current slot |
| timeline_echo | dashed pointer plus delay badge |

No state may rely only on color or animation. All information remains legible at 1920×1080 and in the native 960×540 viewport. Keyboard focus is always visible. Decoration stays outside collision/grid semantics. Reduced-motion mode retains static trails, state labels and outcome marks.

# Eight-level finale closure and production-readiness plan (CURRENT)

- Task: `tasks/0020_eight_level_finale_closure_and_production_readiness_planning.md`
- Gate: `EIGHT-LEVEL SCOPE FREEZE / FINALE PRESENTATION + PRODUCTION READINESS PLANNING`
- Status: `EIGHT_LEVEL_FINALE_CLOSURE_PLAN_READY_FOR_GPT_REVIEW`
- Formal scope: exactly eight levels
- Formal finale: sequence 8 `two_echo_convergence`
- Selected ending direction: `B — FINAL_COMPLETION_OVERLAY_PLUS_BOUNDED_RETURN_STATE`
- Fallback: `A — FINAL_COMPLETION_COPY_ONLY`
- Product changes in Task 0020: none

## 1. Scope freeze

The product is frozen at exactly eight formal levels. The tracked catalog stays
byte-identical at SHA-256
`a2bfa892f77370ac4d7e93ba5b6ce5970f0d7ba75160e1b2d00c4384f3da4e51`.
Sequence 8 `two_echo_convergence` remains the sole `final_level=true` entry,
with formal SHA-256
`772410d3b8bb807e35472ee2a7d07b703de66e1e0e92ffb4d1ff8433a345d5fd`,
`L*=19`, `N*=6 EXACT`, 61,975 visited states, and frontier 21,449.

All eight formal JSON files, accepted hashes, metrics, Simulation, schema,
solver, catalog ordering, prerequisites, Help predicate, and Timeline policy
remain immutable in this plan.

Sequence 9 is explicitly retired from current product scope:

```text
signal_convergence = DEFERRED_CONCEPT_NOT_PRODUCT_SCOPE
B007 = HISTORICAL_EXTERNAL_DIAGNOSTIC_ONLY
candidate A/B/C continuation = CLOSED
```

No reduced sequence-9 grammar, new room, candidate search, proof expansion, or
automatic roadmap revival is permitted. The title `Signal Convergence / 信号汇流`
may remain historical concept language only.

## 2. Source-backed current-state findings

Static inspection used the current repository and accepted reports; no Godot
process, build, export, or new capture was run.

- [`app_root.gd`](../../scripts/app/app_root.gd) validates the catalog, passes
  catalog-derived `final_level` in the route payload, records completion in the
  memory-only progress adapter, and currently navigates immediately to Level
  Select after any successful hosted completion.
- [`vertical_slice.gd`](../../scripts/gameplay/vertical_slice.gd) retains the
  complete route payload and already has one completion overlay, but emits
  `gameplay_completed` before its final HUD refresh. The immediate AppRoot
  callback means the normal hosted flow replaces Gameplay before a bounded
  finale acknowledgment can be used.
- [`memory_progress.gd`](../../scripts/app/memory_progress.gd) performs no
  filesystem write. Progress, best turns, reset, settings, and ending-seen
  state are not persistent.
- [`main_menu.gd`](../../scripts/app/main_menu.gd) is still a development shell
  with only `Play` and `Quit`; it intentionally has no Continue, New Game,
  Reset, Settings, Credits, or exit confirmation.
- [`level_select.gd`](../../scripts/app/level_select.gd) has accepted bounded
  scrolling and generated keyboard focus for all eight entries.
- [`project.godot`](../../project.godot) freezes 960x540,
  `canvas_items`/`keep`, Compatibility rendering, keyboard movement, Space
  WAIT, and R restart. No controller mappings, audio buses, settings, version
  metadata, icon/splash, or export preset are tracked.
- The third-party ledger and attribution file are intentionally empty. No
  release-cleared external asset, font, audio, or music exists.
- There is no `export_presets.cfg`, release build, Windows package smoke test,
  Web build, clean-machine test, or reproducible package manifest.
- The latest accepted aggregate evidence is 578 assertions / 9 vectors with
  thirteen stable markers. That is a strong gameplay baseline, not a
  complete-flow, export, or release suite.

## 3. Ending-option comparison

| Direction | Finale intent | Architecture/change cost | Return clarity | Risk | Decision |
|---|---|---|---|---|---|
| A — completion copy only | Adds final-specific acknowledgment to the existing label | Smallest source change, but still needs the immediate-return path held long enough to be seen | Weak unless the normal auto-return changes | Can feel like ordinary completion with different prose | Fallback |
| B — overlay plus bounded return state | Shows a deterministic final acknowledgment and waits for an explicit return action | Bounded AppRoot/Gameplay presentation seam; no new scene or contract | Strong: visible acknowledgment, replay, and Level Select return | Must record progress exactly once and avoid trapping input | **Selected** |
| C — no ending change | Leaves generic completion and external festival copy as wrapper | No product change | Current flow remains abrupt | Sequence 8 looks merely last, not intentionally final | Rejected |

Direction B is the smallest option that repairs the observed normal-flow gap:
the current hosted completion immediately replaces Gameplay. It gives the final
catalog entry a deliberate ending beat without introducing a cutscene, credits
system, narrative state, save field, or new scene architecture.

## 4. Later ending implementation contract

### Stable trigger

The existing route-payload `final_level` fact is sufficient. AppRoot derives it
from the already validated catalog entry and Gameplay retains the full payload.
No catalog field, level metadata, hard-coded level ID, route witness, progress
count, or schema change is required.

Later implementation must treat the trigger as:

```text
validated route_payload.final_level == true
AND ordinary Simulation completion has occurred
```

### Required behavior

1. Preserve ordinary YOU-on-EXIT completion and the canonical state.
2. Record final-level completion and best turns exactly once through the
   existing progress interface.
3. For non-final levels, preserve the current automatic return to Level Select.
4. For the final level, do not immediately replace Gameplay. Enter one
   deterministic presentation state such as
   `FINAL_ACKNOWLEDGEMENT_VISIBLE`.
5. Show a short provisional acknowledgment consistent with “late, unable to
   change the past, but heard.” Exact production copy remains separately
   reviewable. Example only: `The signal arrived late. It was heard.`
6. Display an explicit keyboard action to acknowledge and return to Level
   Select; R may restart/replay. The return path must use the existing routed
   product flow.
7. The overlay must be readable at 960x540, grayscale, reduced motion, and
   mute; it must not require Timeline, animation, sound, localization, or route
   knowledge.
8. Repeated input, restart, Esc, and acknowledgment must not double-record,
   double-route, or strand the app.

### Preferred implementation surface

Use the existing reusable Gameplay completion label/state and AppRoot routing
seam. A later task may edit only the minimum necessary subset of
`scripts/gameplay/vertical_slice.gd`, `scripts/app/app_root.gd`, the existing
Gameplay scene if a focusable affordance is essential, focused tests/captures,
and current documentation.

Do not create a cutscene scene, ending subsystem, branching narrative,
hard-coded `two_echo_convergence` check, account/network feature, new asset
pipeline, persistence field, or catalog migration.

### Machine acceptance

- final/non-final routing branches are deterministic;
- completion/best-turn recording occurs once;
- restart and return are unambiguous;
- final overlay is absent for entries 1–7 and present only for the
  catalog-marked final entry;
- direct development route receives the same catalog-derived fact;
- canonical state, level hashes/metrics, Help, Timeline, and all accepted
  regression markers remain exact;
- captures cover pre-completion, ordinary completion result, acknowledgment
  state, explicit return, replay/restart, non-final control, 960x540,
  grayscale, reduced motion, and resized presentation.

## 5. Production-readiness matrix

Statuses mean release-oriented readiness, not merely existence of code.

| Area | Status | Evidence | Severity / dependency | Proposed gate |
|---|---|---|---|---|
| Title and Main Menu | `PARTIAL` | Main Menu has title, Play, Quit and still says Development Shell | P1 complete-flow gap | Gate 4 |
| New Game / Continue / Reset | `MISSING` | No UI or persistent profile; only test-only memory reset | P1; depends on save contract | Gate 4 |
| Eight-level catalog/progression | `READY` | Eight contiguous entries; sequence 8 sole final; accepted hash and progression tests | Preserve byte-identically | Gates 1–2 regression |
| Final completion return | `PARTIAL` | Completion records then immediately returns to Level Select | P1 finale-intent gap | Gates 1–2 |
| Level Select scroll/focus | `READY` | Eight/twelve-entry scroll and keyboard-focus evidence; fixed Title/Back | Preserve; broader accessibility still later | Gates 2 and 4 |
| Help | `PARTIAL` | Manual, zero-turn, contextual, non-route; owner acquired model but reported English clarity issues | P2; localization dependency | Gates 3–4 |
| Timeline | `READY` | Optional, contract-derived, not required for Levels 7–8 | Preserve optionality | Gates 2–3 |
| 960x540/window fill/resize | `READY` | Accepted standalone fill, symmetric bars, route/state preservation | Preserve exact baseline | Gates 2 and 5 |
| Grayscale/reduced-motion/overlap | `PARTIAL` | Repeated capture evidence exists; reduced motion is not a user setting | P2/settings dependency | Gates 2 and 4 |
| Keyboard gameplay controls | `PARTIAL` | WASD/arrows, Space, R, H, Esc work; no full pause/confirmation flow | P1 complete-flow gap | Gate 4 |
| Controller support | `DEFERRED` | No project input mapping or evidence | Explicit scope-cut before core flow | Post-RC only if retained |
| Persistent save compatibility | `MISSING` | Memory-only adapter, no filesystem path/format/version/migration/corruption recovery | P1 protected surface | Gate 4 |
| Reset safety | `MISSING` | No product reset/confirmation; only deterministic test helper | P1; follows save contract | Gate 4 |
| Settings | `MISSING` | No volume/fullscreen/reduced-motion/language UI or persistence | P1 GDD complete-flow requirement | Gate 4 |
| Safe Error | `READY` | Validated no-partial catalog and bounded diagnostic return path | Preserve and extend to save errors later | Gates 4–5 |
| Finale/ending presentation | `MISSING` | Generic completion only; hosted flow immediately leaves Gameplay | P1 intentional-finale gap | Gates 1–3 |
| Credits/attribution/licenses | `PARTIAL` | Empty authoritative ledger/attribution docs; no Credits page | P1 before RC; content depends on accepted assets | Gate 4 then Gate 6 audit |
| Visual assets/font | `MISSING` | Procedural primitives only; research shortlist not acquired or cleared | P2 quality; Chinese font dependency | Gate 4, optional slice first |
| Audio/music | `MISSING` | No imported audio, buses, event map, or mute evidence | P2 quality; must never own state | Gate 4 or explicit deferment |
| Localization | `MISSING` | No string table; development UI/Help is English; GDD targets Simplified Chinese | P1 product-language gap | Gate 4 |
| Icon/splash | `MISSING` | No tracked product icon or splash asset/settings | P1 packaging gap | Gates 4–5 |
| Screenshots/store/festival copy/media | `MISSING` | Diagnostic captures exist but no selected submission set or final copy/video | P1 submission gap | Gate 7 |
| Windows export/toolchain | `PARTIAL` | Matching Godot 4.7 templates available; no preset/build/package smoke | P1 release blocker | Gate 5 |
| Web export | `DEFERRED` | Templates/browser exist; no preset/build/browser/hosting evidence | Windows is sufficient primary path | After Windows RC if schedule permits |
| Build/version naming/reproducibility | `MISSING` | No version scheme, preset, manifest, deterministic package/hash procedure | P1 RC blocker | Gates 5–6 |
| Regression/evidence inventory | `PARTIAL` | 578 assertions / 9 vectors and external evidence indexes; no finale/save/export suite | Extend before RC | Gates 2, 4–6 |
| Owner-only product review | `PARTIAL` | Authenticated owner evidence exists with prior exposure; no final product walkthrough | Required disclosure, not fresh difficulty evidence | Gate 3 |
| Independent review | `NOT_APPLICABLE` | `FRESH_INDEPENDENT_REVIEW_UNAVAILABLE_BY_OWNER_CONSTRAINT` | Residual limitation, not a recruitment task | Disclose in Gates 3 and 6 |
| README/current public status | `PARTIAL` | README still describes repository bootstrap/no playable project | P2 public-facing accuracy | Gate 4 |

Critical path is ending flow, persistent save/settings/reset, complete product
navigation, credits/license surface, Simplified-Chinese-capable localization,
icon/splash, Windows export, versioned reproducibility, and final evidence.
Controller and Web remain explicit scope cuts. A visual reskin and audio improve
quality but must not delay the critical complete-flow/Windows path or enter
without license evidence.

## 6. Ordered milestone and gate spine

### Gate 1 — Finale presentation implementation

- Objective: implement selected direction B using the existing final-level
  payload, completion overlay, and routed return seam.
- Authorized paths: minimum AppRoot/Gameplay presentation source and existing
  scene if essential; focused app/gameplay tests; aggregate registration;
  report/current docs.
- Forbidden: formal levels, catalog, Simulation, solver, schema, persistence,
  assets/audio, settings, export, release.
- Acceptance: deterministic final/non-final branching, record-once progress,
  acknowledgment/return/restart, focused tests, unchanged hashes/metrics.
- Stop/rollback: stop on canonical-state change, hard-coded level identity,
  double recording, input trap, or new scene architecture; revert the single
  presentation topic.
- Non-claims: not machine/capture acceptance, owner acceptance, production
  readiness, or release readiness.

### Gate 2 — Machine and capture acceptance

- Objective: independently verify Gate 1 and the unchanged eight-level
  baseline.
- Authorized paths: read-only product inspection, focused/aggregate tests,
  external captures/index, validation/report/current Markdown. Any product fix
  requires a new bounded repair task.
- Evidence: aggregate regression, exact eight hashes/catalog hash, final and
  non-final routes, 960x540/grayscale/reduced-motion/resized captures, Help and
  Timeline isolation, no generated-file residue.
- Stop: P0/P1 machine failure, product drift, capture clipping, or incomplete
  return behavior.
- Non-claims: no human emotional/clarity acceptance or build acceptance.

### Gate 3 — Owner-only finale and eight-level walkthrough

- Objective: assess whether sequence 8 feels intentionally final and the full
  eight-level arc is coherent.
- Authorized paths: review/report/current Markdown plus external owner-supplied
  evidence only; implementation frozen.
- Classification:
  `OWNER_ONLY_REVIEW / FRESH_INDEPENDENT_REVIEW_UNAVAILABLE_BY_OWNER_CONSTRAINT`.
- Evidence: ending comprehension/tone, return clarity, arc coherence,
  Help/Timeline/presentation observations, P0–P3, exact exposure disclosure.
- Stop: P0/P1 or unusable evidence; findings become separate repair tasks.
- Non-claims: no fresh discovery, population difficulty, independent review,
  production, export, or release acceptance.

Task 0021W recorded this gate under the required authenticated-owner, non-fresh,
non-independent classification. The owner understood the ending but did not find
the eight-level arc or current message sufficiently intentional/final; P0=0,
P1=0, P2=0, P3=3. Its disposition is
`EIGHT_LEVEL_FINALE_OWNER_REVIEW_REPAIR_REQUIRED`; no repair is authorized by
that review.

### Gate 4 — Complete-flow and production closure

- Objective: close critical non-export gaps in bounded slices: persistent
  save/settings/reset/Continue; pause/quit confirmation; Credits/Attribution;
  localization/font; icon/splash; and an explicit accept-or-defer decision for
  licensed visual/audio polish.
- Authorized path domains: App/UI/settings/persistence modules and scenes,
  isolated test profiles, approved localization/assets/audio and license
  records, project settings only when the exact slice requires them,
  focused/aggregate tests, report/current docs. Each later task must narrow
  this domain; this plan grants no blanket write authority.
- Evidence: versioned save contract and migration/corruption/reset tests;
  new/continue flow from clean and existing profiles; settings persistence;
  pause/quit/credits; 960x540 text coverage; license ledger/attribution; muted
  equivalence; clean complete flow.
- Stop: real player-data risk, unbounded migration, unclear licenses, state
  cues requiring audio/color, localization clipping, or scope mixing that
  cannot roll back independently.
- Non-claims: no export, package, RC, or submission readiness.

### Gate 5 — Windows export and build validation

- Objective: create the first versioned Windows x86_64 preset/build and prove
  a reproducible clean-profile smoke path. Web remains deferred.
- Authorized paths: exact export preset/version metadata, repository-external
  build/evidence root, packaging manifest, build report/current docs.
- Forbidden: public upload, tag/release, account changes, submission, real
  player-data overwrite, or opportunistic tool/template upgrade.
- Evidence: exact Godot/template version, command, build hash/size, clean
  profile menu-to-ending smoke, save/settings restart, Safe Error, resize,
  license/attribution presence, malware/extra-file inventory.
- Stop: export warning/error, missing file/license, nondeterministic package,
  wrong profile access, P0/P1 smoke finding.
- Non-claims: no RC acceptance, Web readiness, public release, or submission.

### Gate 6 — Release-candidate acceptance

- Objective: freeze one exact Windows package and adjudicate all automated,
  owner, license, known-issue, and reproducibility evidence.
- Authorized paths: RC manifest, known-issues/license/audit reports, selected
  evidence/current docs; protected tag/release remains separately unauthorized.
- Evidence: clean Git/build provenance, package hash, repeated clean-profile
  smoke, full regression, owner boundary, license audit, P0/P1=0, bounded P2/P3
  disposition, rollback archive.
- Stop: evidence mismatch, unclosed P0/P1, missing attribution, package drift,
  or unreviewed asset/build input.
- Non-claims: no upload, public availability, festival acceptance, or Web
  support.

### Gate 7 — Festival submission packaging

- Objective: prepare the exact organizer-facing package, screenshots, concise
  store/festival copy, theme statement, instructions, and video plan from the
  accepted RC.
- Authorized paths: repository-external submission package and separately
  approved submission documents/media. Account login, upload, public release,
  and final submission require explicit owner authorization.
- Evidence: rule checklist, RC hash match, screenshot/media provenance,
  license/AI-disclosure audit, download/unpack instructions, final package
  inventory, owner approval.
- Stop: rule ambiguity, deadline/account blocker, RC mismatch, missing rights,
  or any request to upload without explicit authority.
- Non-claims: packaging is not submission; only confirmed platform/owner
  actions may establish upload or acceptance.

## 7. Owner walkthrough plan

The owner has prior mechanical, route, Help, and design exposure. Record this
before play and do not use completion time/restarts as fresh discovery or
difficulty evidence.

Ask, without route coaching:

1. Does sequence 8 now feel intentionally final rather than merely last?
2. Is the acknowledgment understandable and emotionally appropriate?
3. Is the explicit return/replay behavior clear?
4. Does the eight-level arc feel coherent from tutorial to convergence?
5. Which Help, Timeline, visual-density, language, or control problems remain?
6. Are there any P0–P3 findings?

No third-party reviewer may be sought, required, contacted, recruited, or
suggested.

## 8. Global stop, rollback, and non-claims

Stop and return to GPT if finale presentation requires a new scene system,
save field, catalog/schema change, hard-coded level ID, audio/animation-only
meaning, or formal-level modification. Stop production work on unclear rights,
unsafe player-data handling, or a task too broad to roll back independently.

Task 0020 rollback is removal of its documentation-only commit. Later gates
must each be a separately reversible topic.

This plan does not implement or accept the ending, persistent save/settings,
assets, audio, localization, icon/splash, build/export, release candidate,
festival package, upload, or submission. It does not claim fresh or independent
review, population difficulty, balance, fun, production readiness, export
readiness, or release readiness.

## 9. Recommended next gate

Authorize Gate 1 only: bounded final-level completion overlay plus deterministic
acknowledgment/return implementation, with no catalog, level, Simulation,
solver, persistence, asset, audio, export, or release changes.

```text
EIGHT_LEVEL_FINALE_CLOSURE_PLAN_READY_FOR_GPT_REVIEW
```

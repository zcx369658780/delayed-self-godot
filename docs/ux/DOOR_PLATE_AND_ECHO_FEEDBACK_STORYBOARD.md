# Door, Plate, and Echo feedback storyboard

- Status: `PLANNING_RECOMMENDATION_FOR_GPT`; no animation, audio, scene, or code is implemented.
- Frozen rule: a combinational Door uses the start-of-turn snapshot for entry, recomputes after simultaneous actor movement, and affects the next submitted turn.
- Primary target: make Level 4's accepted mechanic observable without changing it or disclosing a route.

## Feedback grammar

| Event | Motion | Shape/icon/text | Color | Audio | Non-audio fallback |
|---|---|---|---|---|---|
| Player move | short direct slide/snap | solid `Y` and brief origin tick | white/cyan | close, dry step | motion plus solid outline |
| ECHO replay | delayed-looking trail after logical commit | outlined `E`, replay arrow, delay tag when needed | purple | filtered/soft echo step | dotted trail and replay glyph |
| Plate press | 2–3 px depression and outward ring | filled center + `PRESSED` pip | amber bright | soft click/low pulse | ring, fill, and icon |
| Plate release | ring contracts and pad rises | center empties | amber dim | lighter release click | shape change |
| Dependency propagation | 120–180 ms line/pip travel from Plate toward Door | arrowed circuit line | amber→door state | quiet rising pulse | animated dash and directional arrow |
| Door commits open | frame retracts or central bar splits | hollow frame + open aperture + `OPEN · NEXT INPUT` badge during teaching | green/cyan | short two-note unlock | aperture/shape and text |
| Door commits closed | frame returns behind/around any occupant | solid center bars + `CLOSED` icon | red | short descending close | bars and text; never rely on red alone |
| Blocked at Door | Door bumps 2 px, actor remains | red-independent X/stop notch; `BLOCKED · ACTION RECORDED` in Help/teaching mode | high-contrast neutral/red | dry thud | shake, X, caption |
| Completion | calm expanding ring | YOU/EXIT names remain explicit | blue/white | resolved chime | overlay and shape |

Presentation consumes the before/result states and actor-action metadata already produced by the accepted transition. It never delays logical commitment, changes input history, or decides whether a Door is open.

## Timing recommendation

These timings are presentation targets only:

| Phase | Minimal | Enhanced |
|---|---:|---:|
| Input acknowledgement | 0–40 ms | 0–60 ms |
| Actor motion | 90–150 ms | 120–200 ms |
| Plate press/release | overlap final 60–100 ms of motion | 100–160 ms |
| Dependency pulse | 100–140 ms | 140–220 ms |
| Door state transition | 100–160 ms | 160–240 ms |
| Ready-for-next-input confirmation | by 260–320 ms total | by 420–520 ms total |

The minimal version should accept or buffer the next single input after the logical result commits, so rapid play is not forced to wait for decoration. Queued input must apply only after the current presentation reaches its declared safe handoff; no animation callback may calculate state. A “reduce motion” mode may replace travel with a 100 ms crossfade and persistent icon.

## State wording

- Closed start: `CLOSED` with solid bars.
- Open committed result: `OPEN · usable on next input` during the teaching encounter.
- Standard compact state after teaching: `OPEN` plus hollow frame.
- Close result with occupant: `CLOSED · occupant may leave`; show only when confusion is observed.
- Blocked cardinal: `BLOCKED · action recorded` in teaching/Help mode because the original action remains in history.

Avoid “opening next turn”: the Door is already open in the committed result state and is usable by the next submitted turn. The text must describe that boundary precisely.

## Exact Level 4 critical sequence

The accepted witness reaches the critical point after `RIGHT, RIGHT, UP, UP`; the storyboard does not expose those moves to the player.

### 1. Closed start snapshot

- YOU is outside the closed Door; ECHO is one cell before the Plate.
- Door displays solid bars and `CLOSED`; Plate is raised/dim.
- The dependency path is visible but dormant.
- Timeline highlights the ECHO action that will replay now, without telling the player what to submit.

### 2. Submitted action

- Input pip flashes at the history insertion edge.
- YOU begins a 2 px blocked lean toward the Door; ECHO receives the distinct replay trail.
- Logical transition has already been calculated from the closed snapshot.

### 3. ECHO moves onto Plate

- ECHO ends on the Plate with a purple replay ring.
- YOU returns to its original cell; the Door briefly shows a stop notch to explain the blocked start snapshot.
- If teaching text is enabled: `YOU was blocked by the state at turn start.`

### 4. Plate activates

- Plate depresses/fills; an amber ring expands once.
- A dependency pulse travels visibly from Plate to Door.
- Sound: filtered ECHO step followed by Plate click; either may be muted independently later.

### 5. Door visibly commits open for the next turn

- Door bars retract and leave a hollow aperture; color changes only as a secondary cue.
- A short badge appears adjacent to the Door: `OPEN · NEXT INPUT`.
- Right-rail state changes to an open-shape icon plus `OPEN`.
- The next-input ready tick occurs only after the open aperture is fully legible.

### 6. Next-turn player entry

- The next submitted action reads the already-open snapshot; YOU moves into the Door cell.
- No second “unlock” is played. A small pass-through tick confirms that entry used the open state.
- ECHO begins its own replay motion simultaneously in logic, even if the visual tracks are staggered by tens of milliseconds.

### 7. Door closes around or behind the occupant

- If ECHO leaves the Plate, the release ring contracts, the dependency line dims, and the Door bars return.
- When YOU occupies the Door cell, bars render behind the actor silhouette and never obscure `Y`.
- A compact caption may state `CLOSED · YOU may leave`; there is no damage, push, or forced movement.
- The next start snapshot is closed for entry but still permits the occupant to leave, matching the contract.

## Minimal implementation recommendation

Use existing primitives only:

1. Plate press/release ring and fill change.
2. One dependency line/pulse for each referenced Plate.
3. Door shape change: solid barred closed versus hollow split-frame open.
4. A 1.0–1.5 second teaching badge `OPEN · NEXT INPUT` on the first Level 4 open commit; it disappears on the next submitted action or Help toggle.
5. Distinct ECHO replay trail and a blocked-door X.
6. No audio dependency; optional temporary procedural tones only if separately authorized.

This version is the recommended immediate scope because it directly addresses the owner finding and remains reversible.

## Enhanced version

After licensed assets/audio and settings gates:

- animated circuit paths for multi-Plate dependencies;
- per-Plate pips on each Door, so AND requirements show which inputs are active;
- layered player/ECHO/Plate/Door sounds with limited polyphony;
- a subtle controller/keyboard-independent state banner;
- optional particle trails and environment response;
- captions and reduced-motion/reduced-flash alternatives.

The enhanced version is not required to validate Level 4 pedagogy.

## Multi-Plate AND extension

Each Door should display one pip per `all_plate_ids`, ordered by stable Plate ID. Active pips fill; the Door opens only when all are filled. Dependency paths must not imply a new rule: they visualize the exact validated references. In Level 5, two pips plus two visible paths should reinforce the already clear AND causality without adding permanent prose.

## Accessibility and safety

- State is never color-only or sound-only: use aperture/bars, icon, text, and motion.
- Minimum important-state text follows the selected presentation baseline.
- Provide reduce-motion and reduce-flash boundaries before enhanced effects ship.
- Avoid full-screen flashes, rapid repeated pulses, and camera shake for routine turns.
- Captions identify source and event (`ECHO step`, `Plate pressed`, `Door open`) when audio accessibility is implemented.
- Maintain actor letters and EXIT text over all effects.

## Later acceptance evidence

1. Full accepted regression and unchanged canonical keys.
2. Before/result capture pairs for Plate press, Door open, Door close, blocked entry, and occupant-on-closed-Door.
3. Automated proof that feedback consumes transition output and no animation callback calls simulation transition.
4. Grayscale and muted-audio capture review.
5. Owner Level 4 retest without route assistance.
6. Qualifying fresh review that asks when the Door becomes usable.

Stop if the feedback implies same-turn entry, obscures the board, exceeds 520 ms before input handoff in normal mode, or requires a semantic/schema change.

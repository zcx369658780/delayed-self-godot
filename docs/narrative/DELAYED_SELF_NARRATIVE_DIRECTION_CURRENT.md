# Delayed Self narrative direction (CURRENT)

- Status: `PLANNING_RECOMMENDATION_FOR_GPT`; no dialogue, localization file, cutscene, narrative state, or runtime copy is created.
- Scope: eight-level lightweight arc compatible with current player-only EXIT and schema-v1 mechanics.
- Theme: a response can arrive too late to change the past and still matter because it was finally heard.

## Premise

**A maintenance unit enters a silent time-synchronization station and follows delayed copies of its own actions to reconstruct a distress signal that has been waiting years for an answer.**

## Player and ECHO meaning

- YOU is an autonomous maintenance/recovery unit, not a surviving human. This supports a solitary facility and avoids promising character animation or dialogue-heavy production.
- ECHO is the deterministic replay of YOU's earlier inputs. It is never a separate AI or ghost with independent intent.
- In story language, ECHOs embody attempts, replies, and care that arrive after the moment that caused them.
- The mechanical fact remains primary: ECHO cannot complete EXIT and never changes the victory predicate.

## Emotional statement

The game begins with instrumental problem-solving, shifts into recognition that every “helper” is the player's own delayed effort, and ends with acceptance: the original emergency cannot be undone, but completing the signal prevents it from vanishing unheard.

Avoid a conventional rescue twist. The ending should be quiet, not punitive: the player restores witness and continuity, not the past.

## Eight-level arc

| Level | Mechanical role | Narrative beat | Candidate pre/post text |
|---:|---|---|---|
| 1 `tutorial_reach_exit` | YOU and EXIT | the station recognizes a new presence | Pre: `MAINTENANCE LINK: LOCAL CONTROL RESTORED.` Post: `One room answers.` |
| 2 `tutorial_echo_bridge` | first delay-3 ECHO | the station returns the player's motion late | Pre: `Signal return delay: three turns.` Post: `The reply was mine.` |
| 3 `vertical_slice_delay_3` | independent cooperation | repeated movement becomes intentional cooperation | Pre: `A path can be left for whoever arrives later.` Post: `No one else was walking here.` |
| 4 `door_one_turn_late` | next-turn Door timing | cause and access are separated by one turn | Pre: `The station opens only after it understands.` Post: `Every door answers late.` |
| 5 `two_keys_one_door` | two-Plate AND | present and past must hold different responsibilities together | Pre: `Two confirmations required. One operator detected.` Post: `One operator. More than one moment.` |
| 6 `staggered_doors` concept | two Door windows | signal fragments cross rooms out of order | Pre: `FRAGMENT 02 arrived before FRAGMENT 01.` Post: `Order can be rebuilt.` |
| 7 `two_echo_convergence` concept | two distinct delays | the player sees several temporal selves as one continuing effort | Pre: `Multiple returns. Same source.` Post: `I kept answering.` |
| 8 `signal_convergence` concept | accepted-mechanic synthesis | the full distress message is acknowledged, not rescued | Pre: `FINAL PACKET: ACKNOWLEDGEMENT REQUIRED.` Post: `Too late to save. Not too late to hear.` |

All text is provisional. The three Level 6–8 IDs are concepts, not formal catalog entries. No line may reveal a movement sequence or imply new mechanics.

## Beginning, middle, ending

### Beginning — recognition

Levels 1–2 use diagnostic language. The station appears functional but delayed. ECHO is introduced as an observed system effect, not a character.

### Middle — identity

Levels 3–6 gradually replace sterile status messages with first-person recognition. Environmental fragments show that the original staff tried to send one message through a failing synchronization system. The player realizes its repeated helpers are its own recorded actions.

### Ending — acknowledgement

Levels 7–8 combine several delayed returns. Completing the final EXIT allows the unit to send a minimal acknowledgement. The source is long gone or deliberately left unknown. The ending confirms receipt, fades the separate ECHO layers into one audio motif, and returns to the product flow within 30–60 seconds.

## Environmental storytelling

- room numbers and circuit paths repeat at different offsets, reinforcing delay without prose;
- old maintenance lights activate only after a nearby action, visually echoing the rule;
- signal-fragment IDs appear out of sequence in backgrounds;
- ECHO trails briefly align with worn floor paths, suggesting earlier attempts;
- terminal screens show timestamps/delay values, never route instructions;
- Level 5 and later doors use paired confirmation marks, connecting mechanics to station protocol;
- the finale reuses earlier icons/sounds in a resolved order instead of adding a cutscene.

Environmental elements are presentation only. Interactive terminals, collectibles, story inventory, branching goals, and route-dependent endings remain out of scope.

## Delivery model

- One pre-level line, optional one post-level line; each can be dismissed immediately.
- Gameplay begins without waiting for voice or animation.
- Repeated attempts do not replay post text; session/persistent policy belongs to later product/save tasks.
- Narrative text occupies the same modal/card system proposed for Help, never permanent board space.
- Level title and narrative copy use stable localization keys in a later localization task; formal level metadata does not become product prose authority.
- Audio motifs and environmental marks may reinforce the text but cannot be required for comprehension.

## Copy and localization constraints

- Chinese-first target: one sentence, preferably 8–24 Han characters; hard review limit 42 Han characters per card.
- English fallback target: no more than 90 characters or two short lines.
- Avoid concatenated grammatical fragments; give translators complete strings with context notes.
- Keep `YOU`, `ECHO`, `PLATE`, `DOOR`, and `EXIT` stable gameplay terms or consistently localized equivalents.
- Do not embed delay numbers into prose when the HUD already supplies runtime values, unless the line is explicitly a tutorial diagnostic.
- No voiced dialogue before candidate; no lip sync; no proper-name dependency.
- Font import must prove Simplified Chinese coverage and 960×540 readability.

## Intentional ambiguity

Leave unresolved:

- the exact year and location;
- whether the signal sender knew anyone would hear it;
- whether YOU was newly activated or has repeated the repair before;
- whether ECHOs are perceived as memory or only as system traces;
- the content of the original emergency beyond its need for acknowledgement.

Do not leave the core mechanic ambiguous: ECHOs are delayed input replays and only YOU completes EXIT.

## Content safety and scope

- No graphic injury, body imagery, suicide, self-harm, or explicit disaster detail.
- Loss is communicated through absence and timestamps, not traumatic description.
- Do not personify ECHOs as independent victims or imply the player is deleting conscious copies.
- No branching story, multiple endings, romance, voice cast, lore codex, or collectible requirement before candidate.
- Any public-facing claim about AI-generated narrative/art remains subject to rights and disclosure review.

## Production timing recommendation

Introduce the **text prototype after the first board/HUD and primitive Door-feedback pass**, when card space and state vocabulary are stable, but before final licensed art/music selection. This lets narrative guide environment motifs and the audio ending without forcing early asset commitments.

Recommended order:

1. accept presentation and feedback implementation;
2. owner verifies mechanics remain clear;
3. add text-only narrative cards behind stable keys in a separate task;
4. review tone/localization and remove any route-like language;
5. select licensed visual/audio assets that reinforce the accepted arc;
6. fresh/independent complete-flow review before candidate acceptance.

## Narrative acceptance questions

- Can a fresh player state who YOU and ECHO are without being told a route?
- Does the story reinforce delay rather than imply an AI companion?
- Does any card interrupt retry speed or cover the board?
- Is the ending understandable when muted and with reduced motion?
- Does the emotional claim match the actual eight-level flow?
- Can every line be removed without changing simulation, catalog progression, or save correctness?

If the answer to the last question is no, narrative has crossed into gameplay semantics and must be redesigned.

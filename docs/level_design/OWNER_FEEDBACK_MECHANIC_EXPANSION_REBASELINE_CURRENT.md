# Owner-feedback mechanic expansion rebaseline

Foundations are existing sequences 1–6 and are unchanged. Production remains eight levels with sequence 8 formal finale; shipping count is `DEFERRED` and candidate admission is `NOT_AUTHORIZED`.

## Crate slots

Each C slot is grid-deterministic, solver-representable, needs a visible crate cue, and cuts on duplicate/unclear/unsolved behavior. C01 is the only `CLEAR_OBSTRUCTION_ONLY` exception.

|slot|seed_status|teaching_purpose|prerequisite|crate_specific_interaction|reasoning_structure|anti_duplication_note|solver_representation|presentation_requirement|cut_condition|
|---|---|---|---|---|---|---|---|---|---|
|C01|SEQ09 seed revise|obstruction intro|foundation|push obstruction|clear route|intro only|grid crate state|crate visible|no purpose beyond clearing|
|C02|new|plate|C01|crate holds plate|spatial hold|not door repeat|crate position+plate|weight cue|YOU substitute|
|C03|new|delayed door|C02|crate holds window|timing|not plate repeat|crate+turn state|door timing cue|echo irrelevant|
|C04|new|signal blocker|C02|crate blocks beam|line of effect|not door|grid ray occupancy|beam cue|not representable|
|C05|new|anchor|C03|crate bridge|topology|not blocker|grid anchor|bridge cue|duplicate route|
|C06|new|ordering|C05|two crates|ordering|not one crate|two grid states|distinct crate cues|order irrelevant|
|C07|new|cooperation|C03|crate+echo|role split|not solo crate|crate/echo state|actor cue|echo optional|
|C08|new|commitment|C06|irreversible crate|commitment|not reset|persistent state|commit warning|trivial restart|
|C09|new|phase|C08|deterministic transfer|phase planning|contract only|explicit phase state|phase cue|not contract-representable|
|C10|new|synthesis|C01–09|mixed purpose|multi-step|not duplicate|composed state|all cues|weak synthesis|

## Separation slots

Every S slot requires distinct body/echo responsibilities, identity cue, readable failure, solver evidence, presentation cue, and cuts if either role is substitutable.

|slot|seed_status|body_responsibility|echo_responsibility|prerequisite|identity_cue|failure_readability|difficulty_intent|solver_evidence_requirement|presentation_requirement|cut_condition|
|---|---|---|---|---|---|---|---|---|---|---|
|S01|new|move|delayed role|foundation|badges|blocked route|intro|witness|actor cues|roles same|
|S02|SEQ10 seed|commit route|support|S01|body badge|wrong commitment|early|unique role|route cue|echo substitutes|
|S03|new|position|sensor activate|S01|sensor type|inactive sensor|early|sensor witness|typed cue|body substitutes|
|S04|new|path A|path B|S03|split paths|collision|mid|parallel proof|path cue|paths symmetric|
|S05|new|arrive|arrive delayed|S04|timing|missed reunion|mid|timing witness|timeline cue|timing irrelevant|
|S06|new|open|traverse|S04|role labels|closed route|mid|dependency proof|door cue|echo optional|
|S07|new|traverse|open|S06|role labels|closed route|mid|dependency proof|door cue|body optional|
|S08|new|phase one|phase two|S07|phase badge|wrong phase|late|phase witness|phase cue|no reversal|
|S09|SEQ11 seed|typed role|typed role|S08|sensors|barrier failure|late|group proof|sensor/barrier cue|roles blur|
|S10|SEQ12 seed|latch role|latch role|S09|latch cue|unlatched state|late|persistent proof|latch cue|not synthesis|

## Final slots

|slot|purpose|prerequisite|relationship to 7–8|difficulty role|solver requirement|presentation requirement|cut condition|
|---|---|---|---|---|---|---|---|
|F01|reintroduce|expansion review|spacing reference|ramp|witness|spacing cue|redundant|
|F02|advanced alignment|F01|recovery reference|hard|shortest proof|alignment cue|opaque|
|F03|mixed penultimate|F02|optional bridge|very hard|mechanic proof|mixed cues|schedule cut|
|F04|final alignment|F02|future synthesis|final|complete proof|final clarity|not satisfying|

`current_sequence_8 = FORMAL_FINALE_UNCHANGED_FOR_NOW`; `future_finale_direction = SHADOW_TRAPPING_ALIGNMENT`; `exact_final_level = DEFERRED`.

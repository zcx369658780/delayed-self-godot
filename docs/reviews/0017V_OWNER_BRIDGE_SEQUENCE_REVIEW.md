# Task 0017V authenticated-owner bridge sequence review

- Reviewer: `authenticated_project_owner`
- Classification: `AUTHENTICATED_OWNER_NOT_FRESH_NOT_INDEPENDENT_BRIDGE_SEQUENCE_REVIEW`
- Fresh-independent boundary: `FRESH_INDEPENDENT_REVIEW_UNAVAILABLE_BY_OWNER_CONSTRAINT`
- Date: 2026-07-18
- Review checkpoint: `ea3caa3aeb53a8e4e4fffe80098fcf6bab678c0e`
- Accepted bridge implementation: `47e40fa13cccc2725c3110969c64f1e328dee0a8`
- Disposition: `B — BOUNDED_BRIDGE_PRESENTATION_DIFFICULTY_REPAIR`
- Findings: P0=0, P1=0, P2=4, P3=1

## Evidence and exposure boundary

The owner is the only available playtester. No third party was sought, required, contacted, recruited, or suggested.

The owner had extensive prior project exposure and had previously seen the exact `two_echo_convergence` witness. Level 8 evidence is therefore not blind route discovery or unbiased difficulty evidence. No bridge witness, coordinates, target spacing, target turn, next action, or solver output was disclosed before or during the bridge attempts.

Three separate native Compatibility-renderer processes launched Level 6, the bridge, and shifted Level 8. Startup logs were normal and stderr was empty. The owner voluntarily supplied two game-window-only screenshots. No desktop, face, voice, keyboard log, account, notification, or unrelated window evidence was collected.

## Sequence attempt record

### Level 6 — `staggered_doors`

- Status: `COMPLETED_UNASSISTED`
- Prior familiarity: present
- Final visible turn: 16, screenshot-confirmed
- Approximate elapsed time: 4 seconds, owner-supplied
- Restarts: 0; owner said “一次通过”
- Help: not used
- Timeline: not provided
- Owner concept: “主要学到了门的次序”

The owner-provided completion screenshot shows Turn 16 and YOU at EXIT.

### Bridge — `echo_spacing_bridge`

The owner first attempted the bridge without route assistance:

- Initial status: `GAVE_UP_UNASSISTED`
- Initial restarts: “大概20多次”
- Help: used; reported no help
- Timeline: used; reported no help

Initial explanation:

> “两个ECHO间距变化还是门改变地形达成的。和之前类似，我使用→→→↑↑↑←→，就可以让第一个影子进门，但是后续调整让两个影子分别踩中两个开关这一步，我失败了。”

> “门可以挡住第二个影子，第一个可以继续移动拉开距离”

After the initial give-up and the shifted-Level-8 comparison stage, the owner independently returned to the bridge without operator route assistance and discovered a completion method:

- Final status: `COMPLETED_UNASSISTED_AFTER_INITIAL_GIVE_UP_AND_REVISIT`
- Additional elapsed time: approximately 5 minutes
- Additional restarts: 10
- Total reported restart burden: more than 30 across both phases
- Final visible turn: 37
- Screenshot: Turn 35 A+B open result immediately before crossing

Owner explanation:

> “E4被挡住，E2可以进门。”

> “让E2进门往上走，地形阻隔可以任意调整E2和E4的间距，然后玩家在下方顺时针转圈，就可以让E2E4分别踩中机关”

The Turn 35 screenshot shows `ECHO SPACING CHANGED · E2 MOVED · E4 BLOCKED`, E2 on A, E4 on B, Door OPEN, and YOU staged below the Door. The owner confirmed that turns 36–37 crossed and completed the room; the product then returned to the menu.

### Shifted Level 8 — `two_echo_convergence`

- Owner statement: completed previously (“昨天就有这关”)
- Prior exact witness exposure: present
- Current task blind completion: not claimed
- Useful evidence: comparative judgment only

The owner did not consider the bridge an effective teaching step in its current form and did not find the sequence smoother.

## Structured owner answers

1. **What caused E2/E4 spacing to change?**

   Door/terrain blocking changed effective movement distance:

   > “两个ECHO间距变化还是门改变地形达成的。”

2. **Which ECHO was blocked and which moved?**

   > “E4被挡住，E2可以进门。”

   The supplied bridge screenshot also shows `E2 MOVED · E4 BLOCKED`.

3. **Why are both ECHOs necessary for A+B while YOU crosses?**

   The owner found A/B and the Door dependency easy to identify visually and ultimately placed E2/E4 on separate Plates, but did not provide a complete mechanical necessity explanation.

4. **Why can YOU not replace one ECHO?**

   Understanding remained uncertain:

   > “我猜测可能是我的解法不对”

   No stronger explanation is inferred.

5. **What does the next-input Door rule mean?**

   > “门如果是关闭状态，朝向门的移动会显示Block，而门显示打开状态，才能移动到门的位置中。由于移动后门的图像是关闭状态，我倾向于认为门开启后下回合才能进入。”

6. **What recovery experiment was visible after failure?**

   > “我尝试过调整，很多次。有几次第二个影子完全进入门上方（出口处），导致后续出不来了，这时我也会重开。”

   The later successful experiment was to route E2 upward and circle YOU clockwise below to change phase.

7. **Understandable without Timeline?**

   The owner ultimately discovered the mechanism through the board, not Timeline, but only after an initial give-up and high restart burden.

8. **Did Help contribute?**

   No:

   > “Help中没有给出解法或机制解释。”

   > “Timeling和H都没帮助”

9. **Were outcomes and identities readable?**

   > “清晰。”

   A/B and A+B were also described as easy to identify from the visual indicators and Door marks.

10. **Did dotted lines create clutter?**

   > “虚线感觉不必要。”

   This is recorded as a lower-severity presentation preference; the owner did not say it prevented play.

11. **Compared with Level 6, appropriately harder?**

   No. Level 6 was completed in about 4 seconds without Help, while the bridge caused more than 20 restarts and an initial give-up.

12. **Compared with shifted Level 8, materially simpler?**

   The owner stated what the bridge should do rather than confirming it achieved the goal:

   > “桥接关应该足够简单，同时教会玩家后续要用到的技巧”

13. **Did the sequence smooth the discontinuity?**

   > “一点都不平滑，第七关难度增加很多”

14. **Preserve/revise/reposition/remove?**

   > “我建议修改得简单一些。”

15. **Finale planning or repair first?**

   > “难度和Help是最需要改的”

## Findings

### P0 — 0

No crash, corruption, inaccessible level, or progression failure was reported.

### P1 — 0

No false outcome label, stable-spacing false cue, wrong Door behavior, or formal/runtime contradiction was reported. The owner eventually completed the accepted room without route assistance.

### P2 — 4

1. **Difficulty/curriculum failure:** Level 6 took about 4 seconds, while the bridge caused an initial give-up after more than 20 restarts and required roughly 10 more restarts to complete after revisiting.
2. **Help ineffective:** Help was used but supplied neither a useful mechanism explanation nor an actionable experiment according to the owner.
3. **Timeline ineffective:** Timeline was used and reported as unhelpful.
4. **Incomplete necessity model:** even after completion, the owner could not explain why YOU cannot replace one ECHO on a Plate.

### P3 — 1

1. **Dotted-line preference:** the owner found the dotted lines unnecessary, although identities and dependencies remained readable.

## Disposition

```text
B — BOUNDED_BRIDGE_PRESENTATION_DIFFICULTY_REPAIR
```

The bridge formal intent should be preserved: the owner independently discovered the intended terrain/Door spacing manipulation, correctly identified E4 blocked/E2 moved, created E2→A/E4→B, understood next-input Door entry, and completed at Turn 37.

However, the bridge did not achieve its curriculum goal at acceptable owner difficulty. The sequence remained sharply discontinuous; Help and Timeline contributed no useful recovery; and the YOU-substitution necessity remained unexplained. A bounded follow-up should investigate a simpler teaching geometry and/or a clearer mechanism/recovery Help treatment before finale planning. This review does not authorize either change.

## Non-claims

This review does not establish fresh or independent evidence, blind Level 8 discovery, population difficulty, balance/fun acceptance, a specific repair, exact walkthrough Help, finale authority, candidate readiness, export, release, or submission readiness.

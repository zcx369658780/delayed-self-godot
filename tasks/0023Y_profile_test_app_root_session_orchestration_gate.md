# Task 0023Y — Implement the test-profile-only AppRoot session orchestration gate

- Status: `READY`
- Gate: `PROTECTED PLAYER DATA / TEST PROFILE APPROOT SESSION ORCHESTRATION`
- Repository/root/branch: `zcx369658780/delayed-self-godot` / `D:\Delayed_Self` / `main`
- GPT prerequisite acceptance: `docs/reports/0023X_GPT_PROFILE_MEMORY_PROGRESS_ADAPTER_GATE_ACCEPTANCE.md`
- Required checkpoint: `4f3b7c8500ed6fcfacef279b024cd3a01b576eda`

## Objective

Connect the accepted test-only Profile filesystem store and pure Profile↔MemoryProgress adapter through a bounded AppRoot session test path only.

Prove:

- catalog load;
- configured test store creation;
- profile load;
- adapter hydration;
- gameplay completion candidate preparation;
- persistence before runtime commit;
- fresh session reload;
- NO_CHANGE;
- deterministic rollback/failure behavior;
- Safe Error handling where applicable;
- exact fixture cleanup.

## Non-goals

This task does not authorize:

- production Profile access;
- production constructors or fallbacks;
- normal AppRoot boot changing from memory-only behavior;
- New Game/Continue/Reset UI;
- settings persistence;
- menus/localization;
- aggregate persistence tests;
- release/export/submission.

## Frozen authorities

Preserve:

- 0023R path isolation;
- 0023T codec;
- 0023V configured instance;
- 0023W filesystem store;
- 0023X adapter;
- eight-level catalog and simulation boundaries.

## Required constraints

- Use exactly one task-owned canonical fixture.
- Do not enumerate test roots.
- Do not touch production Profile content.
- Do not modify accepted codec or store contracts unless blocked and separately adjudicated.
- Stage only authorized paths.

## Required validation

Before and after implementation rerun:

- 0023R
- 0023T
- 0023V
- 0023W
- 0023X

Add focused AppRoot session tests proving:

- fresh test session starts clean;
- persistence occurs before runtime commit;
- failed persistence does not mutate runtime state;
- successful persistence survives fresh test session reconstruction;
- NO_CHANGE remains deterministic;
- cleanup removes only owned fixture data.

## Terminal verdict

Return exactly one:

```text
PROFILE_APPROOT_SESSION_ORCHESTRATION_READY_FOR_GPT_REVIEW
BLOCKED_PROFILE_APPROOT_SESSION_ORCHESTRATION
```

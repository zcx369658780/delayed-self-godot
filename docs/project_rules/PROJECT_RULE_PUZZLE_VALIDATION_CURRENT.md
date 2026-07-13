# Puzzle validation rules (CURRENT)

Every formal candidate level must identify level/data version and validation commit, solvability, shortest length, at least one machine-verified solution, shortest-solution count or declared approximation, mechanisms, teaching goal, known shortcuts, and human-playtest status.

AI output is a proposal, never proof. Candidate layouts and solutions require schema validation and execution by the solver/runtime contract. A timeout is `UNVERIFIED`, not solvable. Claims of uniqueness require exhaustive or otherwise justified search evidence. Difficulty needs metrics plus human comprehension/playtest evidence, not step count alone.

Any state-transition change reruns the full formal-level suite, compares solvability and shortest solutions, identifies changed levels, and classifies expected changes versus regressions. A runtime/solver mismatch removes affected levels from the formal candidate set until resolved.

The architecture must preserve deterministic `S_(t+1) = F(S_t, u_t, level_rules)`, clear movement/environment/hazard/win settlement order, complete restart reset, and machine-readable level validation.

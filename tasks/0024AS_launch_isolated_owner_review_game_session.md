# Task 0024AS — Launch the isolated 1–12 owner-review game session and leave it running for the owner

- Status: `READY`
- Gate: `INTERACTIVE OWNER-REVIEW LAUNCH / ISOLATED STAGING CATALOG / TEST PROFILE / NO SUBJECTIVE AUTOFILL`
- Repository/root/branch: `zcx369658780/delayed-self-godot` / `D:\Delayed_Self` / `main`
- Required accepted checkpoint in ancestry: `9caa73d548dc15047913a09505ea16f3eaf18195`
- Previous adjudicated gate: `TASK_0024AR_MCP_TRANSPORT_ACCEPTED_DEEPSEEK_CODE_QUALITY_NOT_ACCEPTABLE`
- DeepSeek project-code routing: `DISABLED`
- Accepted owner route: `MACHINE_QUALIFIED_ISOLATED_STAGING_ROUTE`
- Presentation gate: `TASK_0024AL_PROCESS_ISOLATED_WRITE_AHEAD_SCHEMA_V2_MINIMUM_OWNER_REVIEW_PRESENTATION_ACCEPTED`
- Owner playthrough: `NOT_YET_REVIEWED`
- Formal production catalog: exactly sequences 1–8
- Formal production finale: sequence 8 only
- Uncatalogued accepted staging candidates: sequences 9–12
- Catalog admission: `NOT_AUTHORIZED`
- Task success state: `OWNER_REVIEW_SESSION_LAUNCHED_AWAITING_OWNER_INPUT`

## 1. Objective

This is a bounded operational task.

Codex must:

1. synchronize the repository safely;
2. verify the accepted owner-review launcher, staging catalog, level files and minimum presentation gate;
3. verify no Godot process is already running;
4. resolve the exact installed Godot 4.7.1 executable without changing the installation;
5. launch the game non-headless through the accepted Task 0024AE interactive staging launcher;
6. use the isolated Task 0024AE test Profile route, never the production Profile;
7. verify from bounded startup evidence that the session is the interactive staging route;
8. leave the game process and window running for the owner;
9. return the owned PID, launch identity and concise play instructions;
10. make no repository change, commit or push;
11. leave all subjective owner-review worksheet fields untouched.

This task does not conduct the owner's review. It only launches the accepted review environment.

## 2. Owner-session boundary

Codex must not:

- play or solve levels on the owner's behalf;
- send gameplay input after startup;
- auto-complete or unlock levels;
- invoke the machine-qualification flag;
- replay accepted solver solutions;
- populate subjective ratings, confusion points, enjoyment or disposition;
- infer owner acceptance from machine validation;
- admit sequences 9–12 to the production catalog;
- promote sequence 12 to the production finale;
- modify production or test Profile files manually;
- close the successfully launched game;
- wait for the owner to finish;
- perform work asynchronously after returning its launch status.

The owner will interact with the visible game window directly.

## 3. Accepted launch route

Use exactly:

```text
res://tests/playtest/task_0024ae_submission_core_owner_review_launcher.gd
```

Accepted launcher SHA-256:

```text
ad6a2748c404a031c016d78696698a0d8b36dbfdb85ac981aa4cb0a20214ae4c
```

Use exactly:

```text
res://tests/playtest/fixtures/task_0024ae_submission_core_staging_catalog.json
```

Accepted staging catalog SHA-256:

```text
389e33babba6cf9840dc5ddf6e6b0beb3bf22412947ccd81cdb290bc536d1780
```

The launcher configures:

```text
user://delayed_self_test_profiles/task_0024ae_owner_curriculum/delayed_self_profile.json
```

It must instantiate AppRoot outside the tree, assign the staging catalog, configure `TEST_PROFILE`, and enter the tree only after configuration succeeds.

Do not use:

```text
--task-0024ae-route-qualification
```

Absence of that flag selects interactive owner-review mode.

Do not launch the production project main scene directly for this task.

## 4. Frozen product facts

The staging route contains twelve ordered entries:

```text
1  tutorial_reach_exit
2  tutorial_echo_bridge
3  vertical_slice_delay_3
4  door_one_turn_late
5  two_keys_one_door
6  staggered_doors
7  echo_spacing_bridge
8  two_echo_convergence
9  crate_shadow_timing
10 key_route_commitment
11 identity_shift_bridge
12 lasting_echo_latch
```

In staging only:

- sequence 8 is not final;
- sequence 12 is the sole staging final;
- production catalog remains unchanged;
- the isolated test Profile owns staging progression.

The accepted presentation gate is sufficient for owner review but is not final art acceptance.

The launcher may still emit its historical field:

```text
presentation_readiness = BLOCKED_SCHEMA_V2_VISUALS
```

That legacy launcher string is not a current blocker. Task 0024AL superseded it with:

```text
presentation_readiness =
MACHINE_QUALIFIED_SCHEMA_V2_MINIMUM_OWNER_REVIEW_REQUIRED
```

Do not modify the launcher merely to update the legacy diagnostic string.

## 5. Startup state machine

```text
STARTUP_GATE
→ REQUIRED_READS
→ LAUNCH_ARTIFACT_HASH_GATE
→ GODOT_EXECUTABLE_RESOLUTION
→ PRE_LAUNCH_PROCESS_GATE
→ LOCAL_EVIDENCE_DIRECTORY_PREP
→ INTERACTIVE_STAGING_LAUNCH
→ OWNED_PROCESS_AND_CONFIGURATION_VERIFICATION
→ LEAVE_GAME_RUNNING
→ OWNER_HANDOFF
```

There is no implementation, repair, commit or push state.

## 6. Startup gate

Before launching:

1. require absolute root `D:\Delayed_Self`;
2. require branch `main`;
3. confirm origin `zcx369658780/delayed-self-godot`;
4. fetch and fast-forward only;
5. require `HEAD == origin/main`, divergence `0/0`;
6. require Task 0024AS and current pointers from `origin/main`;
7. require checkpoint `9caa73d548dc15047913a09505ea16f3eaf18195` in ancestry;
8. require no Git operation in progress;
9. require no tracked or staged changes;
10. allow only the existing untracked `.codex/config.toml`;
11. require its SHA-256: `d4c670da3c2404921a1ab177f4e5405449bc8321d713cc0b42b8046201fd33cc`;
12. require total Godot process count zero;
13. require no stale Task 0024AS launch record claiming an active owned PID;
14. stop on remote drift, dirty tracked state, unexpected untracked paths, process ambiguity or accepted-artifact drift.

Do not inspect or modify production Profile/player data.

## 7. Required reads

```text
AGENTS.md
docs/CODEX_STARTUP_SNAPSHOT_CURRENT.md
docs/CODEX_ACTIVE_TASK_CURRENT.md
tasks/0024AS_launch_isolated_owner_review_game_session.md
docs/reports/0024AL_GPT_PROCESS_ISOLATED_WRITE_AHEAD_SCHEMA_V2_PRESENTATION_ACCEPTANCE.md
docs/reports/0024AE_SUBMISSION_CORE_OWNER_REVIEW_ROUTE_REPORT.md
docs/playtest/SUBMISSION_CORE_1_12_OWNER_CURRICULUM_REVIEW_CURRENT.md
tests/playtest/task_0024ae_submission_core_owner_review_launcher.gd
tests/playtest/fixtures/task_0024ae_submission_core_staging_catalog.json
docs/reports/0024AR_GPT_DEEPSEEK_MCP_CODE_QUALITY_ADJUDICATION.md
docs/agents/PROJECT_RULE_CODEX_MULTI_SUBAGENT_MODEL_ROUTING.md
docs/DEVELOPMENT_PLAN_CURRENT.md
docs/HANDOFF_MASTER_CURRENT.md
docs/project_memory.md
```

Do not read retained raw evidence or rerun consumed manifests.

## 8. Launch-artifact hash gate

Before launch, compute SHA-256 for:

```text
tests/playtest/task_0024ae_submission_core_owner_review_launcher.gd
tests/playtest/fixtures/task_0024ae_submission_core_staging_catalog.json
```

Require the exact accepted hashes from section 3.

Also verify:

- all twelve referenced level JSON files exist;
- production catalog remains unchanged from the accepted baseline;
- the launcher still contains the exact staging catalog path, exact isolated test Profile path, `configure_test_profile`, and interactive mode when the qualification flag is absent;
- the launcher does not call `configure_production_profile`.

This is read-only. Do not edit a mismatch.

## 9. Godot executable resolution

Resolve one exact installed Godot executable reporting:

```text
4.7.1.stable.steam.a13da4feb
```

Resolution order:

1. use an exact executable path already recorded in canonical local environment evidence when available;
2. otherwise inspect `Get-Command godot`, `godot4`, or the known Steam Godot installation directory narrowly;
3. canonicalize the executable path;
4. require a regular `.exe` file;
5. invoke only `--version`;
6. require exactly one unambiguous match.

Do not install/update Godot, open Steam through a URI, use another version, or change renderer/project/export settings.

## 10. Isolated Profile boundary

The interactive launcher owns only:

```text
user://delayed_self_test_profiles/task_0024ae_owner_curriculum/
```

Do not inspect, enumerate, hash or stat the production Profile or its siblings.

Do not broadly enumerate `user://` or `user://delayed_self_test_profiles/`.

Do not delete the owner test Profile before launch.

- If absent, the session starts fresh.
- If a previous owner session exists, the game may resume that isolated progress.

Do not manually create or edit the Profile.

## 11. Local launch evidence

Create only:

```text
C:\Users\zcxve\.codex\reports\delayed-self\0024AS\
```

Allowed files:

```text
launch_stdout.log
launch_stderr.log
launch_record.json
```

The record may contain timestamp, HEAD, Godot executable/version, PID, project path, script path, staging catalog path, isolated Profile path and startup result.

Do not record Profile contents, secrets, private config, unrelated environment variables, player input or subjective review.

These files are local-only and must never be staged.

## 12. Exact interactive launch

Launch the executable directly, not through Steam.

Use argument-array semantics equivalent to:

```powershell
$arguments = @(
    "--path",
    "D:\Delayed_Self",
    "--script",
    "res://tests/playtest/task_0024ae_submission_core_owner_review_launcher.gd"
)
```

Start non-headless and preserve the visible game window.

Do not include `--headless`, `--editor`, `--task-0024ae-route-qualification`, or `--quit`.

Do not pass solver or completion arguments.

Use `Start-Process` or `System.Diagnostics.ProcessStartInfo` with the exact executable and argument list. Working directory is `D:\Delayed_Self`. Record the root PID.

## 13. Verification after launch

Wait only long enough to verify startup, maximum 15 seconds.

Require:

1. owned process or exact Godot descendant alive;
2. executable identity equals resolved Godot;
3. command line contains exactly one `--path` equal to `D:\Delayed_Self`;
4. command line contains exactly one `--script` equal to the accepted launcher;
5. no qualification flag;
6. bounded stdout contains one parseable `TASK_0024AE_CONFIGURATION_JSON` with `mode = INTERACTIVE_STAGING`, the exact staging catalog path and exact isolated Profile path;
7. route is not `SAFE_ERROR`;
8. no startup-fatal stderr;
9. no unrelated second Godot process;
10. repository remains unchanged.

Acceptable startup routes are `MAIN_MENU`, `LEVEL_SELECT`, or `GAMEPLAY`.

Do not send input to change route.

## 14. Leave-game-running contract

After verification:

- do not wait for exit;
- do not kill or close the process;
- do not clean the isolated Profile;
- do not launch another instance;
- do not modify the worksheet;
- do not commit or push;
- return to the user with the game still running.

The intentionally live process is success, not residue.

Record:

```text
godot_process_state =
ONE_OWNED_INTERACTIVE_SESSION_LEFT_RUNNING
```

## 15. Owner handoff

On success report:

```text
OWNER_REVIEW_SESSION_LAUNCHED_AWAITING_OWNER_INPUT
```

Include synchronized HEAD, Godot version, owned active PID, `INTERACTIVE_STAGING`, twelve-entry staging catalog, isolated test Profile path, startup route, unchanged repository, no production Profile access, no worksheet changes, no commit/push, and that the game was intentionally left running.

Tell the owner to play in order from sequence 1, use normal restart controls, remember sequences 9–12 are staging candidates, close the game manually when finished, and send qualitative observations to the GPT advisor.

Do not include puzzle solutions.

## 16. Failure and stop conditions

Return `BLOCKED` without launching, or close only the exact newly owned failed process, for remote divergence, dirty tracked state, unexpected untracked paths, launcher/catalog hash mismatch, missing level file, Godot version mismatch, ambiguous executable, pre-existing Godot process, production Profile route, qualification mode, `SAFE_ERROR`, startup-fatal stderr, process identity ambiguity, or unauthorized repository change.

Never close an unknown/pre-existing process.

## 17. Git policy

No repository write is authorized.

Do not run `git add`, `git commit`, `git push`, `git restore`, `git reset`, or `git clean`.

Final Git state:

```text
no tracked/staged changes
only .codex/config.toml untracked
```

## 18. DeepSeek boundary

Do not invoke DeepSeek MCP or wrapper/CLI.

Task 0024AR established:

```text
MCP transport = PASS_DIRECT_FILE_EDIT
DeepSeek code quality = 23/100 / NOT_ACCEPTABLE
```

GPT-5.6 owns this launch task.

## 19. Required final fields

```text
task_result =
  OWNER_REVIEW_SESSION_LAUNCHED_AWAITING_OWNER_INPUT
  or BLOCKED

launch_route =
  INTERACTIVE_STAGING
  or NOT_LAUNCHED

godot_version =
  4.7.1.stable.steam.a13da4feb
  or BLOCKED

owned_root_pid =
  <pid or NONE>

owned_active_pid =
  <pid or NONE>

startup_route =
  MAIN_MENU
  or LEVEL_SELECT
  or GAMEPLAY
  or NOT_AVAILABLE

staging_catalog_entries =
  12
  or NOT_VERIFIED

profile_mode =
  TEST_PROFILE
  or NOT_VERIFIED

production_profile_access =
  NO
  or UNVERIFIED

worksheet_modified =
  NO

repository_modified =
  NO

commit_created =
  NO

push_performed =
  NO

godot_process_state =
  ONE_OWNED_INTERACTIVE_SESSION_LEFT_RUNNING
  or ZERO_AFTER_BLOCKED_CLEANUP
  or PRE_EXISTING_PROCESS_BLOCKER

owner_playthrough_status =
  IN_PROGRESS
  or NOT_STARTED
```

## 20. Successor

After the owner closes the game and returns observations, a new task may record only owner-supplied judgments, update the worksheet, and synthesize `ACCEPT / REVISE / CUT / RETEST` recommendations.

Task 0024AS does not modify production catalog, finale, progression or Profile.

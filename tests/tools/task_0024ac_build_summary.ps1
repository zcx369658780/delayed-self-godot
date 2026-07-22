[CmdletBinding()]
param()

$ErrorActionPreference = 'Stop'
$root = 'D:\Delayed_Self'
$output = Join-Path $root 'docs\level_design\validation\sequence_12_lasting_echo_latch_validation.json'
if (Test-Path -LiteralPath $output) { throw "Summary already exists: $output" }
function Read-Json([string]$Relative) { return Get-Content -LiteralPath (Join-Path $root $Relative) -Raw | ConvertFrom-Json -Depth 100 }
function Sha([string]$Relative) { return (Get-FileHash -LiteralPath (Join-Path $root $Relative) -Algorithm SHA256).Hash.ToLowerInvariant() }

$candidatePath = 'data/levels/lasting_echo_latch.json'
$validatorPath = 'tests/levels/task_0024ac_lasting_echo_latch_validation.gd'
$candidate = Read-Json $candidatePath
$manifest = Read-Json 'tests/tools/task_0024ac_final_cycle_manifest.json'
$invocation = Read-Json 'tests/tools/task_0024ac_final_cycle_invocation.json'
$progress = Read-Json 'tests/tools/task_0024ac_final_cycle_progress.json'
$capture = Read-Json 'tests/tools/task_0024ac_final_case_01_capture_validation.json'
$preTask = Read-Json 'tests/tools/task_0024ac_pre_task_frozen_hash_audit.json'
$preFinal = Read-Json 'tests/tools/task_0024ac_pre_final_frozen_hash_audit.json'
$postFinal = Read-Json 'tests/tools/task_0024ac_post_final_frozen_hash_audit.json'
$authoring = Read-Json 'tests/tools/task_0024ac_authoring_history.json'

if ($capture.status -ne 'PASS' -or $capture.record_count -ne 15 -or $capture.maximum_utf8_bytes -ge 1800) { throw 'Final focused capture is not accepted' }
if ($progress.stage -ne 'AFTER_ALL_CASES' -or @($progress.completed_cases).Count -ne 6 -or $progress.final_godot_count -ne 0) { throw 'Final progress is incomplete' }
foreach ($audit in @($preTask, $preFinal, $postFinal)) { if ($audit.status -ne 'PASS') { throw "Frozen audit failed: $($audit.phase)" } }

$payloads = [ordered]@{}
foreach ($prefix in @('TASK_0024AC_METRICS_JSON','TASK_0024AC_WITNESS_JSON','TASK_0024AC_ALL_SHORTEST_JSON','TASK_0024AC_CONTROL_LATCH_JSON','TASK_0024AC_CONTROL_ROUTE_JSON','TASK_0024AC_SHORTCUTS_JSON','TASK_0024AC_REPLAY_RESTART_JSON')) {
    $matches = @($capture.records | Where-Object { $_.prefix -eq $prefix })
    if ($matches.Count -ne 1) { throw "Unexpected final payload count: $prefix=$($matches.Count)" }
    $payloads[$prefix] = $matches[0].payload
}
$events = @($capture.records | Where-Object { $_.prefix -eq 'TASK_0024AC_EVENT_JSON' } | ForEach-Object { $_.payload })
if ($events.Count -ne 8) { throw "Unexpected event count: $($events.Count)" }
$metrics = $payloads.TASK_0024AC_METRICS_JSON
$all = $payloads.TASK_0024AC_ALL_SHORTEST_JSON
if ($metrics.status -ne 'SOLVED' -or $metrics.shortest_turn_count -lt 21 -or $metrics.shortest_turn_count -gt 28 -or $metrics.shortest_solution_count_status -ne 'EXACT' -or $metrics.shortest_solution_count -lt 1 -or $metrics.shortest_solution_count -gt 6 -or $metrics.elapsed_ms -lt 0 -or $metrics.elapsed_ms -gt 45000) { throw 'Final metrics violate contract' }
if ($all.total_completed_paths -ne $metrics.shortest_solution_count -or $all.full_event_paths -ne $metrics.shortest_solution_count -or $all.omitting_event_paths -ne 0) { throw 'All-shortest mismatch' }

$caseSummaries = [Collections.Generic.List[object]]::new()
foreach ($case in $manifest.cases) {
    $record = Read-Json $case.record
    $stderr = @($record.stderr)
    $expectedStderr = if ($case.name -eq 'aggregate') { @('LEVEL_ID_MISMATCH') } else { @() }
    if ($record.status -ne 'PASS' -or $record.wrapper_process_exit -ne 0 -or $record.native_exit_code -ne 0 -or $record.required_marker_count -ne 1 -or $record.cleanup_invocation_count -ne 1 -or $record.godot_before_count -ne 0 -or $record.godot_after_count -ne 0 -or @($record.remaining_owned_pids).Count -ne 0 -or @($record.remaining_unproven_pids).Count -ne 0 -or (($stderr -join '|') -cne ($expectedStderr -join '|'))) { throw "Final case failed exact audit: $($case.name)" }
    $caseSummaries.Add([ordered]@{
        ordinal = $case.ordinal
        name = $case.name
        script = $case.script
        required_marker = $case.marker
        record = $case.record
        record_sha256 = Sha $case.record
        wrapper_process_exit = $record.wrapper_process_exit
        native_exit_code = $record.native_exit_code
        marker_count = $record.required_marker_count
        stderr = $stderr
        cleanup_invocation_count = $record.cleanup_invocation_count
        cleanup_order = @($record.cleanup_order)
        owned_record_count = @($record.owned_records).Count
        unproven_record_count = @($record.unproven_records).Count
        remaining_owned_pids = @($record.remaining_owned_pids)
        remaining_unproven_pids = @($record.remaining_unproven_pids)
        godot_before_count = $record.godot_before_count
        godot_after_count = $record.godot_after_count
        pass = $true
    })
}

$recordBytes = @($capture.records | ForEach-Object { [ordered]@{ prefix = $_.prefix; utf8_bytes = $_.utf8_bytes } })
$result = [ordered]@{
    schema_version = 1
    task_id = '0024AC'
    validation_status = 'SEQUENCE_12_LASTING_ECHO_LATCH_MACHINE_VALIDATED_FOR_GPT_REVIEW'
    repository = [ordered]@{
        root = 'D:\Delayed_Self'
        branch = 'main'
        validation_baseline_commit = $invocation.head
        required_accepted_checkpoint = '349f0436691e7f0a7ee73af36870e0b026bba49d'
        accepted_sequence_11_result_commit = 'e6cd9fe76c19a144315b173b480ad5f9ccf2f115'
        accepted_sequence_10_result_commit = 'b8378bc2e1e96642ff99eded436df65e2435cc9f'
        accepted_sequence_9_result_commit = '445122ab035a4c9210f3280af58d054a35bef2bd'
        accepted_foundation_result_commit = '7072566ef814f6969693bbc9335fcced5e424585'
        godot_version = '4.7.1.stable.steam.a13da4feb'
        accepted_wrapper_blob = '5f14eb0feff903b40311c1c7283b20e2eabbffc2'
    }
    candidate = [ordered]@{
        path = $candidatePath
        sha256 = Sha $candidatePath
        validator_path = $validatorPath
        validator_sha256 = Sha $validatorPath
        classification = 'UNCATALOGUED_SEQUENCE_12_CORE_CANDIDATE'
        finale_status = 'FINALE_CANDIDATE_ONLY'
        identity = [ordered]@{ level_id = $candidate.level_id; title = $candidate.title; planned_zh_hans_title = '余响落锁'; schema_version = $candidate.schema_version; width = $candidate.terrain_rows[0].Length; height = @($candidate.terrain_rows).Count; player_spawn = $candidate.player_spawn; echoes = @($candidate.echoes); exit = $candidate.exit; latches = @($candidate.latches); sensors = @($candidate.sensors); barrier_groups = @($candidate.barrier_groups) }
        forbidden_families_empty = $candidate.crates.Count -eq 0 -and $candidate.keys.Count -eq 0 -and $candidate.locks.Count -eq 0 -and $candidate.plates.Count -eq 0 -and $candidate.doors.Count -eq 0
    }
    limits = $metrics.limits
    solver = $metrics
    witness = $payloads.TASK_0024AC_WITNESS_JSON
    ordered_events = $events
    all_shortest = $all
    necessity_controls = [ordered]@{ latch = $payloads.TASK_0024AC_CONTROL_LATCH_JSON; route = $payloads.TASK_0024AC_CONTROL_ROUTE_JSON }
    shortcut_and_rule_probes = $payloads.TASK_0024AC_SHORTCUTS_JSON
    replay_restart_canonical = $payloads.TASK_0024AC_REPLAY_RESTART_JSON
    bounded_output = [ordered]@{ status = $capture.status; record_count = $capture.record_count; strict_limit_bytes = 1800; maximum_utf8_bytes = $capture.maximum_utf8_bytes; expected_counts = $capture.expected_counts; observed_counts = $capture.observed_counts; records = $recordBytes; final_capture_record = 'tests/tools/task_0024ac_final_case_01_capture_validation.json'; final_capture_sha256 = Sha 'tests/tools/task_0024ac_final_case_01_capture_validation.json'; negative_qualification = Read-Json 'tests/tools/task_0024ac_capture_parser_requalification.json' }
    authoring_history = $authoring
    final_qualification = [ordered]@{ invocation_id = $invocation.invocation_id; started_utc = $invocation.started_utc; completed_utc = $progress.completed_utc; manifest = 'tests/tools/task_0024ac_final_cycle_manifest.json'; manifest_sha256 = Sha 'tests/tools/task_0024ac_final_cycle_manifest.json'; invocation_record_sha256 = Sha 'tests/tools/task_0024ac_final_cycle_invocation.json'; progress_record_sha256 = Sha 'tests/tools/task_0024ac_final_cycle_progress.json'; cycle_consumed = $true; rerun_authorized = $false; case_count = $caseSummaries.Count; cases = @($caseSummaries); final_godot_process_count = $progress.final_godot_count; status = 'PASS' }
    frozen_hash_audit = [ordered]@{
        seal_sha256 = $postFinal.seal_sha256
        repository_file_count = $postFinal.repository_file_count
        historical_external_evidence_file_count = $postFinal.historical_external_evidence_file_count
        historical_0024aa_path_count = $postFinal.historical_0024aa_path_count
        historical_0024ab_path_count = $postFinal.historical_0024ab_path_count
        pre_task = [ordered]@{ status = $preTask.status; repository_mismatch_count = $preTask.repository_mismatch_count; external_mismatch_count = $preTask.historical_external_evidence_mismatch_count; fixed_accepted_mismatch_count = $preTask.fixed_accepted_mismatch_count; historical_0024aa_mismatch_count = $preTask.historical_0024aa_mismatch_count; historical_0024ab_mismatch_count = $preTask.historical_0024ab_mismatch_count }
        pre_final = [ordered]@{ status = $preFinal.status; repository_mismatch_count = $preFinal.repository_mismatch_count; external_mismatch_count = $preFinal.historical_external_evidence_mismatch_count; fixed_accepted_mismatch_count = $preFinal.fixed_accepted_mismatch_count; historical_0024aa_mismatch_count = $preFinal.historical_0024aa_mismatch_count; historical_0024ab_mismatch_count = $preFinal.historical_0024ab_mismatch_count }
        post_final = [ordered]@{ status = $postFinal.status; repository_mismatch_count = $postFinal.repository_mismatch_count; external_mismatch_count = $postFinal.historical_external_evidence_mismatch_count; fixed_accepted_mismatch_count = $postFinal.fixed_accepted_mismatch_count; historical_0024aa_mismatch_count = $postFinal.historical_0024aa_mismatch_count; historical_0024ab_mismatch_count = $postFinal.historical_0024ab_mismatch_count }
    }
    owner_playthrough_status = 'PENDING_LATER_CURRICULUM_GATE'
    catalog_admission_status = 'NOT_AUTHORIZED'
    profile_accessed = $false
}
[IO.File]::WriteAllText($output, ($result | ConvertTo-Json -Depth 100) + "`n", [Text.UTF8Encoding]::new($false))
Write-Output ("TASK_0024AC_SUMMARY_WRITTEN " + $output)

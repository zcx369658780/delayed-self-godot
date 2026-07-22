[CmdletBinding()]
param([Parameter(Mandatory)][string]$OutputPath)

$ErrorActionPreference = 'Stop'
$root = 'D:\Delayed_Self'
$capturePath = Join-Path $root 'tests\tools\task_0024ab_final_case_01_capture_validation.json'
$capture = Get-Content -LiteralPath $capturePath -Raw | ConvertFrom-Json -Depth 100
$equivalence = Get-Content -LiteralPath (Join-Path $root 'tests\tools\task_0024ab_static_equivalence_attempt_03_pre_final.json') -Raw | ConvertFrom-Json -Depth 100
$preAudit = Get-Content -LiteralPath (Join-Path $root 'tests\tools\task_0024ab_pre_task_frozen_hash_audit.json') -Raw | ConvertFrom-Json -Depth 100
$preFinalAudit = Get-Content -LiteralPath (Join-Path $root 'tests\tools\task_0024ab_pre_final_frozen_hash_audit.json') -Raw | ConvertFrom-Json -Depth 100
$postAudit = Get-Content -LiteralPath (Join-Path $root 'tests\tools\task_0024ab_post_final_frozen_hash_audit.json') -Raw | ConvertFrom-Json -Depth 100
$parserQualification = Get-Content -LiteralPath (Join-Path $root 'tests\tools\task_0024ab_capture_parser_qualification.json') -Raw | ConvertFrom-Json -Depth 100

function Get-Payload([string]$Prefix) {
    $matches = @($capture.records | Where-Object { $_.prefix -eq $Prefix })
    if ($Prefix -eq 'TASK_0024AB_EVENT_JSON') { return @($matches | ForEach-Object { $_.payload }) }
    if ($matches.Count -ne 1) { throw "Expected one payload for $Prefix, observed $($matches.Count)" }
    return $matches[0].payload
}

$metrics = Get-Payload 'TASK_0024AB_METRICS_JSON'
$witness = Get-Payload 'TASK_0024AB_WITNESS_JSON'
$events = @(Get-Payload 'TASK_0024AB_EVENT_JSON')
$allShortest = Get-Payload 'TASK_0024AB_ALL_SHORTEST_JSON'
$identityControls = Get-Payload 'TASK_0024AB_CONTROL_IDENTITY_JSON'
$geometryControls = Get-Payload 'TASK_0024AB_CONTROL_GEOMETRY_JSON'
$shortcuts = Get-Payload 'TASK_0024AB_SHORTCUTS_JSON'
$replayRestart = Get-Payload 'TASK_0024AB_REPLAY_RESTART_JSON'

if ($capture.status -ne 'PASS' -or $equivalence.status -ne 'PASS' -or $preAudit.status -ne 'PASS' -or $preFinalAudit.status -ne 'PASS' -or $postAudit.status -ne 'PASS' -or $parserQualification.status -ne 'PASS') { throw 'Required qualification/audit status not PASS' }
if (($metrics.elapsed_ms -isnot [int]) -and ($metrics.elapsed_ms -isnot [long])) { throw 'Fresh elapsed_ms is not integer' }

$casePaths = @(
    'tests/tools/task_0024ab_final_case_01_identity_shift_bridge.json',
    'tests/tools/task_0024ab_final_case_02_sequence_10.json',
    'tests/tools/task_0024ab_final_case_03_sequence_09.json',
    'tests/tools/task_0024ab_final_case_04_aggregate.json',
    'tests/tools/task_0024ab_final_case_05_v2_complete.json'
)
$cases = [Collections.Generic.List[object]]::new()
for ($index = 0; $index -lt $casePaths.Count; $index++) {
    $relative = $casePaths[$index]
    $path = Join-Path $root $relative
    $record = Get-Content -LiteralPath $path -Raw | ConvertFrom-Json -Depth 100
    $expectedStderr = if ($index -eq 3) { @('LEVEL_ID_MISMATCH') } else { @() }
    $stderrExact = (@($record.stderr) -join "`n") -ceq ($expectedStderr -join "`n")
    $valid = $record.status -eq 'PASS' -and $record.native_exit_code -eq 0 -and $record.required_marker_count -eq 1 -and $record.cleanup_invocation_count -eq 1 -and $record.godot_before_count -eq 0 -and $record.godot_after_count -eq 0 -and @($record.remaining_owned_pids).Count -eq 0 -and @($record.remaining_unproven_pids).Count -eq 0 -and $stderrExact
    if (-not $valid) { throw "Final case invalid: $relative" }
    $cases.Add([ordered]@{
        case = $index + 1
        script = $record.case_script_path
        required_marker = $record.required_marker
        required_marker_count = $record.required_marker_count
        record = $relative
        record_sha256 = (Get-FileHash -LiteralPath $path -Algorithm SHA256).Hash.ToLowerInvariant()
        wrapper_status = $record.status
        native_exit_code = $record.native_exit_code
        stderr = @($record.stderr)
        cleanup_invocation_count = $record.cleanup_invocation_count
        cleanup_order = @($record.cleanup_order)
        cleanup_closed_pids = @($record.cleanup_closed_pids)
        godot_before_count = $record.godot_before_count
        godot_after_count = $record.godot_after_count
        remaining_owned_pids = @($record.remaining_owned_pids)
        remaining_unproven_pids = @($record.remaining_unproven_pids)
        owned_records = @($record.owned_records)
    })
}

$qualificationCase1 = Get-Content -LiteralPath (Join-Path $root 'tests\tools\task_0024ab_qualification_case_01.json') -Raw | ConvertFrom-Json -Depth 100
$qualificationCapture1 = Get-Content -LiteralPath (Join-Path $root 'tests\tools\task_0024ab_qualification_capture_01.json') -Raw | ConvertFrom-Json -Depth 100
$qualificationCapture2 = Get-Content -LiteralPath (Join-Path $root 'tests\tools\task_0024ab_qualification_capture_02.json') -Raw | ConvertFrom-Json -Depth 100
$qualificationCase2 = Get-Content -LiteralPath (Join-Path $root 'tests\tools\task_0024ab_qualification_case_02.json') -Raw | ConvertFrom-Json -Depth 100
$qualificationCapture3 = Get-Content -LiteralPath (Join-Path $root 'tests\tools\task_0024ab_qualification_capture_03.json') -Raw | ConvertFrom-Json -Depth 100

$summary = [ordered]@{
    schema_version = 1
    task_id = '0024AB'
    validation_status = 'SEQUENCE_11_IDENTITY_SHIFT_BRIDGE_CORRECTED_MACHINE_VALIDATED_FOR_GPT_REVIEW'
    repository = [ordered]@{
        root = 'D:\Delayed_Self'
        branch = 'main'
        validation_baseline_commit = '8fd4be3661213ad2a3c8b6b1117c246fea484b44'
        required_accepted_checkpoint = 'b426148b95775e8acf8a7cc92796d4678415da3a'
        blocked_0024aa_result_commit = 'e2938b61a6207e970302675db8bb454c08c40cd3'
        godot_version = '4.7.1.stable.steam.a13da4feb'
        accepted_wrapper_blob = '5f14eb0feff903b40311c1c7283b20e2eabbffc2'
    }
    frozen_candidate = [ordered]@{ path = 'data/levels/identity_shift_bridge.json'; sha256 = (Get-FileHash -LiteralPath (Join-Path $root 'data\levels\identity_shift_bridge.json') -Algorithm SHA256).Hash.ToLowerInvariant(); unchanged = $true; classification = 'UNCATALOGUED_SEQUENCE_11_FROZEN_FALLBACK_CANDIDATE' }
    historical_0024aa = [ordered]@{ validator_sha256 = (Get-FileHash -LiteralPath (Join-Path $root 'tests\levels\task_0024aa_identity_shift_bridge_validation.gd') -Algorithm SHA256).Hash.ToLowerInvariant(); retained_cycle_consumed = $true; reused_as_final_evidence = $false; blocker_accepted = $true; historical_path_count = $postAudit.historical_path_count; historical_mismatch_count = $postAudit.historical_mismatch_count }
    replacement_validator = [ordered]@{ path = 'tests/levels/task_0024ab_identity_shift_bridge_validation.gd'; sha256 = (Get-FileHash -LiteralPath (Join-Path $root 'tests\levels\task_0024ab_identity_shift_bridge_validation.gd') -Algorithm SHA256).Hash.ToLowerInvariant(); public_loader = $true; shared_simulation = $true; accepted_bfs_solver = $true }
    static_equivalence = [ordered]@{ status = $equivalence.status; historical_commit = $equivalence.historical_commit; semantic_function_count = $equivalence.semantic_function_count; semantic_function_mismatches = @($equivalence.semantic_function_mismatches); assertion_label_count = $equivalence.assertion_label_count; assertion_labels_exact = $equivalence.assertion_labels_exact; constant_checks = $equivalence.constant_checks; init_checks = $equivalence.init_checks; historical_path_count = $equivalence.historical_path_count; historical_mismatches = @($equivalence.historical_mismatches); dynamic_head_baseline_absent = $equivalence.dynamic_head_baseline_absent }
    bounded_output = [ordered]@{ status = $capture.status; record_count = $capture.record_count; expected_counts = $capture.expected_counts; observed_counts = $capture.observed_counts; records = @($capture.records | ForEach-Object { [ordered]@{ prefix = $_.prefix; utf8_bytes = $_.utf8_bytes } }); maximum_utf8_bytes = ($capture.records.utf8_bytes | Measure-Object -Maximum).Maximum; strict_limit_bytes = 1800; parser_negative_qualification = $parserQualification }
    solver = $metrics
    witness = $witness
    ordered_events = $events
    all_shortest = $allShortest
    controls = [ordered]@{ identity = $identityControls; geometry = $geometryControls }
    shortcuts = $shortcuts
    replay_restart_canonical = $replayRestart
    pre_final_qualification_history = @(
        [ordered]@{ step = 'static_equivalence_attempt_01'; status = 'FAIL'; reason = 'self_scan_literal_false_positive'; godot_launched = $false },
        [ordered]@{ step = 'static_equivalence_attempt_02'; status = 'PASS'; godot_launched = $false },
        [ordered]@{ step = 'focused_qualification_01'; status = $qualificationCase1.status; cleanup = $qualificationCase1.cleanup_invocation_count; godot_after = 0 },
        [ordered]@{ step = 'capture_validation_01'; status = $qualificationCapture1.status; reason = 'event_set_parser_precedence_defect' },
        [ordered]@{ step = 'capture_validation_02_same_record'; status = $qualificationCapture2.status; godot_reexecuted = $false },
        [ordered]@{ step = 'capture_parser_negative_qualification'; status = $parserQualification.status; probe_count = $parserQualification.probe_count },
        [ordered]@{ step = 'focused_qualification_02'; status = $qualificationCase2.status; marker_count = $qualificationCase2.required_marker_count; godot_before = $qualificationCase2.godot_before_count; godot_after = $qualificationCase2.godot_after_count },
        [ordered]@{ step = 'capture_validation_03'; status = $qualificationCapture3.status },
        [ordered]@{ step = 'pre_final_static_equivalence'; status = $equivalence.status }
    )
    frozen_audits = [ordered]@{ pre_task = $preAudit; pre_final = $preFinalAudit; post_final = $postAudit }
    final_qualification = [ordered]@{ cycle_consumed = $true; rerun_authorized = $false; cases = @($cases); final_godot_process_count = 0; status = 'PASS' }
    owner_playthrough_status = 'PENDING_LATER_CURRICULUM_GATE'
    catalog_admission_status = 'NOT_AUTHORIZED'
    profile_accessed = $false
}

$output = [IO.Path]::GetFullPath((Join-Path $root $OutputPath))
if (Test-Path -LiteralPath $output) { throw "Output already exists: $output" }
[IO.File]::WriteAllText($output, ($summary | ConvertTo-Json -Depth 100) + "`n", [Text.UTF8Encoding]::new($false))
Write-Output ("TASK_0024AB_SUMMARY_WRITTEN " + $output)

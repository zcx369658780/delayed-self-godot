[CmdletBinding()]
param()

$ErrorActionPreference = 'Stop'
$root = 'D:\Delayed_Self'
$outputPath = Join-Path $root 'docs\level_design\validation\sequence_09_crate_shadow_timing_validation.json'
if (Test-Path -LiteralPath $outputPath) {
    throw "Validation summary already exists: $outputPath"
}
$focusedPath = Join-Path $root 'tests\tools\task_0024y_final_focused.json'
$finalSummaryPath = Join-Path $root 'tests\tools\task_0024y_final_qualification_summary.json'
$preAuditPath = Join-Path $root 'tests\tools\task_0024y_pre_final_frozen_hash_audit.json'
$postAuditPath = Join-Path $root 'tests\tools\task_0024y_post_final_frozen_hash_audit.json'
$candidatePath = Join-Path $root 'data\levels\crate_shadow_timing.json'
$focused = Get-Content -LiteralPath $focusedPath -Raw | ConvertFrom-Json -Depth 100
$final = Get-Content -LiteralPath $finalSummaryPath -Raw | ConvertFrom-Json -Depth 100
$preAudit = Get-Content -LiteralPath $preAuditPath -Raw | ConvertFrom-Json -Depth 100
$postAudit = Get-Content -LiteralPath $postAuditPath -Raw | ConvertFrom-Json -Depth 100

function Parse-PrefixedJson([string]$Prefix) {
    $line = @($focused.stdout | Where-Object { $_.StartsWith($Prefix, [StringComparison]::Ordinal) })
    if ($line.Count -ne 1) {
        throw "Expected one retained line with prefix $Prefix, observed $($line.Count)"
    }
    return $line[0].Substring($Prefix.Length) | ConvertFrom-Json -Depth 100
}

$result = Parse-PrefixedJson 'TASK_0024Y_RESULT_JSON '
$controls = Parse-PrefixedJson 'TASK_0024Y_CONTROL_JSON '
$trace = @()
foreach ($line in @($focused.stdout | Where-Object { $_.StartsWith('TASK_0024Y_TRACE_EVENT_JSON ', [StringComparison]::Ordinal) })) {
    $trace += $line.Substring('TASK_0024Y_TRACE_EVENT_JSON '.Length) | ConvertFrom-Json -Depth 100
}
if ($trace.Count -ne 4) {
    throw "Expected four retained temporal trace records, observed $($trace.Count)"
}
$caseFacts = @()
foreach ($case in $final.cases) {
    $caseFacts += [ordered]@{
        name = $case.name
        script_path = $case.script_path
        record_path = $case.record_path
        record_sha256 = $case.record_sha256
        wrapper_process_exit = $case.wrapper_process_exit
        native_exit_code = $case.native_exit_code
        exact_marker_count = $case.exact_marker_count
        stderr = @($case.stderr)
        cleanup_invocation_count = $case.cleanup_invocation_count
        cleanup_order = @($case.cleanup_order)
        direct_and_descendant_ownership = @($case.direct_and_descendant_ownership)
        remaining_owned_pids = @($case.remaining_owned_pids)
        remaining_unproven_pids = @($case.remaining_unproven_pids)
        godot_count_before = $case.godot_count_before
        godot_count_after = $case.godot_count_after
        pass = $case.pass
    }
}
$summary = [ordered]@{
    schema_version = 1
    task_id = '0024Y'
    validation_status = 'SEQUENCE_9_CRATE_SHADOW_TIMING_MACHINE_VALIDATED_FOR_GPT_REVIEW'
    repository = [ordered]@{
        root = 'D:\Delayed_Self'
        branch = 'main'
        validation_baseline_commit = 'bcb46aa80d6df83716124524dacedb1ebdf6ac03'
        required_accepted_checkpoint = '3257aa8a1d677aa0596bb5edd9e8015a4c476fd1'
        accepted_foundation_result_commit = '7072566ef814f6969693bbc9335fcced5e424585'
        godot_version = '4.7.1.stable.steam.a13da4feb'
        accepted_wrapper_implementation_commit = '7c0712d6a602dc23200ccb147d0096acc6333305'
        accepted_wrapper_blob = '5f14eb0feff903b40311c1c7283b20e2eabbffc2'
    }
    candidate = [ordered]@{
        path = 'data/levels/crate_shadow_timing.json'
        sha256 = (Get-FileHash -LiteralPath $candidatePath -Algorithm SHA256).Hash.ToLowerInvariant()
        classification = 'UNCATALOGUED_SEQUENCE_9_CORE_CANDIDATE'
        identity = $result.identity
        exactly_one_crate = $true
        exactly_one_echo = $true
        exactly_one_v1_plate = $true
        exactly_one_v1_door = $true
        forbidden_family_arrays_empty = $true
    }
    limits = $result.limits
    solver = $result.solver
    witness_facts = $result.witness_facts
    required_temporal_event = [ordered]@{
        push_index = $result.witness_facts.push_index
        echo_block_index = $result.witness_facts.echo_block_index
        door_cross_index = $result.witness_facts.door_cross_index
        completion_index = $result.witness_facts.completion_index
        trace = $trace
    }
    all_shortest = $result.all_shortest
    necessity_controls = $controls
    shortcut_and_rule_probes = [ordered]@{
        no_terrain_walkaround = $controls.shortcuts.no_terrain_walkaround
        echo_contact_does_not_move_crate = $controls.shortcuts.echo_contact_does_not_move_crate
        illegal_push_stable_and_records_history = $controls.shortcuts.illegal_push_stable_and_records_history
        blocked_input_history_contract_proven_by_illegal_push_probe = $controls.shortcuts.illegal_push_stable_and_records_history
        witness_blocked_you_count = $result.witness_facts.blocked_you_count
        witness_max_repeated_identical_blocked = $result.witness_facts.max_repeated_identical_blocked
        echo_on_exit_nonterminal = $controls.shortcuts.echo_on_exit_nonterminal
        you_requires_echo_held_door = $controls.shortcuts.you_requires_echo_held_door
        restart_zero_residue = $controls.shortcuts.restart_zero_residue
    }
    replay = $result.replay
    restart = $result.restart
    canonical_crate_distinct = $result.canonical_crate_distinct
    final_qualification = [ordered]@{
        invocation_id = $final.invocation_id
        started_utc = $final.started_utc
        completed_utc = $final.completed_utc
        case_count = $final.case_count
        cases = $caseFacts
        final_godot_count = $final.final_godot_count
        status = $final.status
        summary_path = 'tests/tools/task_0024y_final_qualification_summary.json'
        summary_sha256 = (Get-FileHash -LiteralPath $finalSummaryPath -Algorithm SHA256).Hash.ToLowerInvariant()
    }
    frozen_hash_audit = [ordered]@{
        seal_sha256 = $preAudit.seal_sha256
        repository_file_count = $preAudit.repository_file_count
        historical_external_evidence_file_count = $preAudit.historical_external_evidence_file_count
        pre_final_status = $preAudit.status
        pre_final_repository_mismatch_count = $preAudit.repository_mismatch_count
        pre_final_external_mismatch_count = $preAudit.historical_external_evidence_mismatch_count
        post_final_status = $postAudit.status
        post_final_repository_mismatch_count = $postAudit.repository_mismatch_count
        post_final_external_mismatch_count = $postAudit.historical_external_evidence_mismatch_count
    }
    owner_playthrough_status = 'PENDING_LATER_CURRICULUM_GATE'
    catalog_admission_status = 'NOT_AUTHORIZED'
    profile_accessed = $false
}
$utf8NoBom = [Text.UTF8Encoding]::new($false)
[IO.File]::WriteAllText($outputPath, ($summary | ConvertTo-Json -Depth 40) + "`n", $utf8NoBom)
Write-Output ("TASK_0024Y_VALIDATION_SUMMARY_WRITTEN " + $outputPath)

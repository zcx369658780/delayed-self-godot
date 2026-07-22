[CmdletBinding()]
param()

$ErrorActionPreference = 'Stop'
$root = 'D:\Delayed_Self'
$focusedPath = Join-Path $root 'tests\tools\task_0024z_final_focused.json'
$qualificationPath = Join-Path $root 'tests\tools\task_0024z_final_qualification_summary.json'
$preAuditPath = Join-Path $root 'tests\tools\task_0024z_pre_final_frozen_hash_audit.json'
$postAuditPath = Join-Path $root 'tests\tools\task_0024z_post_final_frozen_hash_audit.json'
$outputPath = Join-Path $root 'docs\level_design\validation\sequence_10_key_route_commitment_validation.json'
if (Test-Path -LiteralPath $outputPath) { throw "Summary already exists: $outputPath" }

$focused = Get-Content -LiteralPath $focusedPath -Raw | ConvertFrom-Json -Depth 100
$resultLine = @($focused.stdout | Where-Object { $_ -like 'TASK_0024Z_RESULT_JSON *' })
$controlLine = @($focused.stdout | Where-Object { $_ -like 'TASK_0024Z_CONTROL_JSON *' })
$traceLines = @($focused.stdout | Where-Object { $_ -like 'TASK_0024Z_TRACE_EVENT_JSON *' })
if ($resultLine.Count -ne 1 -or $controlLine.Count -ne 1 -or $traceLines.Count -ne 6) { throw 'Unexpected retained focused payload cardinality' }
$result = $resultLine[0].Substring('TASK_0024Z_RESULT_JSON '.Length) | ConvertFrom-Json -Depth 100
$controls = $controlLine[0].Substring('TASK_0024Z_CONTROL_JSON '.Length) | ConvertFrom-Json -Depth 100
$trace = @($traceLines | ForEach-Object { $_.Substring('TASK_0024Z_TRACE_EVENT_JSON '.Length) | ConvertFrom-Json -Depth 100 })
$qualification = Get-Content -LiteralPath $qualificationPath -Raw | ConvertFrom-Json -Depth 100
$preAudit = Get-Content -LiteralPath $preAuditPath -Raw | ConvertFrom-Json -Depth 100
$postAudit = Get-Content -LiteralPath $postAuditPath -Raw | ConvertFrom-Json -Depth 100

$summary = [ordered]@{
    schema_version = 1
    task_id = '0024Z'
    validation_status = 'SEQUENCE_10_KEY_ROUTE_COMMITMENT_MACHINE_VALIDATED_FOR_GPT_REVIEW'
    repository = [ordered]@{
        root = 'D:\Delayed_Self'
        branch = 'main'
        validation_baseline_commit = '5180dcacdf29336cde6248f7536f081b88510d9a'
        required_accepted_checkpoint = '19a068334b583a1e72180d5c609fed4bf2c94e50'
        accepted_sequence_9_result_commit = '445122ab035a4c9210f3280af58d054a35bef2bd'
        accepted_foundation_result_commit = '7072566ef814f6969693bbc9335fcced5e424585'
        godot_version = '4.7.1.stable.steam.a13da4feb'
        accepted_wrapper_implementation_commit = '7c0712d6a602dc23200ccb147d0096acc6333305'
        accepted_wrapper_blob = '5f14eb0feff903b40311c1c7283b20e2eabbffc2'
    }
    candidate = [ordered]@{
        path = 'data/levels/key_route_commitment.json'
        sha256 = (Get-FileHash -LiteralPath (Join-Path $root 'data\levels\key_route_commitment.json') -Algorithm SHA256).Hash.ToLowerInvariant()
        classification = 'UNCATALOGUED_SEQUENCE_10_CORE_CANDIDATE'
        identity = $result.identity
        exactly_one_main_key = $true
        exactly_one_matching_main_lock = $true
        exactly_one_echo = $true
        exactly_one_v1_plate = $true
        exactly_one_initially_closed_v1_door = $true
        forbidden_family_arrays_empty = $true
    }
    limits = $result.limits
    solver = $result.solver
    witness_facts = $result.witness
    required_temporal_event = [ordered]@{ trace = $trace }
    all_shortest = $result.all_shortest
    necessity_controls = $controls
    echo_item_route_control = $result.echo_item_probes
    shortcut_and_rule_probes = $result.shortcuts
    replay = $result.replay
    restart = $result.restart
    canonical_remaining_held_removed_distinct = $result.canonical_distinct
    final_qualification = [ordered]@{
        invocation_id = $qualification.invocation_id
        started_utc = $qualification.started_utc
        completed_utc = $qualification.completed_utc
        case_count = $qualification.case_count
        cases = $qualification.cases
        final_godot_count = $qualification.final_godot_count
        status = $qualification.status
        summary_path = 'tests/tools/task_0024z_final_qualification_summary.json'
        summary_sha256 = (Get-FileHash -LiteralPath $qualificationPath -Algorithm SHA256).Hash.ToLowerInvariant()
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
[IO.File]::WriteAllText($outputPath, ($summary | ConvertTo-Json -Depth 100) + "`n", $utf8NoBom)
Write-Output ("TASK_0024Z_VALIDATION_SUMMARY_WRITTEN " + $outputPath)

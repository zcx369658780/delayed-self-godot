[CmdletBinding()]
param(
    [Parameter(Mandatory)][string]$RecordPath,
    [Parameter(Mandatory)][string]$OutputPath,
    [ValidateSet('QUALIFICATION','FINAL')][string]$Phase = 'QUALIFICATION'
)

$ErrorActionPreference = 'Stop'
$root = 'D:\Delayed_Self'
$recordFile = [IO.Path]::GetFullPath((Join-Path $root $RecordPath))
$outputFile = [IO.Path]::GetFullPath((Join-Path $root $OutputPath))
if (Test-Path -LiteralPath $outputFile) { throw "Output already exists: $outputFile" }
$record = Get-Content -LiteralPath $recordFile -Raw | ConvertFrom-Json -Depth 100
$expected = [ordered]@{ TASK_0024AD_MANIFEST_JSON=12; TASK_0024AD_METRICS_JSON=12; TASK_0024AD_REPLAY_JSON=12; TASK_0024AD_CATALOG_JSON=1; TASK_0024AD_BATCH_JSON=1 }
$errors = [Collections.Generic.List[string]]::new(); $retained = [Collections.Generic.List[object]]::new(); $payloads = [ordered]@{}
foreach ($prefix in $expected.Keys) { $payloads[$prefix] = [Collections.Generic.List[object]]::new() }
foreach ($line in @($record.stdout)) {
    foreach ($prefix in $expected.Keys) {
        $leader = $prefix + ' '
        if (-not ([string]$line).StartsWith($leader, [StringComparison]::Ordinal)) { continue }
        $bytes = [Text.Encoding]::UTF8.GetByteCount([string]$line)
        if ($bytes -ge 1800) { $errors.Add("over_bound:$prefix`:$bytes") }
        $json = ([string]$line).Substring($leader.Length)
        try { $payload = $json | ConvertFrom-Json -Depth 100 } catch { $errors.Add("non_json_or_truncated:$prefix"); $payload = $null }
        if ($null -ne $payload) { $payloads[$prefix].Add($payload) }
        $retained.Add([ordered]@{ prefix=$prefix; utf8_bytes=$bytes; raw_line=[string]$line; payload=$payload })
        break
    }
}
foreach ($prefix in $expected.Keys) { if ($payloads[$prefix].Count -ne $expected[$prefix]) { $errors.Add("count:$prefix`:$($payloads[$prefix].Count)/$($expected[$prefix])") } }
$maximumBytes = 0; foreach ($item in $retained) { $maximumBytes = [Math]::Max($maximumBytes, [int]$item['utf8_bytes']) }
$markerCount = @($record.stdout | Where-Object { $_ -ceq 'TASK_0024AD_SUBMISSION_CORE_1_12_BATCH_PASS' }).Count
if ($markerCount -ne 1) { $errors.Add("marker_count:$markerCount") }
if (-not $record.marker_pass -or $record.native_exit_code -ne 0 -or $record.status -ne 'PASS') { $errors.Add('wrapper_or_native_status') }
if (@($record.stderr).Count -ne 0) { $errors.Add('stderr_nonempty') }
if ($record.cleanup_invocation_count -ne 1) { $errors.Add('cleanup_count') }
if (@($record.remaining_owned_pids).Count -ne 0 -or @($record.remaining_unproven_pids).Count -ne 0) { $errors.Add('pid_residue') }
if ($record.godot_before_count -ne 0 -or $record.godot_after_count -ne 0) { $errors.Add('godot_boundary') }
$expectedMetrics = @('3/3','9/12','9/31','9/7','12/1','15/4','16/12','19/6','14/6','19/8','18/1','21/6')
if ($payloads.TASK_0024AD_METRICS_JSON.Count -eq 12) {
    for ($index=0; $index -lt 12; $index++) {
        $item = $payloads.TASK_0024AD_METRICS_JSON[$index]; $solver = $item.solver
        $integerElapsed = $solver.elapsed_ms -is [int] -or $solver.elapsed_ms -is [long]
        if ($item.sequence -ne $index+1 -or ("$($solver.l)/$($solver.n)") -ne $expectedMetrics[$index] -or $solver.n_status -ne 'EXACT' -or -not $integerElapsed -or $solver.elapsed_ms -lt 0 -or $solver.elapsed_ms -gt $solver.limits.time_limit_ms) { $errors.Add("metrics_contract:$($index+1)") }
    }
}
if ($payloads.TASK_0024AD_MANIFEST_JSON.Count -eq 12) {
    $ids = @($payloads.TASK_0024AD_MANIFEST_JSON | ForEach-Object { $_.level_id })
    if (@($ids | Sort-Object -Unique).Count -ne 12) { $errors.Add('manifest_unique') }
}
if ($payloads.TASK_0024AD_REPLAY_JSON.Count -eq 12) {
    foreach ($item in $payloads.TASK_0024AD_REPLAY_JSON) { if (-not $item.replay.completed -or -not $item.replay.deterministic -or -not $item.restart_exact -or -not $item.you_only_exit) { $errors.Add("replay:$($item.sequence)") } }
}
if ($payloads.TASK_0024AD_CATALOG_JSON.Count -eq 1) {
    $catalog=$payloads.TASK_0024AD_CATALOG_JSON[0]; if ($catalog.entry_count -ne 8 -or $catalog.ordered_ids.Count -ne 8 -or $catalog.candidate_ids_absent.Count -ne 4 -or $catalog.sole_finale -ne 'two_echo_convergence') { $errors.Add('catalog_contract') }
}
if ($payloads.TASK_0024AD_BATCH_JSON.Count -eq 1) {
    $batch=$payloads.TASK_0024AD_BATCH_JSON[0]; if ($batch.status -ne 'PASS' -or $batch.level_count -ne 12 -or $batch.solved_count -ne 12 -or $batch.exact_count -ne 12) { $errors.Add('batch_contract') }
}
$result=[ordered]@{ schema_version=1; task='0024AD'; phase=$Phase; status=if($errors.Count -eq 0){'PASS'}else{'FAIL'}; source_record=$RecordPath.Replace('\','/'); source_record_sha256=(Get-FileHash -LiteralPath $recordFile -Algorithm SHA256).Hash.ToLowerInvariant(); expected_counts=$expected; observed_counts=[ordered]@{}; marker_count=$markerCount; record_count=$retained.Count; maximum_utf8_bytes=$maximumBytes; records=@($retained); wrapper=[ordered]@{status=$record.status;native_exit_code=$record.native_exit_code;cleanup_invocation_count=$record.cleanup_invocation_count;cleanup_order=@($record.cleanup_order);remaining_owned_pids=@($record.remaining_owned_pids);remaining_unproven_pids=@($record.remaining_unproven_pids);godot_before_count=$record.godot_before_count;godot_after_count=$record.godot_after_count;stderr=@($record.stderr)}; errors=@($errors) }
foreach ($prefix in $expected.Keys) { $result.observed_counts[$prefix]=$payloads[$prefix].Count }
[IO.File]::WriteAllText($outputFile, ($result|ConvertTo-Json -Depth 100)+"`n", [Text.UTF8Encoding]::new($false))
Write-Output ("TASK_0024AD_CAPTURE_"+$result.status+" "+$outputFile)
if ($errors.Count -ne 0) { exit 1 }

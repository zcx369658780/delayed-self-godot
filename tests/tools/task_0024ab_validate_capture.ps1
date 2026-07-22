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
$expected = [ordered]@{
    TASK_0024AB_METRICS_JSON = 1
    TASK_0024AB_WITNESS_JSON = 1
    TASK_0024AB_EVENT_JSON = 6
    TASK_0024AB_ALL_SHORTEST_JSON = 1
    TASK_0024AB_CONTROL_IDENTITY_JSON = 1
    TASK_0024AB_CONTROL_GEOMETRY_JSON = 1
    TASK_0024AB_SHORTCUTS_JSON = 1
    TASK_0024AB_REPLAY_RESTART_JSON = 1
}
$errors = [Collections.Generic.List[string]]::new()
$retained = [Collections.Generic.List[object]]::new()
$payloads = [ordered]@{}
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
        $retained.Add([ordered]@{ prefix = $prefix; utf8_bytes = $bytes; raw_line = [string]$line; payload = $payload })
        break
    }
}

foreach ($prefix in $expected.Keys) {
    $actual = $payloads[$prefix].Count
    if ($actual -ne $expected[$prefix]) { $errors.Add("count:$prefix`:$actual/$($expected[$prefix])") }
}
$markerCount = @($record.stdout | Where-Object { $_ -ceq 'TASK_0024AB_IDENTITY_SHIFT_BRIDGE_PASS' }).Count
if ($markerCount -ne 1) { $errors.Add("marker_count:$markerCount") }
if (-not $record.marker_pass -or $record.native_exit_code -ne 0 -or $record.status -ne 'PASS') { $errors.Add('wrapper_or_native_status') }
if (@($record.stderr).Count -ne 0) { $errors.Add('stderr_nonempty') }
if ($record.cleanup_invocation_count -ne 1) { $errors.Add('cleanup_count') }
if (@($record.remaining_owned_pids).Count -ne 0 -or @($record.remaining_unproven_pids).Count -ne 0) { $errors.Add('pid_residue') }

if ($payloads.TASK_0024AB_METRICS_JSON.Count -eq 1) {
    $metrics = $payloads.TASK_0024AB_METRICS_JSON[0]
    $integerElapsed = $metrics.elapsed_ms -is [int] -or $metrics.elapsed_ms -is [long]
    if (-not $integerElapsed -or $metrics.elapsed_ms -lt 0 -or $metrics.elapsed_ms -gt 35000) { $errors.Add('elapsed_ms') }
    if ($metrics.status -ne 'SOLVED' -or $metrics.shortest_turn_count -lt 18 -or $metrics.shortest_turn_count -gt 23 -or $metrics.shortest_solution_count_status -ne 'EXACT' -or $metrics.shortest_solution_count -lt 1 -or $metrics.shortest_solution_count -gt 8) { $errors.Add('metrics_contract') }
}
if ($payloads.TASK_0024AB_EVENT_JSON.Count -eq 6) {
    $events = @($payloads.TASK_0024AB_EVENT_JSON | ForEach-Object { $_.event })
    $requiredEvents = @('TYPED_PAIR_OPENS_NEXT_STATE','NEXT_OPEN_SNAPSHOT_FIRST_CELL_ENTRY','FIRST_CELL_OCCUPIED_CLOSE_DEFERRAL','SECOND_CELL_OCCUPIED_CLOSE_DEFERRAL','GROUP_VACATED_AND_CLOSED','YOU_EXIT_COMPLETION')
    $actualEventSet = (($events | Sort-Object) -join '|')
    $requiredEventSet = (($requiredEvents | Sort-Object) -join '|')
    if ($actualEventSet -cne $requiredEventSet) { $errors.Add('event_set') }
}
if ($payloads.TASK_0024AB_ALL_SHORTEST_JSON.Count -eq 1) {
    $all = $payloads.TASK_0024AB_ALL_SHORTEST_JSON[0]
    if ($all.status -ne 'COMPLETE' -or $all.total_completed_paths -ne $all.full_event_paths -or $all.omitting_event_paths -ne 0 -or $all.two_cell_cross_paths -ne $all.total_completed_paths) { $errors.Add('all_shortest_contract') }
}
if ($payloads.TASK_0024AB_CONTROL_IDENTITY_JSON.Count -eq 1) {
    $control = $payloads.TASK_0024AB_CONTROL_IDENTITY_JSON[0]
    if (-not $control.no_echo.complete_finite_state -or -not $control.swapped_identity.complete_finite_state -or -not $control.you_sensor_any.solution_structure_changed -or -not $control.echo_sensor_any.solution_structure_changed) { $errors.Add('identity_controls') }
}
if ($payloads.TASK_0024AB_CONTROL_GEOMETRY_JSON.Count -eq 1) {
    $control = $payloads.TASK_0024AB_CONTROL_GEOMETRY_JSON[0]
    if (-not $control.one_cell_group.metrics_changed -or -not $control.one_cell_group.two_cell_chain_eliminated -or $control.no_deferral.status -ne 'UNSOLVABLE_WITHIN_COMPLETE_FINITE_STATE') { $errors.Add('geometry_controls') }
}
if ($payloads.TASK_0024AB_SHORTCUTS_JSON.Count -eq 1) {
    foreach ($property in $payloads.TASK_0024AB_SHORTCUTS_JSON[0].PSObject.Properties) { if ($property.Value -ne $true) { $errors.Add("shortcut:$($property.Name)") } }
}
if ($payloads.TASK_0024AB_REPLAY_RESTART_JSON.Count -eq 1) {
    $rr = $payloads.TASK_0024AB_REPLAY_RESTART_JSON[0]
    if (-not $rr.replay.deterministic -or -not $rr.replay.completed -or -not $rr.restart.exact -or -not $rr.canonical_barrier_actor_history_distinct) { $errors.Add('replay_restart') }
}

$result = [ordered]@{
    schema_version = 1
    task = '0024AB'
    phase = $Phase
    status = if ($errors.Count -eq 0) { 'PASS' } else { 'FAIL' }
    source_record = $RecordPath.Replace('\','/')
    source_record_sha256 = (Get-FileHash -LiteralPath $recordFile -Algorithm SHA256).Hash.ToLowerInvariant()
    expected_counts = $expected
    observed_counts = [ordered]@{}
    marker_count = $markerCount
    record_count = $retained.Count
    records = @($retained)
    wrapper = [ordered]@{ status = $record.status; native_exit_code = $record.native_exit_code; cleanup_invocation_count = $record.cleanup_invocation_count; cleanup_order = @($record.cleanup_order); remaining_owned_pids = @($record.remaining_owned_pids); remaining_unproven_pids = @($record.remaining_unproven_pids); stderr = @($record.stderr) }
    errors = @($errors)
}
foreach ($prefix in $expected.Keys) { $result.observed_counts[$prefix] = $payloads[$prefix].Count }
[IO.File]::WriteAllText($outputFile, ($result | ConvertTo-Json -Depth 100) + "`n", [Text.UTF8Encoding]::new($false))
Write-Output ("TASK_0024AB_CAPTURE_" + $result.status + " " + $outputFile)
if ($errors.Count -ne 0) { exit 1 }

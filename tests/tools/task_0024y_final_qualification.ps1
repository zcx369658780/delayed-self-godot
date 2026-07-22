[CmdletBinding()]
param()

$ErrorActionPreference = 'Stop'
$projectRoot = 'D:\Delayed_Self'
$runner = Join-Path $projectRoot 'tests\tools\task_0024y_run_case.ps1'
$summaryPath = Join-Path $projectRoot 'tests\tools\task_0024y_final_qualification_summary.json'
$caseSpecs = @(
    [ordered]@{ name = 'focused_0024y'; script = 'res://tests/levels/task_0024y_crate_shadow_timing_validation.gd'; marker = 'TASK_0024Y_CRATE_SHADOW_TIMING_PASS'; stderr_policy = 'ForbidNonempty'; output = 'tests\tools\task_0024y_final_focused.json'; expected_stderr = @() },
    [ordered]@{ name = 'aggregate'; script = 'res://tests/run_all.gd'; marker = 'TASK_0003_TESTS_PASS assertions=621 vectors=9'; stderr_policy = 'Allow'; output = 'tests\tools\task_0024y_final_aggregate.json'; expected_stderr = @('LEVEL_ID_MISMATCH') },
    [ordered]@{ name = 'complete_v2'; script = 'res://tests/simulation/task_0024v_v2_solver_replay_canonical_malformed.gd'; marker = 'TASK_0024V_V2_COMPLETE_PASS'; stderr_policy = 'ForbidNonempty'; output = 'tests\tools\task_0024y_final_complete_v2.json'; expected_stderr = @() }
)

function Get-GodotCount {
    return @(Get-Process -Name 'Godot*' -ErrorAction SilentlyContinue).Count
}

if ((Get-GodotCount) -ne 0) {
    throw 'Final qualification requires zero pre-existing Godot processes'
}
if (Test-Path -LiteralPath $summaryPath) {
    throw "Final qualification summary already exists: $summaryPath"
}
foreach ($spec in $caseSpecs) {
    $resolved = Join-Path $projectRoot $spec.output
    if (Test-Path -LiteralPath $resolved) {
        throw "Final qualification case record already exists: $resolved"
    }
}

$invocationId = [Guid]::NewGuid().ToString()
$startedUtc = [DateTime]::UtcNow.ToString('o')
$caseResults = [Collections.Generic.List[object]]::new()
$overallPass = $true
foreach ($spec in $caseSpecs) {
    $godotBefore = Get-GodotCount
    & pwsh -NoProfile -File $runner -ScriptPath $spec.script -RequiredMarker $spec.marker -OutputPath $spec.output -StderrPolicy $spec.stderr_policy -TimeoutSeconds 120
    $runnerExit = $LASTEXITCODE
    $resolved = Join-Path $projectRoot $spec.output
    $record = Get-Content -LiteralPath $resolved -Raw | ConvertFrom-Json -Depth 100
    $godotAfter = Get-GodotCount
    $markerCount = @($record.stdout | Where-Object { $_ -ceq $spec.marker }).Count
    $actualStderr = @($record.stderr)
    $stderrExact = $actualStderr.Count -eq $spec.expected_stderr.Count
    if ($stderrExact) {
        for ($index = 0; $index -lt $actualStderr.Count; $index++) {
            if ([string]$actualStderr[$index] -cne [string]$spec.expected_stderr[$index]) {
                $stderrExact = $false
                break
            }
        }
    }
    $casePass = $runnerExit -eq 0 -and $record.status -eq 'PASS' -and $record.native_exit_code -eq 0 -and $markerCount -eq 1 -and $stderrExact -and $record.cleanup_invocation_count -eq 1 -and @($record.remaining_owned_pids).Count -eq 0 -and @($record.remaining_unproven_pids).Count -eq 0 -and $godotBefore -eq 0 -and $godotAfter -eq 0
    if (-not $casePass) {
        $overallPass = $false
    }
    $caseResults.Add([ordered]@{
        name = $spec.name
        script_path = $spec.script
        record_path = $spec.output.Replace('\', '/')
        record_sha256 = (Get-FileHash -LiteralPath $resolved -Algorithm SHA256).Hash.ToLowerInvariant()
        runner_exit = $runnerExit
        wrapper_process_exit = $record.wrapper_process_exit
        wrapper_status = $record.status
        native_exit_code = $record.native_exit_code
        required_marker = $spec.marker
        exact_marker_count = $markerCount
        stderr = $actualStderr
        stderr_exact = $stderrExact
        cleanup_invocation_count = $record.cleanup_invocation_count
        cleanup_order = @($record.cleanup_order)
        direct_and_descendant_ownership = @($record.owned_records)
        unproven_records = @($record.unproven_records)
        remaining_owned_pids = @($record.remaining_owned_pids)
        remaining_unproven_pids = @($record.remaining_unproven_pids)
        godot_count_before = $godotBefore
        godot_count_after = $godotAfter
        pass = $casePass
    })
}
$finalGodotCount = Get-GodotCount
if ($finalGodotCount -ne 0) {
    $overallPass = $false
}
$summary = [ordered]@{
    schema_version = 1
    task = '0024Y'
    invocation_id = $invocationId
    started_utc = $startedUtc
    completed_utc = [DateTime]::UtcNow.ToString('o')
    case_count = $caseResults.Count
    cases = @($caseResults)
    final_godot_count = $finalGodotCount
    status = if ($overallPass) { 'PASS' } else { 'FAIL' }
}
$utf8NoBom = [Text.UTF8Encoding]::new($false)
[IO.File]::WriteAllText($summaryPath, ($summary | ConvertTo-Json -Depth 30) + "`n", $utf8NoBom)
Write-Output ("TASK_0024Y_FINAL_QUALIFICATION_SUMMARY_WRITTEN " + $summaryPath)
if (-not $overallPass) {
    exit 1
}

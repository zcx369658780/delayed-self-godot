[CmdletBinding()]
param()

$ErrorActionPreference = 'Stop'
$root = (git rev-parse --show-toplevel).Trim()
$godot = 'D:\Program Files (x86)\Steam\steamapps\common\Godot Engine\godot.windows.opt.tools.64.exe'
$wrapper = Join-Path $root 'tests/tools/run_owned_godot_headless.ps1'
$cases = @(
    [ordered]@{ name = 'focused'; script = 'res://tests/presentation/task_0024af_schema_v2_minimum_visual_validation.gd'; marker = 'TASK_0024AF_SCHEMA_V2_MINIMUM_VISUAL_PASS'; stderr = 'ForbidNonempty' },
    [ordered]@{ name = 'route'; script = 'res://tests/playtest/task_0024ae_submission_core_owner_review_launcher.gd'; marker = 'TASK_0024AE_ISOLATED_STAGING_OWNER_ROUTE_PASS'; stderr = 'ForbidNonempty' },
    [ordered]@{ name = 'batch'; script = 'res://tests/curriculum/task_0024ad_submission_core_1_12_batch_validation.gd'; marker = 'TASK_0024AD_SUBMISSION_CORE_1_12_BATCH_PASS'; stderr = 'ForbidNonempty' },
    [ordered]@{ name = 'aggregate'; script = 'res://tests/run_all.gd'; marker = 'TASK_0003_TESTS_PASS assertions=621 vectors=9'; stderr = 'Allow' },
    [ordered]@{ name = 'complete_v2'; script = 'res://tests/simulation/task_0024v_v2_solver_replay_canonical_malformed.gd'; marker = 'TASK_0024V_V2_COMPLETE_PASS'; stderr = 'ForbidNonempty' }
)
$manifest = [ordered]@{ task = '0024AF_v2'; invocation = [guid]::NewGuid().ToString(); cases = $cases; consumed = $true }
$manifest | ConvertTo-Json -Depth 6 | Set-Content -LiteralPath (Join-Path $root 'tests/tools/task_0024af_final_manifest.json') -Encoding utf8
$records = @()
foreach ($case in $cases) {
	if ($case.name -eq 'route') {
		$routeOutput = 'tests/tools/task_0024af_final_case_route.json'
		& (Join-Path $root 'tests/tools/task_0024ae_owner_review_route_runner.ps1') -OutputPath $routeOutput -TimeoutSeconds 180
		$result = Get-Content -Raw -LiteralPath (Join-Path $root $routeOutput) | ConvertFrom-Json -Depth 100
	}
	else {
		$result = & $wrapper -GodotPath $godot -ProjectPath $root -ScriptPath $case.script -TimeoutSeconds 180 -GraceSeconds 3 -RequiredMarker $case.marker -StderrPolicy $case.stderr
	}
    $stderrExact = if ($case.name -eq 'aggregate') { @($result.stderr) -join "`n" -eq 'LEVEL_ID_MISMATCH' } else { @($result.stderr).Count -eq 0 }
    $record = [ordered]@{ case = $case.name; status = $result.status; native_exit = $result.native_exit_code; marker_pass = $result.marker_pass; stderr = @($result.stderr); stderr_exact = $stderrExact; cleanup_count = $result.cleanup_invocation_count; remaining_owned_pids = @($result.remaining_owned_pids); remaining_unproven_pids = @($result.remaining_unproven_pids); pass = ($result.status -eq 'PASS' -and $stderrExact -and $result.cleanup_invocation_count -eq 1 -and @($result.remaining_owned_pids).Count -eq 0 -and @($result.remaining_unproven_pids).Count -eq 0) }
    $records += $record
    $record | ConvertTo-Json -Compress -Depth 10 | Set-Content -LiteralPath (Join-Path $root ('tests/tools/task_0024af_final_case_' + $case.name + '.json')) -Encoding utf8
    if (-not $record.pass) { throw ('TASK_0024AF_FINAL_CASE_FAIL ' + $case.name) }
}
$summary = [ordered]@{ prefix = 'TASK_0024AF_FINAL_CYCLE'; invocation = $manifest.invocation; status = 'PASS'; cases = $records; final_godot_count = @((Get-Process -Name godot,Godot,Godot_v4.7-stable_win64 -ErrorAction SilentlyContinue)).Count }
$summary | ConvertTo-Json -Depth 12 | Set-Content -LiteralPath (Join-Path $root 'tests/tools/task_0024af_final_summary.json') -Encoding utf8
Write-Output ('TASK_0024AF_FINAL_CYCLE ' + ($summary | ConvertTo-Json -Compress -Depth 12))

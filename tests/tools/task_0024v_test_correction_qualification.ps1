[CmdletBinding()]
param(
    [Parameter(Mandatory)][string]$GodotPath,
    [string]$RepoRoot = (Resolve-Path (Join-Path $PSScriptRoot '..\..')).Path
)

$ErrorActionPreference = 'Stop'
$PSNativeCommandUseErrorActionPreference = $false
$maxWrapperBytes = 262144
$maxSummaryBytes = 1048576
$wrapperPath = Join-Path $RepoRoot 'tests\tools\run_owned_godot_headless.ps1'
$staticPath = Join-Path $RepoRoot 'tests\tools\task_0024v_test_correction_static_validator.ps1'
$evidenceRoot = 'D:\Delayed_Self_Evidence\0024V_test_correction_qualification'
$cases = @(
    [pscustomobject]@{ id='aggregate'; script='res://tests/run_all.gd'; marker='TASK_0003_TESTS_PASS'; exact_marker='TASK_0003_TESTS_PASS assertions=621 vectors=9'; policy='Allow'; allowlist=@('LEVEL_ID_MISMATCH'); timeout=600 },
    [pscustomobject]@{ id='complete_v2'; script='res://tests/simulation/task_0024v_v2_solver_replay_canonical_malformed.gd'; marker='TASK_0024V_V2_COMPLETE_PASS'; exact_marker='TASK_0024V_V2_COMPLETE_PASS'; policy='ForbidNonempty'; allowlist=@(); timeout=300 }
)

function Assert-True([bool]$Condition, [string]$Message) {
    if (-not $Condition) { throw $Message }
}

function Get-GodotCount {
    return @(Get-CimInstance Win32_Process | Where-Object { $_.Name -like 'godot*' }).Count
}

function Invoke-StaticValidation([string]$PwshPath) {
    $lines = @(& $PwshPath -NoProfile -File $staticPath -RepoRoot $RepoRoot)
    $exitCode = $LASTEXITCODE
    $raw = $lines -join "`n"
    Assert-True ($exitCode -eq 0) 'Task 0024V static validation failed'
    Assert-True ([Text.Encoding]::UTF8.GetByteCount($raw) -le 65536) 'Static output bound exceeded'
    $result = $raw | ConvertFrom-Json -Depth 30
    Assert-True ($result.status -ceq 'PASS' -and $result.marker -ceq 'TASK_0024V_STATIC_VALIDATION_PASS') 'Static validation result mismatch'
    return $result
}

function Invoke-QualificationCase($Case, [string]$PwshPath) {
    $godotBefore = Get-GodotCount
    Assert-True ($godotBefore -eq 0) "Godot process exists before case: $($Case.id)"
    $arguments = @(
        '-NoProfile','-File',$wrapperPath,
        '-GodotPath',$GodotPath,
        '-ProjectPath',$RepoRoot,
        '-ScriptPath',[string]$Case.script,
        '-TimeoutSeconds',[string]$Case.timeout,
        '-GraceSeconds','3',
        '-RequiredMarker',[string]$Case.marker,
        '-StderrPolicy',[string]$Case.policy
    )
    $rawLines = @(& $PwshPath @arguments)
    $wrapperExit = $LASTEXITCODE
    $raw = $rawLines -join "`n"
    Assert-True ([Text.Encoding]::UTF8.GetByteCount($raw) -le $maxWrapperBytes) "Wrapper output bound exceeded: $($Case.id)"
    try { $wrapper = $raw | ConvertFrom-Json -Depth 50 } catch { throw "Wrapper JSON invalid: $($Case.id)" }
    $godotAfter = Get-GodotCount
    $stderr = @($wrapper.stderr)
    $stderrExact = $stderr.Count -eq @($Case.allowlist).Count
    if ($stderrExact) {
        for ($index = 0; $index -lt $stderr.Count; $index++) {
            if ([string]$stderr[$index] -cne [string]$Case.allowlist[$index]) { $stderrExact = $false }
        }
    }
    $stdout = @($wrapper.stdout)
    $exactMarkerCount = @($stdout | Where-Object { [string]$_ -ceq [string]$Case.exact_marker }).Count
    $remainingOwned = @($wrapper.remaining_owned_pids)
    $remainingUnproven = @($wrapper.remaining_unproven_pids)
    $unprovenRecords = @($wrapper.unproven_records)
    $unrelatedTouched = $false
    foreach ($closedPid in @($wrapper.cleanup_closed_pids)) {
        if (@($wrapper.owned_records | Where-Object { $_.pid -eq $closedPid }).Count -ne 1) { $unrelatedTouched = $true }
    }
    $pass = $wrapper.status -ceq 'PASS' -and
        $wrapperExit -eq 0 -and
        $wrapper.native_exit_code -eq 0 -and
        $wrapper.marker_pass -eq $true -and
        $wrapper.stderr_pass -eq $true -and
        $stderrExact -and
        $exactMarkerCount -eq 1 -and
        $wrapper.cleanup_invocation_count -eq 1 -and
        $remainingOwned.Count -eq 0 -and
        $remainingUnproven.Count -eq 0 -and
        $unprovenRecords.Count -eq 0 -and
        $godotBefore -eq 0 -and $godotAfter -eq 0 -and
        -not $unrelatedTouched
    return [pscustomobject][ordered]@{
        id = [string]$Case.id
        script = [string]$Case.script
        wrapper_status = [string]$wrapper.status
        underlying_status = [string]$wrapper.underlying_status
        wrapper_process_exit = $wrapperExit
        native_exit = $wrapper.native_exit_code
        marker_pass = $wrapper.marker_pass
        exact_marker = [string]$Case.exact_marker
        exact_marker_count = $exactMarkerCount
        stderr_policy = [string]$Case.policy
        stderr_pass = $wrapper.stderr_pass
        stderr_exact = $stderrExact
        cleanup_invocation_count = $wrapper.cleanup_invocation_count
        cleanup_order = @($wrapper.cleanup_order)
        cleanup_closed_pids = @($wrapper.cleanup_closed_pids)
        remaining_owned_pids = $remainingOwned
        remaining_unproven_pids = $remainingUnproven
        unproven_records = $unprovenRecords
        owned_records = @($wrapper.owned_records)
        stdout = $stdout
        stderr = $stderr
        godot_before = $godotBefore
        godot_after = $godotAfter
        unrelated_process_touched = $unrelatedTouched
        pass = $pass
    }
}

Assert-True ((Resolve-Path -LiteralPath $RepoRoot).Path -ceq 'D:\Delayed_Self') 'Repository root mismatch'
Assert-True (Test-Path -LiteralPath $GodotPath -PathType Leaf) 'Godot executable missing'
Assert-True (Test-Path -LiteralPath $wrapperPath -PathType Leaf) 'Accepted wrapper missing'
Assert-True (Test-Path -LiteralPath $staticPath -PathType Leaf) 'Static validator missing'
if (-not (Test-Path -LiteralPath $evidenceRoot)) {
    [void](New-Item -ItemType Directory -Path $evidenceRoot)
}
$existingCycles = @(Get-ChildItem -LiteralPath $evidenceRoot -Directory -Filter 'cycle_*')
$cycleNumber = $existingCycles.Count + 1
$cycleName = 'cycle_{0:d3}' -f $cycleNumber
$cycleRoot = Join-Path $evidenceRoot $cycleName
[void](New-Item -ItemType Directory -Path $cycleRoot)
$summaryPath = Join-Path $cycleRoot 'qualification_summary.json'
$pwsh = (Get-Command pwsh -ErrorAction Stop).Source
$caseResults = [Collections.Generic.List[object]]::new()
$staticBefore = $null
$staticAfter = $null
$errorClass = ''
$errorMessage = ''
$initialGodot = Get-GodotCount
$allCasesPass = $false
$progress = [pscustomobject][ordered]@{
    schema_version = 1
    task_id = '0024V'
    cycle_number = $cycleNumber
    cycle_name = $cycleName
    execution_status = 'STARTED'
    static_before_pass = $false
    case_ids_completed = @()
    godot_initial = $initialGodot
}
$progress | ConvertTo-Json -Depth 10 | Set-Content -LiteralPath $summaryPath -Encoding utf8NoBOM
try {
    Assert-True ($initialGodot -eq 0) 'Godot process exists at qualification-cycle start'
    $staticBefore = Invoke-StaticValidation $pwsh
    $progress.execution_status = 'STATIC_BEFORE_PASS'
    $progress.static_before_pass = $true
    $progress | ConvertTo-Json -Depth 10 | Set-Content -LiteralPath $summaryPath -Encoding utf8NoBOM
    foreach ($case in $cases) {
        $record = Invoke-QualificationCase $case $pwsh
        $caseResults.Add($record)
        $record | ConvertTo-Json -Depth 40 | Set-Content -LiteralPath (Join-Path $cycleRoot ("case_{0}.json" -f $case.id)) -Encoding utf8NoBOM
        $progress.execution_status = 'CASE_COMPLETED'
        $progress.case_ids_completed = @($caseResults | ForEach-Object { $_.id })
        $progress | ConvertTo-Json -Depth 10 | Set-Content -LiteralPath $summaryPath -Encoding utf8NoBOM
        if ($record.godot_after -ne 0 -or @($record.remaining_unproven_pids).Count -ne 0) {
            throw "Process isolation ambiguity after case: $($case.id)"
        }
    }
    $staticAfter = Invoke-StaticValidation $pwsh
    $allCasesPass = $caseResults.Count -eq 2 -and @($caseResults | Where-Object { -not $_.pass }).Count -eq 0
}
catch {
    $errorClass = $_.Exception.GetType().FullName
    $errorMessage = $_.Exception.Message
}
$finalGodot = Get-GodotCount
$qualified = $allCasesPass -and $null -ne $staticBefore -and $null -ne $staticAfter -and $finalGodot -eq 0 -and [string]::IsNullOrEmpty($errorMessage)
$terminal = if ($qualified) { 'CORE_MECHANICS_TEST_CORRECTION_QUALIFIED_FOR_GPT_REVIEW' } else { 'BLOCKED_CORE_MECHANICS_TEST_CORRECTION_QUALIFICATION' }
$summary = [pscustomobject][ordered]@{
    schema_version = 1
    task_id = '0024V'
    cycle_number = $cycleNumber
    cycle_name = $cycleName
    terminal_classification = $terminal
    static_before = $staticBefore
    cases = @($caseResults)
    static_after = $staticAfter
    error_class = $errorClass
    error_message = $errorMessage
    godot_initial = $initialGodot
    godot_final = $finalGodot
    qualified = $qualified
}
$summaryJson = $summary | ConvertTo-Json -Depth 50
Assert-True ([Text.Encoding]::UTF8.GetByteCount($summaryJson) -le $maxSummaryBytes) 'Qualification summary bound exceeded'
$summaryJson | Set-Content -LiteralPath $summaryPath -Encoding utf8NoBOM
$summary | ConvertTo-Json -Depth 12 -Compress
if (-not $qualified) { exit 1 }

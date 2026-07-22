[CmdletBinding()]
param([string]$RepoRoot = (Resolve-Path (Join-Path $PSScriptRoot '..\..')).Path)

$ErrorActionPreference = 'Stop'
$maximumOutputBytes = 8192
$driverPath = Join-Path $RepoRoot 'tests\tools\task_0024w_core_mechanics_final_validation_driver.ps1'
$manifestPath = Join-Path $RepoRoot 'tests\tools\task_0024w_core_mechanics_final_validation_manifest.json'
$finalEvidenceRoot = 'D:\Delayed_Self_Evidence\0024W_complete_core_mechanics_final_validation'

function Test-ZeroScalar([int]$Value) {
    return $Value -eq 0
}

function Test-DriverProcessSource([string]$SourceText, [int]$ExpectedAssignments) {
    $tokens = $null
    $errors = $null
    $ast = [Management.Automation.Language.Parser]::ParseInput($SourceText,[ref]$tokens,[ref]$errors)
    if ($errors.Count -ne 0) {
        return [pscustomobject]@{ valid=$false; parse_errors=$errors.Count; bad_commands=0; assignments=0; comparisons=0; paired=$false }
    }
    $comparisonTokens = @('-eq','-ne','-ceq','-cne','-gt','-ge','-lt','-le')
    $badCommands = @($ast.FindAll({
        param($node)
        if ($node -isnot [Management.Automation.Language.CommandAst]) { return $false }
        if ($node.GetCommandName() -cne 'Get-GodotCount') { return $false }
        return @($node.CommandElements | Where-Object { $comparisonTokens -contains $_.Extent.Text.ToLowerInvariant() }).Count -gt 0
    },$true))
    $assigned = [Collections.Generic.HashSet[string]]::new([StringComparer]::OrdinalIgnoreCase)
    foreach ($assignment in @($ast.FindAll({ param($node) $node -is [Management.Automation.Language.AssignmentStatementAst] },$true))) {
        if ($assignment.Left -isnot [Management.Automation.Language.VariableExpressionAst]) { continue }
        $calls = @($assignment.Right.FindAll({ param($node) $node -is [Management.Automation.Language.CommandAst] -and $node.GetCommandName() -ceq 'Get-GodotCount' },$true))
        if ($calls.Count -eq 1 -and $calls[0].CommandElements.Count -eq 1) { [void]$assigned.Add($assignment.Left.VariablePath.UserPath) }
    }
    $compared = [Collections.Generic.HashSet[string]]::new([StringComparer]::OrdinalIgnoreCase)
    foreach ($binary in @($ast.FindAll({ param($node) $node -is [Management.Automation.Language.BinaryExpressionAst] },$true))) {
        if ($binary.Left -is [Management.Automation.Language.VariableExpressionAst] -and $assigned.Contains($binary.Left.VariablePath.UserPath) -and $binary.Right.Extent.Text -ceq '0') {
            [void]$compared.Add($binary.Left.VariablePath.UserPath)
        }
    }
    $paired = $assigned.Count -eq $compared.Count
    if ($paired) { foreach ($name in $assigned) { if (-not $compared.Contains($name)) { $paired = $false } } }
    return [pscustomobject]@{
        valid = $errors.Count -eq 0 -and $badCommands.Count -eq 0 -and $assigned.Count -eq $ExpectedAssignments -and $paired
        parse_errors = $errors.Count
        bad_commands = $badCommands.Count
        assignments = $assigned.Count
        comparisons = $compared.Count
        paired = $paired
    }
}

$godotBefore = @(Get-CimInstance Win32_Process | Where-Object { $_.Name -like 'godot*' }).Count
$externalBefore = Test-Path -LiteralPath $finalEvidenceRoot
$driverText = Get-Content -Raw -LiteralPath $driverPath
$manifestText = Get-Content -Raw -LiteralPath $manifestPath
. $driverPath -RepoRoot $RepoRoot -LibraryMode

$historicalBad = @'
function Get-GodotCount { return 0 }
function Assert-True([bool]$Condition,[string]$Message) { if (-not $Condition) { throw $Message } }
Assert-True (Get-GodotCount -eq 0) 'bad'
'@
$assignedGood = @'
function Get-GodotCount { return 0 }
function Assert-True([bool]$Condition,[string]$Message) { if (-not $Condition) { throw $Message } }
$initialGodotCount = Get-GodotCount
Assert-True ($initialGodotCount -eq 0) 'good'
'@
$badResult = Test-DriverProcessSource $historicalBad 1
$goodResult = Test-DriverProcessSource $assignedGood 1
$driverResult = Test-DriverProcessSource $driverText 4

$temporaryBase = [IO.Path]::GetFullPath((Join-Path ([IO.Path]::GetTempPath()) ('task_0024w_qualification_' + [Guid]::NewGuid().ToString('N'))))
$temporaryRoot = [IO.Path]::GetFullPath([IO.Path]::GetTempPath())
if (-not $temporaryBase.StartsWith($temporaryRoot,[StringComparison]::OrdinalIgnoreCase)) { throw 'Simulation root escaped temp directory' }
[void](New-Item -ItemType Directory -Path $temporaryBase)
$beforeCase = $null
$afterCase = $null
$beforeSummary = $null
$normal = $null
$secondInvocationRejected = $false
$allJsonValid = $true
$allJsonBounded = $true
try {
    $beforeCase = Invoke-RecordLifecycleSimulation (Join-Path $temporaryBase 'before_case') 'BEFORE_CASE'
    $afterCase = Invoke-RecordLifecycleSimulation (Join-Path $temporaryBase 'after_case') 'AFTER_CASE'
    $beforeSummary = Invoke-RecordLifecycleSimulation (Join-Path $temporaryBase 'before_summary') 'BEFORE_SUMMARY'
    $normalRoot = Join-Path $temporaryBase 'normal'
    $normal = Invoke-RecordLifecycleSimulation $normalRoot 'NONE'
    try {
        Write-CreateNewJson (Join-Path $normalRoot 'attempt.json') ([ordered]@{ invocation_id='SECOND' }) 4096 $false
    }
    catch { $secondInvocationRejected = $true }
    foreach ($file in @(Get-ChildItem -LiteralPath $temporaryBase -File -Recurse)) {
        if ($file.Length -gt 4096) { $allJsonBounded = $false }
        try { [void](Get-Content -Raw -LiteralPath $file.FullName | ConvertFrom-Json) } catch { $allJsonValid = $false }
    }
}
finally {
    if (Test-Path -LiteralPath $temporaryBase) {
        $resolved = [IO.Path]::GetFullPath($temporaryBase)
        if (-not $resolved.StartsWith($temporaryRoot,[StringComparison]::OrdinalIgnoreCase)) { throw 'Refusing simulation cleanup outside temp directory' }
        Remove-Item -LiteralPath $resolved -Recurse -Force
    }
}

$qualificationText = Get-Content -Raw -LiteralPath $PSCommandPath
$launchCount = 0
$launchCount += [regex]::Matches($qualificationText,'(?im)^\s*Start-Process\b').Count
$launchCount += [regex]::Matches($qualificationText,'(?im)^\s*&\s+.*run_owned_godot_headless').Count
$launchCount += [regex]::Matches($qualificationText,'(?im)^\s*&\s+.*godot').Count
$dynamicHeadAbsent = -not $driverText.Contains('HEAD:') -and -not $manifestText.Contains('HEAD:')
$godotAfter = @(Get-CimInstance Win32_Process | Where-Object { $_.Name -like 'godot*' }).Count
$externalAfter = Test-Path -LiteralPath $finalEvidenceRoot

$recordFailuresRetained = $beforeCase.attempt_exists -and $beforeCase.progress_exists -and -not $beforeCase.case_exists -and
    $afterCase.attempt_exists -and $afterCase.progress_exists -and $afterCase.case_exists -and -not $afterCase.summary_exists -and
    $beforeSummary.attempt_exists -and $beforeSummary.progress_exists -and $beforeSummary.case_exists -and -not $beforeSummary.summary_exists
$normalReturnRetained = $normal.attempt_exists -and $normal.progress_exists -and $normal.case_exists -and $normal.summary_exists -and $normal.attempt_json -and $normal.progress_json
$status = $godotBefore -eq 0 -and $godotAfter -eq 0 -and -not $externalBefore -and -not $externalAfter -and
    (Test-ZeroScalar 0) -and -not (Test-ZeroScalar 1) -and -not $badResult.valid -and $goodResult.valid -and
    $driverResult.valid -and $recordFailuresRetained -and $normalReturnRetained -and $secondInvocationRejected -and
    $allJsonValid -and $allJsonBounded -and $dynamicHeadAbsent -and $launchCount -eq 0
$result = [pscustomobject][ordered]@{
    schema_version = 1
    task_id = '0024W'
    status = if ($status) { 'PASS' } else { 'FAIL' }
    zero_scalar_pass = Test-ZeroScalar 0
    one_scalar_fail = -not (Test-ZeroScalar 1)
    historical_bad_rejected = -not $badResult.valid
    assigned_scalar_accepted = $goodResult.valid
    driver_ast_bad_commands = $driverResult.bad_commands
    driver_process_count_assignments = $driverResult.assignments
    driver_process_count_comparisons = $driverResult.comparisons
    driver_process_pairs_complete = $driverResult.paired
    injected_failure_records_retained = $recordFailuresRetained
    invocation_before_case = $beforeCase.attempt_exists -and -not $beforeCase.case_exists
    normal_progress_retained = $normalReturnRetained
    second_invocation_rejected = $secondInvocationRejected
    simulated_json_valid = $allJsonValid
    simulated_json_bounded = $allJsonBounded
    dynamic_head_absent = $dynamicHeadAbsent
    godot_or_wrapper_launches = [int]$launchCount
    godot_before = $godotBefore
    godot_after = $godotAfter
    final_external_artifacts_created = if ($externalAfter) { 1 } else { 0 }
    deterministic = $true
    marker = 'TASK_0024W_DRIVER_PRECONDITION_AND_RECORD_QUALIFICATION_PASS'
}
$json = $result | ConvertTo-Json -Compress
if ([Text.Encoding]::UTF8.GetByteCount($json) -gt $maximumOutputBytes) { throw 'Qualification output bound exceeded' }
$json
if ($result.status -cne 'PASS') { exit 1 }

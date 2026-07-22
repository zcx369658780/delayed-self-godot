[CmdletBinding()]
param([string]$RepoRoot = (Resolve-Path (Join-Path $PSScriptRoot '..\..')).Path)

$ErrorActionPreference = 'Stop'
$validatorPath = Join-Path $RepoRoot 'tests\tools\task_0024u_core_mechanics_final_validation_static_validator.ps1'
$driverPath = Join-Path $RepoRoot 'tests\tools\task_0024u_core_mechanics_final_validation_driver.ps1'
$evidenceRoot = 'D:\Delayed_Self_Evidence\0024U_corrected_complete_core_mechanics_final_validation'
$maximumOutputBytes = 4096

. $validatorPath -RepoRoot $RepoRoot -LibraryMode

function Test-ZeroScalar([int]$Value) {
    return $Value -eq 0
}

$zeroScalarPass = Test-ZeroScalar 0
$oneScalarFail = -not (Test-ZeroScalar 1)
$historicalBad = @'
function Get-GodotCount { return 0 }
function Assert-True([bool]$Condition,[string]$Message) { if (-not $Condition) { throw $Message } }
Assert-True (Get-GodotCount -eq 0) 'bad'
'@
$corrected = @'
function Get-GodotCount { return 0 }
function Assert-True([bool]$Condition,[string]$Message) { if (-not $Condition) { throw $Message } }
$initialGodotCount = Get-GodotCount
Assert-True ($initialGodotCount -eq 0) 'good'
'@
$badResult = Test-DriverPreconditionSource -SourceText $historicalBad
$goodResult = Test-DriverPreconditionSource -SourceText $corrected
$driverText = Get-Content -Raw -LiteralPath $driverPath
$driverResult = Test-DriverPreconditionSource -SourceText $driverText -RequireCompleteDriver
$qualificationText = Get-Content -Raw -LiteralPath $PSCommandPath
$launchPatterns = @(
    [regex]::Matches($qualificationText,'(?im)^\s*Start-Process\b').Count,
    [regex]::Matches($qualificationText,'(?im)^\s*&\s+.*run_owned_godot_headless').Count,
    [regex]::Matches($qualificationText,'(?im)^\s*&\s+.*godot').Count
)
$launchCount = ($launchPatterns | Measure-Object -Sum).Sum
$sealExistsBefore = Test-Path -LiteralPath (Join-Path $evidenceRoot 'pre_execution_seal.json')
$attemptExistsBefore = Test-Path -LiteralPath (Join-Path $evidenceRoot 'attempt_record.json')
$summaryExistsBefore = Test-Path -LiteralPath (Join-Path $evidenceRoot 'final_summary.json')
$externalArtifactsCreated = if ($sealExistsBefore -or $attemptExistsBefore -or $summaryExistsBefore) { 1 } else { 0 }

$result = [pscustomobject][ordered]@{
    schema_version = 1
    status = if ($zeroScalarPass -and $oneScalarFail -and -not $badResult.valid -and $goodResult.valid -and $driverResult.valid -and $launchCount -eq 0 -and $externalArtifactsCreated -eq 0) { 'PASS' } else { 'FAIL' }
    zero_scalar_pass = $zeroScalarPass
    one_scalar_fail = $oneScalarFail
    exact_driver_assigned_scalar_pass = $driverResult.valid
    ast_bad_assertions = $driverResult.bad_command_comparisons
    validator_rejects_historical_bad = -not $badResult.valid
    validator_accepts_corrected = $goodResult.valid
    driver_process_count_assignments = $driverResult.process_count_assignments
    driver_process_count_comparisons = $driverResult.process_count_comparisons
    driver_process_count_assertions = $driverResult.process_count_assertions
    godot_or_wrapper_launches = [int]$launchCount
    external_artifacts_created = $externalArtifactsCreated
    output_bounded = $true
    deterministic = $true
    marker = 'TASK_0024U_DRIVER_PRECONDITION_QUALIFICATION_PASS'
}
$json = $result | ConvertTo-Json -Compress
$byteCount = [Text.Encoding]::UTF8.GetByteCount($json)
if ($byteCount -gt $maximumOutputBytes) { throw 'Qualification output bound exceeded' }
$json
if ($result.status -cne 'PASS') { exit 1 }


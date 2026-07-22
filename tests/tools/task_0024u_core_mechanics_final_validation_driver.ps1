[CmdletBinding()]
param(
    [Parameter(Mandatory)][string]$GodotPath,
    [string]$RepoRoot = (Resolve-Path (Join-Path $PSScriptRoot '..\..')).Path
)

$ErrorActionPreference = 'Stop'
$PSNativeCommandUseErrorActionPreference = $false
$maxCaseResultBytes = 262144
$maxSummaryBytes = 1048576
$manifestPath = Join-Path $RepoRoot 'tests\tools\task_0024u_core_mechanics_final_validation_manifest.json'
$wrapperPath = Join-Path $RepoRoot 'tests/tools/run_owned_godot_headless.ps1'
$activeTaskPath = Join-Path $RepoRoot 'docs\CODEX_ACTIVE_TASK_CURRENT.md'
$evidenceRoot = 'D:\Delayed_Self_Evidence\0024U_corrected_complete_core_mechanics_final_validation'
$sealPath = Join-Path $evidenceRoot 'pre_execution_seal.json'
$attemptPath = Join-Path $evidenceRoot 'attempt_record.json'
$summaryPath = Join-Path $evidenceRoot 'final_summary.json'

function Assert-True([bool]$Condition, [string]$Message) {
    if (-not $Condition) { throw $Message }
}

function Get-GodotCount {
    return @(Get-CimInstance Win32_Process | Where-Object { $_.Name -like 'godot*' }).Count
}

function Get-Sha256([string]$Path) {
    return (Get-FileHash -Algorithm SHA256 -LiteralPath $Path).Hash.ToLowerInvariant()
}

function Get-FileHashMap($Properties) {
    $hashes = [ordered]@{}
    foreach ($property in $Properties) {
        $path = Join-Path $RepoRoot ($property.Name.Replace('/', '\'))
        $pathExists = Test-Path -LiteralPath $path -PathType Leaf
        Assert-True $pathExists "Required hash-bound file missing: $($property.Name)"
        $actualHash = Get-Sha256 $path
        $hashes[$property.Name] = $actualHash
    }
    return $hashes
}

function Get-ChangedPaths {
    $lines = @(& git -C $RepoRoot status --short --untracked-files=all)
    $gitExit = $LASTEXITCODE
    Assert-True ($gitExit -eq 0) 'Unable to audit changed paths'
    return @($lines | ForEach-Object { $_.Substring(3).Replace('\','/') })
}

$godotPathExists = Test-Path -LiteralPath $GodotPath -PathType Leaf
Assert-True $godotPathExists 'Godot executable is unavailable'
$manifestExists = Test-Path -LiteralPath $manifestPath -PathType Leaf
Assert-True $manifestExists 'Manifest is unavailable'
$wrapperExists = Test-Path -LiteralPath $wrapperPath -PathType Leaf
Assert-True $wrapperExists 'Accepted wrapper is unavailable'
$sealExists = Test-Path -LiteralPath $sealPath -PathType Leaf
Assert-True $sealExists 'Pre-execution seal is unavailable'
$attemptExists = Test-Path -LiteralPath $attemptPath
Assert-True (-not $attemptExists) 'A Task 0024U attempt record already exists'
$summaryExists = Test-Path -LiteralPath $summaryPath
Assert-True (-not $summaryExists) 'A Task 0024U final summary already exists'
$initialGodotCount = Get-GodotCount
Assert-True ($initialGodotCount -eq 0) 'Godot process exists at final-session start'

$activeTask = Get-Content -Raw -LiteralPath $activeTaskPath
Assert-True ($activeTask.Contains('tasks/0024U_corrected_sealed_driver_and_complete_core_mechanics_validation_gate.md')) 'CURRENT active task is not Task 0024U'
Assert-True ($activeTask.Contains('CORRECTED_SEALED_COMPLETE_CORE_MECHANICS_VALIDATION_READY_FOR_CODEX')) 'CURRENT Task 0024U status is not execution-ready'
$manifest = Get-Content -Raw -LiteralPath $manifestPath | ConvertFrom-Json -Depth 30
$manifestCaseCount = @($manifest.cases).Count
Assert-True ($manifestCaseCount -eq 4) 'Manifest case count mismatch'
$wrapperBlobLines = @(& git -C $RepoRoot hash-object -- $wrapperPath)
$wrapperBlobExit = $LASTEXITCODE
$wrapperBlob = ($wrapperBlobLines -join '').Trim()
Assert-True ($wrapperBlobExit -eq 0 -and $wrapperBlob -ceq $manifest.wrapper.blob) 'Accepted wrapper blob mismatch'

$seal = Get-Content -Raw -LiteralPath $sealPath | ConvertFrom-Json -Depth 40
Assert-True ($seal.task_id -ceq '0024U' -and $seal.seal_status -ceq 'SEALED') 'Seal identity mismatch'
foreach ($property in $seal.sealed_files.psobject.Properties) {
    $path = Join-Path $RepoRoot ($property.Name.Replace('/', '\'))
    $actualHash = Get-Sha256 $path
    Assert-True ($actualHash -ceq ([string]$property.Value).ToLowerInvariant()) "Sealed artifact mismatch: $($property.Name)"
}

$preFrozen = Get-FileHashMap $manifest.frozen_files.psobject.Properties
foreach ($property in $manifest.frozen_files.psobject.Properties) {
    Assert-True ($preFrozen[$property.Name] -ceq ([string]$property.Value).ToLowerInvariant()) "Frozen pre-hash mismatch: $($property.Name)"
    $sealedHash = [string]$seal.frozen_files.($property.Name)
    Assert-True ($sealedHash -ceq ([string]$property.Value).ToLowerInvariant()) "Seal frozen hash mismatch: $($property.Name)"
}
$preHistorical = Get-FileHashMap $manifest.historical_0024t_files.psobject.Properties
foreach ($property in $manifest.historical_0024t_files.psobject.Properties) {
    Assert-True ($preHistorical[$property.Name] -ceq ([string]$property.Value).ToLowerInvariant()) "Historical pre-hash mismatch: $($property.Name)"
    $sealedHistoricalHash = [string]$seal.historical_0024t_files.($property.Name)
    Assert-True ($sealedHistoricalHash -ceq ([string]$property.Value).ToLowerInvariant()) "Seal historical hash mismatch: $($property.Name)"
}
$historicalSealHash = Get-Sha256 $manifest.historical_0024t_seal_path
Assert-True ($historicalSealHash -ceq $manifest.historical_0024t_seal_sha256) 'Historical 0024T seal mismatch'
Assert-True ($seal.historical_0024t_seal_sha256 -ceq $manifest.historical_0024t_seal_sha256) 'New seal historical identity mismatch'

$allowedDirty = @(
    'tests/tools/task_0024u_core_mechanics_final_validation_manifest.json',
    'tests/tools/task_0024u_core_mechanics_final_validation_static_validator.ps1',
    'tests/tools/task_0024u_core_mechanics_final_validation_driver.ps1',
    'tests/tools/task_0024u_driver_precondition_qualification.ps1',
    'tests/tools/task_0024u_driver_precondition_qualification_summary.json'
)
$preChanged = Get-ChangedPaths
$unauthorizedPreChanged = @($preChanged | Where-Object { $allowedDirty -notcontains $_ })
$unauthorizedPreChangedCount = $unauthorizedPreChanged.Count
Assert-True ($unauthorizedPreChangedCount -eq 0) 'Unauthorized changed path before execution'
$stagedPaths = @(& git -C $RepoRoot diff --cached --name-only)
$stagedExit = $LASTEXITCODE
$stagedCount = $stagedPaths.Count
Assert-True ($stagedExit -eq 0 -and $stagedCount -eq 0) 'Staged path exists before execution'

$attempt = [pscustomobject][ordered]@{
    schema_version = 1
    task_id = '0024U'
    created_utc = [DateTime]::UtcNow.ToString('o')
    seal_sha256 = Get-Sha256 $sealPath
    manifest_sha256 = Get-Sha256 $manifestPath
    case_order = @($manifest.cases | ForEach-Object { $_.id })
}
$attemptJson = $attempt | ConvertTo-Json -Depth 10
$attemptBytes = [Text.Encoding]::UTF8.GetBytes($attemptJson)
$attemptStream = [IO.File]::Open($attemptPath,[IO.FileMode]::CreateNew,[IO.FileAccess]::Write,[IO.FileShare]::Read)
try { $attemptStream.Write($attemptBytes,0,$attemptBytes.Length) } finally { $attemptStream.Dispose() }
[IO.File]::SetAttributes($attemptPath,[IO.File]::GetAttributes($attemptPath) -bor [IO.FileAttributes]::ReadOnly)

$pwshCommand = Get-Command pwsh -ErrorAction Stop
$pwshPath = $pwshCommand.Source
$caseResults = [Collections.Generic.List[object]]::new()
$allCasesPass = $true
$unrelatedProcessTouched = $false
foreach ($case in $manifest.cases) {
    $godotBefore = Get-GodotCount
    $godotBeforeZero = $godotBefore -eq 0
    $wrapperResult = $null
    $wrapperProcessExit = $null
    $parseError = ''
    if ($godotBeforeZero) {
        $wrapperArguments = @(
            '-NoProfile','-File',$wrapperPath,
            '-GodotPath',$GodotPath,
            '-ProjectPath',$RepoRoot,
            '-ScriptPath',[string]$case.script,
            '-TimeoutSeconds',[string]$case.timeout_seconds,
            '-GraceSeconds',[string]$manifest.wrapper.grace_seconds,
            '-RequiredMarker',[string]$case.required_marker,
            '-StderrPolicy',[string]$case.stderr_policy
        )
        $rawLines = @(& $pwshPath @wrapperArguments)
        $wrapperProcessExit = $LASTEXITCODE
        $raw = $rawLines -join "`n"
        $rawByteCount = [Text.Encoding]::UTF8.GetByteCount($raw)
        if ($rawByteCount -gt $maxCaseResultBytes) {
            $parseError = 'WRAPPER_RESULT_BOUND_EXCEEDED'
        }
        else {
            try { $wrapperResult = $raw | ConvertFrom-Json -Depth 40 } catch { $parseError = 'WRAPPER_RESULT_JSON_INVALID' }
        }
    }
    else {
        $parseError = 'NONZERO_GODOT_BEFORE_CASE'
    }
    $godotAfter = Get-GodotCount
    $godotAfterZero = $godotAfter -eq 0
    $stderrExact = $false
    $casePass = $false
    if ($null -ne $wrapperResult) {
        $stderrLines = @($wrapperResult.stderr)
        if ($case.stderr_policy -ceq 'ForbidNonempty') {
            $stderrExact = $stderrLines.Count -eq 0
        }
        else {
            $stderrExact = $stderrLines.Count -eq @($case.stderr_allowlist).Count
            if ($stderrExact) {
                for ($index = 0; $index -lt $stderrLines.Count; $index++) {
                    if ([string]$stderrLines[$index] -cne [string]$case.stderr_allowlist[$index]) { $stderrExact = $false }
                }
            }
        }
        $remainingOwnedCount = @($wrapperResult.remaining_owned_pids).Count
        $remainingUnprovenCount = @($wrapperResult.remaining_unproven_pids).Count
        $unprovenRecordCount = @($wrapperResult.unproven_records).Count
        $casePass = $wrapperResult.status -ceq 'PASS' -and
            $wrapperProcessExit -eq 0 -and
            $wrapperResult.native_exit_code -eq 0 -and
            $wrapperResult.marker_pass -eq $true -and
            $wrapperResult.stderr_pass -eq $true -and
            $stderrExact -and
            $wrapperResult.cleanup_invocation_count -eq 1 -and
            $remainingOwnedCount -eq 0 -and
            $remainingUnprovenCount -eq 0 -and
            $unprovenRecordCount -eq 0 -and
            $godotBeforeZero -and $godotAfterZero
        foreach ($closedPid in @($wrapperResult.cleanup_closed_pids)) {
            $ownedMatches = @($wrapperResult.owned_records | Where-Object { $_.pid -eq $closedPid }).Count
            if ($ownedMatches -ne 1) { $unrelatedProcessTouched = $true }
        }
    }
    $allCasesPass = $allCasesPass -and $casePass
    $record = [pscustomobject][ordered]@{
        id = [string]$case.id
        script = [string]$case.script
        status = if ($null -ne $wrapperResult) { [string]$wrapperResult.status } else { $parseError }
        underlying_status = if ($null -ne $wrapperResult) { [string]$wrapperResult.underlying_status } else { '' }
        wrapper_process_exit = $wrapperProcessExit
        native_exit = if ($null -ne $wrapperResult) { $wrapperResult.native_exit_code } else { $null }
        marker_pass = if ($null -ne $wrapperResult) { $wrapperResult.marker_pass } else { $false }
        stderr_policy = [string]$case.stderr_policy
        stderr_pass = if ($null -ne $wrapperResult) { $wrapperResult.stderr_pass } else { $false }
        stderr_exact = $stderrExact
        cleanup_invocation_count = if ($null -ne $wrapperResult) { $wrapperResult.cleanup_invocation_count } else { $null }
        cleanup_order = if ($null -ne $wrapperResult) { @($wrapperResult.cleanup_order) } else { @() }
        cleanup_closed_pids = if ($null -ne $wrapperResult) { @($wrapperResult.cleanup_closed_pids) } else { @() }
        remaining_owned_pids = if ($null -ne $wrapperResult) { @($wrapperResult.remaining_owned_pids) } else { @() }
        remaining_unproven_pids = if ($null -ne $wrapperResult) { @($wrapperResult.remaining_unproven_pids) } else { @() }
        stdout = if ($null -ne $wrapperResult) { @($wrapperResult.stdout) } else { @() }
        stderr = if ($null -ne $wrapperResult) { @($wrapperResult.stderr) } else { @() }
        godot_before = $godotBefore
        godot_after = $godotAfter
        pass = $casePass
    }
    $caseResults.Add($record)
    $casePath = Join-Path $evidenceRoot ("case_{0}.json" -f $case.id)
    $record | ConvertTo-Json -Depth 20 | Set-Content -LiteralPath $casePath -Encoding utf8NoBOM
}

$postFrozen = Get-FileHashMap $manifest.frozen_files.psobject.Properties
$postHistorical = Get-FileHashMap $manifest.historical_0024t_files.psobject.Properties
$frozenStable = $true
foreach ($property in $manifest.frozen_files.psobject.Properties) {
    if ($postFrozen[$property.Name] -cne $preFrozen[$property.Name]) { $frozenStable = $false }
}
$historicalStable = $true
foreach ($property in $manifest.historical_0024t_files.psobject.Properties) {
    if ($postHistorical[$property.Name] -cne $preHistorical[$property.Name]) { $historicalStable = $false }
}
$postChanged = Get-ChangedPaths
$unauthorizedPostChanged = @($postChanged | Where-Object { $allowedDirty -notcontains $_ })
$changedPathsValid = $unauthorizedPostChanged.Count -eq 0
$finalGodotCount = Get-GodotCount
$finalGodotZero = $finalGodotCount -eq 0
$allPass = $allCasesPass -and $frozenStable -and $historicalStable -and $changedPathsValid -and $finalGodotZero -and -not $unrelatedProcessTouched
$terminal = if ($allPass) { 'COMPLETE_CORE_MECHANICS_FOUNDATION_VALIDATION_READY_FOR_GPT_REVIEW' } else { 'BLOCKED_COMPLETE_CORE_MECHANICS_FOUNDATION_VALIDATION' }
$summary = [pscustomobject][ordered]@{
    schema_version = 1
    task_id = '0024U'
    terminal_classification = $terminal
    case_order = @($caseResults | ForEach-Object { $_.id })
    cases = @($caseResults)
    frozen_pre = $preFrozen
    frozen_post = $postFrozen
    frozen_stable = $frozenStable
    historical_pre = $preHistorical
    historical_post = $postHistorical
    historical_stable = $historicalStable
    changed_paths_before = $preChanged
    changed_paths_after = $postChanged
    changed_paths_valid = $changedPathsValid
    unrelated_process_touched = $unrelatedProcessTouched
    godot_final = $finalGodotCount
}
$summaryJson = $summary | ConvertTo-Json -Depth 40
$summaryByteCount = [Text.Encoding]::UTF8.GetByteCount($summaryJson)
Assert-True ($summaryByteCount -le $maxSummaryBytes) 'Final summary bound exceeded'
$summaryJson | Set-Content -LiteralPath $summaryPath -Encoding utf8NoBOM
$summary | ConvertTo-Json -Depth 10 -Compress
if (-not $allPass) { exit 1 }


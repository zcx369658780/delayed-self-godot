[CmdletBinding()]
param(
    [Parameter(Mandatory)][string]$GodotPath,
    [string]$RepoRoot = (Resolve-Path (Join-Path $PSScriptRoot '..\..')).Path
)

$ErrorActionPreference = 'Stop'
$PSNativeCommandUseErrorActionPreference = $false
$maxCaseResultBytes = 262144
$maxSummaryBytes = 1048576
$manifestPath = Join-Path $RepoRoot 'tests\tools\task_0024t_core_mechanics_final_validation_manifest.json'
$wrapperPath = Join-Path $RepoRoot 'tests/tools/run_owned_godot_headless.ps1'
$activeTaskPath = Join-Path $RepoRoot 'docs\CODEX_ACTIVE_TASK_CURRENT.md'
$evidenceRoot = 'D:\Delayed_Self_Evidence\0024T_complete_core_mechanics_final_validation'
$sealPath = Join-Path $evidenceRoot 'pre_execution_seal.json'
$attemptPath = Join-Path $evidenceRoot 'attempt_record.json'
$summaryPath = Join-Path $evidenceRoot 'final_summary.json'

function Assert-True([bool]$Condition, [string]$Message) {
    if (-not $Condition) { throw $Message }
}

function Get-GodotCount {
    return @(Get-CimInstance Win32_Process -Filter "Name LIKE 'godot%'").Count
}

function Get-Sha256([string]$Path) {
    return (Get-FileHash -Algorithm SHA256 -LiteralPath $Path).Hash.ToLowerInvariant()
}

function Get-FrozenHashes($Manifest) {
    $hashes = [ordered]@{}
    foreach ($property in $Manifest.frozen_files.psobject.Properties) {
        $path = Join-Path $RepoRoot ($property.Name.Replace('/', '\'))
        Assert-True (Test-Path -LiteralPath $path -PathType Leaf) "Frozen file missing: $($property.Name)"
        $hashes[$property.Name] = Get-Sha256 $path
    }
    return $hashes
}

function Get-ChangedPaths {
    $lines = @(& git -C $RepoRoot status --short --untracked-files=all)
    Assert-True ($LASTEXITCODE -eq 0) 'Unable to audit changed paths'
    return @($lines | ForEach-Object { $_.Substring(3).Replace('\', '/') })
}

Assert-True (Test-Path -LiteralPath $GodotPath -PathType Leaf) 'Godot executable is unavailable'
Assert-True (Test-Path -LiteralPath $manifestPath -PathType Leaf) 'Manifest is unavailable'
Assert-True (Test-Path -LiteralPath $wrapperPath -PathType Leaf) 'Accepted wrapper is unavailable'
Assert-True (Test-Path -LiteralPath $sealPath -PathType Leaf) 'Pre-execution seal is unavailable'
Assert-True (-not (Test-Path -LiteralPath $attemptPath)) 'A Task 0024T attempt record already exists'
Assert-True (-not (Test-Path -LiteralPath $summaryPath)) 'A Task 0024T final summary already exists'
Assert-True (Get-GodotCount -eq 0) 'Godot process exists at final-session start'

$activeTask = Get-Content -Raw -LiteralPath $activeTaskPath
Assert-True ($activeTask.Contains('tasks/0024T_manifest_locked_complete_core_mechanics_final_validation_gate.md')) 'CURRENT active task is not Task 0024T'
Assert-True ($activeTask.Contains('MANIFEST_LOCKED_COMPLETE_CORE_MECHANICS_FINAL_VALIDATION_READY_FOR_CODEX')) 'CURRENT Task 0024T status is not execution-ready'
$manifest = Get-Content -Raw -LiteralPath $manifestPath | ConvertFrom-Json -Depth 20
Assert-True (@($manifest.cases).Count -eq 4) 'Manifest case count mismatch'
$wrapperBlob = (& git -C $RepoRoot hash-object -- $wrapperPath).Trim()
Assert-True ($LASTEXITCODE -eq 0 -and $wrapperBlob -ceq '5f14eb0feff903b40311c1c7283b20e2eabbffc2') 'Accepted wrapper blob mismatch'

$seal = Get-Content -Raw -LiteralPath $sealPath | ConvertFrom-Json -Depth 30
Assert-True ($seal.task_id -ceq '0024T' -and $seal.seal_status -ceq 'SEALED') 'Seal identity mismatch'
foreach ($property in $seal.sealed_files.psobject.Properties) {
    $path = Join-Path $RepoRoot ($property.Name.Replace('/', '\'))
    Assert-True ((Get-Sha256 $path) -ceq ([string]$property.Value).ToLowerInvariant()) "Sealed artifact mismatch: $($property.Name)"
}
$preFrozen = Get-FrozenHashes $manifest
foreach ($property in $manifest.frozen_files.psobject.Properties) {
    Assert-True ($preFrozen[$property.Name] -ceq ([string]$property.Value).ToLowerInvariant()) "Frozen pre-hash mismatch: $($property.Name)"
    Assert-True ([string]$seal.frozen_files.($property.Name) -ceq ([string]$property.Value).ToLowerInvariant()) "Seal frozen hash mismatch: $($property.Name)"
}

$allowedDirty = @(
    'tests/tools/task_0024t_core_mechanics_final_validation_manifest.json',
    'tests/tools/task_0024t_core_mechanics_final_validation_static_validator.ps1',
    'tests/tools/task_0024t_core_mechanics_final_validation.ps1',
    'tests/simulation/task_0024t_v2_solver_replay_canonical_malformed.gd'
)
$preChanged = Get-ChangedPaths
Assert-True (@($preChanged | Where-Object { $allowedDirty -notcontains $_ }).Count -eq 0) 'Unauthorized changed path before execution'
Assert-True (@(& git -C $RepoRoot diff --cached --name-only).Count -eq 0) 'Staged path exists before execution'

$attempt = [ordered]@{
    task_id = '0024T'
    created_utc = [DateTime]::UtcNow.ToString('o')
    seal_sha256 = Get-Sha256 $sealPath
    manifest_sha256 = Get-Sha256 $manifestPath
    case_order = @($manifest.cases | ForEach-Object { $_.id })
}
$attemptJson = [pscustomobject]$attempt | ConvertTo-Json -Depth 10
$attemptBytes = [Text.Encoding]::UTF8.GetBytes($attemptJson)
$attemptStream = [IO.File]::Open($attemptPath, [IO.FileMode]::CreateNew, [IO.FileAccess]::Write, [IO.FileShare]::Read)
try { $attemptStream.Write($attemptBytes, 0, $attemptBytes.Length) } finally { $attemptStream.Dispose() }
[IO.File]::SetAttributes($attemptPath, [IO.File]::GetAttributes($attemptPath) -bor [IO.FileAttributes]::ReadOnly)

$caseResults = [Collections.Generic.List[object]]::new()
$allPass = $true
$unrelatedProcessTouched = $false
foreach ($case in $manifest.cases) {
    $godotBefore = Get-GodotCount
    $wrapperResult = $null
    $wrapperNativeExit = $null
    $parseError = ''
    if ($godotBefore -eq 0) {
        $parameters = @{
            GodotPath = $GodotPath
            ProjectPath = $RepoRoot
            ScriptPath = [string]$case.script
            TimeoutSeconds = [int]$case.timeout_seconds
            GraceSeconds = 3
            RequiredMarker = [string]$case.required_marker
            StderrPolicy = [string]$case.stderr_policy
        }
        $rawLines = @(& $wrapperPath @parameters)
        $wrapperNativeExit = $LASTEXITCODE
        $raw = $rawLines -join "`n"
        if ([Text.Encoding]::UTF8.GetByteCount($raw) -gt $maxCaseResultBytes) {
            $parseError = 'WRAPPER_RESULT_BOUND_EXCEEDED'
        }
        else {
            try { $wrapperResult = $raw | ConvertFrom-Json -Depth 30 } catch { $parseError = 'WRAPPER_RESULT_JSON_INVALID' }
        }
    }
    else {
        $parseError = 'NONZERO_GODOT_BEFORE_CASE'
    }
    $godotAfter = Get-GodotCount
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
        $casePass = $wrapperResult.status -ceq 'PASS' -and
            $wrapperNativeExit -eq 0 -and
            $wrapperResult.native_exit_code -eq 0 -and
            $wrapperResult.marker_pass -eq $true -and
            $stderrExact -and
            $wrapperResult.cleanup_invocation_count -eq 1 -and
            @($wrapperResult.remaining_owned_pids).Count -eq 0 -and
            @($wrapperResult.remaining_unproven_pids).Count -eq 0 -and
            @($wrapperResult.unproven_records).Count -eq 0 -and
            $godotBefore -eq 0 -and $godotAfter -eq 0
        foreach ($pid in @($wrapperResult.cleanup_closed_pids)) {
            if (@($wrapperResult.owned_records | Where-Object { $_.pid -eq $pid }).Count -ne 1) { $unrelatedProcessTouched = $true }
        }
    }
    $allPass = $allPass -and $casePass
    $record = [pscustomobject][ordered]@{
        id = [string]$case.id
        script = [string]$case.script
        classification = if ($null -ne $wrapperResult) { [string]$wrapperResult.status } else { $parseError }
        wrapper_native_exit = $wrapperNativeExit
        native_exit = if ($null -ne $wrapperResult) { $wrapperResult.native_exit_code } else { $null }
        marker_pass = if ($null -ne $wrapperResult) { $wrapperResult.marker_pass } else { $false }
        stderr = if ($null -ne $wrapperResult) { @($wrapperResult.stderr) } else { @() }
        stderr_exact = $stderrExact
        cleanup_invocation_count = if ($null -ne $wrapperResult) { $wrapperResult.cleanup_invocation_count } else { $null }
        remaining_owned_count = if ($null -ne $wrapperResult) { @($wrapperResult.remaining_owned_pids).Count } else { $null }
        remaining_unproven_count = if ($null -ne $wrapperResult) { @($wrapperResult.remaining_unproven_pids).Count } else { $null }
        godot_before = $godotBefore
        godot_after = $godotAfter
        pass = $casePass
    }
    $caseResults.Add($record)
    $casePath = Join-Path $evidenceRoot ("case_{0}.json" -f $case.id)
    $record | ConvertTo-Json -Depth 12 | Set-Content -LiteralPath $casePath -Encoding utf8NoBOM
}

$postFrozen = Get-FrozenHashes $manifest
$frozenStable = $true
foreach ($property in $manifest.frozen_files.psobject.Properties) {
    $frozenStable = $frozenStable -and $postFrozen[$property.Name] -ceq $preFrozen[$property.Name]
}
$postChanged = Get-ChangedPaths
$changedPathsValid = @($postChanged | Where-Object { $allowedDirty -notcontains $_ }).Count -eq 0
$zeroGodotFinal = Get-GodotCount -eq 0
$allPass = $allPass -and $frozenStable -and $changedPathsValid -and $zeroGodotFinal -and -not $unrelatedProcessTouched
$terminal = if ($allPass) { 'COMPLETE_CORE_MECHANICS_FOUNDATION_VALIDATION_READY_FOR_GPT_REVIEW' } else { 'BLOCKED_COMPLETE_CORE_MECHANICS_FOUNDATION_VALIDATION' }
$summary = [pscustomobject][ordered]@{
    task_id = '0024T'
    terminal_classification = $terminal
    case_order = @($caseResults | ForEach-Object { $_.id })
    cases = @($caseResults)
    frozen_pre = $preFrozen
    frozen_post = $postFrozen
    frozen_stable = $frozenStable
    changed_paths_before = $preChanged
    changed_paths_after = $postChanged
    changed_paths_valid = $changedPathsValid
    unrelated_process_touched = $unrelatedProcessTouched
    godot_final = Get-GodotCount
}
$summaryJson = $summary | ConvertTo-Json -Depth 30
Assert-True ([Text.Encoding]::UTF8.GetByteCount($summaryJson) -le $maxSummaryBytes) 'Final summary bound exceeded'
$summaryJson | Set-Content -LiteralPath $summaryPath -Encoding utf8NoBOM
$summary | ConvertTo-Json -Depth 8 -Compress
if (-not $allPass) { exit 1 }

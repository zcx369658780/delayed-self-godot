[CmdletBinding()]
param(
    [string]$GodotPath = '',
    [string]$RepoRoot = (Resolve-Path (Join-Path $PSScriptRoot '..\..')).Path,
    [switch]$LibraryMode
)

$ErrorActionPreference = 'Stop'
$PSNativeCommandUseErrorActionPreference = $false
$maxCaseResultBytes = 262144
$maxRecordBytes = 1048576
$manifestPath = Join-Path $RepoRoot 'tests\tools\task_0024w_core_mechanics_final_validation_manifest.json'
$wrapperPath = Join-Path $RepoRoot 'tests\tools\run_owned_godot_headless.ps1'
$activeTaskPath = Join-Path $RepoRoot 'docs\CODEX_ACTIVE_TASK_CURRENT.md'
$evidenceRoot = 'D:\Delayed_Self_Evidence\0024W_complete_core_mechanics_final_validation'
$sealPath = Join-Path $evidenceRoot 'pre_execution_seal.json'
$attemptPath = Join-Path $evidenceRoot 'attempt_record.json'
$progressPath = Join-Path $evidenceRoot 'progress_record.json'
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

function ConvertTo-BoundedJson($Value, [int]$MaximumBytes) {
    $json = $Value | ConvertTo-Json -Depth 60
    Assert-True ([Text.Encoding]::UTF8.GetByteCount($json) -le $MaximumBytes) 'JSON record bound exceeded'
    return $json
}

function Write-CreateNewJson([string]$Path, $Value, [int]$MaximumBytes, [bool]$ReadOnly) {
    $json = ConvertTo-BoundedJson $Value $MaximumBytes
    $bytes = [Text.Encoding]::UTF8.GetBytes($json)
    $stream = [IO.File]::Open($Path,[IO.FileMode]::CreateNew,[IO.FileAccess]::Write,[IO.FileShare]::Read)
    try { $stream.Write($bytes,0,$bytes.Length) } finally { $stream.Dispose() }
    if ($ReadOnly) {
        [IO.File]::SetAttributes($Path,[IO.File]::GetAttributes($Path) -bor [IO.FileAttributes]::ReadOnly)
    }
}

function Write-AtomicJson([string]$Path, $Value, [int]$MaximumBytes) {
    $json = ConvertTo-BoundedJson $Value $MaximumBytes
    $temporaryPath = $Path + '.atomic.' + [Guid]::NewGuid().ToString('N')
    $bytes = [Text.Encoding]::UTF8.GetBytes($json)
    $stream = [IO.File]::Open($temporaryPath,[IO.FileMode]::CreateNew,[IO.FileAccess]::Write,[IO.FileShare]::Read)
    try { $stream.Write($bytes,0,$bytes.Length) } finally { $stream.Dispose() }
    [IO.File]::Move($temporaryPath,$Path,$true)
}

function Get-ChangedPaths {
    $lines = @(& git -C $RepoRoot status --short --untracked-files=all)
    Assert-True ($LASTEXITCODE -eq 0) 'Unable to audit changed paths'
    return @($lines | ForEach-Object { $_.Substring(3).Replace('\','/') })
}

function Assert-SealBindings($Seal) {
    foreach ($property in $Seal.sealed_files.psobject.Properties) {
        $path = Join-Path $RepoRoot ($property.Name.Replace('/', '\'))
        Assert-True (Test-Path -LiteralPath $path -PathType Leaf) "Sealed file missing: $($property.Name)"
        Assert-True ((Get-Sha256 $path) -ceq ([string]$property.Value).ToLowerInvariant()) "Sealed file drift: $($property.Name)"
    }
    foreach ($property in $Seal.external_evidence.psobject.Properties) {
        $path = Join-Path 'D:\Delayed_Self_Evidence' ($property.Name.Replace('/', '\'))
        Assert-True (Test-Path -LiteralPath $path -PathType Leaf) "Sealed external evidence missing: $($property.Name)"
        Assert-True ((Get-Sha256 $path) -ceq ([string]$property.Value).ToLowerInvariant()) "Sealed external evidence drift: $($property.Name)"
    }
}

function New-ProgressValue([string]$InvocationId, [string]$Phase, [string]$NextCase, [string[]]$CompletedCases, [string]$SummaryHash, [int]$GodotFinal) {
    return [pscustomobject][ordered]@{
        schema_version = 1
        task_id = '0024W'
        invocation_id = $InvocationId
        phase = $Phase
        next_case = $NextCase
        completed_cases = @($CompletedCases)
        summary_sha256 = $SummaryHash
        godot_final = $GodotFinal
        updated_utc = [DateTime]::UtcNow.ToString('o')
    }
}

function Invoke-RecordLifecycleSimulation([string]$Root, [ValidateSet('NONE','BEFORE_CASE','AFTER_CASE','BEFORE_SUMMARY')][string]$Injection) {
    [void](New-Item -ItemType Directory -Path $Root)
    $attempt = Join-Path $Root 'attempt.json'
    $progress = Join-Path $Root 'progress.json'
    $casePath = Join-Path $Root 'case.json'
    $summary = Join-Path $Root 'summary.json'
    $invocationId = 'SIMULATED_INVOCATION'
    Write-CreateNewJson $attempt ([ordered]@{ invocation_id=$invocationId; phase='ATTEMPT_CREATED' }) 4096 $false
    Write-CreateNewJson $progress ([ordered]@{ invocation_id=$invocationId; phase='PROGRESS_CREATED' }) 4096 $false
    try {
        if ($Injection -ceq 'BEFORE_CASE') { throw 'INJECTED_BEFORE_CASE' }
        Write-AtomicJson $progress ([ordered]@{ invocation_id=$invocationId; phase='BEFORE_CASE' }) 4096
        Write-CreateNewJson $casePath ([ordered]@{ invocation_id=$invocationId; phase='CASE_RETAINED' }) 4096 $false
        Write-AtomicJson $progress ([ordered]@{ invocation_id=$invocationId; phase='AFTER_CASE' }) 4096
        if ($Injection -ceq 'AFTER_CASE') { throw 'INJECTED_AFTER_CASE' }
        Write-AtomicJson $progress ([ordered]@{ invocation_id=$invocationId; phase='BEFORE_SUMMARY' }) 4096
        if ($Injection -ceq 'BEFORE_SUMMARY') { throw 'INJECTED_BEFORE_SUMMARY' }
        Write-CreateNewJson $summary ([ordered]@{ invocation_id=$invocationId; phase='SUMMARY_RETAINED' }) 4096 $false
        Write-AtomicJson $progress ([ordered]@{ invocation_id=$invocationId; phase='AFTER_SUMMARY' }) 4096
    }
    catch {
        Write-AtomicJson $progress ([ordered]@{ invocation_id=$invocationId; phase='FAILURE_RETAINED'; error=$_.Exception.Message }) 4096
    }
    return [pscustomobject][ordered]@{
        attempt_exists = Test-Path -LiteralPath $attempt -PathType Leaf
        progress_exists = Test-Path -LiteralPath $progress -PathType Leaf
        case_exists = Test-Path -LiteralPath $casePath -PathType Leaf
        summary_exists = Test-Path -LiteralPath $summary -PathType Leaf
        attempt_json = (Get-Content -Raw -LiteralPath $attempt | ConvertFrom-Json).invocation_id -ceq $invocationId
        progress_json = -not [string]::IsNullOrWhiteSpace((Get-Content -Raw -LiteralPath $progress | ConvertFrom-Json).phase)
    }
}

if ($LibraryMode) { return }

Assert-True ((Resolve-Path -LiteralPath $RepoRoot).Path -ceq 'D:\Delayed_Self') 'Repository root mismatch'
Assert-True (Test-Path -LiteralPath $GodotPath -PathType Leaf) 'Godot executable unavailable'
Assert-True (Test-Path -LiteralPath $manifestPath -PathType Leaf) 'Manifest unavailable'
Assert-True (Test-Path -LiteralPath $wrapperPath -PathType Leaf) 'Accepted wrapper unavailable'
Assert-True (Test-Path -LiteralPath $sealPath -PathType Leaf) 'Seal unavailable'
$sealReadOnly = ([IO.File]::GetAttributes($sealPath) -band [IO.FileAttributes]::ReadOnly) -ne 0
Assert-True $sealReadOnly 'Seal is not read-only'
$activeTask = Get-Content -Raw -LiteralPath $activeTaskPath
Assert-True ($activeTask.Contains('tasks/0024W_manifest_locked_corrected_complete_core_mechanics_final_validation_gate.md')) 'CURRENT task mismatch'
Assert-True ($activeTask.Contains('CORRECTED_COMPLETE_CORE_MECHANICS_FINAL_VALIDATION_READY_FOR_CODEX')) 'CURRENT execution status mismatch'
$manifest = Get-Content -Raw -LiteralPath $manifestPath | ConvertFrom-Json -Depth 60
$seal = Get-Content -Raw -LiteralPath $sealPath | ConvertFrom-Json -Depth 60
Assert-True ($seal.task_id -ceq '0024W' -and $seal.seal_status -ceq 'SEALED') 'Seal identity mismatch'
Assert-True ((& git -C $RepoRoot hash-object -- $wrapperPath).Trim() -ceq $manifest.wrapper.blob) 'Accepted wrapper blob mismatch'
Assert-SealBindings $seal

$allowedDirty = @(
    'tests/tools/task_0024w_core_mechanics_final_validation_manifest.json',
    'tests/tools/task_0024w_core_mechanics_final_validation_static_validator.ps1',
    'tests/tools/task_0024w_core_mechanics_final_validation_driver.ps1',
    'tests/tools/task_0024w_driver_precondition_and_record_qualification.ps1',
    'tests/tools/task_0024w_driver_precondition_and_record_qualification_summary.json'
)
$changedPaths = Get-ChangedPaths
Assert-True (@($changedPaths | Where-Object { $allowedDirty -notcontains $_ }).Count -eq 0) 'Unauthorized changed path before final driver'
$stagedPaths = @(& git -C $RepoRoot diff --cached --name-only)
Assert-True ($LASTEXITCODE -eq 0 -and $stagedPaths.Count -eq 0) 'Staged path exists before final driver'

$casePaths = @($manifest.cases | ForEach-Object { Join-Path $evidenceRoot ("case_{0}.json" -f $_.id) })
foreach ($path in @($attemptPath,$progressPath,$summaryPath) + $casePaths) {
    Assert-True (-not (Test-Path -LiteralPath $path)) "Final evidence already exists: $path"
}
$initialGodotCount = Get-GodotCount
Assert-True ($initialGodotCount -eq 0) 'Godot process exists before final driver'

$invocationId = [Guid]::NewGuid().ToString('D')
$attemptValue = [pscustomobject][ordered]@{
    schema_version = 1
    task_id = '0024W'
    invocation_id = $invocationId
    created_utc = [DateTime]::UtcNow.ToString('o')
    seal_sha256 = Get-Sha256 $sealPath
    manifest_sha256 = Get-Sha256 $manifestPath
    case_order = @($manifest.cases | ForEach-Object { $_.id })
}
Write-CreateNewJson $attemptPath $attemptValue $maxRecordBytes $true
$completedCases = [Collections.Generic.List[string]]::new()
$caseResults = [Collections.Generic.List[object]]::new()
$caseHashes = [ordered]@{}
$progressValue = New-ProgressValue $invocationId 'ATTEMPT_CREATED' ([string]$manifest.cases[0].id) @() '' -1
Write-CreateNewJson $progressPath $progressValue $maxRecordBytes $false

$executionError = ''
$unrelatedProcessTouched = $false
$finalGodotCount = -1
$summaryWritten = $false
$allCasesPass = $false
try {
    $pwshPath = (Get-Command pwsh -ErrorAction Stop).Source
    foreach ($case in $manifest.cases) {
        $godotBefore = Get-GodotCount
        $godotBeforeZero = $godotBefore -eq 0
        Assert-True $godotBeforeZero "Godot process exists before case: $($case.id)"
        $progressValue = New-ProgressValue $invocationId 'BEFORE_CASE' ([string]$case.id) @($completedCases) '' -1
        Write-AtomicJson $progressPath $progressValue $maxRecordBytes
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
        Assert-True ([Text.Encoding]::UTF8.GetByteCount($raw) -le $maxCaseResultBytes) "Wrapper result bound exceeded: $($case.id)"
        $wrapperResult = $raw | ConvertFrom-Json -Depth 60
        $godotAfter = Get-GodotCount
        $godotAfterZero = $godotAfter -eq 0
        $stdout = @($wrapperResult.stdout)
        $stderr = @($wrapperResult.stderr)
        $exactMarkerCount = @($stdout | Where-Object { [string]$_ -ceq [string]$case.exact_marker }).Count
        $stderrExact = $stderr.Count -eq @($case.stderr_allowlist).Count
        if ($stderrExact) {
            for ($index = 0; $index -lt $stderr.Count; $index++) {
                if ([string]$stderr[$index] -cne [string]$case.stderr_allowlist[$index]) { $stderrExact = $false }
            }
        }
        foreach ($closedPid in @($wrapperResult.cleanup_closed_pids)) {
            if (@($wrapperResult.owned_records | Where-Object { $_.pid -eq $closedPid }).Count -ne 1) { $unrelatedProcessTouched = $true }
        }
        $remainingOwned = @($wrapperResult.remaining_owned_pids)
        $remainingUnproven = @($wrapperResult.remaining_unproven_pids)
        $unprovenRecords = @($wrapperResult.unproven_records)
        $casePass = $wrapperResult.status -ceq 'PASS' -and
            $wrapperProcessExit -eq 0 -and
            $wrapperResult.native_exit_code -eq [int]$case.expected_native_exit -and
            $wrapperResult.marker_pass -eq $true -and
            $exactMarkerCount -eq 1 -and
            $wrapperResult.stderr_pass -eq $true -and
            $stderrExact -and
            $wrapperResult.cleanup_invocation_count -eq 1 -and
            $remainingOwned.Count -eq 0 -and
            $remainingUnproven.Count -eq 0 -and
            $unprovenRecords.Count -eq 0 -and
            $godotBeforeZero -and $godotAfterZero -and
            -not $unrelatedProcessTouched
        $record = [pscustomobject][ordered]@{
            schema_version = 1
            task_id = '0024W'
            invocation_id = $invocationId
            id = [string]$case.id
            script = [string]$case.script
            wrapper_status = [string]$wrapperResult.status
            underlying_status = [string]$wrapperResult.underlying_status
            wrapper_process_exit = $wrapperProcessExit
            native_exit = $wrapperResult.native_exit_code
            marker_pass = $wrapperResult.marker_pass
            exact_marker = [string]$case.exact_marker
            exact_marker_count = $exactMarkerCount
            stderr_policy = [string]$case.stderr_policy
            stderr_pass = $wrapperResult.stderr_pass
            stderr_exact = $stderrExact
            cleanup_invocation_count = $wrapperResult.cleanup_invocation_count
            cleanup_order = @($wrapperResult.cleanup_order)
            cleanup_closed_pids = @($wrapperResult.cleanup_closed_pids)
            owned_records = @($wrapperResult.owned_records)
            remaining_owned_pids = $remainingOwned
            remaining_unproven_pids = $remainingUnproven
            unproven_records = $unprovenRecords
            wrapper_result_sha256 = [Convert]::ToHexString([Security.Cryptography.SHA256]::HashData([Text.Encoding]::UTF8.GetBytes($raw))).ToLowerInvariant()
            stdout = $stdout
            stderr = $stderr
            godot_before = $godotBefore
            godot_after = $godotAfter
            unrelated_process_touched = $unrelatedProcessTouched
            pass = $casePass
        }
        $casePath = Join-Path $evidenceRoot ("case_{0}.json" -f $case.id)
        Write-CreateNewJson $casePath $record $maxRecordBytes $true
        $caseHashes[[string]$case.id] = Get-Sha256 $casePath
        $caseResults.Add($record)
        $completedCases.Add([string]$case.id)
        $progressValue = New-ProgressValue $invocationId 'AFTER_CASE' '' @($completedCases) '' -1
        Write-AtomicJson $progressPath $progressValue $maxRecordBytes
    }
}
catch {
    $executionError = $_.Exception.Message
}
finally {
    $finalGodotCount = Get-GodotCount
    $finalGodotZero = $finalGodotCount -eq 0
    try { Assert-SealBindings $seal } catch { if ([string]::IsNullOrEmpty($executionError)) { $executionError = $_.Exception.Message } }
    $allCasesPass = $caseResults.Count -eq 4 -and @($caseResults | Where-Object { -not $_.pass }).Count -eq 0
    $terminal = if ($allCasesPass -and $finalGodotZero -and -not $unrelatedProcessTouched -and [string]::IsNullOrEmpty($executionError)) { 'COMPLETE_CORE_MECHANICS_FOUNDATION_VALIDATION_READY_FOR_GPT_REVIEW' } else { 'BLOCKED_COMPLETE_CORE_MECHANICS_FOUNDATION_VALIDATION' }
    $progressValue = New-ProgressValue $invocationId 'BEFORE_FINAL_SUMMARY' '' @($completedCases) '' $finalGodotCount
    Write-AtomicJson $progressPath $progressValue $maxRecordBytes
    $summaryValue = [pscustomobject][ordered]@{
        schema_version = 1
        task_id = '0024W'
        invocation_id = $invocationId
        terminal_classification = $terminal
        seal_sha256 = Get-Sha256 $sealPath
        case_order = @($manifest.cases | ForEach-Object { $_.id })
        cases_executed = $caseResults.Count
        cases = @($caseResults)
        case_record_sha256 = $caseHashes
        execution_error = $executionError
        unrelated_process_touched = $unrelatedProcessTouched
        godot_initial = $initialGodotCount
        godot_final = $finalGodotCount
        all_cases_pass = $allCasesPass
    }
    Write-CreateNewJson $summaryPath $summaryValue $maxRecordBytes $true
    $summaryWritten = $true
    $summaryHash = Get-Sha256 $summaryPath
    $progressValue = New-ProgressValue $invocationId 'AFTER_FINAL_SUMMARY' '' @($completedCases) $summaryHash $finalGodotCount
    Write-AtomicJson $progressPath $progressValue $maxRecordBytes
    [IO.File]::SetAttributes($progressPath,[IO.File]::GetAttributes($progressPath) -bor [IO.FileAttributes]::ReadOnly)
}

$summaryResult = Get-Content -Raw -LiteralPath $summaryPath | ConvertFrom-Json -Depth 60
$summaryResult | ConvertTo-Json -Depth 12 -Compress
if ($summaryResult.terminal_classification -cne 'COMPLETE_CORE_MECHANICS_FOUNDATION_VALIDATION_READY_FOR_GPT_REVIEW') { exit 1 }

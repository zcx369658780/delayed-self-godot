[CmdletBinding()]
param(
    [string]$OwnerAuthorization = '',
    [string]$GodotExe = 'godot'
)

$ErrorActionPreference = 'Stop'
$ExpectedAuthorization = 'TASK_0023ZU_OWNER_AUTHORIZED_PRODUCTION_READ_ONLY'
$RequiredTaskLine = '# Task 0023ZU'
$RequiredStatusLine = '- Status: `OWNER_AUTHORIZED_CONTROLLED_PRODUCTION_READ_ONLY_EXECUTION`'
$ChildGuardName = 'DELAYED_SELF_0023ZU_PRODUCTION_READ_AUTHORIZATION'
$ChildGuardArgument = '--task-0023zu-controlled-production-read-only'

if ($OwnerAuthorization -cne $ExpectedAuthorization) {
    Write-Output 'TASK_0023ZU_CONTROLLED_PRODUCTION_READ_ONLY_RUNNER_AUTHORIZATION_BLOCKED'
    exit 2
}

$RepoRoot = (Resolve-Path -LiteralPath (Join-Path $PSScriptRoot '..\..')).Path
$CurrentAuthorityPath = Join-Path $RepoRoot 'docs\CODEX_ACTIVE_TASK_CURRENT.md'
$CurrentAuthority = [IO.File]::ReadAllText($CurrentAuthorityPath)
if (-not $CurrentAuthority.Contains($RequiredTaskLine) -or -not $CurrentAuthority.Contains($RequiredStatusLine)) {
    Write-Output 'TASK_0023ZU_CONTROLLED_PRODUCTION_READ_ONLY_CURRENT_AUTHORITY_BLOCKED'
    exit 2
}

$FutureEvidenceRoot = 'D:\Delayed_Self_Evidence\0023ZU_controlled_production_read_only'
if (Test-Path -LiteralPath $FutureEvidenceRoot) {
    Write-Output 'TASK_0023ZU_CONTROLLED_PRODUCTION_READ_ONLY_EVIDENCE_ROOT_BLOCKED'
    exit 2
}

function Get-ExactTargetObservation {
    param([Parameter(Mandatory)][string]$TargetPath)
    if (-not (Test-Path -LiteralPath $TargetPath -PathType Leaf)) {
        return [ordered]@{ exists = $false; length = $null; last_write_time_utc = $null }
    }
    $item = Get-Item -LiteralPath $TargetPath -Force
    return [ordered]@{ exists = $true; length = [long]$item.Length; last_write_time_utc = $item.LastWriteTimeUtc.ToString('o') }
}

function Get-ExactSiblingCounts {
    param([Parameter(Mandatory)][string]$ProfileParent)
    $counts = [ordered]@{ recovery = 0; activation_backup = 0; temp = 0; transaction = 0 }
    foreach ($category in @('recovery', 'activation_backup', 'temp', 'transaction')) {
        for ($index = 0; $index -le 7; $index++) {
            $candidate = Join-Path $ProfileParent ('.delayed_self_profile_' + $category + '_' + [string]$index + '.json')
            if (Test-Path -LiteralPath $candidate -PathType Leaf) {
                $counts[$category] += 1
            }
        }
    }
    return $counts
}

function Test-NoDisclosure {
    param([Parameter(Mandatory)][string]$Text)
    if ($Text -match '(?<![A-Za-z0-9+.\-])[A-Za-z]:[\\/]' -or $Text -match '\\\\[^\s\\]+\\[^\s\\]+' -or $Text.Contains('user://') -or $Text.Contains('delayed_self_profile.json')) {
        return $false
    }
    return $true
}

function Test-ExactOutcome {
    param([Parameter(Mandatory)][string]$Stdout)
    $allowed = @(
        @('MISSING_CLEAN', 'PRODUCTION_PROFILE_READY', 'MAIN_MENU'),
        @('LOADED', 'PRODUCTION_PROFILE_READY', 'MAIN_MENU'),
        @('SANITIZED_PENDING_RECOVERY', 'PRODUCTION_PROFILE_READY', 'MAIN_MENU'),
        @('RECOVERY_REQUIRED_READ_ONLY', 'FAILED_RECOVERY_REQUIRED_READ_ONLY', 'SAFE_ERROR'),
        @('UNSUPPORTED_VERSION_READ_ONLY', 'FAILED_UNSUPPORTED_VERSION_READ_ONLY', 'SAFE_ERROR')
    )
    foreach ($row in $allowed) {
        if ($Stdout.Contains('TASK_0023ZU_LOAD_STATUS=' + $row[0]) -and $Stdout.Contains('TASK_0023ZU_BOOT_STATUS=' + $row[1]) -and $Stdout.Contains('TASK_0023ZU_ROUTE=' + $row[2])) {
            return $true
        }
    }
    return $false
}

function Count-ExactMarker {
    param([Parameter(Mandatory)][string]$Text, [Parameter(Mandatory)][string]$Marker)
    return ([regex]::Matches($Text, [regex]::Escape($Marker))).Count
}

# All runner authority gates above have passed before ordinary user-data discovery.
$OrdinaryUserDataRoot = Join-Path $env:APPDATA 'Godot\app_userdata\Delayed Self'
$TargetPath = Join-Path $OrdinaryUserDataRoot 'delayed_self_profile.json'
$TargetBefore = Get-ExactTargetObservation -TargetPath $TargetPath
$SiblingsBefore = Get-ExactSiblingCounts -ProfileParent $OrdinaryUserDataRoot

[IO.Directory]::CreateDirectory($FutureEvidenceRoot) | Out-Null
$StdoutPath = Join-Path $FutureEvidenceRoot 'stdout.txt'
$StderrPath = Join-Path $FutureEvidenceRoot 'stderr.txt'
$AuditPath = Join-Path $FutureEvidenceRoot 'audit.json'
$EngineLogPath = Join-Path $FutureEvidenceRoot 'engine.log'

$psi = [System.Diagnostics.ProcessStartInfo]::new()
$psi.FileName = $GodotExe
$psi.UseShellExecute = $false
$psi.RedirectStandardOutput = $true
$psi.RedirectStandardError = $true
$psi.CreateNoWindow = $true
foreach ($argument in @('--headless', '--path', $RepoRoot, '--log-file', $EngineLogPath, '--script', 'res://tests/app/task_0023zt_controlled_production_read_only_observation.gd', '--', $ChildGuardArgument)) {
    $psi.ArgumentList.Add([string]$argument)
}
$psi.EnvironmentVariables[$ChildGuardName] = $ExpectedAuthorization
$process = [System.Diagnostics.Process]::new()
$process.StartInfo = $psi
if (-not $process.Start()) { throw 'BOUNDED_PROCESS_START_FAILED' }
$stdout = $process.StandardOutput.ReadToEnd()
$stderr = $process.StandardError.ReadToEnd()
$process.WaitForExit()
$nativeExit = $process.ExitCode
$process.Dispose()

$TargetAfter = Get-ExactTargetObservation -TargetPath $TargetPath
$SiblingsAfter = Get-ExactSiblingCounts -ProfileParent $OrdinaryUserDataRoot
$metadataEqual = ($TargetBefore.exists -eq $TargetAfter.exists) -and ($TargetBefore.length -eq $TargetAfter.length) -and ($TargetBefore.last_write_time_utc -eq $TargetAfter.last_write_time_utc)
$siblingsEqual = ($SiblingsBefore.recovery -eq $SiblingsAfter.recovery) -and ($SiblingsBefore.activation_backup -eq $SiblingsAfter.activation_backup) -and ($SiblingsBefore.temp -eq $SiblingsAfter.temp) -and ($SiblingsBefore.transaction -eq $SiblingsAfter.transaction)
$startedCount = Count-ExactMarker -Text $stdout -Marker 'TASK_0023ZU_OBSERVATION_STARTED'
$passCount = Count-ExactMarker -Text $stdout -Marker 'TASK_0023ZU_CONTROLLED_PRODUCTION_READ_ONLY_OBSERVATION_PASS'
$bounded = Test-NoDisclosure -Text ($stdout + "`n" + $stderr)
$stderrBytes = [Text.Encoding]::UTF8.GetByteCount($stderr)
$success = $nativeExit -eq 0 -and $stderrBytes -eq 0 -and $startedCount -eq 1 -and $passCount -eq 1 -and (Test-ExactOutcome -Stdout $stdout) -and $metadataEqual -and $siblingsEqual -and $bounded -and @(Get-Process -Name 'godot*' -ErrorAction SilentlyContinue).Count -eq 0

if ($bounded) {
    [IO.File]::WriteAllText($StdoutPath, $stdout, [Text.UTF8Encoding]::new($false))
    [IO.File]::WriteAllText($StderrPath, $stderr, [Text.UTF8Encoding]::new($false))
}
[ordered]@{
    target_exists_before = $TargetBefore.exists
    target_exists_after = $TargetAfter.exists
    length_before = $TargetBefore.length
    length_after = $TargetAfter.length
    last_write_time_utc_before = $TargetBefore.last_write_time_utc
    last_write_time_utc_after = $TargetAfter.last_write_time_utc
    recovery_count_before = $SiblingsBefore.recovery
    recovery_count_after = $SiblingsAfter.recovery
    activation_backup_count_before = $SiblingsBefore.activation_backup
    activation_backup_count_after = $SiblingsAfter.activation_backup
    temp_count_before = $SiblingsBefore.temp
    temp_count_after = $SiblingsAfter.temp
    transaction_count_before = $SiblingsBefore.transaction
    transaction_count_after = $SiblingsAfter.transaction
    native_exit = $nativeExit
    stderr_byte_count = $stderrBytes
    observation_started_marker_count = $startedCount
    observation_pass_marker_count = $passCount
} | ConvertTo-Json | Set-Content -Encoding UTF8 -LiteralPath $AuditPath

if (-not $success) {
    Write-Output 'TASK_0023ZU_CONTROLLED_PRODUCTION_READ_ONLY_RUN_FAILED'
    exit 1
}
Write-Output 'TASK_0023ZU_CONTROLLED_PRODUCTION_READ_ONLY_RUN_PASS'
exit 0

[CmdletBinding()]
param(
    [Parameter(Mandatory)][string]$GodotPath,
    [Parameter(Mandatory)][string]$ProjectPath,
    [Parameter(Mandatory)][string]$ScriptPath,
    [int]$TimeoutSeconds = 60,
    [int]$GraceSeconds = 3,
    [string[]]$ExtraArguments = @(),
    [string]$RequiredMarker = ""
)

$ErrorActionPreference = 'Stop'
if ($PSVersionTable.PSVersion.Major -lt 7) { throw 'PowerShell 7 or newer is required for ProcessStartInfo.ArgumentList' }

function Get-OwnedDescendantIds {
    param([int]$RootPid, [hashtable]$Owned)
    $all = @(Get-CimInstance Win32_Process)
    $frontier = @($RootPid)
    while ($frontier.Count -gt 0) {
        $parent = $frontier[0]
        $frontier = @($frontier | Select-Object -Skip 1)
        foreach ($candidate in $all | Where-Object { $_.ParentProcessId -eq $parent }) {
            if (-not $Owned.ContainsKey([int]$candidate.ProcessId)) {
                $Owned[[int]$candidate.ProcessId] = $candidate
                $frontier += [int]$candidate.ProcessId
            }
        }
    }
}

function Test-AlivePid { param([int]$ProcessId) return $null -ne (Get-Process -Id $ProcessId -ErrorAction SilentlyContinue) }

if (-not (Test-Path -LiteralPath $GodotPath -PathType Leaf)) { throw 'Godot executable is unavailable' }
if (-not (Test-Path -LiteralPath $ProjectPath -PathType Container)) { throw 'Project path is unavailable' }
if ($TimeoutSeconds -lt 1 -or $GraceSeconds -lt 0) { throw 'Timeout bounds are invalid' }

$arguments = @('--headless', '--path', $ProjectPath, '--script', $ScriptPath) + $ExtraArguments
$info = [System.Diagnostics.ProcessStartInfo]::new()
$info.FileName = $GodotPath
$info.UseShellExecute = $false
$info.RedirectStandardOutput = $true
$info.RedirectStandardError = $true
$info.CreateNoWindow = $true
foreach ($argument in $arguments) { [void]$info.ArgumentList.Add($argument) }
$stdout = [System.Collections.Generic.List[string]]::new()
$stderr = [System.Collections.Generic.List[string]]::new()
$process = [System.Diagnostics.Process]::new()
$process.StartInfo = $info
$owned = @{}
$cleanupAttempted = $false
$cleanupClosed = @()
$timedOut = $false
$nativeExit = $null
$startedAt = [DateTime]::UtcNow
try {
    [void]$process.Start()
    $owned[[int]$process.Id] = [pscustomobject]@{ ProcessId = [int]$process.Id; ExecutablePath = $GodotPath; CommandLine = ($arguments -join "`u{001F}"); StartTimeUtc = $startedAt.ToString('o'); Direct = $true }
    $stdoutTask = $process.StandardOutput.ReadToEndAsync()
    $stderrTask = $process.StandardError.ReadToEndAsync()
    if (-not $process.WaitForExit($TimeoutSeconds * 1000)) { $timedOut = $true } else { $nativeExit = $process.ExitCode }
    if ($timedOut) { Start-Sleep -Milliseconds ($GraceSeconds * 1000) }
}
finally {
    $cleanupAttempted = $true
    Get-OwnedDescendantIds -RootPid $process.Id -Owned $owned
    foreach ($ownedPid in @($owned.Keys | Sort-Object -Descending)) {
        if (Test-AlivePid $ownedPid) { Stop-Process -Id $ownedPid -ErrorAction Stop; $cleanupClosed += $ownedPid }
    }
    Start-Sleep -Milliseconds ($GraceSeconds * 1000)
}

foreach ($line in ($stdoutTask.GetAwaiter().GetResult() -split "`r?`n")) { if ($line -ne '') { $stdout.Add($line) } }
foreach ($line in ($stderrTask.GetAwaiter().GetResult() -split "`r?`n")) { if ($line -ne '') { $stderr.Add($line) } }

$remaining = @($owned.Keys | Where-Object { Test-AlivePid $_ })
$markerPass = [string]::IsNullOrEmpty($RequiredMarker) -or ($stdout -join "`n") -match [regex]::Escape($RequiredMarker)
$result = [ordered]@{
    status = if ($remaining.Count -gt 0) { 'CLEANUP_FAILURE' } elseif ($timedOut) { 'TIMEOUT' } elseif ($nativeExit -ne 0) { 'NONZERO_EXIT' } elseif (-not $markerPass) { 'MARKER_FAILURE' } else { 'PASS' }
    native_exit_code = $nativeExit
    timed_out = $timedOut
    marker_pass = $markerPass
    cleanup_attempted = $cleanupAttempted
    cleanup_closed_pids = @($cleanupClosed | Sort-Object)
    remaining_owned_pids = @($remaining | Sort-Object)
    owned_pids = @($owned.Keys | Sort-Object)
    stdout = @($stdout | Select-Object -First 200)
    stderr = @($stderr | Select-Object -First 200)
}
[pscustomobject]$result | ConvertTo-Json -Depth 5 -Compress
if ($result.status -ne 'PASS') { exit 1 }

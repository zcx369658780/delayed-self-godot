[CmdletBinding()]
param(
    [Parameter(Mandatory)][string]$ScriptPath,
    [Parameter(Mandatory)][string]$RequiredMarker,
    [Parameter(Mandatory)][string]$OutputPath,
    [ValidateSet('Allow', 'ForbidNonempty')][string]$StderrPolicy = 'ForbidNonempty',
    [int]$TimeoutSeconds = 120
)

$ErrorActionPreference = 'Stop'
$godotPath = 'D:\Program Files (x86)\Steam\steamapps\common\Godot Engine\godot.windows.opt.tools.64.exe'
$projectPath = 'D:\Delayed_Self'
$wrapperPath = Join-Path $projectPath 'tests\tools\run_owned_godot_headless.ps1'
$arguments = @('-NoProfile', '-File', $wrapperPath, '-GodotPath', $godotPath, '-ProjectPath', $projectPath, '-ScriptPath', $ScriptPath, '-TimeoutSeconds', [string]$TimeoutSeconds, '-GraceSeconds', '3', '-RequiredMarker', $RequiredMarker, '-StderrPolicy', $StderrPolicy)
$startInfo = [Diagnostics.ProcessStartInfo]::new()
$startInfo.FileName = (Get-Command pwsh).Source
$startInfo.UseShellExecute = $false
$startInfo.CreateNoWindow = $true
$startInfo.RedirectStandardOutput = $true
$startInfo.RedirectStandardError = $true
foreach ($argument in $arguments) { [void]$startInfo.ArgumentList.Add($argument) }
$process = [Diagnostics.Process]::new()
$process.StartInfo = $startInfo
if (-not $process.Start()) { throw 'Failed to start accepted wrapper child process' }
$stdoutTask = $process.StandardOutput.ReadToEndAsync()
$stderrTask = $process.StandardError.ReadToEndAsync()
$process.WaitForExit()
$lines = @($stdoutTask.GetAwaiter().GetResult() -split "`r?`n" | Where-Object { $_ -ne '' })
$stderrLines = @($stderrTask.GetAwaiter().GetResult() -split "`r?`n" | Where-Object { $_ -ne '' })
$childExit = $process.ExitCode
if ($stderrLines.Count -ne 0) { throw ("Wrapper child emitted process stderr: " + ($stderrLines -join ' | ')) }
if ($lines.Count -ne 1) { throw "Expected exactly one wrapper JSON line, observed $($lines.Count)" }
$record = $lines[0] | ConvertFrom-Json
$record | Add-Member -NotePropertyName wrapper_process_exit -NotePropertyValue $childExit
$utf8NoBom = [Text.UTF8Encoding]::new($false)
[IO.File]::WriteAllText([IO.Path]::GetFullPath($OutputPath), ($record | ConvertTo-Json -Depth 12) + "`n", $utf8NoBom)
Write-Output ("TASK_0024AA_CASE_RECORD_WRITTEN " + [IO.Path]::GetFullPath($OutputPath))
exit $childExit

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
$godotBefore = (Get-CimInstance Win32_Process -Filter "Name LIKE 'godot%'" | Measure-Object).Count
if ($godotBefore -ne 0) { throw "Expected zero Godot processes before case, observed $godotBefore" }
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
$markerCount = @($record.stdout | Where-Object { $_ -ceq $RequiredMarker }).Count
$godotAfter = (Get-CimInstance Win32_Process -Filter "Name LIKE 'godot%'" | Measure-Object).Count
$record | Add-Member -NotePropertyName wrapper_process_exit -NotePropertyValue $childExit
$record | Add-Member -NotePropertyName case_script_path -NotePropertyValue $ScriptPath
$record | Add-Member -NotePropertyName required_marker -NotePropertyValue $RequiredMarker
$record | Add-Member -NotePropertyName required_marker_count -NotePropertyValue $markerCount
$record | Add-Member -NotePropertyName godot_before_count -NotePropertyValue $godotBefore
$record | Add-Member -NotePropertyName godot_after_count -NotePropertyValue $godotAfter
$utf8NoBom = [Text.UTF8Encoding]::new($false)
[IO.File]::WriteAllText([IO.Path]::GetFullPath((Join-Path $projectPath $OutputPath)), ($record | ConvertTo-Json -Depth 100) + "`n", $utf8NoBom)
Write-Output ("TASK_0024AB_CASE_RECORD_WRITTEN " + [IO.Path]::GetFullPath((Join-Path $projectPath $OutputPath)))
exit $childExit

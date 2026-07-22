[CmdletBinding()]
param(
    [Parameter(Mandatory)][string]$ScriptPath,
    [Parameter(Mandatory)][string]$RequiredMarker,
    [Parameter(Mandatory)][string]$OutputPath,
    [ValidateSet('Allow','ForbidNonempty')][string]$StderrPolicy = 'ForbidNonempty',
    [int]$TimeoutSeconds = 240
)

$ErrorActionPreference = 'Stop'
$godotPath = 'D:\Program Files (x86)\Steam\steamapps\common\Godot Engine\godot.windows.opt.tools.64.exe'
$projectPath = 'D:\Delayed_Self'
$wrapperPath = Join-Path $projectPath 'tests\tools\run_owned_godot_headless.ps1'
$output = [IO.Path]::GetFullPath((Join-Path $projectPath $OutputPath))
if (Test-Path -LiteralPath $output) { throw "Output already exists: $output" }
$godotBefore = @(Get-CimInstance Win32_Process -Filter "Name LIKE 'godot%'" -ErrorAction SilentlyContinue).Count
if ($godotBefore -ne 0) { throw "Expected zero Godot processes before case, observed $godotBefore" }
$arguments = @('-NoProfile','-File',$wrapperPath,'-GodotPath',$godotPath,'-ProjectPath',$projectPath,'-ScriptPath',$ScriptPath,'-TimeoutSeconds',[string]$TimeoutSeconds,'-GraceSeconds','3','-RequiredMarker',$RequiredMarker,'-StderrPolicy',$StderrPolicy)
$startInfo = [Diagnostics.ProcessStartInfo]::new()
$startInfo.FileName = (Get-Command pwsh).Source
$startInfo.UseShellExecute = $false
$startInfo.CreateNoWindow = $true
$startInfo.RedirectStandardOutput = $true
$startInfo.RedirectStandardError = $true
foreach ($argument in $arguments) { [void]$startInfo.ArgumentList.Add($argument) }
$process = [Diagnostics.Process]::new(); $process.StartInfo = $startInfo
if (-not $process.Start()) { throw 'Failed to start accepted wrapper child process' }
$stdoutTask = $process.StandardOutput.ReadToEndAsync(); $stderrTask = $process.StandardError.ReadToEndAsync(); $process.WaitForExit()
$lines = @($stdoutTask.GetAwaiter().GetResult() -split "`r?`n" | Where-Object { $_ -ne '' })
$stderrLines = @($stderrTask.GetAwaiter().GetResult() -split "`r?`n" | Where-Object { $_ -ne '' })
$childExit = $process.ExitCode
if ($stderrLines.Count -ne 0) { throw ("Wrapper child emitted process stderr: " + ($stderrLines -join ' | ')) }
if ($lines.Count -ne 1) { throw "Expected exactly one wrapper JSON line, observed $($lines.Count)" }
$record = $lines[0] | ConvertFrom-Json -Depth 100
$markerCount = @($record.stdout | Where-Object { $_ -ceq $RequiredMarker }).Count
$godotAfter = @(Get-CimInstance Win32_Process -Filter "Name LIKE 'godot%'" -ErrorAction SilentlyContinue).Count
$record | Add-Member -NotePropertyName wrapper_process_exit -NotePropertyValue $childExit
$record | Add-Member -NotePropertyName case_script_path -NotePropertyValue $ScriptPath
$record | Add-Member -NotePropertyName required_marker -NotePropertyValue $RequiredMarker
$record | Add-Member -NotePropertyName required_marker_count -NotePropertyValue $markerCount
$record | Add-Member -NotePropertyName godot_before_count -NotePropertyValue $godotBefore
$record | Add-Member -NotePropertyName godot_after_count -NotePropertyValue $godotAfter
[IO.File]::WriteAllText($output, ($record | ConvertTo-Json -Depth 100) + "`n", [Text.UTF8Encoding]::new($false))
Write-Output ("TASK_0024AD_CASE_RECORD_WRITTEN " + $output)
if ($childExit -ne 0 -or $record.status -ne 'PASS' -or $record.native_exit_code -ne 0 -or -not $record.marker_pass -or $markerCount -ne 1 -or $godotAfter -ne 0) { exit 1 }
exit 0

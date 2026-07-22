[CmdletBinding()]
param(
    [Parameter(Mandatory)][string]$OutputPath,
    [int]$TimeoutSeconds = 240
)

$ErrorActionPreference = 'Stop'
$root = 'D:\Delayed_Self'
$godotPath = 'D:\Program Files (x86)\Steam\steamapps\common\Godot Engine\godot.windows.opt.tools.64.exe'
$wrapperPath = Join-Path $root 'tests\tools\run_owned_godot_headless.ps1'
$manifest = Get-Content -LiteralPath (Join-Path $root 'tests\tools\task_0024ae_owner_review_route_manifest.json') -Raw | ConvertFrom-Json -Depth 50
$output = [IO.Path]::GetFullPath((Join-Path $root $OutputPath))
if (Test-Path -LiteralPath $output) { throw "Output already exists: $output" }
$godotBefore = @(Get-CimInstance Win32_Process -Filter "Name LIKE 'godot%'" -ErrorAction SilentlyContinue).Count
if ($godotBefore -ne 0) { throw "Expected zero Godot processes before case, observed $godotBefore" }
$arguments = @(
    '-NoProfile','-File',$wrapperPath,
    '-GodotPath',$godotPath,
    '-ProjectPath',$root,
    '-ScriptPath',[string]$manifest.script,
    '-TimeoutSeconds',[string]$TimeoutSeconds,
    '-GraceSeconds','3',
    '-ExtraArguments',[string]$manifest.qualification_flag,
    '-RequiredMarker',[string]$manifest.marker,
    '-StderrPolicy',[string]$manifest.stderr_policy
)
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
if ($stderrLines.Count -ne 0) { throw ('Wrapper child emitted process stderr: ' + ($stderrLines -join ' | ')) }
if ($lines.Count -ne 1) { throw "Expected exactly one wrapper JSON line, observed $($lines.Count)" }
$record = $lines[0] | ConvertFrom-Json -Depth 100
$markerCount = @($record.stdout | Where-Object { $_ -ceq [string]$manifest.marker }).Count
$godotAfter = @(Get-CimInstance Win32_Process -Filter "Name LIKE 'godot%'" -ErrorAction SilentlyContinue).Count
$record | Add-Member wrapper_process_exit $childExit
$record | Add-Member case_script_path ([string]$manifest.script)
$record | Add-Member qualification_flag ([string]$manifest.qualification_flag)
$record | Add-Member required_marker ([string]$manifest.marker)
$record | Add-Member required_marker_count $markerCount
$record | Add-Member godot_before_count $godotBefore
$record | Add-Member godot_after_count $godotAfter
[IO.File]::WriteAllText($output, ($record | ConvertTo-Json -Depth 100) + "`n", [Text.UTF8Encoding]::new($false))
Write-Output ('TASK_0024AE_ROUTE_RECORD_WRITTEN ' + $output)
if ($childExit -ne 0 -or $record.status -ne 'PASS' -or $record.native_exit_code -ne 0 -or -not $record.marker_pass -or $markerCount -ne 1 -or $godotAfter -ne 0) { exit 1 }
exit 0

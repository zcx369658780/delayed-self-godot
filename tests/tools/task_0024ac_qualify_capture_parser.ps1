[CmdletBinding()]
param(
    [Parameter(Mandatory)][string]$BaselineRecordPath,
    [Parameter(Mandatory)][string]$OutputPath,
    [ValidatePattern('^[a-z0-9_]*$')][string]$ProbeTag = ''
)

$ErrorActionPreference = 'Stop'
$root = 'D:\Delayed_Self'
$parser = Join-Path $root 'tests\tools\task_0024ac_validate_capture.ps1'
$baselineFile = [IO.Path]::GetFullPath((Join-Path $root $BaselineRecordPath))
$outputFile = [IO.Path]::GetFullPath((Join-Path $root $OutputPath))
if (Test-Path -LiteralPath $outputFile) { throw "Output already exists: $outputFile" }
$utf8 = [Text.UTF8Encoding]::new($false)

function Invoke-ParserProbe([string]$Name, [scriptblock]$Mutate, [string]$ExpectedError) {
    $source = Get-Content -LiteralPath $baselineFile -Raw | ConvertFrom-Json -Depth 100
    $lines = [Collections.Generic.List[string]]::new()
    foreach ($line in @($source.stdout)) { $lines.Add([string]$line) }
    & $Mutate $lines
    $source.stdout = @($lines)
    $tag = if ($ProbeTag -eq '') { '' } else { '_' + $ProbeTag }
    $inputRelative = "tests/tools/task_0024ac_parser_probe_$($Name)$($tag)_input.json"
    $resultRelative = "tests/tools/task_0024ac_parser_probe_$($Name)$($tag)_result.json"
    $inputFile = Join-Path $root $inputRelative
    $resultFile = Join-Path $root $resultRelative
    foreach ($path in @($inputFile, $resultFile)) { if (Test-Path -LiteralPath $path) { throw "Probe output exists: $path" } }
    [IO.File]::WriteAllText($inputFile, ($source | ConvertTo-Json -Depth 100) + "`n", $utf8)
    $start = [Diagnostics.ProcessStartInfo]::new()
    $start.FileName = (Get-Command pwsh).Source
    $start.UseShellExecute = $false
    $start.CreateNoWindow = $true
    $start.RedirectStandardOutput = $true
    $start.RedirectStandardError = $true
    foreach ($argument in @('-NoProfile','-File',$parser,'-RecordPath',$inputRelative,'-OutputPath',$resultRelative,'-Phase','QUALIFICATION')) { [void]$start.ArgumentList.Add($argument) }
    $process = [Diagnostics.Process]::new()
    $process.StartInfo = $start
    if (-not $process.Start()) { throw "Failed to start parser probe: $Name" }
    $stdoutTask = $process.StandardOutput.ReadToEndAsync()
    $stderrTask = $process.StandardError.ReadToEndAsync()
    $process.WaitForExit()
    $stdout = $stdoutTask.GetAwaiter().GetResult().Trim()
    $stderr = $stderrTask.GetAwaiter().GetResult().Trim()
    if (-not (Test-Path -LiteralPath $resultFile)) { throw "Parser probe result missing: $Name" }
    $result = Get-Content -LiteralPath $resultFile -Raw | ConvertFrom-Json -Depth 100
    $matched = @($result.errors | Where-Object { ([string]$_).StartsWith($ExpectedError, [StringComparison]::Ordinal) }).Count -gt 0
    return [ordered]@{ name = $Name; parser_exit = $process.ExitCode; parser_stdout = $stdout; parser_stderr = $stderr; result_status = $result.status; errors = @($result.errors); expected_error_prefix = $ExpectedError; expected_rejection = $process.ExitCode -eq 1 -and $result.status -eq 'FAIL' -and $matched; input_path = $inputRelative; result_path = $resultRelative }
}

$metricsPrefix = 'TASK_0024AC_METRICS_JSON '
$probes = [Collections.Generic.List[object]]::new()
$probes.Add((Invoke-ParserProbe 'missing' { param($lines) for ($i=$lines.Count-1; $i -ge 0; $i--) { if ($lines[$i].StartsWith($metricsPrefix)) { $lines.RemoveAt($i) } } } 'count:TASK_0024AC_METRICS_JSON'))
$probes.Add((Invoke-ParserProbe 'duplicate' { param($lines) $line=@($lines|Where-Object{$_.StartsWith($metricsPrefix)})[0]; $lines.Add($line) } 'count:TASK_0024AC_METRICS_JSON'))
$probes.Add((Invoke-ParserProbe 'truncated' { param($lines) for($i=0;$i -lt $lines.Count;$i++){if($lines[$i].StartsWith($metricsPrefix)){$lines[$i]=$metricsPrefix+'{"status":"SOLVED"';break}} } 'non_json_or_truncated:TASK_0024AC_METRICS_JSON'))
$probes.Add((Invoke-ParserProbe 'non_json' { param($lines) for($i=0;$i -lt $lines.Count;$i++){if($lines[$i].StartsWith($metricsPrefix)){$lines[$i]=$metricsPrefix+'NOT_JSON';break}} } 'non_json_or_truncated:TASK_0024AC_METRICS_JSON'))
$probes.Add((Invoke-ParserProbe 'over_bound' { param($lines) for($i=0;$i -lt $lines.Count;$i++){if($lines[$i].StartsWith($metricsPrefix)){$lines[$i]=$lines[$i]+(' ' * 1700);break}} } 'over_bound:TASK_0024AC_METRICS_JSON'))
$failures = @($probes | Where-Object { -not $_.expected_rejection })
$summary = [ordered]@{ schema_version = 1; task = '0024AC'; status = if ($failures.Count -eq 0) { 'PASS' } else { 'FAIL' }; baseline_record = $BaselineRecordPath.Replace('\','/'); baseline_sha256 = (Get-FileHash -LiteralPath $baselineFile -Algorithm SHA256).Hash.ToLowerInvariant(); probe_count = $probes.Count; probes = @($probes); failures = @($failures) }
[IO.File]::WriteAllText($outputFile, ($summary | ConvertTo-Json -Depth 100) + "`n", $utf8)
Write-Output ("TASK_0024AC_CAPTURE_PARSER_" + $summary.status + " " + $outputFile)
if ($failures.Count -ne 0) { exit 1 }

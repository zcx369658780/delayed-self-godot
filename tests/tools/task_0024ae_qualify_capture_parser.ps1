[CmdletBinding()]
param(
    [Parameter(Mandatory)][string]$BaselineRecord
)

$ErrorActionPreference='Stop';$root='D:\Delayed_Self';$parserPath=Join-Path $root 'tests\tools\task_0024ae_validate_capture.ps1';$utf8=[Text.UTF8Encoding]::new($false)
$sourcePath=[IO.Path]::GetFullPath((Join-Path $root $BaselineRecord));$source=Get-Content -LiteralPath $sourcePath -Raw|ConvertFrom-Json -Depth 100
$leader='TASK_0024AE_ROUTE_JSON ';$firstIndex=-1;for($i=0;$i-lt $source.stdout.Count;$i++){if(([string]$source.stdout[$i]).StartsWith($leader,[StringComparison]::Ordinal)){$firstIndex=$i;break}}
if($firstIndex-lt 0){throw 'Baseline route record missing'}
$probes=@(
 [ordered]@{name='missing';mutate={param($lines,$index)@($lines[0..($index-1)]+$lines[($index+1)..($lines.Count-1)])};expected='count:TASK_0024AE_ROUTE_JSON'},
 [ordered]@{name='duplicate';mutate={param($lines,$index)@($lines[0..$index]+$lines[$index]+$lines[($index+1)..($lines.Count-1)])};expected='count:TASK_0024AE_ROUTE_JSON'},
 [ordered]@{name='truncated';mutate={param($lines,$index)$copy=@($lines);$copy[$index]=([string]$copy[$index]).Substring(0,([string]$copy[$index]).Length-1);$copy};expected='non_json_or_truncated:TASK_0024AE_ROUTE_JSON'},
 [ordered]@{name='non_json';mutate={param($lines,$index)$copy=@($lines);$copy[$index]=$leader+'not-json';$copy};expected='non_json_or_truncated:TASK_0024AE_ROUTE_JSON'},
 [ordered]@{name='over_bound';mutate={param($lines,$index)$copy=@($lines);$copy[$index]=$leader+'{"padding":"'+('x'*1900)+'"}';$copy};expected='over_bound:TASK_0024AE_ROUTE_JSON'}
)
$results=[Collections.Generic.List[object]]::new()
foreach($probe in $probes){
 $inputRel="tests/tools/task_0024ae_parser_probe_$($probe.name)_input.json";$resultRel="tests/tools/task_0024ae_parser_probe_$($probe.name)_result.json";$input=Join-Path $root $inputRel;$result=Join-Path $root $resultRel
 foreach($path in @($input,$result)){if(Test-Path -LiteralPath $path){throw "Probe path already exists: $path"}}
 $clone=$source|ConvertTo-Json -Depth 100|ConvertFrom-Json -Depth 100;$clone.stdout=@(& $probe.mutate @($source.stdout) $firstIndex)
 [IO.File]::WriteAllText($input,($clone|ConvertTo-Json -Depth 100)+"`n",$utf8)
 & pwsh -NoProfile -File $parserPath -RecordPath $inputRel -OutputPath $resultRel -Phase QUALIFICATION *> $null;$exit=$LASTEXITCODE
 $parsed=Get-Content -LiteralPath $result -Raw|ConvertFrom-Json -Depth 100;$matched=@($parsed.errors|Where-Object{([string]$_).StartsWith($probe.expected,[StringComparison]::Ordinal)}).Count-gt 0
 $results.Add([ordered]@{name=$probe.name;parser_exit=$exit;status=$parsed.status;expected_error_prefix=$probe.expected;matched=$matched;input_path=$inputRel;result_path=$resultRel})
}
$failures=@($results|Where-Object{$_.parser_exit-eq 0-or$_.status-ne'FAIL'-or-not$_.matched})
$summary=[ordered]@{schema_version=1;task='0024AE';status=if($failures.Count-eq 0){'PASS'}else{'FAIL'};baseline=$BaselineRecord.Replace('\','/');probe_count=$results.Count;probes=@($results);failures=@($failures)}
$summaryPath=Join-Path $root 'tests\tools\task_0024ae_capture_parser_qualification.json';if(Test-Path $summaryPath){throw 'Parser qualification summary exists'}
[IO.File]::WriteAllText($summaryPath,($summary|ConvertTo-Json -Depth 100)+"`n",$utf8);Write-Output ('TASK_0024AE_CAPTURE_PARSER_'+$summary.status);if($failures.Count-ne 0){exit 1}

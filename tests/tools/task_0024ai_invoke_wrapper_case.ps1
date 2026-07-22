[CmdletBinding(DefaultParameterSetName='Invoke')]
param(
 [Parameter(Mandatory,ParameterSetName='Invoke')][string]$GodotPath,
 [Parameter(Mandatory,ParameterSetName='Invoke')][string]$ProjectPath,
 [Parameter(Mandatory,ParameterSetName='Invoke')][string]$ScriptPath,
 [Parameter(Mandatory,ParameterSetName='Invoke')][string]$RequiredMarker,
 [Parameter(ParameterSetName='Invoke')][ValidateSet('RequireEmpty','Allow')][string]$StderrPolicy='RequireEmpty',
 [Parameter(ParameterSetName='Invoke')][string[]]$ExtraArguments=@(), [Parameter(ParameterSetName='Invoke')][string[]]$AllowedGodotDescendantTokens=@(),
 [Parameter(ParameterSetName='Invoke')][int]$TimeoutSeconds=120, [Parameter(ParameterSetName='Invoke')][int]$GraceSeconds=3,
 [Parameter(ParameterSetName='Invoke')][string]$EvidencePath='', [Parameter(ParameterSetName='Library',Mandatory)][switch]$Library)
Set-StrictMode -Version Latest; $ErrorActionPreference='Stop'
function Stop-Task0024AICapture([string]$Reason) { throw "TASK_0024AI_WRAPPER_CAPTURE_FAIL:$Reason" }
function ConvertFrom-Task0024AIWrapperValues {
 param([Parameter(Mandatory)][AllowEmptyCollection()][object[]]$Values)
 $nonEmpty=@($Values|Where-Object { $_ -isnot [string] -or -not [string]::IsNullOrWhiteSpace($_) })
 if($nonEmpty.Count -ne 1){Stop-Task0024AICapture "EXPECTED_ONE_NONEMPTY_VALUE:$($nonEmpty.Count)"}
 if($nonEmpty[0] -isnot [string]){Stop-Task0024AICapture "RESULT_NOT_STRING:$($nonEmpty[0].GetType().FullName)"}
 $raw=[string]$nonEmpty[0]; $trimmed=$raw.Trim()
 if(-not $trimmed.StartsWith('{') -or -not $trimmed.EndsWith('}')){Stop-Task0024AICapture 'RESULT_NOT_JSON_OBJECT'}
 try{$record=$raw|ConvertFrom-Json -Depth 100 -ErrorAction Stop}catch{Stop-Task0024AICapture 'INVALID_JSON'}
 if($record -is [array] -or $record -isnot [pscustomobject]){Stop-Task0024AICapture 'RESULT_NOT_OBJECT'}
 $requirements=[ordered]@{schema_version='integer';status='string';underlying_status='string';native_exit_code='integer';marker_pass='boolean';stderr='array';cleanup_invocation_count='integer';remaining_owned_pids='array';remaining_unproven_pids='array';stdout='array'}
 foreach($entry in $requirements.GetEnumerator()){
  $p=$record.PSObject.Properties[$entry.Key]; if($null -eq $p -or $null -eq $p.Value){Stop-Task0024AICapture "MISSING_OR_NULL:$($entry.Key)"}; $v=$p.Value
  $ok=switch($entry.Value){'integer'{$v -is [int] -or $v -is [long]};'string'{$v -is [string]};'boolean'{$v -is [bool]};'array'{$v -is [array]}}
  if(-not $ok){Stop-Task0024AICapture "WRONG_TYPE:$($entry.Key):$($entry.Value)"}
 }
 if([int]$record.schema_version -ne 2){Stop-Task0024AICapture 'SCHEMA_VERSION_NOT_2'}
 $bytes=[Text.Encoding]::UTF8.GetBytes($raw); $sha=[Convert]::ToHexString([Security.Cryptography.SHA256]::HashData($bytes)).ToLowerInvariant()
 [pscustomobject][ordered]@{raw_wrapper_json=$raw;raw_utf8_byte_count=$bytes.Length;raw_utf8_sha256=$sha;parsed_record=$record}
}
if($Library){return}
$wrapper=Join-Path $PSScriptRoot 'run_owned_godot_headless.ps1'; if(-not(Test-Path -LiteralPath $wrapper -PathType Leaf)){Stop-Task0024AICapture 'WRAPPER_NOT_FOUND'}
$policy=if($StderrPolicy -eq 'RequireEmpty'){'ForbidNonempty'}else{'Allow'}
$values=@(& $wrapper -GodotPath $GodotPath -ProjectPath $ProjectPath -ScriptPath $ScriptPath -RequiredMarker $RequiredMarker -StderrPolicy $policy -ExtraArguments $ExtraArguments -AllowedGodotDescendantTokens $AllowedGodotDescendantTokens -TimeoutSeconds $TimeoutSeconds -GraceSeconds $GraceSeconds 2>&1)
$captured=ConvertFrom-Task0024AIWrapperValues -Values $values
if($EvidencePath){[IO.File]::WriteAllText($EvidencePath,($captured|ConvertTo-Json -Depth 100 -Compress),[Text.UTF8Encoding]::new($false))}
$captured|ConvertTo-Json -Depth 100 -Compress

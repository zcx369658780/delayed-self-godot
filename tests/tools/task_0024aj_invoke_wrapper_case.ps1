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
function Stop-Task0024AJCapture([string]$Reason) { throw "TASK_0024AJ_WRAPPER_CAPTURE_FAIL:$Reason" }
function Get-Task0024AJSha256([byte[]]$Bytes) {
 $algorithm=[Security.Cryptography.SHA256]::Create(); try{return (-join ($algorithm.ComputeHash($Bytes)|ForEach-Object{$_.ToString('x2')}))}finally{$algorithm.Dispose()}
}
function ConvertFrom-Task0024AJWrapperValues {
 param([Parameter(Mandatory)][AllowEmptyCollection()][object[]]$Values)
 $normalized=[System.Collections.Generic.List[object]]::new()
 foreach($value in @($Values)){if($value -isnot [string] -or -not [string]::IsNullOrWhiteSpace([string]$value)){$normalized.Add($value)}}
 $nonEmptyCount=$normalized.Count
 if($nonEmptyCount -ne 1){Stop-Task0024AJCapture "EXPECTED_ONE_NONEMPTY_VALUE:$nonEmptyCount"}
 $only=$normalized[0]
 if($only -isnot [string]){Stop-Task0024AJCapture "RESULT_NOT_STRING:$($only.GetType().FullName)"}
 $raw=[string]$only; $trimmed=$raw.Trim()
 if(-not $trimmed.StartsWith('{') -or -not $trimmed.EndsWith('}')){Stop-Task0024AJCapture 'RESULT_NOT_JSON_OBJECT'}
 try{
  # PowerShell 7 supports the required explicit depth; Windows PowerShell 5.1
  # has no -Depth parameter and its parser has no configurable depth.
  if((Get-Command ConvertFrom-Json).Parameters.ContainsKey('Depth')){$record=$raw|ConvertFrom-Json -Depth 100 -ErrorAction Stop}else{$record=$raw|ConvertFrom-Json -ErrorAction Stop}
 }catch{Stop-Task0024AJCapture 'INVALID_JSON'}
 if($record -is [array] -or $record -isnot [pscustomobject]){Stop-Task0024AJCapture 'RESULT_NOT_OBJECT'}
 $requirements=[ordered]@{schema_version='integer';status='string';underlying_status='string';native_exit_code='integer';marker_pass='boolean';stderr='array';cleanup_invocation_count='integer';remaining_owned_pids='array';remaining_unproven_pids='array';stdout='array'}
 foreach($entry in $requirements.GetEnumerator()){
  $p=$record.PSObject.Properties[$entry.Key]; if($null -eq $p -or $null -eq $p.Value){Stop-Task0024AJCapture "MISSING_OR_NULL:$($entry.Key)"}; $v=$p.Value
  $ok=switch($entry.Value){'integer'{$v -is [int] -or $v -is [long]};'string'{$v -is [string]};'boolean'{$v -is [bool]};'array'{$v -is [array]}}
  if(-not $ok){Stop-Task0024AJCapture "WRONG_TYPE:$($entry.Key):$($entry.Value)"}
 }
 if([int]$record.schema_version -ne 2){Stop-Task0024AJCapture 'SCHEMA_VERSION_NOT_2'}
 $bytes=[Text.Encoding]::UTF8.GetBytes($raw); $sha=Get-Task0024AJSha256 -Bytes $bytes
 [pscustomobject][ordered]@{raw_wrapper_json=$raw;raw_utf8_byte_count=$bytes.Length;raw_utf8_sha256=$sha;parsed_record=$record}
}
if($Library){return}
$wrapper=Join-Path $PSScriptRoot 'run_owned_godot_headless.ps1'; if(-not(Test-Path -LiteralPath $wrapper -PathType Leaf)){Stop-Task0024AJCapture 'WRAPPER_NOT_FOUND'}
$policy=if($StderrPolicy -eq 'RequireEmpty'){'ForbidNonempty'}else{'Allow'}
function Get-Task0024AJGodotCount { @((Get-Process -ErrorAction SilentlyContinue | Where-Object { $_.ProcessName -like 'godot*' })).Count }
$godotCountBefore=Get-Task0024AJGodotCount
if($godotCountBefore -ne 0){Stop-Task0024AJCapture "GODOT_NOT_ZERO_BEFORE:$godotCountBefore"}
$wrapperArguments=@{GodotPath=$GodotPath;ProjectPath=$ProjectPath;ScriptPath=$ScriptPath;RequiredMarker=$RequiredMarker;StderrPolicy=$policy;TimeoutSeconds=$TimeoutSeconds;GraceSeconds=$GraceSeconds}
# PowerShell splatting an empty array into a typed array parameter binds `$null`
# under pwsh, which breaks the frozen wrapper's strict-mode `.Count` checks.
# Omitting empty optional parameters preserves the wrapper's own `@()` defaults.
if(@($ExtraArguments).Count -gt 0){$wrapperArguments.ExtraArguments=[string[]]@($ExtraArguments)}
if(@($AllowedGodotDescendantTokens).Count -gt 0){$wrapperArguments.AllowedGodotDescendantTokens=[string[]]@($AllowedGodotDescendantTokens)}
$godotCountAfter=$null
try {
 $values=@(& {
  param([string]$WrapperPath,[hashtable]$InvocationMap)
  # The frozen wrapper intentionally relies on normal PowerShell scalar
  # adaptation for `.Count`; do not leak this adapter's StrictMode into it.
  Set-StrictMode -Off
  & $WrapperPath @InvocationMap
 } $wrapper $wrapperArguments 2>&1)
} finally {
 $godotCountAfter=Get-Task0024AJGodotCount
}
if($godotCountAfter -ne 0){Stop-Task0024AJCapture "GODOT_NOT_ZERO_AFTER:$godotCountAfter"}
$captured=ConvertFrom-Task0024AJWrapperValues -Values $values
$result=[pscustomobject][ordered]@{godot_count_before=$godotCountBefore;godot_count_after=$godotCountAfter;raw_wrapper_json=$captured.raw_wrapper_json;raw_utf8_byte_count=$captured.raw_utf8_byte_count;raw_utf8_sha256=$captured.raw_utf8_sha256;parsed_record=$captured.parsed_record}
if($EvidencePath){[IO.File]::WriteAllText($EvidencePath,($result|ConvertTo-Json -Depth 100 -Compress),[Text.UTF8Encoding]::new($false))}
$result|ConvertTo-Json -Depth 100 -Compress

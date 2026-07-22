[CmdletBinding(DefaultParameterSetName = 'Invoke')]
param(
    [Parameter(Mandatory, ParameterSetName = 'Invoke')][string]$GodotPath,
    [Parameter(Mandatory, ParameterSetName = 'Invoke')][string]$ProjectPath,
    [Parameter(Mandatory, ParameterSetName = 'Invoke')][string]$ScriptPath,
    [Parameter(Mandatory, ParameterSetName = 'Invoke')][string]$RequiredMarker,
    [Parameter(ParameterSetName = 'Invoke')][ValidateSet('RequireEmpty', 'Allow')][string]$StderrPolicy = 'RequireEmpty',
    [Parameter(ParameterSetName = 'Invoke')][string[]]$ExtraArguments = @(),
    [Parameter(ParameterSetName = 'Invoke')][string[]]$AllowedGodotDescendantTokens = @(),
    [Parameter(ParameterSetName = 'Invoke')][int]$TimeoutSeconds = 120,
    [Parameter(ParameterSetName = 'Invoke')][int]$GraceSeconds = 3,
    [Parameter(ParameterSetName = 'Invoke')][string]$EvidencePath = '',
    [Parameter(ParameterSetName = 'Library', Mandatory)][switch]$Library
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

function Stop-Task0024AGCapture {
    param([Parameter(Mandatory)][string]$Reason)
    throw "TASK_0024AG_WRAPPER_CAPTURE_FAIL:$Reason"
}

function ConvertFrom-Task0024AGWrapperValues {
    [OutputType([pscustomobject])]
    param([Parameter(Mandatory)][AllowEmptyCollection()][object[]]$Values)

    # The wrapper is intentionally treated as an opaque native boundary.  Do not
    # hydrate, repair, or otherwise infer a record from process state.
    $nonEmpty = @($Values | Where-Object {
        if ($_ -isnot [string]) { return $true }
        return -not [string]::IsNullOrWhiteSpace($_)
    })
    if ($nonEmpty.Count -ne 1) { Stop-Task0024AGCapture "EXPECTED_ONE_NONEMPTY_VALUE:$($nonEmpty.Count)" }
    if ($nonEmpty[0] -isnot [string]) { Stop-Task0024AGCapture "RESULT_NOT_STRING:$($nonEmpty[0].GetType().FullName)" }
    $raw = [string]$nonEmpty[0]
    $trimmed = $raw.Trim()
    if (-not $trimmed.StartsWith('{') -or -not $trimmed.EndsWith('}')) { Stop-Task0024AGCapture 'RESULT_NOT_JSON_OBJECT' }
    try { $record = $raw | ConvertFrom-Json -Depth 100 -ErrorAction Stop }
    catch { Stop-Task0024AGCapture 'INVALID_JSON' }
    if ($record -is [array] -or $record -isnot [pscustomobject]) { Stop-Task0024AGCapture 'RESULT_NOT_OBJECT' }

    $requirements = [ordered]@{
        schema_version = 'integer'; status = 'string'; underlying_status = 'string'; native_exit_code = 'integer'
        marker_pass = 'boolean'; stderr = 'array'; cleanup_invocation_count = 'integer'
        remaining_owned_pids = 'array'; remaining_unproven_pids = 'array'; stdout = 'array'
    }
    foreach ($entry in $requirements.GetEnumerator()) {
        $property = $record.PSObject.Properties[$entry.Key]
        if ($null -eq $property -or $null -eq $property.Value) { Stop-Task0024AGCapture "MISSING_OR_NULL:$($entry.Key)" }
        $value = $property.Value
        $valid = switch ($entry.Value) {
            'integer' { $value -is [int] -or $value -is [long] }
            'string' { $value -is [string] }
            'boolean' { $value -is [bool] }
            'array' { $value -is [array] }
        }
        if (-not $valid) { Stop-Task0024AGCapture "WRONG_TYPE:$($entry.Key):$($entry.Value)" }
    }
    if ([int]$record.schema_version -ne 2) { Stop-Task0024AGCapture 'SCHEMA_VERSION_NOT_2' }
    $bytes = [Text.Encoding]::UTF8.GetBytes($raw)
    $sha = [Convert]::ToHexString([Security.Cryptography.SHA256]::HashData($bytes)).ToLowerInvariant()
    return [pscustomobject][ordered]@{
        raw_wrapper_json = $raw
        raw_utf8_byte_count = $bytes.Length
        raw_utf8_sha256 = $sha
        parsed_record = $record
    }
}

if ($Library) { return }

$wrapper = Join-Path $PSScriptRoot 'run_owned_godot_headless.ps1'
if (-not (Test-Path -LiteralPath $wrapper -PathType Leaf)) { Stop-Task0024AGCapture 'WRAPPER_NOT_FOUND' }
$wrapperStderrPolicy = if ($StderrPolicy -eq 'RequireEmpty') { 'ForbidNonempty' } else { 'Allow' }
$rawValues = @(& $wrapper -GodotPath $GodotPath -ProjectPath $ProjectPath -ScriptPath $ScriptPath -RequiredMarker $RequiredMarker -StderrPolicy $wrapperStderrPolicy -ExtraArguments $ExtraArguments -AllowedGodotDescendantTokens $AllowedGodotDescendantTokens -TimeoutSeconds $TimeoutSeconds -GraceSeconds $GraceSeconds 2>&1)
$captured = ConvertFrom-Task0024AGWrapperValues -Values $rawValues
if ($EvidencePath -ne '') {
    $parent = Split-Path -Parent $EvidencePath
    if ($parent -ne '' -and -not (Test-Path -LiteralPath $parent)) { Stop-Task0024AGCapture 'EVIDENCE_PARENT_MISSING' }
    [IO.File]::WriteAllText($EvidencePath, ($captured | ConvertTo-Json -Depth 100 -Compress), [Text.UTF8Encoding]::new($false))
}
$captured | ConvertTo-Json -Depth 100 -Compress

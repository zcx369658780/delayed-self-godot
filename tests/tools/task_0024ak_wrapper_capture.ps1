[CmdletBinding()]
param(
    [Parameter(Mandatory)][string]$AkGodotExecutable,
    [Parameter(Mandatory)][string]$AkProjectRoot,
    [Parameter(Mandatory)][string]$AkScriptPath,
    [Parameter(Mandatory)][string]$AkRequiredMarker,
    [ValidateSet('RequireEmpty', 'Allow')][string]$AkStderrPolicy = 'RequireEmpty',
    [string[]]$AkExtraArguments = @(),
    [string[]]$AkAllowedGodotDescendantTokens = @(),
    [ValidateRange(1, 3600)][int]$AkTimeoutSeconds = 120,
    [ValidateRange(0, 60)][int]$AkGraceSeconds = 3
)
Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'
function Stop-Task0024AKWrapperCapture {
    param([Parameter(Mandatory)][string]$AkCaptureReason)
    throw "TASK_0024AK_WRAPPER_CAPTURE_FAIL:$AkCaptureReason"
}
function Get-Task0024AKAdapterGodotCount {
    @((Get-Process -ErrorAction SilentlyContinue | Where-Object { $_.ProcessName -like 'godot*' })).Count
}
$AkCaptureModule = Join-Path $PSScriptRoot 'task_0024ak_evidence_parser.psm1'
$AkCaptureWrapper = Join-Path $PSScriptRoot 'run_owned_godot_headless.ps1'
if (-not (Test-Path -LiteralPath $AkCaptureModule -PathType Leaf)) {
    Stop-Task0024AKWrapperCapture 'PARSER_MODULE_NOT_FOUND'
}
if (-not (Test-Path -LiteralPath $AkCaptureWrapper -PathType Leaf)) {
    Stop-Task0024AKWrapperCapture 'WRAPPER_NOT_FOUND'
}
Import-Module -Name $AkCaptureModule -Force -Scope Local -ErrorAction Stop
$AkCaptureBefore = Get-Task0024AKAdapterGodotCount
if ($AkCaptureBefore -ne 0) {
    Stop-Task0024AKWrapperCapture "GODOT_NOT_ZERO_BEFORE:$AkCaptureBefore"
}
$AkCaptureInvocation = @{
    GodotPath = $AkGodotExecutable
    ProjectPath = $AkProjectRoot
    ScriptPath = $AkScriptPath
    RequiredMarker = $AkRequiredMarker
    StderrPolicy = if ($AkStderrPolicy -eq 'RequireEmpty') { 'ForbidNonempty' } else { 'Allow' }
    TimeoutSeconds = $AkTimeoutSeconds
    GraceSeconds = $AkGraceSeconds
}
if (@($AkExtraArguments).Count -gt 0) {
    $AkCaptureInvocation.ExtraArguments = [string[]]@($AkExtraArguments)
}
if (@($AkAllowedGodotDescendantTokens).Count -gt 0) {
    $AkCaptureInvocation.AllowedGodotDescendantTokens = [string[]]@($AkAllowedGodotDescendantTokens)
}
$AkCaptureAfter = $null
try {
    $AkCaptureValues = @(& {
        param(
            [Parameter(Mandatory)][string]$AkChildWrapper,
            [Parameter(Mandatory)][hashtable]$AkChildInvocation
        )
        Set-StrictMode -Off
        & $AkChildWrapper @AkChildInvocation
    } $AkCaptureWrapper $AkCaptureInvocation 2>&1)
}
finally {
    $AkCaptureAfter = Get-Task0024AKAdapterGodotCount
}
if ($AkCaptureAfter -ne 0) {
    Stop-Task0024AKWrapperCapture "GODOT_NOT_ZERO_AFTER:$AkCaptureAfter"
}
$AkCaptureParsed = ConvertFrom-Task0024AKWrapperValues `
    -AkParserValues $AkCaptureValues `
    -AkParserRequiredMarker $AkRequiredMarker
$AkCaptureMarkerCount = [long]$AkCaptureParsed.required_marker_occurrence_count
if ($AkCaptureMarkerCount -ne 1 -or -not $AkCaptureParsed.parsed_record.marker_pass) {
    Stop-Task0024AKWrapperCapture "MARKER_LITERAL_OCCURRENCE_FAILED:$AkCaptureMarkerCount"
}
if ($AkStderrPolicy -eq 'RequireEmpty' -and @($AkCaptureParsed.parsed_record.stderr).Count -ne 0) {
    Stop-Task0024AKWrapperCapture 'STDERR_NOT_EMPTY'
}
if ($AkCaptureParsed.parsed_record.status -ne 'PASS' -or
    $AkCaptureParsed.parsed_record.underlying_status -ne 'PASS' -or
    [int]$AkCaptureParsed.parsed_record.native_exit_code -ne 0 -or
    $AkCaptureParsed.parsed_record.timed_out -or
    -not $AkCaptureParsed.parsed_record.stderr_pass -or
    [int]$AkCaptureParsed.parsed_record.cleanup_invocation_count -ne 1 -or
    @($AkCaptureParsed.parsed_record.cleanup_order).Count -ne 1 -or
    @($AkCaptureParsed.parsed_record.remaining_owned_pids).Count -ne 0 -or
    @($AkCaptureParsed.parsed_record.remaining_unproven_pids).Count -ne 0 -or
    -not [string]::IsNullOrEmpty([string]$AkCaptureParsed.parsed_record.wrapper_error) -or
    -not [string]::IsNullOrEmpty([string]$AkCaptureParsed.parsed_record.cleanup_error)) {
    Stop-Task0024AKWrapperCapture 'WRAPPER_PASS_CONTRACT_FAILED'
}
[ordered]@{
    godot_count_before = $AkCaptureBefore
    godot_count_after = $AkCaptureAfter
    raw_wrapper_json = $AkCaptureParsed.raw_wrapper_json
    raw_utf8_byte_count = $AkCaptureParsed.raw_utf8_byte_count
    raw_utf8_sha256 = $AkCaptureParsed.raw_utf8_sha256
    marker_count = $AkCaptureMarkerCount
    parsed_record = $AkCaptureParsed.parsed_record
} | ConvertTo-Json -Depth 100 -Compress

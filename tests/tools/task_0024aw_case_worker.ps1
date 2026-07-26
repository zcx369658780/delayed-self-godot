[CmdletBinding()]
param(
    [Parameter(Mandatory)][string]$OutputPath,
    [Parameter(Mandatory)][string]$RunId,
    [Parameter(Mandatory)][int]$Ordinal,
    [Parameter(Mandatory)][string]$CaseName,
    [Parameter(Mandatory)][string]$ScriptPath,
    [Parameter(Mandatory)][string]$Marker,
    [Parameter(Mandatory)][ValidateSet('RequireEmpty','AggregateMismatch')][string]$EvidenceStderrPolicy
)

$ErrorActionPreference = 'Stop'
$root = 'D:\Delayed_Self'
$wrapper = Join-Path $root 'tests\tools\run_owned_godot_headless.ps1'
$godot = 'D:\Program Files (x86)\Steam\steamapps\common\Godot Engine\godot.windows.opt.tools.64.exe'
$before = @(Get-Process godot* -ErrorAction SilentlyContinue).Count
if ($before -ne 0) { throw "PREEXISTING_GODOT:$before" }
$wrapperPolicy = if ($EvidenceStderrPolicy -eq 'RequireEmpty') { 'ForbidNonempty' } else { 'Allow' }
$raw = & pwsh -NoProfile -NonInteractive -File $wrapper `
    -GodotPath $godot -ProjectPath $root -ScriptPath $ScriptPath `
    -TimeoutSeconds 180 -RequiredMarker $Marker -StderrPolicy $wrapperPolicy | Out-String
$raw = $raw.Trim()
$parsed = $raw | ConvertFrom-Json -Depth 100
$after = @(Get-Process godot* -ErrorAction SilentlyContinue).Count
$stderr = @($parsed.stderr)
$stderrOk = if ($EvidenceStderrPolicy -eq 'RequireEmpty') {
    $stderr.Count -eq 0
} else {
    $stderr.Count -eq 1 -and $stderr[0] -eq 'LEVEL_ID_MISMATCH'
}
$markerCount = @($parsed.stdout | Where-Object { $_ -eq $Marker }).Count
$ok = $parsed.status -eq 'PASS' -and $parsed.native_exit_code -eq 0 -and
    $parsed.cleanup_invocation_count -eq 1 -and
    @($parsed.remaining_owned_pids).Count -eq 0 -and
    @($parsed.remaining_unproven_pids).Count -eq 0 -and
    $markerCount -eq 1 -and $stderrOk -and $before -eq 0 -and $after -eq 0
$sha = [Convert]::ToHexString([Security.Cryptography.SHA256]::HashData(
    [Text.Encoding]::UTF8.GetBytes($raw)))
$record = [ordered]@{
    schema_version = 1
    task_identity = '0024AW'
    run_id = $RunId
    ordinal = $Ordinal
    case_name = $CaseName
    script_path = $ScriptPath
    required_marker = $Marker
    evidence_stderr_policy = $EvidenceStderrPolicy
    status = if ($ok) { 'PASS' } else { 'FAIL' }
    marker_occurrence_count = $markerCount
    godot_before_count = $before
    godot_after_count = $after
    raw_wrapper_sha256 = $sha
    raw_wrapper_json = $raw
    source = $parsed
    created_utc = [DateTime]::UtcNow.ToString('o')
}
$json = $record | ConvertTo-Json -Depth 100 -Compress
$temporary = "$OutputPath.tmp.$PID"
[IO.File]::WriteAllText($temporary, $json, [Text.UTF8Encoding]::new($false))
Move-Item -LiteralPath $temporary -Destination $OutputPath
$reopened = [IO.File]::ReadAllText($OutputPath, [Text.Encoding]::UTF8) | ConvertFrom-Json -Depth 100
if ($reopened.run_id -ne $RunId -or $reopened.status -ne $record.status) {
    throw 'DURABLE_REOPEN_MISMATCH'
}
if (-not $ok) { exit 1 }
Write-Output $OutputPath

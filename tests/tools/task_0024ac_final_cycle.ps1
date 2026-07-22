[CmdletBinding()]
param()

$ErrorActionPreference = 'Stop'
$root = 'D:\Delayed_Self'
$manifestPath = Join-Path $root 'tests\tools\task_0024ac_final_cycle_manifest.json'
$runCasePath = Join-Path $root 'tests\tools\task_0024ac_run_case.ps1'
$captureParserPath = Join-Path $root 'tests\tools\task_0024ac_validate_capture.ps1'
$attemptPath = Join-Path $root 'tests\tools\task_0024ac_final_cycle_invocation.json'
$progressPath = Join-Path $root 'tests\tools\task_0024ac_final_cycle_progress.json'
$capturePath = 'tests/tools/task_0024ac_final_case_01_capture_validation.json'
foreach ($path in @($attemptPath, $progressPath, (Join-Path $root $capturePath))) { if (Test-Path -LiteralPath $path) { throw "Final cycle already declared or consumed: $path" } }
$manifest = Get-Content -LiteralPath $manifestPath -Raw | ConvertFrom-Json -Depth 100
if ($manifest.task -ne '0024AC' -or $manifest.cycle_kind -ne 'FRESH_RETAINED_FINAL' -or @($manifest.cases).Count -ne 6) { throw 'Invalid final manifest identity/cardinality' }
for ($index = 0; $index -lt 6; $index++) {
    $case = $manifest.cases[$index]
    if ($case.ordinal -ne $index + 1) { throw "Manifest ordinal mismatch at $index" }
    if (Test-Path -LiteralPath (Join-Path $root $case.record)) { throw "Final case record already exists: $($case.record)" }
}
$godotBefore = @(Get-CimInstance Win32_Process -Filter "Name LIKE 'godot%'" -ErrorAction SilentlyContinue).Count
if ($godotBefore -ne 0) { throw "Expected zero Godot before final declaration, observed $godotBefore" }
$invocation = [ordered]@{
    schema_version = 1
    task = '0024AC'
    invocation_id = [Guid]::NewGuid().ToString()
    status = 'DECLARED_AND_CONSUMED'
    started_utc = [DateTime]::UtcNow.ToString('o')
    head = (git -C $root rev-parse HEAD).Trim()
    manifest_sha256 = (Get-FileHash -LiteralPath $manifestPath -Algorithm SHA256).Hash.ToLowerInvariant()
    candidate_sha256 = (Get-FileHash -LiteralPath (Join-Path $root 'data\levels\lasting_echo_latch.json') -Algorithm SHA256).Hash.ToLowerInvariant()
    godot_before = $godotBefore
}
$progress = [ordered]@{ schema_version = 1; task = '0024AC'; invocation_id = $invocation.invocation_id; stage = 'DECLARED'; completed_cases = @(); updated_utc = [DateTime]::UtcNow.ToString('o') }
$utf8 = [Text.UTF8Encoding]::new($false)
[IO.File]::WriteAllText($attemptPath, ($invocation | ConvertTo-Json -Depth 20) + "`n", $utf8)
[IO.File]::WriteAllText($progressPath, ($progress | ConvertTo-Json -Depth 100) + "`n", $utf8)
foreach ($case in $manifest.cases) {
    $progress.stage = "BEFORE_CASE_$($case.ordinal)"
    $progress.updated_utc = [DateTime]::UtcNow.ToString('o')
    [IO.File]::WriteAllText($progressPath, ($progress | ConvertTo-Json -Depth 100) + "`n", $utf8)
    & pwsh -NoProfile -File $runCasePath -ScriptPath $case.script -RequiredMarker $case.marker -OutputPath $case.record -StderrPolicy $case.stderr_policy -TimeoutSeconds $case.timeout_seconds
    if ($LASTEXITCODE -ne 0) { throw "Final case $($case.ordinal) failed with runner exit $LASTEXITCODE" }
    $progress.completed_cases = @($progress.completed_cases) + [ordered]@{ ordinal = $case.ordinal; name = $case.name; record = $case.record; record_sha256 = (Get-FileHash -LiteralPath (Join-Path $root $case.record) -Algorithm SHA256).Hash.ToLowerInvariant(); completed_utc = [DateTime]::UtcNow.ToString('o') }
    $progress.stage = "AFTER_CASE_$($case.ordinal)"
    $progress.updated_utc = [DateTime]::UtcNow.ToString('o')
    [IO.File]::WriteAllText($progressPath, ($progress | ConvertTo-Json -Depth 100) + "`n", $utf8)
    if ($case.ordinal -eq 1) {
        & pwsh -NoProfile -File $captureParserPath -RecordPath $case.record -OutputPath $capturePath -Phase FINAL
        if ($LASTEXITCODE -ne 0) { throw "Final focused capture validation failed with exit $LASTEXITCODE" }
        $progress.focused_capture_sha256 = (Get-FileHash -LiteralPath (Join-Path $root $capturePath) -Algorithm SHA256).Hash.ToLowerInvariant()
        $progress.stage = 'AFTER_FOCUSED_CAPTURE'
        $progress.updated_utc = [DateTime]::UtcNow.ToString('o')
        [IO.File]::WriteAllText($progressPath, ($progress | ConvertTo-Json -Depth 100) + "`n", $utf8)
    }
}
$progress.stage = 'AFTER_ALL_CASES'
$progress.final_godot_count = @(Get-CimInstance Win32_Process -Filter "Name LIKE 'godot%'" -ErrorAction SilentlyContinue).Count
$progress.completed_utc = [DateTime]::UtcNow.ToString('o')
$progress.updated_utc = $progress.completed_utc
[IO.File]::WriteAllText($progressPath, ($progress | ConvertTo-Json -Depth 100) + "`n", $utf8)
if ($progress.final_godot_count -ne 0) { throw "Final Godot count nonzero: $($progress.final_godot_count)" }
Write-Output ("TASK_0024AC_FINAL_CYCLE_COMPLETE " + $invocation.invocation_id)

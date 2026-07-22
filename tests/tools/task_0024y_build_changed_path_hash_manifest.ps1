[CmdletBinding()]
param()

$ErrorActionPreference = 'Stop'
$root = 'D:\Delayed_Self'
$outputRelative = 'tests/tools/task_0024y_changed_path_hash_manifest.json'
$reportRelative = 'docs/reports/0024Y_SEQUENCE_9_CRATE_SHADOW_TIMING_MACHINE_VALIDATION_REPORT.md'
$outputPath = Join-Path $root $outputRelative
if (Test-Path -LiteralPath $outputPath) {
    throw "Changed-path manifest already exists: $outputPath"
}
$statusLines = @(git -C $root status --short --untracked-files=all)
$paths = @($statusLines | ForEach-Object { $_.Substring(3).Replace('\', '/') } | Sort-Object -Unique)
$entries = @()
foreach ($relative in $paths) {
    if ($relative -eq $outputRelative -or $relative -eq $reportRelative) {
        continue
    }
    $absolute = Join-Path $root $relative
    if (-not (Test-Path -LiteralPath $absolute -PathType Leaf)) {
        throw "Changed path is not a regular file: $relative"
    }
    $entries += [ordered]@{
        path = $relative
        sha256 = (Get-FileHash -LiteralPath $absolute -Algorithm SHA256).Hash.ToLowerInvariant()
    }
}
$manifest = [ordered]@{
    schema_version = 1
    task = '0024Y'
    generated_utc = [DateTime]::UtcNow.ToString('o')
    entry_count = $entries.Count
    entries = $entries
    self_exclusion = $outputRelative
    self_referential_report_exclusion = $reportRelative
}
$utf8NoBom = [Text.UTF8Encoding]::new($false)
[IO.File]::WriteAllText($outputPath, ($manifest | ConvertTo-Json -Depth 10) + "`n", $utf8NoBom)
Write-Output ("TASK_0024Y_CHANGED_PATH_HASH_MANIFEST_WRITTEN " + $outputPath)

[CmdletBinding()]
param()

$ErrorActionPreference = 'Stop'
$root = 'D:\Delayed_Self'
$outputRelative = 'tests/tools/task_0024z_changed_path_hash_manifest.json'
$reportRelative = 'docs/reports/0024Z_SEQUENCE_10_KEY_ROUTE_COMMITMENT_MACHINE_VALIDATION_REPORT.md'
$outputPath = Join-Path $root $outputRelative
if (Test-Path -LiteralPath $outputPath) { throw "Manifest already exists: $outputPath" }
$statusLines = @(git -C $root status --porcelain=v1 --untracked-files=all)
$paths = [Collections.Generic.List[string]]::new()
foreach ($line in $statusLines) {
    if ($line.Length -lt 4) { continue }
    $relative = $line.Substring(3).Replace('\', '/')
    if ($relative -eq $outputRelative -or $relative -eq $reportRelative) { continue }
    $paths.Add($relative)
}
$unique = @($paths | Sort-Object -Unique)
$entries = [Collections.Generic.List[object]]::new()
foreach ($relative in $unique) {
    $path = Join-Path $root $relative
    if (-not (Test-Path -LiteralPath $path -PathType Leaf)) { throw "Changed path is not a file: $relative" }
    $entries.Add([ordered]@{ path = $relative; sha256 = (Get-FileHash -LiteralPath $path -Algorithm SHA256).Hash.ToLowerInvariant(); length = (Get-Item -LiteralPath $path).Length })
}
$manifest = [ordered]@{ schema_version = 1; task = '0024Z'; generated_utc = [DateTime]::UtcNow.ToString('o'); excluded_self = $outputRelative; excluded_report = $reportRelative; included_path_count = $entries.Count; entries = @($entries) }
$utf8NoBom = [Text.UTF8Encoding]::new($false)
[IO.File]::WriteAllText($outputPath, ($manifest | ConvertTo-Json -Depth 10) + "`n", $utf8NoBom)
Write-Output ("TASK_0024Z_CHANGED_PATH_HASH_MANIFEST_WRITTEN " + $outputPath)

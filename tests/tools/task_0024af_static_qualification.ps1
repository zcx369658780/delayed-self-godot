[CmdletBinding()]
param()

$ErrorActionPreference = 'Stop'
$root = (git rev-parse --show-toplevel).Trim()
if ($root -ne 'D:/Delayed_Self') { throw 'TASK_0024AF_STATIC_FAIL_ROOT' }
$allowed = @(
    'scripts/gameplay/schema_v2_presentation.gd',
    'scripts/gameplay/schema_v2_presentation.gd.uid',
    'scripts/gameplay/vertical_slice.gd',
    'tests/presentation/task_0024af_schema_v2_minimum_visual_validation.gd',
    'tests/presentation/task_0024af_schema_v2_minimum_visual_validation.gd.uid',
    'tests/tools/task_0024af_static_qualification.ps1'
)
$changed = @(git status --porcelain=v1 --untracked-files=all | ForEach-Object { $_.Substring(3).Replace('\','/') } | Where-Object { $_ -ne '.codex/config.toml' })
$outside = @($changed | Where-Object {
    $_ -notin $allowed -and
    $_ -notlike 'tests/tools/task_0024af_*' -and
    $_ -notlike 'docs/presentation/SCHEMA_V2_MINIMUM_OWNER_REVIEW_VISUAL_CONTRACT_CURRENT.md' -and
    $_ -notlike 'docs/playtest/SUBMISSION_CORE_1_12_OWNER_CURRICULUM_REVIEW_CURRENT.md' -and
    $_ -notlike 'docs/reports/0024AF_SCHEMA_V2_MINIMUM_OWNER_REVIEW_VISUAL_PRESENTATION_REPORT.md' -and
    $_ -notlike 'docs/CODEX_*_CURRENT.md' -and
    $_ -notlike 'docs/DEVELOPMENT_PLAN_CURRENT.md' -and
    $_ -notlike 'docs/DOC_INDEX_CURRENT.md' -and
    $_ -notlike 'docs/HANDOFF_MASTER_CURRENT.md' -and
    $_ -notlike 'docs/project_memory.md' -and
    $_ -notlike 'docs/production/EXPANDED_CONTENT_SUBMISSION_ROADMAP_CURRENT.md'
})
$config = Join-Path $root '.codex/config.toml'
$configUnstaged = -not (git diff --cached --name-only | Select-String -SimpleMatch '.codex/config.toml' -Quiet)
$baseline = git show 6ce55238c111b0523c72b9168505f107cc5825ea:scripts/gameplay/vertical_slice.gd
$current = Get-Content -Raw (Join-Path $root 'scripts/gameplay/vertical_slice.gd')
$helper = Get-Content -Raw (Join-Path $root 'scripts/gameplay/schema_v2_presentation.gd')
$forbiddenHelper = @('transition(', 'restart(', 'load_file(', 'FileAccess', 'DirAccess', 'Profile', 'Catalog', 'user://') | Where-Object { $helper -match [regex]::Escape($_) }
$verticalPreservesRoutes = $current.Contains('func configure_route_payload') -and $current.Contains('func _restart_level') -and $current.Contains('func _unhandled_input') -and $current.Contains('func _request_acknowledgement_return_once')
$result = [ordered]@{
    prefix = 'TASK_0024AF_STATIC_QUALIFICATION'
    checkpoint = '6ce55238c111b0523c72b9168505f107cc5825ea'
    changed_paths = @($changed)
    outside_allowlist = @($outside)
    config_exists = (Test-Path -LiteralPath $config)
    config_unstaged = $configUnstaged
    vertical_baseline_available = -not [string]::IsNullOrWhiteSpace($baseline)
    vertical_route_markers_preserved = $verticalPreservesRoutes
    helper_forbidden_hits = @($forbiddenHelper)
    status = if ($outside.Count -eq 0 -and $configUnstaged -and $verticalPreservesRoutes -and $forbiddenHelper.Count -eq 0) { 'PASS' } else { 'FAIL' }
}
$json = $result | ConvertTo-Json -Compress -Depth 4
if ([Text.Encoding]::UTF8.GetByteCount('TASK_0024AF_STATIC_QUALIFICATION ' + $json) -ge 1800) { throw 'TASK_0024AF_STATIC_FAIL_RECORD_BOUND' }
Write-Output ('TASK_0024AF_STATIC_QUALIFICATION ' + $json)
if ($result.status -ne 'PASS') { exit 1 }

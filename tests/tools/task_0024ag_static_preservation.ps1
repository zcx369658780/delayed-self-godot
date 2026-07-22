[CmdletBinding()]
param([string]$RepositoryRoot = (Resolve-Path (Join-Path $PSScriptRoot '..\..')).Path)
Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'
$baseline = '25d7fda3937fc269cdf730c14698e47bfb209c29'
$authorized = @('scripts/gameplay/schema_v2_presentation.gd','scripts/gameplay/vertical_slice.gd','tests/presentation/task_0024ag_schema_v2_visual_correction_validation.gd','tests/presentation/task_0024ag_schema_v2_visual_correction_validation.gd.uid')
$authorized += @(git -C $RepositoryRoot ls-files --others --exclude-standard 'tests/tools/task_0024ag_*')
$changed = @(git -C $RepositoryRoot status --porcelain=v1 --untracked-files=all | ForEach-Object { $_.Substring(3).Replace('\','/') } | Where-Object { $_ -ne '.codex/config.toml' })
$unauthorized = @($changed | Where-Object { $_ -notin $authorized -and $_ -notlike 'tests/tools/task_0024ag_*' })
$helper = Join-Path $RepositoryRoot 'scripts/gameplay/schema_v2_presentation.gd'
$helperText = [IO.File]::ReadAllText($helper)
$forbiddenHelperTokens = @('load_file(', 'FileAccess', 'user://', 'Profile', 'transition(', 'restart(')
$forbiddenFound = @($forbiddenHelperTokens | Where-Object { $helperText.Contains($_) })
$historical = @('tests/tools/task_0024af_final_cycle.ps1','tests/tools/task_0024af_final_manifest.json','tests/tools/task_0024af_final_case_focused.json','tests/presentation/task_0024af_schema_v2_minimum_visual_validation.gd')
$history = foreach ($path in $historical) { [ordered]@{ path=$path; baseline_sha256=(git -C $RepositoryRoot show "$baseline`:$path" | git hash-object --stdin); current_sha256=(git -C $RepositoryRoot hash-object -- $path) } }
$config = Join-Path $RepositoryRoot '.codex\config.toml'
$configStatus = @(git -C $RepositoryRoot status --short --untracked-files=all -- '.codex/config.toml')
$result = [ordered]@{ schema_version=1; baseline=$baseline; changed_paths=@($changed); unauthorized_changed_paths=@($unauthorized); helper_forbidden_tokens=@($forbiddenFound); historical=@($history); config_untracked=($configStatus.Count -eq 1 -and $configStatus[0] -like '?? *'); status='PASS' }
if ($unauthorized.Count -ne 0 -or $forbiddenFound.Count -ne 0 -or @($history | Where-Object {$_.baseline_sha256 -ne $_.current_sha256}).Count -ne 0 -or -not $result.config_untracked) { $result.status='FAIL'; $result | ConvertTo-Json -Depth 20 -Compress; exit 1 }
$result | ConvertTo-Json -Depth 20 -Compress

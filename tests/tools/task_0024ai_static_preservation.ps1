[CmdletBinding()]param([string]$RepositoryRoot=(Resolve-Path (Join-Path $PSScriptRoot '..\..')).Path,[ValidateSet('PRE_FINAL','POST_FINAL')][string]$Phase='PRE_FINAL')
Set-StrictMode -Version Latest; $ErrorActionPreference='Stop'
$baseline='1bef7ec79898179079265a132678753da9e1c8f7'
$allowed=@('tests/presentation/task_0024ai_candidate_route_and_dynamic_signature_validation.gd','tests/presentation/task_0024ai_candidate_route_and_dynamic_signature_validation.gd.uid')
$changed=@(git -C $RepositoryRoot status --porcelain=v1 --untracked-files=all|ForEach-Object{$_.Substring(3).Replace('\','/')}|Where-Object{$_ -ne '.codex/config.toml'})
$bad=@($changed|Where-Object{$_ -notin $allowed -and $_ -notlike 'tests/tools/task_0024ai_*'})
$historical=@(git -C $RepositoryRoot ls-files 'tests/presentation/task_0024af_*' 'tests/presentation/task_0024ag_*' 'tests/presentation/task_0024ah_*' 'tests/tools/task_0024af_*' 'tests/tools/task_0024ag_*' 'tests/tools/task_0024ah_*')
$history=foreach($p in $historical){[ordered]@{path=$p;baseline_sha256=(git -C $RepositoryRoot show "$baseline`:$p"|git hash-object --stdin);current_sha256=(git -C $RepositoryRoot hash-object -- $p)}}
$config=@(git -C $RepositoryRoot status --short --untracked-files=all -- '.codex/config.toml')
$result=[ordered]@{schema_version=1;phase=$Phase;baseline=$baseline;changed_paths=@($changed);unauthorized_changed_paths=@($bad);historical=@($history);config_untracked=($config.Count -eq 1 -and $config[0] -like '?? *');status='PASS'}
if($bad.Count -or @($history|Where-Object{$_.baseline_sha256 -ne $_.current_sha256}).Count -or -not $result.config_untracked){$result.status='FAIL';$result|ConvertTo-Json -Depth 30 -Compress;exit 1};$result|ConvertTo-Json -Depth 30 -Compress

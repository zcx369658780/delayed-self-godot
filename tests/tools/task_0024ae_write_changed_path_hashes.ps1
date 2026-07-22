[CmdletBinding()]
param()

$ErrorActionPreference='Stop';$root='D:\Delayed_Self';$outputRel='tests/tools/task_0024ae_changed_path_hashes.json';$output=Join-Path $root $outputRel
if(Test-Path $output){throw 'Changed-path inventory exists'}
$paths=@(git -C $root status --porcelain=v1 --untracked-files=all|ForEach-Object{([string]$_).Substring(3).Replace('\','/')}|Where-Object{$_-ne$outputRel}|Sort-Object -Unique)
$entries=[ordered]@{};foreach($relative in $paths){$absolute=Join-Path $root $relative;if(-not(Test-Path $absolute -PathType Leaf)){throw "Changed path is not a file: $relative"};$entries[$relative]=(Get-FileHash $absolute -Algorithm SHA256).Hash.ToLowerInvariant()}
$result=[ordered]@{schema_version=1;task='0024AE';status='PASS';hash_algorithm='SHA-256';inventory_self_path=$outputRel;inventory_self_excluded_because_self_referential=$true;changed_file_count_excluding_inventory=$entries.Count;files=$entries}
[IO.File]::WriteAllText($output,($result|ConvertTo-Json -Depth 100)+"`n",[Text.UTF8Encoding]::new($false));Write-Output ('TASK_0024AE_CHANGED_PATH_HASHES_WRITTEN '+$entries.Count)

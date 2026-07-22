[CmdletBinding()]
param()

$ErrorActionPreference='Stop'; $root='D:\Delayed_Self'
$manifestPath=Join-Path $root 'tests\tools\task_0024ad_final_cycle_manifest.json'; $runCasePath=Join-Path $root 'tests\tools\task_0024ad_run_case.ps1'; $parserPath=Join-Path $root 'tests\tools\task_0024ad_validate_capture.ps1'
$invocationPath=Join-Path $root 'tests\tools\task_0024ad_final_cycle_invocation.json'; $progressPath=Join-Path $root 'tests\tools\task_0024ad_final_cycle_progress.json'; $capturePath='tests/tools/task_0024ad_final_case_01_capture_validation.json'
foreach($path in @($invocationPath,$progressPath,(Join-Path $root $capturePath))){if(Test-Path -LiteralPath $path){throw "Final cycle already declared or consumed: $path"}}
$manifest=Get-Content -LiteralPath $manifestPath -Raw|ConvertFrom-Json -Depth 100
if($manifest.task -ne '0024AD' -or $manifest.cycle_kind -ne 'FRESH_RETAINED_FINAL' -or @($manifest.cases).Count -ne 7){throw 'Invalid final manifest'}
for($index=0;$index -lt 7;$index++){if($manifest.cases[$index].ordinal -ne $index+1){throw 'Manifest ordinal mismatch'};if(Test-Path -LiteralPath (Join-Path $root $manifest.cases[$index].record)){throw 'Final case record already exists'}}
$godotBefore=@(Get-CimInstance Win32_Process -Filter "Name LIKE 'godot%'" -ErrorAction SilentlyContinue).Count;if($godotBefore -ne 0){throw "Expected zero Godot before final declaration"}
$invocation=[ordered]@{schema_version=1;task='0024AD';invocation_id=[Guid]::NewGuid().ToString();status='DECLARED_AND_CONSUMED';started_utc=[DateTime]::UtcNow.ToString('o');head=(git -C $root rev-parse HEAD).Trim();manifest_sha256=(Get-FileHash -LiteralPath $manifestPath -Algorithm SHA256).Hash.ToLowerInvariant();godot_before=$godotBefore}
$progress=[ordered]@{schema_version=1;task='0024AD';invocation_id=$invocation.invocation_id;stage='DECLARED';completed_cases=@();updated_utc=[DateTime]::UtcNow.ToString('o')};$utf8=[Text.UTF8Encoding]::new($false)
[IO.File]::WriteAllText($invocationPath,($invocation|ConvertTo-Json -Depth 20)+"`n",$utf8);[IO.File]::WriteAllText($progressPath,($progress|ConvertTo-Json -Depth 100)+"`n",$utf8)
foreach($case in $manifest.cases){
    $progress.stage="BEFORE_CASE_$($case.ordinal)";$progress.updated_utc=[DateTime]::UtcNow.ToString('o');[IO.File]::WriteAllText($progressPath,($progress|ConvertTo-Json -Depth 100)+"`n",$utf8)
    & pwsh -NoProfile -File $runCasePath -ScriptPath $case.script -RequiredMarker $case.marker -OutputPath $case.record -StderrPolicy $case.stderr_policy -TimeoutSeconds $case.timeout_seconds
    if($LASTEXITCODE -ne 0){throw "Final case $($case.ordinal) failed"}
    $progress.completed_cases=@($progress.completed_cases)+[ordered]@{ordinal=$case.ordinal;name=$case.name;record=$case.record;record_sha256=(Get-FileHash -LiteralPath (Join-Path $root $case.record) -Algorithm SHA256).Hash.ToLowerInvariant();completed_utc=[DateTime]::UtcNow.ToString('o')}
    $progress.stage="AFTER_CASE_$($case.ordinal)";$progress.updated_utc=[DateTime]::UtcNow.ToString('o');[IO.File]::WriteAllText($progressPath,($progress|ConvertTo-Json -Depth 100)+"`n",$utf8)
    if($case.ordinal -eq 1){& pwsh -NoProfile -File $parserPath -RecordPath $case.record -OutputPath $capturePath -Phase FINAL;if($LASTEXITCODE -ne 0){throw 'Final focused capture validation failed'};$progress.focused_capture_sha256=(Get-FileHash -LiteralPath (Join-Path $root $capturePath) -Algorithm SHA256).Hash.ToLowerInvariant();$progress.stage='AFTER_FOCUSED_CAPTURE';[IO.File]::WriteAllText($progressPath,($progress|ConvertTo-Json -Depth 100)+"`n",$utf8)}
}
$progress.stage='AFTER_ALL_CASES';$progress.final_godot_count=@(Get-CimInstance Win32_Process -Filter "Name LIKE 'godot%'" -ErrorAction SilentlyContinue).Count;$progress.completed_utc=[DateTime]::UtcNow.ToString('o');$progress.updated_utc=$progress.completed_utc;[IO.File]::WriteAllText($progressPath,($progress|ConvertTo-Json -Depth 100)+"`n",$utf8)
if($progress.final_godot_count -ne 0){throw 'Final Godot count nonzero'}
Write-Output ("TASK_0024AD_FINAL_CYCLE_COMPLETE "+$invocation.invocation_id)

[CmdletBinding()]
param()

$ErrorActionPreference='Stop';$root='D:\Delayed_Self';$utf8=[Text.UTF8Encoding]::new($false)
$manifestPath=Join-Path $root 'tests\tools\task_0024ae_final_cycle_manifest.json';$routeRunner=Join-Path $root 'tests\tools\task_0024ae_owner_review_route_runner.ps1';$genericRunner=Join-Path $root 'tests\tools\task_0024ad_run_case.ps1';$parser=Join-Path $root 'tests\tools\task_0024ae_validate_capture.ps1'
$invocationPath=Join-Path $root 'tests\tools\task_0024ae_final_cycle_invocation.json';$progressPath=Join-Path $root 'tests\tools\task_0024ae_final_cycle_progress.json';$captureRel='tests/tools/task_0024ae_final_case_01_capture_validation.json'
foreach($path in @($invocationPath,$progressPath,(Join-Path $root $captureRel))){if(Test-Path $path){throw "Final cycle already declared or consumed: $path"}}
$manifest=Get-Content $manifestPath -Raw|ConvertFrom-Json -Depth 50;if($manifest.task-ne'0024AE'-or$manifest.cycle_kind-ne'FRESH_RETAINED_FINAL'-or@($manifest.cases).Count-ne 4){throw 'Invalid final manifest'}
for($i=0;$i-lt 4;$i++){if($manifest.cases[$i].ordinal-ne$i+1){throw 'Manifest ordinal mismatch'};if(Test-Path (Join-Path $root $manifest.cases[$i].record)){throw 'Final case record exists'}}
$godotBefore=@(Get-CimInstance Win32_Process -Filter "Name LIKE 'godot%'" -ErrorAction SilentlyContinue).Count;if($godotBefore-ne 0){throw 'Expected zero Godot before final declaration'}
$invocation=[ordered]@{schema_version=1;task='0024AE';invocation_id=[Guid]::NewGuid().ToString();status='DECLARED_AND_CONSUMED';started_utc=[DateTime]::UtcNow.ToString('o');head=(git -C $root rev-parse HEAD).Trim();manifest_sha256=(Get-FileHash $manifestPath -Algorithm SHA256).Hash.ToLowerInvariant();godot_before=$godotBefore}
$progress=[ordered]@{schema_version=1;task='0024AE';invocation_id=$invocation.invocation_id;stage='DECLARED';completed_cases=@();updated_utc=[DateTime]::UtcNow.ToString('o')}
[IO.File]::WriteAllText($invocationPath,($invocation|ConvertTo-Json -Depth 20)+"`n",$utf8);[IO.File]::WriteAllText($progressPath,($progress|ConvertTo-Json -Depth 100)+"`n",$utf8)
foreach($case in $manifest.cases){
 $progress.stage="BEFORE_CASE_$($case.ordinal)";$progress.updated_utc=[DateTime]::UtcNow.ToString('o');[IO.File]::WriteAllText($progressPath,($progress|ConvertTo-Json -Depth 100)+"`n",$utf8)
 if($case.ordinal-eq 1){& pwsh -NoProfile -File $routeRunner -OutputPath $case.record -TimeoutSeconds $case.timeout_seconds}else{& pwsh -NoProfile -File $genericRunner -ScriptPath $case.script -RequiredMarker $case.marker -OutputPath $case.record -StderrPolicy $case.stderr_policy -TimeoutSeconds $case.timeout_seconds}
 if($LASTEXITCODE-ne 0){throw "Final case $($case.ordinal) failed"}
 $record=Get-Content (Join-Path $root $case.record)-Raw|ConvertFrom-Json -Depth 100
 $expectedStderr=if($case.ordinal-eq 3){@('LEVEL_ID_MISMATCH')}else{@()};if((@($record.stderr)-join "`n")-cne($expectedStderr-join "`n")){throw "Final case $($case.ordinal) stderr mismatch"}
 $progress.completed_cases=@($progress.completed_cases)+[ordered]@{ordinal=$case.ordinal;name=$case.name;record=$case.record;record_sha256=(Get-FileHash (Join-Path $root $case.record)-Algorithm SHA256).Hash.ToLowerInvariant();completed_utc=[DateTime]::UtcNow.ToString('o')}
 $progress.stage="AFTER_CASE_$($case.ordinal)";$progress.updated_utc=[DateTime]::UtcNow.ToString('o');[IO.File]::WriteAllText($progressPath,($progress|ConvertTo-Json -Depth 100)+"`n",$utf8)
 if($case.ordinal-eq 1){& pwsh -NoProfile -File $parser -RecordPath $case.record -OutputPath $captureRel -Phase FINAL;if($LASTEXITCODE-ne 0){throw 'Final route capture failed'};$progress.focused_capture_sha256=(Get-FileHash (Join-Path $root $captureRel)-Algorithm SHA256).Hash.ToLowerInvariant()}
}
$progress.stage='AFTER_ALL_CASES';$progress.final_godot_count=@(Get-CimInstance Win32_Process -Filter "Name LIKE 'godot%'" -ErrorAction SilentlyContinue).Count;$progress.completed_utc=[DateTime]::UtcNow.ToString('o');$progress.updated_utc=$progress.completed_utc;[IO.File]::WriteAllText($progressPath,($progress|ConvertTo-Json -Depth 100)+"`n",$utf8);if($progress.final_godot_count-ne 0){throw 'Final Godot count nonzero'}
Write-Output ('TASK_0024AE_FINAL_CYCLE_COMPLETE '+$invocation.invocation_id)

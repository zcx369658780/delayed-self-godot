[CmdletBinding()]
param()

$ErrorActionPreference='Stop';$root='D:\Delayed_Self';$utf8=[Text.UTF8Encoding]::new($false);$output=Join-Path $root 'tests\tools\task_0024ae_final_summary.json'
if(Test-Path $output){throw 'Final summary exists'}
$manifest=Get-Content (Join-Path $root 'tests\tools\task_0024ae_final_cycle_manifest.json') -Raw|ConvertFrom-Json -Depth 50
$invocation=Get-Content (Join-Path $root 'tests\tools\task_0024ae_final_cycle_invocation.json') -Raw|ConvertFrom-Json -Depth 50
$progress=Get-Content (Join-Path $root 'tests\tools\task_0024ae_final_cycle_progress.json') -Raw|ConvertFrom-Json -Depth 100
$cases=[Collections.Generic.List[object]]::new();$errors=[Collections.Generic.List[string]]::new()
foreach($case in $manifest.cases){
 $path=Join-Path $root $case.record;$record=Get-Content $path -Raw|ConvertFrom-Json -Depth 100;$expectedStderr=if($case.ordinal-eq 3){@('LEVEL_ID_MISMATCH')}else{@()}
 $valid=$record.status-eq'PASS'-and$record.native_exit_code-eq 0-and$record.required_marker_count-eq 1-and$record.cleanup_invocation_count-eq 1-and@($record.remaining_owned_pids).Count-eq 0-and@($record.remaining_unproven_pids).Count-eq 0-and$record.godot_before_count-eq 0-and$record.godot_after_count-eq 0-and((@($record.stderr)-join"`n")-ceq($expectedStderr-join"`n"))
 if(-not$valid){$errors.Add("case:$($case.ordinal)")}
 $cases.Add([ordered]@{ordinal=$case.ordinal;name=$case.name;status=$record.status;native_exit_code=$record.native_exit_code;marker=$case.marker;marker_count=$record.required_marker_count;stderr=@($record.stderr);cleanup_invocation_count=$record.cleanup_invocation_count;remaining_owned_pids=@($record.remaining_owned_pids);remaining_unproven_pids=@($record.remaining_unproven_pids);godot_before=$record.godot_before_count;godot_after=$record.godot_after_count;record=$case.record;sha256=(Get-FileHash $path -Algorithm SHA256).Hash.ToLowerInvariant()})
}
$qualifications=@('003','004')|ForEach-Object{Get-Content (Join-Path $root "tests\tools\task_0024ae_qualification_capture_$_.json") -Raw|ConvertFrom-Json -Depth 100}
if(@($qualifications|Where-Object{$_.status-ne'PASS'}).Count-ne 0){$errors.Add('repeatable_qualification')}
$parser=Get-Content (Join-Path $root 'tests\tools\task_0024ae_capture_parser_qualification.json') -Raw|ConvertFrom-Json -Depth 100;if($parser.status-ne'PASS'){$errors.Add('parser_qualification')}
$pre=Get-Content (Join-Path $root 'tests\tools\task_0024ae_pre_final_static_qualification.json') -Raw|ConvertFrom-Json -Depth 100;$post=Get-Content (Join-Path $root 'tests\tools\task_0024ae_post_final_static_qualification.json') -Raw|ConvertFrom-Json -Depth 100;if($pre.status-ne'PASS'-or$post.status-ne'PASS'){$errors.Add('frozen_audit')}
if($progress.stage-ne'AFTER_ALL_CASES'-or@($progress.completed_cases).Count-ne 4-or$progress.final_godot_count-ne 0){$errors.Add('final_progress')}
$result=[ordered]@{schema_version=1;task='0024AE';status=if($errors.Count-eq 0){'PASS'}else{'FAIL'};verdict=if($errors.Count-eq 0){'ISOLATED_STAGING_OWNER_REVIEW_ROUTE_READY_FOR_GPT_REVIEW'}else{'BLOCKED_ISOLATED_STAGING_OWNER_REVIEW_ROUTE'};invocation_id=$invocation.invocation_id;head=$invocation.head;manifest_sha256=$invocation.manifest_sha256;cases=@($cases);route_capture_sha256=(Get-FileHash (Join-Path $root 'tests\tools\task_0024ae_final_case_01_capture_validation.json') -Algorithm SHA256).Hash.ToLowerInvariant();repeatable_qualification_count=$qualifications.Count;capture_parser_status=$parser.status;pre_final_status=$pre.status;post_final_status=$post.status;frozen_mismatch_count=$post.frozen_mismatch_count;accepted_0024ad_mismatch_count=$post.accepted_0024ad_mismatch_count;production_profile_probe_count=0;test_profile_root_enumeration_count=0;owner_route_status='MACHINE_QUALIFIED_ISOLATED_STAGING_ROUTE';owner_playthrough_status='NOT_YET_REVIEWED';presentation_readiness='BLOCKED_SCHEMA_V2_VISUALS';catalog_admission_status='NOT_AUTHORIZED';final_godot_count=$progress.final_godot_count;errors=@($errors)}
[IO.File]::WriteAllText($output,($result|ConvertTo-Json -Depth 100)+"`n",$utf8);Write-Output ('TASK_0024AE_FINAL_SUMMARY_'+$result.status);if($errors.Count-ne 0){exit 1}

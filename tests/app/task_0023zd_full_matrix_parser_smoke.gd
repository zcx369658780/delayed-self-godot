extends SceneTree

const FullMatrixBehavior = preload("res://tests/app/task_0023zd_app_root_profile_session_full_matrix.gd")
const AppRootScript = preload("res://scripts/app/app_root.gd")
const AppRootScene = preload("res://scenes/app/app_root.tscn")
const LocalProfile = preload("res://scripts/app/local_profile.gd")
const ProfileProgressAdapter = preload("res://scripts/app/profile_progress_adapter.gd")


func _initialize() -> void:
	call_deferred("_run")


func _run() -> void:
	if FullMatrixBehavior == null or AppRootScript == null or AppRootScene == null or LocalProfile == null or ProfileProgressAdapter == null:
		quit(1)
		return
	print("TASK_0023ZL_FULL_MATRIX_PARSER_SMOKE_PASS")
	quit(0)

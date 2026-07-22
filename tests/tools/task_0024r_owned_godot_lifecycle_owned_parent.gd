extends SceneTree

func _init() -> void:
	var project_root := ProjectSettings.globalize_path("res://").trim_suffix("/")
	var child_pid := OS.create_process(
		OS.get_executable_path(),
		[
			"--headless",
			"--path",
			project_root,
			"--script",
			"res://tests/tools/task_0024r_owned_godot_lifecycle_owned_child.gd",
		],
		false
	)
	print("TASK_0024R_OWNED_CHILD_PID=%d" % child_pid)
	await create_timer(60.0).timeout
	quit(0)

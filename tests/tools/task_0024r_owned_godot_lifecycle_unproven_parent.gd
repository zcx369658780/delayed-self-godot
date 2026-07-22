extends SceneTree

func _init() -> void:
	var helper_executable := ""
	var helper_script := ""
	for argument in OS.get_cmdline_user_args():
		if argument.begins_with("--helper-executable="):
			helper_executable = argument.trim_prefix("--helper-executable=")
		elif argument.begins_with("--helper-script="):
			helper_script = argument.trim_prefix("--helper-script=")
	if helper_executable.is_empty() or helper_script.is_empty():
		printerr("TASK_0024R_HELPER_ARGUMENT_MISSING")
		quit(9)
		return
	var helper_pid := OS.create_process(
		helper_executable,
		[
			"-NoProfile",
			"-File",
			helper_script,
			"-SleepMilliseconds",
			"2500",
			"-CaseToken",
			"TASK_0024R_UNPROVEN_SELF_EXIT",
		],
		false
	)
	print("TASK_0024R_UNPROVEN_HELPER_PID=%d" % helper_pid)
	await create_timer(60.0).timeout
	quit(0)

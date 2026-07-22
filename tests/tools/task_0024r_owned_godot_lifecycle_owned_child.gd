extends SceneTree

func _init() -> void:
	print("TASK_0024R_OWNED_CHILD_READY")
	await create_timer(2.5).timeout
	quit(0)

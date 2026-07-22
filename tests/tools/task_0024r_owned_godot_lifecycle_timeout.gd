extends SceneTree

func _init() -> void:
	await create_timer(60.0).timeout
	quit(0)

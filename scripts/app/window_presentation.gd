class_name DelayedSelfWindowPresentation
extends RefCounted

const LOGICAL_SIZE := Vector2(960, 540)
const BAR_COLOR := Color("000000")


static func content_transform(client_size: Vector2i) -> Dictionary:
	var client := Vector2(client_size)
	if client.x <= 0.0 or client.y <= 0.0:
		return {
			"client_size": client,
			"scale": 0.0,
			"content_rect": Rect2(),
			"bars": {"left": 0.0, "right": 0.0, "top": 0.0, "bottom": 0.0},
		}
	var uniform_scale: float = min(client.x / LOGICAL_SIZE.x, client.y / LOGICAL_SIZE.y)
	var content_size := LOGICAL_SIZE * uniform_scale
	var offset := (client - content_size) * 0.5
	return {
		"client_size": client,
		"scale": uniform_scale,
		"content_rect": Rect2(offset, content_size),
		"bars": {
			"left": offset.x,
			"right": client.x - content_size.x - offset.x,
			"top": offset.y,
			"bottom": client.y - content_size.y - offset.y,
		},
	}

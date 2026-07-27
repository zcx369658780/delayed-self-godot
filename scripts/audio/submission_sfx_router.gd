class_name SubmissionSfxRouter
extends Node

const EVENT_UI_FOCUS_OR_MOVE := "ui_focus_or_move"
const EVENT_UI_CONFIRM := "ui_confirm"
const EVENT_YOU_MOVE := "YOU_move"
const EVENT_ECHO_MOVE := "ECHO_move"
const EVENT_BLOCKED_OR_INVALID := "blocked_or_invalid"
const EVENT_LEVEL_COMPLETE := "level_complete"
const EVENT_ORDER := [EVENT_UI_FOCUS_OR_MOVE, EVENT_UI_CONFIRM, EVENT_YOU_MOVE, EVENT_ECHO_MOVE, EVENT_BLOCKED_OR_INVALID, EVENT_LEVEL_COMPLETE]

const FOCUS_DEBOUNCE_MSEC := 180

const EVENT_MAP := {
	EVENT_UI_FOCUS_OR_MOVE: {
		"label": "UI_FOCUS_OR_MOVE",
		"path": "res://audio/sfx/ui/focus_move.wav",
		"bus": "UI",
		"volume_db": -4.0,
	},
	EVENT_UI_CONFIRM: {
		"label": "UI_CONFIRM",
		"path": "res://audio/sfx/ui/confirm.wav",
		"bus": "UI",
		"volume_db": -2.0,
	},
	EVENT_YOU_MOVE: {
		"label": "YOU_MOVE",
		"path": "res://audio/sfx/gameplay/you_move.wav",
		"bus": "Gameplay",
		"volume_db": -1.0,
	},
	EVENT_ECHO_MOVE: {
		"label": "ECHO_MOVE",
		"path": "res://audio/sfx/gameplay/echo_move.wav",
		"bus": "Gameplay",
		"volume_db": -1.5,
	},
	EVENT_BLOCKED_OR_INVALID: {
		"label": "BLOCKED_OR_INVALID",
		"path": "res://audio/sfx/gameplay/blocked_invalid.wav",
		"bus": "Gameplay",
		"volume_db": -3.0,
	},
	EVENT_LEVEL_COMPLETE: {
		"label": "LEVEL_COMPLETE",
		"path": "res://audio/sfx/gameplay/level_complete.wav",
		"bus": "Gameplay",
		"volume_db": -0.5,
	},
}

var _bus_players: Dictionary = {}
var _streams: Dictionary = {}
var _last_focus_ms: int = -1
var _level_complete_fired: bool = false
var _accepted_event_history: Array[String] = []


func _init() -> void:
	name = "SubmissionSfxRouter"


func _ready() -> void:
	_preload_events()


static func ensure_router(tree: SceneTree) -> Node:
	if tree == null or tree.root == null:
		return null
	for child in tree.root.get_children():
		if child.name == "SubmissionSfxRouter" and child.has_method("play_event"):
			return child
	var existing := tree.root.get_node_or_null("SubmissionSfxRouter")
	if existing != null and existing.has_method("play_event"):
		return existing
	var router: Node = (load("res://scripts/audio/submission_sfx_router.gd") as Script).new()
	router.name = "SubmissionSfxRouter"
	tree.root.add_child(router)
	return router


func play_event(event_id: String, now_msec: int = -1, emit_audio: bool = true) -> bool:
	if not EVENT_MAP.has(event_id):
		return false
	_ensure_ready()
	if event_id == EVENT_UI_FOCUS_OR_MOVE and _focus_spam(now_msec):
		return false
	if event_id == EVENT_LEVEL_COMPLETE and _level_complete_fired:
		return false
	if event_id == EVENT_LEVEL_COMPLETE:
		_level_complete_fired = true
	var player: AudioStreamPlayer = _bus_players.get(event_id, null)
	if player == null:
		return false
	_accepted_event_history.append(event_id)
	if not emit_audio or DisplayServer.get_name() == "headless":
		return true
	if player.playing:
		player.stop()
	player.play()
	return true


func reset_router_state() -> void:
	_last_focus_ms = -1
	_level_complete_fired = false
	_accepted_event_history.clear()


func get_event_map_snapshot() -> Dictionary:
	var snapshot: Dictionary = {}
	for event_id in EVENT_ORDER:
		var record := (EVENT_MAP[event_id] as Dictionary).duplicate(true)
		record["audio_stream_loaded"] = _streams.has(event_id)
		record["ready"] = _bus_players.has(event_id)
		snapshot[event_id] = record
	return snapshot


func movement_event_for_outcome(actor: String, moved: bool, blocked: bool = false, completed: bool = false) -> String:
	if completed:
		return EVENT_LEVEL_COMPLETE
	if blocked and actor.to_upper() == "YOU":
		return EVENT_BLOCKED_OR_INVALID
	if actor.to_upper() == "YOU":
		return EVENT_YOU_MOVE if moved else ""
	if actor.to_upper() == "ECHO":
		return EVENT_ECHO_MOVE if moved else ""
	return ""


func get_loaded_event_ids() -> Array:
	return _bus_players.keys()


func get_accepted_event_history() -> Array[String]:
	return _accepted_event_history.duplicate()


func shutdown_for_test() -> void:
	for key in _bus_players.keys():
		var player: AudioStreamPlayer = _bus_players[key]
		if is_instance_valid(player):
			player.stop()
			player.stream = null
			player.free()
	_bus_players.clear()
	_streams.clear()
	_accepted_event_history.clear()


func _focus_spam(now_msec: int) -> bool:
	var current: int = Time.get_ticks_msec() if now_msec < 0 else now_msec
	var delta: int = current - _last_focus_ms
	if _last_focus_ms >= 0 and delta < FOCUS_DEBOUNCE_MSEC:
		return true
	_last_focus_ms = current
	return false


func _ensure_ready() -> void:
	if _bus_players.is_empty():
		_preload_events()


func _preload_events() -> void:
	for event_id in EVENT_ORDER:
		if _bus_players.has(event_id):
			continue
		var config: Dictionary = EVENT_MAP[event_id]
		var stream: AudioStream = AudioStreamWAV.load_from_file(ProjectSettings.globalize_path(String(config.path)))
		if stream == null or not stream is AudioStream:
			# Keep a deterministic failure path: do not crash if assets are temporarily missing.
			continue
		var player: AudioStreamPlayer = AudioStreamPlayer.new()
		player.name = "SFX_" + event_id.to_upper()
		player.stream = stream
		player.bus = str(config.get("bus", "Master"))
		player.volume_db = float(config.get("volume_db", 0.0))
		add_child(player)
		_streams[event_id] = stream
		_bus_players[event_id] = player


func _exit_tree() -> void:
	for key in _bus_players.keys():
		var player: AudioStreamPlayer = _bus_players[key]
		if is_instance_valid(player):
			player.stop()
			player.stream = null
	_bus_players.clear()
	_streams.clear()

extends Node

const TRIAL_STREAM_PATH := "res://audio/music/crow_producer/优哉游哉(loop).wav"
const MUSIC_BUS := &"Music"
const AUDITION_VOLUME_DB := -16.0

var _player: AudioStreamPlayer


func _ready() -> void:
	if DisplayServer.get_name() == "headless":
		return
	var bus_index := AudioServer.get_bus_index(MUSIC_BUS)
	if bus_index < 0:
		return
	var trial_stream := AudioStreamWAV.load_from_file(ProjectSettings.globalize_path(TRIAL_STREAM_PATH))
	if trial_stream == null:
		return
	AudioServer.set_bus_mute(bus_index, false)
	AudioServer.set_bus_volume_db(bus_index, AUDITION_VOLUME_DB)
	trial_stream.loop_mode = AudioStreamWAV.LOOP_FORWARD
	trial_stream.loop_begin = 0
	trial_stream.loop_end = int(round(trial_stream.get_length() * float(trial_stream.mix_rate)))
	_player = AudioStreamPlayer.new()
	_player.name = "CrowProducerMusicTrial"
	_player.bus = MUSIC_BUS
	_player.stream = trial_stream
	add_child(_player)
	_player.play()

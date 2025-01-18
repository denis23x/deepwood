extends Node

@export var fade_duration: float = 1.0

@onready var audio_stream_player_2d: AudioStreamPlayer2D
@onready var mute = -20.0

func _ready() -> void:
	audio_stream_player_2d = get_node("/root/Game/AudioStreamPlayer2D")
	
func fade_out(player: AudioStreamPlayer2D) -> void:
	var elapsed_time: float = 0.0
	var initial_volume: float = player.volume_db
	
	while elapsed_time < fade_duration:
		elapsed_time += get_process_delta_time()
		var progress: float = elapsed_time / fade_duration
		player.volume_db = lerp(initial_volume, mute, progress)
		await get_tree().process_frame
		
	player.stop()
	player.volume_db = mute
	
func fade_in(player: AudioStreamPlayer2D) -> void:
	var elapsed_time: float = 0.0
	var target_volume: float = player.volume_db
	
	player.volume_db = mute
	player.play()
	
	while elapsed_time < fade_duration:
		elapsed_time += get_process_delta_time()
		var progress: float = elapsed_time / fade_duration
		player.volume_db = lerp(mute, target_volume, progress)
		await get_tree().process_frame
		
func handle_music(music: String) -> void:
	match music:
		"main":
			audio_stream_player_2d.stream =  load("res://assets/music/Where Have the Flowers Gone.mp3")
			audio_stream_player_2d.volume_db = -5.0
		"cave":
			audio_stream_player_2d.stream =  load("res://assets/music/Countersunk.mp3")
		"boss":
			audio_stream_player_2d.stream =  load("res://assets/music/Herding Cats.mp3")
			audio_stream_player_2d.volume_db = 2.5
		
	# Debug
	audio_stream_player_2d.volume_db = -80.0
	
	# Play
	fade_in(audio_stream_player_2d)

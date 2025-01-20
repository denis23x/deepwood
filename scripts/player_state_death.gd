extends AnimationState

@onready var timer: Timer = $Timer
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D

@export var walk: AnimationState

func on_enter() -> void:
	playback.travel("Death")
	
	# Sound
	audio_stream_player_2d.pitch_scale = randf_range(0.75, 1.25)
	audio_stream_player_2d.play()
	
	# Respawn
	timer.start()
	
func _on_timer_timeout() -> void:
	xManager.handle_respawn()
	
	# Restore
	animation_state_machine.switch_states(walk)

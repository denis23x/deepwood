extends AnimationState

@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D
@onready var audio_stream_player_2d_2: AudioStreamPlayer2D = $AudioStreamPlayer2D2
@onready var audio_stream_player_2d_3: AudioStreamPlayer2D = $AudioStreamPlayer2D3

@export var walk: AnimationState
@export var combo: bool = false

func x_input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("attack"):
		combo = true
		
func on_enter() -> void:
	playback.travel("Attack_1")
	
func on_exit() -> void:
	audio_stream_player_2d.stop()
	
func _on_animation_tree_animation_started(anim_name: StringName) -> void:
	if anim_name == "Attack_1":
		combo = false
	elif anim_name == "Attack_2":
		combo = false
		
	if anim_name.begins_with("Attack"):
		audio_stream_player_2d.play()
		audio_stream_player_2d.pitch_scale = randf_range(0.85, 1.15)
	
func _on_animation_tree_animation_finished(anim_name: StringName) -> void:
	if anim_name == "Attack_1":
		if combo:
			playback.travel("Attack_2")
			audio_stream_player_2d_3.play()
			audio_stream_player_2d_3.pitch_scale = randf_range(0.85, 1.15)
		else:
			animation_state_machine.switch_states(walk)
	elif anim_name == "Attack_2":
		if combo:
			playback.travel("Attack_3")
			audio_stream_player_2d_2.play()
			audio_stream_player_2d_2.pitch_scale = randf_range(0.85, 1.15)
		else:
			animation_state_machine.switch_states(walk)
	elif anim_name == "Attack_3":
		animation_state_machine.switch_states(walk)

extends AnimationState

@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D

@export var damageable: xDamageable
@export var walk: AnimationState
@export var death: AnimationState

func on_enter() -> void:
	if playback.get_current_node() == "Hit":
		await get_tree().process_frame
		
	playback.travel("Hit")
	
func on_exit() -> void:
	audio_stream_player_2d.stop()
	
func _on_animation_tree_animation_started(anim_name: StringName) -> void:
	if anim_name == "Hit":
		audio_stream_player_2d.pitch_scale = randf_range(1.0, 1.25)
		audio_stream_player_2d.play()
	
func _on_animation_tree_animation_finished(anim_name: StringName) -> void:
	if anim_name == "Hit":
		if damageable.health > 0:
			animation_state_machine.switch_states(walk)
		else:
			animation_state_machine.switch_states(death)

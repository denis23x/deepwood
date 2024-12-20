extends AnimationState

@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D

func on_enter() -> void:
	playback.travel("Death")
	
	# Disabled collisions
	character_body_2d.set_collision_layer_value(3, false)
	
func on_exit() -> void:
	audio_stream_player_2d.stop()
	
func _on_animation_tree_animation_started(anim_name: StringName) -> void:
	if anim_name == "Death":
		audio_stream_player_2d.play(1)
	
func _on_animation_tree_animation_finished(anim_name: StringName) -> void:
	if anim_name == "Death":
		xOptimization.switch_enemy(character_body_2d)

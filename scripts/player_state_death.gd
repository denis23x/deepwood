extends AnimationState

func on_enter() -> void:
	playback.travel("Death")
	
	# Disable collision
	character_body_2d.set_collision_layer_value(2, false)

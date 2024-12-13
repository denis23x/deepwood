extends AnimationState
class_name PlayerStateFall

@export var walk: PlayerStateWalk

func x_physics_process(_delta: float) -> void:
	if (character_body_2d.is_on_floor()):
		next_state = walk
		
func on_enter() -> void:
	playback.travel("Fall")

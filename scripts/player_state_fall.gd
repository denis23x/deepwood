extends PlayerState
class_name PlayerStateFall

@export var floor: PlayerStateFloor

func x_physics_process(delta: float) -> void:
	if (character_body_2d.is_on_floor()):
		next_state = floor

func on_enter() -> void:
	playback.travel("Fall")

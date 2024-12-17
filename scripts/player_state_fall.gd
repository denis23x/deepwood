extends AnimationState

@export var walk: AnimationState

func x_physics_process(_delta: float) -> void:
	if character_body_2d.is_on_floor():
		animation_state_machine.switch_states(walk)
		
func on_enter() -> void:
	playback.travel("Fall")

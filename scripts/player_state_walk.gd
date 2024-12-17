extends AnimationState

@export var fall: AnimationState

func x_physics_process(_delta: float) -> void:
	if not character_body_2d.is_on_floor():
		animation_state_machine.switch_states(fall)
			
func on_enter() -> void:
	playback.travel("Move")

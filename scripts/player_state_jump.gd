extends AnimationState

@export var walk: AnimationState
@export var jump_velocity: float = -300.0
@export var double_jump: bool = true

func x_physics_process(_delta: float) -> void:
	if character_body_2d.velocity.y < 0:
		playback.travel("Jump")
	elif character_body_2d.velocity.y > 0:
		playback.travel("Jump_Fall")
	else:
		animation_state_machine.switch_states(walk)
		
func x_input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("jump") and double_jump:
		character_body_2d.velocity.y = jump_velocity
		double_jump = false
		
func on_enter() -> void:
	character_body_2d.velocity.y = jump_velocity
	
func on_exit() -> void: 
	double_jump = true

extends PlayerState
class_name PlayerStateJump

@export var floor: PlayerStateFloor
@export var jump_velocity: float = -300.0
@export var has_double_jump: bool = true

func x_physics_process(delta: float) -> void:
	if character_body_2d.velocity.y < 0:
		playback.travel("Jump")
	elif character_body_2d.velocity.y > 0:
		playback.travel("Jump_Fall")
	else:
		next_state = floor

func x_input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("jump") and has_double_jump:
		character_body_2d.velocity.y = jump_velocity
		has_double_jump = false

func on_enter() -> void:
	character_body_2d.velocity.y = jump_velocity

func on_exit() -> void: 
	has_double_jump = true

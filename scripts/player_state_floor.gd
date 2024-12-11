extends PlayerState
class_name PlayerStateFloor

@export var jump: PlayerStateJump
@export var fall: PlayerStateFall

func x_physics_process(delta: float) -> void:
	if (not character_body_2d.is_on_floor()):
		next_state = fall

func x_input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("jump") and character_body_2d.is_on_floor():
		if Input.is_action_pressed("move_down"):
			character_body_2d.position.y += 1
		else:
			next_state = jump

func on_enter() -> void:
	playback.travel("Move")

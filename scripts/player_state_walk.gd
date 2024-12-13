extends AnimationState
class_name PlayerStateWalk

@export var jump: PlayerStateJump
@export var fall: PlayerStateFall
@export var block: PlayerStateBlock
@export var attack: PlayerStateAttack

func x_physics_process(_delta: float) -> void:
	if (not character_body_2d.is_on_floor()):
		next_state = fall
		
func x_input(_event: InputEvent) -> void:
	if character_body_2d.is_on_floor():
		if Input.is_action_just_pressed("jump"):
			if Input.is_action_pressed("move_down"):
				character_body_2d.position.y += 1
			else:
				next_state = jump
				
		if Input.is_action_just_pressed("block"):
			next_state = block
			
		if Input.is_action_just_pressed("attack"):
			next_state = attack
			
func on_enter() -> void:
	playback.travel("Move")

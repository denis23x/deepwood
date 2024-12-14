extends CharacterBody2D
class_name Player

@export var animation_state_machine: AnimationStateMachine
@export var animation_tree: AnimationTree
@export var sprite_2d: Sprite2D
@export var speed: float = 130.0
@export var area_2d: Area2D

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
		
	# Get the input direction and handle the movement/deceleration.
	var direction := Input.get_axis("move_left", "move_right")
	
	# Handle movement animation direction
	animation_tree.set("parameters/Move/blend_position", direction)
	
	# Handle movement flip
	if animation_state_machine.current_state.can_move:
		if direction < 0:
			sprite_2d.flip_h = true
		elif direction > 0:
			sprite_2d.flip_h = false
			
	# Handle attack collision flip
	area_2d.position.x = 20 * (-1 if sprite_2d.flip_h else 1)
	
	# Handle movement
	if direction and animation_state_machine.current_state.can_move:
		velocity.x = direction * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		
	move_and_slide()
	
func switch_direction(_next_direction: int) -> void:
	pass

extends CharacterBody2D
class_name Mushroom

@export var speed: float = 40.0
@export var animation_state_machine: AnimationStateMachine
@export var animation_tree: AnimationTree
@export var sprite_2d: Sprite2D
@export var direction: int = -1 # randi() % 3 - 1
@export var area_2d_attack_area: Area2D
@export var area_2d_detect_player: Area2D
@export var ray_cast_2d: RayCast2D

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	if not ray_cast_2d.is_colliding() and is_on_floor():
		direction = (-1 if direction == 1 else 1)
		
	# Handle movement animation direction
	animation_tree.set("parameters/Move/blend_position", direction)
	
	# Handle movement flip
	if animation_state_machine.current_state.can_move:
		if direction < 0:
			sprite_2d.flip_h = true
		elif direction > 0:
			sprite_2d.flip_h = false
			
	# Handle attack collision flip
	area_2d_attack_area.scale.x = direction
	area_2d_detect_player.scale.x = direction
	ray_cast_2d.scale.x = direction
	
	# Handle movement
	if direction and animation_state_machine.current_state.can_move:
		velocity.x = direction * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		
	move_and_slide()
	
func switch_direction(next_direction: int) -> void:
	direction = next_direction
	
	# Handle reverse flip
	sprite_2d.flip_h = direction < 0

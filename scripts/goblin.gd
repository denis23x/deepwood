extends CharacterBody2D
class_name Goblin

@export var speed: float = 120.0
@export var animation_state_machine: AnimationStateMachine
@export var animation_tree: AnimationTree
@export var sprite_2d: Sprite2D
@export var direction: int = -1 # randi() % 3 - 1
@export var area_2d_attack_area: Area2D
@export var area_2d_detect_player: Area2D
@export var ray_cast_2d: RayCast2D
@export var ray_cast_2d2: RayCast2D

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
		
	if ray_cast_2d.get_collider():
		if ray_cast_2d.get_collider().get("name").begins_with("AnimatableBody2D"):
			direction = (-1 if direction == 1 else 1)
		
	if not ray_cast_2d.is_colliding() and is_on_floor() or ray_cast_2d2.is_colliding():
		direction = (-1 if direction == 1 else 1)
		
	# Handle movement animation direction
	animation_tree.set("parameters/Move/blend_position", direction)
	
	# Handle movement flip
	if animation_state_machine.current_state.can_move:
		if direction < 0:
			sprite_2d.flip_h = true
		elif direction > 0:
			sprite_2d.flip_h = false
			
	var scale_x = -1 if sprite_2d.flip_h else 1
	
	# Handle attack collision flip
	area_2d_attack_area.scale.x = scale_x
	area_2d_detect_player.scale.x = scale_x
	ray_cast_2d.scale.x = scale_x
	ray_cast_2d2.scale.x = scale_x
	
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

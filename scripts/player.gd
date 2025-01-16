extends CharacterBody2D
class_name Player

@export var animation_state_machine: AnimationStateMachine
@export var animation_tree: AnimationTree
@export var sprite_2d: Sprite2D
@export var speed: float = 120.0
@export var area_2d: Area2D
@export var direction: float = 0
@export var camera_2d: Camera2D
@export var camera_2d_attach: bool
@export var menu: CanvasLayer

func _physics_process(delta: float) -> void:
	# Attach Camera
	if camera_2d_attach:
		camera_2d.global_position = global_position
	
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
		
	# Get the input direction and handle the movement/deceleration.		
	if not menu.menu.visible:
		if animation_state_machine.current_state.can_move:
			direction = Input.get_axis("move_left", "move_right")
		
	# Handle movement animation direction
	animation_tree.set("parameters/Move/blend_position", direction)
	
	# Handle flip
	switch_direction(direction)

	# Handle movement
	if direction and animation_state_machine.current_state.can_move:
		velocity.x = direction * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		
	move_and_slide()
	
func switch_direction(next_direction: float) -> void:
	# Handle movement flip
	if next_direction < 0:
		sprite_2d.flip_h = true
	elif next_direction > 0:
		sprite_2d.flip_h = false
			
	# Handle attack collision flip
	area_2d.scale.x = -1 if sprite_2d.flip_h else 1

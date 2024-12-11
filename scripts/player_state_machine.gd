extends Node
class_name PlayerStateMachine

@export var current_state: PlayerState
@export var character_body_2d: CharacterBody2D
@export var animation_tree: AnimationTree
@export var sprite_2d: Sprite2D
@export var speed: float = 130.0

var states: Array[PlayerState]

func _ready() -> void:
	for child in get_children():
		if (child is PlayerState):
			states.append(child)
			
			## Set the states up with they need to function
			child.character_body_2d = character_body_2d
			child.playback = animation_tree["parameters/playback"]

func _physics_process(delta: float) -> void:
	# Get the input direction and handle the movement/deceleration.
	var direction := Input.get_axis("move_left", "move_right")
	
	# Handle movement animation direction
	animation_tree.set("parameters/Move/blend_position", direction)
	
	# Handle movement flip
	if current_state.name != "Attack":
		if direction < 0:
			sprite_2d.flip_h = true
		elif direction > 0:
			sprite_2d.flip_h = false
		
	# Handle movement
	if direction and current_state.name != "Attack":
		character_body_2d.velocity.x = direction * speed
	else:
		character_body_2d.velocity.x = move_toward(character_body_2d.velocity.x, 0, speed)
		
	# Switch states
	if (current_state.next_state != null):
		switch_states(current_state.next_state)
		
	# Attach _physics_process to current_state
	if (current_state != null):
		current_state.x_physics_process(delta)
		
func _input(event: InputEvent) -> void:
	# Attach _input to current_state
	if (current_state != null):
		current_state.x_input(event)
		
func switch_states(next_state: PlayerState):
	if (current_state != null):
		current_state.on_exit()
		current_state.next_state = null
		
	current_state = next_state
	current_state.on_enter()

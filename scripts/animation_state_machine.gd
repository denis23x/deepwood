extends Node
class_name AnimationStateMachine

@export var current_state: AnimationState
@export var character_body_2d: CharacterBody2D
@export var animation_tree: AnimationTree
@export var damageable: xDamageable

var states: Array[AnimationState]

func _ready() -> void:
	damageable.connect("iterrupt_state", iterrupt_state)
	
	for child in get_children():
		if child is AnimationState:
			states.append(child)
			
			# Set the states up with they need to function
			child.character_body_2d = character_body_2d
			child.playback = animation_tree["parameters/playback"]
			
func _physics_process(delta: float) -> void:
	# Attach _physics_process to current_state
	if current_state != null:
		current_state.x_physics_process(delta)
		
func _input(event: InputEvent) -> void:
	# Attach _input to current_state
	if current_state != null:
		current_state.x_input(event)
		
func switch_states(next_state: AnimationState):
	current_state.on_exit()
	current_state = next_state
	current_state.on_enter()
	
	# Emit for xInputBuffer for reset actions
	if character_body_2d.name == "Player":
		xEventBus.emit_signal("switch_state", next_state)
	
func iterrupt_state(next_state: AnimationState):
	switch_states(next_state)

extends Node

@onready var animation_state_machine: AnimationStateMachine
@onready var character_body_2d: CharacterBody2D
@onready var jump: AnimationState
@onready var block: AnimationState
@onready var attack: AnimationState
@onready var dash: AnimationState
@onready var menu: CanvasLayer

var action_in_progress: bool = false
var key_buffer: Array[String] = []
var key_buffer_limit: int = 0

func _ready() -> void:
	xEventBus.connect("switch_state", switch_state)
	
	animation_state_machine = get_node("/root/Game/Player/AnimationStateMachine")
	character_body_2d = get_node("/root/Game/Player")
	jump = get_node("/root/Game/Player/AnimationStateMachine/Jump")
	block = get_node("/root/Game/Player/AnimationStateMachine/Block")
	attack = get_node("/root/Game/Player/AnimationStateMachine/Attack")
	dash = get_node("/root/Game/Player/AnimationStateMachine/Dash")
	menu = get_node("/root/Game/Menu")
	
func _process(_delta: float) -> void:
	if not menu.menu.visible:
		if not animation_state_machine.current_state.name in ["Hit", "Death"]:
			if Input.is_action_just_pressed("jump"):
				handle_action_queue("jump")
			elif Input.is_action_just_pressed("attack"):
				handle_action_queue("attack")
			elif Input.is_action_just_pressed("block"):
				handle_action_queue("block")
			elif Input.is_action_just_pressed("dash"):
				handle_action_queue("dash")
			elif Input.is_action_just_pressed("down"):
				handle_action_queue("down")
				
			# Process buffered inputs if no action is in progress
			if not action_in_progress and not key_buffer.is_empty():
				handle_action(key_buffer.pop_front())
				
func handle_action_queue(key: String) -> void:
	# Process buffered inputs limit
	if key_buffer.size() > key_buffer_limit:
		key_buffer.pop_front()
		
	# Handle repeated inputs and append
	if not action_in_progress:
		handle_action(key)
	elif (key_buffer.is_empty() or key_buffer.back() != key) and not key in ["attack", "jump", "escape"]:
		key_buffer.append(key)
		
func handle_action(action: String) -> void:
	action_in_progress = true
	
	match action:
		"jump":
			if character_body_2d.is_on_floor():
				animation_state_machine.switch_states(jump)
				
			# Do not iterrupt the state to allow to do double jump
			elif animation_state_machine.current_state.name != "Jump":
				if animation_state_machine.current_state.name == "Fall":
					if animation_state_machine.current_state.coyote_time:
						animation_state_machine.switch_states(jump)
				else:
					animation_state_machine.switch_states(jump)
		"attack":
			if character_body_2d.is_on_floor():
				# Do not iterrupt the state to allow to do combo attacks
				if animation_state_machine.current_state.name != "Attack":
					animation_state_machine.switch_states(attack)
		"down":
			if character_body_2d.is_on_floor():
				character_body_2d.position.y += 1
				action_in_progress = false
		"block":
			if character_body_2d.is_on_floor():
				animation_state_machine.switch_states(block)
		"dash":
			if xManager.dash:
				if character_body_2d.is_on_floor():
					if character_body_2d.direction != 0:
						animation_state_machine.switch_states(dash)
					else:
						action_in_progress = false
			else:
				action_in_progress = false
				
func switch_state(next_state: AnimationState) -> void:
	if next_state.name != "Death":
		action_in_progress = false

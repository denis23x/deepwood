extends AnimationState

@onready var jump_effect = load("res://scenes/player_jump_effect.tscn")
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D
@onready var audio_stream_player_2d_2: AudioStreamPlayer2D = $AudioStreamPlayer2D2

@export var walk: AnimationState
@export var jump_velocity: float = -300.0
@export var double_jump: bool = true

func x_physics_process(_delta: float) -> void:
	if character_body_2d.velocity.y < 0:
		pass
	elif character_body_2d.velocity.y > 0:
		playback.travel("Jump_Fall")
	else:
		animation_state_machine.switch_states(walk)
		
func x_input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("jump") and double_jump:
		double_jump = false
		
		# Jump repeat
		on_enter()
		
func on_enter() -> void:
	playback.travel("Jump")
	character_body_2d.velocity.y = jump_velocity
	
	# Draw effetcs
	handle_jump_effect()
	
func on_exit() -> void: 
	double_jump = true
	
	# Stop sounds
	audio_stream_player_2d.stop()
	
func handle_jump_effect() -> void:
	audio_stream_player_2d.play()
	audio_stream_player_2d.pitch_scale = randf_range(0.75, 1.25)
	
	var instance = jump_effect.instantiate()
	
	instance.name = "Player_Jump_Effect"
	instance.global_position = character_body_2d.global_position
	instance.get_node("Sprite2D").flip_h = (true if character_body_2d.direction != 1 else false)
	instance.get_node("AnimationPlayer").play("Jump_Effect" if double_jump else "Jump_Effect_2")
	
	var new_timer = Timer.new()
	new_timer.wait_time = 0.2
	
	add_child(new_timer)
	
	new_timer.connect("timeout", instance.queue_free)
	new_timer.start()
	
	get_tree().get_root().get_node("Game").add_child.call_deferred(instance)

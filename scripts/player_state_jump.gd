extends AnimationState

@onready var jump_effect = load("res://scenes/player_jump_effect.tscn")
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D
@onready var audio_stream_player_2d_2: AudioStreamPlayer2D = $AudioStreamPlayer2D2
@onready var timer: Timer = $Timer
@onready var instance = Sprite2D

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
	if xManager.double_jump:
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
	
	instance = jump_effect.instantiate()
	instance.name = "Player_Jump_Effect"
	instance.global_position = character_body_2d.global_position
	instance.get_node("Sprite2D").flip_h = (true if character_body_2d.direction != 1 else false)
	instance.get_node("AnimationPlayer").play("Jump_Effect" if double_jump else "Jump_Effect_2")
	
	# Lifetime
	timer.start()
	
	# Append to scene
	get_node("/root/Game").add_child.call_deferred(instance)
	
func _on_timer_timeout() -> void:
	instance.queue_free()
	instance = null

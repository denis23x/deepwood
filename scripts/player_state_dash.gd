extends AnimationState

@onready var dash_effect = load("res://scenes/player_dash_effect.tscn")
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D
@onready var timer: Timer = $Timer
@onready var dash: bool = false

@export var sprite_2d: Sprite2D
@export var walk: AnimationState

func x_physics_process(_delta: float) -> void:
	if timer.is_stopped() and not dash:
		character_body_2d.speed = 360
		
		audio_stream_player_2d.pitch_scale = randf_range(0.75, 1.25)
		audio_stream_player_2d.play()
		
		timer.wait_time = 0.2
		timer.start()
		
		# Toggle
		dash = true
	else:
		animation_state_machine.switch_states(walk)
			
func on_enter() -> void:
	playback.travel("Move")
	
func _on_timer_timeout() -> void:
	if dash:
		character_body_2d.speed = 120
		
		timer.wait_time = 0.4
		timer.start()
		
		# Toggle
		dash = false
		
		# Exit
		animation_state_machine.switch_states(walk)
		
func handle_dash() -> void:
	var effect: Sprite2D = dash_effect.instantiate()
	
	effect.global_position = sprite_2d.global_position
	effect.global_rotation = sprite_2d.rotation
	effect.global_scale = sprite_2d.scale
	effect.texture = sprite_2d.texture
	effect.vframes = sprite_2d.vframes
	effect.hframes = sprite_2d.hframes
	effect.frame = sprite_2d.frame
	effect.flip_h = sprite_2d.flip_h
	
	get_node("/root/Game").add_child(effect)
	
func _on_timer_2_timeout() -> void:
	if dash:
		handle_dash()

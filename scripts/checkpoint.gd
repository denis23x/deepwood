extends Node2D

@export var label_position_default: Vector2 = Vector2(0, -40)
@export var label_position_float: Vector2 = Vector2(0, -20)

@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D
@onready var label: Label = $Label
@onready var timer: Timer = $Timer
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var color_rect: ColorRect =  $ColorRect
@onready var fade_timer: float = 0.0
@onready var fade_effect: bool = false

func _ready() -> void:
	label.visible = false
	color_rect.visible = false
	
	# Hide God Rays
	color_rect.get_material().set_shader_parameter("color", Vector4(0.0, 0.0, 0.0, 0.0))
	
func _process(delta: float) -> void:
	if not timer.is_stopped():
		label.position += label_position_float * delta
		
	if fade_effect:
		fade_timer += delta
		
		var alpha = clamp(fade_timer / 2.0, 0.0, 1.0)
		
		color_rect.get_material().set_shader_parameter("color", Vector4(1.0, 0.9, 0.65, alpha))
		
		# Hide God Rays
		if alpha >= 0.5:
			fade_effect = false
	
func _on_body_entered(_body: Node2D) -> void:
	color_rect.visible = true
	label.visible = true
	label.add_theme_color_override("font_color", Color.CHARTREUSE)
	timer.start()
	
	# Disable collision
	collision_shape_2d.queue_free()
	
	# Play sound
	#audio_stream_player_2d.pitch_scale = randf_range(0.75, 1.25)
	audio_stream_player_2d.play(0.05)
	
	# Checkpoint
	xManager.handle_checkpoint()
	
	# Show God Rays
	fade_effect = true
	
func _on_timer_timeout() -> void:
	label.queue_free()

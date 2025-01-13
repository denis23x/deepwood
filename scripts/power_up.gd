extends Node2D

@export var pickup: String
@export var label_position_default: Vector2 = Vector2(0, -40)
@export var label_position_float: Vector2 = Vector2(0, -20)

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D
@onready var timer: Timer = $Timer
@onready var label: Label = $Label

func _ready() -> void:
	label.visible = false
	
func _process(delta: float) -> void:
	if not timer.is_stopped():
		label.position += label_position_float * delta
		
func _on_body_entered(_body: Node2D) -> void:
	xManager.handle_pickup(pickup)
	
	match pickup:
		"double_jump":
			label.text = "Double Jump"
			
			var l: Label = get_node("/root/Game/Labels/Label2")
			
			l.visible = true
		"dash":
			label.text = "Dash"
			
			var l: Label = get_node("/root/Game/Labels/Label3")
			
			l.visible = true
		
	label.visible = true
	label.add_theme_color_override("font_color", Color.CHARTREUSE)
	timer.start()
		
	animated_sprite_2d.queue_free()
	collision_shape_2d.queue_free()
	
	# Play sound
	audio_stream_player_2d.pitch_scale = randf_range(0.75, 1.25)
	audio_stream_player_2d.play()
	
func _on_timer_timeout() -> void:
	queue_free()

extends Node2D

@export var label_position_default: Vector2 = Vector2(0, -40)
@export var label_position_float: Vector2 = Vector2(0, -20)

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D
@onready var label: Label = $Label
@onready var timer: Timer = $Timer
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D

func _ready() -> void:
	label.visible = false
	
	animation_player.active = true
	animation_player.play("Idle")
	
func _process(delta: float) -> void:
	if not timer.is_stopped():
		label.position += label_position_float * delta
	
func _on_body_entered(_body: Node2D) -> void:
	label.visible = true
	label.add_theme_color_override("font_color", Color.CHARTREUSE)
	timer.start()
	
	# Disable collision
	collision_shape_2d.queue_free()
	
	# Play sound
	audio_stream_player_2d.pitch_scale = randf_range(0.75, 1.25)
	audio_stream_player_2d.play()
	
func _on_timer_timeout() -> void:
	label.queue_free()

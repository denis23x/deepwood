extends Node2D

@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

func _on_body_entered(_body: Node2D) -> void:
	xManager.handle_pickup("coins")
	
	animated_sprite_2d.queue_free()
	collision_shape_2d.queue_free()
	
	# Play sound
	audio_stream_player_2d.pitch_scale = randf_range(0.75, 1.25)
	audio_stream_player_2d.play()
	
func _on_audio_stream_player_2d_finished() -> void:
	queue_free()

extends Node
class_name xDestructible

@export var sprite_2d: Sprite2D
@export var animated_sprite_2d: AnimatedSprite2D
@export var audio_stream_player_2d: AudioStreamPlayer2D

func on_damage(_damage: float) -> void:
	sprite_2d.visible = false
	animated_sprite_2d.visible = true
	animated_sprite_2d.play()
	
	audio_stream_player_2d.pitch_scale = randf_range(0.75, 1.25)
	audio_stream_player_2d.play()
	
func _on_animated_sprite_2d_animation_finished() -> void:
	queue_free()

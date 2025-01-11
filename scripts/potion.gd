extends Node2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var sprite_2d: Sprite2D = $Sprite2D

func _ready() -> void:
	animation_player.active = true
	animation_player.play("Idle")
	
func _on_body_entered(_body: Node2D) -> void:
	xManager.handle_pickup("potion")
	
	sprite_2d.queue_free()
	collision_shape_2d.queue_free()
	
	# Play sound
	audio_stream_player_2d.pitch_scale = randf_range(0.75, 1.25)
	audio_stream_player_2d.play(0.25)
	
func _on_audio_stream_player_2d_finished() -> void:
	queue_free()

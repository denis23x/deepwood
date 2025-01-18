extends AnimationState

@onready var projectile = load("res://scenes/demon_projectile.tscn")
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D
@onready var timer: Timer = $Timer

@export var sprite_2d: Sprite2D
@export var walk: AnimationState

func on_enter() -> void:
	playback.travel("Attack")
	
func on_exit() -> void:
	timer.stop()
	#audio_stream_player_2d.stop()
	
func _on_animation_tree_animation_started(anim_name: StringName) -> void:
	if anim_name in ["Attack"]:
		timer.start()
	
func _on_animation_tree_animation_finished(anim_name: StringName) -> void:
	if anim_name == "Attack":
		var instance: CharacterBody2D = projectile.instantiate()
		
		instance.name = "Demon_Projectile"
		instance.direction = character_body_2d.direction
		instance.spawnPosition.x = character_body_2d.global_position.x + 10 * (-1 if sprite_2d.flip_h else 1)
		instance.spawnPosition.y = character_body_2d.global_position.y + 10
		instance.spawnRotation = character_body_2d.rotation
		instance.spawnScale = character_body_2d.scale
		
		get_node("/root/Game").add_child.call_deferred(instance)
		
		# Return to default state
		animation_state_machine.switch_states(walk)
		
func _on_timer_timeout() -> void:
	audio_stream_player_2d.pitch_scale = randf_range(0.75, 1.25)
	audio_stream_player_2d.play()

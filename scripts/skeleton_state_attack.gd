extends AnimationState

@onready var projectile = load("res://scenes/skeleton_projectile.tscn")
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D
@onready var timer: Timer = $Timer

@export var area_2d: Area2D
@export var walk: AnimationState

func on_enter() -> void:
	playback.travel("Attack_1")
	
func on_exit() -> void:
	timer.stop()
	audio_stream_player_2d.stop()
	
func _on_animation_tree_animation_started(anim_name: StringName) -> void:
	if anim_name in ["Attack_1", "Attack_2"]:
		timer.start()
	
func _on_animation_tree_animation_finished(anim_name: StringName) -> void:
	var is_alive: bool = area_2d.target and area_2d.target.health > 0
	
	if anim_name == "Attack_1":
		if area_2d.is_reachable and is_alive:
			playback.travel("Attack_2")
		elif area_2d.is_attainable and is_alive:
			playback.travel("Attack_3")
		else:
			animation_state_machine.switch_states(walk)
	elif anim_name == "Attack_2":
		if area_2d.is_reachable and is_alive:
			playback.travel("Attack_1")
		elif area_2d.is_attainable and is_alive:
			playback.travel("Attack_3")
		else:
			animation_state_machine.switch_states(walk)
	elif anim_name == "Attack_3":
		var instance = projectile.instantiate()
		
		instance.name = "Skeleton_Projectile"
		instance.direction = character_body_2d.direction
		instance.spawnPosition = character_body_2d.global_position
		instance.spawnRotation = character_body_2d.rotation
		instance.spawnScale = character_body_2d.scale
		
		get_node("/root/Game").add_child.call_deferred(instance)
		
		# Return to default state
		animation_state_machine.switch_states(walk)
		
func _on_timer_timeout() -> void:
	audio_stream_player_2d.pitch_scale = randf_range(0.75, 1.25)
	audio_stream_player_2d.play()

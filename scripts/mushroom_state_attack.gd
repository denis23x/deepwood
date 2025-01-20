extends AnimationState

@onready var projectile = load("res://scenes/mushroom_projectile.tscn")
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D
@onready var timer: Timer = $Timer

@export var area_2d: Area2D
@export var walk: AnimationState

func on_enter() -> void:
	if playback.get_current_node() == "Attack_1":
		await get_tree().process_frame
		
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
		var instance: CharacterBody2D = projectile.instantiate()
		
		instance.name = "Mushroom_Projectile"
		instance.direction = character_body_2d.direction
		instance.spawnPosition.x = character_body_2d.global_position.x
		instance.spawnPosition.y = character_body_2d.global_position.y - get_y_outside_camera()
		instance.spawnRotation = character_body_2d.rotation
		instance.spawnScale = character_body_2d.scale
		
		get_node("/root/Game").add_child.call_deferred(instance)
		
		# Return to default state
		animation_state_machine.switch_states(walk)
		
func _on_timer_timeout() -> void:
	audio_stream_player_2d.pitch_scale = randf_range(0.75, 1.25)
	audio_stream_player_2d.play()
	
func get_y_outside_camera() -> float:
	var camera: Camera2D = get_node("/root/Game/Camera2D")
	var camera_position: Vector2 = camera.position
	var zoom_factor: float = camera.zoom.y
	var viewport_size: Vector2 = get_viewport().size
	var camera_visible_height = viewport_size.y / zoom_factor
	
	return camera_position.y + camera_visible_height

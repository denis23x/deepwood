extends AnimationState

@onready var projectile = load("res://scenes/skeleton_projectile.tscn")

@export var area_2d: Area2D
@export var walk: AnimationState

func on_enter() -> void:
	playback.travel("Attack_1")
	
func _on_animation_tree_animation_started(_anim_name: StringName) -> void:
	pass
	
func _on_animation_tree_animation_finished(anim_name: StringName) -> void:
	var is_alive: bool = area_2d.target and area_2d.target.health > 0

	match anim_name:
		"Attack_1":
			if area_2d.is_reachable and is_alive:
				playback.travel("Attack_2")
			elif area_2d.is_attainable and is_alive:
				playback.travel("Attack_3")
			else:
				next_state = walk
		"Attack_2":
			if area_2d.is_reachable and is_alive:
				playback.travel("Attack_1")
			elif area_2d.is_attainable and is_alive:
				playback.travel("Attack_3")
			else:
				next_state = walk
		"Attack_3":
			var instance = projectile.instantiate()
			
			instance.name = "skeleton_projectile"
			instance.direction = character_body_2d.direction
			instance.spawnPosition = character_body_2d.global_position
			instance.spawnRotation = character_body_2d.rotation
			instance.spawnScale = character_body_2d.scale
			
			var game = get_tree().get_root().get_node("Game")
			
			game.add_child.call_deferred(instance)
			
			# Return to default state
			next_state = walk

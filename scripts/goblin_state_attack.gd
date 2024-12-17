extends AnimationState

@onready var projectile = load("res://scenes/goblin_projectile.tscn")

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
				animation_state_machine.switch_states(walk)
		"Attack_2":
			if area_2d.is_reachable and is_alive:
				playback.travel("Attack_1")
			elif area_2d.is_attainable and is_alive:
				playback.travel("Attack_3")
			else:
				animation_state_machine.switch_states(walk)
		"Attack_3":
			var instance = projectile.instantiate()
			var direction: int = -1 if character_body_2d.direction == 1 else 1
			
			instance.name = "goblin_projectile"
			instance.direction = character_body_2d.direction
			instance.spawnPosition.x = character_body_2d.global_position.x + 24 * (direction * -1)
			instance.spawnPosition.y = character_body_2d.global_position.y - 7
			instance.spawnRotation = character_body_2d.rotation
			instance.spawnScale = character_body_2d.scale
			
			var game = get_tree().get_root().get_node("Game")
			
			game.add_child.call_deferred(instance)
			
			# Run away from throwed bomb
			character_body_2d.switch_direction(direction)
			
			# Return to default state
			animation_state_machine.switch_states(walk)

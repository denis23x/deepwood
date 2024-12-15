extends AnimationState

@onready var projectile = load("res://scenes/skeleton_projectile.tscn")

@export var walk: AnimationState
@export var node_2d: Node2D

func on_enter() -> void:
	playback.travel("Attack_1")

	#var instance = projectile.instantiate()
	#instance.name = "test"
	#instance.direction = character_body_2d.direction
	#instance.spawnPosition = character_body_2d.global_position
	#instance.spawnRotation = character_body_2d.rotation
	#instance.spawnScale = character_body_2d.scale
#
	#var game = get_tree().get_root().get_node("Game")
	#game.add_child.call_deferred(instance)
	
func _on_animation_tree_animation_finished(anim_name: StringName) -> void:
	if anim_name == "Attack_1":
		next_state = walk

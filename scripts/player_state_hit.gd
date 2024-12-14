extends AnimationState

@export var damageable: xDamageable
@export var walk: AnimationState
@export var death: AnimationState

func on_enter() -> void:
	playback.travel("Hit")
	
func _on_animation_tree_animation_finished(anim_name: StringName) -> void:
	if anim_name == "Hit":
		if damageable.health > 0:
			next_state = walk
		else:
			next_state = death

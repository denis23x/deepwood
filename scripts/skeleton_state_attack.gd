extends AnimationState

@export var walk: AnimationState

func on_enter() -> void:
	playback.travel("Attack_1")
	
func _on_animation_tree_animation_finished(anim_name: StringName) -> void:
	if anim_name == "Attack_1":
		next_state = walk

extends AnimationState

@export var walk: AnimationState

func on_enter() -> void:
	playback.travel("Block")
	
func _on_animation_tree_animation_finished(anim_name: StringName) -> void:
	if anim_name == "Block":
		next_state = walk

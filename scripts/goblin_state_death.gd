extends AnimationState

func on_enter() -> void:
	playback.travel("Death")

func _on_animation_tree_animation_finished(anim_name: StringName) -> void:
	if anim_name == "Death":
		xOptimization.switch_enemy(character_body_2d)

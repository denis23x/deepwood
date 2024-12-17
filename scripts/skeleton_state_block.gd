extends AnimationState

@export var walk: AnimationState
@export var attack: AnimationState
@export var area_2d: Area2D

func on_enter() -> void:
	playback.travel("Block")
	
func _on_animation_tree_animation_finished(anim_name: StringName) -> void:
	if anim_name == "Block":
		if area_2d.is_colliding:
			animation_state_machine.switch_states(attack)
		else:
			animation_state_machine.switch_states(walk)

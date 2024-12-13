extends AnimationState
class_name PlayerStateAttack

@export var walk: PlayerStateWalk
@export var combo: bool = false

func x_input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("attack"):
		combo = true
		
func on_enter() -> void:
	playback.travel("Attack_1")
	
func _on_animation_tree_animation_started(anim_name: StringName) -> void:
	if (anim_name == "Attack_1"):
		combo = false
		
	if (anim_name == "Attack_2"):
		combo = false
	
func _on_animation_tree_animation_finished(anim_name: StringName) -> void:
	if (anim_name == "Attack_1"):
		if combo:
			playback.travel("Attack_2")
		else:
			next_state = walk
			
	if (anim_name == "Attack_2"):
		if combo:
			playback.travel("Attack_3")
		else:
			next_state = walk
			
	if (anim_name == "Attack_3"):
		next_state = walk

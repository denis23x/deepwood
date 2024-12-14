extends Area2D

@export var damageable: xDamageable
@export var attack: AnimationState
@export var animation_state_machine: AnimationStateMachine
@export var is_colliding: bool = false

func _on_body_entered(body: Node2D) -> void:
	is_colliding = true
	
	if animation_state_machine.current_state.name != "Hit":
		for child in body.get_children():
			if child is xDamageable:
				if child.health > 0:
					animation_state_machine.switch_states(attack)
		
func _on_body_exited(_body: Node2D) -> void:
	is_colliding = false
	
func _on_animation_tree_animation_finished(anim_name: StringName) -> void:
	if anim_name == "Hit" and is_colliding and damageable.health > 0:
		animation_state_machine.switch_states(attack)

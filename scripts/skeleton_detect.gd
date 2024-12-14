extends Area2D

@export var attack: AnimationState
@export var animation_state_machine: AnimationStateMachine

func _on_body_entered(body: Node2D) -> void:
	animation_state_machine.iterrupt_state(attack)

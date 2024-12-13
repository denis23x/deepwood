extends Label

@export var animation_state_machine: AnimationStateMachine

func _process(_delta: float) -> void:
	if animation_state_machine != null:
		text = "State: " + animation_state_machine.current_state.name

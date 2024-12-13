extends Label

@export var animation_state_machine: AnimationStateMachine

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	text = "State: " + animation_state_machine.current_state.name

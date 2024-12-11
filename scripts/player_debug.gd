extends Label

@export var player_state_Machine : PlayerStateMachine

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	text = "State: " + player_state_Machine.current_state.name

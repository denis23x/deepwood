extends AnimationState

@onready var timer: Timer = $Timer

@export var walk: AnimationState

func on_enter() -> void:
	playback.travel("Death")
	
	# Respawn
	timer.start()
	
func _on_timer_timeout() -> void:
	xManager.handle_respawn()
	
	# Restore
	animation_state_machine.switch_states(walk)

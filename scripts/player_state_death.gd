extends AnimationState

@onready var timer: Timer = $Timer

@export var walk: AnimationState

func on_enter() -> void:
	playback.travel("Death")
	
	# Disable collision
	character_body_2d.set_collision_layer_value(2, false)
	
	# Respawn
	timer.start()
	
func _on_timer_timeout() -> void:
	xManager.handle_respawn()
	
	# Restore
	animation_state_machine.switch_states(walk)
	character_body_2d.set_collision_layer_value(2, true)

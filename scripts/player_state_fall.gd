extends AnimationState

@export var walk: AnimationState

@onready var timer: Timer = $Timer
@onready var coyote_time: bool = false

func x_physics_process(_delta: float) -> void:
	if character_body_2d.is_on_floor():
		coyote_time = false
		animation_state_machine.switch_states(walk)
		
func on_enter() -> void:
	playback.travel("Fall")
	
	coyote_time = true
	
	# Coyote time
	timer.start()
	
func _on_timer_timeout() -> void:
	coyote_time = false

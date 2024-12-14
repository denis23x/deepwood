extends AnimationState

@export var walk: AnimationState

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("block"):
		next_state = walk
		
func on_enter() -> void:
	playback.travel("Block")

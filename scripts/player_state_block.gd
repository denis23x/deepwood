extends AnimationState
class_name PlayerStateBlock

@export var walk: PlayerStateWalk

func _process(_delta: float) -> void:
	if Input.is_action_just_released("block"):
		next_state = walk
		
func on_enter() -> void:
	playback.travel("Block")

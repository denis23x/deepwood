extends AnimationState

@export var attack: AnimationState

func on_enter() -> void:
	playback.travel("Move")

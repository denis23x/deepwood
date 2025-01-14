extends AnimationState

@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D

@export var damageable: xDamageable
@export var walk: AnimationState
@export var death: AnimationState
@export var area_2d: Area2D

func on_enter() -> void:
	playback.travel("Hit")
	
func on_exit() -> void:
	audio_stream_player_2d.stop()
	
func _on_animation_tree_animation_started(anim_name: StringName) -> void:
	if anim_name == "Hit":
		audio_stream_player_2d.pitch_scale = randf_range(0.75, 1.25)
		audio_stream_player_2d.play()
	
func _on_animation_tree_animation_finished(anim_name: StringName) -> void:
	if anim_name == "Hit":
		if damageable.health > 0:
			animation_state_machine.switch_states(walk)
		else:
			animation_state_machine.switch_states(death)

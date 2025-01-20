extends AnimationState

@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D

@export var walk: AnimationState
@export var attack: AnimationState
@export var area_2d: Area2D

func on_enter() -> void:
	if playback.get_current_node() == "Block":
		await get_tree().process_frame
		
	playback.travel("Block")
	
func on_exit() -> void:
	audio_stream_player_2d.stop()
	
func _on_animation_tree_animation_started(anim_name: StringName) -> void:
	if anim_name == "Block":
		audio_stream_player_2d.play()
	
func _on_animation_tree_animation_finished(anim_name: StringName) -> void:
	if anim_name == "Block":
		if area_2d.is_colliding:
			animation_state_machine.switch_states(attack)
		else:
			animation_state_machine.switch_states(walk)

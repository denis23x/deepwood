extends AnimationState

@onready var block_effect = load("res://scenes/player_block_effect.tscn")
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D
@onready var timer: Timer = $Timer
@onready var instance = null

@export var walk: AnimationState

func on_enter() -> void:
	if playback.get_current_node() == "Block":
		await get_tree().process_frame
		
	playback.travel("Block")
	
func on_exit() -> void:
	pass
	
func _on_animation_tree_animation_finished(anim_name: StringName) -> void:
	if anim_name == "Block":
		animation_state_machine.switch_states(walk)
	
func handle_block_effect() -> void:
	audio_stream_player_2d.play()
	
	instance = block_effect.instantiate()
	instance.name = "Player_Block_Effect"
	instance.global_position = character_body_2d.global_position
	instance.get_node("Sprite2D").flip_h = (true if character_body_2d.direction != 1 else false)
	instance.get_node("AnimationPlayer").play("Block_Effect")
	
	# Lifetime
	timer.start()
	
	# Append to scene
	get_node("/root/Game").add_child.call_deferred(instance)
	
func _on_timer_timeout() -> void:
	instance.queue_free()
	instance = null

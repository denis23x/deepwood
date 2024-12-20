extends AnimationState

@onready var block_effect = load("res://scenes/player_block_effect.tscn")

@export var walk: AnimationState

func on_enter() -> void:
	playback.travel("Block")
	
func _on_animation_tree_animation_finished(anim_name: StringName) -> void:
	if anim_name == "Block_1":
		animation_state_machine.switch_states(walk)
	
func handle_block_effect() -> void:
	var instance = block_effect.instantiate()
	
	instance.name = "Player_Block_Effect"
	instance.global_position = character_body_2d.global_position
	instance.get_node("Sprite2D").flip_h = (true if character_body_2d.direction != 1 else false)
	instance.get_node("AnimationPlayer").play("Block_Effect")
	
	var new_timer = Timer.new()
	new_timer.wait_time = 0.15
	
	add_child(new_timer)
	
	new_timer.connect("timeout", instance.queue_free)
	new_timer.start()
	
	get_tree().get_root().get_node("Game").add_child.call_deferred(instance)

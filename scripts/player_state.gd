extends Node
class_name PlayerState

var next_state: PlayerState
var character_body_2d: CharacterBody2D
var playback: AnimationNodeStateMachinePlayback

func x_physics_process(delta: float) -> void:
	pass;
	
func x_input(event: InputEvent) -> void:
	pass;
	
func on_enter() -> void:
	pass;
	
func on_exit() -> void:
	pass;

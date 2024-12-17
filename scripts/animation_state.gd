extends Node
class_name AnimationState

@export var can_move: bool = true
@export var animation_state_machine: AnimationStateMachine

var character_body_2d: CharacterBody2D
var playback: AnimationNodeStateMachinePlayback

func x_physics_process(_delta: float) -> void:
	pass;
	
func x_input(_event: InputEvent) -> void:
	pass;
	
func on_enter() -> void:
	pass;
	
func on_exit() -> void:
	pass;

extends Area2D

@export var damageable: xDamageable
@export var attack: AnimationState
@export var animation_state_machine: AnimationStateMachine
@export var ray_cast_2d: RayCast2D
@export var ray_cast_projectile_2d: RayCast2D

var target: xDamageable
var is_colliding: bool = false
var is_reachable: bool = false
var is_attainable: bool = false

func _physics_process(_delta: float) -> void:
	is_reachable = ray_cast_2d.is_colliding()
	is_attainable = ray_cast_projectile_2d.is_colliding()
	
func _on_body_entered(body: Node2D) -> void:
	is_colliding = true
	
	if not animation_state_machine.current_state.name in ["Hit", "Death", "Block"]:
		for child in body.get_children():
			if child is xDamageable:
				target = child
				
				if target and target.health > 0:
					animation_state_machine.switch_states(attack)
					
func _on_body_exited(_body: Node2D) -> void:
	is_colliding = false

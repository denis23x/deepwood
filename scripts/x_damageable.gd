extends Node
class_name xDamageable

@export var health: float = 30.0
@export var label: Label
@export var label_position_default: Vector2 = Vector2(0, -40)
@export var label_position_float: Vector2 = Vector2(0, -20)
@export var timer: Timer
@export var hit: AnimationState
@export var block: AnimationState
@export var character_body_2d: CharacterBody2D
@export var knockback: Vector2 = Vector2(250, 0)
@export var animation_state_machine: AnimationStateMachine

@warning_ignore("unused_signal") signal iterrupt_state(next_state: AnimationState)

func _process(delta: float) -> void:
	if not timer.is_stopped():
		label.position += label_position_float * delta
		
func _on_timer_timeout() -> void:
	label.text = ""
	label.position = label_position_default
	timer.stop()
	
func on_damage(damage: float, direction: Vector2, defense: bool = false) -> void:
	if defense:
		animation_state_machine.switch_states(block)
		
	# Damage behaviour
	if animation_state_machine.current_state.name == "Block":
		label.text = "Block"
		label.add_theme_color_override("font_color", Color.CHARTREUSE)
		timer.start()
		
		emit_signal("iterrupt_state", block)
	else:
		health -= damage
		
		# Handle damage knockback
		character_body_2d.velocity = knockback * direction
			
		if health >= 0:
			label.text = "-" + str(damage)
			label.add_theme_color_override("font_color", Color.CRIMSON)
			timer.start()
			
			emit_signal("iterrupt_state", hit)
			
	# Handle damage flip
	character_body_2d.switch_direction((-1 if direction.x == 1 else 1))

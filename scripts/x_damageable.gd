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

@warning_ignore("unused_signal")  signal iterrupt_state(next_state: AnimationState)

var tt: bool = false

func _process(delta: float) -> void:
	if not timer.is_stopped():
		label.position += label_position_float * delta
		
	if character_body_2d.name == "Player":
		if Input.is_action_just_pressed("block"):
			tt = true
		if Input.is_action_just_released("block"):
			tt = false
			
func _on_timer_timeout() -> void:
	label.text = ""
	label.position = label_position_default
	timer.stop()
	
func on_damage(damage: float, direction: Vector2) -> void:
	health -= damage
	
	# Handle damage impact
	character_body_2d.velocity = knockback * direction
	character_body_2d.switch_direction((-1 if direction.x == 1 else 1))
		
	if health >= 0:
		if tt == true:
			label.text = "blocked"
			timer.start()
			
			emit_signal("iterrupt_state", block)
		else:
			label.text = "-" + str(damage)
			timer.start()
			
			emit_signal("iterrupt_state", hit)

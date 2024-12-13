extends Damageable

@export var health: float = 30.0
@export var label: Label
@export var label_position_default: Vector2 = Vector2(0, -40)
@export var label_position_float: Vector2 = Vector2(0, -20)
@export var timer: Timer

signal on_damage_signal(node: Node, damage: float, direction: Vector2)

func _process(delta: float) -> void:
	if not timer.is_stopped():
		label.position += label_position_float * delta
		
func _on_timer_timeout() -> void:
	label.text = ""
	label.position = label_position_default
	timer.stop()
	
func on_damage(damage: float, direction: Vector2) -> void:
	health -= damage
	
	if health >= 0:
		label.text = "-" + str(damage)
		timer.start()
		
		emit_signal("on_damage_signal", get_parent(), damage, direction)

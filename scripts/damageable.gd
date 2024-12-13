extends Node
class_name Damageable

@export var health: float = 30.0
@export var label: Label

func on_hit(damage: float):
	health -= damage
	
	var timer = Timer.new()
	timer.wait_time = 0.5
	timer.one_shot = true
	timer.connect("timeout", Callable(self, "_on_timer_timeout"))
	add_child(timer)
	timer.start()

	label.text = str(damage)
	
	if (health <= 0):
		get_parent().queue_free()
		
func _on_timer_timeout():
	label.text = ""

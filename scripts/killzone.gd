extends Area2D

@export var timer: Timer

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		timer.start()
	else:
		body.queue_free()
	
func _on_timer_timeout() -> void:
	get_tree().reload_current_scene()

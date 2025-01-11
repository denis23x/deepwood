extends AnimatableBody2D

@onready var timer: Timer = $Timer

@export var start: Vector2 = Vector2(0, 0)
@export var finish: Vector2 = Vector2(0, 0)
@export var done: bool = false

func _physics_process(_delta: float) -> void:
	if timer.is_stopped():
		if not done:
			if finish.y != position.y:
				position.y += 1
			else:
				done = true
				timer.start()
		else:
			if start.y != position.y:
				position.y -= 1
			else:
				done = false
				timer.start()
				
func _on_timer_timeout() -> void:
	timer.stop()

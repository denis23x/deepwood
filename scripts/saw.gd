extends AnimatableBody2D

@onready var timer: Timer = $Timer
@onready var sprite_2d: Sprite2D = $Sprite2D

@export var start: Vector2 = Vector2(0, 0)
@export var finish: Vector2 = Vector2(0, 0)
@export var done: bool = false

func _physics_process(delta: float) -> void:
	if timer.is_stopped():
		if not done:
			if finish.x != position.x:
				position.x += 1
				sprite_2d.rotation = 10 * delta
			else:
				sprite_2d.rotation = 0 
				done = true
				timer.start()
		else:
			if start.x != position.x:
				position.x -= 1
				sprite_2d.rotation = -10 * delta
			else:
				sprite_2d.rotation = 0 
				done = false
				timer.start()
				
func _on_timer_timeout() -> void:
	timer.stop()

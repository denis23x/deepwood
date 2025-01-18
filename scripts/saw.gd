extends AnimatableBody2D

@onready var timer: Timer = $Timer
@onready var timer_2: Timer = $Timer2
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var area_2d: xAttackArea = $Area2D

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
	
func _on_area_2d_body_entered(_body: Node2D) -> void:
	area_2d.set_deferred("monitoring", false)
	timer_2.start()
	
func _on_timer_2_timeout() -> void:
	area_2d.set_deferred("monitoring", true)

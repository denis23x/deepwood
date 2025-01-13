extends Node2D

@onready var point_light_2d: PointLight2D = $PointLight2D
@onready var timer: Timer = $Timer

var base: float = 1.0
var flicker: float = 0.25

func _on_timer_timeout() -> void:
	point_light_2d.energy = base + randf_range(-flicker, flicker)

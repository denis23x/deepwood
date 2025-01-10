extends Node2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var point_light_2d: PointLight2D = $PointLight2D
@onready var timer: Timer = $Timer

var base: float = 0.75
var flicker: float = 0.25

func _ready() -> void:
	animation_player.play("Idle")
	
func _on_timer_timeout() -> void:
	point_light_2d.energy = base + randf_range(-flicker, flicker)

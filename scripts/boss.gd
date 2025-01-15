extends Node2D

@onready var move_speed: float = 1000.0
@onready var camera_2d: Camera2D = %Camera2D
@onready var camera_2d_trigger: bool = false
@onready var parent: Node2D
@onready var player: CharacterBody2D
@onready var x: int = 2704
@onready var y: int = 248

func _ready() -> void:
	parent = get_node("/root/Game")
	player = get_node("/root/Game/Player")
	
func _physics_process(delta: float) -> void:
	if camera_2d_trigger:
		if camera_2d.global_position != Vector2(x, y):
			camera_2d.global_position = camera_2d.global_position.move_toward(Vector2(x, y), move_speed * delta)
			
func _on_area_2d_body_entered(_body: Node2D) -> void:
	camera_2d_trigger = true	
	camera_2d.position_smoothing_enabled = false
	camera_2d.limit_smoothed = false

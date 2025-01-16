extends Node2D

@onready var camera_2d: Camera2D
@onready var player: CharacterBody2D
@onready var x: int = 2704
@onready var y: int = 248

func _ready() -> void:
	player = get_node("/root/Game/Player")
	camera_2d = get_node("/root/Game/Camera2D")
	
	player.camera_2d_attach = false
	camera_2d.global_position = Vector2(x, y)

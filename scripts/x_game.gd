extends Node2D

@onready var platform: AnimationPlayer = $Platforms/Platform/AnimationPlayer
@onready var platform_2: AnimationPlayer = $Platforms/Platform22/AnimationPlayer
@onready var platform_3: AnimationPlayer = $Platforms/Platform3/AnimationPlayer

func _ready() -> void:
	platform.play("Move")
	platform_2.play("Move")
	platform_3.play("Move")

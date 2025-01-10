extends Node2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	animation_player.active = true
	animation_player.play("Idle")
	
func _on_body_entered(body: Node2D) -> void:
	print("Savegame")

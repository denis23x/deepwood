extends Area2D

@export var damage: float = 10

func _on_body_entered(body: Node2D) -> void:
	for child in body.get_children():
		if child is Damageable:
			child.on_hit(damage)

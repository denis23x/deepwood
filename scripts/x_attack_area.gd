extends Area2D
class_name xAttackArea

@export var damage: float = 10

func _on_body_entered(body: Node2D) -> void:
	for child in body.get_children():
		if child is xDamageable:
			var direction_vector: Vector2 = (body.global_position - get_parent().global_position)
			var direction: float = sign(direction_vector.x)
			
			if (child.health > 0):
				if direction > 0:
					child.on_damage(damage, Vector2.RIGHT)
				elif direction < 0:
					child.on_damage(damage, Vector2.LEFT)
				else:
					child.on_damage(damage, Vector2.ZERO)

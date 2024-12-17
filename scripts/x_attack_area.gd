extends Area2D
class_name xAttackArea

@export var damage: float = 10

func _on_body_entered(body: Node2D) -> void:
	for child in body.get_children():
		if child is xDamageable:
			var direction_vector: Vector2 = (body.global_position - get_parent().global_position)
			var direction: Vector2 = (Vector2.LEFT if sign(direction_vector.x) < 0 else Vector2.RIGHT)
			var backstab: bool = child.character_body_2d.direction == direction.x
			var block: bool = false if backstab else bool(randi() % 2)
			var can_block: bool = body.name in ["Skeleton"]
			
			child.on_damage(damage, direction, (block if can_block else false))

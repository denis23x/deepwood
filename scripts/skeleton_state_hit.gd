extends AnimationState

@export var damageable: Damageable
@export var walk: AnimationState
@export var death: AnimationState
@export var knockback: Vector2 = Vector2(200, 0)
@export var sprite_2d: Sprite2D

func _ready() -> void:
	damageable.connect("on_damage_signal", on_hit)
	
func on_hit(node: Node, damage: float, direction: Vector2) -> void:
	character_body_2d.velocity = knockback * direction
	
	# Handle movement flip
	if direction.x < 0:
		sprite_2d.flip_h = false
	elif direction.x > 0:
		sprite_2d.flip_h = true
			
	# Call through Iterrupt State
	emit_signal("iterrupt_state", self)
	
func on_enter() -> void:
	playback.travel("Hit")
	
func _on_animation_tree_animation_finished(anim_name: StringName) -> void:
	if (damageable.health > 0):
		next_state = walk
	else:
		next_state = death

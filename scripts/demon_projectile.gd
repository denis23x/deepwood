extends CharacterBody2D

@onready var collision_shape_2d: CollisionShape2D = $Area2D/CollisionShape2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var speed = 200
@onready var direction : float
@onready var spawnPosition : Vector2
@onready var spawnRotation : float
@onready var spawnScale : Vector2
@onready var sprite_2d_2: Sprite2D = $Sprite2D2
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var target: CharacterBody2D
@onready var target_health: xDamageable

func _ready() -> void:
	global_position = spawnPosition
	global_rotation = spawnRotation
	global_scale = spawnScale
	
	# Link player
	target = get_node("/root/Game/Player")
	target_health = get_node("/root/Game/Player/Damageable")
	
	var pos: Vector2 = target.position
	
	pos.y = pos.y - 16
	
	var dir: Vector2 = (pos-position).normalized()
	
	velocity = dir * speed
	
	rotation = atan2(dir.y, dir.x)
	
func _physics_process(_delta) -> void:
	move_and_slide()
	
func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "Hit":
		queue_free()
		
func _on_area_2d_body_entered(_body: Node2D) -> void:
	collision_shape_2d.queue_free()
	sprite_2d_2.queue_free()
	
	speed = 0
	velocity = Vector2(0, 0)
	
	sprite_2d.visible = true
	
	# Hit
	animation_player.active = true
	animation_player.play("Hit")

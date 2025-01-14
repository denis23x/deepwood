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

func _ready() -> void:
	global_position = spawnPosition
	global_rotation = spawnRotation
	global_scale = spawnScale
	
	if direction == 1:
		sprite_2d_2.flip_h = true
	
func _physics_process(_delta) -> void:
	if direction:
		velocity.x = direction * speed
		
	move_and_slide()
	
func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "Hit":
		queue_free()
		
func _on_area_2d_body_entered(_body: Node2D) -> void:
	collision_shape_2d.queue_free()
	sprite_2d_2.queue_free()
	
	speed = 0
	sprite_2d.visible = true
	
	# Hit
	animation_player.active = true
	animation_player.play("Hit")

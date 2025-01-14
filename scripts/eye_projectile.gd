extends CharacterBody2D

@onready var collision_shape_2d: CollisionShape2D = $Area2D/CollisionShape2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var speed = 200
@onready var direction : float
@onready var spawnPosition : Vector2
@onready var spawnRotation : float
@onready var spawnScale : Vector2

func _ready() -> void:
	global_position = spawnPosition
	global_rotation = spawnRotation
	global_scale = spawnScale
	
func _physics_process(_delta) -> void:
	if direction:
		velocity.x = direction * speed
		
	move_and_slide()
	
func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "Hit":
		queue_free()
		
func _on_area_2d_body_entered(_body: Node2D) -> void:
	collision_shape_2d.queue_free()
	
	# Hit
	animation_player.play("Hit")

extends CharacterBody2D

var speed = 200
var direction : float
var spawnPosition : Vector2
var spawnRotation : float
var spawnScale : Vector2

func _ready() -> void:
	global_position = spawnPosition
	global_rotation = spawnRotation
	global_scale = spawnScale
	
func _physics_process(_delta) -> void:
	if direction:
		velocity.x = direction * speed
		
	move_and_slide()
	
func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "Projectile":
		queue_free()

extends CharacterBody2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var collision_shape_2d: CollisionShape2D = $Area2D/CollisionShape2D
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D
@onready var target: CharacterBody2D
@onready var speed: int = 200
@onready var direction: float
@onready var spawnPosition: Vector2
@onready var spawnRotation: float
@onready var spawnScale: Vector2

func _ready() -> void:
	global_position = spawnPosition
	global_rotation = spawnRotation
	global_scale = spawnScale
	
	# PLay sound
	audio_stream_player_2d.play()
	
	# Link player
	target = get_node("/root/Game/Player")
	
func _physics_process(_delta) -> void:
	var pos: Vector2 = target.position
	
	pos.y = pos.y - 16
	
	var dir: Vector2 = (pos-position).normalized()
	
	velocity = dir * speed
	
	move_and_slide()
	
func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "Hit":
		queue_free()
		
func _on_area_2d_body_entered(_body: Node2D) -> void:
	collision_shape_2d.queue_free()
	
	# Hit
	animation_player.play("Hit")

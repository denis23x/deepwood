extends CharacterBody2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D

var speed = 50
var direction: float
var spawnPosition: Vector2
var spawnRotation: float
var spawnScale: Vector2
var bounce_force: float = 2.0
var bounce_value: float = -300
var bounce_count: float = 1.0

func _ready() -> void:
	global_position = spawnPosition
	global_rotation = spawnRotation
	global_scale = spawnScale
	
func _physics_process(delta) -> void:
	if not is_on_floor():
		velocity.y += get_gravity().y * bounce_force * delta
	else:
		bounce_count += 1.0
		velocity.y = bounce_value / bounce_count
		
	# Handle movement
	if direction:
		velocity.x = direction * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		
	move_and_slide()
	
func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "Projectile":
		direction = 0
		animation_player.play("Projectile_2")
		
		# Sound Effect
		audio_stream_player_2d.pitch_scale = 1.5
		audio_stream_player_2d.play()
	elif anim_name == "Projectile_2":
		queue_free()

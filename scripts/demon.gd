extends CharacterBody2D
class_name Demon

@export var speed: float = 60.0
@export var animation_state_machine: AnimationStateMachine
@export var animation_tree: AnimationTree
@export var sprite_2d: Sprite2D
@export var direction: int = -1 # randi() % 3 - 1
@export var attack: AnimationState
@export var direction_change_interval: float = 2.0  # Time in seconds

@onready var target: xDamageable
@onready var player: CharacterBody2D
@onready var x_left: int = -128
@onready var x_bottom: int = -40
@onready var x_right: int = 128
@onready var x_top: int = -128
@onready var time_since_change = 0.0
@onready var damageable: xDamageable = $Damageable
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D

func _ready() -> void:
	# Link player
	target = get_node("/root/Game/Player/Damageable")
	player = get_node("/root/Game/Player")
	
func _physics_process(delta: float) -> void:
	if damageable.health > 0:
		position += velocity * speed * delta
		
		# Reverse direction at bounds
		if position.x <= x_left or position.x >= x_right:
			velocity.x *= -1
		if position.y <= x_top or position.y >= x_bottom:
			velocity.y *= -1
			
		# Randomize direction periodically
		time_since_change += delta
		
		if time_since_change >= direction_change_interval:
			velocity = Vector2(randf_range(-1, 1), randf_range(-1, 1)).normalized()
			time_since_change = 0.0
			
		var dir: Vector2 = (player.global_position - global_position).normalized()
		
		# Handle movement flip
		if dir.x < 0:
			sprite_2d.flip_h = true
			collision_shape_2d.position.x = -8
		else:
			sprite_2d.flip_h = false
			collision_shape_2d.position.x = 8
		
func switch_direction(_next_direction: int) -> void:
	pass
	
func _on_timer_timeout() -> void:
	if target and target.health > 0:
		animation_state_machine.switch_states(attack)

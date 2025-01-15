extends CharacterBody2D
class_name Demon

@export var speed: float = 60.0
@export var animation_state_machine: AnimationStateMachine
@export var animation_tree: AnimationTree
@export var sprite_2d: Sprite2D
@export var direction: int = -1 # randi() % 3 - 1
@export var attack: AnimationState

@onready var target: xDamageable
@onready var player: CharacterBody2D

@onready var x_left: int = 2592
@onready var x_bottom: int = 192
@onready var x_right: int = 2816
@onready var x_top: int = 104

func _ready() -> void:
	# Link player
	target = get_node("/root/Game/Player/Damageable")
	player = get_node("/root/Game/Player")
	
func _physics_process(delta: float) -> void:
	# Move Y
	if global_position.y <= x_bottom:
		velocity.y += 10 * delta
	elif global_position.y >= x_top:
		velocity.y -= 100 * delta
		
	# Move X
	if global_position.x + 10 < x_left or global_position.x - 10 > x_right:
		direction = (-1 if direction == 1 else 1)
		
	# Handle movement animation direction
	animation_tree.set("parameters/Move/blend_position", direction)
	
	var dir: Vector2 = (player.global_position - global_position).normalized()
	
	# Handle movement flip
	if dir.x < 0:
		sprite_2d.flip_h = true
	else:
		sprite_2d.flip_h = false
	
	# Handle movement
	if direction and animation_state_machine.current_state.can_move:
		velocity.x = direction * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		
	move_and_slide()
	
func switch_direction(_next_direction: int) -> void:
	pass
	
func _on_timer_timeout() -> void:
	if target and target.health > 0:
		animation_state_machine.switch_states(attack)

extends Node

@onready var hearts: xDamageable
@onready var hearts_h: HBoxContainer
@onready var coins: int = 0
@onready var coins_h: Label
@onready var double_jump: bool = false
@onready var double_jump_h: Panel
@onready var dash: bool = false
@onready var dash_h: Panel
@onready var area_2d_3: Area2D

# Player
@onready var player: CharacterBody2D
@onready var player_position: Vector2
@onready var player_direction: float

func get_current_scene_name() -> String:
	var current_scene = get_tree().root.get_child(get_tree().root.get_child_count() - 1)
	return current_scene.name if current_scene else "No scene loaded"
	
func _ready() -> void:
	hearts = get_node("/root/Game/Player/Damageable")
	coins_h = get_node("/root/Game/HUD/%Coins")
	hearts_h = get_node("/root/Game/HUD/%Hearts")
	double_jump_h = get_node("/root/Game/HUD/%DoubleJump")
	dash_h = get_node("/root/Game/HUD/%Dash")

	# Player
	player = get_node("/root/Game/Player")
	
	# Boss spawn
	area_2d_3 = get_node("/root/Game/PickUps/Area2D3")
	
	# Default respawn
	player_position = player.global_position
	player_direction = player.direction
	
func handle_pickup(value: String) -> void:
	match value:
		"coins":
			coins += 1
			coins_h.text = "Coins: " + str(coins)
		"double_jump":
			double_jump = true
			double_jump_h.visible = double_jump
		"dash":
			dash = true
			dash_h.visible = dash
		"potion":
			hearts.health = 6.0 if hearts.health + 2.0 >= 6 else hearts.health + 2.0
			handle_health(hearts.health)
		_:
			print("Picked up something unknown")
	
func handle_health(health: float) -> void:
	var full_hearts: float = floor(health / 2)
	var remainder: float = fmod(health, 2.0)
	
	for i in range(3):
		var sprite: Sprite2D = hearts_h.get_child(i).get_node("Sprite2D")
		
		if i < full_hearts:
			sprite.frame = 0
		elif i == full_hearts and remainder > 0:
			sprite.frame = 1
		else:
			sprite.frame = 2
	
func handle_checkpoint() -> void:
	player_position = player.global_position
	player_direction = player.direction
	
func handle_respawn() -> void:
	hearts.health = 6
	handle_health(hearts.health)
	
	player.global_position = player_position
	player.switch_direction(player_direction)
	
	if has_node("/root/Game/Boss"):
		player.camera_2d_attach = true
		
		# Restore Summon
		area_2d_3.visible = true
		area_2d_3.monitoring = true
		
		# Remove boss
		get_node("/root/Game/Boss").queue_free()
		
		# Change music
		xMusic.handle_music("main")

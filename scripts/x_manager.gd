extends Node

@onready var hearts: xDamageable
@onready var hearts_h: HBoxContainer
@onready var coins: int = 0
@onready var coins_h: Label
@onready var double_jump: bool = false
@onready var double_jump_h: Panel
@onready var dash: bool = false
@onready var dash_h: Panel

func _ready() -> void:
	hearts = get_node("/root/Game/Player/Damageable")
	coins_h = get_node("/root/Game/HUD/%Coins")
	hearts_h = get_node("/root/Game/HUD/%Hearts")
	double_jump_h = get_node("/root/Game/HUD/%DoubleJump")
	dash_h = get_node("/root/Game/HUD/%Dash")
	
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
			if hearts.health + 2 <= 6:
				hearts.health += 2
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
			

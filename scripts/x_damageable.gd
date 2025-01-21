extends Node
class_name xDamageable

@export var health: float = 10.0
@export var label: Label
@export var timer: Timer
@export var hit: AnimationState
@export var death: AnimationState
@export var block: AnimationState
@export var character_body_2d: CharacterBody2D
@export var knockback: Vector2 = Vector2(250, 0)
@export var animation_state_machine: AnimationStateMachine

@onready var camera_2d: Camera2D
@onready var camera_shake_noise: FastNoiseLite
@onready var label_position_default: Vector2 = label.position
@onready var label_position_float: Vector2 = label.position

@warning_ignore("unused_signal") signal iterrupt_state(next_state: AnimationState)

func _ready() -> void:
	camera_2d = get_node("/root/Game/Camera2D")
	camera_shake_noise = FastNoiseLite.new()
	
func _process(delta: float) -> void:
	if not timer.is_stopped():
		label.position += label_position_float * delta
		
func _on_timer_timeout() -> void:
	label.text = ""
	label.position = label_position_default
	timer.stop()
	
func on_heal(heal: float) -> void:
	health = 6.0 if health + heal >= 6 else health + heal
	label.text = "+" + str(heal) if health < 6 else "Full"
	label.add_theme_color_override("font_color", Color.CHARTREUSE)
	timer.wait_time = 0.4
	timer.start()
	
func on_damage(damage: float, direction: Vector2, can_block: bool = false) -> void:
	if health > 0 and (can_block or animation_state_machine.current_state.name == "Block"):
		if character_body_2d.name == "Player":
			animation_state_machine.current_state.handle_block_effect()
		else:
			emit_signal("iterrupt_state", block)
			
		label.text = "Block"
		label.add_theme_color_override("font_color", Color.ORANGE)
		timer.wait_time = 0.2
		timer.start()
		
	elif health > 0:
		# Minus HP
		health -= damage
		
		# Handle damage knockback
		if character_body_2d.name != "Demon":
			character_body_2d.velocity.x = knockback.x * direction.x
			
		if character_body_2d.name == "Demon":
			character_body_2d.handle_health()
			
		# Camera shake
		if character_body_2d.name == "Player":
			get_tree().create_tween().tween_method(handle_camera_shake, 5.0, 1.0, 0.5)
			
			# Update HUD
			xManager.handle_health(health)
			
		label.text = "-" + str(damage)
		label.add_theme_color_override("font_color", Color.CRIMSON)
		timer.wait_time = 0.2
		timer.start()
		
		if health <= 0:
			emit_signal("iterrupt_state", death)
		else:
			emit_signal("iterrupt_state", hit)
			
	# Handle damage flip
	character_body_2d.switch_direction((-1 if direction.x == 1 else 1))
	
func handle_camera_shake(intensity: float):
	var camera_offset_x: float = 0
	var camera_offset_y: float = -60
	var camera_offset: float = camera_shake_noise.get_noise_1d(Time.get_ticks_msec()) * intensity
	
	camera_2d.offset.x = camera_offset_x + camera_offset
	camera_2d.offset.y = camera_offset_y + camera_offset

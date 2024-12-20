extends Node
class_name xDamageable

@export var health: float = 30.0
@export var label: Label
@export var label_position_default: Vector2 = Vector2(0, -40)
@export var label_position_float: Vector2 = Vector2(0, -20)
@export var timer: Timer
@export var hit: AnimationState
@export var block: AnimationState
@export var character_body_2d: CharacterBody2D
@export var knockback: Vector2 = Vector2(250, 0)
@export var animation_state_machine: AnimationStateMachine

var camera_2d: Camera2D
var camera_shake_noise: FastNoiseLite

@warning_ignore("unused_signal") signal iterrupt_state(next_state: AnimationState)

func _ready():
	camera_2d = get_node("/root/Game/Player/Camera2D")
	camera_shake_noise = FastNoiseLite.new()
	
func _process(delta: float) -> void:
	if not timer.is_stopped():
		label.position += label_position_float * delta
		
func _on_timer_timeout() -> void:
	label.text = ""
	label.position = label_position_default
	timer.stop()
	
func on_damage(damage: float, direction: Vector2, can_block: bool = false) -> void:
	if health > 0 and (can_block or animation_state_machine.current_state.name == "Block"):
		if character_body_2d.name == "Player":
			animation_state_machine.current_state.handle_block_effect()
				
		label.text = "Block"
		label.add_theme_color_override("font_color", Color.CHARTREUSE)
		timer.start()
		
		emit_signal("iterrupt_state", block)
	elif health >= 0:
		# Minus HP
		health -= damage
		
		# Handle damage knockback
		character_body_2d.velocity.x = knockback.x * direction.x
		
		# Camera shake
		if character_body_2d.name == "Player":
			get_tree().create_tween().tween_method(handle_camera_shake, 5.0, 1.0, 0.5)
			
		label.text = "-" + str(damage)
		label.add_theme_color_override("font_color", Color.CRIMSON)
		timer.start()
		
		emit_signal("iterrupt_state", hit)
		
	# Handle damage flip
	character_body_2d.switch_direction((-1 if direction.x == 1 else 1))
	
func handle_camera_shake(intensity: float):
	var camera_offset_x: float = 0
	var camera_offset_y: float = -20
	var camera_offset: float = camera_shake_noise.get_noise_1d(Time.get_ticks_msec()) * intensity
	
	camera_2d.offset.x = camera_offset_x + camera_offset
	camera_2d.offset.y = camera_offset_y + camera_offset

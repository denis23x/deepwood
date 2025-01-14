extends CanvasLayer

@onready var target_offset_y: float = 0
@onready var interpolation_speed: float = 5.0
@onready var is_transition_active: bool = false
@onready var panel: Panel = $Panel
@onready var camera2D: Camera2D

func _ready() -> void:
	camera2D = get_node("/root/Game/Player/Camera2D")
	
func _process(delta: float) -> void:
	if is_transition_active:
		camera2D.offset.y = lerp(camera2D.offset.y, target_offset_y, interpolation_speed * delta)
		
		if abs(camera2D.offset.y - target_offset_y) < 1.0:
			get_node("/root/Game/HUD").visible = true
			queue_free()
			
func _on_button_pressed() -> void:
	target_offset_y = -60.0
	is_transition_active = true
	panel.visible = false
	
func _on_button_2_pressed() -> void:
	get_tree().quit()

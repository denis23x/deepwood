extends Area2D

@onready var color_rect: ColorRect = $CanvasLayer/ColorRect
@onready var target_vignette_intensity: float = 0.3
@onready var current_vignette_intensity: float = 0.3
@onready var transition_duration: float = 1.0
@onready var transition_time: float = 0.0

func _process(delta: float) -> void:
	if transition_time < transition_duration:
		transition_time += delta
		
		# Interpolate between current and target values based on elapsed time
		current_vignette_intensity = lerp(current_vignette_intensity, target_vignette_intensity, transition_time / transition_duration)
		color_rect.get_material().set_shader_parameter("vignette_intensity", current_vignette_intensity)
		
func _on_body_entered(_body: Node2D) -> void:
	target_vignette_intensity = 2.4
	transition_time = 0.0
	
func _on_body_exited(_body: Node2D) -> void:
	target_vignette_intensity = 0.4
	transition_time = 0.0

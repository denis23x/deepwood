extends CanvasLayer

@onready var hud: CanvasLayer
@onready var menu: CanvasLayer
@onready var camera_2d: Camera2D
@onready var labels: Node
@onready var button: Button = %Button
@onready var label: Label = %Label
@onready var label_2: Label = %Label2
@onready var texture_rect: TextureRect = %TextureRect
@onready var texture_rect_2: TextureRect = %TextureRect2

func _ready() -> void:
	hud = get_node("/root/Game/HUD")
	menu = get_node("/root/Game/Menu")
	camera_2d = get_node("/root/Game/Camera2D")
	labels = get_node("/root/Game/Labels")
	
func _process(_delta: float) -> void:
	if labels.visible:
		if Input.is_action_just_pressed("escape"):
			if not menu.visible:
				show_menu()
			else:
				hide_menu()
			
func _on_button_pressed() -> void:
	hide_menu()
	
	# Show labels
	labels.visible = true
	
func _on_button_2_pressed() -> void:
	get_tree().quit()
	
func show_menu() -> void:
	if labels.visible:
		get_tree().paused = true
		
	hud.visible = false
	menu.visible = true
	
func hide_menu() -> void:
	if labels.visible:
		get_tree().paused = false
		
	hud.visible = true
	menu.visible = false
	
func handle_finish() -> void:
	label.text = "You Won!"
	label_2.visible = true
	button.visible = false
	texture_rect.visible = false
	texture_rect_2.visible = true
	
	show_menu()

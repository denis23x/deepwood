extends CanvasLayer

@onready var hud: CanvasLayer
@onready var menu: CanvasLayer
@onready var labels: Node
@onready var button: Button = %Button
@onready var label: Label = %Label
@onready var label_2: Label = %Label2
@onready var texture_rect: TextureRect = %TextureRect
@onready var texture_rect_2: TextureRect = %TextureRect2
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D
@onready var game_over: bool = false
@onready var panel: Panel = %Panel

func _ready() -> void:
	hud = get_node("/root/Game/HUD")
	menu = get_node("/root/Game/Menu")
	labels = get_node("/root/Game/Labels")
	
	# Loop
	audio_stream_player_2d.connect("finished", _on_AudioStreamPlayer2D_finished)
	
func _process(_delta: float) -> void:
	if labels.visible and not game_over:
		if Input.is_action_just_pressed("escape"):
			if not menu.visible:
				show_menu()
			else:
				hide_menu()
			
func _on_button_pressed() -> void:
	hide_menu()
	
	button.text = "Continue"
	
	# Show labels
	labels.visible = true
	
	# Start Main music
	xMusic.handle_music("main")
	
func show_menu(volume_db = -5.0) -> void:
	if labels.visible:
		get_tree().paused = true
		
	hud.visible = false
	menu.visible = true
	
	audio_stream_player_2d.volume_db = volume_db
	xMusic.fade_in(audio_stream_player_2d)
	
func hide_menu() -> void:
	if labels.visible:
		get_tree().paused = false
		
	hud.visible = true
	menu.visible = false
	
	audio_stream_player_2d.volume_db = -5.0
	xMusic.fade_out(audio_stream_player_2d)
	
func handle_finish() -> void:
	panel.self_modulate.a = 1
	label.text = "You Won!"
	label_2.visible = true
	button.visible = false
	texture_rect.visible = false
	texture_rect_2.visible = true
	
	game_over = true
	
	# Change music
	audio_stream_player_2d.stream = load("res://assets/music/My Walk.mp3")
	audio_stream_player_2d.disconnect("finished", _on_AudioStreamPlayer2D_finished)
	
	show_menu(5.0)
	
func _on_AudioStreamPlayer2D_finished() -> void:
	audio_stream_player_2d.play()

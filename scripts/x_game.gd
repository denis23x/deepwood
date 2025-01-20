extends Node2D

@onready var boss = load("res://scenes/boss.tscn")
@onready var parallax_background: ParallaxBackground = $ParallaxBackground
@onready var tile_map_layer_background: TileMapLayer = $Inactive/TileMapLayerBackground
@onready var label_2: Label = $Labels/Label2
@onready var label_3: Label = $Labels/Label3
@onready var area_2d_3: Area2D = $PickUps/Area2D3
@onready var menu: CanvasLayer = $Menu
@onready var vignette: CanvasLayer = $Vignette/CanvasLayer
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $PickUps/Area2D3/AudioStreamPlayer2D
@onready var player: Player = $Player

func _ready() -> void:
	Engine.max_fps = 60
	
	menu.show_menu()
	
	# Turn on visible
	parallax_background.visible = true
	tile_map_layer_background.visible = true
	vignette.visible = true
	
	# Turn off visible
	label_2.visible = false
	label_3.visible = false
	
	# Update ALL sounds
	update_node(get_tree().get_current_scene())
	
func update_node(node):
	if node is AudioStreamPlayer2D:
		node.panning_strength = 0
		node.max_distance = 4000
		
	for child in node.get_children():
		update_node(child)
		
func _on_area_2d_3_body_entered(_body: Node2D) -> void:
	area_2d_3.set_deferred("visible", false)
	area_2d_3.set_deferred("monitoring", false)
	audio_stream_player_2d.play()
	
	var damageable: xDamageable = player.get_node("Damageable")
	
	get_tree().create_tween().tween_method(damageable.handle_camera_shake, 5.0, 1.0, 2.0)
	
	# Change music
	xMusic.handle_music("boss")
	
	# Spawn
	var instance: Node2D = boss.instantiate()
		
	instance.name = "Boss"
	instance.position = Vector2(2704, 232)
	instance.modulate.a = 0
	
	get_node("/root/Game").add_child.call_deferred(instance)
	
	# Fade Effect
	var elapsed: float = 0.0
	var duration: float = 2.0
	
	while elapsed < duration:
		elapsed += get_process_delta_time()
		
		var alpha = clamp(elapsed / duration, 0, 1)
		
		instance.modulate.a = alpha
		
		await get_tree().process_frame
		
	instance.modulate.a = 1.0

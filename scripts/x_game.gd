extends Node2D

@onready var parallax_background: ParallaxBackground = $ParallaxBackground
@onready var tile_map_layer_background: TileMapLayer = $Inactive/TileMapLayerBackground
@onready var hud: CanvasLayer = $HUD
@onready var label_2: Label = $Labels/Label2
@onready var label_3: Label = $Labels/Label3
@onready var canvas_layer: CanvasLayer = $Vignette/CanvasLayer
@onready var menu: CanvasLayer = $Menu
@onready var camera_2d: Camera2D = $Player/Camera2D

func _ready() -> void:
	# Turn on visible
	parallax_background.visible = true
	tile_map_layer_background.visible = true
	hud.visible = not menu.visible
	camera_2d.offset.y = (get_viewport().size.y * -1 if menu.visible else -60.0)
	canvas_layer.visible = true
	
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

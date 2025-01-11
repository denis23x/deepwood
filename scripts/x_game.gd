extends Node2D

@onready var parallax_background: ParallaxBackground = $ParallaxBackground
@onready var tile_map_layer_background: TileMapLayer = $Inactive/TileMapLayerBackground
@onready var hud: CanvasLayer = $HUD
@onready var label_2: Label = $Labels/Label2
@onready var label_3: Label = $Labels/Label3

func _ready() -> void:
	# Turn on visible
	parallax_background.visible = true
	tile_map_layer_background.visible = true
	hud.visible = true
	
	# Turn off visible
	label_2.visible = false
	label_3.visible = false
	
	# Update ALL sounds
	process_node(get_tree().get_current_scene())
	
func process_node(node):
	if node is AudioStreamPlayer2D:
		node.panning_strength = 0
		node.max_distance = 4000
		
	for child in node.get_children():
		process_node(child)

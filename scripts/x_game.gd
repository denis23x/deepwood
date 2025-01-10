extends Node2D

@onready var platform: AnimationPlayer = $Platforms/Platform/AnimationPlayer
@onready var platform_2: AnimationPlayer = $Platforms/Platform22/AnimationPlayer
@onready var platform_3: AnimationPlayer = $Platforms/Platform3/AnimationPlayer
@onready var parallax_background: ParallaxBackground = $ParallaxBackground
@onready var tile_map_layer_background: TileMapLayer = $Inactive/TileMapLayerBackground
@onready var hud: CanvasLayer = $HUD
@onready var label_2: Label = $Labels/Label2
@onready var label_3: Label = $Labels/Label3

func _ready() -> void:
	
	# Start platforms
	platform.play("Move")
	platform_2.play("Move")
	platform_3.play("Move")
	
	# Turn on visible
	parallax_background.visible = true
	tile_map_layer_background.visible = true
	hud.visible = true
	
	# Turn off visible
	label_2.visible = false
	label_3.visible = false

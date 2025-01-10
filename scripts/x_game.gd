extends Node2D

@onready var platform: AnimationPlayer = $Platforms/Platform/AnimationPlayer
@onready var platform_2: AnimationPlayer = $Platforms/Platform22/AnimationPlayer
@onready var platform_3: AnimationPlayer = $Platforms/Platform3/AnimationPlayer
@onready var parallax_background: ParallaxBackground = $ParallaxBackground
@onready var tile_map_layer_background: TileMapLayer = $Inactive/TileMapLayerBackground

func _ready() -> void:
	platform.play("Move")
	platform_2.play("Move")
	platform_3.play("Move")
	
	parallax_background.visible = true
	tile_map_layer_background.visible = true

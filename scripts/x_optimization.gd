extends Node

func switch_enemy(character_body_2d: CharacterBody2D) -> void:
	if character_body_2d.name != "Demon":
		for child in character_body_2d.get_children():
			if child is Sprite2D:
				if child.name == "Static":
					var new_sprite = Sprite2D.new()
					
					new_sprite.texture = child.texture
					new_sprite.global_position = character_body_2d.global_position
					new_sprite.global_rotation = character_body_2d.global_rotation
					new_sprite.global_scale = character_body_2d.global_scale
					new_sprite.flip_h = (true if character_body_2d.direction != 1 else false)
					new_sprite.hframes = child.hframes
					new_sprite.vframes = child.vframes
					new_sprite.frame = child.frame
					new_sprite.frame_coords = child.frame_coords
					
					# Add the new Sprite2D to the main scene
					get_node("/root/Game/Enemies").add_child(new_sprite)
					
					# Free the original enemy instance
					character_body_2d.queue_free()
	else:
		character_body_2d.queue_free()

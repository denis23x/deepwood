shader_type canvas_item;

uniform vec4 new : source_color;

void fragment() {
	vec4 current_pixel = texture(TEXTURE,UV);
	vec4 current_pixel2 = texture(TEXTURE,UV);
	if (current_pixel == current_pixel2)
		COLOR.rgb = new.rgb * current_pixel.g;
	else
		COLOR = current_pixel;
}
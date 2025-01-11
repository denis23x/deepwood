shader_type canvas_item;

uniform float speed = 2.0;
uniform float strength = 0.5;
uniform float y_origin = 0.0;
uniform int restrict_dir : hint_range(-1,1) = 0;

void vertex() {
	float x = sin(TIME*speed)*(VERTEX.y-y_origin)*strength+sin(TIME*speed)*strength*8.0;
    VERTEX.x += x*float(restrict_dir==0)+abs(x)*float(-restrict_dir);
}
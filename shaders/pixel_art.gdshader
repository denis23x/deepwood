shader_type canvas_item;

varying mat4 angle;
varying mat4 anti_angle;

void vertex() {
	angle=mat4(mat3(MODEL_MATRIX))+mat4(vec4(0.),vec4(0.),vec4(0.,0.,1.,0.),vec4(0.,0.,0.,1.));

	mat3 rotation = mat3(angle);

    mat3 inverseRotation3x3 = transpose(rotation);

    mat4 inverseRotation4x4 =mat4(inverseRotation3x3)+mat4(vec4(0.),vec4(0.),vec4(0.,0.,1.,0.),vec4(0.,0.,0.,1.));
	anti_angle=inverseRotation4x4;
}

void fragment() {
	float pixel_sc=256.;
	float pixel_size=1./pixel_sc;

	vec2 uv=UV-.5;
	uv*=pixel_sc;
	uv=(anti_angle*vec4(floor((angle*vec4(uv,0.,1.)).xy),0.,1.)).xy/(pixel_sc-1.)+.5+pixel_size/2.;

	vec4 color_1=texture(TEXTURE,uv);

	color_1.a=step(0.5,color_1.a);

	vec3 color_c=color_1.rgb;
	vec3 color_up=texture(TEXTURE,vec2(uv.x,uv.y+pixel_size)).rgb;
	vec3 color_down=texture(TEXTURE,vec2(uv.x,uv.y-pixel_size)).rgb;
	vec3 color_right=texture(TEXTURE,vec2(uv.x+pixel_size,uv.y)).rgb;
	vec3 color_left=texture(TEXTURE,vec2(uv.x-pixel_size,uv.y)).rgb;
	vec3 color_up_right=texture(TEXTURE,vec2(uv.x+pixel_size,uv.y+pixel_size)).rgb;
	vec3 color_down_right=texture(TEXTURE,vec2(uv.x+pixel_size,uv.y-pixel_size)).rgb;
	vec3 color_down_left=texture(TEXTURE,vec2(uv.x-pixel_size,uv.y-pixel_size)).rgb;
	vec3 color_up_left=texture(TEXTURE,vec2(uv.x-pixel_size,uv.y+pixel_size)).rgb;

	float l1=length(color_c-color_up);
	float l2=length(color_c-color_down);
	float l3=length(color_c-color_right);
	float l4=length(color_c-color_left);
	float l5=length(color_c-color_up_right);
	float l6=length(color_c-color_down_right);
	float l7=length(color_c-color_down_left);
	float l8=length(color_c-color_up_left);

	float min_l=min(min(min(l1,l2),min(l3,l4)),min(min(l5,l6),min(l7,l8)));

	float bender=0.0;

	COLOR=color_1;
	COLOR=abs(min_l-l1)<0.00001?vec4(mix(color_up,color_c,bender),color_1.a):color_1;
	COLOR=abs(min_l-l2)<0.00001?vec4(mix(color_down,COLOR.rgb,bender),COLOR.a):COLOR;
	COLOR=abs(min_l-l3)<0.00001?vec4(mix(color_right,COLOR.rgb,bender),COLOR.a):COLOR;
	COLOR=abs(min_l-l4)<0.00001?vec4(mix(color_left,COLOR.rgb,bender),COLOR.a):COLOR;
	COLOR=abs(min_l-l5)<0.00001?vec4(mix(color_up_right,COLOR.rgb,bender),COLOR.a):COLOR;
	COLOR=abs(min_l-l6)<0.00001?vec4(mix(color_down_right,COLOR.rgb,bender),COLOR.a):COLOR;
	COLOR=abs(min_l-l7)<0.00001?vec4(mix(color_down_left,COLOR.rgb,bender),COLOR.a):COLOR;
	COLOR=abs(min_l-l8)<0.00001?vec4(mix(color_up_left,COLOR.rgb,bender),COLOR.a):COLOR;
}
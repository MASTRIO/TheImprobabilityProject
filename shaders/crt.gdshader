shader_type canvas_item;

uniform float flicker_amount = 7.0;
uniform float red_amount = 5.0;

float rand(vec2 co){
    return fract(sin(dot(co.xy ,vec2(12.9898,78.233))) * 43758.5453);
}

void fragment() {
	COLOR = vec4(rand(vec2(TIME, 0.0)) / red_amount, 0.0, 0.0, rand(vec2(TIME, 0.0)) / flicker_amount);
}
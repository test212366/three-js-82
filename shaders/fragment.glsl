uniform float time;
uniform float progress;
uniform sampler2D texture1;
uniform sampler2D mask;
uniform vec4 resolution;
varying vec2 vUv;
varying vec3 vPosition;
float PI = 3.1415926;
void main() {
	vec4 color = vec4(0.,0.,0.,1.);
	vec4 color2 = vec4(0.,0.,0.,1.);

	vec4 flamecolor = vec4(0.929, 0.706, 0.106, 1.);
	vec4 result;
	vec4 gradient = mix(  vec4(1.,1.,1.,1.),vec4(0.,0.,0.,1.), vUv.y * 2.);
	vec4 gradientFlame = mix(vec4(0.553,0.196,0.024,1.),  vec4(0.929, 0.706, 0.106, 1.), vUv.y * 2.);


	// gradient += .2;

	vec4 noise = texture2D(texture1, vec2( fract(vUv.x  ), fract(vUv.y - time / 10.)));
	vec4 maskT = texture2D(mask, vec2(vUv.x + (1. - gradient.r) * sin(time / 10. + vUv.y) / 10., vUv.y));


	noise += gradient;
 	result = noise * gradient;
	if(result.r > 0.5 ) {
		color.r = 1.;
	} else {
		color.r = 0.;
	}
	if(result.r > 0.4) {
		color2.r = 1.;
	} else {
		color2.r = 0.;
	}
	color = vec4(color.r, color.r, color.r, 1.);
	color2 = clamp(vec4(color2.r, color2.r, color2.r, 1.) - color, 0., 1.) ;

	vec4 doubleFlame = clamp( color2, 0. ,1.);

	color *= gradientFlame ; // * maskT
	color2 *= vec4(0.910, 0.753, .518, 1.);

		gl_FragColor = color + color2;

}
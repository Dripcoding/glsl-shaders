#ifdef GL_ES
precision mediump float;
#endif

uniform float u_time;
uniform vec2 u_resolution;

// sin function - use sine wave to create repeating patterns

// create infinite number of color gradients
vec3 palette(float t) {
    vec3 a = vec3(0.5, 0.5, 0.5);
    vec3 b = vec3(0.5, 0.5, 0.5);
    vec3 c = vec3(1.0, 1.0, 1.0);
    vec3 d = vec3(0.263, 0.416, 0.557);

    return a + b * cos(6.28318 * (c * t + d));
}

void mainImage (out vec4 fragColor, in vec2 fragCoord) {
    vec2 uv = (fragCoord * 2.0 - u_resolution.xy) / u_resolution.y;

    float stretchFactor = 8.0; // controls number of rings
    float colorIntensityFactor = 8.0; // controls width of rings

    
    float len = length (uv);
    vec3 color = palette(len + u_time); // rainbow colors based on distance from center
    len = sin (len * stretchFactor - u_time * 2.0) / colorIntensityFactor; // 8 stretches wave and alters color intensity
    len = abs (len);

    // len = smoothstep(0.0, 0.1, len);

    // values less than 0.02 become very bright, values greater than 0.02 become darker
    len = 0.02 / len; 

    // color the rings!
    // vec3 color = vec3(1.0 , 2.0, 3.0);
    color *= len;
    fragColor = vec4 (color, 1.0);
}

void main () {
    mainImage (gl_FragColor, gl_FragCoord.xy);
}
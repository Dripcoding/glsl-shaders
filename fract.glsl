#ifdef GL_ES
precision mediump float;
#endif

uniform float u_time;
uniform vec2 u_resolution;

vec3 palette (float t) {
    vec3 a = vec3 (0.5, 0.5, 0.5);
    vec3 b = vec3 (0.5, 0.5, 0.5);
    vec3 c = vec3 (1.0, 1.0, 1.0);
    vec3 d = vec3 (0.263, 0.416, 0.557);

    return a + b * cos (6.28318 * (c * t + d));
}

void mainImage (out vec4 fragColor, in vec2 fragCoord) {
    vec2 uv = (fragCoord * 2.0 - u_resolution.xy) / u_resolution.y;

    vec2 uv0 = uv; // initial uv coordinates before fract

    vec3 finalColor = vec3 (0.0);

    const float layers = 4.0;
    const float timeFactor = 0.4;

    // use iterations to create a fractal-like effect
    for (float i = 0.0; i < layers; i ++) {
        uv = fract (uv * 1.5) - 0.5;

        float stretchFactor = 8.0;
        float colorIntensityFactor = 8.0;

        float len = length (uv) * exp (- length (uv0));
        // add length of the original uv coordinates to the time variable
        // this creates a rainbow effect based on distance from the center
        vec3 color = palette (length (uv0) + i * timeFactor + u_time + timeFactor);
        len = sin (len * stretchFactor - u_time * 2.0) / colorIntensityFactor;
        len = abs (len);

        // improve contrast - enhance darker colors for values near 0
        len = pow (0.01 / len, 2.0);
        finalColor += color * len;
    }

    fragColor = vec4 (finalColor, 1.0);
}

void main () {
    mainImage (gl_FragColor, gl_FragCoord.xy);
}
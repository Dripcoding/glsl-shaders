#ifdef GL_ES
precision mediump float;
#endif


// each shader must have a mainImage function
// fragCoord - has 2 values x,y of the current pixel
// fragColor - has 4 values r,g,b,a of the current pixel

// fragCoord range depends on the size of the canvas
// to mitigate this clip the range to -1 to 1

void mainImage(out vec4 fragColor, in vec2 fragCoord) {

    // Normalized pixel coordinates (from 0 to 1)
    // fully black shader
    // fragColor = vec4(0.0, 0.0, 0.0, 1.0);

    // white shader
    // fragColor = vec4(1.0, 1.0, 1.0, 1.0);

    // re-centering the canvas around bottom left
    vec2 resolution = vec2(800.0, 800.0) * 2.0 - 1.0;

    vec2 uv = fragCoord / resolution.xy;
    // swizzling - reorder vectors in to new ones
    // iResolution.xy is the same as vec2(iResolution.x, iResolution.y)

    // for vectors of the same size
    // v1 / v2 same as vec2(v1.x / v2.x, v1.y / v2.y)

    // black to red gradient from left to right
    fragColor = vec4(uv.x, 0.0, 0.0, 1.0);

    // black to green gradient from bottom to top
    fragColor = vec4(0.0, uv.y, 0.0,1.0);

    // gradient in both directions
    fragColor = vec4(uv.x, uv.y, 0.0, 1.0);

    // short hand
    fragColor = vec4(uv, 0.0, 1.0);
}

void main() {
    mainImage(gl_FragColor, gl_FragCoord.xy);
}


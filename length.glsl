#ifdef GL_ES
precision mediump float;
#endif

// length(vec2) - calculates the magnitude of a vector (distance from origin)

// sine distance function (sdf) - distance from a point to a shape
// positive outside, negative inside, 0 on the edge

// use step(threshold, x) to create a hard edge
// 0 returned if x < threshold, 1 if x >= threshold

// use smoothstep(min, max, x) to create a smoother transition
// can interpolate between min and max values
// 0 returned if x < min, 1 if x >= max, smooth interpolation between 0 and 1

void mainImage(out vec4 fragColor, in vec2 fragCoord) {
    vec2 resolution = vec2(900.0, 900.0);
    vec2 uv = (fragCoord * 2.0 - resolution.xy) / resolution.y;
    uv.x *= resolution.x / resolution.y; // fix aspect ratio
    float len = length(uv);

    len -= 0.5; // sdf for circle radius 0.5
    len = abs(len); // validate - negative values are pos, dist increases closer to the center

    // radial gradient (black in center to red at edges)
    // center is 0,0 in the center of the canvas
    // gradient from the edge of the circle (black to white)
    // inside the circle is black (negative values)
    fragColor = vec4(len, 0.0, 0.0, 1.0);

    // gray scale gradient
    fragColor = vec4(len, len, len, 1.0);

    // ring shape with hard edge
    // closer to the edge of the circle is closer to 0
    // further away from the edge of the circle is closer to 1
    // len = step(0.1, len);
    // fragColor = vec4(len, len, len, 1.0);

    // smooth ring shape via interpolation
    len = smoothstep(0.0, 0.1, len);
    fragColor = vec4(len, len, len, 1.0);
}

void main() {
    mainImage(gl_FragColor, gl_FragCoord.xy);
}
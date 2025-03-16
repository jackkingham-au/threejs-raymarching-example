/* 
Sourced From -> https://www.shadertoy.com/view/3fSXRV
Original Credit -> https://www.shadertoy.com/view/slGfz1 
*/

uniform vec2 uResolution;
uniform vec2 uMouse;
uniform float uTime;

const float MAX_DISTANCE = 10.0;
const float MIN_DISTANCE = 0.01;
const float MAX_STEPS = 5.0;

mat2 rotate(in float a) { 
    return mat2(cos(a),-sin(a),sin(a),cos(a));
}

float sphereSDF(in vec2 p, in float radius) {
    return length(p) - radius;
}

float scene(in vec2 p) {
    return sphereSDF(p, .1);
}

void showRaymarchSteps(in vec2 p, in vec2 uv, inout vec3 col, in float distance) {
    const vec3 CIRCULAR_FIELD_COLOR = vec3(1);
    const vec3 DOT_COLOR = vec3(0, 1, 0);

    float EDGE_THICKNESS = 4.0 / uResolution.y;

    /** Add circular field representing current step in marching loop. */
    col = mix(col, CIRCULAR_FIELD_COLOR, smoothstep(EDGE_THICKNESS, 0.0, abs(length(uv - p) - abs(distance))));  

    /** Add dot (circle) representing current point in marching loop. */
    col = mix(col, DOT_COLOR, smoothstep(EDGE_THICKNESS, 0.0, length(uv - p) - 0.01));
}

void isolines(in vec2 p, inout vec3 col) {
    const vec3 SHAPE_FILL_COLOR = vec3(0, 0, 1);
    const vec3 SHAPE_BORDER_COLOR = vec3(0, 1, 1);

    /** Thickness of the lines. The `uResolution` is used to provide responsive lines. */
    float EDGE_THICKNESS = 4.0 / uResolution.y;

    /** Color the shape. */
    col = mix(col, SHAPE_FILL_COLOR, smoothstep(EDGE_THICKNESS, 0.0, scene(p)));

    /** Add lines around the shape. */
    col += sin(200.0 * scene(p)) * 0.2;

    /** Add a border around shapes. */
    col = mix(col, SHAPE_BORDER_COLOR, smoothstep(EDGE_THICKNESS * 1.5, 0.0, abs(scene(p))));
}

void raymarch(in vec2 rayOrigin, in vec2 rayDirection, in vec2 uv, inout vec3 col) {
    float distanceFromOrigin = 0.0;

    for(float i = 0.0; i < MAX_STEPS; i++) {
        vec2 p = rayOrigin + rayDirection * distanceFromOrigin;
        float distance = scene(p);

        if(distance < MIN_DISTANCE || distanceFromOrigin > MAX_DISTANCE) {
            break;
        }

        distanceFromOrigin += distance;

        showRaymarchSteps(p, uv, col, distance);
    }
}

void main() {
    vec2 uv = (gl_FragCoord.xy - .5 * uResolution.xy) / uResolution.y;
    vec2 mouse = (uMouse.xy - .5 * uResolution.xy) / uResolution.y;
    vec3 col = vec3(0);

    vec2 rayOrigin = vec2(mouse.x, -mouse.y);
    vec2 rayDirection = normalize(vec2(1.0) * rotate(uTime * 0.2));

    raymarch(rayOrigin, rayDirection, uv, col);
    isolines(uv, col);

    gl_FragColor = vec4(col, 1.);
}
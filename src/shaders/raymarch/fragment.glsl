uniform vec2 uResolution;
uniform vec2 uMouse;
uniform float uTime;

uniform vec3 uCameraPosition;
uniform vec3 uCameraDirection;

uniform vec3 uSunPosition;
uniform vec3 uSunDirection;

#include "./utils/raymarch.glsl"
#include "./utils/lighting.glsl"

void main() {
    vec2 uv = (gl_FragCoord.xy - .5 * uResolution.xy) / uResolution.y;
    vec2 mouse = uMouse.xy / uResolution;
    vec3 col = vec3(0);

    const vec3 RAY_ORIGIN = vec3(0, 1, 6);
    vec3 RAY_DIRECTION = normalize(vec3(uv, -1.));

    float distance = raymarch(RAY_ORIGIN, RAY_DIRECTION);
    vec3 currentPos = getCurrentPos(RAY_ORIGIN, RAY_DIRECTION, distance);

    float lighting = getLighting(currentPos);
    col += lighting;

    gl_FragColor = vec4(col, 1.);
}
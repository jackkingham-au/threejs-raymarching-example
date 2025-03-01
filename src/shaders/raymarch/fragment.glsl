uniform vec2 uResolution;
uniform vec2 uMouse;
uniform float uTime;

#include "./utils/raymarch.glsl"
#include "./utils/lighting.glsl"

#include "./utils/camera.glsl"

void main() {
    vec2 uv = (gl_FragCoord.xy - .5 * uResolution.xy) / uResolution.y;
    vec2 mouse = uMouse.xy / uResolution;
    vec3 col = vec3(0);

    Camera ray = createCamera(uv);
    Material material = material();
    raymarch(ray.origin, ray.direction, material);

    col = material.color;

    float lighting = getLighting(material);
    col *= lighting;

    col = linear2gamma(col);

    gl_FragColor = vec4(col, 1.);
}
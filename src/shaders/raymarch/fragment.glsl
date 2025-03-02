uniform vec2 uResolution;
uniform vec2 uMouse;
uniform float uTime;

const vec3 SKY_COLOR = vec3(0.0, 0.65, 1.0);
const vec3 SUN_COLOR = vec3(1, 1, 0);
const float SUN_BRIGHTNESS = .002;

#define uTime uTime * .8
#define CAMERA_ROTATE 0
#define LIGHT_POSITION vec3(-5, 5, -5)

const float PI = 3.14159;

#include "./utils/camera.glsl"

#include "./utils/raymarch.glsl"
#include "./utils/lighting.glsl"
#include "./utils/render.glsl"

#include "../sun/sun.glsl"

void main() {
    vec2 uv = (gl_FragCoord.xy - .5 * uResolution.xy) / uResolution.y;
    vec2 mouse = uMouse.xy / uResolution;

    Camera camera = createCamera(uv);
    Material material = material();
    vec3 col = render(uv, camera, material);

    if(!material.intersected) {
        col += sun((uv * 6.0) - vec2(0, 2.));
    }

    col = linear2gamma(col);

    gl_FragColor = vec4(col, 1.);
}
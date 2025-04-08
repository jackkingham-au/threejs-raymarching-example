uniform vec2 uResolution;
uniform vec2 uMouse;
uniform float uMouseDown;
uniform float uTime;

uniform vec3 uCameraOrigin;
uniform vec3 uCameraDirection;

uniform sampler2D uBrickAlbedo;
uniform sampler2D uBrickDisplacement;
uniform sampler2D uGrassAlbedo;
uniform sampler2D uGrassDisplacement;
uniform sampler2D uFoliageAlpha; 

const vec3 SKY_COLOR = vec3(0.0, 0.65, 1.0);
const vec3 SUN_COLOR = vec3(1, 1, 0);
const float SUN_BRIGHTNESS = .002;

#define LIGHT_POSITION vec3(-5, 5, -5)

const float PI = 3.14159;

#include "./utils/view.glsl"
#include "./utils/color.glsl"

#include "./utils/material.glsl"
#include "./utils/transform.glsl"
#include "./utils/noise/perlin.glsl"
#include "./utils/textures.glsl"

#include "./utils/raymarch.glsl"
#include "./utils/lighting.glsl"
#include "./utils/render.glsl"

#include "../sun/sun.glsl"

void main() {
    vec2 uv = (gl_FragCoord.xy - .5 * uResolution.xy) / uResolution.y;

    Camera camera = createCamera(uv, CAMERA_LOOKAT, uCameraOrigin);
    Material material = material();
    vec3 col = render(uv, camera, material);

    if(!material.intersected) {
        col += sun((uv * 6.0) - vec2(0, 2.15));
    }

    col = linear2gamma(col);

    gl_FragColor = vec4(col, 1.0);
}
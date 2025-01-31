uniform vec2 uResolution;
uniform vec2 uMouse;
uniform float uTime;

uniform vec3 uCameraPosition;
uniform vec3 uCameraDirection;

uniform vec3 uSunPosition;
uniform vec3 uSunDirection;

uniform sampler2D uBrickTexture;

#define LIGHT_POSITION uSunPosition

#define RESOLUTION uResolution
#define RAYMARCH_MULTISAMPLE 1
#define RAYMARCH_BACKGROUND (RAYMARCH_AMBIENT + rayDirection.y * 0.8)
#define RAYMARCH_AMBIENT    vec3(0.7, 0.9, 1.0)

#define MATERIAL_IDS

#include "../lygia/lighting/raymarch.glsl"
#include "../lygia/lighting/ray.glsl"
#include "../lygia/sdf.glsl"

#include "../lygia/space/ratio.glsl"
#include "../lygia/space/rotate.glsl"
#include "../lygia/color/space/linear2gamma.glsl"


#include "./textures/triplanarMapping.glsl"
#include "./textures/displacement.glsl"

#include "./sdf/map.sdf.glsl"

#include "./sprites/loader.sprite.glsl"
#include "./textures/loader.textures.glsl"

void main() {
    // vec2 st = (2. * uv - 1.) * vec2(uResolution.x / uResolution.y, 1.);
    vec2 st = gl_FragCoord.xy / uResolution;
    vec2 mouse = uMouse.xy / uResolution;
    vec3 col = vec3(0);

    vec2 uv = ratio(st, uResolution);

    Ray camera = Ray(uCameraPosition, uCameraDirection);

    float eyeDepth = .0;
    Material outMaterial = materialZero();

    col = raymarch(camera.origin, camera.direction, uv, eyeDepth, outMaterial).rgb;
    col = linear2gamma(col);

    col = loadTextures(outMaterial, col);
    col = loadSprites(outMaterial, col);

    gl_FragColor = vec4(col, 1.);
}
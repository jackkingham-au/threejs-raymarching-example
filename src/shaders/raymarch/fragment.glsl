uniform vec2 uResolution;
uniform vec2 uMouse;
uniform float uTime;

uniform vec3 uCameraPosition;
uniform vec3 uCameraDirection;

uniform vec3 uSunPosition;
uniform vec3 uSunDirection;

uniform sampler2D uBrickTexture;

void main() {
    vec2 st = gl_FragCoord.xy / uResolution.xy;
    vec2 mouse = uMouse.xy / uResolution;
    vec3 col = vec3(0);

    col.rg = st;

    gl_FragColor = vec4(col, 1.);
}
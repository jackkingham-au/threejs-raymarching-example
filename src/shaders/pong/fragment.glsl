uniform vec2 uResolution;
uniform float uTime;
uniform sampler2D uGameState;

#include "logic.glsl";
#include "visual.glsl";    

vec2 aspect(vec2 st, vec2 s) {
    st.x = st.x * (s.x / s.y);
    return st;
}

void main() {
    vec2 uv = (gl_FragCoord.xy / uResolution.xy) * 2.0 - 1.0;
    vec3 col = vec3(0);

    uv = aspect(uv, uResolution.xy);

    float distance = scene(uv);
    distance = smoothstep(0.01, 0.0, distance);

    col = vec3(distance);

    if (abs(uv.y) > .98) {
        col.g = 1.;
    }

    vec4 state = texture2D(uGameState, vec2(.5));

    gl_FragColor = vec4(col, 1.0);
}
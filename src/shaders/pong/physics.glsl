uniform float uDeltaTime;
uniform vec2 uRenderTargetResolution;
uniform sampler2D uCurrentState;

const vec2 RESOLUTION = vec2(1.0);

void main() {
    vec2 uv = gl_FragCoord.xy / uRenderTargetResolution;

    vec4 state = texture2D(uCurrentState, uv);

    vec2 position = state.xy;
    vec2 velocity = state.zw;

    position += velocity * uDeltaTime;

    gl_FragColor = vec4(position, velocity);
}
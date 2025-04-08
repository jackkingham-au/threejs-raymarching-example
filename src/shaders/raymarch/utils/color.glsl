float saturate(float value) {
    return clamp(value, 0.0, 1.0);
}

// Original Source - https://www.shadertoy.com/view/MtXSzS
vec4 palette(float distance) {
    const vec4 COLOR_ONE = vec4(1.0, 1.0, 1.0, 1.0);
    const vec4 COLOR_TWO = vec4(1.0, 0.8, 0.2, 1.0);
    const vec4 COLOR_THREE = vec4(1.0, 0.03, 0.0, 1.0);
    const vec4 COLOR_FOUR = vec4(0.05, 0.02, 0.02, 1.0);

    float c1 = saturate(distance * 5.0 + 0.5);
    float c2 = saturate(distance * 5.0);
    float c3 = saturate(distance * 3.4 - 0.5);
    vec4 a = mix(COLOR_ONE, COLOR_TWO, c1);
    vec4 b = mix(a, COLOR_THREE, c2);
    return mix(b, COLOR_FOUR, c3);
}

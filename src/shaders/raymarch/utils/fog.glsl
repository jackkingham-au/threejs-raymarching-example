#ifndef FOG_FAR
    #define FOG_FAR MAX_DISTANCE * .8
#endif

#ifndef FOG_COLOR
    #define FOG_COLOR vec3(0.922,0.929,0.953)
#endif

#ifndef FOG_NEAR
    #define FOG_NEAR 30.0
#endif

vec3 linearFog(in vec3 col, in float distanceFromOrigin) {
    float factor = clamp((FOG_FAR - distanceFromOrigin) / (FOG_FAR - FOG_NEAR), 0., 1.);
    return mix(FOG_COLOR, col, factor);
}

vec3 linearFog(in vec3 col, in float distanceFromOrigin, in vec3 worldPos) {
    float height = smoothstep(.2, .9, worldPos.y) + smoothstep(.9, .2, worldPos.y);
    float factor = clamp((FOG_FAR - distanceFromOrigin) / (FOG_FAR - FOG_NEAR), 0., 1.);

    vec3 skyFog = mix(FOG_COLOR, SKY_COLOR * 5.0, height);

    return mix(skyFog, col, factor);
}

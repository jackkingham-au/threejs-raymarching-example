#include "./sdf.glsl"

float scene( in vec3 pos ) {
    float plane = planeSDF(pos);
    float sphere = sphereSDF(pos - vec3(0,1, 0), 1.0);

    return min(plane, sphere);
}
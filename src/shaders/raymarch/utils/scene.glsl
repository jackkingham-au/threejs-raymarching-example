#include "./material.glsl"

#include "./operations.glsl"
#include "./sdf.glsl"

Material scene( in vec3 pos ) {
    Material plane = material();
    plane.sdf = planeSDF(pos);
    plane.color = vec3(0, 1, 0);

    Material box = material();
    box.sdf = boxSDF(pos - vec3(0,1, 0), vec3(.5));
    box.color = vec3(1, 0, 0);

    return opUnion(plane, box);
}
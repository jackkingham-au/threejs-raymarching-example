#include "./material.glsl"

#include "./operations.glsl"
#include "./sdf.glsl"

Material scene( in vec3 pos ) {
    Material plane = material();
    plane.sdf = planeSDF(pos);
    plane.color = vec3(0, 1, 0);

    Material result = plane;

    // Grid grid = opRepeat(pos, vec3(4,0,4));
    // pos = grid.localUv;

    Material box = material();
    box.sdf = boxSDF(pos - vec3(0,1, 0), vec3(1));
    box.color = vec3(1,0,0);
    // box.color.rg = abs(grid.cellId.rb) * .5;

    result = opUnion(result, box);

    return result;
}
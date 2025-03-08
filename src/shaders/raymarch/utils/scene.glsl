#include "./operations.glsl"
#include "./sdf.glsl"

Material tree(in vec3 pos) {
    Grid grid = opRepeat(pos, vec3(1.75,0,2));
    pos = grid.localUv;

    Material trunk = material();
    trunk.sdf = capsuleVerticalSDF(pos, .5, 0.05);
    trunk.color = vec3(0.757,0.071,0.122);

    Material leaves = material();
    leaves.sdf = sphereSDF(pos - vec3(0, .5, 0), 0.35);
    leaves.color = vec3(1, 0.0, 0.0);

    return opUnion(trunk, leaves);
} 

Material ground(in vec3 pos) {
    Material plane = material();
    plane.sdf = planeSDF(pos);
    plane.color = vec3(0,1,0);
    plane.sdf -= displacementMap(uGrassDisplacement, pos, vec3(0, 1, 0), plane.sdf, 0.1);

    plane.id = GRASS_MATERIAL_ID;

    return plane;
}

Material scene( in vec3 pos ) {
    Material ground = ground(pos);

    Material tree = tree(pos);

    Material result = ground;

    return opUnion(result, tree);
}
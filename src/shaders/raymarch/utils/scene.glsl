#include "./operations.glsl"
#include "./sdf.glsl"
#include "./helpers.glsl"

Material ground(in vec3 pos) {
    Material plane = material();
    plane.sdf = planeSDF(pos);
    plane.color = vec3(0, 1, 0);

    plane.id = GRASS_MATERIAL_ID;

    return plane;
}

Material foliage(in vec3 pos) {
    Material foliage = billboard(pos, vec3(0, 1.5, 0));
    foliage.color = palette(perlin(pos)).rgb;

    return foliage;
}

Material scene(in vec3 pos) {
    Material ground = ground(pos);
    Material foliage = foliage(pos);
    
    return opUnion(ground, foliage);
}
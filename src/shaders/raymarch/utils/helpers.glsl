Material billboard(in vec3 pos, in vec3 worldOrigin) {
    Material quad = material();
    quad.id = FOLIAGE_MATERIAL_ID;
    quad.worldOrigin = worldOrigin;
    quad.sdf = quadSDF(transformedPos(pos, quad), 1.);

    return quad;
}
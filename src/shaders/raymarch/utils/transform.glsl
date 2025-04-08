#define BILLBOARD_TARGET uCameraOrigin

/** Position transformations.

    - Need to be applied in textures.
    - Need to be applied in SDF calculations.
*/
vec3 transformedPos(in vec3 originalPos, in Material material) {

    if(material.id == FOLIAGE_MATERIAL_ID) {
        vec3 worldOrigin = material.worldOrigin;
        mat3 rotationMatrix = lookAt(worldOrigin, BILLBOARD_TARGET);
        vec3 localPos = originalPos - worldOrigin;

        return localPos * rotationMatrix;
    }

    return originalPos;
}

/** Account for position transformations in normal calculations.

    - Need to be applied in normal calculations.
*/
vec3 transformedNormal(in vec3 normal, in Material material) {

    if(material.id == FOLIAGE_MATERIAL_ID) {
        mat3 rotationMatrix = lookAt(material.worldOrigin, BILLBOARD_TARGET);
        return normalize(normal * rotationMatrix);
    }

    return normalize(normal);
}

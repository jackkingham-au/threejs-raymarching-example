/** Apply a texture to an object using triplanar mapping. */
vec3 triplanarMapping(sampler2D tex, vec3 p, vec3 normal) {
    normal = abs(normal);
    normal = pow(normal, vec3(5.0));
    normal /= normal.x + normal.y + normal.z;

    return (texture(tex, p.xy * 0.5 + 0.5) * normal.z +
        texture(tex, p.xz * 0.5 + 0.5) * normal.y +
        texture(tex, p.yz * 0.5 + 0.5) * normal.x).rgb;
}

/** Apply a texture to an object using single planar mapping. 

    Applicable for billboard textures in this algorithm.
 */
vec3 singleplanarMapping(sampler2D tex, vec3 p, vec3 normal) {
    normal = abs(normal);
    normal = pow(normal, vec3(5.0));
    normal /= normal.x;

    return (texture(tex, p.yz * 0.5 + 0.5) * normal.x).rgb;
}

float alphaMap(sampler2D tex, in vec3 pos, in vec3 normal) {
    return singleplanarMapping(tex, pos, normal).r;
}

/** Displace a point based on a texture. */
float displacementMap(sampler2D tex, vec3 pos, vec3 normal, float distance, float displacementFactor) {
    float bump = 0.0;

    if(distance < 0.1) {
        normal = normalize(normal);
        bump += displacementFactor * triplanarMapping(tex, pos, normal).r;
    }

    return smoothstep(0.0, 1.0, bump);
}

/** Set material color to match texture, if `material.id` is applicable. */
void addMaterialTexture(inout Material material) {  
    if (material.id == GRASS_MATERIAL_ID) {
        material.color = triplanarMapping(uGrassAlbedo, transformedPos(material.worldPos, material), material.normal);
    }
}

/** Return the opacity value of a material (where alpha maps can be applied). */
float getOpacityValue(in Material material) {
    if (material.id == FOLIAGE_MATERIAL_ID) {
        return alphaMap(uFoliageAlpha, transformedPos(material.worldPos, material), material.normal);
    }

    return 1.0;
}

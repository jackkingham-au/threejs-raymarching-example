struct Material {
    vec3 color;
    float opacity;
    vec3 normal;
    /** Absolute world position relative to the current ray position.

        This will change as the ray marches.
    */
    vec3 worldPos;

    /** Absolute world position. 
    
    The origin/center point of the object in world space. This doesn't change.
    */
    vec3 worldOrigin;

    float sdf;
    bool intersected;
    int id;
};

Material material() {
    return Material(
        vec3(0), 
        1.0,
        vec3(0), 
        vec3(0), 
        vec3(0), 
        0.0, 
        false, 
        -1
    );
}

const int GRASS_MATERIAL_ID = 1;
const int FOLIAGE_MATERIAL_ID = 2;

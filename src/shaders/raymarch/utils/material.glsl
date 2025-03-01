struct Material {
    vec3 color;
    vec3 normal;
    vec3 worldPosition;
    float sdf;
    bool intersected;
};

Material material() {
    return Material(
        vec3(0),
        vec3(0),
        vec3(0),
        0.0,
        false
    );
}


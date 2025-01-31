vec3 loadTextures(in Material material, inout vec3 col) {
    vec3 pos = material.position;
    vec3 normal = material.normal;

    vec3 triplanarColor = triplanarMapping(uBrickTexture, pos * 4., normal);  

    if(material.id == CASTLE_ID) {
        col *= triplanarColor.rgb;
    }

    return col;
}
float diffuseLighting(in vec3 normal, in vec3 lightVector) {
    return clamp(dot(normal, lightVector), 0., 1.);
}

float getShadows(
    in vec3 pos, 
    in vec3 normal, 
    in vec3 lightVector,
    in vec3 lightPosition
) {
    float distanceToLight = raymarch(pos + normal * MIN_DISTANCE * 2., lightVector);
    return distanceToLight < length(lightPosition - pos) ? .1 : 1.;
}

float getLighting(in Material material) {
    vec3 LIGHT_POSITION = vec3(0, 5, 6);
    vec3 lightVector = normalize(LIGHT_POSITION - material.worldPosition);

    float diffuse = diffuseLighting(material.normal, lightVector);
    diffuse *= getShadows(material.worldPosition, material.normal, lightVector, LIGHT_POSITION);

    return diffuse;
}

vec3 linear2gamma( in vec3 color ) {
    return pow(color, vec3(2.2));
}
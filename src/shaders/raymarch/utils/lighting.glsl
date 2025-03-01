const float EPSILON = 0.01;

vec3 getNormal(in vec3 pos) {
    float distanceToScene = scene(pos);
    vec2 epsilon = vec2(EPSILON, 0.);

    vec3 normal = distanceToScene - vec3(scene(pos - epsilon.xyy), scene(pos - epsilon.yxy), scene(pos - epsilon.yyx));

    return normalize(normal);
}

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

float getLighting(in vec3 pos) {
    vec3 LIGHT_POSITION = vec3(0, 5, 6);
    vec3 normal = getNormal(pos);
    vec3 lightVector = normalize(LIGHT_POSITION - pos);

    float diffuse = diffuseLighting(normal, lightVector);
    diffuse *= getShadows(pos, normal, lightVector, LIGHT_POSITION);

    return diffuse;
}
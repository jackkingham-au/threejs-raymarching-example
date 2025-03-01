const float MAX_DISTANCE = 100.0;
const float MAX_STEPS = 100.0;
const float MIN_DISTANCE = 0.001;

#include "./scene.glsl"

vec3 getCurrentPos(in vec3 rayOrigin, in vec3 rayDirection, float distanceFromOrigin) {
    return rayOrigin + rayDirection * distanceFromOrigin;
}

float raymarch(in vec3 rayOrigin, in vec3 rayDirection) {
    float distanceFromOrigin = 0.;

    for(float i = 0.; i < MAX_STEPS; i++) {
        vec3 currentPos = getCurrentPos(rayOrigin, rayDirection, distanceFromOrigin);

        float distanceToScene = scene(currentPos);
        distanceFromOrigin += distanceToScene;

        if (distanceFromOrigin > MAX_DISTANCE || distanceToScene < MIN_DISTANCE) {
            break;
        }
    }

    return distanceFromOrigin;
}
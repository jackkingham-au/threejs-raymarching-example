const float MAX_DISTANCE = 100.0;
const float MAX_STEPS = 100.0;
const float MIN_DISTANCE = 0.001;

#include "./scene.glsl"
#include "./normal.glsl"
#include "./fog.glsl"

vec3 getWorldPos(in vec3 rayOrigin, in vec3 rayDirection, float distanceFromOrigin) {
    return rayOrigin + rayDirection * distanceFromOrigin;
}

float raymarch(in vec3 rayOrigin, in vec3 rayDirection, out Material material) {
    float distanceFromOrigin = 0.;

    for(float i = 0.; i < MAX_STEPS; i++) {
        vec3 worldPos = getWorldPos(rayOrigin, rayDirection, distanceFromOrigin);

        material = scene(worldPos);
        float distanceToScene = material.sdf;
        distanceFromOrigin += distanceToScene;

        material.worldPos = worldPos;
        getNormal(material);

        /** Apply any alpha maps to the material. */
        material.opacity = getOpacityValue(material);

        if (distanceToScene < MIN_DISTANCE) {
            
            /** If the point is transparent, continue marching, so we can capture what is behind it. */
            if (material.opacity < .01) {
                /** If the material is transparent, we need to step forward a bit more to avoid z-fighting. */
                distanceFromOrigin += MIN_DISTANCE * 20.0;
                continue;
            }

            material.intersected = true;
            break;
        }

        if(distanceFromOrigin > MAX_DISTANCE) {
            break;
        }
    }

    return distanceFromOrigin;
}

float raymarch(in vec3 rayOrigin, in vec3 rayDirection) {
    Material material = material();
    return raymarch(rayOrigin, rayDirection, material);
}

#ifndef WORLD_UP
    #define WORLD_UP vec3(0, 1, 0)
#endif

#ifndef CAMERA_ROTATE 
    #define CAMERA_ROTATE 0
#endif

#ifndef CAMERA_ORIGIN
    #if CAMERA_ROTATE == 1
        #define CAMERA_ORIGIN vec3(7.0 * cos(uTime), 4.0, 7.0 * sin(uTime))
    #else
        #define CAMERA_ORIGIN vec3(7.0, 4.0, 7.0)
    #endif
#endif

#ifndef CAMERA_LOOKAT
    #define CAMERA_LOOKAT vec3(0, 2, 0)
#endif

struct Camera {
    vec3 lookAt;
    vec3 origin;
    vec3 direction;
};

mat3 lookAt(in vec3 origin, in vec3 target) {
    vec3 forward = normalize(target - origin);
    vec3 right = cross(forward, WORLD_UP);
    vec3 up = cross(right, forward);

    return mat3(forward, right, up);
}

Camera createCamera(in vec2 uv, in vec3 target, in vec3 origin) {
    mat3 viewMatrix = lookAt(origin, target);

    vec3 forward = viewMatrix[0];
    vec3 right = viewMatrix[1];
    vec3 up = viewMatrix[2];

    vec3 screenCenter = origin + forward;

    /** Where a "ray" will intersect with the screen. */
    vec3 intersectionPoint = screenCenter + uv.x * right + uv.y * up;

    vec3 direction = normalize(intersectionPoint - origin);

    return Camera(target, origin, direction);
}

Camera createCamera(in vec2 uv) {
    return createCamera(uv, CAMERA_LOOKAT, CAMERA_ORIGIN);
}

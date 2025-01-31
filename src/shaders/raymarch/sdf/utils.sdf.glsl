float roundBoxSDF(vec3 p, vec3 b, float r) {
    vec3 q = abs(p) - b + r;
    return length(max(q, 0.0)) + min(max(q.x, max(q.y, q.z)), 0.0) - r;
}

vec3 opSymmetricZ(in vec3 pos, in float space) {
    pos.z = abs(pos.z);
    pos.z -= space;

    return pos;
}

vec3 opSymmetricX(in vec3 pos, in float space) {
    pos.x = abs(pos.x);
    pos.x -= space;

    return pos;
}

vec3 opSymmetricXZ(in vec3 pos, in float space) {
    pos.xz = abs(pos.xz);
    pos.xz -= space;

    return pos;
}

vec3 lookAtCamera(in vec3 pos) {
    mat3 rotationMatrix = lookAt(pos, uCameraPosition, 0.);
    vec3 localPos = inverse(rotationMatrix) * (pos - vec3(0, 1, 0));

    return localPos;
}

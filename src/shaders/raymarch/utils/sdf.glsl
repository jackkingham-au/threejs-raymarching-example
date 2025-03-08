/** Assumes a plane at `y = 0 */
float planeSDF(in vec3 pos) {
    return pos.y;
}

float sphereSDF(in vec3 pos, in float radius) {
    return length(pos) - radius;
}

float boxSDF(vec3 pos, vec3 size) {
    vec3 q = abs(pos) - size;
    return length(max(q, 0.0)) + min(max(q.x, max(q.y, q.z)), 0.0);
}

float capsuleVerticalSDF(vec3 pos, float height, float radius) {
    pos.y -= clamp(pos.y, 0.0, height);
    return length(pos) - radius;
}

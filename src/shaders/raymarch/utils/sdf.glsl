/** Assumes a plane at `y = 0 */
float planeSDF( in vec3 pos ) {
    return pos.y;
}

float sphereSDF( in vec3 pos, in float radius ) {
    return length(pos) - radius;
}
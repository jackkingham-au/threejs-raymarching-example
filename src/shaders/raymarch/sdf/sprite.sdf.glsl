float billboardSDF(in vec3 pos) {
    vec3 localPos = lookAtCamera(pos);
    float billboard = sphereSDF(localPos, 1.);

    return billboard;
}

Material spriteSDF(in vec3 pos) {
    Material billboard = materialZero();
    billboard.sdf = billboardSDF(pos);

    return billboard;
}
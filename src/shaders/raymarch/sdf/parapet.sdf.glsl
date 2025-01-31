float parapetBaseSDF(in vec3 pos, in vec3 size) {
    vec3 baseSize = vec3(size.x + .1, .35, size.z + .1);
    float base = boxSDF(pos, baseSize);
    float roof = boxSDF(pos, baseSize - vec3(.25, -.25, .25));

    return opSubtraction(roof, base);
}

float parapetHolesSDF(in vec3 pos, in vec3 size) {
    pos = pos - vec3(0, .35, 0);
    vec3 holeSize = vec3(.3, .15, .15);

    vec3 posZ = opSymmetricZ(pos, size.x);
    vec3 posX = opSymmetricX(pos, size.x);

    float holesX = boxSDF(posX, holeSize.xyz);
    float holesZ = boxSDF(posZ, holeSize.zyx);

    return opUnion(holesX, holesZ);
}

float parapetSDF(in vec3 pos, in vec3 size) {
    pos = pos + -vec3(0, size.y, 0);

    float base = parapetBaseSDF(pos, size);
    float holes = parapetHolesSDF(pos, size);

    return opSubtraction(holes, base);
}
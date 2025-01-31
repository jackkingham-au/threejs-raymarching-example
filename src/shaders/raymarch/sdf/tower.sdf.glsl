#include "./parapet.sdf.glsl"

Material towerSDF(in vec3 pos) {
    pos = opSymmetricXZ(pos, 3.);
    vec3 baseSize = vec3(.75, 2, .75);

    Material tower = materialZero();

    float parapet = parapetSDF(pos, baseSize);

    float skirt = roundBoxSDF(pos, vec3(1, .2, 1), 0.1);
    float base = roundBoxSDF(pos, baseSize, 0.1);

    float result = opUnion(skirt, base, .35);
    result = opUnion(result, parapet, .001);

    tower.sdf = result;

    return tower;
}
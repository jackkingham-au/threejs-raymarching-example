#define GROUND_COLOR vec3(0,1,0)

Material groundSDF(in vec3 pos) {
    return materialNew(GROUND_COLOR, planeSDF(pos));
}
#include "./tower.sdf.glsl"
#include "./walls.sdf.glsl"

#define CASTLE_COLOR vec3(0.788,0.682,0.455)

Material castleSDF(in vec3 pos) {
    Material castle = materialZero();
    pos -= vec3(4, 0, 4);
    vec3 castlePos = opSymmetricXZ(pos, 3.);


    Material tower = towerSDF(castlePos);
    Material walls = wallsSDF(castlePos);

    castle.albedo = pow(vec4(CASTLE_COLOR, 1.0), vec4(4.));
    castle.sdf = opUnion(walls.sdf, tower.sdf);

    return castle;
}
#include "./utils.sdf.glsl"

#include "./ground.sdf.glsl"
#include "./castle.sdf.glsl"
#include "./sprite.sdf.glsl"

#define GROUND_ID 0.
#define CASTLE_ID 1.

// SPRITES
#define KNIGHT_ID 2.

Material raymarchMap(in vec3 pos) {
    Material plane = groundSDF(pos);
    plane.id = GROUND_ID;

    Material outMaterial = plane;

    Material castle = castleSDF(pos);
    castle.id = CASTLE_ID;
    outMaterial = opUnion(outMaterial, castle);

    Material knight = spriteSDF(pos);
    knight.id = KNIGHT_ID;
    outMaterial = opUnion(outMaterial, knight);

    return outMaterial;
}

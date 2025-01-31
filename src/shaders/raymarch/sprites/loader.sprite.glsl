uniform sampler2D uSpriteKnight;

#include "../../lygia/sample/nearest.glsl"
#include "../../lygia/animation/spriteLoop.glsl"

struct SpriteAction {
    float start;
    float end;
};

struct CharacterSprite {
    SpriteAction attack;
    SpriteAction walk;

    vec2 _grid;
};

vec4 spriteAnimation(in sampler2D tex, in vec2 grid, in vec2 uv, in SpriteAction action) {
    float spriteLoopTime = uTime * 7.0;
    
    return spriteLoop(tex, uv, grid, action.start, action.end, spriteLoopTime);
}

CharacterSprite knight = CharacterSprite(
    SpriteAction(12., 17.),
    SpriteAction(6., 11.),
    vec2(6,8)
);

vec3 loadSprites(Material material, in vec3 col) {
    vec3 pos = lookAtCamera(material.position);

    if (material.id == KNIGHT_ID) {
        return spriteAnimation(uSpriteKnight, knight._grid, (pos.xy * .5 + .5), knight.attack).rgb;
    }

    return col;
}
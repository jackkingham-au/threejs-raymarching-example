/** Logic for keeping scores and physics. */

const vec2 INITIAL_BALL_POSITION = vec2(0.0, 0.0);
const vec2 INITIAL_BALL_VELOCITY = vec2(.1, .3);

const float WORLD_BOUNDS = .98;

bool hasBallCollidedWithBounds(in vec2 p) {
    return (abs(p.y) > WORLD_BOUNDS);
}

// vec2 getBallPosition() {
//     float time = uTime * 0.4;
//     vec2 velocity = INITIAL_BALL_VELOCITY;
//     vec2 p = INITIAL_BALL_POSITION + velocity * time;

//     if (hasBallCollidedWithBounds(p)) {
//         p.y = sign(p.y) * WORLD_BOUNDS;
//     }

//     return p;
// }

vec2 getBallPosition() {
    return texture2D(uGameState, vec2(.25, .25)).xy;
}
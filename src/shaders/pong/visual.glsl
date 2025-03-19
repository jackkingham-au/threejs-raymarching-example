/** Visual Elements of the game. */

float boxSDF(in vec2 p, in vec2 b) {
    vec2 d = abs(p) - b;
    return length(max(d, 0.0)) + min(max(d.x, d.y), 0.0);
}

float sphereSDF(in vec2 p, in float r) {
    return length(p) - r;
}

float dividerSDF(in vec2 p) {
    float spacing = 8.0;
    p.y = (fract(p.y * spacing + .5) - .5) / spacing;
    return boxSDF(p, vec2(0.001, 0.02));
}

float scene(in vec2 p) {
    float ball = sphereSDF(p - getBallPosition(), 0.01);

    float leftPaddle = boxSDF(p + vec2(1.5, 0), vec2(0.01, 0.2));
    float rightPaddle = boxSDF(p - vec2(1.5, 0), vec2(0.01, 0.2));

    float game = min(ball, min(leftPaddle, rightPaddle)); 
    float divider = dividerSDF(p);

    return min(game, divider);
}
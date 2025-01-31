Material wallsSDF(in vec3 pos) {
    Material wall = materialZero();

    vec3 size = vec3(3, 1.25, .25);

    vec3 posX = opSymmetricX(pos, 3.);
    vec3 posZ = opSymmetricZ(pos, 3.);

    float wallX = boxSDF(posX, size.zyx);
    float wallZ = boxSDF(posZ, size.xyz);

    wall.sdf = opUnion(wallX, wallZ, .1);

    return wall;
}
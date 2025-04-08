float alphaMap(in vec3 pos, in vec3 normal) {
    texture(tex, p.yz * 0.5 + 0.5) * normal.x   
}
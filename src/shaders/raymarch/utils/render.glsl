vec3 render(in vec2 uv, in Camera ray, out Material material) {
    vec3 col = vec3(0);
    float distanceFromOrigin = raymarch(ray.origin, ray.direction, material);

    if(material.intersected) {
        col = getLighting(material);
    } else {
        col = SKY_COLOR;
    }

    col = linearFog(col, distanceFromOrigin, material.worldPos);

    return col;
}

vec3 render(in vec2 uv, in Camera camera) {
    Material material = material();
    return render(uv, camera, material);
}

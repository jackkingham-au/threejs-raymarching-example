import * as THREE from "three";

import fragmentShader from "../shaders/raymarch/fragment.glsl";

export default class RaymarchMaterial {
    uniforms: Record<string, THREE.IUniform>;
    _material: THREE.ShaderMaterial;

    constructor() {
        this.uniforms = {
            uResolution: {
                value: new THREE.Vector2(window.innerWidth, window.innerHeight)
            },
            uMouse: {
                value: new THREE.Vector2()
            },
            uTime: {
                value: 0
            },
            uCameraPosition: {
                value: new THREE.Vector3()
            },
            uCameraDirection: {
                value: new THREE.Vector3()
            },
            uSunPosition: {
                value: new THREE.Vector3()
            },
            uSunDirection: {
                value: new THREE.Vector3()
            },
        }

        this._material = new THREE.ShaderMaterial({
            fragmentShader,
            uniforms: this.uniforms,
        });
    }
}
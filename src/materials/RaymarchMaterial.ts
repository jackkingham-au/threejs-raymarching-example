import * as THREE from "three";

import fragmentShader from "../shaders/raymarch/fragment.glsl";


const SPRITE_PATHS = [
    "/knight/knight-blue.png",
]

const TEXTURE_PATHS = [
    "/bricks/bricks-color.jpg",
    "/bricks/bricks-normal.png",
    "/bricks/bricks-roughness.jpg",
    "/bricks/bricks-ao.jpg",
    "/bricks/bricks-height.png",

    "/test.png"
]

const MATERIAL_TEXTURES = TEXTURE_PATHS.map((path) => `/assets/textures${path}`);
const MATERIAL_SPRITES = SPRITE_PATHS.map((path) => `/assets/sprites${path}`);

export default class RaymarchMaterial {
    uniforms: Record<string, THREE.IUniform>;
    _material: THREE.ShaderMaterial;
    _textures: Record<string, THREE.Texture> = {};
    _sprites: Record<string, THREE.Texture> = {};

    constructor() {
        this._loadTextures();

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
            uBrickTexture: {
                value: this._textures[MATERIAL_TEXTURES[5]]
            },
            uSpriteKnight: {
                value: this._sprites[MATERIAL_SPRITES[0]]
            }
        }

        this._material = new THREE.ShaderMaterial({
            fragmentShader,
            uniforms: this.uniforms,
        });
    }

    _loadTextures = () => {
        const loader = new THREE.TextureLoader();

        MATERIAL_TEXTURES.forEach((path) => {
            const texture = loader.load(path);

            texture.wrapS = THREE.RepeatWrapping
            texture.wrapT = THREE.RepeatWrapping

            this._textures[path] = texture;
        });
        
        MATERIAL_SPRITES.forEach((path) => {
            const texture = loader.load(path);

            this._sprites[path] = texture;
        });
    }
}
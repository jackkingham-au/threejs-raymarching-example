import fragmentShader from './shaders/pong/physics.glsl';
import * as THREE from 'three';

const uniforms = {
    uRenderTargetResolution: {
        value: new THREE.Vector2(),
    },
    uTime: {
        value: 0,
    },
    uCurrentState: {
        value: null,
    },
    uDeltaTime: {
        value: 0
    }
}

const physicsMaterial = new THREE.ShaderMaterial({
    fragmentShader,
    uniforms
})

const quad = new THREE.Mesh(
    new THREE.PlaneGeometry(2, 2),
    physicsMaterial
)

const INITIAL_POSITION = [0, 0];
const INITIAL_VELOCITY = [0.1, 0.3];

const INITIAL_STATE = [
    ...INITIAL_POSITION,
    ...INITIAL_VELOCITY
].flat();

/** width x height = 1 texel
 * THREE.RGBA = 4 channels/components
 * 1 float = 4 bytes 
 * **there are 4 bytes (floats) per component 
 * 
 * total bytes = width * height * (channels/components) * bytes per component = 1 * 1 * 4 * 4 = 16 bytes
 */
const INITIAL_STATE_TEXTURE = new THREE.DataTexture(new Float32Array(INITIAL_STATE), 1, 1, THREE.RGBAFormat, THREE.FloatType);
INITIAL_STATE_TEXTURE.needsUpdate = true;

physicsMaterial.uniforms.uCurrentState.value = INITIAL_STATE_TEXTURE;

export default quad;
export { INITIAL_STATE_TEXTURE };
import * as THREE from 'three';
import fragmentShader from './shaders/pong/fragment.glsl';
import physicsQuad, { INITIAL_STATE_TEXTURE } from './physics';

const scene = new THREE.Scene();

const VIEWPORT_SIZES = {
    width: window.innerWidth,
    height: window.innerHeight,
    pixelRatio: Math.min(window.devicePixelRatio, 2),
}

const aspectRatio = VIEWPORT_SIZES.width / VIEWPORT_SIZES.height;

const camera = new THREE.OrthographicCamera(-1 * aspectRatio, 1 * aspectRatio, 1, -1, 0, 1);
scene.add(camera);

const renderer = new THREE.WebGLRenderer({
    antialias: false,
    alpha: true,
    canvas: document.querySelector('canvas.webgl') as HTMLCanvasElement,
});

renderer.setSize(VIEWPORT_SIZES.width, VIEWPORT_SIZES.height)
renderer.setPixelRatio(VIEWPORT_SIZES.pixelRatio)

const uniforms = {
    uResolution: {
        value: new THREE.Vector2(
            VIEWPORT_SIZES.width * VIEWPORT_SIZES.pixelRatio,
            VIEWPORT_SIZES.height * VIEWPORT_SIZES.pixelRatio
        )
    },
    uMouse: {
        value: new THREE.Vector2()
    },
    uTime: {
        value: 0
    },
    uGameState: {
        value: new THREE.Texture(),
    }
}

window.addEventListener('resize', () => {
    // Update VIEWPORT_SIZES
    VIEWPORT_SIZES.width = window.innerWidth
    VIEWPORT_SIZES.height = window.innerHeight
    VIEWPORT_SIZES.pixelRatio = Math.min(window.devicePixelRatio, 2)

    const aspectRatio = VIEWPORT_SIZES.width / VIEWPORT_SIZES.height;
    camera.left = -1 * aspectRatio;
    camera.right = 1 * aspectRatio;
    camera.top = 1;
    camera.bottom = -1;
    camera.updateProjectionMatrix();

    uniforms.uResolution.value.x = VIEWPORT_SIZES.width * VIEWPORT_SIZES.pixelRatio;
    uniforms.uResolution.value.y = VIEWPORT_SIZES.height * VIEWPORT_SIZES.pixelRatio;

    // Update renderer
    renderer.setSize(VIEWPORT_SIZES.width, VIEWPORT_SIZES.height)
    renderer.setPixelRatio(VIEWPORT_SIZES.pixelRatio)
})

const raymarchMaterial = new THREE.ShaderMaterial({
    fragmentShader,
    uniforms
})

const quad = new THREE.Mesh(new THREE.PlaneGeometry(2 * aspectRatio, 2), raymarchMaterial)
scene.add(quad);

window.addEventListener('mousemove', (event) => {
    uniforms.uMouse.value.x = event.clientX;
    uniforms.uMouse.value.y = event.clientY;
})

const RENDER_TARGET_RESOLUTION = 4;
const RENDER_TARGET_OPTIONS = {
    format: THREE.RGBAFormat,
    type: THREE.FloatType,
    minFilter: THREE.NearestFilter,
    magFilter: THREE.NearestFilter
}

const renderTargetA = new THREE.WebGLRenderTarget(RENDER_TARGET_RESOLUTION, RENDER_TARGET_RESOLUTION, RENDER_TARGET_OPTIONS);
const renderTargetB = new THREE.WebGLRenderTarget(RENDER_TARGET_RESOLUTION, RENDER_TARGET_RESOLUTION, RENDER_TARGET_OPTIONS);

const physicsScene = new THREE.Scene();
physicsScene.add(physicsQuad);

renderer.setRenderTarget(renderTargetA);
renderer.render(physicsScene, camera);
renderer.setRenderTarget(renderTargetB);
renderer.render(physicsScene, camera);
renderer.setRenderTarget(null);

const clock = new THREE.Clock();

let currentTarget = renderTargetA;
let previousTarget = renderTargetB;

const tick = () => {
    const deltaTime = Math.min(clock.getDelta(), 0.05);
    const elapsedTime = clock.elapsedTime

    /** Temporary variable used, so we can swap variable references between previous and current targets. */
    const tempTarget = currentTarget;

    /** Destination to write the current state. */
    currentTarget = previousTarget;

    /** Source to read the previous state. */
    previousTarget = tempTarget;

    /** Update Physics */
    physicsQuad.material.uniforms.uRenderTargetResolution.value = new THREE.Vector2(RENDER_TARGET_RESOLUTION, RENDER_TARGET_RESOLUTION);
    physicsQuad.material.uniforms.uCurrentState.value = previousTarget.texture;
    physicsQuad.material.uniforms.uDeltaTime.value = deltaTime;
    physicsQuad.material.uniforms.uTime.value = elapsedTime;

    renderer.setRenderTarget(currentTarget);
    renderer.render(physicsScene, camera);
    renderer.setRenderTarget(null);

    /** Update Uniforms */
    uniforms.uTime.value = elapsedTime;
    uniforms.uGameState.value = currentTarget.texture;

    renderer.render(scene, camera);

    window.requestAnimationFrame(tick);
}

tick();
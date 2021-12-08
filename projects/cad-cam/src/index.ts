import createScene from './scene'
import run from './runner'
import { AssetsManager, Scene, Vector3 } from '@babylonjs/core'
import "@babylonjs/inspector";
import canvas from './canvas';
import setupSky from './sky'
import setupCamera from './free-camera/camera'
import setupInputs from './free-camera/inputs'
// import setupGround from './valley'
import setupGround from './flat-ground'
import setupLights from './hemispheric-light'
import arm from './arm'
import setupController from './car'

const load = async (scene: Scene) => {
    const manager = new AssetsManager(scene);
    // manager.addMeshTask('seagull', 'seagull', '/3d/', 'seagull.glb');
    manager.load()
}

const setup = (scene: Scene) => {
    scene.gravity = new Vector3(0, -0.15, 0);
    scene.collisionsEnabled = true;    
    setupSky(scene);
    setupGround(scene);
    setupLights(scene);
    const { inputs } = setupCamera(scene);
    setupInputs( inputs )
    arm(scene);
    // setupController(scene)
}

const loadInspector = scene => {
    let active = false;
    const toggleInspector = (e: KeyboardEvent) => {
        if (e.key !== '`') {
            return;
        }

        active ? scene.debugLayer.hide() : scene.debugLayer.show();
        active = !active;
    };

    window.addEventListener('keyup', toggleInspector)
}

(async () => {
    const scene = createScene(canvas(), window);
    await load(scene);
    setup(scene)
    run(scene, window);
    loadInspector(scene);
})()
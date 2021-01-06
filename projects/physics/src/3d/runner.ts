import { Scene } from "@babylonjs/core";

const run = (scene: Scene, resizeTarget: EventTarget): void => {
    const engine = scene.getEngine();

    engine.runRenderLoop(function () {
        scene.render();
    });

    resizeTarget.addEventListener('resize', function () {
        engine.resize();
    });
}

export default run;
import { Scene, UniversalCamera, Vector3 } from "@babylonjs/core";
import canvas from './canvas'

export default (scene: Scene): UniversalCamera => {
    const camera = new UniversalCamera('camera', new Vector3(0, 4, -10), scene);
    camera.setTarget(Vector3.Zero());
    camera.attachControl(canvas(), true);
    camera.ellipsoid = new Vector3(1,2,1)
    camera.applyGravity = true;
    camera.checkCollisions = true;
    return camera;
}
import { Scene, HemisphericLight, Vector3, Color3 } from "@babylonjs/core";

export default (scene: Scene) => {
    scene.createDefaultLight()
    const [ light ] = <[HemisphericLight]>scene.lights
    light.direction = new Vector3(1, 1, -1);
    light.specular = new Color3()
}
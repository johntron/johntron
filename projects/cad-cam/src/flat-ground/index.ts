import { StandardMaterial, MeshBuilder, Scene, CustomProceduralTexture } from "@babylonjs/core";

export default (scene: Scene) => {
    const dimension = Math.pow(2, 10)
    const ground = MeshBuilder.CreateGround('ground', {width: dimension, height: dimension, subdivisions: Math.pow(2, 8) });
    ground.checkCollisions = true;
    ground.position.y -= 3;
    const material = new StandardMaterial("ground", scene);
    const texture = new CustomProceduralTexture("ground", "/flat-ground", 4096, scene);
    material.diffuseTexture = texture;
    ground.material = material;
}
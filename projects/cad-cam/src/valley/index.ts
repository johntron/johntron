import { StandardMaterial, MeshBuilder, Scene, CustomProceduralTexture } from "@babylonjs/core";

export default (scene: Scene) => {
    const heightmapZXScale = 0.23302297307470754;
    const dimension = 1024
    const ground = MeshBuilder.CreateGroundFromHeightMap("ground", '/valley/height-map.png', {width: dimension, height: dimension, subdivisions: 256, minHeight:0, maxHeight: dimension * heightmapZXScale});
    ground.checkCollisions = true;
    ground.position.y -= 3;
    const material = new StandardMaterial("ground", scene);
    const texture = new CustomProceduralTexture("ground", "/valley", 4096, scene);
    material.diffuseTexture = texture;
    ground.material = material;
}
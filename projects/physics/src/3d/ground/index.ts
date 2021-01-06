import { StandardMaterial, Texture, MeshBuilder, Scene, CustomProceduralTexture, GroundBuilder } from "@babylonjs/core";
import { TextureHelper } from "@babylonjs/inspector/textureHelper";

export default (scene: Scene) => {
    const heightmapZXScale = 0.23302297307470754;
    const dimension = 1024
    const ground = MeshBuilder.CreateGroundFromHeightMap("ground", '/3d/ground/ground.png', {width: dimension, height: dimension, subdivisions: 256, minHeight:0, maxHeight: dimension * heightmapZXScale});
    ground.checkCollisions = true;
    ground.position.y -= 3;

    // const material = new StandardMaterial("ground", scene);
    // material.diffuseTexture = new Texture("https://assets.babylonjs.com/environments/valleygrass.png", scene);
    const material = new StandardMaterial("ground", scene);
    const texture = new CustomProceduralTexture("ground", "/3d/ground", 4096, scene);
    material.diffuseTexture = texture;
    ground.material = material;
}
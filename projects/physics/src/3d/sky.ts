import { Scene, CubeTexture, HDRCubeTexture } from "@babylonjs/core";

export default (scene: Scene) => {
    const texture = CubeTexture.CreateFromPrefilteredData("https://raw.githubusercontent.com/PatrickRyanMS/BabylonJStextures/master/ENV/flowerRoad_clamped.env", scene);
    texture.name = "environment";
    texture.gammaSpace = false;
    scene.environmentTexture = texture;
    scene.createDefaultSkybox(texture, true);
}
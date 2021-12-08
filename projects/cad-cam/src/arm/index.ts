import {MeshBuilder, Scene, Vector3} from "@babylonjs/core";

export default (scene: Scene) => {
    const base = MeshBuilder.CreateCylinder("base", {
        height: 10,
        diameter: 3
    }, scene)
    const armBasePivot = MeshBuilder.CreateCylinder("armBasePivot", {
        height: 3,
        diameter: 3
    }, scene)
    armBasePivot.position.y += 10 / 2;
    armBasePivot.rotate(new Vector3(0, 0, 1), Math.PI / 2)
    const arm = MeshBuilder.CreateBox("arm", {
        height: 7,
        width: 2,
        depth: 2
    }, scene)
    arm.position = new Vector3(0, (7/2) + (10/2), 0 )
    arm.setParent(armBasePivot)
    armBasePivot.setParent(base)
    // armBasePivot.rotate(new Vector3(0, 1, 0), Math.PI / 2)
}
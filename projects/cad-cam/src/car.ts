import { Scene, ActionManager, ExecuteCodeAction, MeshBuilder, Mesh, Axis, Space, Vector3, AbstractMesh, TransformNode, Quaternion, ContainerAssetTask, FollowCamera, ArcRotateCamera } from "@babylonjs/core";

interface TransformNodes {
    root: TransformNode,
    centerOfRotation: TransformNode,
    wheels: {
        front: {
            left: TransformNode,
            right: TransformNode,
        },
        rear: {
            left: TransformNode,
            right: TransformNode,
        }
    },
    pivots: {
        left: TransformNode,
        right: TransformNode,
    }
}

const parameters = {
    maxAcceleration: 0.01,
    maxBraking: 0.008,
    maxSteeringTheta: Math.PI / 4,
    maxSpeed: 100,
    wheelbase: {
        width: 2,
        length: 3,
    },
    wheels: {
        diameter: 2,
        height: 1
    }
}

const createCar = (scene: Scene): TransformNodes => {
    // const root = new Mesh('root', scene)
    const root = MeshBuilder.CreateBox('root', { size: 1 }, scene)
    const camera = new ArcRotateCamera('car cam',  0, 0, 10, new Vector3(parameters.wheelbase.width / 2, 0, 0), scene);
    camera.setPosition(new Vector3(parameters.wheelbase.width / 2, 3.5, -11.5));	
    camera.parent = root
    scene.setActiveCameraByID(camera.id)
    const centerOfRotation: Mesh = MeshBuilder.CreateDisc('center of rotation', { radius: 1 }, scene)
    const wheelMesh = MeshBuilder.CreateCylinder('front left', parameters.wheels, scene);
    const wheels = {
        front: {
            left: wheelMesh,
            right: wheelMesh.createInstance('front right'),
        },
        rear: {
            left: wheelMesh.createInstance('rear left'),
            right: wheelMesh.createInstance('rear right'),
        }
    };
    const pivotMesh = new Mesh('front left', scene);
    const pivots = {
        left: pivotMesh,
        right: pivotMesh.createInstance('front right')
    };

    centerOfRotation.rotate(Axis.X, Math.PI / 2, Space.WORLD)
    centerOfRotation.position = new Vector3(parameters.wheelbase.width * 2)

    // Rotate wheels
    const wheelsMeshes = [
        wheels.front.left,
        wheels.front.right,
        wheels.rear.left,
        wheels.rear.right
    ]
    wheelsMeshes.forEach(mesh => mesh.rotate(Axis.Z, Math.PI / 2, Space.WORLD));

    wheels.front.left.parent = pivots.left;
    wheels.front.right.parent = pivots.right;
    wheels.rear.left.parent = root;
    wheels.rear.right.parent = root;
    [
        pivots.left,
        pivots.right,
    ].forEach(mesh => mesh.parent = root);

    pivots.left.position = new Vector3(0, 0, parameters.wheelbase.length)
    pivots.right.position = new Vector3(parameters.wheelbase.width, 0, parameters.wheelbase.length)
    wheels.rear.right.position = new Vector3(parameters.wheelbase.width, 0, 0)

    return { root, centerOfRotation, wheels, pivots }
}

const keys = [];
const bindKeys = (scene: Scene): void => {
    scene.actionManager = new ActionManager(scene);

    scene.actionManager.registerAction(new ExecuteCodeAction(ActionManager.OnKeyDownTrigger, function (evt) {
        const { key } = evt.sourceEvent;
        keys[key.toLowerCase()] = true;
    }));

    scene.actionManager.registerAction(new ExecuteCodeAction(ActionManager.OnKeyUpTrigger, function (evt) {
        const { key } = evt.sourceEvent;
        keys[key.toLowerCase()] = false;
    }));
}

const state = {
    acceleration: 0,
    speed: 0,
    steeringAngle: 0,
    stopped: true,
}

const turnLeft = (pivots: { left: TransformNode, right: TransformNode }) => {
    if (state.steeringAngle < -parameters.maxSteeringTheta) {
        return;
    }
    const angleChange = -Math.PI / 100;
    state.steeringAngle += angleChange
    pivots.left.rotate(Axis.Y, angleChange, Space.LOCAL)
    pivots.right.rotate(Axis.Y, angleChange, Space.LOCAL)
}

const turnRight = (pivots: { left: TransformNode, right: TransformNode }) => {
    debugger;
    if (state.steeringAngle > parameters.maxSteeringTheta) {
        return;
    }
    // pivots.front.left.rotate(Axis.Y, Math.PI / 100, Space.LOCAL)
    const angleChange = Math.PI / 100;
    state.steeringAngle += angleChange
    pivots.left.rotate(Axis.Y, angleChange, Space.LOCAL)
    pivots.right.rotate(Axis.Y, angleChange, Space.LOCAL)
}

const accelerate = () => {
    state.acceleration = parameters.maxAcceleration
    state.stopped = false;
}

const brake = () => {
    if (state.speed <= 0) {
        // done braking - stopped
        state.acceleration = 0
        state.speed = 0
        state.stopped = true
        return;
    }
    state.acceleration = -parameters.maxBraking
    state.stopped = false
}

const coast = () => {
    state.acceleration = 0
}

const translate = (root: TransformNode, wheels: { front: { left: TransformNode, right: TransformNode }, rear: { left: TransformNode, right: TransformNode }}) => {
    state.speed += state.acceleration
    root.translate(Axis.Z, state.speed)
    console.log(state.steeringAngle)
}
const update = (scene: Scene, transformNodes: TransformNodes) => (): void => {
    const fps = scene.getEngine().getFps()
    const { root, pivots, wheels } = transformNodes
    if (keys['a']) {
        turnLeft(pivots);
    }
    if (keys['d']) {
        turnRight(pivots);
    }
    if (keys['w']) {
        accelerate()
    }
    if (keys['s']) {
        brake()
    }
    if (!keys['w'] && !keys['s']) {
        coast()
    }
    translate(root, wheels)
}
const registerUpdate = (scene: Scene, pivots): void => {
    scene.registerAfterRender(update(scene, pivots));
}

export default (scene: Scene): void => {
    const transformNodes = createCar(scene);
    bindKeys(scene);
    registerUpdate(scene, transformNodes);
}
import { Engine, EngineStore, FreeCameraInputsManager, FreeCameraKeyboardMoveInput } from "@babylonjs/core";
import canvas from './canvas'

export default (inputs: FreeCameraInputsManager): void => {
    // const { keyboard } = <{ keyboard: FreeCameraKeyboardMoveInput }>inputs.attached;
    // keyboard.keysUp.push(87)
    // keyboard.keysDown.push(83)
    // keyboard.keysLeft.push(65)
    // keyboard.keysRight.push(68)
    enterPointerLock()
    allowReenterLock()
    recoverFromLockError()
}

const enterPointerLock = () => Engine.LastCreatedEngine.enterPointerlock()
const allowReenterLock = () => document.addEventListener('pointerlockchange', handleLockChange, false)
const recoverFromLockError = () => document.addEventListener('pointerlockerror', handleLockChange);
const handleLockChange: EventListener = () => {
    const locking = EngineStore.LastCreatedEngine.isPointerLock

    if (locking) {
        canvas().removeEventListener('click', handleEngagementGesture)
        return;
    }

    canvas().addEventListener('click', handleEngagementGesture)
}
const handleEngagementGesture: EventListener = () => enterPointerLock()
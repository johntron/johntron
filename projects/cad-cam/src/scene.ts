import { Engine, Scene } from '@babylonjs/core'

const createEngine = (parent) => new Engine(parent, true, { preserveDrawingBuffer: true, stencil: true });

export default (parent: HTMLElement, resizeTarget: EventTarget): Scene => {
    const engine = createEngine(parent);
    resizeTarget.addEventListener('resize', () => engine.resize())
    return new Scene(engine)
}
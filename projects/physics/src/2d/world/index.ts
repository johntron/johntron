import {
    Engine,
    Render,
    Runner,
    Body,
    World as MatterWorld
} from '../matter/index.js';

class World {
    extents = {
        width: 800,
        height: 600,
    }
    engine = Engine.create();
    render = Render.create({
        element: document.body,
        engine: this.engine,
        options: {
            ...this.extents,
            showVelocity: true
        }
    })
    runner = Runner.create()

    run() {
        Render.run(this.render)
        Runner.run(this.runner, this.engine)

        Render.lookAt(this.render, {
            min: { x: 0, y: 0 },
            max: { x: 800, y: 600 }
        });
    }

    get world() {
        return this.engine.world;
    }

    add(bodies: Array<Body>) {
        MatterWorld.add(this.world, bodies)
    }
}

export default World
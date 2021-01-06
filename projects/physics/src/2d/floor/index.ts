import { Bodies, Body } from '../matter'
import World from '../world';

const height = 10

class Floor {
    static atExtents({ width, height: extentsHeight }) {
        return new this({ x: width / 2, y: extentsHeight - 0}, width)
    }

    body: Body;

    constructor({ x, y }: Position, width: number) {
        this.body = Bodies.rectangle(x, y - height / 2, width, height, { isStatic: true });
    }
}

export default Floor
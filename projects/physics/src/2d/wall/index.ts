import Floor from '../floor';
import { Bodies, Body } from '../matter'

const width = 30;

class Wall {
    static atFloor(floorPosition: Position, height) {
        const position = {
            x: floorPosition.x - width,
            y: floorPosition.y - height / 2,
        }
        return new this(position, height)
    }

    body: Body;

    constructor({ x, y }: Position, height) {
        this.body = Bodies.rectangle(x, y, width, height);
    }
}

export default Wall
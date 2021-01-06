import { Bodies } from '../matter'

const width = 60;
const height = 100;

export default class {
    static atWall(wallPosition: Position) {
        const position = {
            x: wallPosition.x + width / 2,
            y: wallPosition.y,
        }
        return new this(position);
    }

    body: Body;

    constructor({ x, y }: Position) {
        this.body = Bodies.rectangle(x, y, width, height)
    }
}
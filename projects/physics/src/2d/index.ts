import World from './world';
import Floor from './floor'
import Wall from './wall'
import Cabinet from './cabinet'
import { Body, Vector } from './matter'

const world = new World();
const floor = Floor.atExtents(world.extents)
const wall = Wall.atFloor(floor.body.position, 300)
const cabinet = Cabinet.atWall(wall.body.position)

Body.applyForce(cabinet.body, Vector.create(0, 0), Vector.create(-0.01, 0))
Body.applyForce(wall.body, Vector.create(0, 0), Vector.create(0.01, 0))

const bodies = [
    floor,
    wall,
    cabinet
].map(obj => obj.body)
world.add(bodies)

world.run();
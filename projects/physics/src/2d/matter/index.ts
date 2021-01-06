import m from 'matter-js/src/module/main.js'

const {
    Engine,
    Render,
    Runner,
    Body,
    Bodies,
    Composites,
    World,
    Vector
}: {
    Engine: Matter.Engine,
    Render: Matter.Render,
    Runner: Matter.Runner,
    Body: Matter.Body,
    Bodies: Matter.Bodies,
    Composites: Matter.Composites,
    World: Matter.World
    Vector: Matter.Vector
} = m

export {
    Engine,
    Render,
    Runner,
    Body,
    Bodies,
    Composites,
    World,
    Vector,
}
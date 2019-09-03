const scene = () => ([])
const object = mass => ({ mass })
const stateVector = (position, velocity, accel) => {}
const bodyVisualization = (radius) => {
  const shape = two.makeCircle(0, 0, model.size, model.size)
  shape.fill = '#00f'
}
const addToScene = scene => (object, stateVector, visualization) => {}


{
  const orbitalView = scene()
  const addToOrbital = addToScene(orbitalView)

  const planet = {
    object: object(1e3),
    stateVector: stateVector([0, 0 0], [0, 0, 0], [0, 0, 0])
    visualization:  
  }

  const me = {
    object: object(1),
    stateVector: stateVector([0, 1e4, 0], [0, 0, 0], [0, 0, 0])
}



const intervalExecutor = intervalMillis => scaleExecutionToClock => tick => () => {
  setInterval(() => tick(exeuctionTimeToEarthTime(intervalMillis)), intervalMillis)
}
const stop = executor => clearInterval(executor)

const tick = elapsedTime => 


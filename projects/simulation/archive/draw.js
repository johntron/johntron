// Planet
const planet = () => {
  const model = { 
    radius: 100,
    velocity: [0, 0],
    accel: [0, 0],
    update: previousPosition => previousPosition, // stationary
  }

  const ui = ([x, y]) => {
    const ui = two.makeCircle(x, y, model.radius)
    ui.fill = '#888'
    return ui
  }

  return {
    model,
    ui,
  }
}

// Spacecraft
const spacecraft = () => {
  const model = {
    size: 2,
    velocity: [0, 1],
    accel: [0, 0],
    update: (previousPosition, t) => ([
      previousPosition[0] + (model.velocity[0] * t),
      previousPosition[1] + (model.velocity[1] * t),
    ])
  }

  const ui = ([x, y]) => {
    const ui = two.makeRectangle(x, y, model.size, model.size)
    ui.fill = '#00f'
    return ui
  }

  return {
    model,
    ui,
  }
}

// Setup
const addVector = (a, b) => ([a[0] + b[0], a[1] + b[1]])
const scaleVector = (vector, scale) => ([vector[0] * scale, vector[1] * scale])
const origin = ({ width, height }) => ([ width / 2, height / 2])
const scene = () => {
  const home = () => {
    const position = [0, 0]
    planet().ui(position)
    return () => {}
  }
  const me = () => {
    const position = [105, 105]
    const { model, ui } = spacecraft()
    const instance = ui(position)
    return t => {
      instance.translation.set(...model.update(position, t))
    }
  }

  const updates = [home(), me()]
  return t => {
    updates.forEach(update => update(t))
  }
}

// Loop
const elem = document.getElementById('canvas');
const dimensions = () => {
  const { clientWidth: width, clientHeight: height } = document.body;
  return { width, height }
}
const two = new Two({ ...dimensions(), type: Two.Types.webgl }).appendTo(elem);
two.bind('update', scene()).play()
window.addEventListener('resize', () => {
  two.width = dimensions().width
  two.height = dimensions().height
})

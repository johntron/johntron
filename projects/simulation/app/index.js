const body = ([x0], velocity) => ({
  velocity,
  position: t => (velocity * t + x0),
})

const ship = body([0], 1)

const differenceInSeconds = require('https://unpkg.com/date-fns/fp/differenceInSeconds')
const t = () => {

}
const render = t => () => {
  const t = Date.now() - t0

}
setInterval(

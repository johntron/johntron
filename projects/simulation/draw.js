const elem = document.getElementById('canvas');
const dimensions = () => {
  const { clientWidth: width, clientHeight: height } = document.body;
  return { width, height }
}
const two = new Two({ ...dimensions(), type: Two.Types.webgl }).appendTo(elem);

const rect = two.makeRectangle(213, 100, 100, 100);
rect.fill = 'rgb(0, 200, 255)';
rect.opacity = 0.75;
rect.noStroke();

two.update();
two.bind('update', () => {
  rect.translation.set(rect.translation.x + 0.1, rect.translation.y + 0.1)
}).play()
window.addEventListener('resize', () => {
  two.width = dimensions().width
  two.height = dimensions().height
})

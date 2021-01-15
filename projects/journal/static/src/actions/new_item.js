import item from '../data/item.js'

export default parent => {
  const i = item(parent)
  parent.items = [...parent.items, i]
  console.log(i, parent)
  return i
}

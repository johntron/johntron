const toDayString = d =>
  `${d.getFullYear()}-${d.getMonth() + 1}-${d.getDate()}`
export default date => ({
  id () {
    return toDayString(this.date)
  },
  date,
  items: []
})

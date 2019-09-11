import debounce from 'debounce'
export default debounce(item => {
  console.log('updated', item.description)
}, 500)

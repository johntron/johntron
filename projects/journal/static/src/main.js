import Index from './Index.svelte'
import { journal } from './data/journal.js'

const index = new Index({
  target: document.body,
  props: {
    journal: journal()
  }
})

export default index

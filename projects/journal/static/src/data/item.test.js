import { item, transitions, undo_transitions } from './item.js'
import * as assert from 'assert'

const tests = []
const end = () => tests.length

tests[end()] = () => console.log('> item.js')
tests[end()] = () => {
    console.log('can be dead')
    let i = item()
    i = transitions.dead(i)
    assert.ok(i.dead)
}
tests[end()] = () => {
    console.log('dead can be undone')
    let i = item()
    i = transitions.dead(i)
    i = undo_transitions.dead(i)
    assert.ok(!i.dead)
}

tests.forEach(t => t())


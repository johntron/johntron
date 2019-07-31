import { day, add_item, remove_item } from './day.js'
import assert from 'assert'
const tests = []
const end = () => tests.length

tests[end()] = () => console.log('> day.js')
tests[end()] = () => {
    console.log('supports adding an item')
    const item = Symbol('expected')
    const d = day()
    add_item(d)(item)
    assert.ok(d.items.includes(item))
}
tests[end()] = () => {
    console.log('supports removing an item')
    const item = Symbol('for removal')
    const d = day()
    const add = add_item(d)
    add(Symbol('stubbed'))
    add(item)
    remove_item(d)(item)
    assert.ok(!d.items.includes(item))
}

tests.forEach(test => test())


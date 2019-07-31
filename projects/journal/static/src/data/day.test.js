import { day, add_item, remove_item } from './day.js'

describe('data: day', () => {
  test('supports adding an item', () => {
    const item = Symbol('expected')
    const d = day()
    add_item(d)(item)
    expect(d.items).toContain(item)
  })
  test('supports removing an item', () => {
    const item = Symbol('for removal')
    const d = day()
    const add = add_item(d)
    add(Symbol('stubbed'))
    add(item)
    remove_item(d)(item)
    expect(d.items).not.toContain(item)
  })
})


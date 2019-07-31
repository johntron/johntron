import { item, transitions } from './item.js'

describe('data: item', () => {
  test('can be dead', () => {
      let i = item()
      i = transitions.dead(i)
      expect(i.dead).toBeTruthy()
  })
  test('dead can be undone', () => {
      let i = item()
      i = transitions.revive(i)
      expect(i.dead).toBeFalsy()
  })
})


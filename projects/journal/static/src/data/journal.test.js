import { journal, key, add_daily_log } from './journal.js'

describe('data: journal', () => {
  test('supports key', () => {
      const j = journal()
      const actual = key(j)
      expect(actual)
  })

  test('supports adding a daily log entry', () => {
      const daily_log = Symbol('expected')
      const j = journal()
      add_daily_log(j)(daily_log)
      expect(j.daily_log).toContain(daily_log)
  })
})


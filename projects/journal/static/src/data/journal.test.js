import { journal, key, add_daily_log } from './journal.js'
import assert from 'assert'
const tests = []
const end = () => tests.length

tests[end()] = () => console.log('> journal.js')
tests[end()] = () => {
    console.log('supports key')
    const j = journal()
    const actual = key(j)
    assert.ok(actual)
}
tests[end()] = () => {
    console.log('supports adding a daily log entry')
    const daily_log = Symbol('expected')
    const j = journal()
    add_daily_log(j)(daily_log)
    assert.ok(j.daily_log.includes(daily_log))
}

tests.forEach(test => test())

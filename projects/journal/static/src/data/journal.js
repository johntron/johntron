import { month } from './month.js'
import { day, add_item as add_item_to_day } from './day.js'
import { item } from './item.js'
import { topic } from './topic.js'
import { inspect } from 'util'

export const journal = () => ({
    author: 'John Syrinek',
    title: 'Journal',
    months: [],
    daily_log: [],
    topics: [],
})
export const key = journal => `${journal.author}-${journal.title}`
export const add_daily_log = journal => day => journal.daily_log.push(day)



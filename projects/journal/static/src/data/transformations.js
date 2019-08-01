export const day_add_item = day => item => day.items.push(item)
export const day_remove_item = day => item => (day.items = day.items.filter(i => i !== item))
export const item_kill = item => ({ ...item, dead: true })
export const item_revive = item => ({ dead, ...item }) => item
export const journal_key = journal => `${journal.author}-${journal.title}`
export const journal_add_daily_log = journal => day => journal.daily_log.push(day)


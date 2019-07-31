export const day = date => ({
    date,
    items: [],
})

export const add_item = day => item => day.items.push(item)
export const remove_item = day => item => (day.items = day.items.filter(i => i !== item))


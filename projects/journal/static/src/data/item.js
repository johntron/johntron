export const item = (description) => ({
    description
})

export const transitions = {
    dead: item => ({ ...item, dead: true }),
}
export const undo_transitions = {
    dead: ({ dead, ...item }) => item,
}

export const item = (description) => ({
    description
})

export const transitions = {
    dead: item => ({ ...item, dead: true }),
    revive: ({ dead, ...item }) => item,
}


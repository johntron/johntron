export type Device = {
    templates: {
        import: string;
    },
    name: string
    mac_base: string
    ip: `${number}.${number}.${number}.${number}`
}
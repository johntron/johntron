import {Device} from "./types";

if (!process.env.WIFI_PASSWORD) {
    throw Error('No WIFI_PASSWORD environment variable specified');
}

export const dirs = {
    templates: './templates',
    compiled: './compiled'
}

export const globals = {
    ssid: "Cookie's manor \\F0\\9F\\98\\B8",
    wifi_password: process.env.WIFI_PASSWORD
};

export const devices: Device[] = [
    {
        templates: {
            import: 'wap-for-import.rsc'
        },
        name: "WAP (living room)",
        mac_base: "DC:2C:6E:00:00",
        ip: "192.168.1.4"
    },
    {
        templates: {
            import: 'wap-for-import.rsc'
        },
        name: "WAP (primary bedroom)",
        mac_base: "DC:2C:6E:00:01",
        ip: "192.168.1.3",
    },
    {
        templates: {
            import: 'wap-for-import.rsc'
        },
        name: "WAP (guest bedroom)",
        mac_base: "DC:2C:6E:00:02",
        ip: "192.168.1.2"
    }
]
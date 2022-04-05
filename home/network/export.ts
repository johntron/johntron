import { readFile } from 'fs/promises'
import { Client } from './client'
import {devices} from "./configs";

(async () => {
    const device = devices.find(config => config.name.includes('living'))
    if (!device) {
        throw Error()
    }
    const client = new Client({
        debug: console.log,
        username: 'admin',
        host: device.ip,
        privateKey: await readFile('/Users/johntron/.ssh/id_rsa'),
        password: 'f&5got$Lhsg6Powe^Na4'
    });
    client.connect();
    const result = await client.run('/interfaces');
    if (result instanceof Error) {
        throw result;
    }
    result.pipe(process.stdout)
    client.disconnect()
})()
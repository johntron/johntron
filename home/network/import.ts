import {readFileSync, writeFileSync} from 'fs'
import compileTemplate from 'lodash.template'
import {dirs, globals as globalConfig, devices} from './configs'
import {Device} from "./configs/types";

// const bwItem = (id) => {
//
// }
//
// const replacements = () => {
//     const {parsed: allReplacements} = config()
//     const bitwardenReplacements = Object.entries(allReplacements)
//         .filter(([key, value]) => key.match(/^BW_/))
//         .map(([key, id]) => [key, bwItem(id)])
//     return {
//         ...allReplacements,
//         ...Object.fromEntries(bitwardenReplacements)
//     }
//     // console.log(configs)
// }
// console.log(replacements())
const importConfig = (deviceConfig: Device) => {
    const config = {
        ...globalConfig,
        ...deviceConfig
    }

    const template = readFileSync(`${dirs.templates}/${config.templates.import}`, 'utf-8')
    const compile = compileTemplate(template);
    const compiledConfig = compile(config)
    const path = `${dirs.compiled}/${config.name}.rsc`
    writeFileSync(path, compiledConfig)
    console.log(`Wrote ${path}`)
}

devices.forEach(deviceConfig => importConfig(deviceConfig));

// [{
//     template: 'wap-for-import.rsc',
//     file: 'wap-living-room.rsc',
//     name: "WAP (living room)",
//     mac_base: "DC:2C:6E:00:00",
//     ip: "192.168.1.4"
// }, {
//     template: 'wap-for-import.rsc',
//     file: 'wap-primary-bedroom.rsc',
//     name: "WAP (primary bedroom)",
//     mac_base: "DC:2C:6E:00:01",
//     ip: "192.168.1.3",
// }, {
//     template: 'wap-for-import.rsc',
//     file: 'wap-guest-bedroom.rsc',
//     name: "WAP (guest bedroom)",
//     mac_base: "DC:2C:6E:00:02",
//     ip: "192.168.1.2"

// login over ssh and change password
// scp compiled/wap-guest-bedroom.rsc admin@192.168.88.1:flash/import.rsc
// /system/reset-configuration keep-users=yes run-after-reset=flash/wap-living-room.rsc caps-mode=no
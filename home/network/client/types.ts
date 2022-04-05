import {ConnectConfig} from "ssh2";

export type SSHSettings = ConnectConfig
export type Success = undefined;
export type Output = string;

export type Client = {
    connect: (settings: SSHSettings) => Success | Error
    disconnect: () => void
    run: (command: string) => Output | Error
    write: (remotePath: string, contents: string) => Success | Error
    read: (remotePath: string) => Output | Error
}
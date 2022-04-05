import {Output, SSHSettings, Success} from "./types";
import {Client as SSH2Client} from 'ssh2';
import {promisify} from 'util'
import {Readable, Writable} from "stream";

class Client {
    config: SSHSettings
    connection: SSH2Client

    constructor(settings: SSHSettings) {
        this.connection = new SSH2Client();
        this.config = settings;
    }

    connect(): Success | Error {
        try {
            this.connection.connect(this.config)
        } catch (e) {
            return e as Error;
        }
    }

    disconnect(): void {
        this.connection.end();
    }

    async run(command: string): Promise<Readable | Error> {
        try {
            return new Promise((resolve, reject) => this.connection.exec(command, (err, result) => {
                if (err) {
                    reject(err);
                } else {
                    resolve(result);
                }
            }))
        } catch (e) {
            return e as Error;
        }
    }

    async write(contents: string, remotePath: string): Promise<Success | Error> {
        const input = new Readable()
        input.push(contents)
        try {
            const sftp = await promisify(this.connection.sftp)()
            input.pipe(sftp.createWriteStream(remotePath))
        } catch (e) {
            return e as Error;
        }
    }

    async read(remotePath: string): Promise<Readable | Error> {
        try {
            const sftp = await promisify(this.connection.sftp)()
            return sftp.createReadStream(remotePath);
        } catch (e) {
            return e as Error;
        }
    }
}

export {
    Client
}
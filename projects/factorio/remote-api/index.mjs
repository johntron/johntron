import Rcon from 'modern-rcon';
import dotenv from 'dotenv';

dotenv.config();
const { RCON_PORT, PASSWORD } = process.env;

const runner = {
  async connect() {
    try {
      this.connection = new Rcon('localhost', Number(RCON_PORT), PASSWORD);
      await this.connection.connect();
    } catch (e) {
      console.error(`Error connecting to server: ${e}`, e);
    }

    console.log(`Connected to localhost:${RCON_PORT}`);
  },

  async invoke_raw(command) {
    const response = await this.connection.send(`/remote_api ${command}`);
    const [, status, result] = response.match(/(success|error) (.*)/)
    if (status === 'error') {
      throw Error(result)
    }
    return JSON.parse(result);
  },

  async disconnect() {
    await this.connection.disconnect();
    console.log(`Disconnected`)
  }
}

const find_belt_path = async (begin, end, inputs, outputs) => {

}

const boot = async () => {
  await runner.connect();
  try {
    // const result = await find_belt_path({x: 0, y: 0}, {x: 2, y: 2}, ['transport-belt']);
    const result = await runner.invoke_raw(`for i in pairs(game.surfaces[1].find_entities_filtered{}[1]) do game.print(i) end`);
    console.log(`Result: ${result}`)
  } catch (e) {
    console.error(e);
  }
  await runner.disconnect();
}

boot().catch(console.error);

// const commands = {
//   print => async message => {},
//   create_entity => async (name, position, options) => {},
//   destroy_entity =>  => {}
// }

// import grpc from 'grpc';
// import protoLoader from '@grpc/proto-loader';
//
// const factorioDefinition= protoLoader.loadSync('./factorio.proto', {
//   keepCase: true,
//   longs: String,
//   enums: String,
//   defaults: true,
//   oneofs: true
// });
// const factorio = grpc.loadPackageDefinition(factorioDefinition);
// console.log(factorio)

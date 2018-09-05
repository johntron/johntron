const grpc = require('grpc');
const protoLoader = require('@grpc/proto-loader');
// const process = require('./equipment.js');

const packageDefinition = protoLoader.loadSync(__dirname + '/equipment.proto', {
  keepCase: true,
  longs: String,
  enums: String,
  defaults: true,
  oneofs: true
})
const { johntron } = grpc.loadPackageDefinition(packageDefinition);

class Equipment {
  configure({ request }, callback) {
    const { type, address } = request;
    console.log(`Configuring to output ${type} to ${address}`)
    this.type = type;
    this.targetAddress = address;
    this.output = new johntron.Equipment(address, grpc.credentials.createInsecure());
    return callback(null, { state: 'configured' })
  }

  run(input, callback) {
    const { type } = input.call;
    if (!this.canOutput(type)) {
      console.error(`Cannot create ${this.type} from ${type}`)
      return callback(null, { status: 'fail' });
    }

    if (!this.output) {
      console.error(`No output for ${this.type}. Assuming inventory`)
      return callback(null, { status: 'success' });
    }

    console.log(`Received ${type}. Outputting ${this.type} to ${this.targetAddress}`)
    this.output.run({ type: this.type }, (err, { status }) => {
      if (err) {
        console.error(`Error running output`, err);
        return callback(err, { status: 'fail' })
      }
      console.log(`Done. Status: ${status}`)
      return callback(null, { status: status });
    });
  }

  canOutput(inputType) {
    return true;
  }
}

const run = async () => {
  const server = new grpc.Server();
  const equipment = new Equipment();
  server.addService(johntron.Equipment.service, equipment);
  server.bind(`0.0.0.0:80`, grpc.ServerCredentials.createInsecure());
  server.start();
  console.log(`Equipment running`)
}

if (require.main === module) {
  run();
}
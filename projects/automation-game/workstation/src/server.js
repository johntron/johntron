const { promisify } = require('util');
const express = require('express');
const app = new express();

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

const inventoryAddress = 'inventory:80';
// const inventory = new johntron.Equipment(inventoryAddress, grpc.credentials.createInsecure());

app.get('/configure-equipment', async (req, res) => {
  const { type, address, targetAddress } = req.query;

  console.log(`Configuring equipment with`, { type, address: inventoryAddress })
  const miner = new johntron.Equipment(address, grpc.credentials.createInsecure());
  const configure = promisify(miner.configure.bind(miner));
  const run = promisify(miner.run.bind(miner));

  try {
    const { state: equipmentState } = await configure({ type, address: targetAddress });
    console.log(`${type} producer is ${equipmentState}`);

    console.log(`Running equipment`);
    const { status: runStatus } = await run({ type: 'anything' });
    console.log(`Done`, runStatus);
    res.end()
  } catch (err) {
    console.error(`Error`, err)
  }
})

const server = app.listen(80, () => {
  console.log(`Workstation running on port ${server.address().port}`)
})
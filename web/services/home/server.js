const express = require('express');
const config = require('./config.js');

const app = new express();

app.get('/', (req, res) => {
  res.send('body');
})

app.listen(config.port, () => {
  console.log(`Listening on ${config.port}`)
})
const express = require('express');
const config = require('./config.js');
const routes = require('./routes.js');

const app = new express();
app.use(routes);
app.get('/routes', (req, res) => {
  const signatures = routes.stack.map(({ route }) => route);
  res.send(JSON.stringify(signatures))
})
app.listen(config.port, () => {
  console.log(`Listening on ${config.port}`)
})
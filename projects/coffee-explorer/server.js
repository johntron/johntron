module.paths.push("/Users/jsyrinek/Development/gaptech/core-ui/node_modules");
const http = require('http');
const express = require('express');
const app = express();
const server = http.createServer(app);
app.use((req, res, next) => {
  if (req.url.includes('.jsm')) {
    res.header('content-type', 'application/javascript');
  }
  next();
})
app.use(express.static('.'));

server.listen(3000, () => {
  console.log(`Serving`);
});
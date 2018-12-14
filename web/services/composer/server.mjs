import express from "express";
import _config from './config.mjs';
import discover from './discover.mjs';
import fetch from "node-fetch";

const config = _config();

const app = new express();
app.use('/', () => {
  `<script `
})

const forwarderFactory = internalPath => async (req, res) => {
  console.log(`Fetching from ${internalPath}`);
  const response = await fetch(internalPath, {
    method: req.method,
    headers: req.headers,
  });
  res.send(await response.text())
}

discover().then(services => {
  console.log(`Got services:`, services);

  services.forEach(service => {
    const { name, mountPoint, url, routes } = service;
    routes.forEach(route => {
      Object.keys(route.methods).forEach(method => {
        console.log(`Adding route to ${name}: ${method} ${route.path} => ${url}${mountPoint}${route.path}`)
        app[method](`${route.path}`, forwarderFactory(`${url}${mountPoint}${route.path}`))
      });
    })
  })

  app.listen(config.port, () => {
    console.log(`Listening on ${config.port}`)
  })
})
    .catch(err => {
      console.error(`Server failed to boot`, err)
    })

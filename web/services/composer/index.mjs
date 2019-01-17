import express from "express";
import { request } from 'http';
import config from "./config";

const bootApp = () => {
  const app = new Express();

  app.use('/info', (req, res) => {
    res.send('hello')
  });

  // app.use('/', async (req, res) => {
  //   const response = await fetch(config.services.home)
  //   res.send(await response.text());
  // })

  app.listen(config.port, () => {
    console.log(`App listening on ${config.publicPort}`)
  })

  return app;
};

const bootAppRegistry = (app) => {
  const registry = new Express();

  registry.use('/register', (req, res) => {
    const { pattern, host, port } = req.query;
    app.use(pattern, (req, res) => {
      console.log(`Piping ${req} to ${host}:${port}`);
      request({ ...req, host, port }).pipe(res);
    })
    res.send(`Routing traffic matching ${pattern} to ${host}:${port}`)
  })

  registry.listen(config.port, () => {
    console.log(`Registry listening on ${config.registryPort}`)
  })

  return registry;
}

const app = bootApp();
bootAppRegistry(app);

// const forwarderFactory = internalPath => async (req, res) => {
//   console.log(`Fetching from ${internalPath}`);
//   const response = await fetch(internalPath, {
//     method: req.method,
//     headers: req.headers,
//   });
//   res.send(await response.text())
// }
//
// discover().then(services => {
//   console.log(`Got services:`, services);
//
//   services.forEach(service => {
//     const { name, mountPoint, url, routes } = service;
//     routes.forEach(route => {
//       Object.keys(route.methods).forEach(method => {
//         console.log(`Adding route to ${name}: ${method} ${route.path} => ${url}${mountPoint}${route.path}`)
//         app[method](`${route.path}`, forwarderFactory(`${url}${mountPoint}${route.path}`))
//       });
//     })
//   })
//
//   app.listen(config.port, () => {
//     console.log(`Listening on ${config.port}`)
//   })
// })
//     .catch(err => {
//       console.error(`Server failed to boot`, err)
//     })

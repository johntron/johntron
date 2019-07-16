import Express from "express";
import { request } from 'http';
import { inspect } from 'util'
import { readFileSync } from 'fs';
import config from "./config";

import URL from "url";

const bootApp = (port) => {
  const app = new Express();

  app.all('/info', (req, res) => {
    res.end('composer')
  })

  app.all('/', (req, res) => {
    res.send(`
    <script type="module">
const register = () => {
  if (!navigator.serviceWorker) {
    console.log('not supported')
    return;
  }

  window.addEventListener('load', function() {
    navigator.serviceWorker.register('/service-worker.mjs').then(function(registration) {
      // Registration was successful
      console.log('ServiceWorker registration successful with scope: ', registration.scope);
    }, function(err) {
      // registration failed :(
      console.log('ServiceWorker registration failed: ', err);
    });
  });
};

register();
</script>
<script type="module" src="/home/somescript.mjs"></script>
    `)
  });

  app.all('/home/somescript.mjs', (req, res) => {
res.set('content-type', 'text/javascript');
res.set('cache-control', 'no-cache');
res.end(`import 'asdf.mjs'`)
  });

    app.all('/service-worker.mjs', (req, res) => {
    const serviceWorkerSource = readFileSync('./service-worker.mjs');
    res.set('content-type', 'text/javascript');
    res.end(serviceWorkerSource);
  })

  app.listen(port, () => {
    console.log(`App listening on ${port}`)
  })

  return app;
};

const toClientRequest = expressRequest => ({
  path: expressRequest.url,
  ...expressRequest
})

const bootAppRegistry = (app, port) => {
  const registry = new Express();

  registry.get('/register', (registrationReq, registrationRes) => {
    const { pattern, method, host, port } = registrationReq.query;

    // Define route
    app[method.toLowerCase()](pattern, (publicReq, publicRes) => {
      console.log(`Forwarding request for ${publicReq.method} ${publicReq.path} to ${host}:${port}`);

      // Convert to native ClientRequest
      const clientRequest = toClientRequest(publicReq);
      // console.log(inspect(clientRequest, {depth: 0, sorted: true}))

      // Forward to app server
      const internalReq = request({ ...clientRequest, host, port });
      internalReq.on('response', internalResponse => {
        console.log(`Piping response for ${publicReq.method} ${publicReq.path} from ${host}:${port}`)
        internalResponse.pipe(publicRes)
      })
      internalReq.on('error', console.error.bind(console, 'error'))
      internalReq.on('close', console.error.bind(console, 'close'))
      internalReq.on('data', console.error.bind(console, 'data'))
      internalReq.on('abort', console.error.bind(console, 'abort'))
      internalReq.on('continue', console.error.bind(console, 'continue'))
      internalReq.on('information', console.error.bind(console, 'information'))
      internalReq.on('timeout', console.error.bind(console, 'timeout'))
      internalReq.end();
    });

    console.log(`Routing traffic matching ${method} ${pattern} to ${host}:${port}`)
    registrationRes.send('gotcha')
  })

  registry.listen(port, () => {
    console.log(`Registry listening on ${port}`)
  })

  return registry;
}

const app = bootApp(config.publicPort);
bootAppRegistry(app, config.registryPort);

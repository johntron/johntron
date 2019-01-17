import express from "express";
import config from "./config.mjs";
import _glob from 'glob';
import { promisify } from 'util'
import { readFile as _readFile } from 'fs'
import { parseFromString } from './import-maps/reference-implementation/lib/parser.js';

const app = new express();

const mainScript = `import hi from '/hello.mjs';
hi()`;
const helloScript = `export default () => console.log('hello world')`;

const isStatic = req => req.path === '/main.mjs' || req.path === `${config.prefix}/hello.mjs`;
const toSource = req => req.path === '/main.mjs' ? mainScript : helloScript;
const pattern = `(?<prefix>import(?:["'\\s]*([\\w*{}\\n, ]+)from\\s*)?["'\\s]*)(?<path>[@\\w/_-]+)(?<suffix>["'\\s]*;?)`;
const regex = new RegExp(pattern)
const prefixPath = path => `${config.prefix}${path}`;
const asset_rewriter = async (req, res, next) => {
  if (!isStatic(req)) {
    console.log(`ignoring ${req.path}`)
    return next();
  }
  const source = await toSource(req);
  const transpiled = source.replace(regex, (...parts) => {
    const { prefix, path, suffix } = parts.pop();
    return `${prefix}${prefixPath(path)}${suffix}`;
  });
  res.header('Content-Type', 'text/javascript')
console.log(`transpiled`, transpiled)
  res.send(transpiled)
};
app.use(asset_rewriter)

app.get('/', (req, res) => {
  res.send(`<script type="module" src="./main.mjs"></script>`);
})
app.get('/main.mjs', (req, res) => {
  res.send(mainScript)
})

app.get('/hello.mjs', (req, res) => {
  res.send(helloScript)
})

const glob = promisify(_glob);
const readFile = promisify(_readFile);
const buildImportMap = async () => {
  const files = await glob('./**/*.?(m)js');
  const maps = files.map(readFile);


const boot = () => {
  app.listen(config.port, () => {
    console.log(`Listening on ${config.port}`)
  })
}

buildImportMap().then(boot}
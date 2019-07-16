import express from "express";
import config from "./config.mjs";
import _glob from 'glob';
import { promisify } from 'util'
import { readFile as _readFile } from 'fs'
import { dirname } from 'path';
import getImports from 'import-parser';

const app = new express();

const mainScript = `import importParser from 'import-parser';
import hi from '/hello.mjs';
hi()`;
const helloScript = `export default () => console.log('hello world')`;



const unprefixer = (req, res, next) => {
  if (!req.path.startsWith(config.prefix)) {
    return next();
  }

  const newPath = req.path.replace(new RegExp(`^${config.prefix}`), '');
  console.log(`>>> replacing ${req.path} with ${newPath}`)
  req.baseUrl = newPath;
  next();
}
app.use(unprefixer);

app.use(express.static(`${dirname(new URL(import.meta.url).pathname)}/app`))

const isStatic = req => req.path === '/main.mjs' || req.path === `/hello.mjs`;
const toSource = req => req.path === '/main.mjs' ? mainScript : helloScript;
const pattern = `(?<prefix>import(?:["'\\s]*([\\w*{}\\n, ]+)from\\s*)?["'\\s]*)(?<path>[@\\w/_-]+)(?<suffix>["'\\s]*;?)`;
const regex = new RegExp(pattern, 'g')
const prefixPath = path => `${config.prefix}${path}`;
const asset_rewriter = async (req, res, next) => {
  if (req.path.includes('index.html')) return next();
  // if (!isStatic(req)) {
  //   console.log(`ignoring ${req.path}`)
  //   return next();
  // }
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


// app.get('/', (req, res) => {
//   res.send(``);
// })
// app.get('/main.mjs', (req, res) => {
//   res.header('Content-Type', 'text/javascript')
//   res.send(mainScript)
// })
//
// app.get('/hello.mjs', (req, res) => {
//   res.header('Content-Type', 'text/javascript')
//   res.send(helloScript)
// })

const glob = promisify(_glob);
const readFile = promisify(_readFile);
const isNodeModule = path => !path.startsWith('./') && !path.startsWith('.')
const buildImportMap = async () => {
//   const pattern = `${dirname(new URL(import.meta.url).pathname)}/app/**/*.?(m)js`;
//   const files = await glob(pattern);
// console.log('>>> files', files)
//   const inputs = await Promise.all(files.map(filePath => readFile(filePath, 'utf8')
//       .then(source => [filePath, source])));
//   const maps = inputs.map(([filePath, source]) => {
// console.log('>>> source', source)
//     const nodeModuleImports = getImports(source)
//         .filter(({modulePath}) => isNodeModule(modulePath))
//         .map(({modulePath}) => modulePath);
//     return [filePath, nodeModuleImports]
//   });
// console.log(maps);
}

const boot = () => {
  app.listen(config.port, () => {
    console.log(`Listening on ${config.port}`)
  })
}

buildImportMap().then(boot)
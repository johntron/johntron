import { search } from './search';
import { fetch } from './fetch';
import { renameAll } from './files';
import { basename, resolve } from 'path'
import { createWriteStream, writeFileSync } from 'fs'

const outputDir = './downloads'

const downloadAll = paths => {
  return Promise.all(paths.map(path => fetch(path, {})
    .then(res => {
      const out = resolve(outputDir, basename(path))
      const destination = createWriteStream(out)
      res.body.pipe(destination)
    })))
}

(async () => {
  // const modelYear = '2017'
  // const carlineCode = 'forester'
  // const patterns = {
  //   drivetrain: 'awd',
  //   engine: '2.5',
  //   transmission: 'cvt',
  // }
  // const paths = await search({
  //   modelYear,
  //   carlineCode,
  //   patterns
  // })
  // writeFileSync(resolve(outputDir, 'results.json'), JSON.stringify(paths))
  // downloadAll(paths)
  await renameAll(resolve(outputDir), resolve(outputDir, 'renamed'), resolve(outputDir, 'results.json'))
})()

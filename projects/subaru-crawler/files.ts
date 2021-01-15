import { promises as fsPromises } from 'fs'
export { renameAll }

const { readdir, readFile, copyFile } = fsPromises

const isPDF = filename => filename.toLowerCase().endsWith('.pdf')
const listPDFs = async path => (await readdir(path)).filter(isPDF)

const filenameToDocumentCode = filename => filename.split('.')[0]
const filenameWithoutRevision = filename => {
    const match = filename.match(/\d+-\d+-\d+R/)
    console.log(match)
    if (!match) {
        return null
    }
    return match[0]
}
const readIndex = async path => JSON.parse(await readFile(path, 'utf-8'))
const createLookup = (index) => oldName => {
    const matchesDocumentCode = (oldName, i) => filenameToDocumentCode(oldName) == i.documentCode
    const matchesVersionedDocument = (oldName, i) => filenameWithoutRevision(oldName) == i.documentCode
    const doc = index.find(i => {
        return matchesDocumentCode(oldName, i) || matchesVersionedDocument(oldName, i)
    })
    if (!doc) {
        return null
    }
    return `${doc.title}.pdf`
}

const renameAll = async (inputPath, outputPath, indexPath) => {
    const index = await readIndex(indexPath)
    const lookup = createLookup(index)
    const files = await listPDFs(inputPath)
    debugger
    const oldToNewFilenames = Object.fromEntries(files.map(file => [file, lookup(file)]))
    files.forEach(file => {
        // copyFile(file, lookup[file])
        console.log(`copying file ${file} to ${oldToNewFilenames[file]}`)
    })
}
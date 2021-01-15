import { fetchAsJson } from './fetch'
export { search }

const carLineSearch = async ({ modelYear }) => fetchAsJson(`https://techinfo.subaru.com/stis/service/public/refData/vehicleType/carline?modelYear=${modelYear}`, {});
const carLineIdSearch = async ({ modelYear, carlineCode }) => {
  const carlines = await carLineSearch({ modelYear })
  const { vehicleCarlineId } = carlines.find(carline => carline.code.toLowerCase() == carlineCode)
  return vehicleCarlineId
}

const vehicleTypeSearch = async ({ modelYear, vehicleCarlineId }) => {
  return fetchAsJson(`https://techinfo.subaru.com/stis/service/public/refData/vehicleType?modelYear=${modelYear}&vehicleCarlineId=${vehicleCarlineId}`, {});
}
const propMatchesPattern = (prop, pattern) => obj => obj[prop].description.toLowerCase().includes(pattern.toLowerCase())
const vehicleTypeIdSearchMatchingPatterns = async ({ modelYear, vehicleCarlineId, patterns }) => {
  const matchesPatterns = vehicleType => (
    propMatchesPattern('drivetrain', patterns.drivetrain)(vehicleType)
    && propMatchesPattern('engine', patterns.engine)(vehicleType)
    && propMatchesPattern('transmission', patterns.transmission)(vehicleType)
  )
  const vehicleTypes = await vehicleTypeSearch({ modelYear, vehicleCarlineId })
  const { vehicleTypeId } = vehicleTypes.find(vehicleType => matchesPatterns(vehicleType))
  return vehicleTypeId
}

const params = ({ vehicleTypeId }) => ({
  vehicleTypeId,
  publicationTypes: [
    'SERVICE_MANUAL',
    'OWNER_MANUAL',
    'OTHER_MISCELLANEOUS',
    'ONBOARD_DIAGNOSTIC_INFORMATION',
    'TECHNICAL_SERVICE_BULLETIN',
    'TECHNICIAN_REFERENCE_BOOKLET',
    'TROUBLESHOOTING_GUIDE',
    'HTML_DIAGNOSTICS'
  ],
  publishedYear: null,
  publishedMonth: null
})

const docSearch = async (params) => await fetchAsJson("https://techinfo.subaru.com/stis/document/search", {
  "body": JSON.stringify(params),
  "method": "POST",
})
const docSearchResultToIds = docSearchResult => docSearchResult.map(d => d.documentId)

const documentIdToPath = async documentId => (await fetchAsJson(`https://techinfo.subaru.com/stis/document/path/${documentId}`, {})).path

const withStatus = async p => {
  process.stdout.write('⏳')
  return await p
  process.stdout.write('✅')
}

const search = async ({ modelYear, carlineCode, patterns }) => {
  const vehicleCarlineId = await carLineIdSearch({ modelYear, carlineCode })
  const vehicleTypeId = await vehicleTypeIdSearchMatchingPatterns({ modelYear, vehicleCarlineId, patterns })
  const results = (await docSearch(params({ vehicleTypeId })))
  const documentIds = docSearchResultToIds(results)
  const paths = await Promise.all(documentIds.map(documentId => withStatus(documentIdToPath(documentId))))
  return paths.map(p => `https://techinfo.subaru.com/stis/${p}`)
}
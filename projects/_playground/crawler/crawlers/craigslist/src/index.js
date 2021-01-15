const { PageProvider } = require('./page-provider')
const { extract } = require('./craigslist')

const run = async () => {
    const pageProvider = new PageProvider()
    try {
        const page = await pageProvider.page()
        await page.goto('https://dallas.craigslist.org/search/sss?query=chair&sort=rel')
        const result = await extract(page)
        console.log('result', result)
        pageProvider.close()
    } catch (e) {
        console.error(`Failed to crawl`)
        await pageProvider.close()
        throw e
    }
}

run()
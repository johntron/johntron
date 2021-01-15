const { browser } = require('./browser')

class PageProvider {
    browser;

    async ensureBrowser() {
        if (this.browser) {
            return
        }
        this.browser = await browser()
    }

    async close() {
        if (!this.browser) {
            return
        }
        await this.browser.close()
        this.browser = null
    }

    async page() {
        await this.ensureBrowser()
        const page = await this.browser.newPage()
        return page
    }
    // issue({ url, extract }) {
    //     try {
    //         const page = await this.browser.newPage()
    //         await page.goTo(url)
    //         const result = extract(page)
    //         this.log(url, result)
    //     } catch (e) {
    //         console.log(``)
    //     }
    // }
    // log({ requestedUrl, newUrls, artifacts, stats }) {
    //     console.log(`Finished crawling ${url}.\n new URLs: ${newUrls.join('\n')}\n results: ${resultMeta}`)
    // }
}

module.exports = {
    PageProvider
}
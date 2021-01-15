const puppeteer  = require('puppeteer');

const browser = async () => {
    let instance;
    try {
        instance = await puppeteer.launch()
    } catch (e) {
        console.error(`Couldn't launch browser`)
        throw e
    }
    return instance
}

module.exports = {
    browser
}
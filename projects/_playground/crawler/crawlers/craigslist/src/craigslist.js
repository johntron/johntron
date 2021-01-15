const extract = async page => {
    const result = await page.evaluate(() => {
        const logNodeWithErrors = node => fn => {
            try {
                return fn()
            } catch (e) {
                console.error(e, node.innerHTML)
            }
        }
        const mapNodeList = (list, fn) => Array.prototype.map.call(list, fn)
        const extractors = [
            ['url', n => n.querySelector('a.result-image').href],
            ['images', n => mapNodeList(n.querySelectorAll('.swipe [data-index] img'), n => n.src)],
            ['name', n => n.querySelector('.result-title').textContent],
            ['date', n => n.querySelector('.result-date').dateTime],
            ['price', n => n.querySelector('.result-price').textContent],
            ['neighborhood', n => {
                const h = n.querySelector('.result-hood')
                return h && h.textContent.trim().slice(1,-1)
            }],
        ]
        const extractAllFromNode = node => Object.fromEntries(extractors.map(([name, extract]) => [name, logNodeWithErrors(node)(() => extract(node))]))

        const items = document.querySelectorAll('[data-pid]')
        return mapNodeList(items, extractAllFromNode)
    })
    return result
}

module.exports = {
    extract
}
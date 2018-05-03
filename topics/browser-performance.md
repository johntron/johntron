# Browser performance

## Advice

-   Consider JAM stack (Javascript, API's, pre-build Markup)
-   Understand risks / tradeoffs of doing SSR, esp. regarding SEO (this info is very fluid lately w/advent of newer SPA technologies and Google's improvements in client-side crawlers)
-   Low-hanging fruit (in order): cache static assets at CDN, gzip, minify, HTTP/2, load assets at appropriate time, link rel="preload" critical assets, image compression (webp if possible), defer NFR assets as much as possible
-   Most of things in [Nodejs server-side rendering](./nodejs-server-side-rendering.md)
-   Use custom user timings to measure the things you really care about, not just TTI
-   If doing SSR, use hrefs instead of onclick, so content doesn't need to wait for JS bundle to become interactive

## Gotchas

-   Comparing against a benchmark that isn't apples-to-apples (e.g. a product page with different )
-   Using crude metrics like time-to-interactive instead of ones that reflect performance of specific content (e.g. how quickly CTA's appear and are interactive)

## Outstanding questions

-   Is it finally safe to stop doing SSR?

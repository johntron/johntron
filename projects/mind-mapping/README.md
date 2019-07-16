# Markdown-style mind mapping

Goals:

* Make mind mapping text-based for easier data entry
* Support for edges across "branches"


## Design

Domain model:
* Taxonomy - collection of Topics, Relations, Root, etc.
* Topic (node)
* Topic details
* Relation
* Relation details
* Root - optional? is this just a special Topic?
* Markup
* Visualization

Operations:
* New Taxonomy
* Add Topic
* Add Topic details
* Add Relation
* Markup to Taxonomy
* Taxonomy to Visualization


## Markup

Will look something like:

```
This is a topic --> This is a related topic
```

Questions:

* How to provide topic details?
* How to provide relation details?
* How to minimize typing - e.g. repeating topic / relation names?


## Tools

* [ohm](https://github.com/harc/ohm)
* [dagre](https://github.com/dagrejs/dagre)
* [dagre-d3](https://github.com/dagrejs/dagre-d3)
* [svelte](https://github.com/sveltejs/svelte)


## Next steps

* Setup filesystem
* Basic regex parser for Markdown to Taxonomy
* Basic d3 vis for Taxonomy to Visualization



*Psst — looking for a shareable component template? Go here --> [sveltejs/component-template](https://github.com/sveltejs/component-template)*

---

# svelte app

This is a project template for [Svelte](https://svelte.dev) apps. It lives at https://github.com/sveltejs/template.

To create a new project based on this template using [degit](https://github.com/Rich-Harris/degit):

```bash
npx degit sveltejs/template svelte-app
cd svelte-app
```

*Note that you will need to have [Node.js](https://nodejs.org) installed.*


## Get started

Install the dependencies...

```bash
cd svelte-app
npm install
```

...then start [Rollup](https://rollupjs.org):

```bash
npm run dev
```

Navigate to [localhost:5000](http://localhost:5000). You should see your app running. Edit a component file in `src`, save it, and reload the page to see your changes.


## Deploying to the web

### With [now](https://zeit.co/now)

Install `now` if you haven't already:

```bash
npm install -g now
```

Then, from within your project folder:

```bash
now
```

As an alternative, use the [Now desktop client](https://zeit.co/download) and simply drag the unzipped project folder to the taskbar icon.

### With [surge](https://surge.sh/)

Install `surge` if you haven't already:

```bash
npm install -g surge
```

Then, from within your project folder:

```bash
npm run build
surge public
```

# Domain concepts

* Document: Abstract; a single crawlable document; typically identified by unique URL, but not always
* * Page: HTML document; can contain links and other documents
* * Image: graphical document; cannot contain links or other documents
* Seeds: initial URLs for initial documents
* Policy: what's to be done with each document
* * Selection policy: which pages to visit
* * Revisit policy: which documents to revisit
* * Politeness policy: how to conserve resources (throughput)
* * Parallelization policy: how to coordinate distributed crawlers
* Links: URLs embedded in documents
* Frontier: known but un-crawled URLs
* Archive: stored copy of documents
* Index: collection of details extracted from documents

# Goals

* Humans can review and prune archive

# Architectural goals 

* Convert to distributed crawler
* Decouple indexing from feature extraction
* Extract from corpus or archive

# States

See [states.puml](./docs/states.puml)

# Building

`npm run build`

# Running

`npm run start`
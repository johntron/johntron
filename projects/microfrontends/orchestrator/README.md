# Microfrontend Orchestrator

Microfrontends aim to solve the organizational scalability problem of tightly-coupled build and deploy pipelines. When a web experience grows to include many development teams, they'll likely be in a position where the work of all teams is built and deployed using a single process – AKA pipeline. This shared pipeline takes a certain amount of time to run – 20-40 minutes from my experience. Since all teams must wait for the pipeline to complete existing work, they find themselves frequently blocked waiting to incorporate their own work. This is fine with 1 to 3 teams, but quickly becomes a problem for larger organizations – especially if people are following good practices to avoid divergence by incorporating their changes frequently.

The way this problem is solved is by having one pipeline per team. Teams take ownership of not just the application code they're writing, but also the deployment pipeline used to get their work to production. This naturally leads to the first major problem – how to combine the runtimes of these various microfrontend apps into one cohesive experience – and various secondary problems arising from the solution to this first problem. Please note: microfrontends are complicated – only use them when you experience the problems they were built to solve.

Microfrontends problems:
* Routing: Browsers request webpages from a single domain name, so for each incoming request, something must direct requests to the appropriate microfrontend apps.
* Intra-page dependencies: Any single webpage is likely a collection of multiple microfrontends. Something must manage the loading and rendering of the various apps for each page.
* Dependency optimization: Microfrontend apps often share the same third-party dependencies (libraries). If these dependencies were all loaded ad-hoc, there's lots of bloat from downloading the same dependency multiple times.
* Client-side intra-application coordination: A standard way for one application to trigger behavior in another application.
* Weakest-link response times: Requests can only be serviced as fast as the slowest microfrontend.
* Limiting CSS scope: Preventing style from one app interfering with other apps.

Solutions:
* Registration: A well-defined mechanism for each microfrontend to declare its existence
* Route dependencies: A way for frontends to declare the routes it services and the dependencies it requires for each route.
* Multi-frontend loader: Intelligent loader capable of loading dependencies for multiple frontends without duplication.
* Event bus?
* Frontend performance enforcement: Methods for guaranteeing frontend apps load in a timely manner, and graceful handling for the times when they don't.
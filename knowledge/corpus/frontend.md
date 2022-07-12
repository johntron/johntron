## Techniques

### Optimistic UI

When creating / mutating data, don't wait for network requests to complete before updating the UI - assume they'll succeed

[Example](https://remix.run/docs/en/v1/tutorials/jokes#optimistic-ui)

### Server-side loaders

Similar to Backend-for-Frontend (BFFE), but more granular; bake data fetching into the webapp's server-side code, and make this data automagically available to the frontend; relies on some convention for organizing server-side loaders with client-side consumers

[Example](https://kit.svelte.dev/docs/routing#endpoints-page-endpoints)

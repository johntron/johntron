# Build pipelines

## Health

If possible, don't have teams sharing pipelines. When this is not possible and multiple teams share a single pipeline, it's important that the pipeline is treated as a production system:

 * Failures should be investigated and fixed permanently – don't just re-run the job!
 * Performance is important - remove stuff that doesn't add value, do things in parallel
 * Output must be readable - turn off colors for plaintext, fail on warnings or hide them
 * Cleanup properly or isolate tests - ineffective test setup/teardown hurts everyone
 * Make sure someone monitors the infrastructure - flaky OpenStack connections, expired certificates, BrowserStack tunnels, etc.
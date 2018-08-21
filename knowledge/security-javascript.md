# Security: Javascript

## Advice

-   See [Nodejs Security Checklist](https://blog.risingstack.com/node-js-security-checklist/)
-   Various protections with [helmet](https://www.npmjs.com/package/helmet)
-   CSRF protection with [csurf](https://www.npmjs.com/package/csurf)
-   [ratelimiter](https://www.npmjs.com/package/ratelimiter)
-   Validate SSL configuration with [sslyze](https://github.com/nabla-c0d3/sslyze)
-   Check HSTS: `curl -s -D- https://yourdomain.com/ | grep -i Strict`
-   Prevent DoS from regex with [safe-regex](https://www.npmjs.com/package/safe-regex)
-   Scan dependencies for vulnerabilities with [Snyk](https://snyk.io) or [nsp](https://nodesecurity.io)
-   Escape HTML entities in JSON embedded in page (e.g. using [serialize-javascript](https://github.com/yahoo/serialize-javascript))
-   [Cheat Sheet](https://www.owasp.org/index.php/Web_Application_Security_Testing_Cheat_Sheet)
-   [SonarJS](https://www.sonarsource.com/products/codeanalyzers/sonarjs.html)

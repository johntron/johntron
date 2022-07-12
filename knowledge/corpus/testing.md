## Test definitions 

The terms below are not distinct or mutually exclusive – you might use two terms to describe a single test. Additionally, one type of test can be used to exercise varying amounts of code – one subcutaneous might exercise a large tree of components, while another subcutaneous test might exercise a single component. Similarly, one browser test might exercise a journey across multiple pages, and another might test specific browser technology like drag-to-scroll on a single page. 

It’s important to explain what we’re testing and the tools we're using. For example, someone might consider a test that exercises a single component to be both subcutaneous and a unit test, because it simulates user interactions without a browser and it’s testing a single thing / unit. In this case, we should instead explain that the thing we’re testing is one component, and the tools we're using are Enzyme with a virtual DOM. 

## Tips

From the testdouble.js guys:

> ... either the purpose of the test is to verify an invocation or to ensure that the integrated unit behaves as expected; it can't be both. either the purpose of the test is to verify an invocation or to ensure that the integrated unit behaves as expected; it can't be both. Either the test will be needlessly coupled to its implementation or it will be needlessly coupled to its depended-on component.

Watch out for test double pollution: leaving a double in place after a test completes (or fails prematurely!) can cause other tests to fail.

2.5 types of tests:

* Those that simply accept arguments and return values
* Those that call dependencies
* Those that do both – these are usually a mixture of abstraction layers, so try to avoid. Tip: "If a function outsources, say, three of its four responsibilities, it's usually better off outsourcing the fourth to a dependency as well so it can be cleanly described and tested as a collaborator function, as described above"

Don't use test doubles in integration tests

More from testdouble.js people:

> wrap 3rd-party dependencies in adapter functions to fake those adapters instead of the 3rd-party API—this will decrease the degree to which test doubles will leak throughout the integrated test suite and afford some opportunity for responding to hard-to-test situations by improving the API design of your adapters.

### Terms to avoid 

* Subcutaneous – “just below the surface”. In our case, the “surface” is the browser UI, so a subcutaneous test is one that operates at a high level, but no browser; Unfortunately, this definition can lead to confusion in the world of Components, because a single component can be tested without a browser but at a high level using a virtual DOM and simulated interactions. Instead of using this term, we should use “multi-component integration” or “single-component” – see below. 

### Terms to use instead 

* Exploratory – manual process of searching for potential bugs 
* Automated – can be initiated from command line or in a pipeline 
* Smoke – simple, quick test that verifies highly-critical functionality; could be automated or manual 
* Unit – conventionally, this means testing the smallest “unit” of code, which is a function or method; These are useful to validate complex algorithms like reducing some data; In the world of React and Enzyme, often people use this term to describe a test that mounts a single component with no real / non-mocked dependencies. We should avoid this later usage, because it leads to confusion. 
* (Single-)component – verifies the behavior of a single component in isolation 
* (Multi-)component integration – verifies that two components work together 
* Browser – uses a real – often headless – browser to verify behavior 
* User journey – a multi-step test that simulates an entire workflow a user might follow 
* End-to-end – verifies an entire system, from one end (browser) to the other (real services); note that a browser test doesn’t have to be an end-to-end test, because it’s possible to use mock services instead of the real thing. 
* Contract – verifies communication between APIs using a shared contract between the API provider and the consumer; verifies the API is used correctly by the consumer and that the API is provided correctly by the API provider 
* Protractor and Selenium – tools we use to write and run browser tests. 
* Page objects – a way of organizing test code for our browser tests; a page object represents one page (e.g. product details) and provides methods for interacting with it. 
* Virtual DOM – a virtual representation of the browser’s DOM; used to simulate a browser; used internally by React and Enzyme 
* Enzyme – test tool we use to write component-level tests with a virtual DOM; 
* Snapshot – captures HTML from DOM then compares with future runs to catch visual regressions; used w/Enzyme 

## Things to agree on as a group

* How will we test the integration of "units"?
* How to tell what is tested and what is not?
* How to do mocking - are partial mocks allowed?


## Considerations 

* Infrastructure cost: effort required to start writing / running tests 
* Effort – how much work is it to write and maintain a test 
* Reliability – frequency of failures and false positives; we don’t want flaky pipelines 
* Performance – amount of time it takes to execute test; we don’t want slow pipelines  
* Realism – how closely test reflect user experience 
* Browser technologies – browsers do some things that are hard to simulate / verify, like scrolling, pinch-zoom, double-tapping, etc. 

### Browser test 

* Infrastructure cost: highest 
* Effort: high without useful page objects, then medium because tests take longer to execute 
* Reliability: lowest, but can be matured over time via retries, better timeouts, etc. 
* Performance: lowest, but can be mitigated by running suites in parallel 
* Realism: closest to real user experience, so gives high confidence 
* Browser technologies: can test pretty much everything, including geolocation, multi-touch, etc. 

### Contract 

* Infrastructure cost: medium; requires tests run in two pipelines: consumer and provider 
* Effort: medium / low 
* Reliability: high – much higher than integration tests using real services 
* Performance: medium to high; consumer tests can run with other unit tests, provider tests require often use real network calls, but the service is local, so these return quickly 
* Realism: no resemblance to real user experience, but precisely mimics services 
* Browser technologies: sometimes used to test AJAX request 

### Two-component integration w/virtual DOM 

* Effort: medium if you have to mock a lot of dependencies; low if these mocks already exist 
* Reliability: high, but can break when dependencies / mocks change 
* Performance: high, but low if we don’t mock out AJAX and other asynchronous code 
* Criticality / required confidence: approximates browser, but hard to explain this to stakeholders 
* Browser technologies: no guarantee simulated events match real events, so not good way to test stuff like scrolling.


### Multi-unit integration

* TBD

### Single-component w/virtual DOM 

Same as two-component, but typically uses fewer dependencies, so effort is slightly lower, and reliability is slightly higher 

### Function / method unit test 

* Effort: lowest 
* Reliability: highest, because it tests the least amount of code 
* Performance: highest 
* Criticality: doesn’t approximate browser, so harder to instill confidence in stakeholders 
* Browser technologies: nothing – runs in node. 


## Related

-   [Testing Microservices, the sane way](https://medium.com/@copyconstruct/testing-microservices-the-sane-way-9bb31d158c16)
-   [Uncle Bob's "The Little Mocker"](https://8thlight.com/blog/uncle-bob/2014/05/14/TheLittleMocker.html)
- [testdouble.js "Purpose"](https://github.com/testdouble/testdouble.js/blob/master/docs/2-howto-purpose.md#purpose)


## For discussion

* Main problem to solve: how to test services that use another service?
* What's covered and what's not?
* Avoid testing behavior of a unit and integration with other units in a single test
* Avoid mixing two types of tests when possible
# Monitoring

## New Relic

* Insert API - send custom events
* Data apps - aggregation of dashboards
* Metrics - counterpart to Events
* keyset() - shows table fields
* [chart types](https://docs.newrelic.com/docs/insights/use-insights-ui/manage-dashboards/chart-types)

## Visualization

Guidelines:

* Actionable
* Digestible - can make sense of it?
* Elegant - less is more

What to use when:

* Billboard - Make one piece of data highly prominent (e.g. page views today)
* Gauge - Value relative to some total amount
* Table
* Line chart - time series of one field
* Area chart - add facets to line chart
* Histogram
* Heatmap - Histogram in multiple dimensions (use histogram() w/ facet); good for getting feel for response times across services
* Funnel - How objects distribute toward specific goal (e.g. purchase funnel); good to view multiple funnels side-by-side
* 

Tips:

* Use line graph with overlay of static line (benchmark) to compare actual to benchmark (e.g. repsonse time compared to target)
* Benchmarking with gauges – use WHERE clause for gauge() limit
* Visualizing response times when services depend on others - stacked area chart or heatmap facetted by service
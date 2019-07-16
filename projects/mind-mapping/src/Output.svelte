<script>
  export let graph;

  const prettyPrint = graph => `nodes: ${graph.nodes().map(node => node)}
edges:
  ${graph
    .edges()
    .map(edge => `${edge.v} -> ${edge.w}`)
    .join("\n  ")}`;

  let output = "";
  $: output = prettyPrint(graph);
</script>

<style>
  pre {
    margin: 1em;
  }
</style>

<pre>{output}</pre>

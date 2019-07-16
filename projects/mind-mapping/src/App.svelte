<script type="module">
  import Input from "./Input.svelte";
  import Output from "./Output.svelte";
  import { input } from "./state.js";
  import ohm from "../node_modules/ohm-js/dist/ohm.js";
  import dagre from "../node_modules/dagre";

  const create_grammar = () =>
    ohm.grammar(`Taxonomy {
    taxonomy = relation+
    relation = topic "->" topic eol?
    topic = " "* any " "*
    eol = "\\r"? "\\n"
}`);

  const grammar = create_grammar();
  const evaluate = input => {
    const semantics_with_evalute = grammar =>
      grammar.createSemantics().addOperation("evaluate", {
        taxonomy: function(relations) {
          relations.evaluate().forEach(relation => {
            const [topic_a, topic_b] = relation;
            graph.setNode(topic_a, { label: topic_a, width: 144, height: 100 });
            graph.setNode(topic_b, { label: topic_b, width: 144, height: 100 });
            graph.setEdge(topic_a, topic_b);
          });
          return graph;
        },
        relation: function(topic_a, _, topic_b, __) {
          return [topic_a.evaluate(), topic_b.evaluate()];
        },
        topic: function(_, __, ___) {
          return this.sourceString.trim();
        }
      });
    const match = grammar.match(input);
    console.log("succeeded?", match.succeeded());
    const semantics = match => semantics_with_evalute(grammar)(match);
    const graph = new dagre.graphlib.Graph();
    const results = semantics(match).evaluate();
    console.log(dagre.graphlib.json.write(results));
    return results;
  };

  export const notify = new_value => ($input = new_value);
  let graph;
  $: graph = evaluate($input);
</script>

<style>
  .container {
    display: grid;
    grid-template-columns: auto 1fr 1fr auto;
  }
  .input {
    grid-column: 2;
  }
  .output {
    grid-column: 3;
  }
</style>

<span class="container">
  <span class="input">
    <Input {notify} />
  </span>
  <span class="output">
    <Output {graph} />
  </span>
</span>

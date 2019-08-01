<script>
  import { item } from "./data/item.js";
  export let items;

  if (!items.length) {
    items[items.length] = item("Do something");
  }
</script>

<ul>
  {#each items as item}
    <li>{item.description}</li>
  {/each}
</ul>

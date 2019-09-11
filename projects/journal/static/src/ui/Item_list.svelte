<script>
  import { item } from "../data/item.js";
  import Item from "./Item.svelte";
  export let items;

  if (!items.length) {
    items[items.length] = item("Do something");
  }
</script>

<style>
  ul {
    padding-left: 0;
  }
</style>

<ul>
  {#each items as item}
    <Item {item} />
  {/each}
</ul>

<script>
  import Item from "./Item.svelte";
  import New_item from "./New_item.svelte";
  import item from "../data/item.js";
  export let day;

  let editing_index;

  const newItem = () => {
    const i = item(day);
    editing_index = day.items.length;
    day.items[editing_index] = i;
    console.log(editing_index, i, day);
  };
</script>

<style>
  ul {
    padding-left: 0;
  }
</style>

<ul>
  {#each day.items.map((item, i) => [i, item]) as [i, item]}
    <Item {day} {item} editing={i === editing_index} />
  {/each}
  <li on:click={newItem}>
    <i>new item</i>
    <i class="material-icons">add</i>
  </li>
</ul>

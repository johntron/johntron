<script>
  import item from "../data/item.js";
  export let day;

  const newItem = parent => {
    const i = item(parent);
    parent.items[parent.items.length] = i;
    console.log(i, parent);
  };
</script>

<style>
  li {
    list-style-type: none;
    margin-left: 0;
    padding-left: 0;
  }
  i:hover {
    cursor: pointer;
  }
</style>

<li on:click={() => newItem(day)}>
  <i>new item</i>
  <i class="material-icon">new</i>
</li>

<script>
  import { afterUpdate } from "svelte";
  import updateItemDescription from "../actions/update_item_description.js";
  export let item;
  let editing = false;
  let input;

  const toggle = () => (editing = !editing);
  $: updateItemDescription(item);

  afterUpdate(() => {
    if (editing) {
      input.focus();
    }
  });
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

<li>
  {#if !editing}
    {item.description}
    <i on:click={toggle} class="material-icons">edit</i>
  {/if}
  {#if editing}
    <input
      bind:this={input}
      on:blur={toggle}
      on:click|stopPropagation
      bind:value={item.description} />
  {/if}
</li>

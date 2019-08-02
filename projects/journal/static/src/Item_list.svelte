<script>
  import { item } from "./data/item.js";
  export let items;

  if (!items.length) {
    items[items.length] = item("Do something");
  }

  const remove_contents = parent =>
    [...parent.childNodes].forEach(el => el.remove());
  const edit = (item, element) => {
    const { parentNode } = element;
    remove_contents(parentNode);
    const input = document.createElement("input");
    parentNode.appendChild(input);
    input.value = item.description;
    input.focus();
    const listener = input.addEventListener("blur", () => {
      console.log("blur");
      input.removeEventListener("onblur", listener);
      save(item, input);
    });
  };
  const save = (item, element) => {
    item.description = element.value;
    const { parentNode } = element;
    remove_contents(parentNode);
    parentNode.textContent = item.description;
  };
</script>

<ul>
  {#each items as item}
    <li on:click={e => edit(item, e.target)}>{item.description}</li>
  {/each}
</ul>

<script>
  import { day as create_day } from "./data/day.js";
  import Item_list from "./Item_list.svelte";

  export let day;

  if (!day) {
    day = create_day(new Date());
  }
</script>

<h1>Daily log</h1>
<span>{day.date}</span>
<Item_list items={day.items} />

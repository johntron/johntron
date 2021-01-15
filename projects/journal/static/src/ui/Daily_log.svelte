<script>
  import new_day from "../actions/new_day.js";
  import Item_list from "./Item_list.svelte";

  export let day;

  if (!day) {
    day = new_day(new Date());
  }
</script>

<h1>Daily log</h1>
<span>{day.date}</span>
<Item_list {day} />

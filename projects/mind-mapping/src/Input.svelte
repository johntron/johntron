<script>
  import { input } from "./state.js";
  export let notify;
  const change = e => notify(e.target.value);
</script>

Input:
<br />
<textarea on:change={change}>{$input}</textarea>

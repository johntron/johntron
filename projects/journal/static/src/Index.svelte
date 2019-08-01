<script>
  export let journal;
  import Daily_log from "./Daily_log.svelte";
  console.log(journal.daily_log);
</script>

<style>

</style>

<section>
  <h1>Index</h1>
  <ul>
    <li>
      <a href="#">Today</a>
    </li>
  </ul>
</section>

<section>
  <Daily_log day={journal.daily_log[journal.daily_log.length - 1]} />
</section>

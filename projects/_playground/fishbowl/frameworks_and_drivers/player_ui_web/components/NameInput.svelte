<script context="module">
    export let name = '';
</script>
<script>
    import { onMount } from 'svelte'
    const ls = window.localStorage
    onMount(() => {
        name = ls.getItem('name')
    })

    const changeName = () => {
        ls.setItem('name', name)
    }
</script>
<p><strong>Enter your name</strong></p>
<input type="text" placeholder="John Doe" bind:value={name} on:change={changeName} /><br/>

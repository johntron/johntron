<script context="module">
	/** @type {import('@sveltejs/kit').ErrorLoad} */
	import { telemetry } from '../lib/telemetry';

	export function load({ error, status }) {
		telemetry.error(error);
		return {};
	}
</script>

Oops - we've got pear on our face 🍐⤵️😵 (something went wrong)

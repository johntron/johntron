<template>
  <div class="agent-connector">
    <p>
      Agent address: <input type="text" :value="address" /> <button @click="connect">Connect</button>
    </p>
  </div>
</template>

<script lang="ts">
import { Component, Prop, Vue } from 'vue-property-decorator';

@Component
export default class AgentConnector extends Vue {
  // @Prop() private msg!: string;
}
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped lang="scss">
</style>

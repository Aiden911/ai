<template>
  <div class="home">
    <ChatComponent />
  </div>
</template>

<script>
import ChatComponent from "../components/ChatComponent.vue";

export default {
  name: "HomeView",
  components: {
    ChatComponent,
  },
};
</script>
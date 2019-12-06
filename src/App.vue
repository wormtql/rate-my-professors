<template>
  <div id="app">
    <router-view style="height: 100%; width: 100%"></router-view>
  </div>
</template>

<script>

export default {
  name: 'app',

}
</script>

<style>
  * {
    padding: 0;
    margin: 0;
  }
  #app {
    height: 100%;
    width: 100%;
  }

  html {
    height: 100%;
    width: 100%;
  }

  body {
    height: 100%;
    width: 100%;
  }
</style>

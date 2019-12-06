<template>
    <button @click="$emit('click')"
            >
        <slot></slot>
    </button>
</template>

<script>
    export default {
        name: "Button3"
    }
</script>

<style scoped>

</style>
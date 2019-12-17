<template lang="pug">
    div(:style="rootStyle")
</template>

<script>
export default {
    name: "Spacer",
    props: {
        height: {
            type: Number,
            default: 32
        },
        width: {
            type: Number,
            default: -1
        }
    },
    computed: {
        rootStyle: function () {
            return {
                display: "block",
                width: this.width <= 0 ? "100%" : `${this.width}px`,
                height: this.height <= 0 ? "100%" : `${this.height}px`,
            }
        }
    }
}
</script>
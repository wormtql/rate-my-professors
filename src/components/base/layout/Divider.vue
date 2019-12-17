<template lang="pug">
    div(:style="rootStyle")
</template>

<script>
export default {
    name: "Divider",
    props: {
        width: {
            type: Number,
            default: -1
        },
        height: {
            type: Number,
            default: 1
        },
        color: {
            type: String,
            default: "#00000011",
        }
    },
    computed: {
        rootStyle: function () {
            return {
                width: this.width <= 0 ? "100%" : `${this.width}px`,
                height: this.height <= 0 ? "100%" : `${this.height}px`,
                display: "block",
                background: this.color
            }
        }
    }
}
</script>